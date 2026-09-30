//
//  PDFPostView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI
import PDFKit
import UIKit

// MARK: - PDFKitView

struct PDFKitView: UIViewRepresentable {

    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.backgroundColor = .systemBackground
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let document = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    pdfView.document = document
                }
            }
        }
    }
}

// MARK: - PDFPostView

struct PDFPostView: View {

    let url: URL

    @State private var isPDF: Bool = true
    @State private var loadFailed: Bool = false

    private var isPDFExtension: Bool {
        url.pathExtension.lowercased() == "pdf"
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "doc.richtext")
                    .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                Text("Document")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(url.pathExtension.uppercased())
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Color(.systemFill)))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            Divider()

            if loadFailed {
                VStack(spacing: 10) {
                    Image(systemName: "doc.badge.exclamationmark")
                        .font(.system(size: 36))
                        .foregroundStyle(.secondary)
                    Text("Unable to load document.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(24)
                .frame(maxWidth: .infinity)

            } else if isPDFExtension {
                PDFKitView(url: url)
                    .frame(height: 300)

            } else {
                VStack(spacing: 12) {
                    Image(systemName: "doc.viewfinder")
                        .font(.system(size: 40))
                        .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                    Text("This document format (\(url.pathExtension.uppercased())) cannot be rendered inline.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Link(destination: url) {
                        Label("Open in Browser", systemImage: "safari")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hex: "#0077b6") ?? .blue)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

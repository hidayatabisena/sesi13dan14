//
//  UsersDetailView.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 28/02/24.
//

import SwiftUI

struct UsersDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Text("User Info".uppercased())
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            AsyncImage(url: URL(string: user.avatar)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure(_):
                    Color.red
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
                
                Text(user.name)
                    .font(.headline)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    UsersDetailView(user: User.dummy)
}

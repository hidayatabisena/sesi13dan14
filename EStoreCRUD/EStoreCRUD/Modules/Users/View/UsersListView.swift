//
//  UsersListView.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var userVM = UsersViewModel()
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(userVM.users) { user in
                    Button {
                        showDetailSheet(for: user)
                    } label: {
                        UserRowView(user: user)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(Constant.usersList)
            .sheet(isPresented: $showSheet) {
                if let selectedUser = userVM.selectedUser {
                    UsersDetailView(user: selectedUser)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
            .refreshable {
                await userVM.loadUsers()
            }
            .toolbar {
                EditButton()
            }
            .task {
                await userVM.loadUsers()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        userVM.users.remove(atOffsets: offsets)
    }
    
    func showDetailSheet(for user: User) {
        userVM.selectedUser = user
        self.showSheet = true
    }
}

#Preview {
    UsersListView()
}

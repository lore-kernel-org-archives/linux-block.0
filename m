Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6E346E70;
	Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552528; cv=none; b=e5yNJV4PfqI9E55ZmVXk83+Nt1jr21us85FzcZzoea2v/n0o+xuurcfpcsWByBaXTZdZ6M4Y8hBmGMa7Tg2mQEyQPNqya0XHmRHVSue36TPNvabH4I+lU0rdtBJ+abvIywEMays5+MWgLNngEzhStLXEZsc92vzpS1A44x4Kzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552528; c=relaxed/simple;
	bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYvKHNfDauBmos48EJsZfULQshkT2tGHMVWGsxxzRUyK8d4i6GBgo2jgFJhE/EJJr3UoWbF8rJ/szXlplcIb2sLgtFz1qMoPibrzQdjzLH1bMtjsaHN2BYzdxTiw9kzerFfQ5M+GOWU441AEnIVCS2RbYLWFXvcZZ2P+Hhrejdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B/HX3JHf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B/HX3JHf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC05AC2BCFC;
	Sat, 27 Jun 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782552527; bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/HX3JHfnH0w1g0HI18O99d+b8cE96fv8HkqUvumLfPPTW4YL3tmQ0kvoHN6zJeGd
	 ZXJDIetu2a43uqkHxLGKWhk1lxcqIQaTmMxir5dcDZJ8RLI6LULrsLHXu3oDojEpYM
	 mWbTEj17HBNGHTjQuAmt5/xP1tqMPoY06T/c75Fw=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DADC43211;
	Sat, 27 Jun 2026 09:28:47 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sat, 27 Jun 2026 17:28:42 +0800
Subject: [PATCH v7 04/10] rust: macros: auto-insert OwnerModule in
 #[vtable]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-fix-fops-owner-v7-4-33cd3990edf0@linux.dev>
References: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
In-Reply-To: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782552525; l=4578;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
 b=nlESNdY7OReX+CtyCFY95Ssb+YQBOZtRg8xz5vlNyM3wT+Zh1XE7aIePmfU+LctpiF/cD3N1v
 CTS4oT6LhpwApw6IVrdtKGZ5Zjv2CjfXIdvd/2SSLLtrkOiOKk93WK3
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Auto-add `type OwnerModule: ::kernel::ModuleMetadata;` as a required
associated type on the trait side if not already defined, and
auto-insert `type OwnerModule = crate::LocalModule;` on the impl side
if not explicitly provided, eliminating the need to manually declare
and implement `OwnerModule` in every vtable trait and impl.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/all/DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/macros/lib.rs    |  6 ++++++
 rust/macros/vtable.rs | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7c..bc7ded353c5ca 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -176,6 +176,12 @@ pub fn module(input: TokenStream) -> TokenStream {
 ///
 /// This macro should not be used when all functions are required.
 ///
+/// Additionally, this macro automatically handles the `OwnerModule`
+/// associated type: on the trait side, `type OwnerModule: ModuleMetadata;`
+/// is added as a required associated type if not already defined; on the
+/// impl side, `type OwnerModule = LocalModule;` is automatically inserted
+/// if not explicitly defined.
+///
 /// # Examples
 ///
 /// ```
diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index c6510b0c4ea1d..be9a5ed8abe5e 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -30,6 +30,22 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
          const USE_VTABLE_ATTR: ();
     });
 
+    // Add `type OwnerModule: ModuleMetadata` as a required associated type if
+    // the trait does not already define it.
+    if !item
+        .items
+        .iter()
+        .any(|i| matches!(i, TraitItem::Type(t) if t.ident == "OwnerModule"))
+    {
+        gen_items.push(parse_quote! {
+            /// The module implementing this vtable trait.
+            ///
+            /// Automatically set to `crate::LocalModule` by the `#[vtable]`
+            /// impl macro.
+            type OwnerModule: ::kernel::ModuleMetadata;
+        });
+    }
+
     for item in &item.items {
         if let TraitItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;
@@ -57,12 +73,18 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
 
 fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
     let mut gen_items = Vec::new();
-    let mut defined_consts = HashSet::new();
+    let mut defined_items = HashSet::new();
 
-    // Iterate over all user-defined constants to gather any possible explicit overrides.
+    // Iterate over all user-defined items to gather any possible explicit overrides.
     for item in &item.items {
-        if let ImplItem::Const(const_item) = item {
-            defined_consts.insert(const_item.ident.clone());
+        match item {
+            ImplItem::Const(const_item) => {
+                defined_items.insert(const_item.ident.clone());
+            }
+            ImplItem::Type(type_item) => {
+                defined_items.insert(type_item.ident.clone());
+            }
+            _ => {}
         }
     }
 
@@ -70,6 +92,15 @@ fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
         const USE_VTABLE_ATTR: () = ();
     });
 
+    // Auto-insert `type OwnerModule = crate::LocalModule` if not explicitly defined.
+    // `crate::LocalModule` resolves to the real module type (via `module!`) or a
+    // dummy fallback in non-module contexts (e.g., doctests).
+    if !defined_items.contains(&parse_quote!(OwnerModule)) {
+        gen_items.push(parse_quote! {
+            type OwnerModule = crate::LocalModule;
+        });
+    }
+
     for item in &item.items {
         if let ImplItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;
@@ -78,7 +109,7 @@ fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
                 name.span(),
             );
             // Skip if it's declared already -- this allows user override.
-            if defined_consts.contains(&gen_const_name) {
+            if defined_items.contains(&gen_const_name) {
                 continue;
             }
             let cfg_attrs = crate::helpers::gather_cfg_attrs(&fn_item.attrs);

-- 
2.43.0



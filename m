Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35339397B02;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349978; cv=none; b=Mt8K93m0YqV3KOsNuAOVWjgxrOqI5AuWxLkFSCsZ4iURqbmHYucCWtA/K0VUVlECgor5vMnY/o5TV7QgkRXy6xyB5Zsr3NRb6v02dxM4EeOyxhGe0152iGJXiuHkEjmy+OcnKxwQOyGXHofN8bYal4DNt9DTXRk9qn/3VAXjJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349978; c=relaxed/simple;
	bh=o0NVwirES5UBqa+dDLOUFzSJEpbDhFbK8hdfhxeciEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aa7rDYQvkiGoN2jO/eAlQn77OvGzxPsTr/cINyZscmHc2AJ0sXEsd4BowzE+bIH5N4Wekh1GHW5jxisGhPJIc35wCDuXO0eYU5QVn2cQiOo1ov8SfteXgSzoLszXxkaxs0kh/p5ZDxRbIUux9//bo3dQJovjWVni6PT8RqzAar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCZwE6GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCZwE6GO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8185FC4AF0C;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779349977; bh=o0NVwirES5UBqa+dDLOUFzSJEpbDhFbK8hdfhxeciEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xCZwE6GOX4iuDiy20/IGmM8QsxM+3ra6PCO0q6H2M+A0gS5+2S85pCJjY1k9+ZnV7
	 Jj7lrHwDlUpSmegwXIC7fgfyM0QafFIRYu/zy8pSMXdxgVGqHLmsyTXoDzldJiQ8HL
	 KSMiyBOczT6rTyVbqMNClEvkIn7GvqU48/ROO/HE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED62CD4F3C;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 15:52:54 +0800
Subject: [PATCH v2 2/7] rust: macros: auto-insert ThisModule in #[vtable]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix-fops-owner-v2-2-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
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
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779349975; l=4177;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=o0NVwirES5UBqa+dDLOUFzSJEpbDhFbK8hdfhxeciEw=;
 b=Q6DTbV7+PYfAMn/D2wleruFS9xF8ZeX0LkKJ4lQ3KJ9pAlD1ePSSYkJDIUEFG7J7bjgi4m6yG
 SlPaIh4AX5MA9Gos3sDeR7pI9c3YzSVg0Y89M2pSvYmn9amiF6SQMDP
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Auto-add `type ThisModule: ::kernel::ModuleMetadata;` as a required
associated type on the trait side if not already defined, and
auto-insert `type ThisModule = crate::LocalModule;` on the impl side
if not explicitly provided, eliminating the need to manually declare
and implement `ThisModule` in every vtable trait and impl.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/macros/lib.rs    |  6 ++++++
 rust/macros/vtable.rs | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7c..d35e45ea745c0 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -176,6 +176,12 @@ pub fn module(input: TokenStream) -> TokenStream {
 ///
 /// This macro should not be used when all functions are required.
 ///
+/// Additionally, this macro automatically handles the `ThisModule`
+/// associated type: on the trait side, `type ThisModule: ModuleMetadata;`
+/// is added as a required associated type if not already defined; on the
+/// impl side, `type ThisModule = LocalModule;` is automatically inserted
+/// if not explicitly defined.
+///
 /// # Examples
 ///
 /// ```
diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index c6510b0c4ea1d..d3d0e9cbd7172 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -23,6 +23,7 @@
 
 fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
     let mut gen_items = Vec::new();
+    let mut has_this_module = false;
 
     gen_items.push(parse_quote! {
          /// A marker to prevent implementors from forgetting to use [`#[vtable]`](vtable)
@@ -30,6 +31,28 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
          const USE_VTABLE_ATTR: ();
     });
 
+    // Detect existing type ThisModule so we don't add a duplicate.
+    for i in &item.items {
+        if let TraitItem::Type(type_item) = i {
+            if type_item.ident == "ThisModule" {
+                has_this_module = true;
+            }
+        }
+    }
+
+    // Add `type ThisModule: ModuleMetadata` as a required associated type if
+    // the trait does not already define it. No default is used because
+    // `associated_type_defaults` is unstable (issue #29661).
+    if !has_this_module {
+        gen_items.push(parse_quote! {
+            /// The module implementing this vtable trait.
+            ///
+            /// Automatically set to `crate::LocalModule` by the `#[vtable]`
+            /// impl macro.
+            type ThisModule: ::kernel::ModuleMetadata;
+        });
+    }
+
     for item in &item.items {
         if let TraitItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;
@@ -58,18 +81,31 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
 fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
     let mut gen_items = Vec::new();
     let mut defined_consts = HashSet::new();
+    let mut defined_types = HashSet::new();
 
-    // Iterate over all user-defined constants to gather any possible explicit overrides.
+    // Iterate over all user-defined constants and types to gather any possible explicit overrides.
     for item in &item.items {
         if let ImplItem::Const(const_item) = item {
             defined_consts.insert(const_item.ident.clone());
         }
+        if let ImplItem::Type(type_item) = item {
+            defined_types.insert(type_item.ident.clone());
+        }
     }
 
     gen_items.push(parse_quote! {
         const USE_VTABLE_ATTR: () = ();
     });
 
+    // Auto-insert `type ThisModule = crate::LocalModule` if not explicitly defined.
+    // `crate::LocalModule` resolves to the real module type (via `module!`) or a
+    // dummy fallback in non-module contexts (e.g., doctests).
+    if !defined_types.contains(&parse_quote!(ThisModule)) {
+        gen_items.push(parse_quote! {
+            type ThisModule = crate::LocalModule;
+        });
+    }
+
     for item in &item.items {
         if let ImplItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;

-- 
2.43.0



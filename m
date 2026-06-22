Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78117335564;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096302; cv=none; b=qKPuu4is2vj/ZMAllKLr3ZK1h44QbqSL3vRBWbOuyH/eGWj7eoI0ezyN5vhWOXylU9tl4QOA58+HXrg1Z5eGT9OT5ul6edCpNQWu9tMBM3byTg8eru+xem9MV8LH+BFG++g43QzrXJgr/r63p2T90URd+I5XO4Js8qo1x4wZcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096302; c=relaxed/simple;
	bh=x1Xj7JPaDLl4UdeT1W7h/EaUVh4/bCzvYJqrWlx/1ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJgobWAd6mLW+8kZKwdWAx1DTIls4/y4FJvLv4+Rx23S3g4Pn6QBbPENxalcRS7tWydhx5lixzURL/JPT1F4K2jDBbdI3zDB+U6QpGUIsrbscQdz/ewGHawfMLzKPnI3W7PM4/QvxPblgXLjqex4ZcEt926aj0ayDYtk6nqyW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RaKuLDGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RaKuLDGX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1562CC2BCC6;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782096302; bh=x1Xj7JPaDLl4UdeT1W7h/EaUVh4/bCzvYJqrWlx/1ro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RaKuLDGXwQIDDUqtkc3YRew4SBUXOeBUUZ5Ms1Wzz7Ou7qbPadeZcQySzqnRNGAXk
	 KXQ3huW4f6KbF+GnZZhd+0fJIGg4wHV5ddnP2cTAdAgoIteID66JQGM7cYYzZA2FBa
	 GBcuOkiu1nY7Hov5CtWGRc93mR+pG/mu31mqvQwQ=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E658DCDB466;
	Mon, 22 Jun 2026 02:45:01 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 22 Jun 2026 10:44:55 +0800
Subject: [PATCH v3 1/6] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
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
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782096299; l=4126;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=x1Xj7JPaDLl4UdeT1W7h/EaUVh4/bCzvYJqrWlx/1ro=;
 b=xsFGkKslsVHkxnmCRMeO2GR7hR2tPYBqL0YDVs/fB/jZqt2UEqmwP4PE54OY/SRscBE2DdTTp
 ht9ty4L2X6gC9FMASbUlsaJU/KNuPfC7qWy4wc5BLff0MskuoaGbqBV
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Since `const_refs_to_static` has been stable as of the MSRV bump, a
`ThisModule` pointer can now be used in const contexts.

Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
can provide their `ThisModule` pointer in const contexts such as static
`file_operations`.

Move the `THIS_MODULE` static from the `module!` macro into the
`ModuleMetadata` impl, add a `this_module()` helper, and update `__init`
to use it.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/lib.rs    |  8 ++++++++
 rust/macros/module.rs | 34 +++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d6..50f5a7b5f028e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -184,6 +184,14 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
     const NAME: &'static crate::str::CStr;
+
+    /// The module's `THIS_MODULE` pointer.
+    const THIS_MODULE: ThisModule;
+}
+
+/// Returns a reference to the `THIS_MODULE` of the given module type.
+pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
+    &M::THIS_MODULE
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e2075083..b9fdee2f2af47 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -497,28 +497,28 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         /// Used by the printing macros, e.g. [`info!`].
         const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
 
-        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-        // freed until the module is unloaded.
-        #[cfg(MODULE)]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            extern "C" {
-                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-            };
-
-            ::kernel::ThisModule::from_ptr(__this_module.get())
-        };
-
-        #[cfg(not(MODULE))]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-        };
-
         /// The `LocalModule` type is the type of the module created by `module!`,
         /// `module_pci_driver!`, `module_platform_driver!`, etc.
         type LocalModule = #type_;
 
         impl ::kernel::ModuleMetadata for #type_ {
             const NAME: &'static ::kernel::str::CStr = #name_cstr;
+
+            #[cfg(MODULE)]
+            const THIS_MODULE: ::kernel::ThisModule = {
+                extern "C" {
+                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+                }
+
+                // SAFETY: `__this_module` is constructed by the kernel at load time
+                // and lives until the module is unloaded.
+                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
+            };
+
+            #[cfg(not(MODULE))]
+            const THIS_MODULE: ::kernel::ThisModule = unsafe {
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
+            };
         }
 
         // Double nested modules, since then nobody can access the public items inside.
@@ -616,7 +616,7 @@ pub extern "C" fn #ident_exit() {
                 /// This function must only be called once.
                 unsafe fn __init() -> ::kernel::ffi::c_int {
                     let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
-                        &super::super::THIS_MODULE
+                        ::kernel::this_module::<super::super::LocalModule>()
                     );
                     // SAFETY: No data race, since `__MOD` can only be accessed by this module
                     // and there only `__init` and `__exit` access it. These functions are only

-- 
2.43.0



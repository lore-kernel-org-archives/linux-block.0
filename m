Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304A3C1F59;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196210; cv=none; b=SoMo0rMjnPziWKHjjUk7dU21IgCaH5xnlH1sR/gQRrxuAQABVMFku2zmdkaO8SI7uAJYJihLd9Ud1MUtN+w/4Op4vjSKMpfo2PeG+u4BrJz1YCbzVy+bMhVWrpEG9OzZ4JaRRRqTUA+1ruAcvCjquxoBj6/jOoHhD9IRJYm3ZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196210; c=relaxed/simple;
	bh=7N/aT3TiijTAFPc5W+sgxlVekyjma75ZPcv4Wg0YnXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSlzNJDVGAcdNa5+MQn/QUf6RcEn8RQ549MzQo1G07z1d0dLVwmPffaWTa/SFkOU9BIFLNgvcqOPcEl5HarH+SB2iBOj/ThEcxVhLzch+G1LWZnW8usoQ9Vsnag+f+Omb38n9XqiSg59g1IsOxkQan0k0RqBjwpYSsXEloR/QC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+7JtzUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+7JtzUr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADEDC2BCB8;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782196209; bh=7N/aT3TiijTAFPc5W+sgxlVekyjma75ZPcv4Wg0YnXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+7JtzUrpibxhTu4expInVG8ZitmoMKtFzRwiWyV8tWmyM/qISCfsaD0L6Xg3ygnD
	 vS4xlj4RMKH0GpiikavXhhJum/nBq/sE4AtxdJCpX3iW2hJLBwzNJ2HrloSApvwhhh
	 5Ggrz0ttrQo85XCsp8VXTZJs6ShZoIi1mYqgQvrY=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F7CDB470;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 23 Jun 2026 14:29:44 +0800
Subject: [PATCH v4 1/9] rust: module: move module types into `module.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-fix-fops-owner-v4-1-0daf5f077d5c@linux.dev>
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782196206; l=10092;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=7N/aT3TiijTAFPc5W+sgxlVekyjma75ZPcv4Wg0YnXY=;
 b=joyqUWNOs9l5cEajINwGF3/kl5wlqKfWPgV9PQKxhhkPGf/YftnDm4NxCgkQUsUjGg+lRCOpg
 kI5ZAo139JBBi1geutTqT6LBgaG8K7OpPN90dnpb67RL/pj+p3cx6md
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Move `Module`, `InPlaceModule`, `ModuleMetadata` and `ThisModule` from
`lib.rs` into a new `rust/kernel/module.rs`. Re-export them from `lib.rs`
to avoid tree-wide changes.

Switch six bus driver registrations from `module.0` to the public
`ThisModule::as_ptr()` accessor, since the field is no longer visible
outside the new `module` submodule.

No functional change.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/auxiliary.rs |  2 +-
 rust/kernel/i2c.rs       |  2 +-
 rust/kernel/lib.rs       | 75 +++++-------------------------------------------
 rust/kernel/module.rs    | 71 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs   |  6 +++-
 rust/kernel/pci.rs       |  2 +-
 rust/kernel/platform.rs  |  2 +-
 rust/kernel/usb.rs       |  2 +-
 8 files changed, 88 insertions(+), 74 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 93c0db1f66555..4a02f83240be3 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -63,7 +63,7 @@ unsafe fn register(
 
         // SAFETY: `adrv` is guaranteed to be a valid `DriverType`.
         to_result(unsafe {
-            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
+            bindings::__auxiliary_driver_register(adrv.get(), module.as_ptr(), name.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b908f0c5a58d..24eff08f47123 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -142,7 +142,7 @@ unsafe fn register(
         }
 
         // SAFETY: `idrv` is guaranteed to be a valid `DriverType`.
-        to_result(unsafe { bindings::i2c_register_driver(module.0, idrv.get()) })
+        to_result(unsafe { bindings::i2c_register_driver(module.as_ptr(), idrv.get()) })
     }
 
     unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d6..040ae85056509 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -93,6 +93,7 @@
 pub mod maple_tree;
 pub mod miscdevice;
 pub mod mm;
+pub mod module;
 pub mod module_param;
 #[cfg(CONFIG_NET)]
 pub mod net;
@@ -139,79 +140,17 @@
 #[doc(hidden)]
 pub use bindings;
 pub use macros;
+pub use module::{
+    InPlaceModule,
+    Module,
+    ModuleMetadata,
+    ThisModule, //
+};
 pub use uapi;
 
 /// Prefix to appear before log messages printed from within the `kernel` crate.
 const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 
-/// The top level entrypoint to implementing a kernel module.
-///
-/// For any teardown or cleanup operations, your type may implement [`Drop`].
-pub trait Module: Sized + Sync + Send {
-    /// Called at module initialization time.
-    ///
-    /// Use this method to perform whatever setup or registration your module
-    /// should do.
-    ///
-    /// Equivalent to the `module_init` macro in the C API.
-    fn init(module: &'static ThisModule) -> error::Result<Self>;
-}
-
-/// A module that is pinned and initialised in-place.
-pub trait InPlaceModule: Sync + Send {
-    /// Creates an initialiser for the module.
-    ///
-    /// It is called when the module is loaded.
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error>;
-}
-
-impl<T: Module> InPlaceModule for T {
-    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error> {
-        let initer = move |slot: *mut Self| {
-            let m = <Self as Module>::init(module)?;
-
-            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
-            unsafe { slot.write(m) };
-            Ok(())
-        };
-
-        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
-        unsafe { pin_init::pin_init_from_closure(initer) }
-    }
-}
-
-/// Metadata attached to a [`Module`] or [`InPlaceModule`].
-pub trait ModuleMetadata {
-    /// The name of the module as specified in the `module!` macro.
-    const NAME: &'static crate::str::CStr;
-}
-
-/// Equivalent to `THIS_MODULE` in the C API.
-///
-/// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
-pub struct ThisModule(*mut bindings::module);
-
-// SAFETY: `THIS_MODULE` may be used from all threads within a module.
-unsafe impl Sync for ThisModule {}
-
-impl ThisModule {
-    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
-    ///
-    /// # Safety
-    ///
-    /// The pointer must be equal to the right `THIS_MODULE`.
-    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
-        ThisModule(ptr)
-    }
-
-    /// Access the raw pointer for this module.
-    ///
-    /// It is up to the user to use it correctly.
-    pub const fn as_ptr(&self) -> *mut bindings::module {
-        self.0
-    }
-}
-
 #[cfg(not(testlib))]
 #[panic_handler]
 fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
new file mode 100644
index 0000000000000..be242a82e86d2
--- /dev/null
+++ b/rust/kernel/module.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Module-related types and helpers.
+
+/// The entrypoint to implementing a kernel module.
+///
+/// For any teardown or cleanup operations, your type may implement [`Drop`].
+pub trait Module: Sized + Sync + Send {
+    /// Called at module initialization time.
+    ///
+    /// Use this method to perform whatever setup or registration your module
+    /// should do.
+    ///
+    /// Equivalent to the `module_init` macro in the C API.
+    fn init(module: &'static ThisModule) -> crate::error::Result<Self>;
+}
+
+/// A module that is pinned and initialised in-place.
+pub trait InPlaceModule: Sync + Send {
+    /// Creates an initialiser for the module.
+    ///
+    /// It is called when the module is loaded.
+    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::error::Error>;
+}
+
+impl<T: Module> InPlaceModule for T {
+    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::error::Error> {
+        let initer = move |slot: *mut Self| {
+            let m = <Self as Module>::init(module)?;
+
+            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
+            unsafe { slot.write(m) };
+            Ok(())
+        };
+
+        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
+        unsafe { pin_init::pin_init_from_closure(initer) }
+    }
+}
+
+/// Metadata attached to a [`Module`] or [`InPlaceModule`].
+pub trait ModuleMetadata {
+    /// The name of the module as specified in the `module!` macro.
+    const NAME: &'static crate::str::CStr;
+}
+
+/// Equivalent to `THIS_MODULE` in the C API.
+///
+/// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
+pub struct ThisModule(*mut crate::bindings::module);
+
+// SAFETY: `THIS_MODULE` may be used from all threads within a module.
+unsafe impl Sync for ThisModule {}
+
+impl ThisModule {
+    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be equal to the right `THIS_MODULE`.
+    pub const unsafe fn from_ptr(ptr: *mut crate::bindings::module) -> ThisModule {
+        ThisModule(ptr)
+    }
+
+    /// Access the raw pointer for this module.
+    ///
+    /// It is up to the user to use it correctly.
+    pub const fn as_ptr(&self) -> *mut crate::bindings::module {
+        self.0
+    }
+}
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf2..8b7036b8fe480 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -659,7 +659,11 @@ pub fn register(
         // the `drivers` slice are initialized properly. `drivers` will not be moved.
         // So it's just an FFI call.
         to_result(unsafe {
-            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
+            bindings::phy_drivers_register(
+                drivers[0].0.get(),
+                drivers.len().try_into()?,
+                module.as_ptr(),
+            )
         })?;
         // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
         Ok(Registration { drivers })
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114d..916ed2cb6b70b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -86,7 +86,7 @@ unsafe fn register(
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
         to_result(unsafe {
-            bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
+            bindings::__pci_register_driver(pdrv.get(), module.as_ptr(), name.as_char_ptr())
         })
     }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8917d4ee499fb..9fdbafd53bc21 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -82,7 +82,7 @@ unsafe fn register(
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
-        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.as_ptr()) })
     }
 
     unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9c17a672cd275..213db32727c17 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -63,7 +63,7 @@ unsafe fn register(
 
         // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.
         to_result(unsafe {
-            bindings::usb_register_driver(udrv.get(), module.0, name.as_char_ptr())
+            bindings::usb_register_driver(udrv.get(), module.as_ptr(), name.as_char_ptr())
         })
     }
 

-- 
2.43.0



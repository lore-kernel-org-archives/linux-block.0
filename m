Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B73DD536;
	Thu, 10 Sep 2026 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030900; cv=none; b=ePyorE9Lc7nNI4raqO/z8/fGsyfRRaQNf28grgw7zzLHsEftgwwRIkHw9D3h6QPZGvzH0zicw+BUxDXwiUpp1t2ga3S7v5zwr370w22WBOiJT+YW2TeOA7hihifl1SbPIw4zEP8HzC/ZtfeJzKoqqjnfsIlgbiix8xmUvmk6JeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030900; c=relaxed/simple;
	bh=1tqqvpjhx2OAkbG5Ud8PXC1RlcxT7MiBvIOm0S/0LEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwxVhpIETJQBTMEDTxSXRQHhUVtLtI+n4Pev2+3ouhuNZyzlCrgKGVJRewdKB8dz4igqtn7uhyEe7lRO5qcLjBU5ppBNE0yRbmSqicPS/LBhNFrbLDCG1Qc9paR8mCEZfCVFa3zRakHTp2X+xo5bbBaCieITId/nt/d0R2qjKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF1FkrFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF1FkrFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13671F000FF;
	Thu, 10 Sep 2026 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030884;
	bh=N69w1tIguM4Hdt3qM0oLkhXCHVLtaEMP44Mm/RQY1Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GF1FkrFnxAT7x6BK1dDA+qo5edpg5Nk47WyU/PKWiun+EClOPNwi1TKmUrDZf3glN
	 aYDyx1KKcEpJivX9ZgElDG53kTLbBeLYiJxBZLvW9A5xk3mQe2ztGBElTSxpq89ypd
	 F7SwZ9Nbkd0rSizMV3OaAoq4M4AsBD5saf8ljXnn1cMm9Q9dTByJgcXhYNizXo1fNe
	 SwqSLVSo9KeUllZUT3GVAiLQ3En682WxMcGSFlbd600Ds5w6u0u1/gzduJtzaQTTSz
	 /ToVT9l1iJz4EcjHlF/ETFeIMlH/Dz/p+VtsadspesWPskM0EVLWfQPr9tupkXRDch
	 cdX/CkmqC+nUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:08 +0200
Subject: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Igor Korotin <igor.korotin@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=41983;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=tMZps0y09d+eieqOpxKg/yZV3IVQ5wWryLvjLCJUoVY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGk8fQumjiA5S7esSKkgrQ0orD4jJmjhd6Xd
 9bHZtUQRWWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxpAAKCRD6UCkIqsW9
 0PrpEACFGIgkRYkA9AfeeGmaGAdH5BswkSPC8MX2zpsyFGlbM9X0m7dE9isReY5LDd8sN/jbgs6
 VcTAT3uw/Ax6yLreQ4WoMD+R2v3XsnmOu28/zBn7bB08fg261rSlK7mvvNNkvNhWvut2rP2I1ww
 W8Dz+Ay6/WMPcC+PkGini3oT2IDBf2OA0CTNfq5qFFvRx/RbMqSD8Jx1dVxY2NI1Cu7HvmJeBSr
 +wM1JclmuXQafDeaSLH/rDFyLBZd/ZcFkpusaJ/u9+zZNDC/r+0wFbUFXl3n0syt4u1GQgI3dcJ
 Fv/Ml6dibFvXoFET4JGp4K85yIrEbcdcQZ35qYxFzBPCXtP1M/NphvvWgUth8VNwB5QZh946wXD
 l7XKBjWba2BeLszuxxnZVNKPtHsLPfC+M+jrsAqM6fgBsy5n/lvJjHe94Pu/j/VAFG3BYOJZ8St
 WZ+qEUWaxdOeuKtm9O0Pr+a3e2lbn8wndkjLZ0q4BxOedivLLeNUNWeRMB+Kldqm2Oxd91WeTGj
 mjo+SqeEKGGV7Kjd9C2cA3I58fUzyWj8xijwP9FfBlHnpCReBFLGd9X9DBdgf9mTL7bm99kx2SV
 793hOT0uFIf52A6xn60pMlsENB0RWMbxuN9FT5DnOVvRHyTbn3wMZH7SimYLYyR4zFMwVnTrObJ
 KcFGrCmVreJCzMw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Oliver Mangold <oliver.mangold@pm.me>

There are types where it may both be reference counted in some cases and
owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.

Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
would require) and a marker trait to indicate that the type is always
reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
is possible.

- Rename `AlwaysRefCounted` to `RefCounted`.
- Add a new unsafe trait `AlwaysRefCounted`.
- Implement the new trait `AlwaysRefCounted` for the newly renamed
  `RefCounted` implementations. This leaves functionality of existing
  implementers of `AlwaysRefCounted` intact.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
[ Andreas: Updated commit message and rebase on rust-next (7.2) ]
Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Assisted-by: LLM
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/auxiliary.rs        | 10 ++++++-
 rust/kernel/block/mq/request.rs | 19 ++++++++-----
 rust/kernel/cred.rs             | 16 +++++++++--
 rust/kernel/device.rs           | 12 +++++++--
 rust/kernel/device/property.rs  | 11 ++++++--
 rust/kernel/drm/device.rs       |  9 +++++--
 rust/kernel/drm/gem/mod.rs      | 16 ++++++++---
 rust/kernel/drm/gpuvm/mod.rs    |  9 +++++--
 rust/kernel/drm/gpuvm/vm_bo.rs  |  6 ++++-
 rust/kernel/fs/file.rs          | 23 +++++++++++++---
 rust/kernel/i2c.rs              | 13 ++++++---
 rust/kernel/mm.rs               | 22 ++++++++++++---
 rust/kernel/mm/mmput_async.rs   | 12 +++++++--
 rust/kernel/opp.rs              | 16 ++++++++---
 rust/kernel/owned.rs            |  2 +-
 rust/kernel/pci.rs              | 10 ++++++-
 rust/kernel/pid_namespace.rs    | 15 +++++++++--
 rust/kernel/platform.rs         | 10 ++++++-
 rust/kernel/pwm.rs              | 12 +++++++--
 rust/kernel/sync/aref.rs        | 59 +++++++++++++++++++++++++----------------
 rust/kernel/task.rs             | 13 +++++++--
 rust/kernel/types.rs            | 12 ++++++---
 rust/kernel/usb.rs              | 17 +++++++++---
 rust/kernel/workqueue.rs        |  8 +++---
 24 files changed, 272 insertions(+), 80 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 60dfbec8f3302..52e86ccdb0caa 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -19,6 +19,10 @@
         to_result, //
     },
     prelude::*,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::{
         CovariantForLt,
         ForLt,
@@ -376,7 +380,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -395,6 +399,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index ce3e30c81cb5e..8dad15ae4cfb0 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -9,7 +9,11 @@
     block::mq::Operations,
     error::Result,
     sync::{
-        aref::{ARef, AlwaysRefCounted},
+        aref::{
+            ARef,
+            AlwaysRefCounted,
+            RefCounted, //
+        },
         atomic::Relaxed,
         Refcount,
     },
@@ -229,11 +233,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
 
-// SAFETY: All instances of `Request<T>` are reference counted. This
-// implementation of `AlwaysRefCounted` ensure that increments to the ref count
-// keeps the object alive in memory at least until a matching reference count
-// decrement is executed.
-unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+// SAFETY: All instances of `Request<T>` are reference counted. This implementation of `RefCounted`
+// ensure that increments to the ref count keeps the object alive in memory at least until a
+// matching reference count decrement is executed.
+unsafe impl<T: Operations> RefCounted for Request<T> {
     fn inc_ref(&self) {
         self.wrapper_ref().refcount().inc();
     }
@@ -255,3 +258,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         }
     }
 }
+
+// SAFETY: We currently do not implement `Ownable`, thus it is okay to obtain an `ARef<Request>`
+// from a `&Request` (but this will change in the future).
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index ffa156b9df377..b17736a9adcd5 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,7 +8,15 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    task::Kuid,
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
+};
 
 /// Wraps the kernel's `struct cred`.
 ///
@@ -76,7 +84,7 @@ pub fn euid(&self) -> Kuid {
 }
 
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
-unsafe impl AlwaysRefCounted for Credential {
+unsafe impl RefCounted for Credential {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -90,3 +98,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Credential>` from a
+// `&Credential`.
+unsafe impl AlwaysRefCounted for Credential {}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..afda4ac4a3045 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -8,8 +8,12 @@
     bindings,
     fmt,
     prelude::*,
-    sync::aref::ARef,
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
     types::{
+        AlwaysRefCounted,
         ForeignOwnable,
         Opaque, //
     }, //
@@ -435,7 +439,7 @@ pub fn name(&self) -> &CStr {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -447,6 +451,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 // SAFETY: As by the type invariant `Device` can be sent to any thread.
 unsafe impl Send for Device {}
 
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 5aead835fbbc0..cee7e25013689 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -14,7 +14,10 @@
     fmt,
     prelude::*,
     str::{CStr, CString},
-    sync::aref::ARef,
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    },
     types::Opaque,
 };
 
@@ -360,7 +363,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for FwNode {
+unsafe impl crate::sync::aref::RefCounted for FwNode {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the
         // refcount is non-zero.
@@ -374,6 +377,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<FwNode>` from a
+// `&FwNode`.
+unsafe impl AlwaysRefCounted for FwNode {}
+
 enum Node<'a> {
     Borrowed(&'a FwNode),
     Owned(ARef<FwNode>),
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 6b88ade28e242..33b787aea3cb1 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -17,7 +17,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::{
         NotThreadSafe,
@@ -480,7 +481,7 @@ fn deref(&self) -> &Self::Target {
 
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
+unsafe impl<T: drm::Driver> RefCounted for Device<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -495,6 +496,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
+
 impl<T: drm::Driver> AsRef<T::ParentDevice<device::Normal>> for Device<T> {
     fn as_ref(&self) -> &T::ParentDevice<device::Normal> {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e1ebad77ebe2a..2fa16d33e670e 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -21,7 +21,7 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        RefCounted, //
     },
     types::Opaque,
 };
@@ -34,7 +34,7 @@
 #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
 pub mod shmem;
 
-/// A macro for implementing [`AlwaysRefCounted`] for any GEM object type.
+/// A macro for implementing [`RefCounted`] for any GEM object type.
 ///
 /// Since all GEM objects use the same refcounting scheme.
 #[macro_export]
@@ -47,7 +47,7 @@ impl $( <$( $tparam_id:ident ),+> )? for $type:ty
         )?
     ) => {
         // SAFETY: All GEM objects are refcounted.
-        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::RefCounted for $type
         where
             Self: IntoGEMObject,
             $( $( $bind_param : $bind_trait ),+ )?
@@ -66,6 +66,14 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
                 unsafe { bindings::drm_gem_object_put(obj) };
             }
         }
+
+        // SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<$type>` from a
+        // `&$type`.
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
+        where
+            Self: IntoGEMObject,
+            $( $( $bind_param : $bind_trait ),+ )?
+        {}
     };
 }
 #[cfg_attr(not(CONFIG_RUST_DRM_GEM_SHMEM_HELPER), allow(unused))]
@@ -197,7 +205,7 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     /// Looks up an object by its handle for a given `File`.
     fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
     where
-        Self: AllocImpl<Driver = D> + AlwaysRefCounted,
+        Self: AllocImpl<Driver = D> + RefCounted,
         D: drm::Driver<Object = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index d9d43d7197613..1612a88a455f2 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -22,7 +22,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::Opaque, //
 };
@@ -81,7 +82,7 @@ unsafe impl<T: DriverGpuVm> Send for GpuVm<T> {}
 unsafe impl<T: DriverGpuVm> Sync for GpuVm<T> {}
 
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.vm`.
-unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {
+unsafe impl<T: DriverGpuVm> RefCounted for GpuVm<T> {
     fn inc_ref(&self) {
         // SAFETY: By type invariants, the allocation is managed by the refcount in `self.vm`.
         unsafe { bindings::drm_gpuvm_get(self.vm.get()) };
@@ -93,6 +94,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<GpuVm<T>>` from a
+// `&GpuVm<T>`.
+unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {}
+
 impl<T: DriverGpuVm> PartialEq for GpuVm<T> {
     #[inline]
     fn eq(&self, other: &Self) -> bool {
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index 5989972da829b..3692e832df419 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -29,7 +29,7 @@ unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T> {}
 unsafe impl<T: DriverGpuVm> Sync for GpuVmBo<T> {}
 
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
-unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
+unsafe impl<T: DriverGpuVm> RefCounted for GpuVmBo<T> {
     fn inc_ref(&self) {
         // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
         unsafe { bindings::drm_gpuvm_bo_get(self.inner.get()) };
@@ -44,6 +44,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<GpuVmBo<T>>` from a
+// `&GpuVmBo<T>`.
+unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {}
+
 impl<T: DriverGpuVm> PartialEq for GpuVmBo<T> {
     #[inline]
     fn eq(&self, other: &Self) -> bool {
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd2400..720e57418358d 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -12,8 +12,15 @@
     cred::Credential,
     error::{code::*, to_result, Error, Result},
     fmt,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::ptr;
 
@@ -197,7 +204,7 @@ unsafe impl Sync for File {}
 
 // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl RefCounted for File {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -212,6 +219,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<File>` from a
+// `&File`.
+unsafe impl AlwaysRefCounted for File {}
+
 /// Wraps the kernel's `struct file`. Not thread safe.
 ///
 /// This type represents a file that is not known to be safe to transfer across thread boundaries.
@@ -233,7 +244,7 @@ pub struct LocalFile {
 
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
 // makes `ARef<LocalFile>` own a normal refcount.
-unsafe impl AlwaysRefCounted for LocalFile {
+unsafe impl RefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -249,6 +260,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<LocalFile>` from a
+// `&LocalFile`.
+unsafe impl AlwaysRefCounted for LocalFile {}
+
 impl LocalFile {
     /// Constructs a new `struct file` wrapper from a file descriptor.
     ///
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 0487bae811fba..0f3f62a81763f 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -18,7 +18,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::Opaque, //
 };
@@ -415,7 +416,7 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
 kernel::impl_device_context_into_aref!(I2cAdapter);
 
 // SAFETY: Instances of `I2cAdapter` are always reference-counted.
-unsafe impl AlwaysRefCounted for I2cAdapter {
+unsafe impl RefCounted for I2cAdapter {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
@@ -428,6 +429,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<I2cAdapter>` from an
+// `&I2cAdapter`.
+unsafe impl AlwaysRefCounted for I2cAdapter {}
 
 /// The i2c board info representation
 ///
@@ -493,7 +497,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for I2cClient<C
 kernel::impl_device_context_into_aref!(I2cClient);
 
 // SAFETY: Instances of `I2cClient` are always reference-counted.
-unsafe impl AlwaysRefCounted for I2cClient {
+unsafe impl RefCounted for I2cClient {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -504,6 +508,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<I2cClient>` from an
+// `&I2cClient`.
+unsafe impl AlwaysRefCounted for I2cClient {}
 
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for I2cClient<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 4764d7b68f2a7..83ed94fca14ca 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,8 +13,15 @@
 
 use crate::{
     bindings,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -55,7 +62,7 @@ unsafe impl Send for Mm {}
 unsafe impl Sync for Mm {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for Mm {
+unsafe impl RefCounted for Mm {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -69,6 +76,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Mm>` from a `&Mm`.
+unsafe impl AlwaysRefCounted for Mm {}
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
@@ -91,7 +101,7 @@ unsafe impl Send for MmWithUser {}
 unsafe impl Sync for MmWithUser {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUser {
+unsafe impl RefCounted for MmWithUser {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -105,6 +115,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUser>` from a
+// `&MmWithUser`.
+unsafe impl AlwaysRefCounted for MmWithUser {}
+
 // Make all `Mm` methods available on `MmWithUser`.
 impl Deref for MmWithUser {
     type Target = Mm;
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index b8d2f051225c7..8fbc396e46028 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,7 +10,11 @@
 use crate::{
     bindings,
     mm::MmWithUser,
-    sync::aref::{ARef, AlwaysRefCounted},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::AlwaysRefCounted,
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -34,7 +38,7 @@ unsafe impl Send for MmWithUserAsync {}
 unsafe impl Sync for MmWithUserAsync {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUserAsync {
+unsafe impl RefCounted for MmWithUserAsync {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -48,6 +52,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUserAsync>`
+// from a `&MmWithUserAsync`.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {}
+
 // Make all `MmWithUser` methods available on `MmWithUserAsync`.
 impl Deref for MmWithUserAsync {
     type Target = MmWithUser;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 62e44676125d1..b8db6bdefd077 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,8 +16,14 @@
     ffi::{c_char, c_ulong},
     prelude::*,
     str::CString,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::Opaque,
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -1041,7 +1047,7 @@ unsafe impl Send for OPP {}
 unsafe impl Sync for OPP {}
 
 /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
-unsafe impl AlwaysRefCounted for OPP {
+unsafe impl RefCounted for OPP {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -1055,6 +1061,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
+// `&OPP`.
+unsafe impl AlwaysRefCounted for OPP {}
+
 impl OPP {
     /// Creates an owned reference to a [`OPP`] from a valid pointer.
     ///
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index e54a058d65cd6..3414e8df692b3 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -27,7 +27,7 @@
 ///
 /// Note: The underlying object is not required to provide internal reference counting, because it
 /// represents a unique, owned reference. If reference counting (on the Rust side) is required,
-/// [`AlwaysRefCounted`](crate::sync::aref::AlwaysRefCounted) should be implemented.
+/// [`RefCounted`](crate::types::RefCounted) should be implemented.
 ///
 /// # Examples
 ///
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3ec897709e890..d9898be45f1f5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -19,6 +19,10 @@
     },
     prelude::*,
     str::CStr,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -488,7 +492,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
@@ -502,6 +506,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 979a9718f153d..067f68b99e8c5 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,7 +7,14 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
+};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.
@@ -41,7 +48,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
 }
 
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
-unsafe impl AlwaysRefCounted for PidNamespace {
+unsafe impl RefCounted for PidNamespace {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -55,6 +62,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<PidNamespace>` from
+// a `&PidNamespace`.
+unsafe impl AlwaysRefCounted for PidNamespace {}
+
 // SAFETY:
 // - `PidNamespace::dec_ref` can be called from any thread.
 // - It is okay to send ownership of `PidNamespace` across thread boundaries.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ac0a012ae1bb6..08b534dbd331a 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -24,6 +24,10 @@
     },
     of,
     prelude::*,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -534,7 +538,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
 impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -546,6 +550,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 8aa47304bec36..5ae172cbc112c 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -13,7 +13,11 @@
     devres,
     error::{self, to_result},
     prelude::*,
-    sync::aref::{ARef, AlwaysRefCounted},
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque, //
 };
 use core::{
@@ -627,7 +631,7 @@ pub fn new<'a>(
 }
 
 // SAFETY: Implements refcounting for `Chip` using the embedded `struct device`.
-unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
+unsafe impl<T: PwmOps> RefCounted for Chip<T> {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
@@ -645,6 +649,10 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Chip<T>>` from a
+// `&Chip<T>`.
+unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {}
+
 // SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The underlying C
 // structure's state is managed and synchronized by the kernel's device model
 // and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 1876e40c76df4..215e7eb139fac 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -11,7 +11,7 @@
 //! underlying object, but this refcount is internal to the object. It essentially is a Rust
 //! implementation of the `get_` and `put_` pattern used in C for reference counting.
 //!
-//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`AlwaysRefCounted`]. It is a trait
+//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`RefCounted`]. It is a trait
 //! for accessing the internal reference count of an object of the `MyType` type.
 //!
 //! [`Arc`]: crate::sync::Arc
@@ -29,11 +29,9 @@
     types::ForeignOwnable, //
 };
 
-/// Types that are _always_ reference counted.
+/// Types that are internally reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decrement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
-/// [`ARef<T>`].
 ///
 /// This is usually implemented by wrappers to existing structures on the C side of the code. For
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
@@ -50,9 +48,8 @@
 /// at least until matching decrements are performed.
 ///
 /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
-/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
-/// alive.)
-pub unsafe trait AlwaysRefCounted {
+/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object alive.)
+pub unsafe trait RefCounted {
     /// Increments the reference count on the object.
     fn inc_ref(&self);
 
@@ -65,11 +62,27 @@ pub unsafe trait AlwaysRefCounted {
     /// Callers must ensure that there was a previous matching increment to the reference count,
     /// and that the object is no longer used after its reference count is decremented (as it may
     /// result in the object being freed), unless the caller owns another increment on the refcount
-    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
-    /// [`AlwaysRefCounted::dec_ref`] once).
+    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`RefCounted::dec_ref`] once).
     unsafe fn dec_ref(obj: NonNull<Self>);
 }
 
+/// Always reference-counted type.
+///
+/// It allows deriving a counted reference [`ARef<T>`] from a `&T`.
+///
+/// This provides some convenience, but it allows "escaping" borrow checks on `&T`. As it
+/// complicates attempts to ensure that a reference to T is unique, it is optional to provide for
+/// [`RefCounted`] types. See *Safety* below.
+///
+/// # Safety
+///
+/// Implementers must ensure that no safety invariants are violated by upgrading an `&T` to an
+/// [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`crate::types::Ownable`]
+/// cannot be implemented for the same type, as this would allow violating the uniqueness guarantee
+/// of [`crate::types::Owned<T>`] by dereferencing it into an `&T` and obtaining an [`ARef`] from
+/// that.
+pub unsafe trait AlwaysRefCounted: RefCounted {}
+
 /// An owned reference to an always-reference-counted object.
 ///
 /// The object's reference count is automatically decremented when an instance of [`ARef`] is
@@ -80,7 +93,7 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
+pub struct ARef<T: RefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
 }
@@ -89,19 +102,19 @@ pub struct ARef<T: AlwaysRefCounted> {
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
 // `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
 // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
 
 // SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
 // because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
 // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
 // `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
 // example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
 
 // Even if `T` is pinned, pointers to `T` can still move.
-impl<T: AlwaysRefCounted> Unpin for ARef<T> {}
+impl<T: RefCounted> Unpin for ARef<T> {}
 
-impl<T: AlwaysRefCounted> ARef<T> {
+impl<T: RefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
     /// It takes over an increment of the reference count on the underlying object.
@@ -130,12 +143,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// ```
     /// use core::ptr::NonNull;
-    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
+    /// use kernel::sync::aref::{ARef, RefCounted};
     ///
     /// struct Empty {}
     ///
     /// # // SAFETY: TODO.
-    /// unsafe impl AlwaysRefCounted for Empty {
+    /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
     /// }
@@ -153,7 +166,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
     }
 }
 
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
+impl<T: RefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
         self.inc_ref();
         // SAFETY: We just incremented the refcount above.
@@ -161,7 +174,7 @@ fn clone(&self) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
+impl<T: RefCounted> Deref for ARef<T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -178,7 +191,7 @@ fn from(b: &T) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
+impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
         // decrement.
@@ -188,15 +201,15 @@ fn drop(&mut self) {
 
 impl<T, U> PartialEq<ARef<U>> for ARef<T>
 where
-    T: AlwaysRefCounted + PartialEq<U>,
-    U: AlwaysRefCounted,
+    T: RefCounted + PartialEq<U>,
+    U: RefCounted,
 {
     #[inline]
     fn eq(&self, other: &ARef<U>) -> bool {
         T::eq(&**self, &**other)
     }
 }
-impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
+impl<T: RefCounted + Eq> Eq for ARef<T> {}
 
 // SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so it's non-null. The
 // `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's aligned to `T`.
@@ -245,7 +258,7 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
 
 impl<T, U> PartialEq<&'_ U> for ARef<T>
 where
-    T: AlwaysRefCounted + PartialEq<U>,
+    T: RefCounted + PartialEq<U>,
 {
     #[inline]
     fn eq(&self, other: &&U) -> bool {
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 3336df493decc..da363e27664fa 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -10,7 +10,12 @@
     pid_namespace::PidNamespace,
     prelude::*,
     sync::aref::ARef,
-    types::{NotThreadSafe, Opaque},
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque,
+        RefCounted, //
+    },
 };
 use core::{
     ops::Deref,
@@ -347,7 +352,7 @@ pub fn group_leader(&self) -> &Task {
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
+unsafe impl RefCounted for Task {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -361,6 +366,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Task>` from a
+// `&Task`.
+unsafe impl AlwaysRefCounted for Task {}
+
 impl PartialEq for Task {
     #[inline]
     fn eq(&self, other: &Self) -> bool {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index b23e1d60cdd65..f97b8ab6dad55 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -18,9 +18,15 @@
     ForLt, //
 };
 
-pub use crate::owned::{
-    Ownable,
-    Owned, //
+pub use crate::{
+    owned::{
+        Ownable,
+        Owned, //
+    },
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    }, //
 };
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 993760ff332b8..88af466cedaba 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -18,7 +18,10 @@
         to_result, //
     },
     prelude::*,
-    sync::aref::AlwaysRefCounted,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -373,7 +376,7 @@ fn as_ref(&self) -> &Device {
 }
 
 // SAFETY: Instances of `Interface` are always reference-counted.
-unsafe impl AlwaysRefCounted for Interface {
+unsafe impl RefCounted for Interface {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Interface` guarantee that `self.as_raw()`
@@ -389,6 +392,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Interface>` from a
+// `&Interface`.
+unsafe impl AlwaysRefCounted for Interface {}
+
 // SAFETY: A `Interface` is always reference-counted and can be released from any thread.
 unsafe impl Send for Interface {}
 
@@ -426,7 +433,7 @@ fn as_raw(&self) -> *mut bindings::usb_device {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Device` guarantee that `self.as_raw()`
@@ -442,6 +449,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7e253b6f299ce..77673b8ea45fb 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -192,7 +192,7 @@
     sync::{
         aref::{
             ARef,
-            AlwaysRefCounted, //
+            RefCounted, //
         },
         Arc,
         LockClassKey, //
@@ -954,7 +954,7 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Pin<KBox<T>>
 //     implementation of `WorkItemPointer` for `ARef<T>`.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
 where
-    T: AlwaysRefCounted,
+    T: RefCounted,
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
@@ -987,7 +987,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
 // requirements of `WorkItemPointer`.
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for ARef<T>
 where
-    T: AlwaysRefCounted,
+    T: RefCounted,
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
@@ -1020,7 +1020,7 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for ARef<T>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasDelayedWork<T, ID>,
-    T: AlwaysRefCounted,
+    T: RefCounted,
 {
 }
 

-- 
2.51.2



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7143DA5D9;
	Thu,  4 Jun 2026 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604010; cv=none; b=AD2nqQeeUHTNlGX5Y+zbkKRevwQ0ePERGujqmg2YEhO78CYngPUgy897Tm39CvSA1yiuY5tO/vmw+WJvELcqUMZ3MQFDmQMIxI/x+dGwfx6ekNLcb7T1Mccm4k3R4v2U31foWwFfqe9c7Kc4sGC8KYY65vYW/Gn/86fg1tJ+swQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604010; c=relaxed/simple;
	bh=KZI821jCYwAlNEM8F+VgChXooOwtVc75TRXvBIP5mYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uu5m71rPc0ftN8FLa+vPFinFia6jcfPSQiN5pG4p0srE6HVdtLiRouMZzo0kUiqaawHXgeuN2tLQ1NkuUqdqstv8GpJ0ml02zzc5Jqyh0w4jiNjwrnB4svSo0wolfaHabPtGtA0OAUzgoV/RVO2kmDuw+asexyYMXHTy5Ru1GhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRIkboba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRIkboba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FAB1F00898;
	Thu,  4 Jun 2026 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604004;
	bh=JJhJELyOPXSQq8UHfkijKrUFykDpNArMVIBDqRCSDBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VRIkbobaAr9Tvr/LAjf2l1rvmR/ZiO2YxIV4t682uHMzRWiALP1IZXokoJBcOloT1
	 Or71+h4vazMIfxWurjCgsWfNJUmmSpeB9v6xvlQzaH/plwyltqhDjSP6fEijMzSN6A
	 lHyVBbNDN6KUOTRZ2jPZT7eqDxv/ycg9Q/TC0MkokwYxRiKcpbDE5zB/u2uzj2NUuA
	 LTXJcIfhaWmNjPnyhW9uaBXLgwb+ZpTZjiJSpvpNsE5gR0reYKGT+izJFb9SC5KuAR
	 jntQ+3UCQnKChQH7wMkLjf2hdggkgylWTxpEPESNxNSTlB6bnGys6t265+JJevmGwg
	 mFwBmxZ90ZjAg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:18 +0200
Subject: [PATCH v17 06/10] rust: rename `AlwaysRefCounted` to `RefCounted`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=35062;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=vsLTWGJQlTArMQSB/3JY/GTrzdDUXcFWfohN952re70=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvrPR64zgPbGaLah3DFrW0PlrQLGxOZQdIoK
 wJ5RBmrhZGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb6wAKCRD6UCkIqsW9
 0JaBEACjGXyVUfZAk6I9+XfF3wKRVWMXOBNsu9hT6TZkyGgUHv9A8nV1odHO5I4U4NwVPmkKgxe
 ywE6TSqqkEHDTfalGD90oGto7lAIRWnbEmYzFVOfhNpU+HK5E6JWAixBSH5OL4pms47d/ANrtUc
 GvT5etR9yB2NidAUpjkyBOJzTU4qDlRumdL+RLIiTe1e4AETBr2jEaeNl8WVCwnPAGIPU32qt3D
 uofQ8gOIBp2AvhwSgJ6Vi/I8RW50Lf3FseeAmyu0p7rc7V8UulZ9ihR/MImzy7WmWI+qJUYPqjq
 6BVQkwOUQa+CvwqXqU70v6fPBbCCtjJjArhIiuRvAX4103O/cjrRJkPtC69/8DRgCp6HvS7n+YM
 0uqCcCDdEIOOeTO185gMK0BfgnW86qHPlmVAVt6XGhfIeXsYpYiRRqwmd9VhFtpfH06CqJGTO13
 gmu/C3v/geAw1o/3K5BdWJMwC/LdhnNuxcHXJZslBaHQDzGyCY06sfM0f9/QOemIyFOhHOGMDud
 C2Oi/mkdimmvjiYjko/hv8LTdfq3xcrpazJfllBZjuGF896O520/r2eq30B9Pix1uzovnsbJukt
 K6ksvaxr+wuK/faCwhurMLRQRxbdchhaIafsQXY/druZrro9W4wbYeMoA72J4G70gbZpt6nIVdQ
 hZBmVuUjj1hSbJQ==
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
[ Andreas: Updated commit message and rebase on rust-6.20-7.0 ]
Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/auxiliary.rs        |  7 +++++-
 rust/kernel/block/mq/request.rs | 15 ++++++++-----
 rust/kernel/cred.rs             | 13 +++++++++--
 rust/kernel/device.rs           | 12 ++++++++--
 rust/kernel/device/property.rs  | 11 +++++++--
 rust/kernel/drm/device.rs       |  9 ++++++--
 rust/kernel/drm/gem/mod.rs      | 16 ++++++++++----
 rust/kernel/fs/file.rs          | 16 ++++++++++----
 rust/kernel/i2c.rs              | 13 ++++++++---
 rust/kernel/mm.rs               | 15 +++++++++----
 rust/kernel/mm/mmput_async.rs   |  9 ++++++--
 rust/kernel/opp.rs              | 10 ++++++---
 rust/kernel/owned.rs            |  2 +-
 rust/kernel/pci.rs              | 10 ++++++++-
 rust/kernel/pid_namespace.rs    | 12 ++++++++--
 rust/kernel/platform.rs         |  7 +++++-
 rust/kernel/sync/aref.rs        | 49 ++++++++++++++++++++++++++---------------
 rust/kernel/task.rs             | 13 +++++++++--
 rust/kernel/types.rs            |  3 ++-
 rust/kernel/usb.rs              | 17 +++++++++++---
 20 files changed, 195 insertions(+), 64 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 93c0db1f6655..49f07740f657 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -19,6 +19,7 @@
         to_result, //
     },
     prelude::*,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::Opaque,
     ThisModule, //
 };
@@ -289,7 +290,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -308,6 +309,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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
index ce3e30c81cb5..cf013b9e2cac 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -9,7 +9,7 @@
     block::mq::Operations,
     error::Result,
     sync::{
-        aref::{ARef, AlwaysRefCounted},
+        aref::{ARef, AlwaysRefCounted, RefCounted},
         atomic::Relaxed,
         Refcount,
     },
@@ -229,11 +229,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
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
@@ -255,3 +254,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         }
     }
 }
+
+// SAFETY: We currently do not implement `Ownable`, thus it is okay to obtain an `ARef<Request>`
+// from a `&Request` (but this will change in the future).
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index ffa156b9df37..20ef0144094b 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,7 +8,12 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    task::Kuid,
+    types::{AlwaysRefCounted, Opaque},
+};
 
 /// Wraps the kernel's `struct cred`.
 ///
@@ -76,7 +81,7 @@ pub fn euid(&self) -> Kuid {
 }
 
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
-unsafe impl AlwaysRefCounted for Credential {
+unsafe impl RefCounted for Credential {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -90,3 +95,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Credential>` from a
+// `&Credential`.
+unsafe impl AlwaysRefCounted for Credential {}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 6d5396a43ebe..efdf33617d12 100644
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
@@ -508,7 +512,7 @@ pub fn name(&self) -> &CStr {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -520,6 +524,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 // SAFETY: As by the type invariant `Device` can be sent to any thread.
 unsafe impl Send for Device {}
 
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 5aead835fbbc..cee7e2501368 100644
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
index adbafe8db54d..a5a040266aae 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -15,7 +15,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::Opaque,
     workqueue::{
@@ -217,7 +218,7 @@ fn deref(&self) -> &Self::Target {
 
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
+unsafe impl<T: drm::Driver> RefCounted for Device<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -232,6 +233,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
+
 impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 75acda7ba500..f8cc2a0ff4c7 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -17,7 +17,7 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        RefCounted, //
     },
     types::Opaque,
 };
@@ -29,7 +29,7 @@
 #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
 pub mod shmem;
 
-/// A macro for implementing [`AlwaysRefCounted`] for any GEM object type.
+/// A macro for implementing [`RefCounted`] for any GEM object type.
 ///
 /// Since all GEM objects use the same refcounting scheme.
 #[macro_export]
@@ -42,7 +42,7 @@ impl $( <$( $tparam_id:ident ),+> )? for $type:ty
         )?
     ) => {
         // SAFETY: All GEM objects are refcounted.
-        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::RefCounted for $type
         where
             Self: IntoGEMObject,
             $( $( $bind_param : $bind_trait ),+ )?
@@ -61,6 +61,14 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
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
@@ -98,7 +106,7 @@ fn close(_obj: &<Self::Driver as drm::Driver>::Object, _file: &DriverFile<Self>)
 }
 
 /// Trait that represents a GEM object subtype
-pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
+pub trait IntoGEMObject: Sized + super::private::Sealed + RefCounted {
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
     fn as_raw(&self) -> *mut bindings::drm_gem_object;
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd240..06e457d62a93 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -12,8 +12,8 @@
     cred::Credential,
     error::{code::*, to_result, Error, Result},
     fmt,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::RefCounted,
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
 
@@ -197,7 +197,7 @@ unsafe impl Sync for File {}
 
 // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl RefCounted for File {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -212,6 +212,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<File>` from a
+// `&File`.
+unsafe impl AlwaysRefCounted for File {}
+
 /// Wraps the kernel's `struct file`. Not thread safe.
 ///
 /// This type represents a file that is not known to be safe to transfer across thread boundaries.
@@ -233,7 +237,7 @@ pub struct LocalFile {
 
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
 // makes `ARef<LocalFile>` own a normal refcount.
-unsafe impl AlwaysRefCounted for LocalFile {
+unsafe impl RefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -249,6 +253,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
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
index 7b908f0c5a58..56791c1d63d7 100644
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
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::i2c_get_adapter(self.index()) };
@@ -426,6 +427,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
+// `&I2cAdapter`.
+unsafe impl AlwaysRefCounted for I2cAdapter {}
 
 /// The i2c board info representation
 ///
@@ -491,7 +495,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for I2cClient<C
 kernel::impl_device_context_into_aref!(I2cClient);
 
 // SAFETY: Instances of `I2cClient` are always reference-counted.
-unsafe impl AlwaysRefCounted for I2cClient {
+unsafe impl RefCounted for I2cClient {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -502,6 +506,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
+// `&I2cClient`.
+unsafe impl AlwaysRefCounted for I2cClient {}
 
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for I2cClient<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 4764d7b68f2a..dd9e3969e720 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,8 +13,8 @@
 
 use crate::{
     bindings,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::RefCounted,
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -55,7 +55,7 @@ unsafe impl Send for Mm {}
 unsafe impl Sync for Mm {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for Mm {
+unsafe impl RefCounted for Mm {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -69,6 +69,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Mm>` from a `&Mm`.
+unsafe impl AlwaysRefCounted for Mm {}
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
@@ -91,7 +94,7 @@ unsafe impl Send for MmWithUser {}
 unsafe impl Sync for MmWithUser {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUser {
+unsafe impl RefCounted for MmWithUser {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -105,6 +108,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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
index b8d2f051225c..aba4ce675c86 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,7 +10,8 @@
 use crate::{
     bindings,
     mm::MmWithUser,
-    sync::aref::{ARef, AlwaysRefCounted},
+    sync::aref::RefCounted,
+    types::{ARef, AlwaysRefCounted},
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -34,7 +35,7 @@ unsafe impl Send for MmWithUserAsync {}
 unsafe impl Sync for MmWithUserAsync {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUserAsync {
+unsafe impl RefCounted for MmWithUserAsync {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -48,6 +49,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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
index a760fac28765..06fe2ca776a4 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,8 +16,8 @@
     ffi::{c_char, c_ulong},
     prelude::*,
     str::CString,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::Opaque,
+    sync::aref::RefCounted,
+    types::{ARef, AlwaysRefCounted, Opaque},
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -1041,7 +1041,7 @@ unsafe impl Send for OPP {}
 unsafe impl Sync for OPP {}
 
 /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
-unsafe impl AlwaysRefCounted for OPP {
+unsafe impl RefCounted for OPP {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::dev_pm_opp_get(self.0.get()) };
@@ -1053,6 +1053,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
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
index 5eacdf327d12..bedd4fef84fa 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -27,7 +27,7 @@
 ///
 /// Note: The underlying object is not required to provide internal reference counting, because it
 /// represents a unique, owned reference. If reference counting (on the Rust side) is required,
-/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
+/// [`RefCounted`](crate::types::RefCounted) should be implemented.
 ///
 /// # Examples
 ///
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..acf7384fea02 100644
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
@@ -474,7 +478,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 impl crate::dma::Device for Device<device::Core> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
@@ -486,6 +490,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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
index 979a9718f153..4f6a94540e33 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,7 +7,11 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    types::{AlwaysRefCounted, Opaque},
+};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.
@@ -41,7 +45,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
 }
 
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
-unsafe impl AlwaysRefCounted for PidNamespace {
+unsafe impl RefCounted for PidNamespace {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -55,6 +59,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
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
index 8917d4ee499f..3c35aa94e319 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -27,6 +27,7 @@
     },
     of,
     prelude::*,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::Opaque,
     ThisModule, //
 };
@@ -512,7 +513,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
 impl crate::dma::Device for Device<device::Core> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -524,6 +525,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 4ee5fac0e0b6..2d656f672b97 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -19,11 +19,9 @@
 
 use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
 
-/// Types that are _always_ reference counted.
+/// Types that are internally reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decrement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
-/// [`ARef<T>`].
 ///
 /// This is usually implemented by wrappers to existing structures on the C side of the code. For
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
@@ -40,9 +38,8 @@
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
 
@@ -55,11 +52,27 @@ pub unsafe trait AlwaysRefCounted {
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
@@ -70,7 +83,7 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
+pub struct ARef<T: RefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
 }
@@ -79,19 +92,19 @@ pub struct ARef<T: AlwaysRefCounted> {
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
@@ -120,12 +133,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
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
@@ -143,7 +156,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
     }
 }
 
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
+impl<T: RefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
         self.inc_ref();
         // SAFETY: We just incremented the refcount above.
@@ -151,7 +164,7 @@ fn clone(&self) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
+impl<T: RefCounted> Deref for ARef<T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -168,7 +181,7 @@ fn from(b: &T) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
+impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
         // decrement.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38273f4eedb5..6259430b0ca3 100644
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
index 4aec7b699269..9b96aa2ebdb7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -18,7 +18,8 @@
     },
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     }, //
 };
 
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9c17a672cd27..90b13e65cc82 100644
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
@@ -381,7 +384,7 @@ fn as_ref(&self) -> &Device {
 }
 
 // SAFETY: Instances of `Interface` are always reference-counted.
-unsafe impl AlwaysRefCounted for Interface {
+unsafe impl RefCounted for Interface {
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Interface` guarantee that `self.as_raw()`
         // returns a valid `struct usb_interface` pointer, for which we will
@@ -395,6 +398,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Interface>` from a
+// `&Interface`.
+unsafe impl AlwaysRefCounted for Interface {}
+
 // SAFETY: A `Interface` is always reference-counted and can be released from any thread.
 unsafe impl Send for Interface {}
 
@@ -432,7 +439,7 @@ fn as_raw(&self) -> *mut bindings::usb_device {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Device` guarantee that `self.as_raw()`
         // returns a valid `struct usb_device` pointer, for which we will
@@ -446,6 +453,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid

-- 
2.51.2



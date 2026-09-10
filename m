Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3138DC7A;
	Thu, 10 Sep 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030865; cv=none; b=NcXGRIVVB9qUVHPDTzRpbTlL6hO0sloHqn2T3/YQ1rM64asGoEvTsq6Wzif/0jYp6nFfB4RIGFwvhzfmmnYWY+v8Oy/VAJH+HcM290vyaEliIXCu3DR9VTvCDgKvYN4moU/1Kii186w7CYgLhOM/AuO02+kI5jfCAJWzq5hCgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030865; c=relaxed/simple;
	bh=Hb2HNhVK5xYDFsjqho1bSkwk0fFnV2KftqOWKG6uYyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJVsUIrGZrX60OmcvJgcJrjtiRjHRkgcVWmV+rLDOmDHS5ih9GBJMTjDxx8ofV7xtZo9MRx2v0N+Rpi6/0+IpfFiPerZunz0X9d/G+cPj0wbSVFoZ7f2Lo/ZPyf2Qa9cqXn6Nc3zTCc3bA5F1StxuAw7BGv5mdMk9UJyYqkFKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMe5u/k2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMe5u/k2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9D1F000FF;
	Thu, 10 Sep 2026 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030849;
	bh=uQml9IWDW5+htLmEYNNi48E8YJfucS2455Ey2j2BYFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bMe5u/k2HwLOKRURCP4zIpVVO7Vhj0W0uicOP2neknaxys8AM8ILpI2lfOCOID19q
	 BvIRygBnGtMD8iHTPcoyyI7mrinkS3FTeclLoPxVenqn+emuNIvW2IlJDUOF4fU9kg
	 BdjyV0RQB2SBUlwUv1K4PPKS4qlEyIFKMkpNnYxZFNDQ37/Al+v/T/jP1D+12WEMCO
	 tYuXsQ4EjCus+vZDIGXGLKa7gw/94vq4Ap7oXnrZEsnv0rEvyu/hdUsXAV7bUM6MiL
	 XEvOF7RUwpft5taUZ1JYtku9zItwzIxyCwFX340Uevkvy8Mlj4tVYsOGZu9ukySezW
	 dYQoGKvssPCjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:10 +0200
Subject: [PATCH v21 6/9] rust: Add `OwnableRefCounted`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-6-e83257373062@kernel.org>
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
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10710;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=LhNdeWjsAq8Iqh7hoE5lqbiBvBxHde9km6+3nWP/qJU=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGmXTFp4HVdd/kifr5tO6N87tVIDwru8njrQ
 k5wrayLpWeJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxpgAKCRD6UCkIqsW9
 0ObFEACwkRjVnLx3u2xUyFPxylC/Jwz599HvQ+QYkPCiunJXkm1mjGrf2XGk1kcyie056aA01On
 GwMqBcMi5WhnW+7z4paWiyFy2LCOB0955PxWZh3TDqbdZTj0rrH+3P/SumzGfE3xx+wwRwImVAI
 CAqrvNoM3Vn683/l4le3xfZ8DhwiK5/LBTg9iSenUpk2+R70vmvukEo/L1ENzh4bQY2Px8CjM6p
 0gtk5bp45Krn3Rl69DG6uJdnSoz9aO9qdLjTAKwLYqK3xYfQ8rAXBpEdqeSMULKuZf9sPnFsd8F
 oXhsun19gpVDvqHhBLxAE2S4GNiDWLiX6cWfUdZVwHn/07ljp5p9R94X8VFvgFVCnbVjfAjzGvh
 EM5yy0H9TZzO33EtEfZlRtaL8kIgnEH4+aaI9A28KEYA+hEAczluwSQjsOPzSju9dZfzjl6X80X
 pnNZk6dFK2vkHkpln25EGPI/lKEeNOKA9Rum+aSF0tFDT/15evwMJJnQw+1XCYT6xDfjNsFb2YE
 swp+qoQvcp1E4gc9TLssUCeAOA5LADHblFX/kGBZ7WQJBW1e/ss5Y0K2C/apoEJ534kXaMTvhVv
 L87paAlbYpA9VgNSxZvOGdv3PNsBMQqwnPUe6TrrL51/QC7lhmW/Bq2WJ9EDcosbHqsmAF36VFs
 XTxCa6/CD334bKg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Oliver Mangold <oliver.mangold@pm.me>

Types implementing one of these traits can safely convert between an
`ARef<T>` and an `Owned<T>`.

This is useful for types which generally are accessed through an `ARef`
but have methods which can only safely be called when the reference is
unique, like e.g. `block::mq::Request::end_ok()`.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
[ Andreas: Fix formatting, update documentation, fix error handling in
  examples. ]
Assisted-by: LLM
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs     | 147 +++++++++++++++++++++++++++++++++++++++++++++--
 rust/kernel/sync/aref.rs |  16 +++++-
 rust/kernel/types.rs     |   1 +
 3 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 3414e8df692b..ff3fa31ce1d1 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -14,20 +14,26 @@
     pin::Pin,
     ptr::NonNull, //
 };
+use kernel::{
+    sync::aref::ARef,
+    types::RefCounted, //
+};
 
 use kernel::types::ForeignOwnable;
 
 /// Types that specify their own way of performing allocation and destruction. Typically, this trait
 /// is implemented on types from the C side.
 ///
-/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
-/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
-/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
-/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
+/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type.
+///  - This is useful when it is desirable to tie the lifetime of an object reference to an owned
+///    object, rather than pass around a bare reference.
+///  - [`Ownable`] types can define custom drop logic that is executed when the owned reference
+///    of type [`Owned<_>`] pointing to the object is dropped.
 ///
 /// Note: The underlying object is not required to provide internal reference counting, because it
 /// represents a unique, owned reference. If reference counting (on the Rust side) is required,
-/// [`RefCounted`](crate::types::RefCounted) should be implemented.
+/// [`RefCounted`] should be implemented. [`OwnableRefCounted`] should be implemented if conversion
+/// between unique and shared (reference counted) ownership is needed.
 ///
 /// # Examples
 ///
@@ -99,6 +105,8 @@ pub trait Ownable {
     /// Callers must ensure that they have exclusive ownership of the `Self` pointed to by `this`,
     /// and that this ownership is transferred to the `release` method. `this` must not be used
     /// after calling this method, as the underlying object may have been freed.
+    ///
+    /// `this` is pinned and implementers of this method must observe this constraint.
     unsafe fn release(this: NonNull<Self>);
 }
 
@@ -139,6 +147,8 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// This function does not drop the underlying `T`. When this function returns, ownership of the
     /// underlying `T` is with the caller.
+    ///
+    /// Note that the returned pointer is pinned.
     #[inline]
     pub fn into_raw(me: Self) -> NonNull<T> {
         ManuallyDrop::new(me).ptr
@@ -239,3 +249,130 @@ unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a>
         unsafe { Pin::new_unchecked(inner) }
     }
 }
+
+/// A trait for objects that can be wrapped in either one of the reference types [`Owned`] and
+/// [`ARef`].
+///
+/// # Examples
+///
+/// A minimal example implementation of [`OwnableRefCounted`], [`Ownable`] and its usage with
+/// [`ARef`] and [`Owned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// # use core::ptr::NonNull;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::sync::aref::{ARef, RefCounted};
+/// # use kernel::sync::atomic::Acquire;
+/// # use kernel::sync::Refcount;
+/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
+///
+/// // An internally refcounted struct for demonstration purposes.
+/// //
+/// // # Invariants
+/// //
+/// // - `refcount` counts the live references to the object, so the object is valid while
+/// //   `refcount` is non-zero.
+/// struct Foo {
+///     refcount: Refcount,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>> {
+///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
+///         // not actually a C-allocated object.
+///         // INVARIANT: We initialize `refcount` to 1, counting the reference held by the
+///         // returned `Owned<Foo>`.
+///         let result = KBox::new(
+///             Foo {
+///                 refcount: Refcount::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result = KBox::into_non_null(result);
+///         // SAFETY:
+///         //  - We just allocated the `Self`, thus it is valid and we own it.
+///         //  - We can transfer this ownership to the `from_raw` method.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: We increment and decrement the refcount each time the respective function is
+/// // called, and only free the `Foo` when the refcount reaches zero.
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.inc();
+///     }
+///
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: By requirement on calling this function, the refcount is non-zero,
+///         // implying the underlying object is valid.
+///         let refcount = unsafe { &this.as_ref().refcount };
+///         if refcount.dec_and_test() {
+///             // SAFETY: The refcount reached zero, so by requirement on calling this function
+///             // no reference to the object remains and it will no longer be used. We can
+///             // reclaim the allocation by passing ownership back to the [`KBox`], which frees
+///             // the `Foo` when dropped.
+///             drop(unsafe { KBox::from_raw(this.as_ptr()) });
+///         }
+///     }
+/// }
+///
+/// impl OwnableRefCounted for Foo {
+///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>> {
+///         // `this` is a live reference, so the refcount cannot drop below 1, and it can only
+///         // grow through an existing reference. Thus observing 1 means that `this` is the only
+///         // reference to the object. The `Acquire` ordering synchronizes with the release
+///         // decrements of references dropped on other threads.
+///         if this.refcount.as_atomic().load(Acquire) == 1 {
+///             // SAFETY: The `Foo` is valid and `this` holds the only reference to it, so we
+///             // can transfer this last reference to the returned `Owned<Foo>`.
+///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+///
+///     fn into_shared(this: Owned<Self>) -> ARef<Self> {
+///         // SAFETY: An `Owned<Foo>` holds the unique reference (refcount 1), which we transfer to
+///         // the new `ARef`.
+///         unsafe { ARef::from_raw(Owned::into_raw(this)) }
+///     }
+/// }
+///
+/// impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: Using `dec_ref()` from [`RefCounted`] to release is okay, as the refcount is
+///         // always 1 for an [`Owned<Foo>`].
+///         unsafe { Foo::dec_ref(this) };
+///     }
+/// }
+///
+/// let foo = Foo::new()?;
+/// let foo = ARef::from(foo);
+/// {
+///     let bar = foo.clone();
+///     assert!(Owned::try_from(bar).is_err());
+/// }
+/// assert!(Owned::try_from(foo).is_ok());
+/// # Ok::<(), Error>(())
+/// ```
+pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
+    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`] if that is the case.
+    /// Otherwise it returns again an [`ARef`] to the same underlying object.
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>>;
+
+    /// Converts the [`Owned`] into an [`ARef`].
+    fn into_shared(this: Owned<Self>) -> ARef<Self>;
+}
+
+impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
+    type Error = ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
+    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In case the [`ARef`] is not
+    /// unique, it returns again an [`ARef`] to the same underlying object.
+    #[inline]
+    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
+        T::try_from_shared(b)
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index ae76bd9b6c1c..f12d091faafa 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -23,6 +23,10 @@
     ops::Deref,
     ptr::NonNull, //
 };
+use kernel::types::{
+    OwnableRefCounted,
+    Owned, //
+};
 
 use crate::{
     prelude::*,
@@ -40,7 +44,10 @@
 /// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
 /// internal reference count and provides only shared references. If unique references are required
 /// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
-/// [`Owned<Self>`](crate::types::Owned).
+/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
+/// [`OwnableRefCounted`] allows to convert between unique and
+/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
+/// [`ARef<Self>`]).
 ///
 /// # Safety
 ///
@@ -196,6 +203,13 @@ fn from(b: &T) -> Self {
     }
 }
 
+impl<T: OwnableRefCounted> From<Owned<T>> for ARef<T> {
+    #[inline]
+    fn from(b: Owned<T>) -> Self {
+        T::into_shared(b)
+    }
+}
+
 impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index f97b8ab6dad5..65593c5c5fab 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -21,6 +21,7 @@
 pub use crate::{
     owned::{
         Ownable,
+        OwnableRefCounted,
         Owned, //
     },
     sync::aref::{

-- 
2.51.2



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C13D9048;
	Thu,  4 Jun 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604067; cv=none; b=d2cc4lLg9qLEdu0BG/uNY4IjPJ5C/pM3PZJjcLnOxmZNNiAvL8P4ciW7mjpkB/S9hR7Y6KTgkM4NGJo8oYa8hOEQ4cry2/LytR8+dVzU8MTTuvycXlJEniLl2XOqTe0fsrjPpjbIX2jvZ5GsN2xAn5qJK4MNU43WS1dHPj1xphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604067; c=relaxed/simple;
	bh=Hg680IEqr7v0RXM8wFbgsXk2c2pTY227EWWpn05Z3d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQPcHkKRFQh4FYLSqGIXvWth2HMIHtND/6w6H+MWtZCzlGxKchNhVOI1AvZeAUtpD27Fn6NCnrClVokL42ED2NvbRg01pzNXSN3TIyKQfSnAvjScW/dJC0ORXzeDuETox2NXD54dWzii7yolKsRXp8X/rdSejC0rLJEVphxUDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqm/CGit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqm/CGit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BE1F00898;
	Thu,  4 Jun 2026 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604065;
	bh=wHDP8KrP4ENQIKP1t0z9YatTAObeBB7wKfKH68vjOXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lqm/CGitNYnPbP6Mqjym4bObZ0Xd7TttuPt4yzN9DyK1s7pzp5bDS4Ut6WmWsgcW7
	 Br9DqJJwCbM6kHoi7+G7XAihST+dc047ZlQpOuVS6BtW10FN+Efa+3byBcu0udW3O7
	 8MCZ8i0bL1mj/vhtwE0+cEmvQHwt1V6C5YojYGeqTgNWEv6CNDljcpTZx1XLALQXDT
	 O4YqJ7dEPYsbbWGOTEWNk5vbMQXJO9GZIqjOFskKbDwtpV5VeAkJlF8zC5Mj5o8XhW
	 XQB5Hq91xaT9+2dToC3YfbxtBRAOuGJOdctWiEU+zGSdqu7YG2YSXisrHgxSs+2REo
	 lGoLkhmILZBtQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:21 +0200
Subject: [PATCH v17 09/10] rust: Add `OwnableRefCounted`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-9-7b4c3d2930b9@kernel.org>
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
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9300; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=B2PMU7iUM8MeGMk4qqOCmUPfmlEfQ1FXjOI3V19ZFVo=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvuCHC8F7WwT17RsGVrQwmcDjE9XnhTBl5G0
 /UWl8J5lDSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb7gAKCRD6UCkIqsW9
 0D94D/9rqndYQ7hbvG1gd74fmkjYs06Zjp+poWTO4HjCKos3yChMUlBeMbHFGVvmwafHT4tZTov
 0H5EQLKYbEQrGgkUHwGakY0pEheF7j0jD8/QNAy7TfqO8/tchPgbLX5CHbJ85xb2FbwsXcKbxkN
 RkQOtSIfRIgqRmCnz+IbfPrgB9o8qcBQQwBccLtqYXmo0FpjvugCZPV3iF2Sag0UHGZcj9SgYk0
 ih99KJwjnvABG1ii0lxsCyYY7sKKvACJdiaT/qRQ6HcaZj61Hz1fwiepkf/NzgYAemwK077dczz
 Q9bIlWGdcqUmHglB/+KjHpJqt6ZFGvn4nfZEJ3BdxU0bnQbYNVD2EupHjMODL0hlCKbRY/084lL
 KZe723EfoB2xv7sv2KkpwxdjAlmGUAgOads3JTdMqZ8YOpoeCzHRsXqCNKq0Id+PZJyWRky7kn1
 TXzUWPse1ZM93uIhD5P67ls6gLGxVRLhfOLHCIbVmYlE3stV56uw+h8Ql2IGF9IbaVbM9vv5hVW
 mbw6w73Whj5Fr/0Ced2Ma5ZEXI5za+Ar5kgQl327xaiDiE2wSGhBV+5DO/HjHlCR+8+rs/kAtja
 N3RfqM+1Y5sHe363U0OHL9yZ5oVDor+Rwz2MbZkI2Z+TjDVkDJDxcDIWmdqJoriU1Xu9NondLEh
 7iuqE6PRbIZj7CA==
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
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs     | 138 +++++++++++++++++++++++++++++++++++++++++++++--
 rust/kernel/sync/aref.rs |  16 +++++-
 rust/kernel/types.rs     |   1 +
 3 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index bedd4fef84fa..9db0daab2225 100644
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
@@ -231,3 +237,125 @@ unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a>
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
+/// # use core::cell::Cell;
+/// # use core::ptr::NonNull;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::sync::aref::{ARef, RefCounted};
+/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
+///
+/// // An internally refcounted struct for demonstration purposes.
+/// //
+/// // # Invariants
+/// //
+/// // - `refcount` is always non-zero for a valid object.
+/// // - `refcount` is >1 if there is more than one Rust reference to it.
+/// //
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>> {
+///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result = KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
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
+/// // SAFETY: We increment and decrement each time the respective function is called and only free
+/// // the `Foo` when the refcount reaches zero.
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: By requirement on calling this function, the refcount is non-zero,
+///         // implying the underlying object is valid.
+///         let refcount = unsafe { &this.as_ref().refcount };
+///         let new_refcount = refcount.get() - 1;
+///         if new_refcount == 0 {
+///             // The `Foo` will be dropped when `KBox` goes out of scope.
+///             // SAFETY: The [`KBox<Foo>`] is still alive as the old refcount is 1. We can pass
+///             // ownership to the [`KBox`] as by requirement on calling this function,
+///             // the `Self` will no longer be used by the caller.
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+/// }
+///
+/// impl OwnableRefCounted for Foo {
+///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>> {
+///         if this.refcount.get() == 1 {
+///             // SAFETY: The `Foo` is still alive and has no other Rust references as the refcount
+///             // is 1.
+///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+/// }
+///
+/// impl Ownable for Foo {
+///     unsafe fn release(&mut self) {
+///         // SAFETY: Using `dec_ref()` from [`RefCounted`] to release is okay, as the refcount is
+///         // always 1 for an [`Owned<Foo>`].
+///         unsafe{ Foo::dec_ref(NonNull::new_unchecked(self)) };
+///     }
+/// }
+///
+/// let foo = Foo::new()?;
+/// let mut foo = ARef::from(foo);
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
+    #[inline]
+    fn into_shared(this: Owned<Self>) -> ARef<Self> {
+        // SAFETY: Safe by the requirements on implementing the trait.
+        unsafe { ARef::from_raw(Owned::into_raw(this)) }
+    }
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
index 818c84fa923a..68d31f43e674 100644
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
 
 /// Types that are internally reference counted.
 ///
@@ -35,7 +39,10 @@
 /// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
 /// internal reference count and provides only shared references. If unique references are required
 /// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
-/// [`Owned<Self>`](crate::types::Owned).
+/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
+/// [`OwnableRefCounted`] allows to convert between unique and
+/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
+/// [`ARef<Self>`](crate::types::Owned)).
 ///
 /// # Safety
 ///
@@ -188,6 +195,13 @@ fn from(b: &T) -> Self {
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
index 9b96aa2ebdb7..f43c091eeb8b 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -14,6 +14,7 @@
 pub use crate::{
     owned::{
         Ownable,
+        OwnableRefCounted,
         Owned, //
     },
     sync::aref::{

-- 
2.51.2



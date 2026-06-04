Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44D3D8907;
	Thu,  4 Jun 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603998; cv=none; b=IFF0ihZvIzhHd2Z4aB2EQkAn9qcCXbQaA8sGn3rDJjflUpsKMCS++nfWFxH2V1KKSqUSN4/QsS7VMPLabh9WCYJchpO3IorRSD1dk0/ce4ey4AF/vgdfl8PtePbrIT36AqDGaU/kazsR0g2F5oThiapcKTn9jQhMx22+6vxBsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603998; c=relaxed/simple;
	bh=1O8hcxxp/kMcvtu9yjMVb2lB/y685VrmQp32UNfHOYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhSng2Kv51OuGtMs41pxXmevrJI7gszt7CqSxNyBZq6lAXC4zyyUnUAbfZrDKl66nCnfJxPrFpBZ/vutDtDIZd7GnjmcLUxuTl6245O4S67d4/pZlQsyUSk2cd/VtKWDQLRO+xvJCXwOH8BBqEGnerYyKXfaNN9spQ7LHdibp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7+DGx4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7+DGx4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B489B1F00893;
	Thu,  4 Jun 2026 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603994;
	bh=FyqbifIs0gEb+brR0HRbFPYYe8b52/vPAxEVwbskZ2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d7+DGx4kRvBF22JK7YfD6UvK3MZe3cZ/G1pHGIQ/3H8UfQSOg7Ieg0mx1bvLq8xYE
	 stPU76+2J+5djPEJUrJ1IJm9wxEsW9K1zFRweb/+eze4ZwWaK8HxgXzLBfo8ZCB7ex
	 E6JVc6TzkG/cwill6Ag6itwfXLT+HjIzQS4e2j4JAEXcKLJ1ea2ES/Y2Aixk+6YMcV
	 +zPKqF7gU8duISScX8HUFNycYk6Q9tClZy4tbVRZfiMySzFe/DI/+aarw/vw5bQ+zy
	 sK5VJR26InjGBY29wYKn90akDlQ9bsTfZNRrgTc8VLd0dHkUdyQeYrz3ziSwEvPitl
	 Du+Cpa9aaWiug==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:14 +0200
Subject: [PATCH v17 02/10] rust: types: Add Ownable/Owned types
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
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
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10553;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=ofZDFIhDjpLPpUbpvtXo6zWuRmODfjHMDH0JWHuSFdY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvofKBkFboGfACnM0viGjPeiixT1NxDQcbNU
 MsW74xazMuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb6AAKCRD6UCkIqsW9
 0DEkD/4gf7Ho/vS4edp6caiLITOv/bLkSQN5bDrgSo/Dqw6VjWYilBwVVAiLblnteDI9tSnZAz4
 evcQDaMvY7IrsQilUAtM8OixDbWtvlR+x/eslY/TZ3XhvbZhSLsMnQ8UkkHAOto8tCBTvl53I5a
 G8FmcHac+ptW26zaW0XNDXoedp4ZU4w/MElpuhCWopnNx578V/5+/Kd0++KK9AJdewxigY+O09R
 XKMuyGtiteZwpDtUCDrndWu6LUELJFBk8DlTERSF7P+OV3b/Z3bb9nsbkjC2dNa6SG0WmIUu3OP
 QeyC4cPcKPSTzIGcS8ecFZzwJp5ChQN+O3DEGMwV9NTEV9WrrGRGEeqcW05Jd8akGmDILrPT9uw
 7PPhGLGSGJvPJ94joJDKzhWeGGQKN4Ypt7eKVQMrFp9Ydul9sXRxfanYsRd7xUsVCJsXHe0qRhw
 axz+zRqxcYG96KESp5w1DAN0DXXjeDg5Tip6/Di/vvvoZrcnl66TJxO8IaBQoKUir/7KAjhvDKh
 6sAopNMKeJY/bAeb+sNVhiaT50U9xhsI6ME1e6JBNS2dFoe68qSHt4tpl0mNEtS+P2FRcWnIkw8
 9wvr6lwo2ivn1lb6ppIFBpmHrqozyBAsxUj/60/7Ugd0+pXRJQrGpGnYAMRg8JMKgAIEIQN+hgo
 Di9hhF085JUUMWg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Asahi Lina <lina+kernel@asahilina.net>

By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
(typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
`AlwaysRefCounted`, this mechanism expects the reference to be unique
within Rust, and does not allow cloning.

Conceptually, this is similar to a `KBox<T>`, except that it delegates
resource management to the `T` instead of using a generic allocator.

[ om:
  - Split code into separate file and `pub use` it from types.rs.
  - Make from_raw() and into_raw() public.
  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
  - Usage example/doctest for Ownable/Owned.
  - Fixes to documentation and commit message.
]

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
[ Andreas: Updated documentation, examples, and formatting. Change safety
  requirements, safety comments. Use a reference for `release`. ]
Reviewed-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 187 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/aref.rs |   5 ++
 rust/kernel/types.rs     |  11 +++
 4 files changed, 204 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d..d07759eec799 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -100,6 +100,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod owned;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 000000000000..456e239e906e
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unique owned pointer types for objects with custom drop logic.
+//!
+//! These pointer types are useful for C-allocated objects which by API-contract
+//! are owned by Rust, but need to be freed through the C API.
+
+use core::{
+    mem::ManuallyDrop,
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    pin::Pin,
+    ptr::NonNull, //
+};
+
+/// Types that specify their own way of performing allocation and destruction. Typically, this trait
+/// is implemented on types from the C side.
+///
+/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
+/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
+/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
+/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
+///
+/// Note: The underlying object is not required to provide internal reference counting, because it
+/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
+/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`Ownable`] and its usage with [`Owned`] looks like
+/// this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// # use core::cell::Cell;
+/// # use core::ptr::NonNull;
+/// # use kernel::sync::global_lock;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::types::{Owned, Ownable};
+///
+/// // Let's count the allocations to see if freeing works.
+/// kernel::sync::global_lock! {
+///     // SAFETY: we call `init()` right below, before doing anything else.
+///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
+/// }
+/// // SAFETY: We call `init()` only once, here.
+/// unsafe { FOO_ALLOC_COUNT.init() };
+///
+/// struct Foo;
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>> {
+///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result = KBox::new(
+///             Foo {},
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result = KBox::into_non_null(result);
+///         // Count new allocation
+///         *FOO_ALLOC_COUNT.lock() += 1;
+///         // SAFETY:
+///         //  - We just allocated the `Self`, thus it is valid and we own it.
+///         //  - We can transfer this ownership to the `from_raw` method.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// impl Ownable for Foo {
+///     unsafe fn release(&mut self) {
+///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
+///         // by requirement on calling this function.
+///         drop(unsafe { KBox::from_raw(self) });
+///         // Count released allocation
+///         *FOO_ALLOC_COUNT.lock() -= 1;
+///     }
+/// }
+///
+/// {
+///    let foo = Foo::new()?;
+///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
+/// }
+/// // `foo` is out of scope now, so we expect no live allocations.
+/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
+/// # Ok::<(), Error>(())
+/// ```
+pub trait Ownable {
+    /// Tear down this `Ownable`.
+    ///
+    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
+    /// include freeing the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
+    /// be transferred to the `release` method.
+    unsafe fn release(&mut self);
+}
+
+/// A mutable reference to an owned `T`.
+///
+/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
+/// dropped.
+///
+/// # Invariants
+///
+/// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
+/// - The `T` value is pinned.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new instance of [`Owned`].
+    ///
+    /// This function takes over ownership of the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `ptr` points to a valid instance of `T`.
+    /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
+    #[inline]
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: By function safety requirement we satisfy the first invariant of `Self`.
+        // We treat `T` as pinned from now on.
+        Self { ptr }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not drop the underlying `T`. When this function returns, ownership of the
+    /// underlying `T` is with the caller.
+    #[inline]
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+
+    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
+    #[inline]
+    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        let unpinned = unsafe { self.ptr.as_mut() };
+
+        // SAFETY: By type invariant `T` is pinned.
+        unsafe { Pin::new_unchecked(unpinned) }
+    }
+}
+
+// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the underlying `T` is [`Send`],
+// because of the ownership invariant. Sending an [`Owned<T>`] is equivalent to sending the `T`.
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the underlying `T` is [`Sync`],
+// because of the ownership invariant. Sending an [`&Owned<T>`] is equivalent to sending the `&T`.
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + Unpin> DerefMut for Owned<T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By existence of `&mut self` we exclusively own `self` and the underlying `T`. As
+        // we are dropping `self`, we can transfer ownership of the `T` to the `release` method.
+        unsafe { T::release(self.ptr.as_mut()) };
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 9989f56d0605..4ee5fac0e0b6 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -29,6 +29,11 @@
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
 /// instances of a type.
 ///
+/// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
+/// internal reference count and provides only shared references. If unique references are required
+/// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
+/// [`Owned<Self>`](crate::types::Owned).
+///
 /// # Safety
 ///
 /// Implementers must ensure that increments to the reference count keep the object alive in memory
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4329d3c2c2e5..4aec7b699269 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,6 +11,17 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
 
+pub use crate::{
+    owned::{
+        Ownable,
+        Owned, //
+    },
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    }, //
+};
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and

-- 
2.51.2



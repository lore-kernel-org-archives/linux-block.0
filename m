Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838910;
	b=G/6q22AMM5Ioe63n55FCxGL5Y3SfGojBHjHY3Gyb9WEg61DZzeS0UKUXn4hXdblysU9L
	 ZNNcD2e+tzj/Lni56h79DooVDP3yqszjQ7AO7RAIr+WjlR/KDrwQkoPpM6kgP2DQm/QLC
	 2UmPRhgEbzajjg+Vm9vT+6INEFGoLPcCMqBSO4kO9P2myuyTqm3eY9ZBQHiNzv6WiNU/f
	 vzM38ACglggYB4EQui7o8pkxrFDkMwOPeR7/TOthLSt0r8IEqQe6f7OwNtUo54ftKE9DT
	 2bJx0xZ0yTSKq4cKCDz7TygJSOC1+PF+cAKKyK6HCKMt3G9UGoAALb3VkqSlegTGqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838910;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bJE9cg4UfrYfnBkt+rjYwJS5VmysvIBAf/LtRPIeyp8=;
	b=fME+F9Qo3iw+tQMdig92B0wkZsbZho2XPW5nBLkXpU9ad5sw4zbydrhIKVq42yIBtBSJ
	 5/jHkhgaP3MfVEJP+JiJan0dn6/W+Chp/FY2PJ11COKcbbYPjKQNE1QrhI1ZBl55iTvD+
	 fwsK3sIDm4WoHAXPdWtThRYYoYeTbpgfNeNyDnsoONQApyJ3ZN3HanleEs/M/oCfRXQ/o
	 KIjsRaogj4YyUx/YBANWMtBJDXIdrYlVp/1A30ZUy/Ox5E+f9bM37/QkQg7fu8WcgVGxa
	 3c4zeFTY81lq6TyabDqgUJEWgy3Z/J1V5xOvWB9Ld7Kxjw1cfKf5XQYKKsmQcSl4y0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BcSZN7/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEE606A32C;
	Mon, 16 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcSZN7/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669AD1F000C4;
	Mon, 16 Nov 2026 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838910;
	bh=bJE9cg4UfrYfnBkt+rjYwJS5VmysvIBAf/LtRPIeyp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BcSZN7/enrgRWw4MM6iCqT5DSAFqsFzMzx/dbidZjgERppNLRKKtsiha0moK7QLzq
	 agm3BuwAASDw2GWTXgA9ES/rQrMxgITRcE9D3oWdZHhjVfrod6yzwwB96RHvVIJ1r2
	 5bswlOYRTUaZCDoTy1hS3HybHnmaIXrQizmAEKOGiWKoTDFyk+3rYaxR9ujkmxKw4L
	 VFPUbNk7lVeStn6bLIJZ7iv6TO4froRfnkRMmIXsoSFBM5AwBwYk0BV/0rarXR1HIn
	 nLXmf10RgzbmDoCEri/L2DhXsM+eOf1xAQLiWLynF8dKeP8ulhK3IX2c7iH5LrnSzr
	 UCTvabdKDrW1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Nov 2026 15:20:59 +0100
Subject: [PATCH v22 2/5] rust: types: Add Ownable/Owned types
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-unique-ref-v22-2-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
In-Reply-To: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
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
 Johan Hovold <johan@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Markus Probst <markus.probst@posteo.de>, Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16660;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=48t/wLyGqLRL7lnIER6RcDkge9+8SlAdjlk+2AzCIz8=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq+xFSRNysy44W4zSWKRaNnn7DvG6xS16HtcB7M
 9ClnR9UYeCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavsRUgAKCRD6UCkIqsW9
 0DWED/9XsrMOd8kd3BbagUeok0sOqzFhFraoRvlMKUxX8jp9dhUlj5XM49gh22oLMdCCG6P2O8+
 T4BoMQ6xf5OeFQ7kMEhh4I5qwpDJFDwjiHFs+zkGftu8E99z55+cIm9EA7cOUvWX9tLCQBQPobX
 EsshgUmD+dotWdA0BiCvMLkct6eXvu0syJH2PayNgsCvCbp5HfUdrJaw2ng9OPnwfLXC+3D5czd
 bHEo46JFFwwQkITvXw8xelKQ1XTDBM3s6DJELvTmfQKIRWxy8jMOIT3Zu9XOpATMcWggtTz+HAi
 wF34v7317MErLqHU30w6vP+4F7vkq9NW/lCkbvLcbm4TJ5GSKZxxm5rGSdgdl1riUqz0hKX9j0W
 IVxA4516rDaqwFnudojawCnAnVLCF2IH6wSTOh9U6lhsE1+KuQm0nKk9kZ3NmeYHUwaoKlUNw4a
 iuP9SWoaXnJPX/LkjjZ0lZq1gSnnPRVopYXN5azkxgsmajtez8b+j9Boyj++4nH0tOLPixnTZP2
 T8iYFHTE2AeQxGf2OwPRkSm5KKdlfJZ4G6b6Nm1BHziVgJ0iFmV3CdStV2yvb5AQ71j4mVeSAlj
 Ue4bAAA9klYFaxdlV9O+XeVM8/ZXPeP6vl0dsxlWq8SajNiHUAAiqYdHYMbPjwC62e2kff3kj+I
 KB2/CHBdzpxJo4Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Asahi Lina <lina+kernel@asahilina.net>

By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
(typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
an `ARef<T>`, an `Owned<T>` cannot be cloned. At most one `Owned<T>` exists
for an object at any time, and the type `T` decides whether other
references to the object may exist together with it.

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
[ Andreas: Updated documentation, examples, and formatting. Change safety
  requirements, safety comments. Let `T` decide whether other references
  may exist together with an `Owned<T>`. ]
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 274 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/aref.rs |   5 +
 rust/kernel/types.rs     |   5 +
 4 files changed, 285 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..fd0f9bf484e4 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -111,6 +111,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod owned;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 000000000000..51da9bc7e1f4
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,274 @@
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
+/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type.
+///  - This is useful when it is desirable to tie the lifetime of an object reference to an owned
+///    object, rather than pass around a bare reference.
+///  - [`Ownable`] types can define custom drop logic that is executed when the owned reference
+///    of type [`Owned<_>`] pointing to the object is dropped.
+///
+/// Note: The underlying object is not required to provide internal reference counting, because it
+/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
+/// [`AlwaysRefCounted`](crate::sync::aref::AlwaysRefCounted) should be implemented.
+///
+/// # Access model
+///
+/// An [`Owned<Self>`] is a unique handle: at most one [`Owned<Self>`] exists for an object at any
+/// time. There are two kinds of references to the object to consider, and they are governed by
+/// different rules:
+///
+///  - References that borrow the [`Owned<Self>`]. An [`Owned<Self>`] hands out `&Self` and
+///    `Pin<&mut Self>` to safe code, and also `&mut Self` if `Self` is [`Unpin`]. These references
+///    borrow the [`Owned<Self>`], so the borrow checker ensures that they do not outlive it and
+///    that they follow the usual aliasing rules with respect to each other.
+///  - Other references. These are references to the object that do not borrow the
+///    [`Owned<Self>`], such as an `ARef<Self>`, or a `&Self` obtained from one. The borrow checker
+///    does not relate these to the [`Owned<Self>`].
+///
+/// Whether other references to an object may exist together with the [`Owned<Self>`] is decided by
+/// the implementer of this trait:
+///
+///  - A type may forbid all other references to an object for as long as an [`Owned<Self>`] to
+///    the object exists. For such a type, an [`Owned<Self>`] is the exclusive owner of the object.
+///  - A type may allow other references, such as `ARef<Self>`, to exist together with an
+///    [`Owned<Self>`]. For such a type, an [`Owned<Self>`] has exclusive access only to the parts
+///    of the object that the type reserves for it.
+///
+/// The borrow checker cannot ensure that references that borrow the [`Owned<Self>`] are sound in
+/// the presence of other references. This is the responsibility of the code that creates an
+/// [`Owned<Self>`], see [`Owned::from_raw`]. Note that a `&mut Self` must never alias another
+/// reference, so a type that is [`Unpin`] cannot allow other references to exist together with an
+/// [`Owned<Self>`].
+///
+/// A type that allows other references to exist together with an [`Owned<Self>`] must place all
+/// state that is accessible through those references inside [`Opaque`](crate::types::Opaque) or
+/// [`UnsafeCell`](core::cell::UnsafeCell). A `&Self` asserts that state outside of these wrappers
+/// is not mutated while the reference is live, so such state must not be mutated through the
+/// [`Owned<Self>`]. In addition, a `Pin<&mut Self>` handed out by an [`Owned<Self>`] may only
+/// alias other references because the compiler does not treat a mutable reference to a type that
+/// is not [`Unpin`] as unique. The intent is to express this with `UnsafePinned` instead, once it
+/// is stable.
+///
+/// Implementers should document, as a type invariant of `Self`, which other references may exist
+/// together with an [`Owned<Self>`], and why access through the [`Owned<Self>`] is sound.
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
+/// // Let's count the allocations to see if freeing works.
+/// kernel::sync::global_lock! {
+///     // SAFETY: we call `init()` right below, before doing anything else.
+///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
+/// }
+/// // SAFETY: We call `init()` only once, here.
+/// unsafe { FOO_ALLOC_COUNT.init() };
+///
+/// // An exclusively owned struct for demonstration purposes.
+/// //
+/// // # Invariants
+/// //
+/// // `Foo` does not allow other references to exist together with an `Owned<Foo>`: while an
+/// // `Owned<Foo>` exists, it is the only reference to the object.
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
+///         //  - We just allocated the `Self`, thus it is valid until we free it in `release`.
+///         //  - No other pointer to the allocation exists, so this is the only `Owned<Foo>` and
+///         //    no other reference to the `Foo` exists. Thus access through the `Owned<Foo>` is
+///         //    sound, and it can be used from any thread that `Foo` can be used from.
+///         //  - The `Foo` is not moved until it is freed in `release`.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
+///         // by requirement on calling this function.
+///         drop(unsafe { KBox::from_raw(this.as_ptr()) });
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
+    /// include freeing the underlying object, handing it back to the subsystem that allocated it,
+    /// or dropping a reference count.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `this` points to a valid `Self`.
+    /// - They hold the ownership of the `Self` pointed to by `this` that is represented by the
+    ///   unique [`Owned<Self>`], and that this ownership is transferred to the `release` method.
+    /// - `this` is not used after calling this method, as the underlying object may have been
+    ///   freed.
+    ///
+    /// `this` is pinned and implementers of this method must observe this constraint.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// A unique owning handle to a `T`.
+///
+/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
+/// dropped.
+///
+/// Whether other references to the underlying `T` may exist together with an [`Owned<T>`] is
+/// decided by `T`, see the *Access model* section of [`Ownable`].
+///
+/// # Invariants
+///
+/// Until `T::release` is called:
+/// - `ptr` points to a valid `T`.
+/// - This is the only `Owned<T>` for the underlying `T`.
+/// - The `T` value is pinned.
+/// - It is sound to create a `&T` or a `Pin<&mut T>` to the underlying `T` and to hand it to safe
+///   code, for the duration of a shared or mutable borrow of this `Owned<T>` respectively. If `T`
+///   is [`Unpin`], the same applies to a `&mut T`. This holds in the presence of all the references
+///   that `T` allows to exist together with an `Owned<T>`.
+/// - If `T` is [`Send`], it is sound to use this `Owned<T>` from, and to drop it on, another thread
+///   than the one it was created on. If `T` is [`Sync`], it is sound to use shared references to
+///   this `Owned<T>` from multiple threads concurrently.
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
+    /// Callers must ensure that, until `T::release` is called:
+    /// - `ptr` points to a valid instance of `T`.
+    /// - The returned `Owned<T>` is the only `Owned<T>` for the underlying `T`.
+    /// - The `T` pointed to by `ptr` is treated as pinned from this call on: unless `T: Unpin`, it
+    ///   must not be moved for the rest of its lifetime, including after the pointer is recovered
+    ///   with [`Owned::into_raw`].
+    /// - No reference to the underlying `T` exists, or is created, other than the references that
+    ///   `T` allows to exist together with an `Owned<T>`. In the presence of those references, it
+    ///   must be sound to create a `&T` or a `Pin<&mut T>` to the underlying `T` and to hand it to
+    ///   safe code, for the duration of a shared or mutable borrow of the returned `Owned<T>`
+    ///   respectively. If `T` is [`Unpin`], the same applies to a `&mut T`.
+    /// - If `T` is [`Send`], it is sound to use the returned `Owned<T>` from, and to drop it on,
+    ///   another thread than the current one. If `T` is [`Sync`], it is sound to use shared
+    ///   references to the returned `Owned<T>` from multiple threads concurrently.
+    #[inline]
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The function safety requirements match the invariants of `Self`.
+        Self { ptr }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not drop the underlying `T`. When this function returns, ownership of the
+    /// underlying `T` is with the caller.
+    ///
+    /// Note that the returned pointer is pinned.
+    #[inline]
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+
+    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
+    #[inline]
+    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: By the type invariants, `ptr` points to a valid `T` and it is sound to create a
+        // mutable reference to the `T` for the duration of the mutable borrow of `self`, given that
+        // we only hand it out as a `Pin<&mut T>` below.
+        let unpinned = unsafe { self.ptr.as_mut() };
+
+        // SAFETY: By type invariant `T` is pinned.
+        unsafe { Pin::new_unchecked(unpinned) }
+    }
+}
+
+// SAFETY: By the type invariants, it is sound to use and drop an [`Owned<T>`] on another thread
+// when the underlying `T` is [`Send`]. For a `T` that does not allow other references to exist
+// together with an [`Owned<T>`], sending an [`Owned<T>`] is equivalent to sending the `T`.
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: By the type invariants, it is sound to use shared references to an [`Owned<T>`] from
+// multiple threads when the underlying `T` is [`Sync`]. A [`&Owned<T>`] only gives access to a
+// `&T`, so sending a [`&Owned<T>`] is equivalent to sending the `&T`.
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariants, `ptr` points to a valid `T` and it is sound to create a
+        // shared reference to the `T` for the duration of the borrow of `self`.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + Unpin> DerefMut for Owned<T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: By the type invariants, `ptr` points to a valid `T` and, as `T` is `Unpin`, it is
+        // sound to create a mutable reference to the `T` for the duration of the mutable borrow of
+        // `self`.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, `ptr` points to a valid `T` and `self` is the only
+        // `Owned<T>` for it. As we are dropping `self`, we can transfer the ownership it represents
+        // to the `release` method, and we do not use `ptr` afterwards.
+        unsafe { T::release(self.ptr) };
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 9983ee085248..1876e40c76df 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -39,6 +39,11 @@
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
index 132dd428c1f6..b23e1d60cdd6 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -18,6 +18,11 @@
     ForLt, //
 };
 
+pub use crate::owned::{
+    Ownable,
+    Owned, //
+};
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and

-- 
2.54.0



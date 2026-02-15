Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A672DF6E9;
	Sun, 15 Feb 2026 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199106; cv=none; b=bIngt387DcWCBcHT0nV+uL9b/EymlpVz98zLTXjYpmO+81LgRYJFpWtu7cRXuNhNZjhDylIltErUZwz94IXZYqziA0N/onCZnMp7q9Mv/Qr2t4GIzYgut0EtfRauhuhyW7V3hIezUTtj1y+NecuQIJoeKRkx0AB7zh87kLb3BUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199106; c=relaxed/simple;
	bh=nKDJESXMMdAbXJmbQH/TDKLxr1LGgof53q+XTMeqr04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4S/XefkW8wlAy1CZl0DopAymOExDn8lVhtIExcsIlkW3gf2HRoyCGWmu5TjO/oG9Bdyl2ctycz1ax/ZmpKtJCzcU8DF4EsEApfLw4iPmEFPKI8HgBYsqEej3ZwUMQrgrPUvyQozdAX02dtNyJp4eSwfcAa4SeHwp2qQqdnfZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu0XHhmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu0XHhmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF990C4CEF7;
	Sun, 15 Feb 2026 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199106;
	bh=nKDJESXMMdAbXJmbQH/TDKLxr1LGgof53q+XTMeqr04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fu0XHhmJy1gX/cIRnvFxxJ+Y6oO6mmRvqlrUbBDEAj7/MDVFRt8wHqVsDplzrIE5T
	 5EOS9gGCApRYbQcciwZ07npml4Uvrks09ds2DcHMJ1tcvhe4fNjl6tcbYAWqWtUl76
	 KnoZ76AcPMBYHrXAnJPaTJf9TmwRH0MdLxin18ihIcwxPV6Pcv5IYBq78fTPOTX3QR
	 aloupiIdvfV5i1HQMGoQkNwR4OLzgwkaab1uWkDyTn6wtKtil5GQg+U3YmXLcAlmZc
	 Jb/apVlrYiUjpbWdaOHC4gwTXpZtwM3V0S+fD1WZO/cQ2nNhTcNDvFbYb6OCfQ03LS
	 x2WLZhUmvGAhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:53 +0100
Subject: [PATCH 06/79] block: rust: add `Request` private data support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-6-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8672; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nKDJESXMMdAbXJmbQH/TDKLxr1LGgof53q+XTMeqr04=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklghxER7z4eSTdEgWu7X/lQaa701iP5OWF88X
 2vR1dp8TKmJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYIQAKCRDhuBo+eShj
 d5E4D/0WP5q39O/TWBj0zA73T1cdUnagb39/g6S+WLyQMwhG/g/V+RteReTcHJduUiBc1vZIWc+
 liak4eD/kewjxEn34O7jS0CPyMcS532TA4dhaGsMjw6ClQDzI/iqw6HMi/JZOEq3Dbkx7xk8htA
 sKWAUpXf3+xxGuF9t/Nc/OxHivpjIsArUeX5fz5anIMuwKMNQtWx3hCFMbXUDxr/VuJ8f5iqKBb
 ZdSonYSCcXir9fXGDpPV54nM18ZZja6RsoZTuNVKzbJO7YVzWIfFyMM38/Gr1XExlzehFsp33lU
 Lj97Q01XDL2fxwgY7ru1gJ3R+f+hmrBNdLQOQKECNVx/4UbBGt69bfO1BKXk82zHionAFBJXZnN
 0wCOIVvqO2ecr3ZjQxKACU2XahihjhlnMyOa2u3NM7T72+D2fpV6PwB8awhuKMIC7oXyjsPMLBm
 xYfaURbuvtahZg9e2jLbtkf/bvg7hiYdYB4InVbQ2SrUyJYUu1rI2jc/Zzfohdoi/+QHFc+01Kp
 w1KhO+jQDsqeaf7qKbSybYPtkmK7BmGdnjK2xB5LtkyJHL+IXkZ7hTY8DCgvUp6Dnr6DsTZPBmp
 ETjeKMMkQ0b+BhUbxUZ7JBnWGuVOJl1pyKmN5HBFFl7FrmMbOP17swDr2zZ4tkL2aaalrIDXXMt
 J36cFJ6YWjJ1Ahw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

C block device drivers can attach private data to a `struct request`. This
data is stored next to the request structure and is part of the request
allocation set up during driver initialization.

Expose this private request data area to Rust block device drivers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  5 +++++
 rust/kernel/block/mq.rs            |  6 ++++++
 rust/kernel/block/mq/operations.rs | 24 +++++++++++++++++++++++-
 rust/kernel/block/mq/request.rs    | 24 +++++++++++++++++++-----
 rust/kernel/block/mq/tag_set.rs    |  2 +-
 5 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6a7f660d31998..065639fc4f941 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -134,6 +134,11 @@ struct QueueData {
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = KBox<QueueData>;
+    type RequestData = ();
+
+    fn new_request_data() -> impl PinInit<Self::RequestData> {
+        pin_init::zeroed::<Self::RequestData>()
+    }
 
     #[inline(always)]
     fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool) -> Result {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index b8ecd69abe980..a285b753ada88 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -69,8 +69,14 @@
 //!
 //! #[vtable]
 //! impl Operations for MyBlkDevice {
+//!     type RequestData = ();
 //!     type QueueData = ();
 //!
+//!     fn new_request_data(
+//!     ) -> impl PinInit<()> {
+//!         pin_init::zeroed::<()>()
+//!     }
+//!
 //!     fn queue_rq(_queue_data: (), rq: Owned<Request<Self>>, _is_last: bool) -> Result {
 //!         rq.end_ok();
 //!         Ok(())
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 3dea79d647ff7..cd37b939bbf30 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -13,6 +13,7 @@
     types::{ForeignOwnable, Owned},
 };
 use core::{marker::PhantomData, ptr::NonNull};
+use pin_init::PinInit;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
 
@@ -28,10 +29,24 @@
 /// [module level documentation]: kernel::block::mq
 #[macros::vtable]
 pub trait Operations: Sized {
+    /// Data associated with a request. This data is located next to the request
+    /// structure.
+    ///
+    /// To be able to handle accessing this data from interrupt context, this
+    /// data must be `Sync`.
+    ///
+    /// The `RequestData` object is initialized when the requests are allocated
+    /// during queue initialization, and it is are dropped when the requests are
+    /// dropped during queue teardown.
+    type RequestData: Sized + Sync;
+
     /// Data associated with the `struct request_queue` that is allocated for
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable;
 
+    /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
+    fn new_request_data() -> impl PinInit<Self::RequestData>;
+
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.
     fn queue_rq(
@@ -236,6 +251,13 @@ impl<T: Operations> OperationsVTable<T> {
             // it is valid for writes.
             unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
 
+            let initializer = T::new_request_data();
+
+            // SAFETY: `pdu` is a valid pointer as established above. We do not
+            // touch `pdu` if `__pinned_init` returns an error. We promise ot to
+            // move the pointee of `pdu`.
+            unsafe { initializer.__pinned_init(RequestDataWrapper::data_ptr(pdu.as_ptr()))? };
+
             Ok(0)
         })
     }
@@ -255,7 +277,7 @@ impl<T: Operations> OperationsVTable<T> {
     ) {
         // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
         // for the request data.
-        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper>();
+        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper<T>>();
 
         // SAFETY: `pdu` is valid for read and write and is properly initialised.
         unsafe { core::ptr::drop_in_place(pdu) };
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 148348b4ef245..8a6c29ac627ee 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -96,12 +96,12 @@ pub fn complete(this: ARef<Self>) {
     ///
     /// - `this` must point to a valid allocation of size at least size of
     ///   [`Self`] plus size of [`RequestDataWrapper`].
-    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
+    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper<T>> {
         let request_ptr = this.cast::<bindings::request>();
         // SAFETY: By safety requirements for this function, `this` is a
         // valid allocation.
         let wrapper_ptr =
-            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
+            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper<T>>() };
         // SAFETY: By C API contract, `wrapper_ptr` points to a valid allocation
         // and is not null.
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
@@ -109,7 +109,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
 
     /// Return a reference to the [`RequestDataWrapper`] stored in the private
     /// area of the request structure.
-    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
+    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper<T> {
         // SAFETY: By type invariant, `self.0` is a valid allocation. Further,
         // the private data associated with this request is initialized and
         // valid. The existence of `&self` guarantees that the private data is
@@ -121,16 +121,19 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
 /// A wrapper around data stored in the private area of the C [`struct request`].
 ///
 /// [`struct request`]: srctree/include/linux/blk-mq.h
-pub(crate) struct RequestDataWrapper {
+pub(crate) struct RequestDataWrapper<T: Operations> {
     /// The Rust request refcount has the following states:
     ///
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
     /// - 2+: There are [`ARef`] references to the request.
     refcount: Refcount,
+
+    /// Driver managed request data
+    data: T::RequestData,
 }
 
-impl RequestDataWrapper {
+impl<T: Operations> RequestDataWrapper<T> {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
     pub(crate) fn refcount(&self) -> &Refcount {
@@ -148,6 +151,17 @@ pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // field projection is safe.
         unsafe { &raw mut (*this).refcount }
     }
+
+    /// Return a pointer to the `data` field of the `Self` pointed to by `this`.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must point to a live allocation of at least the size of `Self`.
+    pub(crate) unsafe fn data_ptr(this: *mut Self) -> *mut T::RequestData {
+        // SAFETY: Because of the safety requirements of this function, the
+        // field projection is safe.
+        unsafe { &raw mut (*this).data }
+    }
 }
 
 // SAFETY: Exclusive access is thread-safe for `Request`. `Request` has no `&mut
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c3cf56d52beec..46481754b1335 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -41,7 +41,7 @@ pub fn new(
         // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
         // all are allowed to be 0.
         let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
-        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
+        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper<T>>()
             .try_into()
             .map(|cmd_size| {
                 bindings::blk_mq_tag_set {

-- 
2.51.2



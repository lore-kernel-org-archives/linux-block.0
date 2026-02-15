Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867F30E0EF;
	Sun, 15 Feb 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199226; cv=none; b=V38v16BDcgrUn7SlwHjyj+NpvV9+r5Kkcd/4Xby1zUWgYL8l806+QCQDPi4GquuEkoRw9ZVl/4dklDOpau8wE939g3rSWeLZ5d8dcL5ZNP5poq1LbPfuOkNdvSR59octAHpJaYPxQBu0HUyW5l0zz2NySM0opGUhI3c2ol+T9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199226; c=relaxed/simple;
	bh=LfEJY7xsVq6LTYvFdGhIx9M30ktfxy1WzlpEoNzCFmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3OSgHFav5ztsu1rH6tACUIhmCjOUZVOB4QL2DR+mIh1iejkGLN/NopsputiJ5C1rcmsmlOsgsCNnGUDBzK9G6yq9HPQDG+pBxOtMFGRg3if89KraBag2O1nPrejO+hxcFeQWopNdYU7YQ4+KVhzgYi7fB15b5eMmmGVHt4OReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCQzTIxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCQzTIxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CB2C4CEF7;
	Sun, 15 Feb 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199225;
	bh=LfEJY7xsVq6LTYvFdGhIx9M30ktfxy1WzlpEoNzCFmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NCQzTIxhjQC5qtGYKhlogOzFs6mSy7j5BfyQbmkW6bZ23Nm01v0Gx4eL2MqdT9mEJ
	 QdzoM0JbRegOH/Ds6ZhUpdUVZB6AMdNKgtKyYw2hMZOszucxe/+tijwhOYT6gRi8rm
	 fBpRc/9Lwy+glV/7XYJmQ2FfdzUqBsVUr3z1drCq+1QHZpRsFCJ+WUQ4BW+CZn4Z2C
	 vmf3SHyaCJXEWX/5+1ECHdQFc9VwRi0Fju6XaW0JjQXYjxAW1KmkaiL/DmMOchtXU8
	 zLufISjSFwQ54mlErZmQlKjOGyjxh+RISdZEs5tyglr1lkDFGqc3QM0ZfQ3pmPs1tu
	 yFUSmC5OXS+LQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:54 +0100
Subject: [PATCH 07/79] block: rust: allow `hrtimer::Timer` in `RequestData`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-7-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8261; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LfEJY7xsVq6LTYvFdGhIx9M30ktfxy1WzlpEoNzCFmo=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgisv81RN4Rm6WZCUvmCKYbNqWj7DW/uhMxn
 ihoGWWE2gyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYIgAKCRDhuBo+eShj
 d984D/9kempnq428rshpY56BpINqqSCTNKH2DMV2IZPnlP7E8eGvuqDq20+uXKTtiBOUU1UDJS9
 JsyksU6I4yySv9J8SCUa4V6Z3aEqSUwPDxhD//UgNKGzQ0nJ8Nhr7YjUaKg9nOMoe4wfYPhfoAH
 Y2/NRUUqy6aAlu1VgvQll0qkhpALuIbBF8agrW0CVP43NT1/X5hd840ZN9UbwEOnpjq6XntjVPG
 HXfqrq2dmYoSJtM8D4izvHgRbFw7AAcaf7ksJMkv7W3NcJ1i+5wVzXQbN8LSlLPPsK6p+scfu09
 OOO6mbSb7svIwlTd0j6kzyvcQQD1W+2D5mzqkcMvrl5SmMm5Bbb20sKohnYN3HnEiWB9liR5y0C
 lgrpPV817hFLl/xMt03VZktA/OfPo1ogf5NKKE9UsE70O19LTrC+6HGWrsV69NoTbiF1z/WVVI3
 A9jyXz1+RLxDfh7VuPW4PDb1c+/7qMOPklDfodVuMsi8UZCJjukk0Fsv7Kk21o89swP3EnJV3Gk
 twUkStoY4jMiJsePabJxYMkArymNF9Ua0rdt3ttxnpk681zxO/q1DvWpqvCRM+MKurGYa4vU3HK
 ILN/d57ssX56jNN6powR5bD20xHEC+C+GkWC+Cn86ABJhRTNq03AHi0RzFkChYFTQwqF95esHrQ
 Ab0LbB319eKwJlw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`Request` is essentially a smart pointer that derefs to
`Operations::RequestData`. To use an `HrTimer` in `Operations::RequestData`
via the `Request` pointer, we must implement `HrTimerPointer` for
`Request`.

Thus, implement `HrTimerPointer` and friends for `ARef<Request>`.

Publicly export `HrTimer::raw_cancel` and `HrTimer::into_c`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs         |   1 +
 rust/kernel/block/mq/request.rs | 138 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/hrtimer.rs     |   5 +-
 3 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index a285b753ada88..cedaf85ba0b1d 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -108,4 +108,5 @@
 
 pub use operations::Operations;
 pub use request::Request;
+pub use request::RequestTimerHandle;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 8a6c29ac627ee..f270060be27eb 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -12,9 +12,12 @@
         atomic::ordering,
         Refcount,
     },
+    time::hrtimer::{
+        HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, HrTimerMode, HrTimerPointer,
+    },
     types::{Opaque, Ownable, OwnableRefCounted, Owned},
 };
-use core::{marker::PhantomData, ptr::NonNull};
+use core::{ffi::c_void, marker::PhantomData, ptr::NonNull};
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
@@ -116,6 +119,11 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper<T> {
         // valid as a shared reference.
         unsafe { Self::wrapper_ptr(core::ptr::from_ref(self).cast_mut()).as_ref() }
     }
+
+    /// Return a reference to the per-request data associated with this request.
+    pub fn data_ref(&self) -> &T::RequestData {
+        &self.wrapper_ref().data
+    }
 }
 
 /// A wrapper around data stored in the private area of the C [`struct request`].
@@ -300,3 +308,131 @@ fn into_shared(this: Owned<Self>) -> ARef<Self> {
         unsafe { ARef::from_raw(Owned::into_raw(this)) }
     }
 }
+
+/// A handle for a timer that is embedded in a [`Request`] private data area.
+pub struct RequestTimerHandle<T>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+{
+    inner: ARef<Request<T>>,
+}
+
+// SAFETY: The drop implementation of `RequestTimerHandle` calls `cancel`, which cancels the timer
+// if it is running. `drop` will block if the timer handler is running. This is ensured via a call
+// to `HrTimer::raw_cancel` in the implementation of `cancel`.
+unsafe impl<T> HrTimerHandle for RequestTimerHandle<T>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+{
+    fn cancel(&mut self) -> bool {
+        let request_data_ptr = &self.inner.wrapper_ref().data as *const T::RequestData;
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `U`.
+        let timer_ptr = unsafe {
+            <T::RequestData as HasHrTimer<T::RequestData>>::raw_get_timer(request_data_ptr)
+        };
+
+        // SAFETY: As `timer_ptr` points into `U` and `U` is valid, `timer_ptr`
+        // must point to a valid `HrTimer` instance.
+        unsafe { HrTimer::<T::RequestData>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<T> RequestTimerHandle<T>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+{
+    /// Drop the timer handle without cancelling the timer.
+    ///
+    /// This is safe because dropping the last [`ARef<Request>`] does not drop the [`Request`].
+    pub fn dismiss(mut self) {
+        let inner = core::ptr::from_mut(&mut self.inner);
+
+        // SAFETY: `inner` is valid for reads and writes, is properly aligned and nonnull. We have
+        // exclusive access to `inner` and we do not access `inner` after this call.
+        unsafe { core::ptr::drop_in_place(inner) };
+        core::mem::forget(self);
+    }
+}
+
+impl<T> Drop for RequestTimerHandle<T>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<T> HrTimerPointer for ARef<Request<T>>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+    T::RequestData: Sync,
+{
+    type TimerMode = <T::RequestData as HasHrTimer<T::RequestData>>::TimerMode;
+    type TimerHandle = RequestTimerHandle<T>;
+
+    fn start(self, expires: <Self::TimerMode as HrTimerMode>::Expires) -> RequestTimerHandle<T> {
+        let pdu_ptr = self.data_ref() as *const T::RequestData;
+
+        // SAFETY: `pdu_pointer` is coerced from a live reference to a `T` and this points to a
+        // valid `T`. The reference is valid until `T` is dropped, and the timer will be canceled
+        // before this.
+        unsafe { T::RequestData::start(pdu_ptr, expires) };
+
+        RequestTimerHandle { inner: self }
+    }
+}
+
+impl<T> kernel::time::hrtimer::RawHrTimerCallback for ARef<Request<T>>
+where
+    T: Operations,
+    T::RequestData: HasHrTimer<T::RequestData>,
+    T::RequestData: for<'a> HrTimerCallback<Pointer<'a> = ARef<Request<T>>>,
+    T::RequestData: Sync,
+{
+    type CallbackTarget<'a> = Self;
+
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(transparent)`
+        let timer_ptr = ptr.cast::<kernel::time::hrtimer::HrTimer<T::RequestData>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // enqueuing the timer, so it is a `HrTimer<T::RequestData>` embedded in a `T::RequestData`
+        let request_data_ptr = unsafe { T::RequestData::timer_container_of(timer_ptr) };
+
+        let offset = core::mem::offset_of!(RequestDataWrapper<T>, data);
+
+        // SAFETY: This sub stays within the `bindings::request` allocation and does not wrap.
+        let pdu_ptr = unsafe {
+            request_data_ptr
+                .cast::<u8>()
+                .sub(offset)
+                .cast::<RequestDataWrapper<T>>()
+        };
+
+        // SAFETY: This request pointer was passed to us by the kernel in `init_request_callback`.
+        let request_ptr = unsafe { bindings::blk_mq_rq_from_pdu(pdu_ptr.cast::<c_void>()) };
+
+        // SAFETY: By C API contract, we have ownership of the request.
+        let request_ref = unsafe { &*(request_ptr as *const Request<T>) };
+
+        request_ref.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        let aref: ARef<Request<T>> = unsafe { ARef::from_raw(NonNull::from(request_ref)) };
+
+        // SAFETY:
+        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
+        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
+        // - We are within `RawHrTimerCallback::run`
+        let context = unsafe { kernel::time::hrtimer::HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::RequestData::run(aref, context).into_c()
+    }
+}
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index b2272b059e504..0512a8dfee82a 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -160,7 +160,7 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `this` must point to a valid `Self`.
-    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
+    pub unsafe fn raw_cancel(this: *const Self) -> bool {
         // SAFETY: `this` points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
 
@@ -514,7 +514,8 @@ pub enum HrTimerRestart {
 }
 
 impl HrTimerRestart {
-    fn into_c(self) -> bindings::hrtimer_restart {
+    /// Convert `self` into an integer for FFI use.
+    pub fn into_c(self) -> bindings::hrtimer_restart {
         self as bindings::hrtimer_restart
     }
 }

-- 
2.51.2



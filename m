Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488A4D90D7;
	Tue,  9 Jun 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032426; cv=none; b=jz0+RVGLOs0RPGrivG9MTXDfrexAStdlhBjqCc6t22VaU7bw3JpMJ4EGBy+suDUeVbDh4ETFgZ9sfKwN2ulZ4tOx82cvI+daXeYXb5d/LfP7x21spa6NOz6kJ2//2s5mZkckvCW26BgdCkvebWgoHpmip1gDAkrBuOiezOXK39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032426; c=relaxed/simple;
	bh=MxU/avvgu0ObO+hSiIzPv5Gh1hPwXbxknG4ZgL5JR2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGLCMZIrgg6QK9QVtaEbtW2iex2/0tsCjJx4RxssPELNm5tYkt4qcySOSw/8wnYcXSoAhWUTRRXlCZrUiD6y6mSV38ALXWCUGMD2nyAd6fCrRmebatnkXjkJESFKaVRbPTpGDgoSOsrtKWnyQZ58QStt/dEvADLYmvvAE7faCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfnLzzTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfnLzzTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E3A1F00893;
	Tue,  9 Jun 2026 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032425;
	bh=XPdx1oCo+cDGKHpfIjN0PVTLlY+JG6MdSS1fHOHa1sM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AfnLzzTxPZjO9ehKPb9b2SbLpNUEFeuH3N5AStrAtc1iU7GQOokbmWJ0vrkEep7me
	 LYGxii8ZJ1Lweycf+53XWBXkQT4k/aN1MjrknxAdDKgx1zDZfW+Ogg4XyOgy11UwHp
	 uEzRtPDDHT+hjlz+GCUjrAE9d4qnc8G1pgLrgXeb2f1p6ZZuJT22q5ISlmqFLe4TGv
	 Mf1Dxv0FEx96l56ZNL9N9o+rMsa7uf9L2sWaWrK/2P6N1PKnbZ8l/9/r4qglqLBJ+G
	 aPyiTFjSGKLYnBoSMjZwdUHOo/7pANnZ7IJMwayibLplmz+zpKji9NvtoV4xOd+5nt
	 RvpDS3daO9tjA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:49 +0200
Subject: [PATCH v2 10/83] block: rust: allow `hrtimer::Timer` in
 `RequestData`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-10-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8262; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=MxU/avvgu0ObO+hSiIzPv5Gh1hPwXbxknG4ZgL5JR2I=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS9QazYsxgfYMLVHCHgKKVjzrf3FJbLdn8ww
 +/TN93edpaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkvQAKCRD6UCkIqsW9
 0FJGD/97Fixr3jGIlPgmEP6cWYHvaI4ONk7ITRFh7/tfq5iF7O4OiQV58e9R+Br+J80W8kv8t72
 a9tF07TjgAHAz5j2CtgAghAX2Dog0PE2Y9kPETYarm8PqqG56T43ctr0Z3icnQUGTx8v9OAPJFY
 HezJ/hX7TrE7h/AZlpX02lgY4DAXCpXkqbmoKvTubJRoau5weN4ESUs0OwmZ9hk2fnCgZab8FDN
 eOASHKr+srZAMT8DQM7RU1cfj1UlwYE6smitL195w03eRdDC16SM4O/AbUgEJ+hRq7R2Rq5Fk4D
 DMlI5L9fow6PzL0kU/7IdYYZiF85VPgTqdHwEsRjmYVDlGT1SfgAxlmvsuJdheqAFU0UojAdiAs
 hofFoQj18th6a//f9AtAZMupTeMIF7pM0rGb5LGqyG4A8f94XgtCA0tTNbeJziyQJLR7KcCmQiw
 /fgLN/DbRyt0lojLLFTZMDqGdAi3y8VdlvVxY2txEXn+eL/4n1nVIXQ4F/X5wsAdHdM3yLWS6ri
 NAF6l8ns0rcGkHdC1xNkIwVR6FeAjV661vXf9xEyStqI3OOygyGV6GYCZeA2G3EvlpMMyjLt6wt
 gzFUzDE2E8DVZdZddM9+dzNCXN28y51+7uIjXQF6iJ6O7NMjYY2GbJVl62xBqcCfbDdnxmcmn0E
 CWQNJg/g0Pwbo6w==
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
 rust/kernel/block/mq.rs         |   5 +-
 rust/kernel/block/mq/request.rs | 142 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer.rs     |   5 +-
 3 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 7718b106eb49..a03d46d274a5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -107,5 +107,8 @@
 mod tag_set;
 
 pub use operations::Operations;
-pub use request::Request;
+pub use request::{
+    Request,
+    RequestTimerHandle, //
+};
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a6e757d8755d..0b14f584c9d9 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -15,6 +15,14 @@
         atomic::ordering,
         Refcount,
     },
+    time::hrtimer::{
+        HasHrTimer,
+        HrTimer,
+        HrTimerCallback,
+        HrTimerHandle,
+        HrTimerMode,
+        HrTimerPointer, //
+    },
     types::{
         Opaque,
         Ownable,
@@ -23,6 +31,7 @@
     },
 };
 use core::{
+    ffi::c_void,
     marker::PhantomData,
     ptr::NonNull, //
 };
@@ -145,6 +154,11 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper<T> {
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
@@ -329,3 +343,131 @@ fn into_shared(this: Owned<Self>) -> ARef<Self> {
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
index d57276496ed6..096b18523c73 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -496,7 +496,7 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `this` must point to a valid `Self`.
-    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
+    pub unsafe fn raw_cancel(this: *const Self) -> bool {
         // SAFETY: `this` points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
 
@@ -900,7 +900,8 @@ pub enum HrTimerRestart {
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



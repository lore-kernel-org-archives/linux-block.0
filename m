Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C32D4B47
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573078; cv=none; b=SreI6QDa/BptEih6CnLKuy4Ev7HXKwyIpDPezeveIEh2MPkcSNYJxs7UZnVBmdt25RgklSmylLo/9cYtFnlAIXguVgZCp99EraTcx7raZ8k47kHYD+hgn9Hl8sKxi93y5uAkMGOy5cR9hhcAHvu8NJYAKeiH5nU8GtWqJ+Qun7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573078; c=relaxed/simple;
	bh=NX4x6fhZVv1hW2+9FgQ7i9Y26Mbd31LBndgfwKw5ka0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FgwuQv+qKdyTyB0+SxKRZdQLymcZq9Cth+2Z7+GrGYev7AtTc2pwWTSWYpW45RGyM/HW6g+Zgau0al6tQdYFwG5590Nwf8QtFa6oM3SepDqJxx23Zxrnpvhzd22x4DXXqGcQAjr22PjQRtZWhyuQo25hoHB8eL3+13VSLQIhnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7kl2ROH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7kl2ROH"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso3211035e9.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573074; x=1753177874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/IF5TqxbbTb43CI8c7Vt2zyr41KNdbrlxXyELTsINA=;
        b=i7kl2ROHt1oT5fjvAGuyOluW8/xK8pmviCKjunse8pkXauNAkR36Rju+/OCs8v7MuF
         dJFRwmk6G04rPCux8f3FmaYRJu2jhJIJHzlupB1OCyHnLPneyAyY3hs8V7bsAIEpdlZI
         uMoUd03YJHIB/y5dsAkYLHKcQLseLawPrWzKHqdM29llMej7TX29w8EFowBBkHxr5jBS
         yHY4nyo5kknjm8Gr1x4gLZuthDbbieGhb2igER1cJAYapu2M58wm97E9EH0HB3zVYUkj
         4E6SQ7sb13FHDX0PJcc/6sSQqwohqqal6KyQTbZhz6z4iTAYmTer50c4O1+EcC8HmIuD
         /Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573074; x=1753177874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/IF5TqxbbTb43CI8c7Vt2zyr41KNdbrlxXyELTsINA=;
        b=mrnNlTnAdru8FDRJCKBgDTzz3lFnXuvNVO/0d7u4rVUk6AuoTtP4afVOSSn3K4m54E
         9hz4TarqWHRY9H1t/Y2p1O89MLvhFpcjfkHpdBwwqXV7DhvDWnNHGIdpKsl/bdT396X4
         KjmcsVX+0p4zinSY2WharvUuZjkFzX2yeMj7N7E4FwxU/y1uVROTXTVoq/zPdapSlJLJ
         IR8aIiz7ZcjYij1Sa5f0YbRK7iDskQN6DGkkHAPNIA4fO6HzpVp+yh4bjT4NiY+5rEeS
         LICC1U4IiZGUJ4qmyTVwQDRwvuqCKBvWUM579fmpVhTvS6Q5UDgZa2QBo1/XurtlW5c4
         IP0g==
X-Forwarded-Encrypted: i=1; AJvYcCWNFkzZHnbP5H4i/f4vH+6dEgMCeUy+Aukb4XerWz1aJwOjK2JJVy82Fotg1AqlNRTAvjV6/wf1e08SlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnk/Go5ids+QeQQUijEgEpTqAA/0316wnFxGyoIM+CzuWkQK4b
	Pg0/EUq2+FQoeJmpPEVvb+aEd7AavNhEdU531v5r+u/0pDre+sZhZwtJuB71kdMLi0UWc6mO9hk
	0DhmSuF32ActHn+6T7g==
X-Google-Smtp-Source: AGHT+IEDK5gnNSNQW+GqnNlZ7j+IOtZlVB4qpnyAHPg0jd0R90zS53J91A20T58vFKqQu881GKsAR8AN/KpNORY=
X-Received: from wrqd4.prod.google.com ([2002:adf:f844:0:b0:3a8:2eca:bbd4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2dc6:b0:3a5:2e84:cc7b with SMTP id ffacd0b85a97d-3b5f2dac5ebmr12080008f8f.11.1752573074135;
 Tue, 15 Jul 2025 02:51:14 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:51:13 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org>
Message-ID: <aHYkkQpFOIcKuK-v@google.com>
Subject: Re: [PATCH v3 13/16] rust: block: add `GenDisk` private data support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:14PM +0200, Andreas Hindborg wrote:
> Allow users of the rust block device driver API to install private data in
> the `GenDisk` structure.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/block/rnull/rnull.rs       |  8 ++++---
>  rust/kernel/block/mq.rs            |  7 +++---
>  rust/kernel/block/mq/gen_disk.rs   | 32 ++++++++++++++++++++++----
>  rust/kernel/block/mq/operations.rs | 46 ++++++++++++++++++++++++++++++--------
>  4 files changed, 74 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index d09bc77861e4..a012c59ecb3c 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -62,14 +62,16 @@ fn new(
>              .logical_block_size(block_size)?
>              .physical_block_size(block_size)?
>              .rotational(rotational)
> -            .build(fmt!("{}", name.to_str()?), tagset)
> +            .build(fmt!("{}", name.to_str()?), tagset, ())
>      }
>  }
>  
>  #[vtable]
>  impl Operations for NullBlkDevice {
> +    type QueueData = ();
> +
>      #[inline(always)]
> -    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
> +    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>          mq::Request::end_ok(rq)
>              .map_err(|_e| kernel::error::code::EIO)
>              // We take no refcounts on the request, so we expect to be able to
> @@ -80,5 +82,5 @@ fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>          Ok(())
>      }
>  
> -    fn commit_rqs() {}
> +    fn commit_rqs(_queue_data: ()) {}
>  }
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index faa3ccb5a49a..34b7425fa94d 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -69,20 +69,21 @@
>  //!
>  //! #[vtable]
>  //! impl Operations for MyBlkDevice {
> +//!     type QueueData = ();
>  //!
> -//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> Result {
> +//!     fn queue_rq(_queue_data: (), rq: ARef<Request<Self>>, _is_last: bool) -> Result {
>  //!         Request::end_ok(rq);
>  //!         Ok(())
>  //!     }
>  //!
> -//!     fn commit_rqs() {}
> +//!     fn commit_rqs(_queue_data: ()) {}
>  //! }
>  //!
>  //! let tagset: Arc<TagSet<MyBlkDevice>> =
>  //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
>  //! let mut disk = gen_disk::GenDiskBuilder::new()
>  //!     .capacity_sectors(4096)
> -//!     .build(format_args!("myblk"), tagset)?;
> +//!     .build(format_args!("myblk"), tagset, ())?;
>  //!
>  //! # Ok::<(), kernel::error::Error>(())
>  //! ```
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index 7ab049ec591b..954bc64cfa59 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -12,6 +12,7 @@
>      static_lock_class,
>      str::NullTerminatedFormatter,
>      sync::Arc,
> +    types::{ForeignOwnable, ScopeGuard},
>  };
>  use core::fmt::{self, Write};
>  
> @@ -97,7 +98,14 @@ pub fn build<T: Operations>(
>          self,
>          name: fmt::Arguments<'_>,
>          tagset: Arc<TagSet<T>>,
> +        queue_data: T::QueueData,
>      ) -> Result<GenDisk<T>> {
> +        let data = queue_data.into_foreign();
> +        let recover_data = ScopeGuard::new(|| {
> +            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
> +            unsafe { T::QueueData::from_foreign(data) };

I think this is clearer to read as

drop(unsafe { T::QueueData::from_foreign(data) });

> +        });
> +
>          // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>          let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>  
> @@ -112,7 +120,7 @@ pub fn build<T: Operations>(
>              bindings::__blk_mq_alloc_disk(
>                  tagset.raw_tag_set(),
>                  &mut lim,
> -                core::ptr::null_mut(),
> +                data.cast(),
>                  static_lock_class!().as_ptr(),
>              )
>          })?;
> @@ -166,8 +174,12 @@ pub fn build<T: Operations>(
>              },
>          )?;
>  
> +        recover_data.dismiss();
> +
>          // INVARIANT: `gendisk` was initialized above.
>          // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
> +        // `__blk_mq_alloc_disk` above.
>          Ok(GenDisk {
>              _tagset: tagset,
>              gendisk,
> @@ -179,9 +191,10 @@ pub fn build<T: Operations>(
>  ///
>  /// # Invariants
>  ///
> -/// - `gendisk` must always point to an initialized and valid `struct gendisk`.
> -/// - `gendisk` was added to the VFS through a call to
> -///   `bindings::device_add_disk`.
> +///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
> +///  - `gendisk` was added to the VFS through a call to
> +///    `bindings::device_add_disk`.
> +///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
>  pub struct GenDisk<T: Operations> {
>      _tagset: Arc<TagSet<T>>,
>      gendisk: *mut bindings::gendisk,
> @@ -193,9 +206,20 @@ unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
>  
>  impl<T: Operations> Drop for GenDisk<T> {
>      fn drop(&mut self) {
> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid
> +        // and initialized instance of `struct gendisk`, and, `queuedata` was
> +        // initialized with the result of a call to
> +        // `ForeignOwnable::into_foreign`.
> +        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
> +
>          // SAFETY: By type invariant, `self.gendisk` points to a valid and
>          // initialized instance of `struct gendisk`, and it was previously added
>          // to the VFS.
>          unsafe { bindings::del_gendisk(self.gendisk) };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
> +        // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
> +        // `ForeignOwnable::from_foreign` is only called here.
> +        let _queue_data = unsafe { T::QueueData::from_foreign(queue_data.cast()) };

Ditto here.

drop(unsafe { T::QueueData::from_foreign(queue_data.cast()) });

Also, is this cast necessary as of
https://lore.kernel.org/all/20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org/
?

>      }
>  }
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index 864ff379dc91..c50959d5517b 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -6,14 +6,15 @@
>  
>  use crate::{
>      bindings,
> -    block::mq::request::RequestDataWrapper,
> -    block::mq::Request,
> +    block::mq::{request::RequestDataWrapper, Request},
>      error::{from_result, Result},
>      prelude::*,
> -    types::ARef,
> +    types::{ARef, ForeignOwnable},
>  };
>  use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
>  
> +type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
> +
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
>  /// To implement a block device driver, implement this trait as described in the
> @@ -26,12 +27,20 @@
>  /// [module level documentation]: kernel::block::mq
>  #[macros::vtable]
>  pub trait Operations: Sized {
> +    /// Data associated with the `struct request_queue` that is allocated for
> +    /// the `GenDisk` associated with this `Operations` implementation.
> +    type QueueData: ForeignOwnable;
> +
>      /// Called by the kernel to queue a request with the driver. If `is_last` is
>      /// `false`, the driver is allowed to defer committing the request.
> -    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
> +    fn queue_rq(
> +        queue_data: ForeignBorrowed<'_, Self::QueueData>,
> +        rq: ARef<Request<Self>>,
> +        is_last: bool,
> +    ) -> Result;
>  
>      /// Called by the kernel to indicate that queued requests should be submitted.
> -    fn commit_rqs();
> +    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
>  
>      /// Called by the kernel to poll the device for completed requests. Only
>      /// used for poll queues.
> @@ -70,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>      ///   promise to not access the request until the driver calls
>      ///   `bindings::blk_mq_end_request` for the request.
>      unsafe extern "C" fn queue_rq_callback(
> -        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        hctx: *mut bindings::blk_mq_hw_ctx,
>          bd: *const bindings::blk_mq_queue_data,
>      ) -> bindings::blk_status_t {
>          // SAFETY: `bd.rq` is valid as required by the safety requirement for
> @@ -88,10 +97,20 @@ impl<T: Operations> OperationsVTable<T> {
>          //    reference counted by `ARef` until then.
>          let rq = unsafe { Request::aref_from_raw((*bd).rq) };
>  
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data = unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
> +        // `ForeignOwnable::from_foreign()` is only called when the tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };
> +
>          // SAFETY: We have exclusive access and we just set the refcount above.
>          unsafe { Request::start_unchecked(&rq) };
>  
>          let ret = T::queue_rq(
> +            queue_data,
>              rq,
>              // SAFETY: `bd` is valid as required by the safety requirement for
>              // this function.
> @@ -110,9 +129,18 @@ impl<T: Operations> OperationsVTable<T> {
>      ///
>      /// # Safety
>      ///
> -    /// This function may only be called by blk-mq C infrastructure.
> -    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
> -        T::commit_rqs()
> +    /// This function may only be called by blk-mq C infrastructure. The caller
> +    /// must ensure that `hctx` is valid.
> +    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data = unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
> +        // `ForeignOwnable::from_foreign()` is only called when the tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };
> +        T::commit_rqs(queue_data)
>      }
>  
>      /// This function is called by the C kernel. It is not currently
> 
> -- 
> 2.47.2
> 
> 

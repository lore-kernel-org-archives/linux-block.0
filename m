Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F674268C40;
	Mon,  1 Sep 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715189; cv=none; b=kpP6oZHhQxP8C4c8atO8aId+pWuBz5Kl7FCYV1A+9+5dBo7GL+3FTjAutPa31bc+b3MeC3KZZcUr3qI73l0SaY6zMW5W0BjMe7X21cd4MtQOgsrFWJhRv6uR7L0RSo3o280MKo0SGUgyVGDIX8BatXRSo8BFVIhuZJOFjj4U+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715189; c=relaxed/simple;
	bh=EL4g7ElDYnH0F+Q3iJ4AYSfurnJ+CMkjA+k87gJVbts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKMarC9FphxXB/Hm8v+P7ulee+hamS88v8XG/XvGIK2lsaX6flVQ9JlA8DqnB9Hh6PKxmASnxQtKMi1nvXxEPjU0crFwXoVbT599NDEJlsksMbU3BN8kE2n0PUHErAY+GktF3sgWgCjKQ5l3vNhOTGeCSveQCFal8vep2I+VTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO8xilVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO8xilVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1322FC4CEF0;
	Mon,  1 Sep 2025 08:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715189;
	bh=EL4g7ElDYnH0F+Q3iJ4AYSfurnJ+CMkjA+k87gJVbts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tO8xilVMw7lUa77DfE6iZLZuWSdvykZbvV0b46eo+vFIv4ADFZeUsvn6D08GYqW4r
	 Y3vBNgC0WTvezBQM8mg3BCYBsUkU4Yn1RF/4loRN798rKzEz6rnclMQbiln5vHWE3P
	 +1FOyYy9bqCsCTqtJXRE//T9+RXT7i8W3iHmN54j+11xAVW4hw8PMBFJRbqopg2KOW
	 bn8y5DIv0xGEGaZrMrjI6Otys/hLXcfejeD+aW6oOy7zzVqlWjquP5J/JXpdYd8/Df
	 gcNVC2yEOp6HmB4FpAKt28V0/ZJt9NaGS7Cm7bJQRsiN1ER8bbKuoD8/eMUwnLNtjm
	 5fHX6b3v+ksWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao
 <leitao@debian.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] rust: block: add `GenDisk` private data support
In-Reply-To: <F5F77953-D3B2-4A03-BEFF-D937A01A645E@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-15-ec65006e2f07@kernel.org>
 <_8F464g73UiE3RDovzsbrDnz23OqxIFm-aco6DaaWbByhY4AcIn09hOKnGQ6sKJlSENjAFr3yEeDKC7dQDWbeg==@protonmail.internalid>
 <F5F77953-D3B2-4A03-BEFF-D937A01A645E@collabora.com>
Date: Mon, 01 Sep 2025 10:21:31 +0200
Message-ID: <87v7m2h9bo.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Allow users of the rust block device driver API to install private data =
in
>> the `GenDisk` structure.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> drivers/block/rnull/rnull.rs       |  8 ++++---
>> rust/kernel/block/mq.rs            |  7 +++---
>> rust/kernel/block/mq/gen_disk.rs   | 32 ++++++++++++++++++++++----
>> rust/kernel/block/mq/operations.rs | 46 ++++++++++++++++++++++++++++++--=
------
>> 4 files changed, 74 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
>> index 8690ff5f974f..8255236bc550 100644
>> --- a/drivers/block/rnull/rnull.rs
>> +++ b/drivers/block/rnull/rnull.rs
>> @@ -61,14 +61,16 @@ fn new(
>>             .logical_block_size(block_size)?
>>             .physical_block_size(block_size)?
>>             .rotational(rotational)
>> -            .build(fmt!("{}", name.to_str()?), tagset)
>> +            .build(fmt!("{}", name.to_str()?), tagset, ())
>>     }
>> }
>>
>> #[vtable]
>> impl Operations for NullBlkDevice {
>> +    type QueueData =3D ();
>> +
>>     #[inline(always)]
>> -    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>> +    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last:=
 bool) -> Result {
>>         mq::Request::end_ok(rq)
>>             .map_err(|_e| kernel::error::code::EIO)
>>             // We take no refcounts on the request, so we expect to be a=
ble to
>> @@ -79,5 +81,5 @@ fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: boo=
l) -> Result {
>>         Ok(())
>>     }
>>
>> -    fn commit_rqs() {}
>> +    fn commit_rqs(_queue_data: ()) {}
>> }
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> index 98fa0d6bc8f7..6e546f4f3d1c 100644
>> --- a/rust/kernel/block/mq.rs
>> +++ b/rust/kernel/block/mq.rs
>> @@ -69,20 +69,21 @@
>> //!
>> //! #[vtable]
>> //! impl Operations for MyBlkDevice {
>> +//!     type QueueData =3D ();
>> //!
>> -//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> Result {
>> +//!     fn queue_rq(_queue_data: (), rq: ARef<Request<Self>>, _is_last:=
 bool) -> Result {
>> //!         Request::end_ok(rq);
>> //!         Ok(())
>> //!     }
>> //!
>> -//!     fn commit_rqs() {}
>> +//!     fn commit_rqs(_queue_data: ()) {}
>> //! }
>> //!
>> //! let tagset: Arc<TagSet<MyBlkDevice>> =3D
>> //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
>> //! let mut disk =3D gen_disk::GenDiskBuilder::new()
>> //!     .capacity_sectors(4096)
>> -//!     .build(format_args!("myblk"), tagset)?;
>> +//!     .build(format_args!("myblk"), tagset, ())?;
>> //!
>> //! # Ok::<(), kernel::error::Error>(())
>> //! ```
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen=
_disk.rs
>> index 6b1b846874db..46ec80269970 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -13,6 +13,7 @@
>>     static_lock_class,
>>     str::NullTerminatedFormatter,
>>     sync::Arc,
>> +    types::{ForeignOwnable, ScopeGuard},
>> };
>> use core::fmt::{self, Write};
>>
>> @@ -98,7 +99,14 @@ pub fn build<T: Operations>(
>>         self,
>>         name: fmt::Arguments<'_>,
>>         tagset: Arc<TagSet<T>>,
>> +        queue_data: T::QueueData,
>>     ) -> Result<GenDisk<T>> {
>> +        let data =3D queue_data.into_foreign();
>> +        let recover_data =3D ScopeGuard::new(|| {
>> +            // SAFETY: T::QueueData was created by the call to `into_fo=
reign()` above
>> +            drop(unsafe { T::QueueData::from_foreign(data) });
>> +        });
>> +
>>         // SAFETY: `bindings::queue_limits` contain only fields that are=
 valid when zeroed.
>>         let mut lim: bindings::queue_limits =3D unsafe { core::mem::zero=
ed() };
>>
>> @@ -113,7 +121,7 @@ pub fn build<T: Operations>(
>>             bindings::__blk_mq_alloc_disk(
>>                 tagset.raw_tag_set(),
>>                 &mut lim,
>> -                core::ptr::null_mut(),
>> +                data,
>>                 static_lock_class!().as_ptr(),
>>             )
>>         })?;
>> @@ -167,8 +175,12 @@ pub fn build<T: Operations>(
>>             },
>>         )?;
>>
>> +        recover_data.dismiss();
>> +
>>         // INVARIANT: `gendisk` was initialized above.
>>         // INVARIANT: `gendisk` was added to the VFS via `device_add_dis=
k` above.
>> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in th=
e call to
>> +        // `__blk_mq_alloc_disk` above.
>>         Ok(GenDisk {
>>             _tagset: tagset,
>>             gendisk,
>> @@ -180,9 +192,10 @@ pub fn build<T: Operations>(
>> ///
>> /// # Invariants
>> ///
>> -/// - `gendisk` must always point to an initialized and valid `struct g=
endisk`.
>> -/// - `gendisk` was added to the VFS through a call to
>> -///   `bindings::device_add_disk`.
>> +///  - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
>> +///  - `gendisk` was added to the VFS through a call to
>> +///    `bindings::device_add_disk`.
>> +///  - `self.gendisk.queue.queuedata` is initialized by a call to `Fore=
ignOwnable::into_foreign`.
>> pub struct GenDisk<T: Operations> {
>>     _tagset: Arc<TagSet<T>>,
>>     gendisk: *mut bindings::gendisk,
>> @@ -194,9 +207,20 @@ unsafe impl<T: Operations + Send> Send for GenDisk<=
T> {}
>>
>> impl<T: Operations> Drop for GenDisk<T> {
>>     fn drop(&mut self) {
>> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points t=
o a valid
>> +        // and initialized instance of `struct gendisk`, and, `queuedat=
a` was
>> +        // initialized with the result of a call to
>> +        // `ForeignOwnable::into_foreign`.
>> +        let queue_data =3D unsafe { (*(*self.gendisk).queue).queuedata =
};
>> +
>>         // SAFETY: By type invariant, `self.gendisk` points to a valid a=
nd
>>         // initialized instance of `struct gendisk`, and it was previous=
ly added
>>         // to the VFS.
>>         unsafe { bindings::del_gendisk(self.gendisk) };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::bu=
ild` with
>> +        // a call to `ForeignOwnable::into_foreign` to create `queuedat=
a`.
>> +        // `ForeignOwnable::from_foreign` is only called here.
>> +        drop(unsafe { T::QueueData::from_foreign(queue_data) });
>>     }
>> }
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/o=
perations.rs
>> index c2b98f507bcb..6fb256f55acc 100644
>> --- a/rust/kernel/block/mq/operations.rs
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -6,14 +6,15 @@
>>
>> use crate::{
>>     bindings,
>> -    block::mq::request::RequestDataWrapper,
>> -    block::mq::Request,
>> +    block::mq::{request::RequestDataWrapper, Request},
>>     error::{from_result, Result},
>>     prelude::*,
>> -    types::ARef,
>> +    types::{ARef, ForeignOwnable},
>> };
>> use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::O=
rdering};
>>
>> +type ForeignBorrowed<'a, T> =3D <T as ForeignOwnable>::Borrowed<'a>;
>> +
>> /// Implement this trait to interface blk-mq as block devices.
>> ///
>> /// To implement a block device driver, implement this trait as describe=
d in the
>> @@ -26,12 +27,20 @@
>> /// [module level documentation]: kernel::block::mq
>> #[macros::vtable]
>> pub trait Operations: Sized {
>> +    /// Data associated with the `struct request_queue` that is allocat=
ed for
>> +    /// the `GenDisk` associated with this `Operations` implementation.
>> +    type QueueData: ForeignOwnable;
>> +
>>     /// Called by the kernel to queue a request with the driver. If `is_=
last` is
>>     /// `false`, the driver is allowed to defer committing the request.
>> -    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
>> +    fn queue_rq(
>> +        queue_data: ForeignBorrowed<'_, Self::QueueData>,
>> +        rq: ARef<Request<Self>>,
>> +        is_last: bool,
>> +    ) -> Result;
>>
>>     /// Called by the kernel to indicate that queued requests should be =
submitted.
>> -    fn commit_rqs();
>> +    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
>>
>>     /// Called by the kernel to poll the device for completed requests. =
Only
>>     /// used for poll queues.
>> @@ -70,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>>     ///   promise to not access the request until the driver calls
>>     ///   `bindings::blk_mq_end_request` for the request.
>>     unsafe extern "C" fn queue_rq_callback(
>> -        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        hctx: *mut bindings::blk_mq_hw_ctx,
>>         bd: *const bindings::blk_mq_queue_data,
>>     ) -> bindings::blk_status_t {
>>         // SAFETY: `bd.rq` is valid as required by the safety requiremen=
t for
>> @@ -88,10 +97,20 @@ impl<T: Operations> OperationsVTable<T> {
>>         //    reference counted by `ARef` until then.
>>         let rq =3D unsafe { Request::aref_from_raw((*bd).rq) };
>>
>> +        // SAFETY: `hctx` is valid as required by this function.
>> +        let queue_data =3D unsafe { (*(*hctx).queue).queuedata };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()=
` with a
>
> isn=E2=80=99t this set on build() ?

Yes, you are right. Refactoring happened.

>
>> +        // call to `ForeignOwnable::into_pointer()` to create `queuedat=
a`.
>
> into_pointer() ?

Should be `into_foreign`, will fix.

>
>> +        // `ForeignOwnable::from_foreign()` is only called when the tag=
set is
>> +        // dropped, which happens after we are dropped.
>> +        let queue_data =3D unsafe { T::QueueData::borrow(queue_data) };
>> +
>>         // SAFETY: We have exclusive access and we just set the refcount=
 above.
>>         unsafe { Request::start_unchecked(&rq) };
>>
>>         let ret =3D T::queue_rq(
>> +            queue_data,
>>             rq,
>>             // SAFETY: `bd` is valid as required by the safety requireme=
nt for
>>             // this function.
>> @@ -110,9 +129,18 @@ impl<T: Operations> OperationsVTable<T> {
>>     ///
>>     /// # Safety
>>     ///
>> -    /// This function may only be called by blk-mq C infrastructure.
>> -    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_=
mq_hw_ctx) {
>> -        T::commit_rqs()
>> +    /// This function may only be called by blk-mq C infrastructure. Th=
e caller
>> +    /// must ensure that `hctx` is valid.
>> +    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_m=
q_hw_ctx) {
>> +        // SAFETY: `hctx` is valid as required by this function.
>> +        let queue_data =3D unsafe { (*(*hctx).queue).queuedata };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()=
` with a
>> +        // call to `ForeignOwnable::into_pointer()` to create `queuedat=
a`.
>
> into_foreign()?

Yep, thanks.

>
>> +        // `ForeignOwnable::from_foreign()` is only called when the tag=
set is
>> +        // dropped, which happens after we are dropped.
>> +        let queue_data =3D unsafe { T::QueueData::borrow(queue_data) };
>> +        T::commit_rqs(queue_data)
>>     }
>>
>>     /// This function is called by the C kernel. It is not currently
>>
>> --
>> 2.47.2
>>
>>
>>
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099221FF55;
	Wed, 27 Aug 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317200; cv=pass; b=MseMvGGxFLJGjreyyAXBDZxPEcf4QOy8bNn0L7/Tu00+hHGocnhSMr0Wl4uVRPDkXFQiIunU6O2s9My0Ium6yq5YF6NyKnvFoCBoEWKg1RH5SDWRrK52/6bLSiNrnM8C9Vrw+8byvPLjdekmv1KmfZsqG7kSWjq8ZqzsaR4U9Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317200; c=relaxed/simple;
	bh=FiAVdmpAd56Eo8yeLlOaWldznsJoTafgRx9VVj0nzMk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gAkqpiZTlSeZWqv5rl8qdfeOBqXELtOpge/Mb0Ad/U5jnQ3bzcCBXVH2WaiAethLkL+qmuAmQaumNjnf9UQWjZDxEKn20XVPDkvXRUjpySnM41LW9I2Xx8MpUM50zO+fIDY0K+yLcGXlVZMJP5NkttcjxEiUDfBQGM7Mksf0yvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LCsWkMSc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LCsWkMSc"
ARC-Seal: i=1; a=rsa-sha256; t=1756317177; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SFVlvlMoLih63YeCfRuKzBIkV+AUuk/QLm3VgUpXJWAmHCRq7QHlFjsEt9J3fmt0Mv7m/nhASCQDyFAjI2Afvxr8VLSEeU9HY5TLJs6mroKycJ2HwdtzLPYBNmcDt9EcymDCmURLbhg4VgJQZGM+aGeE547A3TESt8yd7ytoTUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756317177; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AnFhkcCNOfTOWgQFBiJ5K7cFdzpqzmzqvFP4oFM1Njs=; 
	b=EIdlqEWLwRWlfX6AsZ7mJCs64+vGlYGTRREf8MlOZlDna7kuXMOi19FdBNRe9xbD0fBMKWki7bwE0vExh9d5BDeD07iHnA8F6HcKGc82E5qUtFPjdQyt4c8c4pknyTyhgslMxnZZDr14Zh4UqBk5aOtzT3kub5AgMy6zoczYA7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756317177;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=AnFhkcCNOfTOWgQFBiJ5K7cFdzpqzmzqvFP4oFM1Njs=;
	b=LCsWkMScpLH2aCcZAv0dbhhdFX8o5mDYOByE4xE4QNiN6Irwmw7b4dmM9+mwy2y0
	XMiVHNlULO7v1oSprH+eQgDwfgi3/54ZrF6FFYHxZBxW6kIZ+X22W4Ol6OVAv2R8n9E
	MGNfIEJ9ow4PhtsYGLWU4xQf1rMpUdXC4brKvC6M=
Received: by mx.zohomail.com with SMTPS id 1756317173875832.4987805869289;
	Wed, 27 Aug 2025 10:52:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 15/18] rust: block: add `GenDisk` private data support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-15-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 14:52:37 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5F77953-D3B2-4A03-BEFF-D937A01A645E@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-15-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Allow users of the rust block device driver API to install private =
data in
> the `GenDisk` structure.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> drivers/block/rnull/rnull.rs       |  8 ++++---
> rust/kernel/block/mq.rs            |  7 +++---
> rust/kernel/block/mq/gen_disk.rs   | 32 ++++++++++++++++++++++----
> rust/kernel/block/mq/operations.rs | 46 =
++++++++++++++++++++++++++++++--------
> 4 files changed, 74 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/block/rnull/rnull.rs =
b/drivers/block/rnull/rnull.rs
> index 8690ff5f974f..8255236bc550 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -61,14 +61,16 @@ fn new(
>             .logical_block_size(block_size)?
>             .physical_block_size(block_size)?
>             .rotational(rotational)
> -            .build(fmt!("{}", name.to_str()?), tagset)
> +            .build(fmt!("{}", name.to_str()?), tagset, ())
>     }
> }
>=20
> #[vtable]
> impl Operations for NullBlkDevice {
> +    type QueueData =3D ();
> +
>     #[inline(always)]
> -    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> =
Result {
> +    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, =
_is_last: bool) -> Result {
>         mq::Request::end_ok(rq)
>             .map_err(|_e| kernel::error::code::EIO)
>             // We take no refcounts on the request, so we expect to be =
able to
> @@ -79,5 +81,5 @@ fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: =
bool) -> Result {
>         Ok(())
>     }
>=20
> -    fn commit_rqs() {}
> +    fn commit_rqs(_queue_data: ()) {}
> }
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index 98fa0d6bc8f7..6e546f4f3d1c 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -69,20 +69,21 @@
> //!
> //! #[vtable]
> //! impl Operations for MyBlkDevice {
> +//!     type QueueData =3D ();
> //!
> -//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> =
Result {
> +//!     fn queue_rq(_queue_data: (), rq: ARef<Request<Self>>, =
_is_last: bool) -> Result {
> //!         Request::end_ok(rq);
> //!         Ok(())
> //!     }
> //!
> -//!     fn commit_rqs() {}
> +//!     fn commit_rqs(_queue_data: ()) {}
> //! }
> //!
> //! let tagset: Arc<TagSet<MyBlkDevice>> =3D
> //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
> //! let mut disk =3D gen_disk::GenDiskBuilder::new()
> //!     .capacity_sectors(4096)
> -//!     .build(format_args!("myblk"), tagset)?;
> +//!     .build(format_args!("myblk"), tagset, ())?;
> //!
> //! # Ok::<(), kernel::error::Error>(())
> //! ```
> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
> index 6b1b846874db..46ec80269970 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -13,6 +13,7 @@
>     static_lock_class,
>     str::NullTerminatedFormatter,
>     sync::Arc,
> +    types::{ForeignOwnable, ScopeGuard},
> };
> use core::fmt::{self, Write};
>=20
> @@ -98,7 +99,14 @@ pub fn build<T: Operations>(
>         self,
>         name: fmt::Arguments<'_>,
>         tagset: Arc<TagSet<T>>,
> +        queue_data: T::QueueData,
>     ) -> Result<GenDisk<T>> {
> +        let data =3D queue_data.into_foreign();
> +        let recover_data =3D ScopeGuard::new(|| {
> +            // SAFETY: T::QueueData was created by the call to =
`into_foreign()` above
> +            drop(unsafe { T::QueueData::from_foreign(data) });
> +        });
> +
>         // SAFETY: `bindings::queue_limits` contain only fields that =
are valid when zeroed.
>         let mut lim: bindings::queue_limits =3D unsafe { =
core::mem::zeroed() };
>=20
> @@ -113,7 +121,7 @@ pub fn build<T: Operations>(
>             bindings::__blk_mq_alloc_disk(
>                 tagset.raw_tag_set(),
>                 &mut lim,
> -                core::ptr::null_mut(),
> +                data,
>                 static_lock_class!().as_ptr(),
>             )
>         })?;
> @@ -167,8 +175,12 @@ pub fn build<T: Operations>(
>             },
>         )?;
>=20
> +        recover_data.dismiss();
> +
>         // INVARIANT: `gendisk` was initialized above.
>         // INVARIANT: `gendisk` was added to the VFS via =
`device_add_disk` above.
> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in =
the call to
> +        // `__blk_mq_alloc_disk` above.
>         Ok(GenDisk {
>             _tagset: tagset,
>             gendisk,
> @@ -180,9 +192,10 @@ pub fn build<T: Operations>(
> ///
> /// # Invariants
> ///
> -/// - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
> -/// - `gendisk` was added to the VFS through a call to
> -///   `bindings::device_add_disk`.
> +///  - `gendisk` must always point to an initialized and valid =
`struct gendisk`.
> +///  - `gendisk` was added to the VFS through a call to
> +///    `bindings::device_add_disk`.
> +///  - `self.gendisk.queue.queuedata` is initialized by a call to =
`ForeignOwnable::into_foreign`.
> pub struct GenDisk<T: Operations> {
>     _tagset: Arc<TagSet<T>>,
>     gendisk: *mut bindings::gendisk,
> @@ -194,9 +207,20 @@ unsafe impl<T: Operations + Send> Send for =
GenDisk<T> {}
>=20
> impl<T: Operations> Drop for GenDisk<T> {
>     fn drop(&mut self) {
> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points =
to a valid
> +        // and initialized instance of `struct gendisk`, and, =
`queuedata` was
> +        // initialized with the result of a call to
> +        // `ForeignOwnable::into_foreign`.
> +        let queue_data =3D unsafe { =
(*(*self.gendisk).queue).queuedata };
> +
>         // SAFETY: By type invariant, `self.gendisk` points to a valid =
and
>         // initialized instance of `struct gendisk`, and it was =
previously added
>         // to the VFS.
>         unsafe { bindings::del_gendisk(self.gendisk) };
> +
> +        // SAFETY: `queue.queuedata` was created by =
`GenDiskBuilder::build` with
> +        // a call to `ForeignOwnable::into_foreign` to create =
`queuedata`.
> +        // `ForeignOwnable::from_foreign` is only called here.
> +        drop(unsafe { T::QueueData::from_foreign(queue_data) });
>     }
> }
> diff --git a/rust/kernel/block/mq/operations.rs =
b/rust/kernel/block/mq/operations.rs
> index c2b98f507bcb..6fb256f55acc 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -6,14 +6,15 @@
>=20
> use crate::{
>     bindings,
> -    block::mq::request::RequestDataWrapper,
> -    block::mq::Request,
> +    block::mq::{request::RequestDataWrapper, Request},
>     error::{from_result, Result},
>     prelude::*,
> -    types::ARef,
> +    types::{ARef, ForeignOwnable},
> };
> use core::{marker::PhantomData, sync::atomic::AtomicU64, =
sync::atomic::Ordering};
>=20
> +type ForeignBorrowed<'a, T> =3D <T as ForeignOwnable>::Borrowed<'a>;
> +
> /// Implement this trait to interface blk-mq as block devices.
> ///
> /// To implement a block device driver, implement this trait as =
described in the
> @@ -26,12 +27,20 @@
> /// [module level documentation]: kernel::block::mq
> #[macros::vtable]
> pub trait Operations: Sized {
> +    /// Data associated with the `struct request_queue` that is =
allocated for
> +    /// the `GenDisk` associated with this `Operations` =
implementation.
> +    type QueueData: ForeignOwnable;
> +
>     /// Called by the kernel to queue a request with the driver. If =
`is_last` is
>     /// `false`, the driver is allowed to defer committing the =
request.
> -    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
> +    fn queue_rq(
> +        queue_data: ForeignBorrowed<'_, Self::QueueData>,
> +        rq: ARef<Request<Self>>,
> +        is_last: bool,
> +    ) -> Result;
>=20
>     /// Called by the kernel to indicate that queued requests should =
be submitted.
> -    fn commit_rqs();
> +    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
>=20
>     /// Called by the kernel to poll the device for completed =
requests. Only
>     /// used for poll queues.
> @@ -70,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>     ///   promise to not access the request until the driver calls
>     ///   `bindings::blk_mq_end_request` for the request.
>     unsafe extern "C" fn queue_rq_callback(
> -        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        hctx: *mut bindings::blk_mq_hw_ctx,
>         bd: *const bindings::blk_mq_queue_data,
>     ) -> bindings::blk_status_t {
>         // SAFETY: `bd.rq` is valid as required by the safety =
requirement for
> @@ -88,10 +97,20 @@ impl<T: Operations> OperationsVTable<T> {
>         //    reference counted by `ARef` until then.
>         let rq =3D unsafe { Request::aref_from_raw((*bd).rq) };
>=20
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data =3D unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by =
`GenDisk::try_new()` with a

isn=E2=80=99t this set on build() ?

> +        // call to `ForeignOwnable::into_pointer()` to create =
`queuedata`.

into_pointer() ?

> +        // `ForeignOwnable::from_foreign()` is only called when the =
tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data =3D unsafe { T::QueueData::borrow(queue_data) =
};
> +
>         // SAFETY: We have exclusive access and we just set the =
refcount above.
>         unsafe { Request::start_unchecked(&rq) };
>=20
>         let ret =3D T::queue_rq(
> +            queue_data,
>             rq,
>             // SAFETY: `bd` is valid as required by the safety =
requirement for
>             // this function.
> @@ -110,9 +129,18 @@ impl<T: Operations> OperationsVTable<T> {
>     ///
>     /// # Safety
>     ///
> -    /// This function may only be called by blk-mq C infrastructure.
> -    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut =
bindings::blk_mq_hw_ctx) {
> -        T::commit_rqs()
> +    /// This function may only be called by blk-mq C infrastructure. =
The caller
> +    /// must ensure that `hctx` is valid.
> +    unsafe extern "C" fn commit_rqs_callback(hctx: *mut =
bindings::blk_mq_hw_ctx) {
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data =3D unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by =
`GenDisk::try_new()` with a
> +        // call to `ForeignOwnable::into_pointer()` to create =
`queuedata`.

into_foreign()?

> +        // `ForeignOwnable::from_foreign()` is only called when the =
tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data =3D unsafe { T::QueueData::borrow(queue_data) =
};
> +        T::commit_rqs(queue_data)
>     }
>=20
>     /// This function is called by the C kernel. It is not currently
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


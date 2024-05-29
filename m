Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD1125C0
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987156; cv=none; b=pA/6G3xI84UWyvQfI7tBTCO629ftPqxthSkdlZPdvafUcLCr3ess4wqPas9mwAPnItGYJdeYUl6vP/lhbBev3+FSMsRq7E1W0h2CFN18PC1SfCIMmp76w30iG74DVwhchLO4FcQzxuiL4ICKMg0b4KcAHGL/wZpOBwHBwGKBNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987156; c=relaxed/simple;
	bh=sx0V1RlpE4jsP8NDWgQtt5cEV03Pe3nSUsYBP96HH5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leoIG6K+P8R8+pMAI7nahcmY32Nz/MIzE7Zq0me0nbsLXmM9VrukmAEydtN0ZKIZANSUDg+qVxy/mzSOu9xV2GlhueI7N2OJocTQsTdQyCxbgruRXZXhZmZ8sbhFpFBUX192RSLC/4/MwWD0A3GXHTwZLt+oo1dzdzcAJXLzgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=E5MRmwGW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="E5MRmwGW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a609dd3fso163700166b.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2024 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716987151; x=1717591951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiXL7bhrCvXqbeEIWwktCoIVvN4IeH3qgQ1FGOcHxug=;
        b=E5MRmwGWPQHNpEzlWR8PTzRS8cYsd78xx8eJNLqep8Ln6PEqnknlbNaOKeoVxx9KaF
         wOA1uQKRO+6xnP2tC/w70+lKlKBfDUptZca6gyIh6Nh32KXGcECbI+5YGV9AvPGvkXMH
         h3/CSUbewY1yRIrHavzehKmnDrmn1izdy+a3cFGSUQQFynCTWHxd8BnfCsBJd3H6BxdO
         hpG1w3ozDw79ntGgjM9tKVcQkfQ2+dgBC+CZtCPOeGfKgI25unirKnexF5JLSNJwGLmi
         rWUH5ufxNg/Aw0XxMVObYjJL2eLnZ1pThecbPj/TgoCY/H1nf9g4RjXCVBryf99JMY1Q
         So7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987151; x=1717591951;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiXL7bhrCvXqbeEIWwktCoIVvN4IeH3qgQ1FGOcHxug=;
        b=oB//4VyW8pjw4RmFd5UnkecdsWmJHoIHgMYoCKx5HaQ9rYyVvAGa267BdtCmOXnUL6
         kJzmWx7ASMaGf3UuwxTEa+K6o2cVXNndR/Qes4K32U+pulI5sMm19Y5RN2lq7S917CD1
         IbK/6RPgXN255gfdwr9sjhnuh2jqe8QSPBjN3b4+9SO/SGJPu9JX2mKoPF5gh9ybFv/E
         Nx6EBcklI7Ks03oTH79tAdgPXQ3IT8pzuvT0S4zLjyKhv+fhd8/fFiqdLFTB1XLLA1P1
         K+jkunZl7mtZwio7uRe1D2pFVynQ74u9kR7driVCkbI3N2aFV181xUhi1qFNcnHWtuxN
         2cQw==
X-Forwarded-Encrypted: i=1; AJvYcCWeOgKCYFfLjI9+95zsrr1XwPx9eebPC+8+RGSM5PXeFW7CPnkMbkobSzEK8kspaJ//O/7ziKVHaX3OjIYy1m5vYH+MCCJAczNqQ4c=
X-Gm-Message-State: AOJu0YyDk9AECxNaKVrI6/JHznMqUV0PNZxSL63nxKsaLcAXuT6FLiei
	lvPLLE/VUnroEs0hb5k0tBdpq8MJk6/2sXOD7EVl0PNoBvQpHOLdpyRFPomt1ZI=
X-Google-Smtp-Source: AGHT+IFOcOa/ZeI0k+ldgtGrsNCdpNNjQmFAsYjrkqHJlPeqrEoC0LWUJHsH6kCYHdPUrVJUooi0Mw==
X-Received: by 2002:a17:906:3143:b0:a63:f0c8:68f8 with SMTP id a640c23a62f3a-a642da90b6cmr163192366b.32.1716987150811;
        Wed, 29 May 2024 05:52:30 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cd87281sm713680566b.157.2024.05.29.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:52:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,  Bart Van
 Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v2 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <2d2689e7-7052-4a92-b6fb-37f25fd05810@proton.me> (Benno Lossin's
	message of "Tue, 28 May 2024 13:24:32 +0000")
References: <20240521140323.2960069-1-nmi@metaspace.dk>
	<20240521140323.2960069-2-nmi@metaspace.dk>
	<2d2689e7-7052-4a92-b6fb-37f25fd05810@proton.me>
Date: Wed, 29 May 2024 14:52:15 +0200
Message-ID: <87sey0rda8.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

> On 21.05.24 16:03, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>

[...]

>> >> +
>> +//! This module provides types for implementing block drivers that inte=
rface the
>> +//! blk-mq subsystem.
>> +//!
>> +//! To implement a block device driver, a Rust module must do the follo=
wing:
>> +//!
>> +//! - Implement [`Operations`] for a type `T`
>> +//! - Create a [`TagSet<T>`]
>> +//! - Create a [`gen_disk::GenDisk<T>`], passing in the `TagSet` refere=
nce
>
> I would use short links [`GenDisk<T>`].

`GenDisk` is not in scope, so short link is not working. But I can do
whatever this is called:


//! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
...
//! [`GenDisk<T>`]: gen_disk::GenDisk

Would you prefer that?

>
>> +//! - Add the disk to the system by calling [`gen_disk::GenDisk::add`]
>> +//!
>> +//! The types available in this module that have direct C counterparts =
are:
>> +//!
>> +//! - The `TagSet` type that abstracts the C type `struct tag_set`.
>
> Missing link? (also below)

`TagSet` was linked above. Would you link it on each mention?

[...]

>> +//!
>> +//!     fn commit_rqs(
>> +//!     ) {
>> +//!     }
>
> Formatting.

I would love if `rustfmt` would do this. But I think it is both unstable
and broken for examples like this [1]. I'll fix it up by hand.

How do you manage formatting in examples? By hand?

[...]

>> +/// A generic block device.
>> +///
>> +/// # Invariants
>> +///
>> +///  - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
>> +pub struct GenDisk<T: Operations, S: GenDiskState> {
>
> Does it make sense to do `S: GenDiskState =3D Added`?

Yes, that would make sense.

>
>> +    _tagset: Arc<TagSet<T>>,
>
> Does this really need a leading underscore?

It does not.

>
>> +    gendisk: *mut bindings::gendisk,
>> +    _phantom: core::marker::PhantomData<S>,
>> +}
>> +
>> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `=
Arc` to a
>> +// `TagSet` It is safe to send this to other threads as long as T is Se=
nd.
>> +unsafe impl<T: Operations + Send, S: GenDiskState> Send for GenDisk<T, =
S> {}
>> +
>> +/// Disks in this state are allocated and initialized, but are not yet
>> +/// accessible from the kernel VFS.
>> +pub enum Initialized {}
>> +
>> +/// Disks in this state have been attached to the kernel VFS and may re=
ceive IO
>> +/// requests.
>> +pub enum Added {}
>> +
>> +/// Typestate representing states of a `GenDisk`.
>> +pub trait GenDiskState {}
>
> Should this trait be sealed?

Yes.

>
>> +
>> +impl GenDiskState for Initialized {}
>> +impl GenDiskState for Added {}
>> +
>> +impl<T: Operations> GenDisk<T, Initialized> {
>> +    /// Register the device with the kernel. When this function returns=
, the
>> +    /// device is accessible from VFS. The kernel may issue reads to th=
e device
>> +    /// during registration to discover partition information.
>> +    pub fn add(self) -> Result<GenDisk<T, Added>> {
>> +        crate::error::to_result(
>> +            // SAFETY: By type invariant, `self.gendisk` points to a va=
lid and
>> +            // initialized instance of `struct gendisk`
>> +            unsafe {
>> +                bindings::device_add_disk(
>> +                    core::ptr::null_mut(),
>> +                    self.gendisk,
>> +                    core::ptr::null_mut(),
>> +                )
>> +            },
>> +        )?;
>> +
>> +        // We don't want to run the destuctor and remove the device fro=
m the VFS
>> +        // when `disk` is dropped.
>> +        let mut old =3D core::mem::ManuallyDrop::new(self);
>> +
>> +        let new =3D GenDisk {
>> +            _tagset: old._tagset.clone(),
>> +            gendisk: old.gendisk,
>> +            _phantom: PhantomData,
>> +        };
>> +
>> +        // But we have to drop the `Arc` or it will leak.
>> +        // SAFETY: `old._tagset` is valid for write, aligned, non-null,=
 and we
>> +        // have exclusive access. We are not accessing the value again =
after it
>> +        // is dropped.
>> +        unsafe { core::ptr::drop_in_place(&mut old._tagset) };
>> +
>> +        Ok(new)
>
> Instead of using `ManuallyDrop` and `drop_in_place` why not use
> `transmute`? I feel like that would be a lot simpler.

I was considering the layout not being deterministic for `repr(Rust)`. I
think that in practice it will be the case that the two types will have
the same layout, but I could not find the documentation that states
this. Nomicon does not talk about zero sized types [2].

[...]

>> +impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
>> +    /// Call to tell the block layer the capacity of the device in sect=
ors (512
>> +    /// bytes).
>> +    pub fn set_capacity_sectors(&self, sectors: u64) {
>> +        // SAFETY: By type invariant, `self.gendisk` points to a valid =
and
>> +        // initialized instance of `struct gendisk`. Callee takes a loc=
k to
>
> By `Callee`, do you mean `set_capacity`? If so, I would prefer that.

Yes. I will update.

[...]

>> +impl<T: Operations, S: GenDiskState> Drop for GenDisk<T, S> {
>> +    fn drop(&mut self) {
>> +        // TODO: This will `WARN` if the disk was not added. Since we c=
annot
>> +        // specialize drop, we have to call it, or track state with a f=
lag.
>
> You could add an associated constant to GenDiskState and then write the
> following:
>
>     if <S as GenDiskState>::DELETE_ON_DROP {
>         /* del_gendisk ... */
>     }
>
> Then the check is essentially done at compile-time.

Thanks, this is very useful. I will add it.

>
>> +
>> +        // SAFETY: By type invariant, `self.gendisk` points to a valid =
and
>> +        // initialized instance of `struct gendisk`
>> +        unsafe { bindings::del_gendisk(self.gendisk) };
>> +    }
>> +}
>> +
>> +/// Try to create a new `GenDisk`.
>> +pub fn try_new<T: Operations>(tagset: Arc<TagSet<T>>) -> Result<GenDisk=
<T, Initialized>> {
>
> Why is this not inside of an `impl` block of `GenDisk<T, Initialized>`?

No particular reason. I should probably move it.

[...]

>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/o=
perations.rs
>> new file mode 100644
>> index 000000000000..3bd1af2c2260
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -0,0 +1,245 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides an interface for blk-mq drivers to implement.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::request::RequestDataWrapper,
>> +    block::mq::Request,
>> +    error::{from_result, Result},
>> +    types::ARef,
>> +};
>> +use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::=
Ordering};
>> +
>> +/// Implement this trait to interface blk-mq as block devices.
>> +///
>> +/// To implement a block device driver, implement this trait as describ=
ed in the
>> +/// [module level documentation]. The kernel will use the implementatio=
n of the
>> +/// functions defined in this trait to interface a block device driver.=
 Note:
>> +/// There is no need for an exit_request() implementation, because the =
`drop`
>> +/// implementation of the [`Request`] type will be invoked by automatic=
ally by
>> +/// the C/Rust glue logic.
>
> This text is wrapped to 80 columns, but our usual wrapping is 100.

This had me scratch my head for a bit. I run `make rustfmt` and `make
rustfmtcheck`, so I had no idea why my code would be formatted
incorrect. It took me a while to figure out that we are not enabling
`comment_width =3D 100`, presumably because it is an unstable `rustfmt`
feature. I am not sure what the correct way to enable it but I hacked
the Makefile and enabled it. It gives a huge diff all across the kernel
crate.

So, it seems we _are_ in fact using 80 line fill column, since that is
what much of our existing code is using, and that is what the build
system is configured to use.

Where did you come across the 100 character fill column?

Anyways, we should configure our tools to the standard we want. I don't
care if it's 80 or 100, as long as I can have the tools do the job for
me.

Let's discuss this at next meeting.

>
>> +///
>> +/// [module level documentation]: kernel::block::mq
>> +#[macros::vtable]
>> +pub trait Operations: Sized {
>> +    /// Called by the kernel to queue a request with the driver. If `is=
_last` is
>> +    /// `false`, the driver is allowed to defer committing the request.
>> +    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
>> +
>> +    /// Called by the kernel to indicate that queued requests should be=
 submitted.
>> +    fn commit_rqs();
>> +
>> +    /// Called by the kernel when the request is completed.
>> +    fn complete(_rq: ARef<Request<Self>>);
>
> Is there a reason for the `_`?

Copy pasta probably. Will remove.

>
> To me it seems this is called when the given request is already done, so
> would it make more sense to name it `completed` or `on_completion`?

I would agree. But we had a bit of discussion at LSF about naming things
differently in Rust vs C. C people prefer if we keep the C names, even
if they do not make sense to the people who write the new Rust code.

In C, the vtable entry is called `complete_callback` and the called
symbol is usually `my_driver_complete_rq`.

We could go with `completed`, `completed_callback`, or `complete_rq`.
Although `completed` sounds like it should return a bool indicating
whether the request was already completed.

I think I'll leave it for now, and we can always change it if we come up
with a really good name.

>
>> +
>> +    /// Called by the kernel to poll the device for completed requests.=
 Only
>> +    /// used for poll queues.
>> +    fn poll() -> bool {
>> +        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
>> +    }
>> +}
>> +
>> +/// A vtable for blk-mq to interact with a block device driver.
>> +///
>> +/// A `bindings::blk_mq_opa` vtable is constructed from pointers to the=
 `extern
>> +/// "C"` functions of this struct, exposed through the `OperationsVTabl=
e::VTABLE`.
>> +///
>> +/// For general documentation of these methods, see the kernel source
>> +/// documentation related to `struct blk_mq_operations` in
>> +/// [`include/linux/blk-mq.h`].
>> +///
>> +/// [`include/linux/blk-mq.h`]: srctree/include/linux/blk-mq.h
>> +pub(crate) struct OperationsVTable<T: Operations>(PhantomData<T>);
>> +
>> +impl<T: Operations> OperationsVTable<T> {
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - The caller of this function must ensure `bd` is valid
>> +    ///   and initialized. The pointees must outlive this function.
>> +    /// - This function must not be called with a `hctx` for which
>> +    ///   `Self::exit_hctx_callback()` has been called.
>> +    /// - (*bd).rq must point to a valid `bindings:request` for which
>> +    ///   `OperationsVTable<T>::init_request_callback` was called
>> +    unsafe extern "C" fn queue_rq_callback(
>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        bd: *const bindings::blk_mq_queue_data,
>> +    ) -> bindings::blk_status_t {
>> +        // SAFETY: `bd.rq` is valid as required by the safety requireme=
nt for
>> +        // this function.
>> +        let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
>> +
>> +        // One refcount for the ARef, one for being in flight
>> +        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
>> +
>> +        let rq =3D
>> +        // SAFETY: We own a refcount that we took above. We pass that t=
o `ARef`.
>> +        // By the safety requirements of this function, `request` is a =
valid
>> +        // `struct request` and the private data is properly initialize=
d.
>> +            unsafe {Request::aref_from_raw((*bd).rq)};
>
> Can you put the SAFETY comment above the line, then the formatting is
> more natural.

Yes.

>
>> +
>> +        // SAFETY: We have exclusive access and we just set the refcoun=
t above.
>> +        unsafe { Request::start_unchecked(&rq) };
>> +
>> +        let ret =3D T::queue_rq(
>> +            rq,
>> +            // SAFETY: `bd` is valid as required by the safety requirem=
ent for this function.
>> +            unsafe { (*bd).last },
>> +        );
>> +
>> +        if let Err(e) =3D ret {
>> +            e.to_blk_status()
>> +        } else {
>> +            bindings::BLK_STS_OK as _
>> +        }
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_=
mq_hw_ctx) {
>> +        T::commit_rqs()
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure. `r=
q` must
>> +    /// point to a valid request that has been marked as completed. The=
 pointee
>> +    /// of `rq` must be valid for write for the duration of this functi=
on.
>> +    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
>> +        // SAFETY: This function can only be dispatched through
>> +        // `Request::complete`. We leaked a refcount then which we pick=
 back up
>> +        // now.
>
> What do you mean by the first sentence? Where was this refcount leaked?

I can understand why you are confused. `Request::complete` is in my
outgoing patch queue. There is no way to call this function in this
patch. I will move it to a later patch. Thanks.

[...]

>> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/r=
aw_writer.rs
>> new file mode 100644
>> index 000000000000..4f7e4692b592
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/raw_writer.rs
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use core::fmt::{self, Write};
>> +
>> +use crate::error::Result;
>> +use crate::prelude::EINVAL;
>> +
>> +/// A mutable reference to a byte buffer where a string can be written =
into.
>> +///
>> +/// # Invariants
>> +///
>> +/// `buffer` is always null terminated.
>
> I don't know how valuable this would be, but you could only ask for this
> invariant, if `buffer` is non-empty. Then you could have the `new` and
> `from_array` functions return a `RawWriter` without result.

I think guaranteeing at least a null character is always written by
`write_str` is a good thing. It is used for writing C strings to device
name fields. `write_str` with a zero size buffer would give undesirable
results, and is probably not what the caller wants.

>
>> +pub(crate) struct RawWriter<'a> {
>> +    buffer: &'a mut [u8],
>> +    pos: usize,
>> +}
>> +
>> +impl<'a> RawWriter<'a> {
>> +    /// Create a new `RawWriter` instance.
>> +    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
>> +        *(buffer.last_mut().ok_or(EINVAL)?) =3D 0;
>> +
>> +        // INVARIANT: We null terminated the buffer above
>
> Missing `.`.

=F0=9F=91=8D

[...]

>> +impl<T: Operations> Request<T> {
>> +    /// Create an `ARef<Request>` from a `struct request` pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// * The caller must own a refcount on `ptr` that is transferred t=
o the
>> +    ///   returned `ARef`.
>> +    /// * The type invariants for `Request` must hold for the pointee o=
f `ptr`.
>> +    pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> =
ARef<Self> {
>> +        // INVARIANTS: By the safety requirements of this function, inv=
ariants are upheld.
>
> Typo: INVARIANTS -> INVARIANT

=F0=9F=91=8D

>
>> +        // SAFETY: By the safety requirement of this function, we own a
>> +        // reference count that we can pass to `ARef`.
>> +        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Se=
lf as *mut Self)) }
>> +    }
>> +
>> +    /// Notify the block layer that a request is going to be processed =
now.
>> +    ///
>> +    /// The block layer uses this hook to do proper initializations suc=
h as
>> +    /// starting the timeout timer. It is a requirement that block devi=
ce
>> +    /// drivers call this function when starting to process a request.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must have exclusive ownership of `self`, that is
>> +    /// `self.wrapper_ref().refcount() =3D=3D 2`.
>> +    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>> +        unsafe { bindings::blk_mq_start_request(this.0.get()) };
>> +    }
>> +
>> +    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>> {
>> +        // We can race with `TagSet::tag_to_rq`
>> +        match this.wrapper_ref().refcount().compare_exchange(
>> +            2,
>> +            0,
>> +            Ordering::Relaxed,
>> +            Ordering::Relaxed,
>> +        ) {
>> +            Err(_old) =3D> Err(this),
>> +            Ok(_) =3D> Ok(this),
>> +        }
>> +    }
>> +
>> +    /// Notify the block layer that the request has been completed with=
out errors.
>> +    ///
>> +    /// This function will return `Err` if `this` is not the only `ARef`
>> +    /// referencing the request.
>> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>
> I am not yet fully convinced that this is the way we should go. I think
> I would have to see a more complex usage of `Request` with that id <->
> request mapping that you mentioned. Because with how rnull uses this
> API, it could also have a `URef<Self>` parameter (URef :=3D unique ARef).

I considered a `UniqueARef` but it would just move the error handing to
`ARef::into_unique` and then make `end_ok` infallible.

There are four states for a request that we need to track:

A) Request is owned by block layer (refcount 0)
B) Request is owned by driver but with zero `ARef`s in existence
   (refcount 1)
C) Request is owned by driver with exactly one `ARef` in existence
   (refcount 2)
D) Request is owned by driver with more than one `ARef` in existence
   (refcount > 2)

It is in the doc comments for `RequestDataWrapper` as well.

We need A and B to ensure we fail tag to request conversions for
requests that are not owned by the driver.

We need C and D to ensure that it is safe to end the request and hand back
ownership to the block layer.

I will ping you when I hook up the NVMe driver with this.

>
>> +        let this =3D Self::try_set_end(this)?;
>> +        let request_ptr =3D this.0.get();
>> +        core::mem::forget(this);
>
> Would be a good idea to mention who is going to own this refcount.

The refcount is zero after `try_set_end`, so there is no owner of the
count. The request will be in state A and thus block layer owns the
request. Block layer does not honor this refcount, it is only for the
driver to know.

Perhaps I should move the explanation up into the docs for `Request`.

>
>> +
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BL=
K_STS_OK as _) };
>> +
>> +        Ok(())
>> +    }
>> +
>> +    /// Return a pointer to the `RequestDataWrapper` stored in the priv=
ate area
>> +    /// of the request structure.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - `this` must point to a valid allocation.
>> +    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<Reques=
tDataWrapper> {
>> +        let request_ptr =3D this.cast::<bindings::request>();
>> +        let wrapper_ptr =3D
>> +            // SAFETY: By safety requirements for this function, `this`=
 is a
>> +            // valid allocation.
>> +            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<Req=
uestDataWrapper>() };
>> +        // SAFETY: By C api contract, wrapper_ptr points to a valid all=
ocation
>> +        // and is not null.
>> +        unsafe { NonNull::new_unchecked(wrapper_ptr) }
>> +    }
>> +
>> +    /// Return a reference to the `RequestDataWrapper` stored in the pr=
ivate
>> +    /// area of the request structure.
>> +    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
>> +        // SAFETY: By type invariant, `self.0` is a valid alocation. Fu=
rther,
>> +        // the private data associated with this request is initialized=
 and
>> +        // valid. The existence of `&self` guarantees that the private =
data is
>> +        // valid as a shared reference.
>> +        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as=
_ref() }
>> +    }
>> +}
>> +
>> +/// A wrapper around data stored in the private area of the C `struct r=
equest`.
>> +pub(crate) struct RequestDataWrapper {
>
> Why is this called `Wrapper`? It doesn't really wrap anything,
> `RequestData` seems fine.

It will eventually wrap private data associated with the request. Those
patches will be submitted later. Should I change the name in the
meanwhile?

>
>> +    /// The Rust request refcount has the following states:
>> +    ///
>> +    /// - 0: The request is owned by C block layer.
>> +    /// - 1: The request is owned by Rust abstractions but there are no=
 ARef references to it.
>> +    /// - 2+: There are `ARef` references to the request.
>> +    refcount: AtomicU64,
>> +}
>> +
>> +impl RequestDataWrapper {
>> +    /// Return a reference to the refcount of the request that is embed=
ding
>> +    /// `self`.
>> +    pub(crate) fn refcount(&self) -> &AtomicU64 {
>> +        &self.refcount
>> +    }
>> +
>> +    /// Return a pointer to the refcount of the request that is embeddi=
ng the
>> +    /// pointee of `this`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - `this` must point to a live allocation of at least the size o=
f `Self`.
>> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU6=
4 {
>> +        // SAFETY: Because of the safety requirements of this function,=
 the
>> +        // field projection is safe.
>> +        unsafe { addr_of_mut!((*this).refcount) }
>> +    }
>> +}
>> +
>> +// SAFETY: Exclusive access is thread-safe for `Request`. `Request` has=
 no `&mut
>> +// self` methods and `&self` methods that mutate `self` are internally
>> +// synchronzied.
>> +unsafe impl<T: Operations> Send for Request<T> {}
>> +
>> +// SAFETY: Shared access is thread-safe for `Request`. `&self` methods =
that
>> +// mutate `self` are internally synchronized`
>> +unsafe impl<T: Operations> Sync for Request<T> {}
>> +
>> +/// Store the result of `op(target.load())` in target, returning new va=
lue of
>> +/// taret.
>> +fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64=
) -> u64 {
>> +    let mut old =3D target.load(Ordering::Relaxed);
>> +    loop {
>> +        match target.compare_exchange_weak(old, op(old), Ordering::Rela=
xed, Ordering::Relaxed) {
>> +            Ok(_) =3D> break,
>> +            Err(x) =3D> {
>> +                old =3D x;
>> +            }
>> +        }
>> +    }
>
> This seems like a reimplementation of `AtomicU64::fetch_update` to me.

It looks like it! Except this function is returning the updated value,
`fetch_update` is returning the old value.

Would you rather that I rewrite in terms of the library function?

>
>> +
>> +    op(old)
>> +}
>> +
>> +/// Store the result of `op(target.load)` in `target` if `target.load()=
 !=3D
>> +/// pred`, returning previous value of target
>> +fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64=
, pred: u64) -> bool {
>> +    let x =3D target.load(Ordering::Relaxed);
>> +    loop {
>> +        if x =3D=3D pred {
>> +            break;
>> +        }
>> +        if target
>> +            .compare_exchange_weak(x, op(x), Ordering::Relaxed, Orderin=
g::Relaxed)
>> +            .is_ok()
>> +        {
>> +            break;
>> +        }
>> +    }
>> +
>> +    x =3D=3D pred
>> +}
>> +
>> +// SAFETY: All instances of `Request<T>` are reference counted. This
>> +// implementation of `AlwaysRefCounted` ensure that increments to the r=
ef count
>> +// keeps the object alive in memory at least until a matching reference=
 count
>> +// decrement is executed.
>> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>> +    fn inc_ref(&self) {
>> +        let refcount =3D &self.wrapper_ref().refcount();
>> +
>> +        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
>
> Another option would be to use `_updated` as the name of the variable. I
> personally would prefer that. What do you guys think?

Either way is fine by me.

[...]

>> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_=
set.rs
>> new file mode 100644
>> index 000000000000..4217c2b03ff3
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides the `TagSet` struct to wrap the C `struct blk_=
mq_tag_set`.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
>> +
>> +use core::pin::Pin;
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::request::RequestDataWrapper,
>> +    block::mq::{operations::OperationsVTable, Operations},
>> +    error::{self, Error, Result},
>> +    prelude::PinInit,
>> +    try_pin_init,
>> +    types::Opaque,
>> +};
>> +use core::{convert::TryInto, marker::PhantomData};
>> +use macros::{pin_data, pinned_drop};
>> +
>> +/// A wrapper for the C `struct blk_mq_tag_set`.
>> +///
>> +/// `struct blk_mq_tag_set` contains a `struct list_head` and so must b=
e pinned.
>> +#[pin_data(PinnedDrop)]
>> +#[repr(transparent)]
>> +pub struct TagSet<T: Operations> {
>> +    #[pin]
>> +    inner: Opaque<bindings::blk_mq_tag_set>,
>> +    _p: PhantomData<T>,
>> +}
>> +
>> +impl<T: Operations> TagSet<T> {
>> +    /// Try to create a new tag set
>> +    pub fn try_new(
>> +        nr_hw_queues: u32,
>> +        num_tags: u32,
>> +        num_maps: u32,
>> +    ) -> impl PinInit<Self, error::Error> {
>> +        try_pin_init!( TagSet {
>> +            inner <- unsafe {kernel::init::pin_init_from_closure(move |=
place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
>
> We currently do not have `Opaque::try_ffi_init`, I vaguely remember that
> we talked about it. Do you mind adding it? Otherwise I can also send a
> patch.

I have a `try_ffi_init` patch queued. I removed it from here to cut
dependencies. I will submit it soon after this is in.

>
>> +                let place =3D place.cast::<bindings::blk_mq_tag_set>();
>> +
>> +                // SAFETY: try_ffi_init promises that `place` is writab=
le, and
>> +                // zeroes is a valid bit pattern for this structure.
>> +                core::ptr::write_bytes(place, 0, 1);
>> +
>> +                /// For a raw pointer to a struct, write a struct field=
 without
>> +                /// creating a reference to the field
>> +                macro_rules! write_ptr_field {
>> +                    ($target:ident, $field:ident, $value:expr) =3D> {
>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((*=
$target).$field), $value)
>> +                    };
>> +                }
>> +
>> +                // SAFETY: try_ffi_init promises that `place` is writab=
le
>> +                    write_ptr_field!(place, ops, OperationsVTable::<T>:=
:build());
>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues=
);
>> +                    write_ptr_field!(place, timeout , 0); // 0 means de=
fault which is 30 * HZ in C
>> +                    write_ptr_field!(place, numa_node , bindings::NUMA_=
NO_NODE);
>> +                    write_ptr_field!(place, queue_depth , num_tags);
>> +                    write_ptr_field!(place, cmd_size , core::mem::size_=
of::<RequestDataWrapper>().try_into()?);
>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_=
SHOULD_MERGE);
>> +                    write_ptr_field!(place, driver_data , core::ptr::nu=
ll_mut::<core::ffi::c_void>());
>> +                    write_ptr_field!(place, nr_maps , num_maps);
>
> I think that there is some way for pinned-init to do a better job here.
> I feel like we ought to be able to just write:
>
>     Opaque::init(
>         try_init!(bindings::blk_mq_tag_set {
>             ops: OperationsVTable::<T>::build(),
>             nr_hw_queues,
>             timeout: 0, // 0 means default, which is 30Hz
>             numa_node: bindings::NUMA_NO_NODE,
>             queue_depth: num_tags,
>             cmd_size: size_of::<RequestDataWrapper>().try_into()?,
>             flags: bindings::BLK_MQ_F_SHOULD_MERGE,
>             driver_data: null_mut(),
>             nr_maps: num_maps,
>             ..Zeroable::zeroed()
>         }? Error)
>         .chain(|tag_set| to_result(bindings::blk_mq_alloc_tag_set(tag_set=
)))
>     )
>
> But we don't have `Opaque::init` (shouldn't be difficult) and
> `bindings::blk_mq_tag_set` doesn't implement `Zeroable`. We would need
> bindgen to put `derive(Zeroable)` on certain structs...
>
> Another option would be to just list the fields explicitly, since there
> aren't that many. What do you think?

Both options sound good. Ofc the first one sounds more user friendly
while the latter one sounds easier to implement. Getting rid of the
unsafe blocks here would be really nice.

>
>> +
>> +                // SAFETY: Relevant fields of `place` are initialised a=
bove
>> +                let ret =3D bindings::blk_mq_alloc_tag_set(place);
>> +                if ret < 0 {
>> +                    return Err(Error::from_errno(ret));
>> +                }
>> +
>> +                Ok(())
>> +            })},
>> +            _p: PhantomData,
>> +        })
>> +    }
>> +
>> +    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
>> +    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
>> +        self.inner.get()
>> +    }
>> +}
>> +
>> +#[pinned_drop]
>> +impl<T: Operations> PinnedDrop for TagSet<T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: We are not moving self below
>> +        let this =3D unsafe { Pin::into_inner_unchecked(self) };
>
> You don't need to unwrap the `Pin`, since you only need access to `&Self`
> and `Pin` always allows you to do that. (so just use `self` instead of
> `this` below)

Thanks =F0=9F=91=8D

>
>> +
>> +        // SAFETY: `inner` is valid and has been properly initialised d=
uring construction.
>
> Should be an invariant.

Ok =F0=9F=91=8D

Thanks for the review! I will send a new version.


Best regards,
Andreas


[1] https://github.com/rust-lang/rustfmt/issues/3348
[2] https://doc.rust-lang.org/nomicon/repr-rust.html#reprrust

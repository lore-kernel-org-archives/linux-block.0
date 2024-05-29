Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8056A016
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006071; cv=none; b=GYMRbcjcWB73p0ZWZv3C90p8DaS6Ggf3HDHwU8WXf10OBFF/95D9zQUiJcYQ8F+cwz7891NJt71KjnGh8yUHbTCgJOkNi16s1N5eIhVp5Glqwg0b44EBbfwD53AU6cAY3hZ3YlqHC5ukpN9eaN40YEWtNGICM+mJcATG3wq9/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006071; c=relaxed/simple;
	bh=XDLYvL047fgSFh4KfG4f1bwyxaaOQTZiSzYw1pWTRaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVpwPAyMJHiZnf9r6lKT322TwQCWyvudI+SnRXNKfDjiX4qDId0kb1NxYbTptAozjcBidjF+q76IDM2g+8NtV3cX3ViFW4wi1t6MJcbOPihCvC9zhsBJe96jjWrq7EdQOLfQJ1L+HERAJy28CyjeKFjZdYPRi1ZCnCuK6ly0bE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LWMnqDz8; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LWMnqDz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7scin46c7jatxcwxrro7pcb72i.protonmail; t=1717006059; x=1717265259;
	bh=9Hu7NQkgD3QTGjHaSy/nLBTtgh42YxiP4FTMBrecY5w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LWMnqDz8RZoBCVPEQi04HjSIPUkbmx9R6YdXmqvyiQPU19BN8raZAixmqgoWLWOII
	 RGT9k6xQLco4RftL3iq35THXk5KrzQGYvsX61VMSKo8E1kypEZbVWASE9uukoRDrPY
	 o4coJoM5PF1ijMmylZkUXgWZx8SbDq9ZBMyjAotimu6Oe2lJkEcXb+jNezjvdOAUz5
	 G26xaPI/jZragXgXH/mD52TlsseViWwub5sN1gWFQFa/u5NuIWy2ZlF+dZd4vBagjN
	 dKcNwqlAbNBd5MCVSB7YiAlU/UOfKTiTJADu1dhouyXDqboRyG89e+Ny9NvMdKYiUM
	 C+GJdBBZLm2Wg==
Date: Wed, 29 May 2024 18:07:33 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <29e31afd-c10f-4262-82ef-d0e3599753ea@proton.me>
In-Reply-To: <87sey0rda8.fsf@metaspace.dk>
References: <20240521140323.2960069-1-nmi@metaspace.dk> <20240521140323.2960069-2-nmi@metaspace.dk> <2d2689e7-7052-4a92-b6fb-37f25fd05810@proton.me> <87sey0rda8.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7052567407e042c1f95f9f22d3346922410cf7b4
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.05.24 14:52, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 21.05.24 16:03, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> [...]
>=20
>>>>> +
>>> +//! This module provides types for implementing block drivers that int=
erface the
>>> +//! blk-mq subsystem.
>>> +//!
>>> +//! To implement a block device driver, a Rust module must do the foll=
owing:
>>> +//!
>>> +//! - Implement [`Operations`] for a type `T`
>>> +//! - Create a [`TagSet<T>`]
>>> +//! - Create a [`gen_disk::GenDisk<T>`], passing in the `TagSet` refer=
ence
>>
>> I would use short links [`GenDisk<T>`].
>=20
> `GenDisk` is not in scope, so short link is not working. But I can do
> whatever this is called:
>=20
>=20
> //! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
> ...
> //! [`GenDisk<T>`]: gen_disk::GenDisk
>=20
> Would you prefer that?

Yes that is what I had in mind.

>>> +//! - Add the disk to the system by calling [`gen_disk::GenDisk::add`]
>>> +//!
>>> +//! The types available in this module that have direct C counterparts=
 are:
>>> +//!
>>> +//! - The `TagSet` type that abstracts the C type `struct tag_set`.
>>
>> Missing link? (also below)
>=20
> `TagSet` was linked above. Would you link it on each mention?

I think that is more resilient to doc updates (eg if the mention above
is removed, then there would be no link). Also the reader won't have to
search for a different, linked location of the same thing.

> [...]
>=20
>>> +//!
>>> +//!     fn commit_rqs(
>>> +//!     ) {
>>> +//!     }
>>
>> Formatting.
>=20
> I would love if `rustfmt` would do this. But I think it is both unstable
> and broken for examples like this [1]. I'll fix it up by hand.
>=20
> How do you manage formatting in examples? By hand?

I usually copy-paste it into a temporary file and then format that
(removing the leading `//! `) the annoying thing is that you then want
to align it to 96 columns. The way I do it is by wrapping the code in a
`mod tmp {}`, since that introduces 4 additional spaces. I think you
could also directly do it in the file by just removing the prefix and
wrapping in a module.

[...]

>>> +impl<T: Operations> GenDisk<T, Initialized> {
>>> +    /// Register the device with the kernel. When this function return=
s, the
>>> +    /// device is accessible from VFS. The kernel may issue reads to t=
he device
>>> +    /// during registration to discover partition information.
>>> +    pub fn add(self) -> Result<GenDisk<T, Added>> {
>>> +        crate::error::to_result(
>>> +            // SAFETY: By type invariant, `self.gendisk` points to a v=
alid and
>>> +            // initialized instance of `struct gendisk`
>>> +            unsafe {
>>> +                bindings::device_add_disk(
>>> +                    core::ptr::null_mut(),
>>> +                    self.gendisk,
>>> +                    core::ptr::null_mut(),
>>> +                )
>>> +            },
>>> +        )?;
>>> +
>>> +        // We don't want to run the destuctor and remove the device fr=
om the VFS
>>> +        // when `disk` is dropped.
>>> +        let mut old =3D core::mem::ManuallyDrop::new(self);
>>> +
>>> +        let new =3D GenDisk {
>>> +            _tagset: old._tagset.clone(),
>>> +            gendisk: old.gendisk,
>>> +            _phantom: PhantomData,
>>> +        };
>>> +
>>> +        // But we have to drop the `Arc` or it will leak.
>>> +        // SAFETY: `old._tagset` is valid for write, aligned, non-null=
, and we
>>> +        // have exclusive access. We are not accessing the value again=
 after it
>>> +        // is dropped.
>>> +        unsafe { core::ptr::drop_in_place(&mut old._tagset) };
>>> +
>>> +        Ok(new)
>>
>> Instead of using `ManuallyDrop` and `drop_in_place` why not use
>> `transmute`? I feel like that would be a lot simpler.
>=20
> I was considering the layout not being deterministic for `repr(Rust)`. I
> think that in practice it will be the case that the two types will have
> the same layout, but I could not find the documentation that states
> this. Nomicon does not talk about zero sized types [2].

Ah I forgot about this issue... You are absolutely correct that we do
not get the guarantee for `repr(Rust)`.

[...]

>>> +/// Implement this trait to interface blk-mq as block devices.
>>> +///
>>> +/// To implement a block device driver, implement this trait as descri=
bed in the
>>> +/// [module level documentation]. The kernel will use the implementati=
on of the
>>> +/// functions defined in this trait to interface a block device driver=
. Note:
>>> +/// There is no need for an exit_request() implementation, because the=
 `drop`
>>> +/// implementation of the [`Request`] type will be invoked by automati=
cally by
>>> +/// the C/Rust glue logic.
>>
>> This text is wrapped to 80 columns, but our usual wrapping is 100.
>=20
> This had me scratch my head for a bit. I run `make rustfmt` and `make
> rustfmtcheck`, so I had no idea why my code would be formatted
> incorrect. It took me a while to figure out that we are not enabling
> `comment_width =3D 100`, presumably because it is an unstable `rustfmt`
> feature.

Yeah, Alice also ran into this issue.

> I am not sure what the correct way to enable it but I hacked
> the Makefile and enabled it. It gives a huge diff all across the kernel
> crate.

Oh I did not notice...

> So, it seems we _are_ in fact using 80 line fill column, since that is
> what much of our existing code is using, and that is what the build
> system is configured to use.
>=20
> Where did you come across the 100 character fill column?

Well, my editor is configured to wrap at the 100th column including
comments. I don't know why we have so many comment blocks at 80 columns.

> Anyways, we should configure our tools to the standard we want. I don't
> care if it's 80 or 100, as long as I can have the tools do the job for
> me.

Agreed.

> Let's discuss this at next meeting.
>=20
>>
>>> +///
>>> +/// [module level documentation]: kernel::block::mq
>>> +#[macros::vtable]
>>> +pub trait Operations: Sized {
>>> +    /// Called by the kernel to queue a request with the driver. If `i=
s_last` is
>>> +    /// `false`, the driver is allowed to defer committing the request=
.
>>> +    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
>>> +
>>> +    /// Called by the kernel to indicate that queued requests should b=
e submitted.
>>> +    fn commit_rqs();
>>> +
>>> +    /// Called by the kernel when the request is completed.
>>> +    fn complete(_rq: ARef<Request<Self>>);
>>
>> Is there a reason for the `_`?
>=20
> Copy pasta probably. Will remove.
>=20
>>
>> To me it seems this is called when the given request is already done, so
>> would it make more sense to name it `completed` or `on_completion`?
>=20
> I would agree. But we had a bit of discussion at LSF about naming things
> differently in Rust vs C. C people prefer if we keep the C names, even
> if they do not make sense to the people who write the new Rust code.

That makes sense. In that case, we could also probably add an additional
note to the function that the name might be a bit misleading. In the
sense that it sounds like "here is a request, please complete it"
instead of "here is a request that was just completed".

> In C, the vtable entry is called `complete_callback` and the called
> symbol is usually `my_driver_complete_rq`.
>=20
> We could go with `completed`, `completed_callback`, or `complete_rq`.
> Although `completed` sounds like it should return a bool indicating
> whether the request was already completed.
>=20
> I think I'll leave it for now, and we can always change it if we come up
> with a really good name.

[...]

>>> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/=
raw_writer.rs
>>> new file mode 100644
>>> index 000000000000..4f7e4692b592
>>> --- /dev/null
>>> +++ b/rust/kernel/block/mq/raw_writer.rs
>>> @@ -0,0 +1,55 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +use core::fmt::{self, Write};
>>> +
>>> +use crate::error::Result;
>>> +use crate::prelude::EINVAL;
>>> +
>>> +/// A mutable reference to a byte buffer where a string can be written=
 into.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// `buffer` is always null terminated.
>>
>> I don't know how valuable this would be, but you could only ask for this
>> invariant, if `buffer` is non-empty. Then you could have the `new` and
>> `from_array` functions return a `RawWriter` without result.
>=20
> I think guaranteeing at least a null character is always written by
> `write_str` is a good thing. It is used for writing C strings to device
> name fields. `write_str` with a zero size buffer would give undesirable
> results, and is probably not what the caller wants.

Makes sense.

[...]

>>> +    /// Notify the block layer that the request has been completed wit=
hout errors.
>>> +    ///
>>> +    /// This function will return `Err` if `this` is not the only `ARe=
f`
>>> +    /// referencing the request.
>>> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>>
>> I am not yet fully convinced that this is the way we should go. I think
>> I would have to see a more complex usage of `Request` with that id <->
>> request mapping that you mentioned. Because with how rnull uses this
>> API, it could also have a `URef<Self>` parameter (URef :=3D unique ARef)=
.
>=20
> I considered a `UniqueARef` but it would just move the error handing to
> `ARef::into_unique` and then make `end_ok` infallible.
>=20
> There are four states for a request that we need to track:
>=20
> A) Request is owned by block layer (refcount 0)
> B) Request is owned by driver but with zero `ARef`s in existence
>    (refcount 1)
> C) Request is owned by driver with exactly one `ARef` in existence
>    (refcount 2)
> D) Request is owned by driver with more than one `ARef` in existence
>    (refcount > 2)
>=20
> It is in the doc comments for `RequestDataWrapper` as well.
>=20
> We need A and B to ensure we fail tag to request conversions for
> requests that are not owned by the driver.
>=20
> We need C and D to ensure that it is safe to end the request and hand bac=
k
> ownership to the block layer.
>=20
> I will ping you when I hook up the NVMe driver with this.

Thanks. I think that since the C side doesn't use ref-counting, the
lifecycle of a request is probably rather simple. Therefore we should
try to also avoid refcounting in Rust and see if we can eg tie ending
requests to the associated `TagSet` (ie require `&mut` on the tagset)
and tie accessing requests to shared access to the `TagSet`. Then we
would be able to avoid the refcount. But I will first have to take a
look at the nvme driver to gauge the plausibility.

>>> +        let this =3D Self::try_set_end(this)?;
>>> +        let request_ptr =3D this.0.get();
>>> +        core::mem::forget(this);
>>
>> Would be a good idea to mention who is going to own this refcount.
>=20
> The refcount is zero after `try_set_end`, so there is no owner of the
> count. The request will be in state A and thus block layer owns the
> request. Block layer does not honor this refcount, it is only for the
> driver to know.
>=20
> Perhaps I should move the explanation up into the docs for `Request`.

It wouldn't hurt to have the above as a comment :)

>>> +
>>> +        // SAFETY: By type invariant, `self.0` is a valid `struct requ=
est`. By
>>> +        // existence of `&mut self` we have exclusive access.
>>> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::B=
LK_STS_OK as _) };
>>> +
>>> +        Ok(())
>>> +    }
>>> +
>>> +    /// Return a pointer to the `RequestDataWrapper` stored in the pri=
vate area
>>> +    /// of the request structure.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `this` must point to a valid allocation.
>>> +    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<Reque=
stDataWrapper> {
>>> +        let request_ptr =3D this.cast::<bindings::request>();
>>> +        let wrapper_ptr =3D
>>> +            // SAFETY: By safety requirements for this function, `this=
` is a
>>> +            // valid allocation.
>>> +            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<Re=
questDataWrapper>() };
>>> +        // SAFETY: By C api contract, wrapper_ptr points to a valid al=
location
>>> +        // and is not null.
>>> +        unsafe { NonNull::new_unchecked(wrapper_ptr) }
>>> +    }
>>> +
>>> +    /// Return a reference to the `RequestDataWrapper` stored in the p=
rivate
>>> +    /// area of the request structure.
>>> +    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
>>> +        // SAFETY: By type invariant, `self.0` is a valid alocation. F=
urther,
>>> +        // the private data associated with this request is initialize=
d and
>>> +        // valid. The existence of `&self` guarantees that the private=
 data is
>>> +        // valid as a shared reference.
>>> +        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).a=
s_ref() }
>>> +    }
>>> +}
>>> +
>>> +/// A wrapper around data stored in the private area of the C `struct =
request`.
>>> +pub(crate) struct RequestDataWrapper {
>>
>> Why is this called `Wrapper`? It doesn't really wrap anything,
>> `RequestData` seems fine.
>=20
> It will eventually wrap private data associated with the request. Those
> patches will be submitted later. Should I change the name in the
> meanwhile?

I don't think the churn of the name change is worth it, so keep the
wrapper name.

>>> +    /// The Rust request refcount has the following states:
>>> +    ///
>>> +    /// - 0: The request is owned by C block layer.
>>> +    /// - 1: The request is owned by Rust abstractions but there are n=
o ARef references to it.
>>> +    /// - 2+: There are `ARef` references to the request.
>>> +    refcount: AtomicU64,
>>> +}
>>> +
>>> +impl RequestDataWrapper {
>>> +    /// Return a reference to the refcount of the request that is embe=
dding
>>> +    /// `self`.
>>> +    pub(crate) fn refcount(&self) -> &AtomicU64 {
>>> +        &self.refcount
>>> +    }
>>> +
>>> +    /// Return a pointer to the refcount of the request that is embedd=
ing the
>>> +    /// pointee of `this`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `this` must point to a live allocation of at least the size =
of `Self`.
>>> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU=
64 {
>>> +        // SAFETY: Because of the safety requirements of this function=
, the
>>> +        // field projection is safe.
>>> +        unsafe { addr_of_mut!((*this).refcount) }
>>> +    }
>>> +}
>>> +
>>> +// SAFETY: Exclusive access is thread-safe for `Request`. `Request` ha=
s no `&mut
>>> +// self` methods and `&self` methods that mutate `self` are internally
>>> +// synchronzied.
>>> +unsafe impl<T: Operations> Send for Request<T> {}
>>> +
>>> +// SAFETY: Shared access is thread-safe for `Request`. `&self` methods=
 that
>>> +// mutate `self` are internally synchronized`
>>> +unsafe impl<T: Operations> Sync for Request<T> {}
>>> +
>>> +/// Store the result of `op(target.load())` in target, returning new v=
alue of
>>> +/// taret.
>>> +fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u6=
4) -> u64 {
>>> +    let mut old =3D target.load(Ordering::Relaxed);
>>> +    loop {
>>> +        match target.compare_exchange_weak(old, op(old), Ordering::Rel=
axed, Ordering::Relaxed) {
>>> +            Ok(_) =3D> break,
>>> +            Err(x) =3D> {
>>> +                old =3D x;
>>> +            }
>>> +        }
>>> +    }
>>
>> This seems like a reimplementation of `AtomicU64::fetch_update` to me.
>=20
> It looks like it! Except this function is returning the updated value,
> `fetch_update` is returning the old value.
>=20
> Would you rather that I rewrite in terms of the library function?

If you can just use the fetch_update function, then that would be better
than (almost) reimplementing it. But if you really need to get the new
value, then I guess it can't really be helped. (or do you think you can
just apply `op` to the old value returned by `fetch_update`?)

>>> +
>>> +    op(old)
>>> +}
>>> +
>>> +/// Store the result of `op(target.load)` in `target` if `target.load(=
) !=3D
>>> +/// pred`, returning previous value of target
>>> +fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u6=
4, pred: u64) -> bool {
>>> +    let x =3D target.load(Ordering::Relaxed);
>>> +    loop {
>>> +        if x =3D=3D pred {
>>> +            break;
>>> +        }
>>> +        if target
>>> +            .compare_exchange_weak(x, op(x), Ordering::Relaxed, Orderi=
ng::Relaxed)
>>> +            .is_ok()
>>> +        {
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    x =3D=3D pred
>>> +}
>>> +
>>> +// SAFETY: All instances of `Request<T>` are reference counted. This
>>> +// implementation of `AlwaysRefCounted` ensure that increments to the =
ref count
>>> +// keeps the object alive in memory at least until a matching referenc=
e count
>>> +// decrement is executed.
>>> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>>> +    fn inc_ref(&self) {
>>> +        let refcount =3D &self.wrapper_ref().refcount();
>>> +
>>> +        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
>>
>> Another option would be to use `_updated` as the name of the variable. I
>> personally would prefer that. What do you guys think?
>=20
> Either way is fine by me.
>=20
> [...]
>=20
>>> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag=
_set.rs
>>> new file mode 100644
>>> index 000000000000..4217c2b03ff3
>>> --- /dev/null
>>> +++ b/rust/kernel/block/mq/tag_set.rs
>>> @@ -0,0 +1,93 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! This module provides the `TagSet` struct to wrap the C `struct blk=
_mq_tag_set`.
>>> +//!
>>> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.=
h)
>>> +
>>> +use core::pin::Pin;
>>> +
>>> +use crate::{
>>> +    bindings,
>>> +    block::mq::request::RequestDataWrapper,
>>> +    block::mq::{operations::OperationsVTable, Operations},
>>> +    error::{self, Error, Result},
>>> +    prelude::PinInit,
>>> +    try_pin_init,
>>> +    types::Opaque,
>>> +};
>>> +use core::{convert::TryInto, marker::PhantomData};
>>> +use macros::{pin_data, pinned_drop};
>>> +
>>> +/// A wrapper for the C `struct blk_mq_tag_set`.
>>> +///
>>> +/// `struct blk_mq_tag_set` contains a `struct list_head` and so must =
be pinned.
>>> +#[pin_data(PinnedDrop)]
>>> +#[repr(transparent)]
>>> +pub struct TagSet<T: Operations> {
>>> +    #[pin]
>>> +    inner: Opaque<bindings::blk_mq_tag_set>,
>>> +    _p: PhantomData<T>,
>>> +}
>>> +
>>> +impl<T: Operations> TagSet<T> {
>>> +    /// Try to create a new tag set
>>> +    pub fn try_new(
>>> +        nr_hw_queues: u32,
>>> +        num_tags: u32,
>>> +        num_maps: u32,
>>> +    ) -> impl PinInit<Self, error::Error> {
>>> +        try_pin_init!( TagSet {
>>> +            inner <- unsafe {kernel::init::pin_init_from_closure(move =
|place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
>>
>> We currently do not have `Opaque::try_ffi_init`, I vaguely remember that
>> we talked about it. Do you mind adding it? Otherwise I can also send a
>> patch.
>=20
> I have a `try_ffi_init` patch queued. I removed it from here to cut
> dependencies. I will submit it soon after this is in.
>=20
>>
>>> +                let place =3D place.cast::<bindings::blk_mq_tag_set>()=
;
>>> +
>>> +                // SAFETY: try_ffi_init promises that `place` is writa=
ble, and
>>> +                // zeroes is a valid bit pattern for this structure.
>>> +                core::ptr::write_bytes(place, 0, 1);
>>> +
>>> +                /// For a raw pointer to a struct, write a struct fiel=
d without
>>> +                /// creating a reference to the field
>>> +                macro_rules! write_ptr_field {
>>> +                    ($target:ident, $field:ident, $value:expr) =3D> {
>>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((=
*$target).$field), $value)
>>> +                    };
>>> +                }
>>> +
>>> +                // SAFETY: try_ffi_init promises that `place` is writa=
ble
>>> +                    write_ptr_field!(place, ops, OperationsVTable::<T>=
::build());
>>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queue=
s);
>>> +                    write_ptr_field!(place, timeout , 0); // 0 means d=
efault which is 30 * HZ in C
>>> +                    write_ptr_field!(place, numa_node , bindings::NUMA=
_NO_NODE);
>>> +                    write_ptr_field!(place, queue_depth , num_tags);
>>> +                    write_ptr_field!(place, cmd_size , core::mem::size=
_of::<RequestDataWrapper>().try_into()?);
>>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F=
_SHOULD_MERGE);
>>> +                    write_ptr_field!(place, driver_data , core::ptr::n=
ull_mut::<core::ffi::c_void>());
>>> +                    write_ptr_field!(place, nr_maps , num_maps);
>>
>> I think that there is some way for pinned-init to do a better job here.
>> I feel like we ought to be able to just write:
>>
>>     Opaque::init(
>>         try_init!(bindings::blk_mq_tag_set {
>>             ops: OperationsVTable::<T>::build(),
>>             nr_hw_queues,
>>             timeout: 0, // 0 means default, which is 30Hz
>>             numa_node: bindings::NUMA_NO_NODE,
>>             queue_depth: num_tags,
>>             cmd_size: size_of::<RequestDataWrapper>().try_into()?,
>>             flags: bindings::BLK_MQ_F_SHOULD_MERGE,
>>             driver_data: null_mut(),
>>             nr_maps: num_maps,
>>             ..Zeroable::zeroed()
>>         }? Error)
>>         .chain(|tag_set| to_result(bindings::blk_mq_alloc_tag_set(tag_se=
t)))
>>     )
>>
>> But we don't have `Opaque::init` (shouldn't be difficult) and
>> `bindings::blk_mq_tag_set` doesn't implement `Zeroable`. We would need
>> bindgen to put `derive(Zeroable)` on certain structs...
>>
>> Another option would be to just list the fields explicitly, since there
>> aren't that many. What do you think?
>=20
> Both options sound good. Ofc the first one sounds more user friendly
> while the latter one sounds easier to implement. Getting rid of the
> unsafe blocks here would be really nice.

I think since it is not that expensive in this case, you should go for
the second approach.
We can fix it later, when we get the proper bindgen support.

---
Cheers,
Benno

>>> +
>>> +                // SAFETY: Relevant fields of `place` are initialised =
above
>>> +                let ret =3D bindings::blk_mq_alloc_tag_set(place);
>>> +                if ret < 0 {
>>> +                    return Err(Error::from_errno(ret));
>>> +                }
>>> +
>>> +                Ok(())
>>> +            })},
>>> +            _p: PhantomData,
>>> +        })
>>> +    }
>>> +
>>> +    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
>>> +    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set =
{
>>> +        self.inner.get()
>>> +    }
>>> +}
>>> +
>>> +#[pinned_drop]
>>> +impl<T: Operations> PinnedDrop for TagSet<T> {
>>> +    fn drop(self: Pin<&mut Self>) {
>>> +        // SAFETY: We are not moving self below
>>> +        let this =3D unsafe { Pin::into_inner_unchecked(self) };
>>
>> You don't need to unwrap the `Pin`, since you only need access to `&Self=
`
>> and `Pin` always allows you to do that. (so just use `self` instead of
>> `this` below)
>=20
> Thanks =F0=9F=91=8D
>=20
>>
>>> +
>>> +        // SAFETY: `inner` is valid and has been properly initialised =
during construction.
>>
>> Should be an invariant.
>=20
> Ok =F0=9F=91=8D
>=20
> Thanks for the review! I will send a new version.
>=20
>=20
> Best regards,
> Andreas
>=20
>=20
> [1] https://github.com/rust-lang/rustfmt/issues/3348
> [2] https://doc.rust-lang.org/nomicon/repr-rust.html#reprrust



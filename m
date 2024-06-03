Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B735137C4A;
	Mon,  3 Jun 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439187; cv=none; b=FfU4UsonkYOZJyqVfS1XPZlugO9usxpaV2dmOPxzsBxn97PwDWprhs21VXA3/MhH7t2JuKR+/zXuk/vANf6Ipd7318BqarT+xtpYVAku2biFZcofhGQuirVJm+6NowqZu6GZWdiOJfVfdbuCHL2uuhhvA0Y4uDPXvEzWQ956kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439187; c=relaxed/simple;
	bh=IYDSrevwN0l8xOdEMkQFQ8XiL8ZhTn5e0JZtNVYcOa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQvHIQcMvuV04aqLVOZLzEbSMygi0QC/3csdGlzqXTpJxUcBMzwGuJ6WyzK46cB4gLiQO/iFNAvWIYLAa6edE9UdsZ7EdnHhCdsVQqpzf+cSNYjG0BPaYDYftJUAE3U9LxgMMBh7rTiVkzmspOpoUzPt5XDaPCvGOjT2TUbhCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I8FUfYep; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I8FUfYep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717439176; x=1717698376;
	bh=h5UBR5s+DqAv1y4ocFeN+mluknCcFmnFq+yPUyc1U4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I8FUfYepxDICOZxNDvK48bFsvqV1CguSjcb0QSHtzMRml22V3rC+9nSm5vAtudFnF
	 UodAOyU3g6SkUHLvYVG5nlVAZenDlK8SzZPQZy+KLD8sItktsP26Xd35ypC97aPcWM
	 E4bazlmUI/6BnYvHTkRLWqto38XR+WaF4DvsM+2atcXDmFDngLOYX9uKQS5Tdv3My+
	 eN1URtby09xA2/F6jAddhdTnsypZKlAY8/EV+Qyofj7N4khu3I5WxE0KBpRon81z3s
	 QtmDJy9yLfE+HJkepQecBZT8NoNhYPwZ0qeFpioJzE8ByonstAJG2CbOsFhcI50zpY
	 t/mQ2YI8dZISw==
Date: Mon, 03 Jun 2024 18:26:08 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <925fe0fe-9303-4f49-b473-c3a3ecc5e2e6@proton.me>
In-Reply-To: <87mso2me0p.fsf@metaspace.dk>
References: <20240601134005.621714-1-nmi@metaspace.dk> <20240601134005.621714-2-nmi@metaspace.dk> <b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me> <87mso2me0p.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6e3342b49160368ba5b3571626e6270cd0c4f503
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.06.24 14:01, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 01.06.24 15:40, Andreas Hindborg wrote:
>>> +impl seal::Sealed for Initialized {}
>>> +impl GenDiskState for Initialized {
>>> +    const DELETE_ON_DROP: bool =3D false;
>>> +}
>>> +impl seal::Sealed for Added {}
>>> +impl GenDiskState for Added {
>>> +    const DELETE_ON_DROP: bool =3D true;
>>> +}
>>> +
>>> +impl<T: Operations> GenDisk<T, Initialized> {
>>> +    /// Try to create a new `GenDisk`.
>>> +    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {
>>
>> Since there is no non-try `new` function, I think we should name this
>> function just `new`.
>=20
> Right, I am still getting used to the new naming scheme. Do you know if
> it is documented anywhere?

I don't think it is documented, it might only be a verbal convention at
the moment. Although [1] is suggesting `new` for general constructors.
Since this is the only constructor, one could argue that the
recommendation is to use `new` (which I personally find a good idea).

[1]: https://rust-lang.github.io/api-guidelines/naming.html

[...]

>>> +impl<T: Operations> OperationsVTable<T> {
>>> +    /// This function is called by the C kernel. A pointer to this fun=
ction is
>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - The caller of this function must ensure `bd` is valid
>>> +    ///   and initialized. The pointees must outlive this function.
>>
>> Until when do the pointees have to be alive? "must outlive this
>> function" could also be the case if the pointees die immediately after
>> this function returns.
>=20
> It should not be plural. What I intended to communicate is that what
> `bd` points to must be valid for read for the duration of the function
> call. I think that is what "The pointee must outlive this function"
> states? Although when we talk about lifetime of an object pointed to by
> a pointer, I am not sure about the correct way to word this. Do we talk
> about the lifetime of the pointer or the lifetime of the pointed to
> object (the pointee). We should not use the same wording for the pointer
> and the pointee.
>=20
> How about:
>=20
>     /// - The caller of this function must ensure that the pointee of `bd=
` is
>     ///   valid for read for the duration of this function.

But this is not enough for it to be sound, right? You create an `ARef`
from `bd.rq`, which potentially lives forever. You somehow need to
require that the pointer `bd` stays valid for reads and (synchronized)
writes until the request is ended (probably via `blk_mq_end_request`).

>>> +    /// - This function must not be called with a `hctx` for which
>>> +    ///   `Self::exit_hctx_callback()` has been called.
>>> +    /// - (*bd).rq must point to a valid `bindings:request` for which
>>> +    ///   `OperationsVTable<T>::init_request_callback` was called
>>
>> Missing `.` at the end.
>=20
> Thanks.
>=20
>>
>>> +    unsafe extern "C" fn queue_rq_callback(
>>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>>> +        bd: *const bindings::blk_mq_queue_data,
>>> +    ) -> bindings::blk_status_t {
>>> +        // SAFETY: `bd.rq` is valid as required by the safety requirem=
ent for
>>> +        // this function.
>>> +        let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
>>> +
>>> +        // One refcount for the ARef, one for being in flight
>>> +        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
>>> +
>>> +        // SAFETY: We own a refcount that we took above. We pass that =
to `ARef`.
>>> +        // By the safety requirements of this function, `request` is a=
 valid
>>> +        // `struct request` and the private data is properly initializ=
ed.
>>> +        let rq =3D unsafe { Request::aref_from_raw((*bd).rq) };
>>
>> I think that you need to require that the request is alive at least
>> until `blk_mq_end_request` is called for the request (since at that
>> point all `ARef`s will be gone).
>> Also if this is not guaranteed, the safety requirements of
>> `AlwaysRefCounted` are violated (since the object can just disappear
>> even if it has refcount > 0 [the refcount refers to the Rust refcount in
>> the `RequestDataWrapper`, not the one in C]).
>=20
> Yea, for the last invariant of `Request`:
>=20
>   /// * `self` is reference counted by atomic modification of
>   ///   self.wrapper_ref().refcount().
>=20
> I will add this to the safety comment at the call site:
>=20
>   //  - `rq` will be alive until `blk_mq_end_request` is called and is
>   //    reference counted by `ARef` until then.

Seems like you already want to use this here :)

[...]

>>> +    /// This function is called by the C kernel. A pointer to this fun=
ction is
>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function may only be called by blk-mq C infrastructure. `=
set` must

`set` doesn't exist (`_set` does), you are also not using this
requirement.

>>> +    /// point to an initialized `TagSet<T>`.
>>> +    unsafe extern "C" fn init_request_callback(
>>> +        _set: *mut bindings::blk_mq_tag_set,
>>> +        rq: *mut bindings::request,
>>> +        _hctx_idx: core::ffi::c_uint,
>>> +        _numa_node: core::ffi::c_uint,
>>> +    ) -> core::ffi::c_int {
>>> +        from_result(|| {
>>> +            // SAFETY: The `blk_mq_tag_set` invariants guarantee that =
all
>>> +            // requests are allocated with extra memory for the reques=
t data.
>>
>> What guarantees that the right amount of memory has been allocated?
>> AFAIU that is guaranteed by the `TagSet` (but there is no invariant).
>=20
> It is by C API contract. `TagSet`::try_new` (now `new`) writes
> `cmd_size` into the `struct blk_mq_tag_set`. That is picked up by
> `blk_mq_alloc_tag_set` to allocate the right amount of space for each req=
uest.
>=20
> The invariant here is on the C type. Perhaps the wording is wrong. I am
> not exactly sure how to express this. How about this:
>=20
>             // SAFETY: We instructed `blk_mq_alloc_tag_set` to allocate r=
equests
>             // with extra memory for the request data when we called it i=
n
>             // `TagSet::new`.

I think you need a safety requirement on the function: `rq` points to a
valid `Request`. Then you could just use `Request::wrapper_ptr` instead
of the line below.

>>> +            let pdu =3D unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast=
::<RequestDataWrapper>();
>>> +
>>> +            // SAFETY: The refcount field is allocated but not initial=
ized, this
>>> +            // valid for write.
>>> +            unsafe { RequestDataWrapper::refcount_ptr(pdu).write(Atomi=
cU64::new(0)) };
>>> +
>>> +            Ok(0)
>>> +        })
>>> +    }
>>
>> [...]
>>
>>> +    /// Notify the block layer that a request is going to be processed=
 now.
>>> +    ///
>>> +    /// The block layer uses this hook to do proper initializations su=
ch as
>>> +    /// starting the timeout timer. It is a requirement that block dev=
ice
>>> +    /// drivers call this function when starting to process a request.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The caller must have exclusive ownership of `self`, that is
>>> +    /// `self.wrapper_ref().refcount() =3D=3D 2`.
>>> +    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>>> +        // SAFETY: By type invariant, `self.0` is a valid `struct requ=
est`. By
>>> +        // existence of `&mut self` we have exclusive access.
>>
>> We don't have a `&mut self`. But the safety requirements ask for a
>> unique `ARef`.
>=20
> Thanks, I'll rephrase to:
>=20
>         // SAFETY: By type invariant, `self.0` is a valid `struct request=
` and
>         // we have exclusive access.
>=20
>>
>>> +        unsafe { bindings::blk_mq_start_request(this.0.get()) };
>>> +    }
>>> +
>>> +    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>>=
 {
>>> +        // We can race with `TagSet::tag_to_rq`
>>> +        match this.wrapper_ref().refcount().compare_exchange(
>>> +            2,
>>> +            0,
>>> +            Ordering::Relaxed,
>>> +            Ordering::Relaxed,
>>> +        ) {
>>> +            Err(_old) =3D> Err(this),
>>> +            Ok(_) =3D> Ok(this),
>>> +        }
>>> +    }
>>> +
>>> +    /// Notify the block layer that the request has been completed wit=
hout errors.
>>> +    ///
>>> +    /// This function will return `Err` if `this` is not the only `ARe=
f`
>>> +    /// referencing the request.
>>> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>>> +        let this =3D Self::try_set_end(this)?;
>>> +        let request_ptr =3D this.0.get();
>>> +        core::mem::forget(this);
>>> +
>>> +        // SAFETY: By type invariant, `self.0` is a valid `struct requ=
est`. By
>>> +        // existence of `&mut self` we have exclusive access.
>>
>> Same here, but in this case, the `ARef` is unique, since you called
>> `try_set_end`. You could make it a `# Guarantee` of `try_set_end`: "If
>> `Ok(aref)` is returned, then the `aref` is unique."
>=20
> Makes sense. I have not seen `# Guarantee` used anywhere. Do you have a l=
ink for that use?

Alice used it a couple of times, eg in [2]. I plan on putting it in the
safety standard.

[2]: https://lore.kernel.org/rust-for-linux/20230601134946.3887870-2-alicer=
yhl@google.com/

---
Cheers,
Benno


Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB031BF2A;
	Mon, 10 Jun 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050066; cv=none; b=cI306pDL21pg2f5bRUxLroljc6gZTKn9DKAczV7XgvRM4rH4rw4wduRr39jXV8IMT3effPosUghutzjDrwUh0TPLS3py71a6p2QjfNFJrFy0H7JOTg/Z/eiI2r9r97HIaFw81hwZzDkJW1eqDPVXRI/2uBvQJrtr6gWU16yLmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050066; c=relaxed/simple;
	bh=AVwvkyK+QfwnXB8dsA/WxUOo0rA7BRZfw4QqNw4utwc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzXPsRjiZcaRoIBagJC1FCxtR1V4QqmvcG1wwNAKbg1SuHjk1pwyV+c6yxRek5j/pZvx7tjpWXrezucrSDubaAzSgg2ch3Y9Dt4WSdZXCOs9AolWlK0McsO/JSlY5P458omYZkMSsQa01+V+ImcTVIKJ4VQxQK4tJU2BaunB6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iLx/Oj+H; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iLx/Oj+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718050061; x=1718309261;
	bh=5jgdFYZWMFkdcxhAGWY4bzY1aHJjynRB5K3U4qiCAsw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iLx/Oj+HjYHTmkkwWTn1g8PZJslcvdPCNMv20BEQx9wk55B+6f5moINgTz051sEuV
	 ovPnhX69/pOa8x4DtZqkJ47qpW34Gq0HsYOUBaZs71jawwgJnuKAo+R43N3DzyBaMk
	 dvUPmy7IyAMK5l/JvD3PwBrA5LthpkSzFZSzFyc2EDiCeHjhvM3fO2aWVFoVzuwyp/
	 B7CNvXS0ySdUUYSYHLqELKlv5HxXV2JLMVeZ/M5pa7MJetLY2shNfoHwvBz6ZojuXM
	 RW5+50bBs1z3b7Go0AiQbzjquz0zlihrnrobyQUs7HVQObH+X3RJj3ryfjPYha4XVb
	 HluHfpESS/MAA==
Date: Mon, 10 Jun 2024 20:07:37 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <f3e45a41-cc54-4c1f-885b-0f868ebf8744@proton.me>
In-Reply-To: <87y17lqb8q.fsf@metaspace.dk>
References: <20240601134005.621714-1-nmi@metaspace.dk> <20240601134005.621714-2-nmi@metaspace.dk> <b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me> <87mso2me0p.fsf@metaspace.dk> <925fe0fe-9303-4f49-b473-c3a3ecc5e2e6@proton.me> <87y17lqb8q.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e088cf28736281f159b5929e71db72c79baa7ad3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.06.24 11:59, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
> [...]
>=20
>>>>> +impl<T: Operations> OperationsVTable<T> {
>>>>> +    /// This function is called by the C kernel. A pointer to this f=
unction is
>>>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// - The caller of this function must ensure `bd` is valid
>>>>> +    ///   and initialized. The pointees must outlive this function.
>>>>
>>>> Until when do the pointees have to be alive? "must outlive this
>>>> function" could also be the case if the pointees die immediately after
>>>> this function returns.
>>>
>>> It should not be plural. What I intended to communicate is that what
>>> `bd` points to must be valid for read for the duration of the function
>>> call. I think that is what "The pointee must outlive this function"
>>> states? Although when we talk about lifetime of an object pointed to by
>>> a pointer, I am not sure about the correct way to word this. Do we talk
>>> about the lifetime of the pointer or the lifetime of the pointed to
>>> object (the pointee). We should not use the same wording for the pointe=
r
>>> and the pointee.
>>>
>>> How about:
>>>
>>>     /// - The caller of this function must ensure that the pointee of `=
bd` is
>>>     ///   valid for read for the duration of this function.
>>
>> But this is not enough for it to be sound, right? You create an `ARef`
>> from `bd.rq`, which potentially lives forever. You somehow need to
>> require that the pointer `bd` stays valid for reads and (synchronized)
>> writes until the request is ended (probably via `blk_mq_end_request`).
>=20
> The statement does not say anything about `*((*bd).rq)`. `*bd` needs to
> be valid only for the duration of the function. It carries a pointer to
> a `struct request` in the `rq` field. The pointee of that pointer must
> be exclusively owned by the driver until the request is done.
>=20
> Maybe like this:
>=20
> # Safety
>=20
> - The caller of this function must ensure that the pointee of `bd` is
>   valid for read for the duration of this function.

"valid for reads"

> - This function must be called for an initialized and live `hctx`. That
>   is, `Self::init_hctx_callback` was called and
>   `Self::exit_hctx_callback()` was not yet called.
> - `(*bd).rq` must point to an initialized and live `bindings:request`.
>   That is, `Self::init_request_callback` was called but
>   `Self::exit_request_callback` was not yet called for the request.
> - `(*bd).rq` must be owned by the driver. That is, the block layer must
>   promise to not access the request until the driver calls
>   `bindings::blk_mq_end_request` for the request.

Sounds good!

> [...]
>=20
>>>>> +    /// This function is called by the C kernel. A pointer to this f=
unction is
>>>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// This function may only be called by blk-mq C infrastructure.=
 `set` must
>>
>> `set` doesn't exist (`_set` does), you are also not using this
>> requirement.
>=20
> Would be nice if there was a way in `rustdoc` no name arguments
> explicitly.
>=20
>>
>>>>> +    /// point to an initialized `TagSet<T>`.
>>>>> +    unsafe extern "C" fn init_request_callback(
>>>>> +        _set: *mut bindings::blk_mq_tag_set,
>>>>> +        rq: *mut bindings::request,
>>>>> +        _hctx_idx: core::ffi::c_uint,
>>>>> +        _numa_node: core::ffi::c_uint,
>>>>> +    ) -> core::ffi::c_int {
>>>>> +        from_result(|| {
>>>>> +            // SAFETY: The `blk_mq_tag_set` invariants guarantee tha=
t all
>>>>> +            // requests are allocated with extra memory for the requ=
est data.
>>>>
>>>> What guarantees that the right amount of memory has been allocated?
>>>> AFAIU that is guaranteed by the `TagSet` (but there is no invariant).
>>>
>>> It is by C API contract. `TagSet`::try_new` (now `new`) writes
>>> `cmd_size` into the `struct blk_mq_tag_set`. That is picked up by
>>> `blk_mq_alloc_tag_set` to allocate the right amount of space for each r=
equest.
>>>
>>> The invariant here is on the C type. Perhaps the wording is wrong. I am
>>> not exactly sure how to express this. How about this:
>>>
>>>             // SAFETY: We instructed `blk_mq_alloc_tag_set` to allocate=
 requests
>>>             // with extra memory for the request data when we called it=
 in
>>>             // `TagSet::new`.
>>
>> I think you need a safety requirement on the function: `rq` points to a
>> valid `Request`. Then you could just use `Request::wrapper_ptr` instead
>> of the line below.
>=20
> I cannot require `rq` to point to a valid `Request`, because that would
> require the private data area to already be initialized as a valid
> `RequestDataWrapper`. Using the `wrapper_ptr` is good =F0=9F=91=8D. How i=
s this:
>=20
>=20
>     /// # Safety
>     ///
>     /// - This function may only be called by blk-mq C infrastructure.
>     /// - `_set` must point to an initialized `TagSet<T>`.
>     /// - `rq` must point to an initialized `bindings::request`.
>     /// - The allocation pointed to by `rq` must be at the size of `Reque=
st`
>     ///   plus the size of `RequestDataWrapper`.

Also sounds good to me.

---
Cheers,
Benno


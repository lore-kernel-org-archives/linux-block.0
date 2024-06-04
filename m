Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD81448CD
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495200; cv=none; b=JperIeJLti4vWy7AS9lCGjf2+KchPf56vxFkLMm8wVFIIG+24UFbTbu6eR3O6QZhJBEgtu8i/RkXZQesqZ5reU6odiyjUJvzBCsGWqIdciMbSp+/8USFVl0Ykv2jg+Uh6613yuGhz1NDLxxy6FoqRN5Aftk59qF1YCvGlTIEKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495200; c=relaxed/simple;
	bh=ojWCF20cfUoiMtLqDIeUZ96Ul+Nd3RwITJw/ORXbDbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfhVsvnrYsiPvphOn2y3zZ8FN8LImt1Ksi8WVB8edCXwTLS0gTVOo7RL3B2SxZ0poDN41+ecwzUK/tVFdcu7jnYv+zjmakIOFkaTuzLNg3cc0fFTB0tiIj6nZXnVS2aUgkRELy7kL385jFcKaj5QJWYPp+Ry8OASh4fab9EqmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=YgXe1opa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="YgXe1opa"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a6fcb823fso1593646a12.3
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2024 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717495196; x=1718099996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIq/eUO9YgOB4ouX5wft1IfVxCcuFVt84XqSDqsem4E=;
        b=YgXe1opacThhBRASQJwpscZaF/tEgG1LG33rXLo3BpRu9hTkLUwxt0J6rI/zAXEk7z
         XX6UHIQrSij5pwyWtjV+OFbtZQcwga6UTYdc3ThO6qbI/pTexKAqZooQhqRyHyuUBNHS
         bR/IsfWiWZEQ9WKwG1TE+CjG3i12C3qv6tOPs5lIADpqiG0GkTpHnBA9gs+iALgzZ+Hp
         DerLvIOZ7vIyP0EpvCQ5+tKouonIze8jyKUgizkE7Y86shIeCNGA/npaVxKEcS2QtMLR
         XKmY7BIdaPiBIgMnymRC/BMkCqul9w/H4AeMVE8buHGYddxZgJS3FkKfvdH1hETkQLD5
         kbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495196; x=1718099996;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIq/eUO9YgOB4ouX5wft1IfVxCcuFVt84XqSDqsem4E=;
        b=gzWpuAMgiAXNj9TN+bx33kwR4cL20w4aB3Sc5mLUQVHKk4s4YV/LnTW9bgCMnMzxzh
         zlcTMTsOx3FHDrM50CgU9JDAhNsKGPrruTGkhiD77J9EWZbehDm5p8V3cmRHIVYNQHDM
         ijMbwAawQd/+hla5LhJtaahOoV+VIKELb33jaDX1jGL5qxX9NKE2KHIu7RY741fXyGNR
         TIqN3UKo7jn/mz5QzBFr+uDGrTbEqTCFAuODx9ERU4QijeJbtZbWO8mlDeqR6JOvUgdx
         r0qWdqiYTceeC7Q7N9fBb7mswEtaVJKJYa/G+XmAuQw6Pe/xDWZrYpEKH0L33LV2SpDi
         1XYw==
X-Forwarded-Encrypted: i=1; AJvYcCUCA+74bZqbcJ1p+N/QfwS2jewUFtnrlY6Lg2UFTVjCL80cVB8OWOQlPK58kbHueRxssMKsqjJt+T7MufpA0Lrrvsu29Bw6EZedFOY=
X-Gm-Message-State: AOJu0Yw5QvZitCoGP33L8st88StL/PyTGJ/U8cEMa+VLKQZyPtQiingv
	WQanIGYsKzNxHI/BTeUxRJGJU+RnyCkVwNLcR+LQTrXqOR2tjjSLeafDkV1zgv8=
X-Google-Smtp-Source: AGHT+IH5c8gvgpxeYJR9DYjfzyPr9/QZPrSpme+Az/DADz5sutMsuFt/AqEGuTF3K5Xc2qa5/1JKTQ==
X-Received: by 2002:a17:906:6807:b0:a68:bae4:94d3 with SMTP id a640c23a62f3a-a68bae49c1fmr545115966b.8.1717495195916;
        Tue, 04 Jun 2024 02:59:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f03b7esm594011066b.2.2024.06.04.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:59:55 -0700 (PDT)
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
Subject: Re: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <925fe0fe-9303-4f49-b473-c3a3ecc5e2e6@proton.me> (Benno Lossin's
	message of "Mon, 03 Jun 2024 18:26:08 +0000")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-2-nmi@metaspace.dk>
	<b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me>
	<87mso2me0p.fsf@metaspace.dk>
	<925fe0fe-9303-4f49-b473-c3a3ecc5e2e6@proton.me>
Date: Tue, 04 Jun 2024 11:59:49 +0200
Message-ID: <87y17lqb8q.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

[...]

>>>> +impl<T: Operations> OperationsVTable<T> {
>>>> +    /// This function is called by the C kernel. A pointer to this fu=
nction is
>>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// - The caller of this function must ensure `bd` is valid
>>>> +    ///   and initialized. The pointees must outlive this function.
>>>
>>> Until when do the pointees have to be alive? "must outlive this
>>> function" could also be the case if the pointees die immediately after
>>> this function returns.
>>=20
>> It should not be plural. What I intended to communicate is that what
>> `bd` points to must be valid for read for the duration of the function
>> call. I think that is what "The pointee must outlive this function"
>> states? Although when we talk about lifetime of an object pointed to by
>> a pointer, I am not sure about the correct way to word this. Do we talk
>> about the lifetime of the pointer or the lifetime of the pointed to
>> object (the pointee). We should not use the same wording for the pointer
>> and the pointee.
>>=20
>> How about:
>>=20
>>     /// - The caller of this function must ensure that the pointee of `b=
d` is
>>     ///   valid for read for the duration of this function.
>
> But this is not enough for it to be sound, right? You create an `ARef`
> from `bd.rq`, which potentially lives forever. You somehow need to
> require that the pointer `bd` stays valid for reads and (synchronized)
> writes until the request is ended (probably via `blk_mq_end_request`).

The statement does not say anything about `*((*bd).rq)`. `*bd` needs to
be valid only for the duration of the function. It carries a pointer to
a `struct request` in the `rq` field. The pointee of that pointer must
be exclusively owned by the driver until the request is done.

Maybe like this:

# Safety

- The caller of this function must ensure that the pointee of `bd` is
  valid for read for the duration of this function.
- This function must be called for an initialized and live `hctx`. That
  is, `Self::init_hctx_callback` was called and
  `Self::exit_hctx_callback()` was not yet called.
- `(*bd).rq` must point to an initialized and live `bindings:request`.
  That is, `Self::init_request_callback` was called but
  `Self::exit_request_callback` was not yet called for the request.
- `(*bd).rq` must be owned by the driver. That is, the block layer must
  promise to not access the request until the driver calls
  `bindings::blk_mq_end_request` for the request.

[...]

>>>> +    /// This function is called by the C kernel. A pointer to this fu=
nction is
>>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// This function may only be called by blk-mq C infrastructure. =
`set` must
>
> `set` doesn't exist (`_set` does), you are also not using this
> requirement.

Would be nice if there was a way in `rustdoc` no name arguments
explicitly.

>
>>>> +    /// point to an initialized `TagSet<T>`.
>>>> +    unsafe extern "C" fn init_request_callback(
>>>> +        _set: *mut bindings::blk_mq_tag_set,
>>>> +        rq: *mut bindings::request,
>>>> +        _hctx_idx: core::ffi::c_uint,
>>>> +        _numa_node: core::ffi::c_uint,
>>>> +    ) -> core::ffi::c_int {
>>>> +        from_result(|| {
>>>> +            // SAFETY: The `blk_mq_tag_set` invariants guarantee that=
 all
>>>> +            // requests are allocated with extra memory for the reque=
st data.
>>>
>>> What guarantees that the right amount of memory has been allocated?
>>> AFAIU that is guaranteed by the `TagSet` (but there is no invariant).
>>=20
>> It is by C API contract. `TagSet`::try_new` (now `new`) writes
>> `cmd_size` into the `struct blk_mq_tag_set`. That is picked up by
>> `blk_mq_alloc_tag_set` to allocate the right amount of space for each re=
quest.
>>=20
>> The invariant here is on the C type. Perhaps the wording is wrong. I am
>> not exactly sure how to express this. How about this:
>>=20
>>             // SAFETY: We instructed `blk_mq_alloc_tag_set` to allocate =
requests
>>             // with extra memory for the request data when we called it =
in
>>             // `TagSet::new`.
>
> I think you need a safety requirement on the function: `rq` points to a
> valid `Request`. Then you could just use `Request::wrapper_ptr` instead
> of the line below.

I cannot require `rq` to point to a valid `Request`, because that would
require the private data area to already be initialized as a valid
`RequestDataWrapper`. Using the `wrapper_ptr` is good =F0=9F=91=8D. How is =
this:


    /// # Safety
    ///
    /// - This function may only be called by blk-mq C infrastructure.
    /// - `_set` must point to an initialized `TagSet<T>`.
    /// - `rq` must point to an initialized `bindings::request`.
    /// - The allocation pointed to by `rq` must be at the size of `Request`
    ///   plus the size of `RequestDataWrapper`.


BR Andreas

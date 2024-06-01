Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D33D8E
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717223746; cv=none; b=aefPFxpNnK4SuIGvKKc6y4ldNsTvPVeTkLq3SAKNhhXzKbzO8IA+PbRaz95DE6Ayz0mSMVoR56lb1JyEKgR8e3x6r+oS6CcSRZBcKlPs2srkzw6xJ+SWiZYp3dXYt4YzBuqdiTO5cCstTayryNY89dJM8/kiCuSgPsBzQvVDMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717223746; c=relaxed/simple;
	bh=Mz8Hxjrxu4rGo4t3crAqddJyc25JjD3rXRWX5qNVWjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7TyyYKq+qILqRSunwI5T2QyemO8ay5c1iXu11a/jz06pSVQjqFnea/BAcIDIY8FDY78hFvYAuUAGAkJ4IgS4OgzgDp945LHDUeY5CMEay/UPeMKlF1n9fAaJTrh1pBJkxZxmD459HflX7yhHql5ojehYuQnzUoGgPPnSigsqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=iLEcL3Go; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="iLEcL3Go"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so121357a12.2
        for <linux-block@vger.kernel.org>; Fri, 31 May 2024 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717223742; x=1717828542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6LNY6xv2/4eeyQXLXkI83LJOKbMoY6Do9+TvOQJ91Q=;
        b=iLEcL3GoHCw1zddiCfLUrBFHjKYJ55r0UpBhr2CAWNXCArvXgXzwtUUoU1BGz4jo+Y
         o30Dle1xk3iq/eH0eyi0k7+yqiswjApHVmcFoxTR+NrGn3Pnz7Hr+9G5hosEmLfFmlN0
         JgXEsdbE1rJZwM/tD9AtES/hT6eF2+C0xanOesEMeSqWwTjnsvt2FmRQHTDwptG8rolZ
         smFfBkOHm9wAcq5ZybEmsf4A/r0IXDI876TS2DVW+zIHXqnGd3tQpYhfiWwF8K0yrWph
         orfzSjJZTDOeJe8Wpy2JQVVnrSA6Kyg28pnypQP6gJnQKAyDb2mP7KX+tf2hJpV08ptv
         jXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717223742; x=1717828542;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6LNY6xv2/4eeyQXLXkI83LJOKbMoY6Do9+TvOQJ91Q=;
        b=QyZytpzolkdXM9X7VHKARO8E1x8BSThdeEIFzo+uekInuSuGQkK9AIRV72ZK0O3VQC
         pXMAEi7RUkGDqo+lOeA7ldssp/C97JY2LWyyQA1NXFHIyCd76e2eZ/LWUuOQf/5H2oFs
         8LfHlbwGtHlhdHHWsuG8z/YBAGPh9hJy9IIso8uzbAEcPQtopubyr9Q+lIrOqiZ8odUC
         f0nXf6uHpqxAMShmZWBSbYHaLEFJhALtJLYvniKT3w5xPVec3FiUsTZ7oDxtSvC9SkX1
         ZzY1dmkCdOE0xMgz5PFIctAdigRt6tBD2v4QBO2ke/KnpIpblzIHQeg3LUtuKY3dHTbL
         vKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV13xmM02uwzJ2lB13hs2UheLnaoABuGxsmIJKUgdGYwyRIiqpTG8ZGDywQs26L8tnzChEp2yezFc49tbEb4m42qtyBg+o9XGgGrHQ=
X-Gm-Message-State: AOJu0YyJCoPKZ8iK6R6yGWbadpf/j9FvGy09g8GUF8v8f5gbMefuyGtz
	GWw1kvhquQqDgsp3jhuUs2+fX/ZETzNPR8F44K9oAbDFO05mSek4Jq7MGWPcBF0=
X-Google-Smtp-Source: AGHT+IGNFc6BIvNUh2peUBk1UIPpjkqoa6xCb2VUlR5N6dXhaLyFRabOGddaiynXAOGYrDINtoHzMQ==
X-Received: by 2002:a50:871d:0:b0:57a:3273:e646 with SMTP id 4fb4d7f45d1cf-57a3644a330mr2629575a12.26.1717223741445;
        Fri, 31 May 2024 23:35:41 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4d468a4fsm240767a12.79.2024.05.31.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 23:35:41 -0700 (PDT)
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
In-Reply-To: <29e31afd-c10f-4262-82ef-d0e3599753ea@proton.me> (Benno Lossin's
	message of "Wed, 29 May 2024 18:07:33 +0000")
References: <20240521140323.2960069-1-nmi@metaspace.dk>
	<20240521140323.2960069-2-nmi@metaspace.dk>
	<2d2689e7-7052-4a92-b6fb-37f25fd05810@proton.me>
	<87sey0rda8.fsf@metaspace.dk>
	<29e31afd-c10f-4262-82ef-d0e3599753ea@proton.me>
Date: Sat, 01 Jun 2024 08:35:30 +0200
Message-ID: <87v82tnpal.fsf@metaspace.dk>
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

>>>> +    /// Notify the block layer that the request has been completed wi=
thout errors.
>>>> +    ///
>>>> +    /// This function will return `Err` if `this` is not the only `AR=
ef`
>>>> +    /// referencing the request.
>>>> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>>>
>>> I am not yet fully convinced that this is the way we should go. I think
>>> I would have to see a more complex usage of `Request` with that id <->
>>> request mapping that you mentioned. Because with how rnull uses this
>>> API, it could also have a `URef<Self>` parameter (URef :=3D unique ARef=
).
>>=20
>> I considered a `UniqueARef` but it would just move the error handing to
>> `ARef::into_unique` and then make `end_ok` infallible.
>>=20
>> There are four states for a request that we need to track:
>>=20
>> A) Request is owned by block layer (refcount 0)
>> B) Request is owned by driver but with zero `ARef`s in existence
>>    (refcount 1)
>> C) Request is owned by driver with exactly one `ARef` in existence
>>    (refcount 2)
>> D) Request is owned by driver with more than one `ARef` in existence
>>    (refcount > 2)
>>=20
>> It is in the doc comments for `RequestDataWrapper` as well.
>>=20
>> We need A and B to ensure we fail tag to request conversions for
>> requests that are not owned by the driver.
>>=20
>> We need C and D to ensure that it is safe to end the request and hand ba=
ck
>> ownership to the block layer.
>>=20
>> I will ping you when I hook up the NVMe driver with this.
>
> Thanks. I think that since the C side doesn't use ref-counting, the
> lifecycle of a request is probably rather simple. Therefore we should
> try to also avoid refcounting in Rust and see if we can eg tie ending
> requests to the associated `TagSet` (ie require `&mut` on the tagset)
> and tie accessing requests to shared access to the `TagSet`. Then we
> would be able to avoid the refcount. But I will first have to take a
> look at the nvme driver to gauge the plausibility.

C side _does_ use ref-counting in the `ref` field of the C `struct
request`. I am not able to reuse that field for the state tracking I
need. Other users such as iostat will take references on the request and
we will not be able to tell if there are no more Rust refs to the
request from that field. We need a separate one.

Anyways I think we should go with the current implementation for now. We
can always change it, nothing is locked in stone.

[...]

>>>> +/// Store the result of `op(target.load())` in target, returning new =
value of
>>>> +/// taret.
>>>> +fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u=
64) -> u64 {
>>>> +    let mut old =3D target.load(Ordering::Relaxed);
>>>> +    loop {
>>>> +        match target.compare_exchange_weak(old, op(old), Ordering::Re=
laxed, Ordering::Relaxed) {
>>>> +            Ok(_) =3D> break,
>>>> +            Err(x) =3D> {
>>>> +                old =3D x;
>>>> +            }
>>>> +        }
>>>> +    }
>>>
>>> This seems like a reimplementation of `AtomicU64::fetch_update` to me.
>>=20
>> It looks like it! Except this function is returning the updated value,
>> `fetch_update` is returning the old value.
>>=20
>> Would you rather that I rewrite in terms of the library function?
>
> If you can just use the fetch_update function, then that would be better
> than (almost) reimplementing it. But if you really need to get the new
> value, then I guess it can't really be helped. (or do you think you can
> just apply `op` to the old value returned by `fetch_update`?)

I can implement `atomic_relaxed_op_return` in terms of `fetch_update` =F0=
=9F=91=8D

[...]

>>>> +                let place =3D place.cast::<bindings::blk_mq_tag_set>(=
);
>>>> +
>>>> +                // SAFETY: try_ffi_init promises that `place` is writ=
able, and
>>>> +                // zeroes is a valid bit pattern for this structure.
>>>> +                core::ptr::write_bytes(place, 0, 1);
>>>> +
>>>> +                /// For a raw pointer to a struct, write a struct fie=
ld without
>>>> +                /// creating a reference to the field
>>>> +                macro_rules! write_ptr_field {
>>>> +                    ($target:ident, $field:ident, $value:expr) =3D> {
>>>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!(=
(*$target).$field), $value)
>>>> +                    };
>>>> +                }
>>>> +
>>>> +                // SAFETY: try_ffi_init promises that `place` is writ=
able
>>>> +                    write_ptr_field!(place, ops, OperationsVTable::<T=
>::build());
>>>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queu=
es);
>>>> +                    write_ptr_field!(place, timeout , 0); // 0 means =
default which is 30 * HZ in C
>>>> +                    write_ptr_field!(place, numa_node , bindings::NUM=
A_NO_NODE);
>>>> +                    write_ptr_field!(place, queue_depth , num_tags);
>>>> +                    write_ptr_field!(place, cmd_size , core::mem::siz=
e_of::<RequestDataWrapper>().try_into()?);
>>>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_=
F_SHOULD_MERGE);
>>>> +                    write_ptr_field!(place, driver_data , core::ptr::=
null_mut::<core::ffi::c_void>());
>>>> +                    write_ptr_field!(place, nr_maps , num_maps);
>>>
>>> I think that there is some way for pinned-init to do a better job here.
>>> I feel like we ought to be able to just write:
>>>
>>>     Opaque::init(
>>>         try_init!(bindings::blk_mq_tag_set {
>>>             ops: OperationsVTable::<T>::build(),
>>>             nr_hw_queues,
>>>             timeout: 0, // 0 means default, which is 30Hz
>>>             numa_node: bindings::NUMA_NO_NODE,
>>>             queue_depth: num_tags,
>>>             cmd_size: size_of::<RequestDataWrapper>().try_into()?,
>>>             flags: bindings::BLK_MQ_F_SHOULD_MERGE,
>>>             driver_data: null_mut(),
>>>             nr_maps: num_maps,
>>>             ..Zeroable::zeroed()
>>>         }? Error)
>>>         .chain(|tag_set| to_result(bindings::blk_mq_alloc_tag_set(tag_s=
et)))
>>>     )
>>>
>>> But we don't have `Opaque::init` (shouldn't be difficult) and
>>> `bindings::blk_mq_tag_set` doesn't implement `Zeroable`. We would need
>>> bindgen to put `derive(Zeroable)` on certain structs...
>>>
>>> Another option would be to just list the fields explicitly, since there
>>> aren't that many. What do you think?
>>=20
>> Both options sound good. Ofc the first one sounds more user friendly
>> while the latter one sounds easier to implement. Getting rid of the
>> unsafe blocks here would be really nice.
>
> I think since it is not that expensive in this case, you should go for
> the second approach.
> We can fix it later, when we get the proper bindgen support.

Cool, I will send a follow up patch with this =F0=9F=91=8D

Best regards,
Andreas


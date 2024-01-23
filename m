Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC11823B6
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038540; cv=none; b=gdxE9O5gHEYK3mE9TFBdDJg8QwJCl0E/ETriZopzIXYWNgOhBMEPMLg9C/PA/GumVNP5sydU6tcqm8crrw2flYmY1lF7rhuO4rdqrPx2eZAfNbBjHpvxx0FuJQqudHU7V8gKDnNqxhcum2xXrES1urNrQucSVLUv98Akt7Hol8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038540; c=relaxed/simple;
	bh=UlJXHzckCQJdamra/G6D9M8Y+u6D7yXFSqzOhtZP1dM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=F9ecWDVte8X2rSrmacwmmHI3QP/Z0aWBrAZBM2kBIhY1YjW7T5iETPL1mIJQ9duYvOnH8H1R8TriAQs1pQuRU1TmMeI/HhnT/ldb2tBbL8I2JdGhWHuNvLwQolhx7aTB2UXHNlDs9AK++rHfxmJoywR4diIipS5OtH9VJA0Z1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Jh6DFuwS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Jh6DFuwS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a293f2280c7so488933266b.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1706038536; x=1706643336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NajI3TyyQ9rVjJzigsgGZze0f+PlQKZyJBohU0PsaJA=;
        b=Jh6DFuwSN+WUkKnMU3d4iIsjF3HOxY+RAhAvx4wswwS/kfuhwe7/1vFT7VgeGXhx+y
         8STV8Ra3CFmg0xmKyWy8+2JUaL9jybGP0CH89Rfdvo2WaGMGpY0eopxrbmU/NxFLSz1Z
         zbpzNp+VGBsnx/aQAiUT84qMDXqmeRU5Oa5s308nVFxl0vrrQDO3Rlnl29PKp0bBxFnC
         d8fDSqQLwe+kf9ipBKyl/x87HzQ/ew9ruOkblgtdBKvmVOMB5AXoKJHHDqoFDs4Wf1Fu
         J2VPPzu/5azY1E8TJxxdu17Y7VkpM6gqBb1DQ86bSEykYNWETif/Sv9Qj+oobdw23isb
         XFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038536; x=1706643336;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NajI3TyyQ9rVjJzigsgGZze0f+PlQKZyJBohU0PsaJA=;
        b=AbxGtBIuEv9udgZEgN2A8nxZzvcQf17i7Plri2k4SUcA199cGvJDALC2sh7rTU0Z5U
         7dlw94n5Poq8bFVtJfU/B6wTJoxQcqVVIhUUq51i9itimKLEBpNs69pY0ZtF50LLAB0n
         XHchvSApzJPs6KTDzJV3t/7CyKaNt006oAr01/tvHExEvO19XBLM+FQZz7dCVKNJQBnY
         HtX8uO5V/5W5iDb5qGFIXNnB7Pu6LfjwQxvAoT2o9DI4hLrnttz8akOrlDjw22OH/3Bo
         r3Vp/YGDrL7ApYtfBA8qrRBPAhMNVOUaBWFTBzgmfQCdsGtA39CLqXF37IWN+iqHsecY
         R7zA==
X-Gm-Message-State: AOJu0YztIHoSmp0F5hDB+ZQM52MzaFbi/a3dga1EsjLTqrSq6U2FJ0B2
	uQxCdUQvXClGOa/R8KV9tLi/km5jWvXvKixemsFRgtqsVuSd5xClQnv7Hf5FMPI=
X-Google-Smtp-Source: AGHT+IH+nEjpWVx0IVAFz3yVMdU+gU7oGcfJTGzNXfC0VN2oXyQ4l7UdqaC8c9fQ5/eV65g/ZF9OTg==
X-Received: by 2002:a17:906:458:b0:a2f:c87a:385b with SMTP id e24-20020a170906045800b00a2fc87a385bmr113163eja.3.1706038535403;
        Tue, 23 Jan 2024 11:35:35 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906c00d00b00a2a1bbda0a6sm14819283ejz.175.2024.01.23.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:35:34 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-4-nmi@metaspace.dk>
 <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
 <87il3kjgk0.fsf@metaspace.dk>
 <104a22f7-a5bb-4fb6-9ce9-aa2d4e63417f@proton.me>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes
 Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org,
 gost.dev@samsung.com
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq`
 module
Date: Tue, 23 Jan 2024 19:39:15 +0100
In-reply-to: <104a22f7-a5bb-4fb6-9ce9-aa2d4e63417f@proton.me>
Message-ID: <874jf3kflx.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Benno Lossin <benno.lossin@proton.me> writes:

> Hi Andreas,
>
> just so you know, I received this email today, so it was very late,
> since the send date is January 12.

My mistake. I started drafting Jan 12, but did not get time to finish
the mail until today. I guess that is how mu4e does things, I should be
aware and fix up the date. Thanks for letting me know =F0=9F=91=8D

>
> On 12.01.24 10:18, Andreas Hindborg (Samsung) wrote:
>>=20
>> Hi Benno,
>>=20
>> Benno Lossin <benno.lossin@proton.me> writes:
>>=20
>> <...>
>>=20
>>>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/g=
en_disk.rs
>>>> new file mode 100644
>>>> index 000000000000..50496af15bbf
>>>> --- /dev/null
>>>> +++ b/rust/kernel/block/mq/gen_disk.rs
>>>> @@ -0,0 +1,133 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +//! GenDisk abstraction
>>>> +//!
>>>> +//! C header: [`include/linux/blkdev.h`](../../include/linux/blkdev.h)
>>>> +//! C header: [`include/linux/blk_mq.h`](../../include/linux/blk_mq.h)
>>>> +
>>>> +use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>>>> +use crate::{
>>>> +    bindings, error::from_err_ptr, error::Result, sync::Arc, types::F=
oreignOwnable,
>>>> +    types::ScopeGuard,
>>>> +};
>>>> +use core::fmt::{self, Write};
>>>> +
>>>> +/// A generic block device
>>>> +///
>>>> +/// # Invariants
>>>> +///
>>>> +///  - `gendisk` must always point to an initialized and valid `struc=
t gendisk`.
>>>> +pub struct GenDisk<T: Operations> {
>>>> +    _tagset: Arc<TagSet<T>>,
>>>> +    gendisk: *mut bindings::gendisk,
>>>
>>> Why are these two fields not embedded? Shouldn't the user decide where
>>> to allocate?
>>=20
>> The `TagSet` can be shared between multiple `GenDisk`. Using an `Arc`
>> seems resonable?
>>=20
>> For the `gendisk` field, the allocation is done by C and the address
>> must be stable. We are owning the pointee and must drop it when it goes =
out
>> of scope. I could do this:
>>=20
>> #[repr(transparent)]
>> struct GenDisk(Opaque<bindings::gendisk>);
>>=20
>> struct UniqueGenDiskRef {
>>      _tagset: Arc<TagSet<T>>,
>>      gendisk: Pin<&'static mut GenDisk>,
>>=20
>> }
>>=20
>> but it seems pointless. `struct GenDisk` would not be pub in that case. =
What do you think?
>
> Hmm, I am a bit confused as to how you usually use a `struct gendisk`.
> You said that a `TagSet` might be shared between multiple `GenDisk`s,
> but that is not facilitated by the C side?
>
> Is it the case that on the C side you create a struct containing a
> tagset and a gendisk for every block device you want to represent?

Yes, but the `struct tag_set` can be shared between multiple `struct
gendisk`.

Let me try to elaborate:

In C you would first allocate a `struct tag_set` and partially
initialize it. The allocation can be dynamic, static or part of existing
allocation. You would then partially initialize the structure and finish
the initialization by calling `blk_mq_alloc_tag_set()`. This populates
the rest of the structure which includes more dynamic allocations.

You then allocate a `struct gendisk` by calling `blk_mq_alloc_disk()`,
passing in a pointer to the `struct tag_set` you just created. This
function will return a pointer to a `struct gendisk` on success.

In the Rust abstractions, we allocate the `TagSet`:

#[pin_data(PinnedDrop)]
#[repr(transparent)]
pub struct TagSet<T: Operations> {
    #[pin]
    inner: Opaque<bindings::blk_mq_tag_set>,
    _p: PhantomData<T>,
}

with `PinInit` [^1]. The initializer will partially initialize the struct a=
nd
finish the initialization like C does by calling
`blk_mq_alloc_tag_set()`. We now need a place to point the initializer.
`Arc::pin_init()` is that place for now. It allows us to pass the
`TagSet` reference to multiple `GenDisk` if required. Maybe we could be
generic over `Deref<TagSet>` in the future. Bottom line is that we need
to hold on to that `TagSet` reference until the `GenDisk` is dropped.

`struct tag_set` is not reference counted on the C side. C
implementations just take care to keep it alive, for instance by storing
it next to a pointer to `struct gendisk` that it is servicing.

> And you decided for the Rust abstractions that you want to have only a
> single generic struct for any block device, distinguished by the generic
> parameter?

Yes, we have a single generic struct (`GenDisk`) representing the C
`struct gendisk`, and a single generic struct (`TagSet`) representing
the C `struct tag_set`. These are both generic over `T: Operations`.
`Operations` represent a C vtable (`struct blk_mq_ops`) attached to the
`struct tag_set`. This vtable is provided by the driver and holds
function pointers that allow the kernel to perform actions such as queue
IO requests with the driver. A C driver can instantiate multiple `struct
gendisk` and service them with the same `struct tag_set` and thereby the
same vtable. Or it can use separate tag sets and the same vtable. Or a
separate tag_set and vtable for each gendisk.

> I think these kinds of details would be nice to know. Not only for
> reviewers, but also for veterans of the C APIs.

I should write some module level documentation clarifying the use of
these types. The null block driver is a simple example, but it is just
code. I will include more docs in the next version.

Best regards
Andreas


[^1]: This was not `PinInit` in the RFC, I changed this based on your
feedback. The main points are still the same though.

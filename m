Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84221C684
	for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610056; cv=none; b=Yk1AFsu05sFSbgXpUopj6HSmOQsA04J3JBl9COnv9hJG8xLXMEDXYI7WgwS4HfayfkCmGsVKN9GmGSBdY3PFWKrwnW0vN12qLFTTur/vclcNv+9imjWaiTgfX2pZoZ2eT6GZTU620veZ3Z4n0gicllKgda727hbZa1QrCGWZE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610056; c=relaxed/simple;
	bh=rlqQHY/Iru95tLSYrHqyJIG83LeQkWO2iRzCE/rjTgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ne5iMmkrTc937YR1kh+/CosvjTWfYoEKiWF4Q4bOZ6ZosjAKSZ3nZimXhpIdJXM58fI4bMH+mI0KjNHy6DSFKGSSHTEWUO648lfvXusEC6x6bnlH8WfeOusgMDBwT1XVVdgHmHl0LfY8CjBSu7EW5NFARAHI3PRLQelqDXs2q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Fj2T0jc6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Fj2T0jc6"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3950036e87.0
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710610051; x=1711214851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldIeQ0x8GcqpmGtokI1YG/KjLGWPo0JWFs82jZy3wgU=;
        b=Fj2T0jc6Oq8Cg/+ddV44q21UZsa5YSbow3RY2BpzX5ULaTf88nqeZEObZ7OeVl2+ZZ
         zOqAkcxuOooxQis1GqvTnE/ifVYEbbwJJsoZuEodIQRx9l3d9K6WVcTdqFqs2ud6J4Zv
         o7lGJmzkr0Qv/tqPaw45m98QSNeldohAtpga6pcCRN8zhjSKoS4iVbS4PeqJtUk+eImB
         wJhq69q7GU922LVjXUs3G2Drh4QSnbyyU5HGaTymUg9yRwPnki3JfHmXOAsPIIUZWdPD
         2xddLMkkY+4DXoU5KO4/h36JSj/QgrRQ85YFmRzzuDSyPUsUkX+I6OfyDbsKrYde00DP
         5v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710610051; x=1711214851;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldIeQ0x8GcqpmGtokI1YG/KjLGWPo0JWFs82jZy3wgU=;
        b=xR5QSLkOaw0G43x8JGeGK0ORAPZ2IdPuGsBwPTJ+y3Gk8DyEcjoR9HYCC4+FcBGXBV
         FubytA/Dhs43Bxjc/OFWVX3NB23sBMVj8uUaa5xOYWpwfo0esnY5P3mZgPYWSPTmsWSC
         rIeCx0Yhm86m9S2usD6FtFNsNjMEcE18agqclgvHttSY/EWpGDVxcUx8utCEczzuPXxJ
         vnXXE29mxr3dfQNMjGxwqc1DOzqbk7O8p6McXXFIkSE4aMwyamkfqtyDkNOp754vjAlB
         vooo0trJBh1k+umiMPph0aiV6yDv4y8YSdtuQtqh38JQ6lkYdc0vRUE6eTBhtwBrxbv5
         M4rw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgYP19GpkRy4TmE4Na1EfUwDVIIcwTlNxQDU6AVGlpX4ez1OsVMRlbw7mX5s+TDD1DZrI3rQwLl6mrHjolRDPevDX0qfkkNes/a0=
X-Gm-Message-State: AOJu0YwYrcezl/bXFmwInURrc+ZwiMrEUgM9UhYdT9Ue24DY1XRHxgeE
	rf22BLNF7+4m2PFpoadbR1GibjXE4hJn6/NWOUloX4EjxCAb5jBkx5xBFgAKHYY=
X-Google-Smtp-Source: AGHT+IEgn2nD6Ekhe0UTM1uxUR2tB9g9Tk4Fntk67sLksxOmjaiU9EGRcMT21FlbyM2Q4WLrp/HV3Q==
X-Received: by 2002:a05:6512:61:b0:513:a7c5:15d with SMTP id i1-20020a056512006100b00513a7c5015dmr4376959lfo.47.1710610050593;
        Sat, 16 Mar 2024 10:27:30 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id qk26-20020a170906d9da00b00a45bb14b1a5sm2921212ejb.89.2024.03.16.10.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 10:27:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,  Jens Axboe
 <axboe@kernel.dk>,  Keith Busch <kbusch@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Christoph Hellwig <hch@lst.de>,  Damien Le Moal
 <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,  Hannes
 Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Niklas Cassel
 <Niklas.Cassel@wdc.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Alice Ryhl <aliceryhl@google.com>,  Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan
 Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <ZfWxOgYLgRN6Pcge@fedora> (Ming Lei's message of "Sat, 16 Mar
	2024 22:48:26 +0800")
References: <ZfI8-14RUqGqoRd-@boqun-archlinux> <87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
	<CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
	<8734ssrkxd.fsf@metaspace.dk> <ZfQ8Wz9gMqsN02Mv@fedora>
	<87o7bfr7bt.fsf@metaspace.dk> <ZfRoJxzOLZEIaQK7@fedora>
	<87il1nqtak.fsf@metaspace.dk> <ZfWxOgYLgRN6Pcge@fedora>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Sat, 16 Mar 2024 18:27:22 +0100
Message-ID: <87cyruqe85.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> writes:

> On Fri, Mar 15, 2024 at 06:49:39PM +0100, Andreas Hindborg wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>>=20
>> > On Fri, Mar 15, 2024 at 01:46:30PM +0100, Andreas Hindborg wrote:
>> >> Ming Lei <ming.lei@redhat.com> writes:
>> >> > On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
>> >> >> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>> >> >>=20
>> >> >> > On Thu, Mar 14, 2024 at 8:23=E2=80=AFPM Andreas Hindborg <nmi@me=
taspace.dk> wrote:
>> >> >> >>
>> >> >> >> The way the current code compiles, <kernel::block::mq::Request =
as
>> >> >> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the =
`rnull`
>> >> >> >> module. A relocation for `rust_helper_blk_mq_free_request_inter=
nal`
>> >> >> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
>> >> >> >> `__blk_mq_free_request` (or the helper) is not exported, I don'=
t think
>> >> >> >> this would be possible?
>> >> >> >
>> >> >> > Yeah, something needs to be exported since there is a generic
>> >> >> > involved, but even if you want to go the route of exporting only=
 a
>> >> >> > different symbol, you would still want to put it in the C header=
 so
>> >> >> > that you don't get the C missing declaration warning and so that=
 we
>> >> >> > don't have to write the declaration manually in the helper.
>> >> >>=20
>> >> >> That is what I did:
>> >> >>=20
>> >> >> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_=
set *set,
>> >> >>  		unsigned int set_flags);
>> >> >>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
>> >> >>=20=20
>> >> >> +void __blk_mq_free_request(struct request *rq);
>> >> >>  void blk_mq_free_request(struct request *rq);
>> >> >>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>> >> >>  		unsigned int poll_flags);
>> >> >
>> >> > Can you explain in detail why one block layer internal helper is
>> >> > called into rnull driver directly? It never happens in C driver cod=
e.
>> >>=20
>> >> It is not the rust null block driver that calls this symbol directly.=
 It
>> >> is called by the Rust block device driver API. But because of inlinin=
g,
>> >> the symbol is referenced from the loadable object.
>> >
>> > What is the exact Rust block device driver API? The key point is that =
how
>> > the body of one exported kernel C API(EXPORT_SYMBOL) becomes inlined
>> > with Rust driver.
>>=20
>> This happens when `ARef<Request<_>>` is dropped. The drop method
>> (destructor) of this smart pointer decrements the refcount and
>> potentially calls `__blk_mq_free_request`.
>>=20
>> >>=20
>> >> The reason we have to call this symbol directly is to ensure proper
>> >> lifetime of the `struct request`. For example in C, when a driver
>> >
>> > Sounds Rust API still calls into __blk_mq_free_request() directly, rig=
ht?
>>=20
>> Yes, the Rust block device driver API will call this request if an
>> `ARef<Request<_>>` is dropped and the refcount goes to 0.
>>=20
>> > If that is the case, the usecase need to be justified, and you need
>> > to write one standalone patch with the exact story for exporting
>> > __blk_mq_free_request().
>>=20
>> Ok, I can do that.
>>=20
>> >
>> >> converts a tag to a request, the developer makes sure to only ask for
>> >> requests which are outstanding in the driver. In Rust, for the API to=
 be
>> >> sound, we must ensure that the developer cannot write safe code that
>> >> obtains a reference to a request that is not owned by the driver.
>> >>=20
>> >> A similar issue exists in the null block driver when timer completions
>> >> are enabled. If the request is cancelled and the timer fires after the
>> >> request has been recycled, there is a problem because the timer holds=
 a
>> >> reference to the request private data area.
>> >>=20
>> >> To that end, I use the `atomic_t ref` field of the C `struct request`
>> >> and implement the `AlwaysRefCounted` Rust trait for the request type.
>> >> This is a smart pointer that owns a reference to the pointee. In this
>> >> way, the request is not freed and recycled until the smart pointer is
>> >> dropped. But if the smart pointer holds the last reference when it is
>> >> dropped, it must be able to free the request, and hence it has to call
>> >> `__blk_mq_free_request`.
>> >
>> > For callbacks(queue_rq, timeout, complete) implemented by driver, block
>> > layer core guaranteed that the passed request reference is live.
>> >
>> > So driver needn't to worry about request lifetime, same with Rust
>> > driver, I think smart pointer isn't necessary for using request in
>> > Rust driver.
>>=20
>> Using the C API, there is nothing preventing a driver from using the
>> request after the lifetime ends.
>
> Yes, it is true for C, so will Rust-for-linux need to add refcount for
> most exported kernel C structure? such as by implementing AlwaysRefCounted
> traits?

Not for all types and not all the time. For instance the Rust block
device driver API does not always use refcounting for `struct request`.
Only when it cannot determine the lifetime of a request reference at
compile time.

>
>> With Rust, we have to make it
>> impossible.Without the refcount and associated call to
>> `__blk_mq_free_request`, it would be possible to write Rust code that
>> access the request after the lifetime ends. This is not sound, and it is
>> something we need to avoid in the Rust abstractions.
>>=20
>> One concrete way to do write unsound code with a Rust API where lifetime
>> is not tracked with refcount, is if the null block timer completion
>> callback fires after the request is completed. Perhaps the driver
>> cancels the request but forgets to cancel the timer. When the timer
>> fires, it will access the request via the context pointer, but the
>> request will be invalid.
>
> The issue is less serious for blk-mq request, which is pre-allocated,
> and one freed request just means it can be re-allocated for other IO
> in same queue, and the pointed memory won't be really freed.

The issue here is not so much use after free as it is aliasing of
mutable and shared references. This is illegal in Rust, and programs
that allow this may exhibit undefined behavior.

> Also as I mentioned, inside driver's ->timeout(), the request is
> guaranteed to be live by block layer core(won't be re-allocated to other =
IO),
> the passed-in request is referenced already, please see bt_iter() which
> is called from blk_mq_timeout_work(). Here, block layer core just
> borrows request, then passed the reference to ->timeout(), when
> request is owned by driver actually.

I understand. I am not referring to `blk_mq_opw.timeout`. The null block
driver has a feature where requests complete after a delay. This is
implemented via the `hrtimer` subsystem.

> I understand Rust block driver still need to implement ->queue_rq(),
> ->timeout(), ..., just like C driver, but maybe I am wrong? Or Rust block=
 driver
> will re-implement part of block layer core code? such as, get one extra
> reference of request no matter block core has done that.

The Rust block driver API implements the `blk_mq_ops` vtable on behalf
of the driver. There is a little bit of glue code inserted between the C
symbols called by the kernel and the Rust functions that the block device
driver provides.

>> In C we have to write the driver code so this
>> cannot happen. In Rust, the API must prevent this from happening. So any
>> driver written in the safe subset of Rust using this API can never
>> trigger this behavior.
>>=20
>> By using the refcount, we ensure that the request is alive until all
>> users who hold a reference to it are dropped.
>
> block layer has provided such guarantee if Rust driver follows current
> block driver model.

I understand that the driver has exclusive ownership of the request
between `queue_rq()` and `complete()`. What we want to guarantee is that
the author of a block device driver is not able to access a request
after block layer has regained ownership of the request (after complete).
The way we achieve this is by preventing block layer from calling
`__blk_mq_free_request` if the Rust driver did not destroy all
references to the request.

I understand that this is not necessary for correct operation of a
block device driver. However, it is necessary to uphold invariants of
the Rust language for references.

>>=20
>> Another concrete example is when a driver calls `blk_mq_tag_to_rq` with
>> an invalid tag. This can return a reference to an invalid tag, if the
>> driver is not implemented correctly. By using `req_ref_inc_not_zero` we
>> can assert that the request is live before we create a Rust reference to
>> it, and even if the driver code has bugs, it can never access an invalid
>> request, and thus it can be memory safe.
>>=20
>> We move the responsibility of correctness, in relation to memory safety,
>> from the driver implementation to the API implementation.
>
> After queue_rq(req) is called, request ownership is actually transferred =
to
> driver like Rust's move, then driver is free to call blk_mq_tag_to_rq(), =
and
> finally return request to block core after the request is completed by dr=
iver.

As I said, I understand and appreciate this design. But there is a
possibility for a buggy driver to not obey. The Rust abstractions must
prevent this buggy code from compiling at all. In Rust, it must be
impossible to call `blk_mq_tag_to_rq()` for a tag that is not owned by
the driver. `blk_mq_tag_to_rq` takes an integer, so the driver developer
can call this function with an invalid tag like
`blk_mq_tag_to_rq(tagset, 5)`. If 5 is not owned by the driver, this
will return a request pointer that will alias with mutable access. When
this pointer is converted to a Rust reference, this will give undefined
behavior. For Rust, we must prevent code like this from compiling in the
first place.

> The biggest question should be how Rust block driver will be designed &
> implemented? Will rust block driver follow current C driver's model, such
> as implementing ->queue_rq(), ->timeout(), ->complete()...?

The Rust driver API does follow the design of the C driver model. It
does implement the `blk_mq_ops` vtable. Rust block drivers must
implement a set of Rust functions that very closely follow this vtable.
But when it is not possible to statically determine the lifetime of an
object, to the point where the compiler will refuse to compile the code
that violates the lifetime durations of the object, we must revert to
reference counting.

I understand that a correctly implemented block device driver will not
violate lifetime of the request structure. Incorrect driver code might
violate the lifetime though. With Rust, we must prevent incorrectly
implemented drivers from compiling at all. We need the refcount for
that. By only allowing access to the request through the refcounted
pointer in certain cases, we prevent the safe driver code from
misbehaving.

It might seem cumbersome to do this dance at first. After all, we can
just write the device drivers correctly without memory safety bugs. But
the reward for all this work is that if a device driver is implemented
in the safe subset of Rust, it _cannot_ exhibit memory safety related
bugs. We don't have to review a device driver implemented in safe Rust
for memory safety issues at all.

Best regards,
Andreas

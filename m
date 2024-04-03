Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CDE26286
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133990; cv=none; b=iRKjcNU+3j6WxcuuusVKCJcLmvcjvPj//+tdjk1ghbYUiCz8WrP8ZbTneS1p4Dtf4comq3fgb6XUy1vt677vfmhTK5jLxByO9aI1OUiUawsCd9YHCurFpwHhfx0rWpql8VHgPYRdFGyZDL7Pe+1pb+TFs7FFxxyYV9DiwpPz2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133990; c=relaxed/simple;
	bh=CnCNaZzl5rEH+QwH0mfl8Hi6Yca+JPC01k5/o/eFevs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oP2W1hm7jDM1IxDFVBwwwSTJgWoWo3llriOE6jswzbJeHAEl//QVO/R0WC+A0XGGzRv6XUMT6TJrIVP8h2J8DBX0GxmM5MrxHTtSRk/9DxDnrSNlBRjRMq3oln/3ociIJBGPSq3RH77FjDf8R5ATqWD+02N9JwuwfrwRxinsue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=vHlPntHc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="vHlPntHc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56df1dbb15dso1860687a12.3
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2024 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712133986; x=1712738786; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ZMejo28/LllyfJA5g9nwz3RGVzU+8WXzt/3Z5s4wA=;
        b=vHlPntHcV3neZhL+d8OrTCOLohiXlSLDh6Ra9sMTNc/vREXX/2C8ev4B4JSlnbhxjw
         7q99LKyw+CQwZgwgfxvpYj/Z2jC8AWtDwit42nVn30QyrGlALTCn/uU6SXAAXTSpO7wu
         AzRjlzfPHsNuhEf/fvPQNw3wGEI9gpY1jzl1/3wM5Woba0opiuM9QPP29BVSICxe/+HW
         NKusdeTNiQzpDBrxf6EgL3XRrdWH/Z7mGEpqJ0NECyJxhoid0vf5rAjQB6ZcPo+fpFb3
         rEIAg5TTKGf03lbbWbumZl1KRp369qZm7IbtweUgAWuN0owAwYpoaFc9W0Q9d9M3kf2k
         WK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133986; x=1712738786;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/ZMejo28/LllyfJA5g9nwz3RGVzU+8WXzt/3Z5s4wA=;
        b=eqW2/5VnIAeA0+JOC9H3SeFo9kKv0o/NDGUuL1BkUeph4Z2VWu1P6DnjJ2Pgh2QJ+y
         rNZZGOTwtGJ04tulvcAnzWcpyvH6eyVNdPlt4Y0IzVrLhlq77zQmFEbJJtpQhCietfU3
         MUt2UqvOa8cTzS2ly6l1yKp5SYUpxVU9Jxy6NV2I2QCV5RHXx16ru2YplydzoKPDDizF
         yzSw55l1ZV4dojPa7lIG9DSruup24un+b1fGfGQmZ+ZR9pM+gdrF1ZZ/h7k+43kYg4Iw
         Q3DivEkEc8kapQ6kqHZE/wuzeELD0l0js32ssvbxCM82YCvP4xXJJNSIqCEoGdS96Cr0
         fS4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLxoIWZG0YL6Zodu81ppgdsM8BHGC7C8ncEq6AkzUN5LsC07UHR2Imxklrg5kw+/5Tz5NKnieBpONlM92yrkCYeesAddUBiFYKnRg=
X-Gm-Message-State: AOJu0YxLEu4VLKERzcTsJVKsXMh+IRfhPELC7OefYGA8ZTynNBD+OIgw
	pExDxSTxjBEcOWIhee2FZ+KkoiCWsf9SBQ/dX+DnG3KzAX6K22GQycIilT2lCOw=
X-Google-Smtp-Source: AGHT+IGo0b98RS6TrT3TIulpj9uf0OgGe9HgqnWXsEMXgCAc3KB/kjdbiHGYBrypbUj2L0uEeH3M1A==
X-Received: by 2002:a05:6402:5111:b0:56e:447:1e44 with SMTP id m17-20020a056402511100b0056e04471e44mr1297850edd.8.1712133985643;
        Wed, 03 Apr 2024 01:46:25 -0700 (PDT)
Received: from localhost ([194.62.217.1])
        by smtp.gmail.com with ESMTPSA id l24-20020aa7cad8000000b00562d908daf4sm7753421edt.84.2024.04.03.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:46:25 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Greg KH
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
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> (Benno Lossin's
	message of "Tue, 02 Apr 2024 23:09:49 +0000")
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
	<871q7o54el.fsf@metaspace.dk>
	<7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 03 Apr 2024 10:46:19 +0200
Message-ID: <87v84ysujo.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 23.03.24 07:32, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>> +//! implementations of the `Operations` trait.
>>>> +//!
>>>> +//! IO requests are passed to the driver as [`Request`] references. The
>>>> +//! `Request` type is a wrapper around the C `struct request`. The driver must
>>>> +//! mark start of request processing by calling [`Request::start`] and end of
>>>> +//! processing by calling one of the [`Request::end`], methods. Failure to do so
>>>> +//! can lead to IO failures.
>>>
>>> I am unfamiliar with this, what are "IO failures"?
>>> Do you think that it might be better to change the API to use a
>>> callback? So instead of calling start and end, you would do
>>>
>>>       request.handle(|req| {
>>>           // do the stuff that would be done between start and end
>>>       });
>>>
>>> I took a quick look at the rnull driver and there you are calling
>>> `Request::end_ok` from a different function. So my suggestion might not
>>> be possible, since you really need the freedom.
>>>
>>> Do you think that a guard approach might work better? ie `start` returns
>>> a guard that when dropped will call `end` and you need the guard to
>>> operate on the request.
>> 
>> I don't think that would fit, since the driver might not complete the
>> request immediately. We might be able to call `start` on behalf of the
>> driver.
>> 
>> At any rate, since the request is reference counted now, we can
>> automatically fail a request when the last reference is dropped and it
>> was not marked successfully completed. I would need to measure the
>> performance implications of such a feature.
>
> Are there cases where you still need access to the request after you
> have called `end`?

In general no, there is no need to handle the request after calling end.
C drivers are not allowed to, because this transfers ownership of the
request back to the block layer. This patch series defer the transfer of
ownership to the point when the ARef<Request> refcount goes to zero, so
there should be no danger associated with touching the `Request` after
end.

> If no, I think it would be better for the request to
> be consumed by the `end` function.
> This is a bit difficult with `ARef`, since the user can just clone it
> though... Do you think that it might be necessary to clone requests?

Looking into the details now I see that calling `Request::end` more than
once will trigger UAF, because C code decrements the refcount on the
request. When we have `ARef<Request>` around, that is a problem. It
probably also messes with other things in C land. Good catch.

I did implement `Request::end` to consume the request at one point
before I fell back on reference counting. It works fine for simple
drivers. However, most drivers will need to use the block layer tag set
service, that allows conversion of an integer id to a request pointer.
The abstraction for this feature is not part of this patch set. But the
block layer manages a mapping of integer to request mapping, and drivers
typically use this to identify the request that corresponds to
completion messages that arrive from hardware. When drivers are able to
turn integers into requests like this, consuming the request in the call
to `end` makes little sense (because we can just construct more).

What I do now is issue the an `Option<ARef<Request>>` with
`bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
is currently owned by the driver.

I guess we can check the absolute value of the refcount, and only issue
a request handle if the count matches what we expect. Then we can be certain
that the handle is unique, and we can require transfer of ownership of
the handle to `Request::end` to make sure it can never be called more
than once.

Another option is to error out in `Request::end` if the
refcount is not what we expect.

>
> Also what happens if I call `end_ok` and then `end_err` or vice versa?

That would be similar to calling end twice.

>
>>>> +    pub fn data_ref(&self) -> &T::RequestData {
>>>> +        let request_ptr = self.0.get().cast::<bindings::request>();
>>>> +
>>>> +        // SAFETY: `request_ptr` is a valid `struct request` because `ARef` is
>>>> +        // `repr(transparent)`
>>>> +        let p: *mut c_void = unsafe { bindings::blk_mq_rq_to_pdu(request_ptr) };
>>>> +
>>>> +        let p = p.cast::<T::RequestData>();
>>>> +
>>>> +        // SAFETY: By C API contract, `p` is initialized by a call to
>>>> +        // `OperationsVTable::init_request_callback()`. By existence of `&self`
>>>> +        // it must be valid for use as a shared reference.
>>>> +        unsafe { &*p }
>>>> +    }
>>>> +}
>>>> +
>>>> +// SAFETY: It is impossible to obtain an owned or mutable `Request`, so we can
>>>
>>> What do you mean by "mutable `Request`"? There is the function to obtain
>>> a `&mut Request`.
>> 
>> The idea behind this comment is that it is not possible to have an owned
>> `Request` instance. You can only ever have something that will deref
>> (shared) to `Request`. Construction of the `Request` type is not
>> possible in safe driver code. At least that is the intention.
>> 
>> The `from_ptr_mut` is unsafe, and could be downgraded to
>> `from_ptr`, since `Operations::complete` takes a shared reference
>> anyway. Bottom line is that user code does not handle `&mut Request`.
>
> Ah I see what you mean. But the user is able to have an `ARef<Request>`.
> Which you own, if it is the only refcount currently held on that
> request. When you drop it, you will run the destructor of the request.
>
> A more suitable safety comment would be "SAFETY: A `struct request` may
> be destroyed from any thread.".

I see, I will update the comment.


BR Andreas

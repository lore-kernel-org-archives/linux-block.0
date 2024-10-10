Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108F1A08BC
	for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553721; cv=none; b=AE9bXzxL5WfFsImtOE8+J2dm6itSrc6s4/SEewXO2hjHvn3S6TmP53HtGhT4t+vfjZQ9GYTUzyP7F//zA/KvtWNXo6/EKpz5xRxrGTgbPYJ/vCLOyfNKiD8XQVoXJaAQvsOIc4tjX54JqYzdYsGNCMAsJDHGAcLEBtQqW2ViTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553721; c=relaxed/simple;
	bh=Hmt3jEs6UFtCZSwVksLED/7D3NvxMMvWC6XgppiqDdk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVSj8cXNoAof4uK+5HifLSfP7EXBJLETq3b9Oy6A1ZpUViRCJt4RO9h4rnMwX1KI+SdZ269dTrw1bpzcsXuz0kFaxhQkoM1a0r8MHsUqemcWm7xZOdrboNLGwXZbfFaoLsXakBYbrrcT6YiDXsC9TQ6YRXg73ZDR0LeHsWcpC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kA0ia7XW; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kA0ia7XW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728553716; x=1728812916;
	bh=zjjrWauUtafR1DGK8lQ4A/Pbp3ms1S1NTtMuRVcyuIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kA0ia7XWxjYQ7IHaBlnJMZyUHgv6uMNRaP5fL2Bbv6Pvm4ioSI/5/pSAvZocNlK+N
	 ciO4wv6VTht6djm++Bcq8Zgt3YSVp4efKCJLtqo42QwmdCQt5AHFrYlALVKCSp5/fB
	 HjQ59bjThiJ3uNihNqJvTxmjBlVfc5HNfZnSfKPz9TowPmvXIjCRbcSI4MOwfFjCp7
	 PgBkeGIUKwxCEoDo6+fm4JB0c8mQLCrWF7VoJlbk4Zy2iBgTDro5qnC94nhcYaz7Ov
	 ckIjR5t7GxEFmoaxi8oMbxSN1hRcpn8yAR2fwhJhlJ2H3hckG6Bz0dmWfvsvVnUjhK
	 Q306B2yKxJNCA==
Date: Thu, 10 Oct 2024 09:48:31 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <19808a54-cb7e-4818-98e9-5de32bfede2c@proton.me>
In-Reply-To: <87set4min7.fsf@kernel.org>
References: <20241004155247.2210469-1-gary@garyguo.net> <2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org> <CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com> <fz1Ji-tl63pAnAOL2TkFwggNx45TTBONKOUcKAKq7e6ZOCX2KsklDS6Zbc_xqnMef1eevpM-a64Bui_nEg49mA==@protonmail.internalid> <20241005142332.78b8b5d0.gary@garyguo.net> <87msjioax2.fsf@kernel.org> <871q0onyhf.fsf@kernel.org> <87set4min7.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 39b58565af7c7faa869c9594e80aa2a7225e8963
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.24 11:06, Andreas Hindborg wrote:
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>=20
>> Andreas Hindborg <a.hindborg@kernel.org> writes:
>>
>>> "Gary Guo" <gary@garyguo.net> writes:
>>>
>>>> On Sat, 5 Oct 2024 13:59:44 +0200
>>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>>
>>>>> On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@=
kernel.org> wrote:
>>>>>>
>>>>>> Hi Greg,
>>>>>>
>>>>>> "Greg KH" <gregkh@linuxfoundation.org> writes:
>>>>>>
>>>>>>> On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
>>>>>>>> There is an operation needed by `block::mq`, atomically decreasing
>>>>>>>> refcount from 2 to 0, which is not available through refcount.h, s=
o
>>>>>>>> I exposed `Refcount::as_atomic` which allows accessing the refcoun=
t
>>>>>>>> directly.
>>>>>>>
>>>>>>> That's scary, and of course feels wrong on many levels, but:
>>>>>>>
>>>>>>>
>>>>>>>> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &AR=
ef<Self>) {
>>>>>>>>      /// C `struct request`. If the operation fails, `this` is ret=
urned in the
>>>>>>>>      /// `Err` variant.
>>>>>>>>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::req=
uest, ARef<Self>> {
>>>>>>>> -        // We can race with `TagSet::tag_to_rq`
>>>>>>>> -        if let Err(_old) =3D this.wrapper_ref().refcount().compar=
e_exchange(
>>>>>>>> -            2,
>>>>>>>> -            0,
>>>>>>>> -            Ordering::Relaxed,
>>>>>>>> -            Ordering::Relaxed,
>>>>>>>> -        ) {
>>>>>>>> +        // To hand back the ownership, we need the current refcou=
nt to be 2.
>>>>>>>> +        // Since we can race with `TagSet::tag_to_rq`, this needs=
 to atomically reduce
>>>>>>>> +        // refcount to 0. `Refcount` does not provide a way to do=
 this, so use the underlying
>>>>>>>> +        // atomics directly.
>>>>>>>> +        if this
>>>>>>>> +            .wrapper_ref()
>>>>>>>> +            .refcount()
>>>>>>>> +            .as_atomic()
>>>>>>>> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::=
Relaxed)
>>>>>>>> +            .is_err()
>>>>>>>
>>>>>>> Why not just call rust_helper_refcount_set()?  Or is the issue that=
 you
>>>>>>> think you might not be 2 here?  And if you HAVE to be 2, why that m=
agic
>>>>>>> value (i.e. why not just always be 1 and rely on normal
>>>>>>> increment/decrement?)
>>>>>>>
>>>>>>> I know some refcounts are odd in the kernel, but I don't see where =
the
>>>>>>> block layer is caring about 2 as a refcount anywhere, what am I mis=
sing?
>>>>>>
>>>>>> It is in the documentation, rendered version available here [1]. Let=
 me
>>>>>> know if it is still unclear, then I guess we need to update the docs=
.
>>>>>>
>>>>>> Also, my session from Recipes has a little bit of discussion regardi=
ng
>>>>>> this refcount and it's use [2].
>>>>>>
>>>>>> Best regards,
>>>>>> Andreas
>>>>>>
>>>>>>
>>>>>> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html=
#implementation-details
>>>>>> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>>>>>
>>>>> So it sounds like there is one refcount from the C side, and some
>>>>> number of references from the Rust side. The function checks whether
>>>>> there's only one Rust reference left, and if so, takes ownership of
>>>>> the value, correct?
>>>>>
>>>>> In that case, the CAS should have an acquire ordering to synchronize
>>>>> with dropping the refcount 3->2 on another thread. Otherwise, you
>>>>> might have a data race with the operations that happened just before
>>>>> the 3->2 refcount drop.
>>>>>
>>>>> Alice
>>>>
>>>> The code as is is fine since there's no data protected in
>>>> `RequestDataWrapper` yet (in fact it's not even generic yet). I know
>>>> Andreas does want to introduce driver-specific data into that, so in
>>>> the long term the acquire would be necessary.
>>>>
>>>> Andreas, please let me know if you want me to make the change now, or
>>>> you'd rather change the ordering when you introduce data to
>>>> `RequestDataWrapper`.
>>>
>>> I guess we will have said data dependencies when we are going to run
>>> drop for fields in the private data area. Thanks for pointing that out.
>>> I will update the ordering when I submit that patch.
>>>
>>> As I mentioned before, I would rather we do not apply this patch before
>>> we get a way to inline helpers.
>>
>> As discussed offline, the code that suffers the performance regression
>> is downstream, and since this change seems to be important, I can apply
>> the helper LTO patch downstream as well.
>>
>> Since the plan for the downstream code _is_ to move upstream, I really
>> hope to see the helper LTO patch upstream, so we don't get a performance
>> regression because of these refcounts.
>>
>> If we cannot figure out a way to get the LTO patches (or an alternative
>> solution) upstream, we can always revert back to a more performant
>> solution in block.
>=20
> I forgot to report the result of the benchmarks. Over the usual
> benchmark workload that I run for `rnull` I see an average 0.8 percent
> performance penalty with this patch. For some configurations
> I see 95% CI N=3D40 [-18%;-5%]. So it is not insignificant.

Was the benchmark run together with the LTO helper patches?

---
Cheers,
Benno


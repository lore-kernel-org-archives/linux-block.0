Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD021BC072;
	Thu, 10 Oct 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551211; cv=none; b=hRWtgqKpIoNeZr8CmUjvJoTYfHaG17uBltpqmWKLlu0Vak/+/jrBoPHv7XOfu2pPECEjmGVbo71/hjBsR2xYRUvll+z8Nlei3/FRNSTTjgk1RF1epkZRfqq0SBFkoWeN7oB+sFQ2EF1Pc2ATlYCLqSlVTzVyN3QTQZdjwg2S6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551211; c=relaxed/simple;
	bh=v4F8XpUl4hzFdHfzDjb5HLOD91LVHfyBbNZzZzRfUAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tA4vyqVmnk6OO75vamtImUOjlBkAHz0AQs/MA5+EO9vkuSVGgMha+SsuYPxYMRqQSrQsfwPPi5gqOFWO7HvSO3Q8ih+qQPCK3nAiHDvCrhmFpAPHi8QQ67YH9mfUgprZ5n0l8dI4/oBN53vHMI9/UkdH5eS9QewwuvT4TujKXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0xTcg5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0xTcg5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F882C4CEC5;
	Thu, 10 Oct 2024 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728551211;
	bh=v4F8XpUl4hzFdHfzDjb5HLOD91LVHfyBbNZzZzRfUAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R0xTcg5L2aCx/ttD6ENUD6O6y1Zfwx3aCFVpWkNrHVIazxdpJw5ZtkdwfKBhtURRr
	 nKs+katFJtGY4y9BHsx6YE5YLYjJyfbk5XB0Ad2iiIxeARpwAHC7FA+lJZdmhUd74G
	 Sv67APBSjpoytNZZVp828xYUo8/esQSrHxYAzGzMi1pqcAAmjQcVphmr4yIWk06iuh
	 0yZ9pbVU6fAogCQZzdc83nl7zeVrgLPZLlbhR4nNZl8VIRciqGgae2hONIXtep4um7
	 EfOB3Vby2EJIgRv2v2i0IPeo+hySRYJ1+p/AJ+HhbBPMXpH9jnWoITGvuAkWNODkV/
	 UtSHXuY5irBBg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Greg KH"
 <gregkh@linuxfoundation.org>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Jens Axboe" <axboe@kernel.dk>,  "Will Deacon"
 <will@kernel.org>,  "Peter Zijlstra" <peterz@infradead.org>,  "Mark
 Rutland" <mark.rutland@arm.com>,  <linux-block@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <871q0onyhf.fsf@kernel.org> (Andreas Hindborg's message of "Thu,
	10 Oct 2024 10:39:08 +0200")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
	<CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
	<fz1Ji-tl63pAnAOL2TkFwggNx45TTBONKOUcKAKq7e6ZOCX2KsklDS6Zbc_xqnMef1eevpM-a64Bui_nEg49mA==@protonmail.internalid>
	<20241005142332.78b8b5d0.gary@garyguo.net> <87msjioax2.fsf@kernel.org>
	<871q0onyhf.fsf@kernel.org>
Date: Thu, 10 Oct 2024 11:06:36 +0200
Message-ID: <87set4min7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>>> On Sat, 5 Oct 2024 13:59:44 +0200
>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>
>>>> On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>>>> >
>>>> > Hi Greg,
>>>> >
>>>> > "Greg KH" <gregkh@linuxfoundation.org> writes:
>>>> >
>>>> > > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
>>>> > >> There is an operation needed by `block::mq`, atomically decreasing
>>>> > >> refcount from 2 to 0, which is not available through refcount.h, =
so
>>>> > >> I exposed `Refcount::as_atomic` which allows accessing the refcou=
nt
>>>> > >> directly.
>>>> > >
>>>> > > That's scary, and of course feels wrong on many levels, but:
>>>> > >
>>>> > >
>>>> > >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &A=
Ref<Self>) {
>>>> > >>      /// C `struct request`. If the operation fails, `this` is re=
turned in the
>>>> > >>      /// `Err` variant.
>>>> > >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::re=
quest, ARef<Self>> {
>>>> > >> -        // We can race with `TagSet::tag_to_rq`
>>>> > >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compa=
re_exchange(
>>>> > >> -            2,
>>>> > >> -            0,
>>>> > >> -            Ordering::Relaxed,
>>>> > >> -            Ordering::Relaxed,
>>>> > >> -        ) {
>>>> > >> +        // To hand back the ownership, we need the current refco=
unt to be 2.
>>>> > >> +        // Since we can race with `TagSet::tag_to_rq`, this need=
s to atomically reduce
>>>> > >> +        // refcount to 0. `Refcount` does not provide a way to d=
o this, so use the underlying
>>>> > >> +        // atomics directly.
>>>> > >> +        if this
>>>> > >> +            .wrapper_ref()
>>>> > >> +            .refcount()
>>>> > >> +            .as_atomic()
>>>> > >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering:=
:Relaxed)
>>>> > >> +            .is_err()
>>>> > >
>>>> > > Why not just call rust_helper_refcount_set()?  Or is the issue tha=
t you
>>>> > > think you might not be 2 here?  And if you HAVE to be 2, why that =
magic
>>>> > > value (i.e. why not just always be 1 and rely on normal
>>>> > > increment/decrement?)
>>>> > >
>>>> > > I know some refcounts are odd in the kernel, but I don't see where=
 the
>>>> > > block layer is caring about 2 as a refcount anywhere, what am I mi=
ssing?
>>>> >
>>>> > It is in the documentation, rendered version available here [1]. Let=
 me
>>>> > know if it is still unclear, then I guess we need to update the docs.
>>>> >
>>>> > Also, my session from Recipes has a little bit of discussion regardi=
ng
>>>> > this refcount and it's use [2].
>>>> >
>>>> > Best regards,
>>>> > Andreas
>>>> >
>>>> >
>>>> > [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html=
#implementation-details
>>>> > [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>>>>
>>>> So it sounds like there is one refcount from the C side, and some
>>>> number of references from the Rust side. The function checks whether
>>>> there's only one Rust reference left, and if so, takes ownership of
>>>> the value, correct?
>>>>
>>>> In that case, the CAS should have an acquire ordering to synchronize
>>>> with dropping the refcount 3->2 on another thread. Otherwise, you
>>>> might have a data race with the operations that happened just before
>>>> the 3->2 refcount drop.
>>>>
>>>> Alice
>>>
>>> The code as is is fine since there's no data protected in
>>> `RequestDataWrapper` yet (in fact it's not even generic yet). I know
>>> Andreas does want to introduce driver-specific data into that, so in
>>> the long term the acquire would be necessary.
>>>
>>> Andreas, please let me know if you want me to make the change now, or
>>> you'd rather change the ordering when you introduce data to
>>> `RequestDataWrapper`.
>>
>> I guess we will have said data dependencies when we are going to run
>> drop for fields in the private data area. Thanks for pointing that out.
>> I will update the ordering when I submit that patch.
>>
>> As I mentioned before, I would rather we do not apply this patch before
>> we get a way to inline helpers.
>
> As discussed offline, the code that suffers the performance regression
> is downstream, and since this change seems to be important, I can apply
> the helper LTO patch downstream as well.
>
> Since the plan for the downstream code _is_ to move upstream, I really
> hope to see the helper LTO patch upstream, so we don't get a performance
> regression because of these refcounts.
>
> If we cannot figure out a way to get the LTO patches (or an alternative
> solution) upstream, we can always revert back to a more performant
> solution in block.

I forgot to report the result of the benchmarks. Over the usual
benchmark workload that I run for `rnull` I see an average 0.8 percent
performance penalty with this patch. For some configurations
I see 95% CI N=3D40 [-18%;-5%]. So it is not insignificant.


BR Andreas


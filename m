Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA3158A33;
	Sat,  5 Oct 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140254; cv=none; b=sSgkaX/sD6MS2jaBUaQVFQ5eYNbV2/WC6ol/pDDG+KatcgcxTuyEn89IRUMdk26uNwYzdIqGYVg/z9YyZ7/35p6Jr7RLunkdAHMPKWhSIri55cz9pvOR7xmlqsoHmVYhanBZDR/KPs8uHEwGFhkoS/ml0va0pS0LiPi/mrB/dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140254; c=relaxed/simple;
	bh=UI6A+gUe9Or+l6RqYCzmLAd1fXEEIXTpGNecDTvRy2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJzWd+Kfn/lMmlN8D4IzR38397at39V5B2qmTmlEuxSGRzL8ypMwIeSbmb+fFF7m+00PmJZhKLju3ehnss7f4D8oV1mQZv0KRT+FZ6hWRUdJdDHbMVkGFxDn7lf33JrO1YJYeEMBnvki1CYzcGM2cBUlz3u9lFuvjRggfST3QaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll+msrGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll+msrGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C9CC4CED2;
	Sat,  5 Oct 2024 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728140253;
	bh=UI6A+gUe9Or+l6RqYCzmLAd1fXEEIXTpGNecDTvRy2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ll+msrGuoIUoY9xKwKYInTfQ7vNa6sEr58eYVOpKEL01IoELN4SgbHDhm90rtI6L7
	 70v4h/UJWMRUQxMEEaf/6u17HssLLNSAXTKCoWw4i1eSRcEjRzGWVPDsNJMrImx6VZ
	 jdLXRLlQnX5IWdbugT/V7VgpEvxWQJbQBMh9WWxNePzKEcHQMJC91V3S9F/lqf6+Rn
	 jgfSwasz5kGhJrCUVymwmm72pHVnJsn7vP6qL7zhbn4KiCSjM6rhWXIfzShpHdStJf
	 RpC9/AVc3S+z+kFvKBho0eW3/fIsxd2ig46v8AMlPgrE/XVN4dT7+Eqfy0cbH13gSe
	 BcdI0yXwctfTA==
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
In-Reply-To: <20241005142332.78b8b5d0.gary@garyguo.net> (Gary Guo's message of
	"Sat, 05 Oct 2024 14:23:32 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
	<CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
	<fz1Ji-tl63pAnAOL2TkFwggNx45TTBONKOUcKAKq7e6ZOCX2KsklDS6Zbc_xqnMef1eevpM-a64Bui_nEg49mA==@protonmail.internalid>
	<20241005142332.78b8b5d0.gary@garyguo.net>
Date: Sat, 05 Oct 2024 16:56:57 +0200
Message-ID: <87msjioax2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Gary Guo" <gary@garyguo.net> writes:

> On Sat, 5 Oct 2024 13:59:44 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
>> On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>> >
>> > Hi Greg,
>> >
>> > "Greg KH" <gregkh@linuxfoundation.org> writes:
>> >
>> > > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
>> > >> There is an operation needed by `block::mq`, atomically decreasing
>> > >> refcount from 2 to 0, which is not available through refcount.h, so
>> > >> I exposed `Refcount::as_atomic` which allows accessing the refcount
>> > >> directly.
>> > >
>> > > That's scary, and of course feels wrong on many levels, but:
>> > >
>> > >
>> > >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARe=
f<Self>) {
>> > >>      /// C `struct request`. If the operation fails, `this` is retu=
rned in the
>> > >>      /// `Err` variant.
>> > >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::requ=
est, ARef<Self>> {
>> > >> -        // We can race with `TagSet::tag_to_rq`
>> > >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare=
_exchange(
>> > >> -            2,
>> > >> -            0,
>> > >> -            Ordering::Relaxed,
>> > >> -            Ordering::Relaxed,
>> > >> -        ) {
>> > >> +        // To hand back the ownership, we need the current refcoun=
t to be 2.
>> > >> +        // Since we can race with `TagSet::tag_to_rq`, this needs =
to atomically reduce
>> > >> +        // refcount to 0. `Refcount` does not provide a way to do =
this, so use the underlying
>> > >> +        // atomics directly.
>> > >> +        if this
>> > >> +            .wrapper_ref()
>> > >> +            .refcount()
>> > >> +            .as_atomic()
>> > >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::R=
elaxed)
>> > >> +            .is_err()
>> > >
>> > > Why not just call rust_helper_refcount_set()?  Or is the issue that =
you
>> > > think you might not be 2 here?  And if you HAVE to be 2, why that ma=
gic
>> > > value (i.e. why not just always be 1 and rely on normal
>> > > increment/decrement?)
>> > >
>> > > I know some refcounts are odd in the kernel, but I don't see where t=
he
>> > > block layer is caring about 2 as a refcount anywhere, what am I miss=
ing?
>> >
>> > It is in the documentation, rendered version available here [1]. Let me
>> > know if it is still unclear, then I guess we need to update the docs.
>> >
>> > Also, my session from Recipes has a little bit of discussion regarding
>> > this refcount and it's use [2].
>> >
>> > Best regards,
>> > Andreas
>> >
>> >
>> > [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#i=
mplementation-details
>> > [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>>
>> So it sounds like there is one refcount from the C side, and some
>> number of references from the Rust side. The function checks whether
>> there's only one Rust reference left, and if so, takes ownership of
>> the value, correct?
>>
>> In that case, the CAS should have an acquire ordering to synchronize
>> with dropping the refcount 3->2 on another thread. Otherwise, you
>> might have a data race with the operations that happened just before
>> the 3->2 refcount drop.
>>
>> Alice
>
> The code as is is fine since there's no data protected in
> `RequestDataWrapper` yet (in fact it's not even generic yet). I know
> Andreas does want to introduce driver-specific data into that, so in
> the long term the acquire would be necessary.
>
> Andreas, please let me know if you want me to make the change now, or
> you'd rather change the ordering when you introduce data to
> `RequestDataWrapper`.

I guess we will have said data dependencies when we are going to run
drop for fields in the private data area. Thanks for pointing that out.
I will update the ordering when I submit that patch.

As I mentioned before, I would rather we do not apply this patch before
we get a way to inline helpers.


BR Andreas



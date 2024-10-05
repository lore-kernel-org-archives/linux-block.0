Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7171B7F4;
	Sat,  5 Oct 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139899; cv=none; b=G+wiXRsjC6pnWDdrKTBfPkVsT71XlQgt4gHbs2uKzdygIXqBRaHwVqKJQfMF7/PX3PznE6Ehc0XsHo7hky8dE1OCFEQ8qwBzfRh/ozrS9c42tyNL/ZsRBBbQXesLY6WLiCnqymgj9NxyPUmHuK6TTGaR2y3Oi1WKB3HRb2WRoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139899; c=relaxed/simple;
	bh=cIDQZ3VFgVlF584wBg+yIQIma0fK4hTce/36W+uCn8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvdDbG15MV/mNsYRhAyaK59OFC4hhL35p/mF0bWn2BHWPgCBJ3+DFjmtrM4KRy6jmS7owRLSzp/yFKO+klkETvXocsONVqd3ZXEfncrB6xE/5KtqPcfjQN+9W5nK16G9FikEnMDLkFhbn7iqyOMD70Z1DOZ9iMFezRNKhRVXnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shEvVrEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shEvVrEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3078AC4CEC2;
	Sat,  5 Oct 2024 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728139899;
	bh=cIDQZ3VFgVlF584wBg+yIQIma0fK4hTce/36W+uCn8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=shEvVrEIjtS4m/RLIHpsfbXPL0DUo2lDazMn29Ntpg/PIRkneYzn97Pt4OeBMBevT
	 4uQ3nYNoFjbF50/QrGS28+bFGb9LcwcQS5t61rxzTXw0GEaHZJ9l7IP6Z6VqTBXpwq
	 /EchaBAcVte02aphm1G4nfK+sWI073JsYUXreqPZz/eQ/c/dusd9/WikgR0OmBqUnZ
	 Q+MP0ZqRmbg1ijMxhwyxpjPCU3iS7HFO1ACsLJWU1olPzNm4cP0lHwhrcucCFU1hbJ
	 JL0V0gITqB3tOsCDh07lAW5rFonChQZn7ZiymEwTkziDSJ3saifTDTg1yVzgVQXHlk
	 LeevGFGvnk62A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,  "Gary Guo" <gary@garyguo.net>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jens Axboe" <axboe@kernel.dk>,
  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
 (Alice
	Ryhl's message of "Sat, 05 Oct 2024 13:59:44 +0200")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
	<Iv1dzncMcKGj5zv3wxh_AG5fxfl-RhnuU_pwEQ8rWbhzVCZ13lzLBOgU5Jva9iPBDWaZmyZjVnnOzs_Qwi3uhQ==@protonmail.internalid>
	<CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
Date: Sat, 05 Oct 2024 16:51:26 +0200
Message-ID: <87r08uob69.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Hi Greg,
>>
>> "Greg KH" <gregkh@linuxfoundation.org> writes:
>>
>> > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
>> >> There is an operation needed by `block::mq`, atomically decreasing
>> >> refcount from 2 to 0, which is not available through refcount.h, so
>> >> I exposed `Refcount::as_atomic` which allows accessing the refcount
>> >> directly.
>> >
>> > That's scary, and of course feels wrong on many levels, but:
>> >
>> >
>> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<=
Self>) {
>> >>      /// C `struct request`. If the operation fails, `this` is return=
ed in the
>> >>      /// `Err` variant.
>> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::reques=
t, ARef<Self>> {
>> >> -        // We can race with `TagSet::tag_to_rq`
>> >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_e=
xchange(
>> >> -            2,
>> >> -            0,
>> >> -            Ordering::Relaxed,
>> >> -            Ordering::Relaxed,
>> >> -        ) {
>> >> +        // To hand back the ownership, we need the current refcount =
to be 2.
>> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to=
 atomically reduce
>> >> +        // refcount to 0. `Refcount` does not provide a way to do th=
is, so use the underlying
>> >> +        // atomics directly.
>> >> +        if this
>> >> +            .wrapper_ref()
>> >> +            .refcount()
>> >> +            .as_atomic()
>> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Rel=
axed)
>> >> +            .is_err()
>> >
>> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
>> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
>> > value (i.e. why not just always be 1 and rely on normal
>> > increment/decrement?)
>> >
>> > I know some refcounts are odd in the kernel, but I don't see where the
>> > block layer is caring about 2 as a refcount anywhere, what am I missin=
g?
>>
>> It is in the documentation, rendered version available here [1]. Let me
>> know if it is still unclear, then I guess we need to update the docs.
>>
>> Also, my session from Recipes has a little bit of discussion regarding
>> this refcount and it's use [2].
>>
>> Best regards,
>> Andreas
>>
>>
>> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#imp=
lementation-details
>> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>
> So it sounds like there is one refcount from the C side, and some
> number of references from the Rust side.

C side uses a different refcount field. That refcount never read by
Rust, but it is guaranteed to be greater or equal to one while the
driver owns the request.

Rust uses a different refcount field to keep track of how many Rust
references there is to a request. There is an implicit count while the
driver owns the request. This count is not materialized as an `ARef`
instance.

> The function checks whether there's only one Rust reference left, and
> if so, takes ownership of the value, correct?

It checks if the `ARef` passed to the function is the last one in
existence. If it is, it takes ownership of the `Request` object.

> In that case, the CAS should have an acquire ordering to synchronize
> with dropping the refcount 3->2 on another thread. Otherwise, you
> might have a data race with the operations that happened just before
> the 3->2 refcount drop.

I am not sure. I don't think that the thread that does the CAS 2 -> 0
has any data dependencies to any thread that does the atomic decrement 3
-> 2. Any data dependencies between operations on the underlying C
`struct request` would be synchronized by operations on the `ref` field
of `struct request`, which is entirely managed block layer C code and
the C functions called by the Rust abstractions.


BR Andreas


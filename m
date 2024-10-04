Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166E1DBB24;
	Fri,  4 Oct 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069755; cv=none; b=FY0Gedy0J6/oCpjVjN5nAnHPZEWvMgY58H8m6CGZgK3QJ8xbQBpavUPGfCfAw5nSkfF3cRZ/hKv9HQoNRD16s39r6nFFicld+7XWBOQT/6UohF+Aw3+50utGChcjXhXJUwLfoC/YrO8mjw4uLQd0d2YXUTCYJwidbchgIgtVM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069755; c=relaxed/simple;
	bh=6slShbL4MlgHiIezr8TX3tBdk8WYBf3htlE1LQbLCPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtcvCtiCRHaBLX56jDYWtUTKnCoIp8VdYcWq6I4KC/M5LiPiZ4W/fNASDzrg2ZXZzjFx72yyKaRf8Lx0Euk13uOhwhG2jG6gmxqt9jHjM58TJG5mNmquqqsO2VJcggvP+Q3FbKqMbbfxbGe398r+le0o/XqH7LOqjVUYKfD7PPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSaSprE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSaSprE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC117C4CEC6;
	Fri,  4 Oct 2024 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069754;
	bh=6slShbL4MlgHiIezr8TX3tBdk8WYBf3htlE1LQbLCPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kSaSprE1rFwZ0xXZGNIzp/5abPPE1CbdjPi8N95IY2FHLeg2ajsOEF2jMfmzkJMUw
	 QlPC7CIzVUD+6qOcuDQe9y5mCTcgAywKmMrUNpYk0rRuUNjNcGskGRxv8yxI1S4ZxM
	 q65EKsGKvPJPNyMy3yFcjc61tpUlhFLYhBmK17bYnEDbIjOw+Ys0t1As1Ib1vRLE2y
	 O9xtvMQNI9OidMbTdXvbNIrCxyWmO5XRKyRobsyT1iCxOUWUsQrH8r7Ic+Oe/6mxHC
	 ACxWNrKWPdHLpGawswF3PQ+iT3e/Y7TnBiy7lxilfCp/rZOoxuKeSxjeGJiHka2YVk
	 2zLEdULje7LEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Jens Axboe" <axboe@kernel.dk>,  "Will Deacon" <will@kernel.org>,  "Peter
 Zijlstra" <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <20241004194330.651c1db8.gary@garyguo.net> (Gary Guo's message of
	"Fri, 04 Oct 2024 19:43:30 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net> <87h69rpvja.fsf@kernel.org>
	<7qQNVF4awh6SbIu5i7dqpxu-AoXKnhXX8K7VL3khHvYvSapkpSFkI4DcbNjIw5FVyJ_Ux3T9UJXFkHQr1zNfgQ==@protonmail.internalid>
	<20241004194330.651c1db8.gary@garyguo.net>
Date: Fri, 04 Oct 2024 21:18:22 +0200
Message-ID: <878qv3pthd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Fri, 04 Oct 2024 20:34:01 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> Hi Gary,
>>
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>> [...]
>>
>> >  // SAFETY: All instances of `Request<T>` are reference counted. This
>> >  // implementation of `AlwaysRefCounted` ensure that increments to the ref count
>> >  // keeps the object alive in memory at least until a matching reference count
>> >  // decrement is executed.
>> >  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>> >      fn inc_ref(&self) {
>> > -        let refcount = &self.wrapper_ref().refcount();
>> > -
>> > -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
>> > -        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
>> > -
>> > -        #[cfg(CONFIG_DEBUG_MISC)]
>> > -        if !updated {
>> > -            panic!("Request refcount zero on clone")
>> > -        }
>> > +        self.wrapper_ref().refcount().inc();
>>
>> What happened to the debug code?
>>
>>
>> BR Andreas
>>
>
> `refcount_inc` will WARN and saturate the refcount when trying to
> increment from zero. This is true regardless of config.
>
> I've already captured this in `Refcount::inc` documentation.

I did not know. Thanks!

BR Andreas


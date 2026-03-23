Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD162DE6F1;
	Mon, 23 Mar 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267702; cv=none; b=lYkCb7x9od7qjjSSQanR9LBFtnyXVAPpNc1yEKz5tCbGEbEkIZEECwV/SzScUPWClvTFwJoZdaov2bEl5pW8EgWJWb8Nge8XeY8e0rrnomuCwaFVR8BvDl6XRXXfuoD+84owlu2dfDBo+nmKUux8MREBaWZZxWGiFswL88CAkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267702; c=relaxed/simple;
	bh=Q7c7YRUKbJB7h3AZniygI8hUU3h+dXr9eLDt713Z4Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tcdxt67qcNi3+fLsX6uBpwmeG6KyX1hU/SR5Hqzwk6PdzRSceSIX4DaZU0EHtZ4HzWkzVAYn8/MtJN+5tBsUyaolfAjpogssZ5RDbbBU7R36+lDTGuPEuut9He55kVPWo82Sf6eN53lMAIanzIOl5570NkEf78ITOc+kCes5rnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMpoQMqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMpoQMqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AF2C4CEF7;
	Mon, 23 Mar 2026 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267702;
	bh=Q7c7YRUKbJB7h3AZniygI8hUU3h+dXr9eLDt713Z4Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UMpoQMqHQpm7Lt6rdcCSDM3Qt7iufMTBL2PLg2t836OcL31jTd38g1/hWUUmkQr6C
	 BXGgrMe84kl19LRKekTspkCCzyVgqCBTXdNAG7z/fogi1teOof5l0z14e6+yTpiPtv
	 aJ/GDzQDltsqPhYId2yr2ZpjNXTd3rHNA1pRqT2A8xlgC21eTp8j4OW61MHhDm8Glw
	 vZnyAD05Zg+LyRazFM6/PNhZXiVPtU/g0STcRZPeUgWat/pC1Q/4PLcZ0koEiQ7OYS
	 otN3wGnrTLkFcWz1fRNmHcO7pJw/KugCRF8623wWzWfoZ4RHsCfC9ghBv/ZMSvV11w
	 L1Bou7d4+8l5Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/79] block: rust: change `queue_rq` request type to
 `Owned`
In-Reply-To: <abfU_itQLa4jDy5L@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-5-de9a7af4b469@kernel.org>
 <abfU_itQLa4jDy5L@google.com>
Date: Mon, 23 Mar 2026 13:08:08 +0100
Message-ID: <87ikamrbo7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:34:52AM +0100, Andreas Hindborg wrote:
>> Simplify the reference counting scheme for `Request` from 4 states to 3
>> states. This is achieved by coalescing the zero state between block layer
>> owned and uniquely owned by driver.
>> 
>> Implement `Ownable` for `Request` and deliver `Request` to drivers as
>> `Owned<Request>`. In this process:
>> 
>>  - Move uniqueness assertions out of `rnull` as these are now guaranteed by
>>    the `Owned` type.
>>  - Move `start_unchecked`, `try_set_end` and `end_ok` from `Request` to
>>    `Owned<Request>`, relying on type invariant for uniqueness.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> It would be a lot cleaner if we could implement HrTimerPointer for
> Owned<Request> and entirely get rid of the refcount in request so we
> don't need ARef<Request> at all.
>
> Is there a reason we *need* ARef here?

There is. Real drivers will need to dma map the data buffers in
 `Request` to a device. This requires taking a reference on the pages to
 be mapped, which in turn requires taking a reference on the `Request`.

We could split up the reference counts into multiple fields, but that
would be less efficient.


Best regards,
Andreas Hindborg



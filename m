Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7A15B99D;
	Sat,  5 Oct 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154100; cv=none; b=MZVo0w/WZxeUTA2bbHPzzV0Di80He0kq+hUdlkdMUh1+rLoPw9PhFnqvFVcHi+E9vzaVBmNYL+xK5nN/oVo3GjSyaDMaaN47wWM4uR4d566eBsBCYEca6cSrYZXltiCeZ9k1QZ3/PoomSyEI/BCHeEKYiKLezpkfDo03eYJuW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154100; c=relaxed/simple;
	bh=yu92kLGRnwmSbkfGWgwhWOrGGZBrIMwgS2H0C7O6jRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9P33Oplv5TJKTFaVzAOJk7RpINRf7xH7vyHeZhfhoHFhV1EFfUShQ7VOZ9T9vFprbX7+2LC0EdM/eTlePRvCWGFXqFkIVVvcEDueVhvpQ2GO2nfgidIrmjrE7pjFpR4twS3ar+H/wqIm8XplEdN+thbVbnq0EqTaWJK4cEM/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNsehQZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNsehQZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1C5C4CEC2;
	Sat,  5 Oct 2024 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728154099;
	bh=yu92kLGRnwmSbkfGWgwhWOrGGZBrIMwgS2H0C7O6jRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jNsehQZWkbSJGH929Puu9Na6k2cNRNl7DOyr8l1WgmgYsN6rxywDEXVsPBQwQ+TBH
	 dTMhjKX0xBjK7wzvRw1OXGvRFgMlgtIAP7E1XvBE0ub2zb4wT+Bsdsp+G5rksKHIds
	 GBs7WdxULGGAR51sZzkD1sI3Fp6s/9uowz1TVy2QD+ylCaqLDUJJEUnYzeQJyI0C7O
	 EzmZPMNJc2Q86NUm7IdhALqhpY79b0PDu/Bh85ORKeLm9NTb4MAxZJo63ypQAxan48
	 idmwAbURVgMBcu2xTfjFBKTVwG+FQAEFrN4cJMfaCpnEVFjxj/NW0IwcLPCGPsLF9x
	 WKCQHPlYOTF/A==
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
In-Reply-To: <20241005160857.537ae04b.gary@garyguo.net> (Gary Guo's message of
	"Sat, 05 Oct 2024 16:08:57 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net> <87ldz3pwui.fsf@kernel.org>
	<z2yEtd3JQLXA3WUzKyDCgJyD3HR-gjiCw_qlKC4mnZNkmjAydqfTtBKHqeNBEWVpXHOs3kYIVK5NytzOOiU9sQ==@protonmail.internalid>
	<20241005160857.537ae04b.gary@garyguo.net>
Date: Sat, 05 Oct 2024 20:47:59 +0200
Message-ID: <87iku6o080.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Fri, 04 Oct 2024 20:05:41 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> Hi Gary,
>>
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>> > Currently there's a custom reference counting in `block::mq`, which uses
>> > `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
>> > architectures. We cannot just change it to use 32-bit atomics, because
>> > doing so will make it vulnerable to refcount overflow. So switch it to
>> > use the kernel refcount `kernel::sync::Refcount` instead.
>> >
>> > There is an operation needed by `block::mq`, atomically decreasing
>> > refcount from 2 to 0, which is not available through refcount.h, so
>> > I exposed `Refcount::as_atomic` which allows accessing the refcount
>> > directly.
>>
>> I would rather wait with this patch until the helper LTO patches land
>> upstream. Or at least let me run the benchmarks to see the effect of not
>> inlining these refcount operations.
>>
>> Best regards,
>> Andreas
>>
>
> The helper LTO patch series still need some time. I'd want to be able to
> test on 32-bit archs in the meantime.

In that case I would rather just conditionally gate the `block` module
and the `rnull` driver on 64 bit arch.

BR Andreas


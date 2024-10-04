Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03491DD89F;
	Fri,  4 Oct 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065172; cv=none; b=Dn9IjJdT88s4jxVHJUDREp+RGLKNo2rssY6wE/QtCzezmiKOVFDl2aLb89eig1ByG9ofTvGO/g+bOzp9SogNv8+TBvjaWIXBY6XqUXRheAPxBj+YOFDFShUeC+Dx5opgIC7jUYN7ChXcpV5snBV/p+FimE3xTlMkUdJQSF0JQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065172; c=relaxed/simple;
	bh=aml15hsNTI2VDMkG4UyHqgiSZO6Gk9K57VCgD7nJmvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bn3vNiu65JE9J2+EcGYkk/NP2n4TndG1ThvtfsLMoc0Hp298uxcj3uzxBEWhntjAuE/g1NOifnTeL8u3ld/FLFiDC3wllJVgxelAHGUw+gEVD7sQG85GC/9JQvRf5IVADQwYNFGRhCWs9Xwab9QiF0aoXxb9qJit3k34y6CK9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXajJuBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXajJuBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E151EC4CECC;
	Fri,  4 Oct 2024 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065171;
	bh=aml15hsNTI2VDMkG4UyHqgiSZO6Gk9K57VCgD7nJmvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KXajJuBuX2PqAcLq9QyLGzQlI8Byyg1i4FfYmRK/M2p2alCVQLijOUU8HjUe87FVF
	 CY4GTCYycFO0hd8yTQPsVr1TIvtUwAMTirkRkcoijCneLg7x8K9oQkouVFdR3zLFdP
	 DHWrbU6SJOS+2VeOUcDffDDVeARUdJWXgMwZZJP2CWx6xX4+U/2lv4k96qxoU8829P
	 V05E5pzyLVgs1uhXuTXyDPVzqSlQPWJp5FPkQrI/8HfJN44qd1UjZ06MgZhlruyfPf
	 0fuhaWIQ6gv7T1kEezI0dKYcWqc0Wh8j3GYNM5iBlf7pCsuVZRNUJP0W8xqyLSFY4v
	 VVN9itcd5W8pQ==
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
In-Reply-To: <20241004155247.2210469-4-gary@garyguo.net> (Gary Guo's message
	of "Fri, 04 Oct 2024 16:52:24 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net>
Date: Fri, 04 Oct 2024 20:05:41 +0200
Message-ID: <87ldz3pwui.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Gary,

"Gary Guo" <gary@garyguo.net> writes:

> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
>
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.

I would rather wait with this patch until the helper LTO patches land
upstream. Or at least let me run the benchmarks to see the effect of not
inlining these refcount operations.

Best regards,
Andreas


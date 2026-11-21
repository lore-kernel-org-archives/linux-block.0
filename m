Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795292113;
	b=TD2DEKmPVqsF+K59YopZvzUf/jd/uRIUsUyLS9s42UGqGphXlBmLZn3RvQTXeYjouPHT
	 UcCfLiphh2DrSGBN5zF5LMC6GQyZviNT3Gwy7lWH7mPtwwJWgtzBUD6o0qoo8Y3Nav6vy
	 FS0JHp6pKZxbwrZylCMOguHvDVRXmUCwy7zKHEBrlOQQ0/EdXJvWugJaTyuXhggceDKRt
	 7+D3TYR18i9q2IuGxiRanKSTBEV92vFm+GOOaednQUexdnf6ETf4HF2xhgT34XomJgfWr
	 0h9cHupEbUE8BupGfbCqupd9zdu30hYHqhBCH2KMn5kn1AOFJF09bMlOw+mu6I2Shiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795292113;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8uhAFZ7h1LFOLqH+boeQkUjvDPoO3zqskMS2pOYyjAE=;
	b=qpmDa+GUQlokFGJwd6ij8pG9Oi3+HdchT2gnXh/EUTRFREGVPY1hNQf0QOqvOibC1a9S
	 eBUobnJDzneOyoaWVrv3/rtSezSjujeXcZEgZrUkfvYHyROwPOR7+23V06dZHupdY84kd
	 EjapDzX4AEgDktnvyKkh6s2RmD4fDQq2YieNSqx7gkSqlKa00/z34xrxePZxpa7yU8tqP
	 A/obpJlY/XTORmQl9B2R+ItihJheboANY9W9NJumr7o13Nv017SSe2wgi9ZqE5GfFFLgm
	 icPNHrU5Uv+4A8062aWKDQBuFTpsn3LAJ1usCNF7OfIjFB6z3LLCDip3p4GjrW0qiPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf2Jw065;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841C606A32A;
	Sat, 21 Nov 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf2Jw065
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F45F1F000C0;
	Sat, 21 Nov 2026 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795292113;
	bh=8uhAFZ7h1LFOLqH+boeQkUjvDPoO3zqskMS2pOYyjAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kf2Jw065rh0xSXxciSE+F3yevvqVWm0K2dpOs18g2p3A4sQxZKI2861u7vGtTzQvW
	 rNgWTJEUMRIPx6h8pLlJoHRHTBz6l9Pe29dGc/z6fSlvGLFlGb3cEU15HOO1HlszTn
	 9vuQ9vB37AEKke2N23V7KNa9k5nei14VSAE6mIX1SB5OGWW+QIoInTkX105DxCi1k6
	 5Zqb9W41o4dymzI2eli5vOEe9/ckWyojqVwF0niN44xWsvbe/y6VfmN/PSBGRPESzK
	 fv94rA6GwpKTCF3kVODAA07IPpdlrIFHT2EXno2ctkd6ZSg8pGvS52IyOt+xFUW1Ad
	 rhLONGXzeVHTA==
Date: Sat, 21 Nov 2026 12:15:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] zram: avoid copying spanning LZ4 objects before
 decompression
Message-ID: <20261121201511.GG1975@quark>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>

Hi Xueyuan,

On Sun, Nov 22, 2026 at 01:09:23AM +0800, Xueyuan Chen wrote:
> I measured the time to swap in 1 GiB of synthetic data on arm64 with
> 4 KiB pages. Each page started with pseudorandom data of one of 16
> lengths, followed by zeros. On this workload, 32.6% of compressed
> reads spanned two pages with LZ4 and 34.4% with LZ4HC.
> 
> The table shows median swap-in times over seven pairs. The last two
> columns summarize the percentage change within each pair.
> 
>   Codec  Workers  Baseline (ms)  Patched (ms)   Median   Range
>   LZ4          1        1403.81       1344.45   -4.21%   -4.64% to -1.61%
>   LZ4          8         222.57        216.36   -2.73%   -4.19% to -1.97%
>   LZ4HC        1        1403.35       1336.99   -4.74%   -5.07% to -2.90%
>   LZ4HC        8         222.10        215.77   -3.16%   -4.39% to -1.27%
> 
> These timings include both skipping the copy and switching decoders.
> 
> I used Codex to help implement this series.
> Do you think the swap-in improvement justifies maintaining a second
> LZ4 decoder?
> 
> Assisted-by: LLM
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

LZ4_decompress_safe_split() isn't actually very well optimized.  While
it avoids the copy of the source data into a contiguous buffer, it
copies every match and literal run with a variable-length memcpy(),
which on most data is a very slow way to implement LZ decompression.

I suspect it looked good on your synthetic benchmark (pseudorandom data
followed by 0's) only because that tended to generate 1 very long
literal run and 1 very long match.  Whereas normal data would have lots
of interleaved literal runs and matches of much shorter lengths where an
external memcpy() call does very poorly; that is why the existing LZ4
decompression code does not do it that way.

To some extent the literal run and match copy performance is fixable
with a better implementation.  However, having to handle two different
source buffers still introduces overhead that cannot go away.

So I feel this approach is probably not worth it.  If you'd like to
continue to explore it, it would need to be tested on different data and
would need to be properly optimized.

- Eric

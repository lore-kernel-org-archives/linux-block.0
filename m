Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312748;
	b=rrGvUlXd4sVsdyNnOztxivDnI053uWbqGL6t8RhFfP2vK1VOYuhtKHO6riiXGDLmBZDV
	 9CUnneQV72gJn0NinizhHFd7ntLIKNgK3D8+tS/BHcPGcF56BdURSS8+OaxDsLgs72LTO
	 MyNmC5oZOdM1hJXIt+ZKBBBocb0wuNvtBP1Z927yWs09vGrSqPIcDKGEzPQHPkhkdBNxW
	 BDyagFZHI65VuT+nbdtKZto7MRzi2eb8KdK2+C08BNb0cGiRnQmG2VmfXtLuF2of84Fob
	 Fr1ePREWvAtcpFVi/LhSDKQYbV9qJDnDUIXITiwZnvDuB1u5yX4VceoCNwYE0+10ucA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=pfjbw67htTtalCIVH+0nx+HlV0pTaeMozQ67+kkKxbQ=;
	b=lTmfAIA++2JP8qbpWZmYk0BVWWsH8JkDkq9ZJjkh4zaA8+pNDownBF0UZzLsxlMa1Frj
	 MgSpHGp9Ong1s8XFktqSEEfE++1zSx9nkTPUsWZ1UchDBIQa95CS7n6hXt7LRoQqloqdq
	 LetNcgh407qOOqNnd7Q4vDrzIQPONg4Z/uq6rd0JxFC/V/gjmBk4sxcp3Bz0orDxGWHm5
	 MM2+jHk4tA5/cl7ML1yaX5cb29f47WfGaCywBAP/XdWRqvXvmSsNi63JVjU7AyfJ6qvMX
	 bAAOFzV5NO54pNCEa31TtFNDFF2tFD9ZwlWPY7DsEnZotYEqYoYB43dM57CmLo5krFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YsDGSKt7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3798606A32A
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 01:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3798606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YsDGSKt7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35159e0092aso102374eec.2
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795312747; x=1795917547; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pfjbw67htTtalCIVH+0nx+HlV0pTaeMozQ67+kkKxbQ=;
        b=YsDGSKt7+wZS/g934zu7cIPv39C6J3sIMD8THQ/X6GYzyVZHvAk1y2W0wBH0D00n8T
         ewz78xhSzTP+Er+WmczIjvvqmlO3KJHM64GG5NnvewARGXS5CFmEUd8rO9zcjlLK1Qnj
         sTsceH5OZ9QsoSQX/OLkuI53zkRAevkt/sMwMu49TejcoZ15/uHCACRg3+rtALTjd/aj
         1nDs7+12762c/7gbCDJAHkozcJNRFrOjt4Kiojd7ayJQMALHwyIHoA3wbNVWRVcg9WIB
         GXJmedAbHSLVhpxu19WLUSDYzdqaeq9Bnwgbmc7nlYEPvl39EJj8zbRvg64u0QTY9Xsh
         7Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795312747; x=1795917547;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfjbw67htTtalCIVH+0nx+HlV0pTaeMozQ67+kkKxbQ=;
        b=Drl1/xgLpdhTi9kmxEr4ma1bY/V13Mghr1YNRm3sUsbzQN9crOnP+LykBWOHtMlVPM
         7Mnf7iIyDtKF2khZDLqL4L70Km4vQGoWgpFgNgrOMrWKSOtsZ/S0IrtXYlnzHw07b4F8
         dWGAQAd60Gd9J+OibW9JyTY6Iz8+QSYMh7RrjVNT7VccoVuM0yDjxi5h221ncLS4X4/j
         YJFOHzBIZzw42fMRXZ3mLUEgCtZ4JstwaPLQvtSKXN8dJb4paPBUa2Dauk+E0hhabk3f
         EySrr1KSKArc6DX5mQ2bazAIvBz0ed710/3ibacTgn3V5SwmXh53O7QhPvfeUcSecklj
         r7mQ==
X-Forwarded-Encrypted: i=1; AL+hErEHCavSHMbsyVn/vCTPgK/r5gXIODzCpnD75EK5bHBgBQH68d8GUS8sqaQzMT520S1XsK+E7RvpPgwTww==@vger.kernel.org
X-Gm-Message-State: APuU4Z+T4loebPmDEqDoP3Py29L5WR0y9sPMglUO9Lb4ytGeyXfMx/Z9
	zHoAXe+zZ76lMSqC9efGTx7XnWcKotlsyDgbk1Mmy2ohQQL+XBVszmuB
X-Gm-Gg: AZFdTZcrPmrhYoWI3YxOGlwO+UyikBF6vJsZk4RBlRA7ASZb2FD+fK3GoCJqDxEwkg8
	wzZ593tiLzDJT1JLsp5A5LzZxgQDXEL/snqzqVH8sHcyaSLDWWBb07V/9AsSnOl06CHouz5o9pg
	2yRL2s+Hz8x8EMtd42JJDTFWIy/5DaaNA8gs3lo52kknFmo9+SX1Z/2kbKeR38u378mdcnY67MK
	BtOr8vy870CRt3kHpEQswRuWA6s6nHgbGAULLSVCqBpuI4qPHi1PlQTV9xf0Q99wad9VxL997ul
	7zC03LUtd5ZaLkNmke1sq3YPlSjnkB2MP5swvjYiTxMSLkyfywR49AOyoMVwghSo6UPtZK+AtVT
	RELIesKaOnP9CNrEyWpGrqHJInmbmYFBaWOsMO+Xg0zW1cGkxR1Pjn7RwVTysx966tNYDZugGQv
	6XR2fXH5UdxPQabNf9SZeeVTOo2XKWMtCaWssDWdloZyLkIAygJEv5V4rSJuoXBBXi4n8YZubCm
	SJDbqZ7W9XA7a0bFtgMgleQVLY/ECRz+ezVFelfoXmkDTiofvUa/V9sjtCXqzSdARpn04HTIEo/
	tHvcXxS3fKaERJje2VMsZLLKgrB0qWhY6JdZP6d+/etUFD+zLEVxM6f95sDEfMxWt5A=
X-Received: by 2002:a05:7301:2624:b0:385:1a45:47b3 with SMTP id 5a478bee46e88-3856e24682amr12308740eec.1.1795312746575;
        Sat, 21 Nov 2026 17:59:06 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm15055243eec.19.2026.11.21.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 17:59:06 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC 0/3] zram: avoid copying spanning LZ4 objects
 before decompression
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20261121201511.GG1975@quark>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
 <20261121201511.GG1975@quark>
Date: Sun, 22 Nov 2026 09:59:01 +0800
Message-Id: <179531274171.2385422.15680036128312823906.b4-reply@b4>
X-Mailer: b4 0.16.0

On 2026-11-21 12:15 -0800, Eric Biggers wrote:
> Hi Xueyuan,
> 
> On Sun, Nov 22, 2026 at 01:09:23AM +0800, Xueyuan Chen wrote:
> > I measured the time to swap in 1 GiB of synthetic data on arm64 with
> > 4 KiB pages. Each page started with pseudorandom data of one of 16
> > lengths, followed by zeros. On this workload, 32.6% of compressed
> > reads spanned two pages with LZ4 and 34.4% with LZ4HC.
> > 
> > The table shows median swap-in times over seven pairs. The last two
> > columns summarize the percentage change within each pair.
> > 
> >   Codec  Workers  Baseline (ms)  Patched (ms)   Median   Range
> >   LZ4          1        1403.81       1344.45   -4.21%   -4.64% to -1.61%
> >   LZ4          8         222.57        216.36   -2.73%   -4.19% to -1.97%
> >   LZ4HC        1        1403.35       1336.99   -4.74%   -5.07% to -2.90%
> >   LZ4HC        8         222.10        215.77   -3.16%   -4.39% to -1.27%
> > 
> > These timings include both skipping the copy and switching decoders.
> > 
> > I used Codex to help implement this series.
> > Do you think the swap-in improvement justifies maintaining a second
> > LZ4 decoder?
> > 
> > Assisted-by: LLM
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> 
> LZ4_decompress_safe_split() isn't actually very well optimized.  While
> it avoids the copy of the source data into a contiguous buffer, it
> copies every match and literal run with a variable-length memcpy(),
> which on most data is a very slow way to implement LZ decompression.
> 
> I suspect it looked good on your synthetic benchmark (pseudorandom data
> followed by 0's) only because that tended to generate 1 very long
> literal run and 1 very long match.  Whereas normal data would have lots
> of interleaved literal runs and matches of much shorter lengths where an
> external memcpy() call does very poorly; that is why the existing LZ4
> decompression code does not do it that way.
> 
> To some extent the literal run and match copy performance is fixable
> with a better implementation.  However, having to handle two different
> source buffers still introduces overhead that cannot go away.
> 
> So I feel this approach is probably not worth it.  If you'd like to
> continue to explore it, it would need to be tested on different data and
> would need to be properly optimized.
> 
> - Eric
> 
>

Hi Eric,

Thanks for taking a look. I was also unsure how representative the
synthetic workload was, so I was hoping to get some feedback from
experienced kernel developers.

I'll collect 1 GiB of data from zram on an Android phone and rerun the
swap-in benchmark with it.


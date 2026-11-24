Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505589;
	b=WOlOPT1D0GzVHhHFYTVFDiA/+bONADduKuPF+gwpXlAWmNEFyI2xehQ7YqNlMQ9VLWPA
	 ulEkhJcuzU9a9zZWEz4dB1QIOpUq4EZPzKrFQ2HulZXfgzCMb1/qfXt1H9JdV5LFKz46R
	 lWFeQineTXH2yv9cx86X5EJzSkcXoyeQDqkd564yxbyayNLjPIyFGfaoKMfqX7EJJo8hz
	 wBxmPBdlrOAyLOEMpzcViSHxjgeuvkFmM7DEeTQ16Beps9yvilGdj+J+en8LH+tABN2io
	 ckcGFBfu5i05GLwUCWJlqK/vFMNfpUoCyLAPYohkNggHkSXf0DIveQNkUVfi7kuN0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TAMfOuNFtblDQEnaf3fqBx0suItcSS3DJ/gNPv6O2+Q=;
	b=Eqb4auPLrA0sDS/OQfg+NT6UyOfbM26QmejOEOLy35k875b6XX5HJt8uRafvLiLJuP3Z
	 b4BEO1mTR3Otuhfr8AwMzKLyV8jnQrrjeOJZRjwYp8ZIsajXQN4ytAThcD/UvD4C7wouE
	 CUYyzEHtNlkt2GAB7UNACbkN/DNtLfT+qJw1iiSJn2cqSGumqEQ0e4MJQKJDZrxQqJcKp
	 QP/k6FjshJ1inDfaBmcxV0NCt206RANb+aF2pR8grLWUFMDNjkJpbxs2dLtZ5NUUrS8/f
	 jWExeoeTB41sdhX/lE5+X9/OgfLmpGW2riq7N41BbDStsuWXL+LFm0DexitBov4j82g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fpd3dPh+;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04292606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 07:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04292606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fpd3dPh+
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3869f03af6aso3410083eec.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 23:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795505588; x=1796110388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TAMfOuNFtblDQEnaf3fqBx0suItcSS3DJ/gNPv6O2+Q=;
        b=Fpd3dPh+c6x4LvxCk5WLrpb/2qKK43kRNoHM/prHUNmCE6nRIBkvq0qdPwjBEl3+BR
         ZlAMrMXHM8ax7dtGxnoS/bNyXdhcthaNbv2Ws83Toyvhs6dQpKsfSa7gQhCZa4vCvZ/W
         GkkoHGs0YviwI6T6YP7PDAW6pcTQ4O/rNz9Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505588; x=1796110388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TAMfOuNFtblDQEnaf3fqBx0suItcSS3DJ/gNPv6O2+Q=;
        b=g+DzxLWl+ATPVQM7sHxJ3Wdb+GtLd6iOKuHCp11Y7Te0/R4E8jGm3htH0MELN0Pnn5
         8JZbBBCFh78TBmadpIjZQCbZ25AGk3xj6w3crOhAkeFy5HHYQSvd8perTn+Zi9cQ/xeB
         /8giQq/rBP8qBENrpYbQ6OChc5NNkTVFcGPMe0DyEdcJFA/jtM2ua7s/vb6Vgz0dFCEq
         JFVZgoJ2qSLr6HPosr5e7v2we9ysy51tUbVlXLh1bBnuQFjGcLKm2k5YoIsVThkI5+4D
         FZm2LqpIel+n8fwvlnr+ZckxZ/OfJ34ye5i1IQP9SGp33KxZZCrjQEmds560Y7Qh7wkA
         cHig==
X-Forwarded-Encrypted: i=1; AL+hErGYkurIIn7XWfVEkDfD5xA714JYRKr4MotNX+2TJChemVXaTgLIGitCKdi+msfS+M0aAOOkaegL87pU2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/GOXg0QCgyOZtzyfLBu8L5Ln0x6hBKXg4fMJSGzA+6rSvjGA2b
	bzmxL15zXy/IUaTgvMSH0cLmv/xDeNTbyGYSgoDH0sX6U0sjN9/3Dz2TKo7jW0MmYA==
X-Gm-Gg: AZFdTZeBlaInE7rkqTTd9kmMbr04TQuTJD+Dj+Uy/5HKnRgTHn2EGFnw3kSmYo1HRjH
	30/o3BIqhwYJ90PxsFKMciRD05f17CeUYEwwZtGMtxa5yP20ZzNGYxu8ymsRJxx21m3i7bAw/en
	48EOpEJz/HCQMcUtNUZIB9NWpQIxSR5Vx9Mb3Y2ebIDNQC1g0yR+BIZQT1IpZ41oWAxIyhD81pZ
	DqnnSI6mbU/Bo41KBEfjfm+ThORZ74qGrIXgxxjrHVB27R4Qks6sMQddvNJewlpv4JMGbBiznge
	l0VCR5W15dDGOY+dJ3Y4m8gnFatt5WH7QeFOzQJCRw9KV9EDF1imZc25WghuslVi/NZRnD5zdU+
	jKrP1i0aAWkpgGgYSo//EPu66ysguPe4RAFuEdmSf5hOAuq6rpYELigez6aHtksbiXUE6tRYN9R
	D5e16dkRjUDXqmlKxkkQAW1xmB376ipJ1OyA/GHIhMMEnSgxxI2bcn9GOiAZ/vIqJrMF1EyLEyP
	6l44I0bUh8OSoP/bqjTIV9mzVTu2HuYCJmpg1IPJxVBeoj3JrH1joeSPjcPOa2sfLXP9d5wkZPZ
	nkRyZL2Kl7WNITUuKQaL4LX4hQJVAgXJihDMP/O8AbuPvwkkOINZx+4mpE0Njd7+NqtZ38nwlT8
	aWVJeGUt+WMEvL8Y=
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id 5a478bee46e88-384b3986edamr15452668eec.7.1795505587840;
        Mon, 23 Nov 2026 23:33:07 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d159:d585:9ced:38ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm48387343eec.26.2026.11.23.23.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:33:07 -0800 (PST)
Date: Tue, 24 Nov 2026 16:33:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] zram: avoid copying spanning LZ4 objects before
 decompression
Message-ID: <awU9ZqH74dletoXh@google.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
 <20261121201511.GG1975@quark>
 <179550336970.2385422.4070914679921452831.b4-reply@b4>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179550336970.2385422.4070914679921452831.b4-reply@b4>

On (26/11/24 14:56), Xueyuan Chen wrote:
> > LZ4_decompress_safe_split() isn't actually very well optimized.  While
> > it avoids the copy of the source data into a contiguous buffer, it
> > copies every match and literal run with a variable-length memcpy(),
> > which on most data is a very slow way to implement LZ decompression.
> > 
> > I suspect it looked good on your synthetic benchmark (pseudorandom data
> > followed by 0's) only because that tended to generate 1 very long
> > literal run and 1 very long match.  Whereas normal data would have lots
> > of interleaved literal runs and matches of much shorter lengths where an
> > external memcpy() call does very poorly; that is why the existing LZ4
> > decompression code does not do it that way.
> > 
> > To some extent the literal run and match copy performance is fixable
> > with a better implementation.  However, having to handle two different
> > source buffers still introduces overhead that cannot go away.
> > 
> > So I feel this approach is probably not worth it.  If you'd like to
> > continue to explore it, it would need to be tested on different data and
> > would need to be properly optimized.
> > 
> > - Eric
> > 
> Hi Eric,
> 
> I reran the benchmark on arm64 with pages from an Android phone's
> zram export. Optimizing short match copies cut cycles per spanning
> read by 22–27% compared with the RFC decoder.
> 
> I also tried restoring the LZ4 short-sequence fast path within each
> input fragment. That version was still slower than the existing
> copy-and-decompress path in all 28 paired runs. Swap-in took about
> 6.6–6.8% longer with one worker and 3.8% longer with eight workers.
> 
> I'll drop this RFC. Thanks for pointing me toward the short-copy
> overhead and the workload issue.

Oh, I see, thanks for the update.

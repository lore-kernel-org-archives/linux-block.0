Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565851;
	b=EoLqF5h+/TK90K6m6JJxb8ENDZ4NuT5omC9GzYIVyy6pehBkvz9zkIFWRRn8UywbX67z
	 3chHNy6ik1FkUakb2n3DO97yMXV1cIU2dUScTtrp7N7pqqP05AFS43jjIYSORwc8kOqwK
	 Ny1XCPe3ICJdZxt0YQb8j2YqRutSb1d5EYXrkd1grlSBtE5I7x17f8NFsVNtO2AJzqd52
	 JkBwPpJ4QSdxw+X648XMoFseVnfg3hqyT86glnnrK4uiNJd+mfCtB/OZiS1n/y9pnHIqO
	 cyl9x9C/7BvWBrLjL6tYwCElL2bnT7Y1M3FBZVMjGd5bGq9I/LpyQhyckiV5lvbyA/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565851;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer;
	bh=YVyO34/+vwkp8pkrCOkfsJrmVw+ShcRwN5uH3EK9AOQ=;
	b=vwAZpR8VQu7DG81aZSk0ZVmXmKKD5cT3p0DQUBWHH48tsJT3MUna5BfIZdfYnJJ5ocEq
	 3+PAoObwuFgSwcQ5Sv473B+u3qQr6sn5TwB6wBJiL1QiMbK4RSmG3psSr+ZTgJJ/CHGbZ
	 ZDgzZBwsET/jWEQwCsR0zzyjR98KHk8Kmop6Rbj3eHij1yIT3q5xtwz3n31u+tpprX941
	 +0ZJdLzGtn1FIie07LUnCarGqxYcSKac575mWa9kIymquxAFfa+MSTUEhKvXHMHPUK+Xo
	 5r8fw1tf/ZI8tFZruhitWrZ/uFD95FN8g/26U/lkv+/MBhJkqgX7sDFUQcP/9DyePdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtqXe8qJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAE606A31C;
	Fri, 13 Nov 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtqXe8qJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B041F000C4;
	Fri, 13 Nov 2026 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565850;
	bh=YVyO34/+vwkp8pkrCOkfsJrmVw+ShcRwN5uH3EK9AOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LtqXe8qJjoCs6EgAPAbRpq91b52a2VyeQM1Gmbh1aszCIQsHw90zu2II0XhvZBVPf
	 MYe4sCeWsUIT4Qk1u+8y141B9pvooL1UVPFd4jVeuj583/dWSS0d8wIZXTRqeo8Cmr
	 jX0clMTXPzsOgqjpxbfc1oq46h+KocQFM3MQ934rxvl7SR7DdRoDmc6Oxb3/xmKe2C
	 wl8K8UDU/hOCVkeESaZt2xwyECXACM3PlylmDK3o568qfqNsFmFKM3uzFK4Va3DPl2
	 ljQeGJWVYW2W0/PMV9BcmlO9j3pNwLvEEUbnzib0+EcpdDyUPufXUZKKoMr92Uz2ED
	 0eedJIL8aZeJQ==
Date: Fri, 13 Nov 2026 11:30:34 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 1/2] block: add BLK_FEAT_ATOMIC_WRITE_MULTI
Message-ID: <20261113103711.1-da.gomez@kernel.org>
In-Reply-To: <20261103093849.203851-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com> <20261103093849.203851-1-arthur.simchaev@sandisk.com>
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
X-Mailer: lorebird



On 2026-11-03T11:38:49+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:11PM +0200, Daniel Gomez wrote:
> [...]
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index d003a9d2d1f6c..92efd4ff67f26 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_features_t;
> >  #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
> >  	((__force blk_features_t)(1u << 15))
> >  
> > +/* device writes each atomic write boundary window of a command atomically */
> > +#define BLK_FEAT_ATOMIC_WRITE_MULTI	((__force blk_features_t)(1u << 16))
>
> With this flag set, a request with REQ_ATOMIC may now carry several independent
> atomic writes rather than one. Code that looks at REQ_ATOMIC on a request (e.g.
> blk_insert_cloned_request(), or a future SCSI WRITE ATOMIC user) needs to know
> that. Could the comment here (or Documentation/block/) spell out what REQ_ATOMIC
> means on a merged request, and what a driver must guarantee before setting the
> flag?

Makes sense. I'll update accordingly on both places.

>
> It might also be useful to expose the feature in sysfs next to the other
> atomic_write_* attributes, so users can tell whether merging across boundaries
> is active on a device.

TBH, I was initially hesitant with the idea of adding another attribute.
I'll add it and if we find it not useful we can drop it during review
time.



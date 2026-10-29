Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279513;
	b=AvtBY00wSUSvoqhsW5jXBEVblBT3RGvZovapnsk6nyf5Y/+b/QSj0Eotho4IKodUdxDM
	 Ruypne7IWfPS0jyScEyDXYHnMGiUcoGgbbRMU+mEayyEraTII3ZFWwv1xIQV04VlrEoGE
	 L8SSx7EAExs3hLoar+7WAsC7EsuQMVqi5vyiVF4n3PvmAmOEMHBcLRWRontnHXxBwaeCS
	 8kxtc+UojO/uajMeiJBYt1aqE9m0OstEZOudDoKBhG/1fJyKbdG3TV/N9KU4sVW4McPrX
	 hkyncEQgKCFcHrNtJ03vrXjqugFm3ow93M+vkuFRY5fpH72YbJB9EkR3fK/rkYcGZCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279513;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=C83gEU3kLZnbS7pwP/IcqLN17d/qu+B4Lm37Mby/L8U=;
	b=L6f4FCVN4l1xQQAIQX3z8QCzLZAbRLQfcVlF/SD112BWKsWc1MTflIpehdPpWBE4Tc6A
	 CA6Nt1fR25GCI3uu9ajK4RPkqURsJgiRpx54GcHQj7R3/YEcVPTwgcgVwzGb4xJMEuoYG
	 CaFZDv0p8lZVIuEpbYPaIpe2c+9ZWN5Dv3o38l4gPiQIEDojYFtfDU27XGkUeiHYlwT2+
	 +Gh2wDQJ68PUztHkaVSDNQWwri+l2FD/Efw1e3wyZ6CGWr9m0K3B81JVsRL1qSBMQb5/a
	 zR5/O14atcGOSjk6+0Fn9z1K88RvNR28dIRMFsm+SaqRY1UKhE/pa25+Tu1tdSxwwWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nTPp5swU;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AACB606A332
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AACB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nTPp5swU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C83gEU3kLZnbS7pwP/IcqLN17d/qu+B4Lm37Mby/L8U=; b=nTPp5swUSsvoz9Yd4HAURTtRJ9
	VOo3pU7uEKr0gmUIGw209DSk4IWdcwoU/kd4bLA92rPzT8HbM2PWcYzGPs0gFfek0He86g5fY1oqF
	oCTj8t9rcq6HGz4BlqLgCx/jv5XtolP6/II0GCd+d6kMXM3RjRQzufyMxuUatpsWPXy7qXDDAiuRu
	qQU7/yhgiQFxRXKVfivH7yKniEunxl1oGaNuuT9v59yy+GPOv7BMoswD/CxhEe86cm2QRIuaO5Tho
	SpjkskMmGYY1JDVVGEzzc5FBs4ccplNCH27ZR3AEy48Gb1ULa3P0gAthZQIYdm0Paojd/n/7eg4tJ
	zfH5owxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPv6-00000009IWO-2tRm;
	Thu, 29 Oct 2026 13:11:52 +0000
Date: Thu, 29 Oct 2026 06:11:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 42/98] block: partitions/mac: compute the sectors in 64
 bits
Message-ID: <auNGGO5_gBUZD95Q@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-43-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-43-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:45AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> start_block and block_count are converted to 512 byte sectors in 32-bit
> arithmetic, although put_partition() takes a sector_t. With a block size
> above 512 bytes anything beyond 2TiB wraps and the partition lands on
> top of another one.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/partitions/mac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/partitions/mac.c b/block/partitions/mac.c
> index df03ca428e15..f372392af95b 100644
> --- a/block/partitions/mac.c
> +++ b/block/partitions/mac.c
> @@ -97,8 +97,8 @@ int mac_partition(struct parsed_partitions *state)
>  		if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC)
>  			break;
>  		put_partition(state, slot,
> -			be32_to_cpu(part->start_block) * (secsize/512),
> -			be32_to_cpu(part->block_count) * (secsize/512));
> +			(sector_t)be32_to_cpu(part->start_block) * (secsize/512),
> +			(sector_t)be32_to_cpu(part->block_count) * (secsize/512));

PLease just put this into a helper..


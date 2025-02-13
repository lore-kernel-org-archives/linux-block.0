Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC181EF08E
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435602; cv=none; b=fR2gTzUPplVh5gsmtpaucwMWBGB55SYR1eCMdhz3O2Xfx9vBrfXiT8dSYjdt3k+iMhPZHZNW6RKSCErSYGSXS7cmKlWiAPt10gc/8W/c8FjWHR6KIq0ILzwWkhAGyMJn6uqNOyJO754/sMltO54cuB4xiuz0n1GVc8ZQYnd/rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435602; c=relaxed/simple;
	bh=7hsUtQ7UXEQ29Cblb6HE61UNJsQRDWDqR0bvu3MqYQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSskhGk4vz+CS2BwL6wW5VW4nQF8PTP7xFSZTcacbtJPAvu9Atx0uitc5XNTXIInjhMPrEinUHkajkwQpgYGVBJTAvVG/ZAnoORm1Spi6okmLMPl+jE4inzInvAX14WIEaxi5mpBlEpRiS2BoieB1q2vADviltjawA5b1WQ3eqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SYMqiEfv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYMqiEfv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ydE7ajUR4LUUe5rtbV2jqCrV/LjT2GqDmA2ehiLRGWQ=; b=SYMqiEfv9G5k3MZPAyCtUonYEJ
	GSxunFnw9NghSwuAxaZXwLRtHt+cKEmICmzsKd2DKYiKxN6BI1ccGDREjr/FnCOF0Tbg72D5iV6+E
	OHKoZg/ufieJ8z3eo7MeAvZOBDtGaKAf+paoBcGdu+Iz4+OOj9GTXAw9X+/btXs0U/QPhTegmtfkf
	MN71SKVxfc0bE9kdGwHpqTJeIMQRfdaaVB4ySn6/hP5r2MH6YHRIsNq0QeC1EIXH5xzB67IwcoScP
	eBLonJMZDp9MFNDoLLxuhhrx7K8l2Uvr1WJ4TPS+op+MPo52hKn+ZoXz8mHj7xXL3m6jzwdxNO4oN
	DRZxzWwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiUeu-0000000AHy2-2oSk;
	Thu, 13 Feb 2025 08:33:20 +0000
Date: Thu, 13 Feb 2025 00:33:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z62uUDSaVb3Qh0b6@infradead.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210090319.1519778-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 10, 2025 at 05:03:19PM +0800, Ming Lei wrote:
> PAGE_SIZE is applied in some block device queue limits, this way is
> very fragile and is wrong:

Can you rephrase this?  what is "some block device queue limits"?

>  	}
>  
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..cbfa8a3d4e42 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -359,7 +359,7 @@ static inline bool bio_may_need_split(struct bio *bio,
>  		const struct queue_limits *lim)
>  {
>  	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> +		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > BLK_MIN_SEGMENT_SIZE;

please avoid the overly long line here.  And maybe split up the
condition to actually be readable?  I.e.

	if (lim->chunk_sectors)
		return true;
	if (bio->bi_vcnt != 1)
		return true;
	if (bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
	    BLK_MIN_SEGMENT_SIZE)
		return true;
	return false;

> +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */

That's a very sparse and cryptic comment.  Please write down an
actual explanation.


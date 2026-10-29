Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278283;
	b=hBx4bmqQ1v5qb/QPcU8LTkTaXzihOJB9ZUDLqB99ItESQ1DNFwtqbsuodUHxbQClSq6q
	 4cin/wtZCxo5oLZBAO0unYDC+qDVZbgTf8OWpszKTAkf1dTAxFoQvDaduJh42CDnX97M5
	 XBPz3U2wgkw/nWrbsX/+ltZzzAPKALffKIbd15mSlm2weiOLfcqHXzf+ThJycXzWZJj9w
	 39oCmW6lEfs5VJzjR0j6WgAE/96+XS+RWnHJK+w9QwrcokYMipIo5W+TNb7TPiN4IzR1v
	 PA83PYk5iZ7M9BH+wvJpMj1QKEI+UJuxWxEw131gmxK1vK07oKSb3xNXnMRSv4odImA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278283;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=RoIvldB2CmlMkwf+xjAcoDO3oYA9WZL6LaRxTy+jca8=;
	b=4UG5vOumubJTWKkWgH+v0WxrguOtJIZ1pRGJaOACvyWlDFlKvbtaY2+9jCctbzmwmtqP
	 jN2xHNCCQjJpGyfuaQOsIBJvPDHk6+90d7Gcl/g0f+ZwJ4L5Q/PHN9sNrUUIWseZC7dK0
	 bZvyz8T7hJVPvlh8JO30lwQwqqnRxReVrA6YWmIxdeA3blKRuymgsufz7hweg+nA+bTff
	 mEo6ZWWalG4maogd9d9oZlZWPuqcKHXfs7nuM2xXELRw9DklVlu+rFmnC8kpgLCY2Zf+I
	 +5B4zBj7QtS7zjEU/2iZSNGiX4+UWIqaV/y+ifeWYBgo/J4X/czBmSSn56w9iBUJITQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HKmiTtam;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0D606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E0D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HKmiTtam
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RoIvldB2CmlMkwf+xjAcoDO3oYA9WZL6LaRxTy+jca8=; b=HKmiTtamCrcuQRs5pnJLc7NbMz
	s+oE59P/aP4YeqZBbDVpylDDxDiq749a0bhJ3HP7QFkObovOjwkIh8KO8sdQTg08lhXRCpsdf/YiQ
	83EYV4iIL98WxPGiHTwlPCFuJ/J844keGyiQ/9UJVexj6WxUuFy+4zyOzGqWyNYeYRU+B0qcqoIQg
	WI076gQv1Y1X3Sw0yxgSEcWPWRl9sdjksOgnh7Jbz6b50cknE8SAYkUAOA7US0J35ji7f6yq1zmmi
	u+wDQRDm5EHYM35ga/FLG9DtT4K1Q4Za1M8I++jqfLdB2oqU08qExwJQgSkQkI0QWLugXcv7ybI9V
	PnewIKbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPbG-00000009FD7-2zJX;
	Thu, 29 Oct 2026 12:51:22 +0000
Date: Thu, 29 Oct 2026 05:51:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 09/98] blk-mq: end the request if getting a keyslot fails
Message-ID: <auNBSoa3vscdnr9_@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-10-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-10-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Adding Eric for the blk-crypto code.

On Wed, Oct 28, 2026 at 10:41:12AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
> by hand and frees the request. By then blk_mq_bio_to_request() has done
> the IO accounting, which blk_mq_free_request() doesn't undo, so the
> in_flight counter never drops and iostat shows a device that is 100%
> busy. If the bio went through zone write plugging the zone stays plugged
> as well, and every later write to it waits forever.
> 
> Use blk_mq_end_request() like the dispatch path does for a request the
> driver rejected, after marking it for zone write plugging.
> 
> Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7400f678258e..c91306f8156f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3195,8 +3195,9 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  	ret = blk_crypto_rq_get_keyslot(rq);
>  	if (ret != BLK_STS_OK) {
> -		bio_endio_status(bio, ret);
> -		blk_mq_free_request(rq);
> +		if (bio_zone_write_plugging(bio))
> +			blk_zone_write_plug_init_request(rq);
> +		blk_mq_end_request(rq, ret);

If blk_mq_end_request does the right thing (it looks like that to
me, but I'd rather rely on Eric and Jens for that), we should
reorder the blk_crypto_rq_get_keyslot and
blk_zone_write_plug_init_request calls so that the extra copy
of the blk_zone_write_plug_init_request call is not needed.


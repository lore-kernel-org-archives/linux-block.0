Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279472;
	b=HYozIFDpRKXUlv4svvBxDl/diq9Bvoq1/qhKTcj4RJkclxVmB0Y402cGamopExbrpbW5
	 QFuUgrEVviRutQleHF/2v6eEmjxof1sS7trpis+mwyW7fIvX4Jo/mKw9vvgCOwV0saG0h
	 E5ukz9cS8jLOPh088p6QRhpD7mhEllsJmTX9Lm4Oy7OZeOhWtHrWRc9LzZXkQp+sqPRMF
	 BMZJhnuxOrmAXob55d9B3488gcKuJkRBLnuYFeFAWxf/6e0zO1/iv700cbn5Xn1Hvl3bp
	 ogEFAPREj9vnwea89aumusHpbvsFKjNM6YHi/6a84I2G3ItuqfrKBql2KSUaXXaCm4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279472;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=v6ZXBTo/ISjfzE9wS/OAY12IKSvuSsxdMen/7ggLK5U=;
	b=hKpWtBFp+bJ2mRp5XJdQPRvaf9kzpigO9xQQIIpkCm6hxPcWSeOj77NUkMja5G00aNNl
	 r8UJenQ+/toSZSlYSsBv8c799mKZcl5Pvu1X5ctTLFo4XwaQa74f1+iDhm4XYVQG8bZr1
	 MUxQ97lGpJ3ZG5ENzjLJtzK5J/Q1+QGXRnIosoeUmqq7k8xMXlpiRH1WaplyDdLLHrR9U
	 J2KFvaipBvWWSFL1czeTL8uSQQ6cvVqwenY6uervtj1TAhyQudas9NJMEUkXpFSANUH/T
	 ub5OCxI8i1u3YwVsLHN2d+XM38wBP2rcgpo5V94sG0RiQsDun48n6wdAMv5WlNAbVqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="VL/DQieV";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB6606A31D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCDB6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VL/DQieV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v6ZXBTo/ISjfzE9wS/OAY12IKSvuSsxdMen/7ggLK5U=; b=VL/DQieV7yjWWNqvfKUdFBLOdO
	1Pog1QbXNtc8sjGB4vBxlKFcNrinVlwIElFmBAgQ4ezeUSLQOyYvZnjAh7Rm2HRXZgn5SRPeMyfQz
	GToaGmC5qrMOpkM88+DMYVCDRWNOHmxrD22+d9TFGk+NjSba8bR61fyMT5/Sp57DbEzotNeFwAyhC
	dtz9b7DPxSJXdzPQRcskw3yG6J9kuzWH2g/m+9Lrt16yKaxJUgJhmgFylslELbO7DWlflXUMbTGtQ
	GVlAdarHR8KFcHwQ9LUpgiNFPfJJzUVrRrFwvae2JnxKQe6hFTAx5xiSxTcZ55rQsTXf4NfQd/UN6
	p2swlN5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPuR-00000009I3Q-0pHm;
	Thu, 29 Oct 2026 13:11:11 +0000
Date: Thu, 29 Oct 2026 06:11:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 38/98] blk-mq: set up a queue under tag_list_lock
Message-ID: <auNF73ueU40KTazf@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-39-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-39-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:41AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> blk_mq_init_allocated_queue() only takes tag_list_lock at the end, when
> it adds the queue to the set. Before that it sizes the queue by
> set->nr_hw_queues, hands out set->tags[], maps by set->map[], and
> blk_mq_map_swqueue() frees tags of the set. An update clearing the maps
> at that time makes the new queue free tags that all the other queues
> share. An NVMe controller reset during a namespace scan does exactly
> that.
> 
> Take the lock before the first look at the set. An update can be part of
> error handling, so the allocations under the lock must not wait for IO:
> memalloc_noio_save(), as in add_disk_fwnode().
> 
> Fixes: 868f2f0b7206 ("blk-mq: dynamic h/w context count")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 37c8f68e23c4..458ef0970527 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4355,7 +4355,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  {
>  	unsigned int i;
>  
> -	mutex_lock(&set->tag_list_lock);
> +	lockdep_assert_held(&set->tag_list_lock);
>  
>  	/*
>  	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> @@ -4380,8 +4380,6 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  			blk_mq_quiesce_queue_nowait(q);
>  	}
>  	spin_unlock(&set->quiesce_lock);
> -
> -	mutex_unlock(&set->tag_list_lock);
>  }
>  
>  /* All allocations will be freed in release handler of q->mq_kobj */
> @@ -4658,6 +4656,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  		struct request_queue *q)
>  {
> +	unsigned int memflags;
> +
>  	/* mark the queue as mq asap */
>  	q->mq_ops = set->ops;
>  
> @@ -4676,6 +4676,16 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	INIT_LIST_HEAD(&q->unused_hctx_list);
>  	spin_lock_init(&q->unused_hctx_lock);
>  
> +	/*
> +	 * Keep blk_mq_update_nr_hw_queues() away until the queue is on
> +	 * set->tag_list: it changes the number of hardware queues, the tags and
> +	 * the maps, and blk_mq_map_swqueue() allocates and frees tags of the set.

Overly long line inside an otherwise nicely formatted block comment :(

Otherwise similarly a slight worry about lock chains, otherwise this
looks fine.


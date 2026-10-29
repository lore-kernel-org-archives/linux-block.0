Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279404;
	b=omPV7CrnpvM+zpQwIhWXuptaVkEi4bABXKI8nsUXgW1ERGAIujFZExRZ6N6piMFbE8ZW
	 gbkKkai/ZHJ2bDtwA08PKM2t+pBWD5C/2f7/WNDcv8svgeFzRHJZQKXUYIS/+51k6dz4V
	 MhFKq+NqBFKv7MZayA+lF7SnjhojRAXmk7aNTCSKm/MPpK4PKNOj2Gtjl5faQHvFt50TM
	 g/GmfKV2dRLPdwjgHXQn9csXBJEeit5Ko2oFWqgnsfUIPo2bMWyrhZqfS9Ac1PB61hELi
	 a2fXqg9roCDsD6KE+/lkGtyxEZgJkhrlbNT8uCzMPjgg1YiPJmOCtZmsq7PIijTD8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279404;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=KOdgnK8xZFM5IsOKZUAH8B+/467biiMEbMPJwGwT4Uw=;
	b=Zhh2eqo2UHTYZ4ot9vFac4sPMm5m6WtAzXFMNWx9cqdfN9dVaSKsADtg0E1vm04W5dbf
	 Tsn2fxMTAg7zQjnG0SdMF7R5p2No2X2x5G9eNG6QYzBG/TJYTL08Bg1MEXY7DqdUOYQht
	 QfvlCrXfpORuB+CO6/fgw0RzLP9nehARoBuxmzL9RzOpyqn/tSXVnYyHIy4x3PSKCn/nS
	 FEbmSv4GZQmH4P73M4OkdFywAOvciH7WJuM7AcCH4OiDK4LJOzr8/1eoWkRHlxucOTPBI
	 VycJAGf18Wp1oBcuXOLRraxFvdkMRkIH+gwPkqutw5oL4J4aSER7zEt/UlU60iTx9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vOPBHM1c;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90E606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E90E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vOPBHM1c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KOdgnK8xZFM5IsOKZUAH8B+/467biiMEbMPJwGwT4Uw=; b=vOPBHM1cHGVCdywoz7A61M+HYN
	dVVkDFqE0YjOR66oMgUo0TFqqUOKOdylvOl9HYFgnbeHeM1QjxUM7I0lX7+05ZJr7S3o35V38h/0H
	XhIVlaRA6ayLR0sQoAezWRNuLc/j7WHGWYxw6Nwr0/0eZhF8bjNA2dpk+pJO3Q4m7HlRomRdKEVBk
	wY/vGP3B0j0vrFx++5WgtIk87i8++v4MYkeBu3Y9KFXpbWgotQ4UqkZp2fp5Nj9/iIQJl5NbkguDv
	Qn9EebfLLrktQCoYis/4IQlk2CFEQma5fM/SHGTUv0Ohh0Im9EqjzTaI4AziNnfZNbq4solx5ULlo
	8q+J4+0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPtL-00000009HdM-1mrk;
	Thu, 29 Oct 2026 13:10:03 +0000
Date: Thu, 29 Oct 2026 06:10:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 37/98] blk-mq: exit the hctxs of a queue under
 tag_list_lock
Message-ID: <auNFqyGofX79OZVx@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-38-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-38-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:40AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> blk_mq_update_nr_hw_queues() exits and replaces the hctxs of every queue
> on set->tag_list under tag_list_lock. blk_mq_exit_queue() exits its
> hctxs without the lock and only then takes the queue off the list, so an
> update running at the same time exits them again and sets up new ones
> that nobody exits. del_gendisk() is kept away by update_nr_hwq_lock,
> disk_release() of a never added disk and blk_mq_destroy_queue() are not,
> and nvme_alloc_ns() drops such a disk when it finds the queues frozen by
> a reset.
> 
> Hold tag_list_lock for both steps.

I'm a bit worried about cpu hotplug lock interaction as that always
lead to the craziest imaginable lock chains, but otherwise this looks
ok.

> 
> Fixes: 630ef623ed26 ("blk-mq: Swap two calls in blk_mq_exit_queue()")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0e8449424c9a..37c8f68e23c4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4339,7 +4339,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
>  
> -	mutex_lock(&set->tag_list_lock);
> +	lockdep_assert_held(&set->tag_list_lock);
> +
>  	list_del_rcu(&q->tag_set_list);
>  	if (list_is_singular(&set->tag_list)) {
>  		/* just transitioned to unshared */
> @@ -4347,7 +4348,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		/* update existing queue */
>  		blk_mq_update_tag_set_shared(set, false);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> @@ -4711,10 +4711,16 @@ void blk_mq_exit_queue(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
>  
> +	/*
> +	 * As long as the queue is on set->tag_list, its hctxs belong to
> +	 * blk_mq_update_nr_hw_queues() as well, which exits and replaces them.
> +	 */
> +	mutex_lock(&set->tag_list_lock);
>  	/* Checks hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED. */
>  	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
>  	/* May clear BLK_MQ_F_TAG_QUEUE_SHARED in hctx->flags. */
>  	blk_mq_del_queue_tag_set(q);
> +	mutex_unlock(&set->tag_list_lock);
>  }
>  
>  static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> -- 
> 2.56.0
> 
> 
---end quoted text---

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492306;
	b=xel/2uOvTGJ50L9jvAlJJtZdbFsZsEEvu0jzHFp4bnj2ij/ni0lhmRyp2oNz2P9+Knyc
	 56uO/YQfcF30wXcq29lqI56Gc6W+vHybWpdebc0Mz5KK3dDULldX++y6hMMXb3kR74uDD
	 gPaaxdUoGgGtOdI3K/E0uID4JcXofeEQBGvoQtO9PhJoO+BiXKkddIUcyai73TVkJXGT7
	 VOXgCY6bcRxPdFAqstcXHZd69JDzMpLGhF3gc7OW73IxVF3ys42Pm7LBSPdbw8vr1SMTl
	 8Yl6pN9xfacrVjDvI2r3rDV9VOj8grsdeDuVXO0Pt5W2C1E5ZUaETEM73TizWl9QT7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492306;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=gm0yD+b5i2lQ4S3U6RnsGtdY0rSarSOxzGrXaSrcCqU=;
	b=jzYg6pfrWJo+LkY7r8jj+yK61DWLqjwqs8Xuno+SQ+G5VNltEGSN30Pg8MDKIM9hHMKb
	 WK05a1RX/4VmcHFo4eOWIL7jHb/OV1CKat5YGwxLkSarnRZ7Bxtgy7d/AXeQqtOSCZl0I
	 B9pjsHQw+E1SIYLQoyGVTyWTHwAvf7vWFnm2r5/PSHmY/SQB9QVSXAdtESG1ZV3asmOR2
	 rZbTZpUeGiGgXDYRHmK2Ys3QOllVrt5MkeS4vjZar0Jcjpm9ZbU7JW/2UIKgd4id/Oh0A
	 /8kMLkq5zzxBpuYUVnmgA29xIcdwhLsI0ppmrp9Ad6A3v/Z5+gLmmYm0/a3Zp/ELZNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FNIhJ8Yd;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A7606A331;
	Thu, 12 Nov 2026 14:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C5A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FNIhJ8Yd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gm0yD+b5i2lQ4S3U6RnsGtdY0rSarSOxzGrXaSrcCqU=; b=FNIhJ8Yd+rPA68tNaBn1bvsrVL
	QGdSdTOerA0MuiihHZaafACfUyEUOXSFoH0O8uPYxqf334x9R31KQ8mDRgW6G/a3txNzYTisY7znZ
	gLWwHRS3tm0MEr8cmz2vqmX1vvozyn/BHNcgMHeG+u1tE62wb4haUepSUIi2EenfPCpvottzrnBH7
	zfggO6QOAIZUAvuUlLWdFbt6pUT0xoTgc3k+QKomC89L8TGHFLxNdHHHwRc8W9UTGKcQHtmwtg7rB
	PZ0TooGkYOpcW+lHiv4sEgtes+suhizIZiPw2KY9gRdCzOkBs671/nbTCjjXdrmUOhXLhTPP6hp0q
	tZPt8iwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVQF-0000000ABIV-41qr;
	Thu, 12 Nov 2026 14:05:04 +0000
Date: Thu, 12 Nov 2026 06:05:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: return early when the elevator doesn't change
Message-ID: <avXHj1CXuNzXC8Ye@infradead.org>
References: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
 <20261111-bug-block-elevator-unchanged-v1-2-583198bd4e21@linux.dev>
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
In-Reply-To: <20261111-bug-block-elevator-unchanged-v1-2-583198bd4e21@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 11, 2026 at 10:00:59PM -0500, Qiliang Yuan wrote:
> Writing the scheduler a queue already uses to queue/scheduler used to
> be a no-op. elevator_change() now only checks for an unchanged elevator
> after freezing the queue, and doesn't treat "none" on a queue without
> an elevator as unchanged at all, so that case also quiesces the queue
> in elevator_switch() and resets nr_requests.
> 
> Every such write therefore drains in-flight I/O and waits for an RCU
> grace period. udev rules and tuning tools that set the scheduler
> unconditionally stall I/O on live disks each time they run.
> 
> Check under elevator_lock whether anything would change before
> allocating scheduler resources and freezing the queue. Elevator changes
> of a queue are already serialized by QUEUE_FLAG_NO_ELV_SWITCH,
> registration and update_nr_hwq_lock, so drop the check under the freeze.
> 
> Writing the current scheduler to queue/scheduler of a null_blk disk 20
> times takes (median):
> 
>   operation                 before (ms)  after (ms)  change
>   none -> none                     9.06        0.08    -99%
>   mq-deadline -> mq-deadline       9.14        0.08    -99%
> 
> 4k random reads at queue depth 1 for 10 seconds, while "none" is
> written to queue/scheduler every 50 ms:
> 
>   metric             before  after  change
>   IOPS               342609 395915    +16%
>   max latency (us)    10839    978    -91%
> 
> Fixes: b07a889e83355 ("block: move q->sysfs_lock and queue-freeze under show/store method")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>  block/elevator.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 9d9b2e84a1288..979203f518ada 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -654,10 +654,24 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  {
>  	unsigned int memflags;
>  	struct blk_mq_tag_set *set = q->tag_set;
> +	bool unchanged;
>  	int ret = 0;
>  
>  	lockdep_assert_held(&set->update_nr_hwq_lock);
>  
> +	/*
> +	 * Callers serialize elevator changes of this queue, so q->elevator is
> +	 * stable here. Skip freezing the queue if nothing would change.
> +	 */
> +	mutex_lock(&q->elevator_lock);
> +	if (q->elevator)
> +		unchanged = elevator_match(q->elevator->type, ctx->name);
> +	else
> +		unchanged = !strncmp(ctx->name, "none", 4);
> +	mutex_unlock(&q->elevator_lock);
> +	if (unchanged)
> +		return 0;

Strictly speaking this is racy with another thread changing the
elevator.  I don't think we actually care about that, but maybe
add a comment to that effect?

> +
>  	if (strncmp(ctx->name, "none", 4)) {

>  		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res,
>  				set->nr_hw_queues);
> @@ -677,8 +691,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  	 */
>  	blk_mq_cancel_work_sync(q);
>  	mutex_lock(&q->elevator_lock);
> -	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
> -		ret = elevator_switch(q, ctx);
> +	ret = elevator_switch(q, ctx);

However, the raciness means we still need to keep this check I think.


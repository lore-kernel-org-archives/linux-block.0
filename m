Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE971F9F6E;
	Tue, 17 Dec 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471596; cv=none; b=ROyVBVuk025zweZk8TjgoMyYz2il+VIC4THtgOXwA+4trH0lFZqAtY9K3G6GjcT6sI5qQSUzuD3XVelBZ57m05+mkhfN8G2dPOnr6g4clUftbE7lgLxE5R306DtzalAd8Yl8iQEgo+JBbtuSZPYpCGsHn2d2bC3Y0h3LTwOwR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471596; c=relaxed/simple;
	bh=waPL8MSo91BSCASabGJTRyFGziNHSYJPmgybZVAEl5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRW1j5Ckym4rjkt0pUlYEDMUri2wjz7HHq1hg+PzDxxkhTvdNBHwft4FeX03oBJkM4SiYb7P+8Nh5MgXnSzs8Fz8uiY9xK9P8GB2mqEQqzwAWZ2yMclzJppLgljcnpXKt8mQL4Bd9unDuq+SgfSBu15/FpjJmYn2ejWXX1Sru9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vSVfanhk; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vSVfanhk"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YCVZx5Hcsz6ClY9C;
	Tue, 17 Dec 2024 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734471585; x=1737063586; bh=w2NSjeBFnnChdL8x6+UsuaJO
	wEIF50BKYw1sXCgw0Sw=; b=vSVfanhkNJhsLrav09l0gN7u92Idr8Z1C2isEXyg
	AlpYxUIbfKXvS7Nfgck9ao7UuT714+CpLfdrwAizYz2P3ZFl8vX48c45wAgl353Y
	BqvVxCet7YROPOJ1xRyq26cqYEG6Aet8S2iejLt/QSaqPOD+tk7NVYNoPvY1a09o
	Ks/I7AmSWLK2E54xi2KpSbOhNAqVNjrf+lzDCvoq8XozfCRNkI7Ps0M8bB6g9QnZ
	jQmmsNYsz6QuCfH8VApUYnVhpWVLOEeQZep61g8y8xH8IUBjZG4MErEPnPLzZTsy
	fegglZTQkwVkF8B1gKF/f8SQFCMHtwjSvAX+OZxskXcZ5w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id abOatshre1vv; Tue, 17 Dec 2024 21:39:45 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YCVZk2xngz6ClY9B;
	Tue, 17 Dec 2024 21:39:41 +0000 (UTC)
Message-ID: <7e26bf70-3ff3-4cf0-870e-9d0d9c35491b@acm.org>
Date: Tue, 17 Dec 2024 13:39:40 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/4] block/mq-deadline: Revert "block/mq-deadline:
 Fix the tag reservation code"
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217024047.1091893-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 6:40 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This reverts commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8.
> 
> 1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
>     and this will cause performance degradation in some high concurrency
>     test, for both IO bandwidth and cpu usage.
> 
>     async_depth can be changed by sysfs, and the minimal value is 1. This
>     is why min_shallow_depth is set to 1 at initialization to make sure
>     functional is correct if async_depth is set to 1. However, sacrifice
>     performance in the default scenario is not acceptable.
> 
> 2) dd_to_word_depth() is supposed to scale down async_depth, however, user
>     can set low nr_requests and sb->depth can be less than 1 << sb->shift,
>     then dd_to_word_depth() will end up scale up async_depth.

Although this patch fixes a performance regression, it breaks the
async_depth functionality. If we are going to break that functionality
temporarily, I propose to do something like this:

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 20a8a3afb88b..4cc7b5db4669 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -487,37 +487,12 @@ static struct request *dd_dispatch_request(struct 
blk_mq_hw_ctx *hctx)
  	return rq;
  }

-/*
- * 'depth' is a number in the range 1..INT_MAX representing a number of
- * requests. Scale it with a factor (1 << bt->sb.shift) / 
q->nr_requests since
- * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
- * Values larger than q->nr_requests have the same effect as 
q->nr_requests.
- */
-static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int 
qdepth)
-{
-	struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
-	const unsigned int nrr = hctx->queue->nr_requests;
-
-	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
-}
-
  /*
   * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
   * function is used by __blk_mq_get_tag().
   */
  static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
  {
-	struct deadline_data *dd = data->q->elevator->elevator_data;
-
-	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
-		return;
-
-	/*
-	 * Throttle asynchronous requests and writes such that these requests
-	 * do not block the allocation of synchronous requests.
-	 */
-	data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
  }

  /* Called by blk_mq_update_nr_requests(). */
@@ -525,11 +500,8 @@ static void dd_depth_updated(struct blk_mq_hw_ctx 
*hctx)
  {
  	struct request_queue *q = hctx->queue;
  	struct deadline_data *dd = q->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;

  	dd->async_depth = q->nr_requests;
-
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
  }

  /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */


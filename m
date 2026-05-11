Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0C3D301E;
	Mon, 11 May 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515096; cv=none; b=q0mwdX99geQIzt6bJpw4eQN6RKJng67pEpb+KLDeBF5VCihKo2W5TLU/AgpK2FogYnLxn16KPlCiTnZ4kCrTr9E1xXPCXfvqL2q44grC0JglrDUJodEZROwJqTTCKTyCbHfYbowmtPfc8QHTGr/Uzo7vBzK7s/bA0I38BBsa32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515096; c=relaxed/simple;
	bh=IOa2rk96FIJ7USIoXgWoPEPEpqlURjMbbFryJ4vbLH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OKvTX+P+XrUl52Vc+hidVYGkBO4mu3OV9tOzFVPvBHwCaOMqGwhipEaFo16SJxmvaXi9UGTFRf+Jm9Yh5L3O7wabYs2D7MEnEkgetj+rmQkE0Psprg7DcYNvnT8kGnGPD/hvPs+uYTLkuYjVFShxZQssdRXDgtKZM3R7pa5k4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CKtoVvKg; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CKtoVvKg"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDksL6ZNbzlffvb;
	Mon, 11 May 2026 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778515090; x=1781107091; bh=hNaKD1fQ5uJxjCybxNlROYmb
	x5C050NUO18KAErj+vY=; b=CKtoVvKg3wdAdXsbWhnVTMYx7yfUXjWvOazftsR3
	/98UGMBcuDQzBNM48f/WSHlUW5dyhMumQqu7d6PdOuZHMHwukoGfAm5Lf+0wKGEr
	VPHg7d0+QO3yBRoRn4ZtNn992Oew+I/KoFL41edsyrcamNj5Yu1UVA2/id9lO46B
	eEYUTXnw5u3diI+4TiaEhsLyEOtsLxBDF3C4pXCi9srKo+g2dRJFBgCuaPVgzow4
	/CXexbL3mgpoGJ5gTOGfElB3+QWrzqiB6clEagOzRcY0x/zA16GmtIbc7zZjPMpr
	4rc1P7553XnxzGc9tBr1/3UmuTU6+psZxoZZycxmDmu7pA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BuYqrM0zrkxa; Mon, 11 May 2026 15:58:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDksD6N9SzlfpM6;
	Mon, 11 May 2026 15:58:08 +0000 (UTC)
Message-ID: <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
Date: Mon, 11 May 2026 08:58:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 4:43 AM, Tetsuo Handa wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..9be47ce97dab 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -93,6 +93,7 @@ struct loop_cmd {
>   static DEFINE_IDR(loop_index_idr);
>   static DEFINE_MUTEX(loop_ctl_mutex);
>   static DEFINE_MUTEX(loop_validate_mutex);
> +DEFINE_SRCU(loop_io_srcu);
>   
>   /**
>    * loop_global_lock_killable() - take locks for safe loop_validate_file() test
> @@ -1747,8 +1748,19 @@ static void lo_release(struct gendisk *disk)
>   	need_clear = (lo->lo_state == Lo_rundown);
>   	mutex_unlock(&lo->lo_mutex);
>   
> -	if (need_clear)
> +	if (need_clear) {
> +		/*
> +		 * Now that loop_queue_rq() sees lo->lo_state != Lo_bound,
> +		 * wait for already started loop_queue_rq() to complete.
> +		 */
> +		synchronize_srcu(&loop_io_srcu);
> +		/*
> +		 * Now that no more works are scheduled by loop_queue_rq(),
> +		 * wait for already scheduled works to complete.
> +		 */
> +		drain_workqueue(lo->workqueue);
>   		__loop_clr_fd(lo);
> +	}
>   }

There is already a mechanism in the block layer to wait for pending
.queue_rq() calls to complete. Please take a look at
blk_mq_quiesce_queue().

>   static void lo_free_disk(struct gendisk *disk)
> @@ -1854,11 +1866,15 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct request *rq = bd->rq;
>   	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>   	struct loop_device *lo = rq->q->queuedata;
> +	int idx;
>   
>   	blk_mq_start_request(rq);
>   
> -	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
> +	idx = srcu_read_lock(&loop_io_srcu);
> +	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound) {
> +		srcu_read_unlock(&loop_io_srcu, idx);
>   		return BLK_STS_IOERR;
> +	}
>   
>   	switch (req_op(rq)) {
>   	case REQ_OP_FLUSH:
> @@ -1888,6 +1904,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   #endif
>   	loop_queue_work(lo, cmd);
>   
> +	srcu_read_unlock(&loop_io_srcu, idx);
>   	return BLK_STS_OK;
>   }

Why SRCU instead of RCU? The loop driver doesn't set BLK_MQ_F_BLOCKING
and hence must not sleep inside loop_queue_rq(). Additionally, the block
layer already holds an RCU lock around all loop_queue_rq() calls. From
block/blk-mq.h:

/* run the code block in @dispatch_ops with rcu/srcu read lock held */
#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
do {								\
	if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {		\
		struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
		int srcu_idx;					\
								\
		might_sleep_if(check_sleep);			\
		srcu_idx = srcu_read_lock(__tag_set->srcu);	\
		(dispatch_ops);					\
		srcu_read_unlock(__tag_set->srcu, srcu_idx);	\
	} else {						\
		rcu_read_lock();				\
		(dispatch_ops);					\
		rcu_read_unlock();				\
	}							\
} while (0)

Thanks,

Bart.

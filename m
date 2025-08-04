Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F4EC2
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289058; cv=none; b=UnIkBfr4qrvR2SUgnWeQZCTMyOvPSNRQi3+UMhQa3a4zy7xwwJBqHBv+4KhunCKVcUEIshDsjtWaoWMc2RCp+RRTJa02LcE4oS7MlSm/ffZav6n6/TObGn6md2I4RYku/BMebcKPnFATjMonA3x4hEHzRrtrY+UZ7uWDkgt7ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289058; c=relaxed/simple;
	bh=4zlnMiNfH5rJdvPBMJJwXjvmspoaqVbWWS4Qk86KPx4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ttcTJSFMroVe+GAD7TtsZfmfEVztbGuNumH+G0GqrafaHAYmjPFXP63QJnKaoooz1BdEE8U2yhBMRiisQ8hv5NEQkMd99BBQbklagSA/FRo8bqWrntwKhqPPME8GAc8WTJGCRx556H1J9pVszMqOLc9YNxgOZwiPcMxM6pJCsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bwRWw4B9DzYQvFB
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 14:30:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D8051A07BB
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 14:30:51 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhOTU5Bo97IQCg--.1014S3;
	Mon, 04 Aug 2025 14:30:45 +0800 (CST)
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b86b9098-fb76-bdfe-bdf0-1344386d067a@huaweicloud.com>
Date: Mon, 4 Aug 2025 14:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhOTU5Bo97IQCg--.1014S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW7JrW7Gr17Jw43Cw1rZwb_yoW7AF1UpF
	W7GanIkwsYqr10qrsrt39Fkrsa9wsYgF1xGF9aq34Yvr1qkr93JF10yr1UZrW8trZ7Cr4f
	uF4jkrWkAF4kXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> around the tag iterators.
> 
> This is done by:
> 
> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> 
> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> 
> This change improves performance by replacing a spinlock with a more
> scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> shost->host_blocked.
> 
> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> accounting.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 12 ++++++++----
>   block/blk-mq.c     | 24 ++++--------------------
>   2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 6c2f5881e0de..7ae431077a32 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -256,13 +256,10 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>   		unsigned int bitnr)
>   {
>   	struct request *rq;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&tags->lock, flags);
>   	rq = tags->rqs[bitnr];
>   	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>   		rq = NULL;
> -	spin_unlock_irqrestore(&tags->lock, flags);
>   	return rq;
>   }
>
Just wonder, does the lockup problem due to the tags->lock contention by
concurrent scsi_host_busy?

> @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   		busy_tag_iter_fn *fn, void *priv)
>   {
>   	unsigned int flags = tagset->flags;
> -	int i, nr_tags;
> +	int i, nr_tags, srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&tagset->tags_srcu);
>   
>   	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>   
> @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>   					      BT_TAG_ITER_STARTED);
>   	}
> +	srcu_read_unlock(&tagset->tags_srcu, srcu_idx);

And should we add cond_resched() after finish interating one tags, even
with the srcu change, looks like it's still possible to lockup with
big cpu cores & deep queue depth.

Thanks,
Kuai

>   }
>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>   
> @@ -499,6 +499,8 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   		void *priv)
>   {
> +	int srcu_idx;
> +
>   	/*
>   	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
>   	 * while the queue is frozen. So we can use q_usage_counter to avoid
> @@ -507,6 +509,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   	if (!percpu_ref_tryget(&q->q_usage_counter))
>   		return;
>   
> +	srcu_idx = srcu_read_lock(&q->tag_set->tags_srcu);
>   	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>   		struct blk_mq_tags *tags = q->tag_set->shared_tags;
>   		struct sbitmap_queue *bresv = &tags->breserved_tags;
> @@ -536,6 +539,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   			bt_for_each(hctx, q, btags, fn, priv, false);
>   		}
>   	}
> +	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
>   	blk_queue_exit(q);
>   }
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7b4ab8e398b6..43b15e58ffe1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3415,7 +3415,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>   				    struct blk_mq_tags *tags)
>   {
>   	struct page *page;
> -	unsigned long flags;
>   
>   	/*
>   	 * There is no need to clear mapping if driver tags is not initialized
> @@ -3439,15 +3438,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>   			}
>   		}
>   	}
> -
> -	/*
> -	 * Wait until all pending iteration is done.
> -	 *
> -	 * Request reference is cleared and it is guaranteed to be observed
> -	 * after the ->lock is released.
> -	 */
> -	spin_lock_irqsave(&drv_tags->lock, flags);
> -	spin_unlock_irqrestore(&drv_tags->lock, flags);
>   }
>   
>   void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> @@ -3670,8 +3660,12 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>   	struct rq_iter_data data = {
>   		.hctx	= hctx,
>   	};
> +	int srcu_idx;
>   
> +	srcu_idx = srcu_read_lock(&hctx->queue->tag_set->tags_srcu);
>   	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> +	srcu_read_unlock(&hctx->queue->tag_set->tags_srcu, srcu_idx);
> +
>   	return data.has_rq;
>   }
>   
> @@ -3891,7 +3885,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>   		unsigned int queue_depth, struct request *flush_rq)
>   {
>   	int i;
> -	unsigned long flags;
>   
>   	/* The hw queue may not be mapped yet */
>   	if (!tags)
> @@ -3901,15 +3894,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>   
>   	for (i = 0; i < queue_depth; i++)
>   		cmpxchg(&tags->rqs[i], flush_rq, NULL);
> -
> -	/*
> -	 * Wait until all pending iteration is done.
> -	 *
> -	 * Request reference is cleared and it is guaranteed to be observed
> -	 * after the ->lock is released.
> -	 */
> -	spin_lock_irqsave(&tags->lock, flags);
> -	spin_unlock_irqrestore(&tags->lock, flags);
>   }
>   
>   static void blk_free_flush_queue_callback(struct rcu_head *head)
> 


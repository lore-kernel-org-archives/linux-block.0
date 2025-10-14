Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C642BF009
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422226; cv=none; b=puY4OJU+o5saqPOUm2gCvjnhbHaSfeRpCH36GGnv74J+Ml8d085UOnyzQwSp4XtEIJOIPhoO62mgLV1Vv7LsGslqc28f2uv4H+LZpWX90Do166E67EbmgAv7cumdoIJVKwJ3H+Pwl9iZLKWQQjIK+RzFB6/7X3GaCG9qrTSpMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422226; c=relaxed/simple;
	bh=c2q9dsAP8X5flO5aAs7FV2/XAucvJvzPsgOX4SmiuCw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qMR+A22e3pvGIFuiK2CD1gL47fdedOLpLtaG2M2KgCL7DQszub4twlpMFdS4Tu6/+nSd9uA2aQfysCHNq87KaJt1uTQ1OO6RDhSz0lkn0wYN4Fjp6upRS6uysfw57FQznDl8uD/8UkkPh2szwaAvU/HciFue3lGShydqAvEKozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cm3hT2pf4zKHMNL
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 14:09:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 379441A0FA2
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 14:10:05 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUY56e1oXytCAQ--.25869S3;
	Tue, 14 Oct 2025 14:10:02 +0800 (CST)
Subject: Re: [PATCH 2/2] block/mq-deadline: Switch back to a single dispatch
 list
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai@kernel.org>,
 chengkaitao <chengkaitao@kylinos.cn>, "yukuai (C)" <yukuai3@huawei.com>
References: <20251013192803.4168772-1-bvanassche@acm.org>
 <20251013192803.4168772-3-bvanassche@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa88f2ce-7320-b71e-c1b7-e9e6a9b3dcfc@huaweicloud.com>
Date: Tue, 14 Oct 2025 14:10:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251013192803.4168772-3-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3TUY56e1oXytCAQ--.25869S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4xtw43uw1rur1kWF1xXwb_yoW3ZFW7pa
	yru3WYyF4rJFsFga4UGrW3Zr1rXw17u3sFgryfK3yfG3WqvrsrCF1rCFyYvrZxAr9xuFsx
	WF4qgFykXrnIqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/10/14 3:28, Bart Van Assche Ð´µÀ:
> Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> modified the behavior of request flag BLK_MQ_INSERT_AT_HEAD from
> dispatching a request before other requests into dispatching a request
> before other requests with the same I/O priority. This is not correct since
> BLK_MQ_INSERT_AT_HEAD is used when requeuing requests and also when a flush
> request is inserted.  Both types of requests should be dispatched as soon
> as possible. Hence, make the mq-deadline I/O scheduler again ignore the I/O
> priority for BLK_MQ_INSERT_AT_HEAD requests.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai@kernel.org>
> Reported-by: chengkaitao <chengkaitao@kylinos.cn>
> Closes: https://lore.kernel.org/linux-block/20251009155253.14611-1-pilgrimtao@gmail.com/
> Fixes: c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 107 +++++++++++++++++++-------------------------
>   1 file changed, 47 insertions(+), 60 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 647a45f6d935..3e3719093aec 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -71,7 +71,6 @@ struct io_stats_per_prio {
>    * present on both sort_list[] and fifo_list[].
>    */
>   struct dd_per_prio {
> -	struct list_head dispatch;
>   	struct rb_root sort_list[DD_DIR_COUNT];
>   	struct list_head fifo_list[DD_DIR_COUNT];
>   	/* Position of the most recently dispatched request. */
> @@ -84,6 +83,7 @@ struct deadline_data {
>   	 * run time data
>   	 */
>   
> +	struct list_head dispatch;
>   	struct dd_per_prio per_prio[DD_PRIO_COUNT];
>   
>   	/* Data direction of latest dispatched request. */
> @@ -332,16 +332,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   
>   	lockdep_assert_held(&dd->lock);
>   
> -	if (!list_empty(&per_prio->dispatch)) {
> -		rq = list_first_entry(&per_prio->dispatch, struct request,
> -				      queuelist);
> -		if (started_after(dd, rq, latest_start))
> -			return NULL;
> -		list_del_init(&rq->queuelist);
> -		data_dir = rq_data_dir(rq);
> -		goto done;
> -	}
> -
>   	/*
>   	 * batches are currently reads XOR writes
>   	 */
> @@ -421,7 +411,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	 */
>   	dd->batching++;
>   	deadline_move_request(dd, per_prio, rq);
> -done:
>   	return dd_start_request(dd, data_dir, rq);
>   }
>   
> @@ -469,6 +458,14 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	enum dd_prio prio;
>   
>   	spin_lock(&dd->lock);
> +
> +	if (!list_empty(&dd->dispatch)) {
> +		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		dd_start_request(dd, rq_data_dir(rq), rq);
> +		goto unlock;
> +	}
> +
>   	rq = dd_dispatch_prio_aged_requests(dd, now);
>   	if (rq)
>   		goto unlock;
> @@ -557,10 +554,10 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
>   
>   	eq->elevator_data = dd;
>   
> +	INIT_LIST_HEAD(&dd->dispatch);
>   	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
>   		struct dd_per_prio *per_prio = &dd->per_prio[prio];
>   
> -		INIT_LIST_HEAD(&per_prio->dispatch);
>   		INIT_LIST_HEAD(&per_prio->fifo_list[DD_READ]);
>   		INIT_LIST_HEAD(&per_prio->fifo_list[DD_WRITE]);
>   		per_prio->sort_list[DD_READ] = RB_ROOT;
> @@ -664,7 +661,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	trace_block_rq_insert(rq);
>   
>   	if (flags & BLK_MQ_INSERT_AT_HEAD) {
> -		list_add(&rq->queuelist, &per_prio->dispatch);
> +		list_add(&rq->queuelist, &dd->dispatch);
>   		rq->fifo_time = jiffies;
>   	} else {
>   		deadline_add_rq_rb(per_prio, rq);

Do you still want this request to be accounted into per_prio stat? I
feel we should not, otherwise perhaps can you explain more?

Thanks,
Kuai

> @@ -731,8 +728,7 @@ static void dd_finish_request(struct request *rq)
>   
>   static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
>   {
> -	return !list_empty_careful(&per_prio->dispatch) ||
> -		!list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
> +	return !list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
>   		!list_empty_careful(&per_prio->fifo_list[DD_WRITE]);
>   }
>   
> @@ -741,6 +737,9 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>   	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>   	enum dd_prio prio;
>   
> +	if (!list_empty_careful(&dd->dispatch))
> +		return true;
> +
>   	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
>   		if (dd_has_work_for_prio(&dd->per_prio[prio]))
>   			return true;
> @@ -949,49 +948,39 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> -#define DEADLINE_DISPATCH_ATTR(prio)					\
> -static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
> -					     loff_t *pos)		\
> -	__acquires(&dd->lock)						\
> -{									\
> -	struct request_queue *q = m->private;				\
> -	struct deadline_data *dd = q->elevator->elevator_data;		\
> -	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
> -									\
> -	spin_lock(&dd->lock);						\
> -	return seq_list_start(&per_prio->dispatch, *pos);		\
> -}									\
> -									\
> -static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
> -					    void *v, loff_t *pos)	\
> -{									\
> -	struct request_queue *q = m->private;				\
> -	struct deadline_data *dd = q->elevator->elevator_data;		\
> -	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
> -									\
> -	return seq_list_next(v, &per_prio->dispatch, pos);		\
> -}									\
> -									\
> -static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
> -	__releases(&dd->lock)						\
> -{									\
> -	struct request_queue *q = m->private;				\
> -	struct deadline_data *dd = q->elevator->elevator_data;		\
> -									\
> -	spin_unlock(&dd->lock);						\
> -}									\
> -									\
> -static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
> -	.start	= deadline_dispatch##prio##_start,			\
> -	.next	= deadline_dispatch##prio##_next,			\
> -	.stop	= deadline_dispatch##prio##_stop,			\
> -	.show	= blk_mq_debugfs_rq_show,				\
> +static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
> +	__acquires(&dd->lock)
> +{
> +	struct request_queue *q = m->private;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +
> +	spin_lock(&dd->lock);
> +	return seq_list_start(&dd->dispatch, *pos);
>   }
>   
> -DEADLINE_DISPATCH_ATTR(0);
> -DEADLINE_DISPATCH_ATTR(1);
> -DEADLINE_DISPATCH_ATTR(2);
> -#undef DEADLINE_DISPATCH_ATTR
> +static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct request_queue *q = m->private;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +
> +	return seq_list_next(v, &dd->dispatch, pos);
> +}
> +
> +static void deadline_dispatch_stop(struct seq_file *m, void *v)
> +	__releases(&dd->lock)
> +{
> +	struct request_queue *q = m->private;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +
> +	spin_unlock(&dd->lock);
> +}
> +
> +static const struct seq_operations deadline_dispatch_seq_ops = {
> +	.start	= deadline_dispatch_start,
> +	.next	= deadline_dispatch_next,
> +	.stop	= deadline_dispatch_stop,
> +	.show	= blk_mq_debugfs_rq_show,
> +};
>   
>   #define DEADLINE_QUEUE_DDIR_ATTRS(name)					\
>   	{#name "_fifo_list", 0400,					\
> @@ -1014,9 +1003,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
>   	{"batching", 0400, deadline_batching_show},
>   	{"starved", 0400, deadline_starved_show},
>   	{"async_depth", 0400, dd_async_depth_show},
> -	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
> -	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
> -	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
> +	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
>   	{"owned_by_driver", 0400, dd_owned_by_driver_show},
>   	{"queued", 0400, dd_queued_show},
>   	{},
> 
> .
> 


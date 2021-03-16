Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E170C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 06:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE06522F
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 06:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCPGqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:46:33 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48207 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231397AbhCPGqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 02:46:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0US7Dy4A_1615877168;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0US7Dy4A_1615877168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 14:46:08 +0800
Subject: Re: [RFC PATCH 08/11] block: use per-task poll context to implement
 bio based io poll
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210316031523.864506-1-ming.lei@redhat.com>
 <20210316031523.864506-9-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <b4dce8c6-61dd-9524-0a55-41db63eb084d@linux.alibaba.com>
Date:   Tue, 16 Mar 2021 14:46:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316031523.864506-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is a giant progress to gather all split bios that need to be polled
in a per-task queue. Still some comments below.


On 3/16/21 11:15 AM, Ming Lei wrote:
> Currently bio based IO poll needs to poll all hw queue blindly, this way
> is very inefficient, and the big reason is that we can't pass bio
> submission result to io poll task.
> 
> In IO submission context, store associated underlying bios into the
> submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
> and return current->pid to caller of submit_bio() for any DM or bio based
> driver's IO, which is submitted from FS.
> 
> In IO poll context, the passed cookie tells us the PID of submission
> context, and we can find the bio from that submission context. Moving
> bio from submission queue to poll queue of the poll context, and keep
> polling until these bios are ended. Remove bio from poll queue if the
> bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.
> 
> Usually submission shares context with io poll. The per-task poll context
> is just like stack variable, and it is cheap to move data between the two
> per-task queues.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c               |   5 ++
>  block/blk-core.c          |  74 +++++++++++++++++-
>  block/blk-mq.c            | 156 +++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |   3 +
>  4 files changed, 235 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a1c4d2900c7a..bcf5eca0e8e3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
>   **/
>  void bio_endio(struct bio *bio)
>  {
> +	/* BIO_END_BY_POLL has to be set before calling submit_bio */
> +	if (bio_flagged(bio, BIO_END_BY_POLL)) {
> +		bio_set_flag(bio, BIO_DONE);
> +		return;
> +	}
>  again:
>  	if (!bio_remaining_done(bio))
>  		return;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a082bbc856fb..970b23fa2e6e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -854,6 +854,40 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
>  		bio->bi_opf |= REQ_TAG;
>  }
>  
> +static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
> +{
> +	struct blk_bio_poll_data data = {
> +		.bio	=	bio,
> +	};
> +	struct blk_bio_poll_ctx *pc = ioc->data;
> +	unsigned int queued;
> +
> +	/* lock is required if there is more than one writer */
> +	if (unlikely(atomic_read(&ioc->nr_tasks) > 1)) {
> +		spin_lock(&pc->lock);
> +		queued = kfifo_put(&pc->sq, data);
> +		spin_unlock(&pc->lock);
> +	} else {
> +		queued = kfifo_put(&pc->sq, data);
> +	}
> +
> +	/*
> +	 * Now the bio is added per-task fifo, mark it as END_BY_POLL,
> +	 * so we can save cookie into this bio after submit_bio().
> +	 */
> +	if (queued)
> +		bio_set_flag(bio, BIO_END_BY_POLL);
> +	else
> +		bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
> +
> +	return queued;
> +}

The size of kfifo is limited, and it seems that once the sq of kfifio is
full, REQ_HIPRI flag is cleared and the corresponding bio is actually
enqueued into the default hw queue, which is IRQ driven.


> +
> +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> +{
> +	bio->bi_iter.bi_private_data = cookie;
> +}
> +
>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  {
>  	struct block_device *bdev = bio->bi_bdev;
> @@ -1008,7 +1042,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
>   * bio_list_on_stack[1] contains bios that were submitted before the current
>   *	->submit_bio_bio, but that haven't been processed yet.
>   */
> -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> +static blk_qc_t __submit_bio_noacct_int(struct bio *bio, struct io_context *ioc)
>  {
>  	struct bio_list bio_list_on_stack[2];
>  	blk_qc_t ret = BLK_QC_T_NONE;
> @@ -1031,7 +1065,16 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  		bio_list_on_stack[1] = bio_list_on_stack[0];
>  		bio_list_init(&bio_list_on_stack[0]);
>  
> -		ret = __submit_bio(bio);
> +		if (ioc && queue_is_mq(q) &&
> +				(bio->bi_opf & (REQ_HIPRI | REQ_TAG))) {
> +			bool queued = blk_bio_poll_prep_submit(ioc, bio);
> +
> +			ret = __submit_bio(bio);
> +			if (queued)
> +				blk_bio_poll_post_submit(bio, ret);
> +		} else {
> +			ret = __submit_bio(bio);
> +		}
>  
>  		/*
>  		 * Sort new bios into those for a lower level and those for the
> @@ -1057,6 +1100,33 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  	return ret;
>  }
>  
> +static inline blk_qc_t __submit_bio_noacct_poll(struct bio *bio,
> +		struct io_context *ioc)
> +{
> +	struct blk_bio_poll_ctx *pc = ioc->data;
> +	int entries = kfifo_len(&pc->sq);
> +
> +	__submit_bio_noacct_int(bio, ioc);
> +
> +	/* bio submissions queued to per-task poll context */
> +	if (kfifo_len(&pc->sq) > entries)
> +		return current->pid;
> +
> +	/* swapper's pid is 0, but it can't submit poll IO for us */
> +	return 0;
> +}
> +
> +static inline blk_qc_t __submit_bio_noacct(struct bio *bio)
> +{
> +	struct io_context *ioc = current->io_context;
> +
> +	if (ioc && ioc->data && (bio->bi_opf & REQ_HIPRI))
> +		return __submit_bio_noacct_poll(bio, ioc);
> +
> +	return __submit_bio_noacct_int(bio, NULL);
> +}
> +
> +
>  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  {
>  	struct bio_list bio_list[2] = { };
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 03f59915fe2c..4e6f1467d303 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3865,14 +3865,168 @@ static inline int blk_mq_poll_hctx(struct request_queue *q,
>  	return ret;
>  }
>  
> +static blk_qc_t bio_get_poll_cookie(struct bio *bio)
> +{
> +	return bio->bi_iter.bi_private_data;
> +}
> +
> +static int blk_mq_poll_io(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	blk_qc_t cookie = bio_get_poll_cookie(bio);
> +	int ret = 0;
> +
> +	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
> +		struct blk_mq_hw_ctx *hctx =
> +			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> +
> +		ret += blk_mq_poll_hctx(q, hctx);
> +	}
> +	return ret;
> +}
> +
> +static int blk_bio_poll_and_end_io(struct request_queue *q,
> +		struct blk_bio_poll_ctx *poll_ctx)
> +{
> +	struct blk_bio_poll_data *poll_data = &poll_ctx->pq[0];
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < BLK_BIO_POLL_PQ_SZ; i++) {
> +		struct bio *bio = poll_data[i].bio;
> +
> +		if (!bio)
> +			continue;
> +
> +		ret += blk_mq_poll_io(bio);
> +		if (bio_flagged(bio, BIO_DONE)) {
> +			poll_data[i].bio = NULL;
> +
> +			/* clear BIO_END_BY_POLL and end me really */
> +			bio_clear_flag(bio, BIO_END_BY_POLL);
> +			bio_endio(bio);
> +		}
> +	}
> +	return ret;
> +}

When there are multiple threads polling, saying thread A and thread B,
then there's one bio which should be polled by thread A (the pid is
passed to thread A), while it's actually completed by thread B. In this
case, when the bio is completed by thread B, the bio is not really
completed and one extra blk_poll() still needs to be called.



> +
> +static int __blk_bio_poll_io(struct request_queue *q,
> +		struct blk_bio_poll_ctx *submit_ctx,
> +		struct blk_bio_poll_ctx *poll_ctx)
> +{
> +	struct blk_bio_poll_data *poll_data = &poll_ctx->pq[0];
> +	int i;
> +
> +	/*
> +	 * Move IO submission result from submission queue in submission
> +	 * context to poll queue of poll context.
> +	 *
> +	 * There may be more than one readers on poll queue of the same
> +	 * submission context, so have to lock here.
> +	 */
> +	spin_lock(&submit_ctx->lock);
> +	for (i = 0; i < BLK_BIO_POLL_PQ_SZ; i++) {
> +		if (poll_data[i].bio == NULL &&
> +				!kfifo_get(&submit_ctx->sq, &poll_data[i]))
> +			break;
> +	}
> +	spin_unlock(&submit_ctx->lock);
> +
> +	return blk_bio_poll_and_end_io(q, poll_ctx);
> +}
> +
> +static int blk_bio_poll_io(struct request_queue *q,
> +		struct io_context *submit_ioc,
> +		struct io_context *poll_ioc)
> +{
> +	struct blk_bio_poll_ctx *submit_ctx = submit_ioc->data;
> +	struct blk_bio_poll_ctx *poll_ctx = poll_ioc->data;
> +	int ret;
> +
> +	if (unlikely(atomic_read(&poll_ioc->nr_tasks) > 1)) {
> +		mutex_lock(&poll_ctx->pq_lock);
> +		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
> +		mutex_unlock(&poll_ctx->pq_lock);
> +	} else {
> +		ret = __blk_bio_poll_io(q, submit_ctx, poll_ctx);
> +	}
> +	return ret;
> +}
> +
> +static bool blk_bio_ioc_valid(struct task_struct *t)
> +{
> +	if (!t)
> +		return false;
> +
> +	if (!t->io_context)
> +		return false;
> +
> +	if (!t->io_context->data)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int __blk_bio_poll(struct request_queue *q, blk_qc_t cookie)
> +{
> +	struct io_context *poll_ioc = current->io_context;
> +	pid_t pid;
> +	struct task_struct *submit_task;
> +	int ret;
> +
> +	pid = (pid_t)cookie;
> +
> +	/* io poll often share io submission context */
> +	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
> +		return blk_bio_poll_io(q, poll_ioc, poll_ioc);
> +
> +	submit_task = find_get_task_by_vpid(pid);
> +	if (likely(blk_bio_ioc_valid(submit_task)))
> +		ret = blk_bio_poll_io(q, submit_task->io_context,
> +				poll_ioc);
> +	else
> +		ret = 0;
> +
> +	put_task_struct(submit_task);
> +
> +	return ret;
> +}
> +
>  static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  {
> +	long state;
> +
> +	/* no need to poll */
> +	if (cookie == 0)
> +		return 0;
> +
>  	/*
>  	 * Create poll queue for storing poll bio and its cookie from
>  	 * submission queue
>  	 */
>  	blk_create_io_context(q, true);
>  
> +	state = current->state;
> +	do {
> +		int ret;
> +
> +		ret = __blk_bio_poll(q, cookie);
> +		if (ret > 0) {
> +			__set_current_state(TASK_RUNNING);
> +			return ret;
> +		}
> +
> +		if (signal_pending_state(state, current))
> +			__set_current_state(TASK_RUNNING);
> +
> +		if (current->state == TASK_RUNNING)
> +			return 1;
> +		if (ret < 0 || !spin)
> +			break;
> +		cpu_relax();
> +	} while (!need_resched());
> +
> +	__set_current_state(TASK_RUNNING);
>  	return 0;
>  }
>  
> @@ -3893,7 +4047,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	struct blk_mq_hw_ctx *hctx;
>  	long state;
>  
> -	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
> +	if (!blk_queue_poll(q) || (queue_is_mq(q) && !blk_qc_t_valid(cookie)))
>  		return 0;
>  
>  	if (current->plug)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index a1bcade4bcc3..53f64eea9652 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -304,6 +304,9 @@ enum {
>  	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
>  	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
>  	BIO_REMAPPED,
> +	BIO_END_BY_POLL,	/* end by blk_bio_poll() explicitly */
> +	/* set when bio can be ended, used for bio with BIO_END_BY_POLL */
> +	BIO_DONE,
>  	BIO_FLAG_LAST
>  };
>  
> 

-- 
Thanks,
Jeffle

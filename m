Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:49083 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdKHIyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 03:54:16 -0500
Received: by mail-io0-f182.google.com with SMTP id d66so5171625ioe.5
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 00:54:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 09:54:14 +0100
Message-ID: <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Define and use a blk-mq queue. Discards and flushes are processed
> synchronously, but reads and writes asynchronously. In order to support
> slow DMA unmapping, DMA unmapping is not done until after the next request
> is started. That means the request is not completed until then. If there is
> no next request then the completion is done by queued work.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> -       blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
> +       if (req->mq_ctx)
> +               blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
> +       else
> +               blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);

I think this quite obvious code duplication is unfortunate.

What my patches do is get rid of the old block layer in order
to be able to focus on the new stuff using just MQ.

One reason is that the code is hairy already as it is, by just
supporting MQ the above is still just one line of code, the same
goes for the other instances below.

At least you could do what I did and break out a helper like
this:

/*
 * This reports status back to the block layer for a finished request.
 */
static void mmc_blk_complete(struct mmc_queue_req *mq_rq,
                            blk_status_t status)
{
       struct request *req = mmc_queue_req_to_req(mq_rq);

       if (req->mq_ctx) {
          blk_mq_end_request(req, status);
       } else
          blk_end_request_all(req, status);
}

> +/* Single sector read during recovery */
> +static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       blk_status_t status;
> +
> +       while (1) {
> +               mmc_blk_rw_rq_prep(mqrq, mq->card, 1, mq);
> +
> +               mmc_wait_for_req(mq->card->host, &mqrq->brq.mrq);
> +
> +               /*
> +                * Not expecting command errors, so just give up in that case.
> +                * If there are retries remaining, the request will get
> +                * requeued.
> +                */
> +               if (mqrq->brq.cmd.error)
> +                       return;
> +
> +               if (blk_rq_bytes(req) <= 512)
> +                       break;
> +
> +               status = mqrq->brq.data.error ? BLK_STS_IOERR : BLK_STS_OK;
> +
> +               blk_update_request(req, status, 512);
> +       }
> +
> +       mqrq->retries = MMC_NO_RETRIES;
> +}
> +
> +static void mmc_blk_rw_recovery(struct mmc_queue *mq, struct request *req)
> +{
> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_blk_request *brq = &mqrq->brq;
> +       struct mmc_blk_data *md = mq->blkdata;
> +       struct mmc_card *card = mq->card;
> +       static enum mmc_blk_status status;
> +
> +       brq->retune_retry_done = mqrq->retries;
> +
> +       status = __mmc_blk_err_check(card, mqrq);
> +
> +       mmc_retune_release(card->host);
> +
> +       /*
> +        * Requests are completed by mmc_blk_mq_complete_rq() which sets simple
> +        * policy:
> +        * 1. A request that has transferred at least some data is considered
> +        * successful and will be requeued if there is remaining data to
> +        * transfer.
> +        * 2. Otherwise the number of retries is incremented and the request
> +        * will be requeued if there are remaining retries.
> +        * 3. Otherwise the request will be errored out.
> +        * That means mmc_blk_mq_complete_rq() is controlled by bytes_xfered and
> +        * mqrq->retries. So there are only 4 possible actions here:
> +        *      1. do not accept the bytes_xfered value i.e. set it to zero
> +        *      2. change mqrq->retries to determine the number of retries
> +        *      3. try to reset the card
> +        *      4. read one sector at a time
> +        */
> +       switch (status) {
> +       case MMC_BLK_SUCCESS:
> +       case MMC_BLK_PARTIAL:
> +               /* Reset success, and accept bytes_xfered */
> +               mmc_blk_reset_success(md, type);
> +               break;
> +       case MMC_BLK_CMD_ERR:
> +               /*
> +                * For SD cards, get bytes written, but do not accept
> +                * bytes_xfered if that fails. For MMC cards accept
> +                * bytes_xfered. Then try to reset. If reset fails then
> +                * error out the remaining request, otherwise retry
> +                * once (N.B mmc_blk_reset() will not succeed twice in a
> +                * row).
> +                */
> +               if (mmc_card_sd(card)) {
> +                       u32 blocks;
> +                       int err;
> +
> +                       err = mmc_sd_num_wr_blocks(card, &blocks);
> +                       if (err)
> +                               brq->data.bytes_xfered = 0;
> +                       else
> +                               brq->data.bytes_xfered = blocks << 9;
> +               }
> +               if (mmc_blk_reset(md, card->host, type))
> +                       mqrq->retries = MMC_NO_RETRIES;
> +               else
> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
> +               break;
> +       case MMC_BLK_RETRY:
> +               /*
> +                * Do not accept bytes_xfered, but retry up to 5 times,
> +                * otherwise same as abort.
> +                */
> +               brq->data.bytes_xfered = 0;
> +               if (mqrq->retries < MMC_MAX_RETRIES)
> +                       break;
> +               /* Fall through */
> +       case MMC_BLK_ABORT:
> +               /*
> +                * Do not accept bytes_xfered, but try to reset. If
> +                * reset succeeds, try once more, otherwise error out
> +                * the request.
> +                */
> +               brq->data.bytes_xfered = 0;
> +               if (mmc_blk_reset(md, card->host, type))
> +                       mqrq->retries = MMC_NO_RETRIES;
> +               else
> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
> +               break;
> +       case MMC_BLK_DATA_ERR: {
> +               int err;
> +
> +               /*
> +                * Do not accept bytes_xfered, but try to reset. If
> +                * reset succeeds, try once more. If reset fails with
> +                * ENODEV which means the partition is wrong, then error
> +                * out the request. Otherwise attempt to read one sector
> +                * at a time.
> +                */
> +               brq->data.bytes_xfered = 0;
> +               err = mmc_blk_reset(md, card->host, type);
> +               if (!err) {
> +                       mqrq->retries = MMC_MAX_RETRIES - 1;
> +                       break;
> +               }
> +               if (err == -ENODEV) {
> +                       mqrq->retries = MMC_NO_RETRIES;
> +                       break;
> +               }
> +               /* Fall through */
> +       }
> +       case MMC_BLK_ECC_ERR:
> +               /*
> +                * Do not accept bytes_xfered. If reading more than one
> +                * sector, try reading one sector at a time.
> +                */
> +               brq->data.bytes_xfered = 0;
> +               /* FIXME: Missing single sector read for large sector size */
> +               if (brq->data.blocks > 1 && !mmc_large_sector(card)) {
> +                       /* Redo read one sector at a time */
> +                       pr_warn("%s: retrying using single block read\n",
> +                               req->rq_disk->disk_name);
> +                       mmc_blk_ss_read(mq, req);
> +               } else {
> +                       mqrq->retries = MMC_NO_RETRIES;
> +               }
> +               break;
> +       case MMC_BLK_NOMEDIUM:
> +               /* Do not accept bytes_xfered. Error out the request */
> +               brq->data.bytes_xfered = 0;
> +               mqrq->retries = MMC_NO_RETRIES;
> +               break;
> +       default:
> +               /* Do not accept bytes_xfered. Error out the request */
> +               brq->data.bytes_xfered = 0;
> +               mqrq->retries = MMC_NO_RETRIES;
> +               pr_err("%s: Unhandled return value (%d)",
> +                      req->rq_disk->disk_name, status);
> +               break;
> +       }
> +}
> +
> +static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       unsigned int nr_bytes = mqrq->brq.data.bytes_xfered;
> +
> +       if (nr_bytes) {
> +               if (blk_update_request(req, BLK_STS_OK, nr_bytes))
> +                       blk_mq_requeue_request(req, true);
> +               else
> +                       __blk_mq_end_request(req, BLK_STS_OK);
> +       } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> +               blk_mq_requeue_request(req, true);
> +       } else {
> +               if (mmc_card_removed(mq->card))
> +                       req->rq_flags |= RQF_QUIET;
> +               blk_mq_end_request(req, BLK_STS_IOERR);
> +       }
> +}

This retry and error handling using requeue is very elegant.
I really like this.

If we could also go for MQ-only, only this nice code
remains in the tree.

The problem: you have just reimplemented the whole error
handling we had in the old block layer and now we have to
maintain two copies and keep them in sync.

This is not OK IMO, we will inevitable screw it up, so we
need to get *one* error path.

> +static bool mmc_blk_urgent_bkops_needed(struct mmc_queue *mq,
> +                                       struct mmc_queue_req *mqrq)
> +{
> +       return mmc_card_mmc(mq->card) &&
> +              (mqrq->brq.cmd.resp[0] & R1_EXCEPTION_EVENT ||
> +               mqrq->brq.stop.resp[0] & R1_EXCEPTION_EVENT);
> +}
> +
> +static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
> +                                struct mmc_queue_req *mqrq)
> +{
> +       if (mmc_blk_urgent_bkops_needed(mq, mqrq))
> +               mmc_start_bkops(mq->card, true);
> +}
> +
> +void mmc_blk_mq_complete(struct request *req)
> +{
> +       struct mmc_queue *mq = req->q->queuedata;
> +
> +       mmc_blk_mq_complete_rq(mq, req);
> +}

So this is called from the struct blk_mq_ops .complete()
callback. And this calls blk_mq_end_request().

So the semantic order needs to be complete -> end.

I see this pattern in newer MQ code, I got it wrong in
my patch set so I try to fix it up.

> +static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
> +                                      struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +
> +       mmc_blk_rw_recovery(mq, req);
> +
> +       mmc_blk_urgent_bkops(mq, mqrq);
> +}

This looks nice.

> +static void mmc_blk_mq_acct_req_done(struct mmc_queue *mq, struct request *req)

What does "acct" mean in the above function name?
Accounting? Actual? I'm lost.

> +{
> +       struct request_queue *q = req->q;
> +       unsigned long flags;
> +       bool put_card;
> +
> +       spin_lock_irqsave(q->queue_lock, flags);
> +
> +       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +
> +       put_card = mmc_tot_in_flight(mq) == 0;

This in_flight[] business seems a bit kludgy, but I
don't really understand it fully. Magic numbers like
-1 to mark that something is not going on etc, not
super-elegant.

I believe it is necessary for CQE though as you need
to keep track of outstanding requests?

> +
> +       spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +       if (put_card)
> +               mmc_put_card(mq->card, &mq->ctx);

I think you should try not to sprinkle mmc_put_card() inside
the different functions but instead you can put this in the
.complete callback I guess mmc_blk_mq_complete() in your
patch set.

Also you do not need to avoid calling it several times with
that put_card variable. It's fully reentrant thanks to your
own code in the lock and all calls come from the same block
layer process if you call it in .complete() I think?

> +static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_request *mrq = &mqrq->brq.mrq;
> +       struct mmc_host *host = mq->card->host;
> +
> +       if (host->ops->post_req)
> +               host->ops->post_req(host, mrq, 0);
> +
> +       blk_mq_complete_request(req);
> +
> +       mmc_blk_mq_acct_req_done(mq, req);
> +}

Now the problem Ulf has pointed out starts to creep out in the
patch: a lot of code duplication on the MQ path compared to
the ordinary block layer path.

My approach was structured partly to avoid this: first refactor
the old path, then switch to (only) MQ to avoid code duplication.

> +static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
> +                                        struct request **prev_req)
> +{
> +       mutex_lock(&mq->complete_lock);
> +
> +       if (!mq->complete_req)
> +               goto out_unlock;
> +
> +       mmc_blk_mq_poll_completion(mq, mq->complete_req);
> +
> +       if (prev_req)
> +               *prev_req = mq->complete_req;
> +       else
> +               mmc_blk_mq_post_req(mq, mq->complete_req);
> +
> +       mq->complete_req = NULL;
> +
> +out_unlock:
> +       mutex_unlock(&mq->complete_lock);
> +}

This looks a bit like it is reimplementing the kernel
completion abstraction using a mutex and a variable named
.complete_req?

We were using a completion in the old block layer so
why did you not use it for MQ?

> +static void mmc_blk_mq_req_done(struct mmc_request *mrq)
> +{
> +       struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
> +                                                 brq.mrq);
> +       struct request *req = mmc_queue_req_to_req(mqrq);
> +       struct request_queue *q = req->q;
> +       struct mmc_queue *mq = q->queuedata;
> +       unsigned long flags;
> +       bool waiting;
> +
> +       spin_lock_irqsave(q->queue_lock, flags);
> +       mq->complete_req = req;
> +       mq->rw_wait = false;
> +       waiting = mq->waiting;
> +       spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +       if (waiting)
> +               wake_up(&mq->wait);

I would contest using a waitqueue for this. The name even says
"complete_req" so why is a completion not the right thing to
hang on rather than a waitqueue?

The completion already contains a waitqueue, so I think you're
just essentially reimplementing it.

Just complete(&mq->mq_req_complete) or something should do
the trick.

> +       else
> +               kblockd_schedule_work(&mq->complete_work);

I did not use the kblockd workqueue for this, out of fear
that it would interfere and disturb the block layer work items.
My intuitive idea was that the MMC layer needed its own
worker (like in the past it used a thread) in order to avoid
congestion in the block layer queue leading to unnecessary
delays.

On the other hand, this likely avoids a context switch if there
is no congestion on the queue.

I am uncertain when it is advisible to use the block layer
queue for subsystems like MMC/SD.

Would be nice to see some direction from the block layer
folks here, it is indeed exposed to us...

My performance tests show no problems with this approach
though.

> +static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
> +{
> +       struct request_queue *q = mq->queue;
> +       unsigned long flags;
> +       bool done;
> +
> +       spin_lock_irqsave(q->queue_lock, flags);
> +       done = !mq->rw_wait;
> +       mq->waiting = !done;
> +       spin_unlock_irqrestore(q->queue_lock, flags);

This makes it look like a reimplementation of completion_done()
so I think you should use the completion abstraction again. The
struct completion even contains a variable named "done".

> +static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
> +                                 struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_host *host = mq->card->host;
> +       struct request *prev_req = NULL;
> +       int err = 0;
> +
> +       mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
> +
> +       mqrq->brq.mrq.done = mmc_blk_mq_req_done;
> +
> +       if (host->ops->pre_req)
> +               host->ops->pre_req(host, &mqrq->brq.mrq);
> +
> +       err = mmc_blk_rw_wait(mq, &prev_req);
> +       if (err)
> +               goto out_post_req;
> +
> +       mq->rw_wait = true;
> +
> +       err = mmc_start_request(host, &mqrq->brq.mrq);
> +
> +       if (prev_req)
> +               mmc_blk_mq_post_req(mq, prev_req);
> +
> +       if (err)
> +               mq->rw_wait = false;
> +
> +out_post_req:
> +       if (err && host->ops->post_req)
> +               host->ops->post_req(host, &mqrq->brq.mrq, err);
> +
> +       return err;
> +}

This is pretty straight-forward (pending the comments above).
Again it has the downside of duplicating the same code for the
old block layer instead of refactoring.

> +enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_blk_data *md = mq->blkdata;
> +       struct mmc_card *card = md->queue.card;
> +       struct mmc_host *host = card->host;
> +       int ret;
> +
> +       ret = mmc_blk_part_switch(card, md->part_type);
> +       if (ret)
> +               return MMC_REQ_FAILED_TO_START;
> +
> +       switch (mmc_issue_type(mq, req)) {
> +       case MMC_ISSUE_SYNC:
> +               ret = mmc_blk_wait_for_idle(mq, host);
> +               if (ret)
> +                       return MMC_REQ_BUSY;
> +               switch (req_op(req)) {
> +               case REQ_OP_DRV_IN:
> +               case REQ_OP_DRV_OUT:
> +                       mmc_blk_issue_drv_op(mq, req);
> +                       break;
> +               case REQ_OP_DISCARD:
> +                       mmc_blk_issue_discard_rq(mq, req);
> +                       break;
> +               case REQ_OP_SECURE_ERASE:
> +                       mmc_blk_issue_secdiscard_rq(mq, req);
> +                       break;
> +               case REQ_OP_FLUSH:
> +                       mmc_blk_issue_flush(mq, req);
> +                       break;
> +               default:
> +                       WARN_ON_ONCE(1);
> +                       return MMC_REQ_FAILED_TO_START;
> +               }
> +               return MMC_REQ_FINISHED;
> +       case MMC_ISSUE_ASYNC:
> +               switch (req_op(req)) {
> +               case REQ_OP_READ:
> +               case REQ_OP_WRITE:
> +                       ret = mmc_blk_mq_issue_rw_rq(mq, req);
> +                       break;
> +               default:
> +                       WARN_ON_ONCE(1);
> +                       ret = -EINVAL;
> +               }
> +               if (!ret)
> +                       return MMC_REQ_STARTED;
> +               return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
> +       default:
> +               WARN_ON_ONCE(1);
> +               return MMC_REQ_FAILED_TO_START;
> +       }
> +}

Again looks fine, again duplicates code. In this case I don't even
see why the MQ code needs its own copy of the issue funtion.

> +enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
> +{
> +       if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
> +               return MMC_ISSUE_ASYNC;
> +
> +       return MMC_ISSUE_SYNC;
> +}

Distinguishing between SYNC and ASYNC operations and using
that as abstraction is nice.

But you only do this in the new MQ code.

Instead, make this a separate patch and first refactor the old
code to use this distinction between SYNC and ASYNC.

Unfortunately I think Ulf's earlier criticism that you're rewriting
the world instead of refactoring what we have still stands on many
accounts here.

It makes it even harder to understand your persistance in keeping
the old block layer around. If you're introducing new concepts and
cleaner code in the MQ path and kind of discarding the old
block layer path, why keep it around at all?

I would have a much easier time accepting this patch if it
deleted as much as it was adding, i.e. introduce all this new
nice MQ code, but also tossing out the old block layer and error
handling code. Even if it is a massive rewrite, at least there
is just one body of code to maintain going forward.

That said, I would strongly prefer a refactoring of the old block
layer leading up to transitioning to MQ. But I am indeed biased
since I took that approach myself.

> +static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
> +                                                bool reserved)
> +{
> +       return BLK_EH_RESET_TIMER;
> +}

This timeout looks like something I need to pick up in my patch
set as well. It seems good for stability to support this. But what happened
here? Did you experience a bunch of timeouts during development,
or let's say how was this engineered, I guess it is for the case when
something randomly locks up for a long time and we don't really know
what has happened, like a watchdog?

> +static int mmc_init_request(struct request_queue *q, struct request *req,
> +                           gfp_t gfp)
> +{
> +       return __mmc_init_request(q->queuedata, req, gfp);
> +}
> +
(...)
> +static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
> +                              unsigned int hctx_idx, unsigned int numa_node)
> +{
> +       return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
> +}
> +
> +static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
> +                               unsigned int hctx_idx)
> +{
> +       struct mmc_queue *mq = set->driver_data;
> +
> +       mmc_exit_request(mq->queue, req);
> +}

Here is more code duplication just to keep both the old block layer
and MQ around. Including introducing another inner __foo function
which I have something strongly against personally (I might be
crazily picky, because I see many people do this).

> +static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> +                                   const struct blk_mq_queue_data *bd)
> +{
> +       struct request *req = bd->rq;
> +       struct request_queue *q = req->q;
> +       struct mmc_queue *mq = q->queuedata;
> +       struct mmc_card *card = mq->card;
> +       enum mmc_issue_type issue_type;
> +       enum mmc_issued issued;
> +       bool get_card;
> +       int ret;
> +
> +       if (mmc_card_removed(mq->card)) {
> +               req->rq_flags |= RQF_QUIET;
> +               return BLK_STS_IOERR;
> +       }
> +
> +       issue_type = mmc_issue_type(mq, req);
> +
> +       spin_lock_irq(q->queue_lock);
> +
> +       switch (issue_type) {
> +       case MMC_ISSUE_ASYNC:
> +               break;
> +       default:
> +               /*
> +                * Timeouts are handled by mmc core, so set a large value to
> +                * avoid races.
> +                */
> +               req->timeout = 600 * HZ;
> +               break;
> +       }

These timeouts again, does this mean we have competing timeout
code in the block layer and MMC?

This mentions timeouts in the MMC core, but they are actually
coming from the *MMC* core, when below you set:
blk_queue_rq_timeout(mq->queue, 60 * HZ);?

Isn't the actual case that the per-queue timeout is set up to
occur before the per-request timeout, and that you are hacking
around the block layer core having two different timeouts?

It's a bit confusing so I'd really like to know what's going on...

> +       mq->in_flight[issue_type] += 1;
> +       get_card = mmc_tot_in_flight(mq) == 1;

Parenthesis around the logical expression preferred I guess
get_card = (mmc_tot_in_flight(mq) == 1);
(Isn't checkpatch complaining about this?)

Then:
(...)
> +       if (get_card)
> +               mmc_get_card(card, &mq->ctx);

I simply took the card on every request. Since the context is the
same for all block layer business and the lock is now fully
reentrant this if (get_card) is not necessary. Just take it for
every request and release it in the .complete() callback.

> +#define MMC_QUEUE_DEPTH 64
> +
> +static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
> +                        spinlock_t *lock)
> +{
> +       int q_depth;
> +       int ret;
> +
> +       q_depth = MMC_QUEUE_DEPTH;
> +
> +       ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);

Apart from using a define, then assigning the define to a
variable and then passing that variable instead of just
passing the define: why 64? Is that the depth of the CQE
queue? In that case we need an if (cqe) and set it down
to 2 for non-CQE.

> +       if (ret)
> +               return ret;
> +
> +       blk_queue_rq_timeout(mq->queue, 60 * HZ);

And requests timeout after 1 minute I take it.

I suspect both of these have some relation to CQE, so that is where
you find these long execution times etc?

> +static void mmc_mq_queue_suspend(struct mmc_queue *mq)
> +{
> +       blk_mq_quiesce_queue(mq->queue);
> +
> +       /*
> +        * The host remains claimed while there are outstanding requests, so
> +        * simply claiming and releasing here ensures there are none.
> +        */
> +       mmc_claim_host(mq->card->host);
> +       mmc_release_host(mq->card->host);

I think just blk_mq_quiesce_queue() should be fine as and
should make sure all requests have called .complete() and there
I think you should also release the host lock.

If the MQ code is not doing this, we need to fix MQ to
do the right thing (or add a new callback such as
blk_mq_make_sure_queue_empty()) so at the very
least put a big fat FIXME or REVISIT comment on the above.

> +static void mmc_mq_queue_resume(struct mmc_queue *mq)
> +{
> +       blk_mq_unquiesce_queue(mq->queue);
> +}
> +
> +static void __mmc_queue_suspend(struct mmc_queue *mq)
> +{
> +       struct request_queue *q = mq->queue;
> +       unsigned long flags;
> +
> +       if (!mq->suspended) {
> +               mq->suspended |= true;
> +
> +               spin_lock_irqsave(q->queue_lock, flags);
> +               blk_stop_queue(q);
> +               spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +               down(&mq->thread_sem);
> +       }
> +}
> +
> +static void __mmc_queue_resume(struct mmc_queue *mq)
> +{
> +       struct request_queue *q = mq->queue;
> +       unsigned long flags;
> +
> +       if (mq->suspended) {
> +               mq->suspended = false;
> +
> +               up(&mq->thread_sem);
> +
> +               spin_lock_irqsave(q->queue_lock, flags);
> +               blk_start_queue(q);
> +               spin_unlock_irqrestore(q->queue_lock, flags);
> +       }
> +}

One of the good reasons to delete the old block layer is to get
rid of this horrible semaphore construction. So I see it as necessary
to be able to focus development efforts on code that actually has
a future.

> +       if (q->mq_ops)
> +               mmc_mq_queue_suspend(mq);
> +       else
> +               __mmc_queue_suspend(mq);

And then there is the code duplication again.

>         int                     qcnt;
> +
> +       int                     in_flight[MMC_ISSUE_MAX];

So this is a [2] containing a counter for the number of
synchronous and asynchronous requests in flight at any
time.

But are there really synchronous and asynchronous requests
going on at the same time?

Maybe on the error path I guess.

I avoided this completely but I guess it may be necessary with
CQE, such that in_flight[0,1] is way more than 1 or 2 at times
when there are commands queued?

> +       bool                    rw_wait;
> +       bool                    waiting;
> +       wait_queue_head_t       wait;

As mentioned I think this is a reimplementation of
the completion abstraction.

Yours,
Linus Walleij

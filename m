Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35436 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbdHTMNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2017 08:13:04 -0400
Received: by mail-oi0-f47.google.com with SMTP id e124so132748406oig.2
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2017 05:13:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Aug 2017 14:13:03 +0200
Message-ID: <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com>
Subject: Re: [PATCH V5 11/13] mmc: block: Add CQE support
To: Adrian Hunter <adrian.hunter@intel.com>,
        linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add CQE support to the block driver, including:
>         - optionally using DCMD for flush requests
>         - manually issuing discard requests

"Manually" has no place in computer code IMO since there is no
man there. But I may be especially grumpy. But I don't understand the
comment anyway.

>         - issuing read / write requests to the CQE
>         - supporting block-layer timeouts
>         - handling recovery
>         - supporting re-tuning
>
> CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
> (e.g. 2%) drop in sequential read speed but no observable change to sequential
> write.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This commit message seriously needs to detail the design of the
request handling thread/engine.

So adding a new (in effect) invasive block driver needs to at least
be CC:ed to the block maintainers so we don't sneak anything like
that in under the radar.

This duplicates the "thread that sucks out requests" from the
MMC core, and doubles the problem of replacing it with
something like blk-mq.

Especially these two snippets I would personally NOT merge
without the explicit consent of a block layer maintainer:

> +static void mmc_cqe_request_fn(struct request_queue *q)
> +{
> +       struct mmc_queue *mq = q->queuedata;
> +       struct request *req;
> +
> +       if (!mq) {
> +               while ((req = blk_fetch_request(q)) != NULL) {
> +                       req->rq_flags |= RQF_QUIET;
> +                       __blk_end_request_all(req, BLK_STS_IOERR);
> +               }
> +               return;
> +       }
> +
> +       if (mq->asleep && !mq->cqe_busy)
> +               wake_up_process(mq->thread);
> +}
(...)
> +static int mmc_cqe_thread(void *d)
> +{
> +       struct mmc_queue *mq = d;
> +       struct request_queue *q = mq->queue;
> +       struct mmc_card *card = mq->card;
> +       struct mmc_host *host = card->host;
> +       unsigned long flags;
> +       int get_put = 0;
> +
> +       current->flags |= PF_MEMALLOC;
> +
> +       down(&mq->thread_sem);
> +       spin_lock_irqsave(q->queue_lock, flags);
> +       while (1) {
> +               struct request *req = NULL;
> +               enum mmc_issue_type issue_type;
> +               bool retune_ok = false;
> +
> +               if (mq->cqe_recovery_needed) {
> +                       spin_unlock_irqrestore(q->queue_lock, flags);
> +                       mmc_blk_cqe_recovery(mq);
> +                       spin_lock_irqsave(q->queue_lock, flags);
> +                       mq->cqe_recovery_needed = false;
> +               }
> +
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               if (!kthread_should_stop())
> +                       req = blk_peek_request(q);

Why are you using blk_peek_request() instead of blk_fetch_request()
when the other thread just goes with fetch?

Am I right in assuming that also this request queue replies on the
implicit semantic that blk_peek_request(q) shall return NULL
if there are no requests in the queue, and that it is pulling out a
few NULLs to flush the request-handling machinery? Or did it
fix this? (Put that in the commit message in that case.)

> +
> +               if (req) {
> +                       issue_type = mmc_cqe_issue_type(host, req);
> +                       switch (issue_type) {
> +                       case MMC_ISSUE_DCMD:
> +                               if (mmc_cqe_dcmd_busy(mq)) {
> +                                       mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
> +                                       req = NULL;
> +                                       break;
> +                               }

I guess peek is used becaue you want to have the option to give it up here.

> +                               /* Fall through */
> +                       case MMC_ISSUE_ASYNC:
> +                               if (blk_queue_start_tag(q, req)) {
> +                                       mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
> +                                       req = NULL;
> +                               }

Then you start it with blk_queue_start_tag(), now does "tag" in this
function call mean the same as the "tag" you just added to the
MMC request struct?

> +                               break;
> +                       default:
> +                               /*
> +                                * Timeouts are handled by mmc core, so set a
> +                                * large value to avoid races.
> +                                */
> +                               req->timeout = 600 * HZ;
> +                               blk_start_request(req);

And here it just starts.

> +                               break;
> +                       }
> +                       if (req) {
> +                               mq->cqe_in_flight[issue_type] += 1;
> +                               if (mmc_cqe_tot_in_flight(mq) == 1)
> +                                       get_put += 1;
> +                               if (mmc_cqe_qcnt(mq) == 1)
> +                                       retune_ok = true;
> +                       }
> +               }
> +
> +               mq->asleep = !req;
> +
> +               spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +               if (req) {
> +                       enum mmc_issued issued;
> +
> +                       set_current_state(TASK_RUNNING);
> +
> +                       if (get_put) {
> +                               get_put = 0;
> +                               mmc_get_card(card);
> +                       }
> +
> +                       if (host->need_retune && retune_ok &&
> +                           !host->hold_retune)
> +                               host->retune_now = true;
> +                       else
> +                               host->retune_now = false;
> +
> +                       issued = mmc_blk_cqe_issue_rq(mq, req);
> +
> +                       cond_resched();
> +
> +                       spin_lock_irqsave(q->queue_lock, flags);
> +
> +                       switch (issued) {
> +                       case MMC_REQ_STARTED:
> +                               break;
> +                       case MMC_REQ_BUSY:
> +                               blk_requeue_request(q, req);

Here it is requeued.

> +                               goto finished;
> +                       case MMC_REQ_FAILED_TO_START:
> +                               __blk_end_request_all(req, BLK_STS_IOERR);

Or ended.

> +                               /* Fall through */
> +                       case MMC_REQ_FINISHED:
> +finished:
> +                               mq->cqe_in_flight[issue_type] -= 1;
> +                               if (mmc_cqe_tot_in_flight(mq) == 0)
> +                                       get_put = -1;
> +                       }
> +               } else {
> +                       if (get_put < 0) {
> +                               get_put = 0;
> +                               mmc_put_card(card);
> +                       }
> +                       /*
> +                        * Do not stop with requests in flight in case recovery
> +                        * is needed.
> +                        */
> +                       if (kthread_should_stop() &&
> +                           !mmc_cqe_tot_in_flight(mq)) {
> +                               set_current_state(TASK_RUNNING);
> +                               break;
> +                       }
> +                       up(&mq->thread_sem);
> +                       schedule();
> +                       down(&mq->thread_sem);
> +                       spin_lock_irqsave(q->queue_lock, flags);

And this semaphoring and threading is just as confusing as ever and now
we have two of them. (Sorry, I'm grumpy.)

I think I said in the beginning maybe not in response to this series but
another that I don't like the idea of making a second copy of the
whole request thread. I would much rather see that ONE request thread
is used for both regular requests and CQE.

Atleast I wanna see a serious rebuttal of why my claim that we should
keep this code down is such a pipe dream that we just have to go ahead
and make a second instance of all the core request mechanics.
And that this should be part of the commit message: "I'm duplicating
the queue thread because (...)" etc.

I'm sorry for being so conservative, but I am plain scared, I had serious
trouble refactoring this code already, and I got the feeling that several
people think the MMC stack has grown unapproachable for average
developers (my Googledoc where I tried to pry it apart got very popular
with developers I respect), and this is making that situation worse. Soon
only you and Ulf will understand this piece of code.

I do not know if I'm especially stupid when I feel the MMC stack code
is already hard to grasp, if that is the case I need to be told.

What we need is an MMC stack where it is clear where blocks come in
and out and how they are processed by the block layer, but now we
already have a scary Rube Goldberg-machine and it is not getting better.
If people have different feelings they can tell me off right now.

I have my hopes up that we can get the code lesser and more readable
with MQ, as I tried to illustrate in my attempts, which are indeed lame
because they don't work because of misc and SDIO use cases, but
I'm honestly doing my best. Currently with other clean-ups to get a
clean surface to do that.

As it stands, the MQ migration work size is in some spots doubled or
more than doubled after this commit :(

Yours,
Linus Walleij

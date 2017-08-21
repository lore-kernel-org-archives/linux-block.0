Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbdHUJeD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 05:34:03 -0400
Subject: Re: [PATCH V5 11/13] mmc: block: Add CQE support
To: Linus Walleij <linus.walleij@linaro.org>,
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
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <b7d28123-ecc1-8b24-28bd-18e87c475fc5@intel.com>
Date: Mon, 21 Aug 2017 12:27:30 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 20/08/17 15:13, Linus Walleij wrote:
> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Add CQE support to the block driver, including:
>>         - optionally using DCMD for flush requests
>>         - manually issuing discard requests
> 
> "Manually" has no place in computer code IMO since there is no
> man there. But I may be especially grumpy. But I don't understand the
> comment anyway.

CQE automatically sends the commands to complete requests.  However it only
supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
DCMD is limited to one command at a time, but discards require 3 commands.
That makes issuing discards through CQE very awkward, but some CQE's don't
support DCMD anyway.  So for discards, the existing non-CQE approach is
taken, where the mmc core code issues the 3 commands one at a time i.e.
mmc_erase().

> 
>>         - issuing read / write requests to the CQE
>>         - supporting block-layer timeouts
>>         - handling recovery
>>         - supporting re-tuning
>>
>> CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
>> (e.g. 2%) drop in sequential read speed but no observable change to sequential
>> write.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> This commit message seriously needs to detail the design of the
> request handling thread/engine.
> 
> So adding a new (in effect) invasive block driver needs to at least
> be CC:ed to the block maintainers so we don't sneak anything like
> that in under the radar.
> 
> This duplicates the "thread that sucks out requests" from the
> MMC core, and doubles the problem of replacing it with
> something like blk-mq.

We need to start with a legacy API because people want to backport CQ to
earlier kernels (we really need to get features upstream more quickly), but
blk-mq has been evolving a lot (e.g. elevator support), so backporters face
having either something quite different from upstream or trying to backport
great chunks of the block layer.

We also don't know how blk-mq will perform so it would be prudent to start
with support for both the legacy API and blk-mq (as scsi does) so that we
can find out first.

A loop to remove requests from the queue is normal e.g. scsi_request_fn()
and taking a consistent approach with the existing mmc thread does not
double the the problem of blk-mq implementation, since the same approach can
be used for both.

> 
> Especially these two snippets I would personally NOT merge
> without the explicit consent of a block layer maintainer:
> 
>> +static void mmc_cqe_request_fn(struct request_queue *q)
>> +{
>> +       struct mmc_queue *mq = q->queuedata;
>> +       struct request *req;
>> +
>> +       if (!mq) {
>> +               while ((req = blk_fetch_request(q)) != NULL) {
>> +                       req->rq_flags |= RQF_QUIET;
>> +                       __blk_end_request_all(req, BLK_STS_IOERR);
>> +               }
>> +               return;
>> +       }
>> +
>> +       if (mq->asleep && !mq->cqe_busy)
>> +               wake_up_process(mq->thread);
>> +}
> (...)
>> +static int mmc_cqe_thread(void *d)
>> +{
>> +       struct mmc_queue *mq = d;
>> +       struct request_queue *q = mq->queue;
>> +       struct mmc_card *card = mq->card;
>> +       struct mmc_host *host = card->host;
>> +       unsigned long flags;
>> +       int get_put = 0;
>> +
>> +       current->flags |= PF_MEMALLOC;
>> +
>> +       down(&mq->thread_sem);
>> +       spin_lock_irqsave(q->queue_lock, flags);
>> +       while (1) {
>> +               struct request *req = NULL;
>> +               enum mmc_issue_type issue_type;
>> +               bool retune_ok = false;
>> +
>> +               if (mq->cqe_recovery_needed) {
>> +                       spin_unlock_irqrestore(q->queue_lock, flags);
>> +                       mmc_blk_cqe_recovery(mq);
>> +                       spin_lock_irqsave(q->queue_lock, flags);
>> +                       mq->cqe_recovery_needed = false;
>> +               }
>> +
>> +               set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +               if (!kthread_should_stop())
>> +                       req = blk_peek_request(q);
> 
> Why are you using blk_peek_request() instead of blk_fetch_request()
> when the other thread just goes with fetch?

Because we are not always able to start the request.

> Am I right in assuming that also this request queue replies on the
> implicit semantic that blk_peek_request(q) shall return NULL
> if there are no requests in the queue, and that it is pulling out a
> few NULLs to flush the request-handling machinery? Or did it
> fix this? (Put that in the commit message in that case.)

CQ is different.  Because read / write requests are processed asynchronously
we can keep preparing and issuing more requests until the hardware queue is
full.  That is, we don't have to wait for the first request to complete
before preparing and issuing the second request, and so on.

However, the existing thread's need to issue a "null" is not because it is a
thread.  It is because of the convoluted design of mmc_start_areq().
However, you still need a way to issue the prepared request when the current
request completes.  Either wake-up the thread to do it, or in the past I
have suggested that should be done in the completion path, but that needs
changes to the host controller API.

> 
>> +
>> +               if (req) {
>> +                       issue_type = mmc_cqe_issue_type(host, req);
>> +                       switch (issue_type) {
>> +                       case MMC_ISSUE_DCMD:
>> +                               if (mmc_cqe_dcmd_busy(mq)) {
>> +                                       mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
>> +                                       req = NULL;
>> +                                       break;
>> +                               }
> 
> I guess peek is used becaue you want to have the option to give it up here.

Yes

> 
>> +                               /* Fall through */
>> +                       case MMC_ISSUE_ASYNC:
>> +                               if (blk_queue_start_tag(q, req)) {
>> +                                       mq->cqe_busy |= MMC_CQE_QUEUE_FULL;
>> +                                       req = NULL;
>> +                               }
> 
> Then you start it with blk_queue_start_tag(), now does "tag" in this
> function call mean the same as the "tag" you just added to the
> MMC request struct?

Yes

> 
>> +                               break;
>> +                       default:
>> +                               /*
>> +                                * Timeouts are handled by mmc core, so set a
>> +                                * large value to avoid races.
>> +                                */
>> +                               req->timeout = 600 * HZ;
>> +                               blk_start_request(req);
> 
> And here it just starts.

This is the path for requests that the CQE cannot process.  They don't need
to be tagged because there is no command queue - no way to do more than one
request at a time.

> 
>> +                               break;
>> +                       }
>> +                       if (req) {
>> +                               mq->cqe_in_flight[issue_type] += 1;
>> +                               if (mmc_cqe_tot_in_flight(mq) == 1)
>> +                                       get_put += 1;
>> +                               if (mmc_cqe_qcnt(mq) == 1)
>> +                                       retune_ok = true;
>> +                       }
>> +               }
>> +
>> +               mq->asleep = !req;
>> +
>> +               spin_unlock_irqrestore(q->queue_lock, flags);
>> +
>> +               if (req) {
>> +                       enum mmc_issued issued;
>> +
>> +                       set_current_state(TASK_RUNNING);
>> +
>> +                       if (get_put) {
>> +                               get_put = 0;
>> +                               mmc_get_card(card);
>> +                       }
>> +
>> +                       if (host->need_retune && retune_ok &&
>> +                           !host->hold_retune)
>> +                               host->retune_now = true;
>> +                       else
>> +                               host->retune_now = false;
>> +
>> +                       issued = mmc_blk_cqe_issue_rq(mq, req);
>> +
>> +                       cond_resched();
>> +
>> +                       spin_lock_irqsave(q->queue_lock, flags);
>> +
>> +                       switch (issued) {
>> +                       case MMC_REQ_STARTED:
>> +                               break;
>> +                       case MMC_REQ_BUSY:
>> +                               blk_requeue_request(q, req);
> 
> Here it is requeued.

Any request that is started has to be either re-queued or completed.

> 
>> +                               goto finished;
>> +                       case MMC_REQ_FAILED_TO_START:
>> +                               __blk_end_request_all(req, BLK_STS_IOERR);
> 
> Or ended.

Any request that is started has to be either re-queued or completed.

> 
>> +                               /* Fall through */
>> +                       case MMC_REQ_FINISHED:
>> +finished:
>> +                               mq->cqe_in_flight[issue_type] -= 1;
>> +                               if (mmc_cqe_tot_in_flight(mq) == 0)
>> +                                       get_put = -1;
>> +                       }
>> +               } else {
>> +                       if (get_put < 0) {
>> +                               get_put = 0;
>> +                               mmc_put_card(card);
>> +                       }
>> +                       /*
>> +                        * Do not stop with requests in flight in case recovery
>> +                        * is needed.
>> +                        */
>> +                       if (kthread_should_stop() &&
>> +                           !mmc_cqe_tot_in_flight(mq)) {
>> +                               set_current_state(TASK_RUNNING);
>> +                               break;
>> +                       }
>> +                       up(&mq->thread_sem);
>> +                       schedule();
>> +                       down(&mq->thread_sem);
>> +                       spin_lock_irqsave(q->queue_lock, flags);
> 
> And this semaphoring and threading is just as confusing as ever and now
> we have two of them. (Sorry, I'm grumpy.)

Sure we have two, but they follow the same approach. i.e. if you can get rid
of one, then you can use the same method to get rid of the other.

> 
> I think I said in the beginning maybe not in response to this series but
> another that I don't like the idea of making a second copy of the
> whole request thread. I would much rather see that ONE request thread
> is used for both regular requests and CQE.

They issue requests in completely different ways.  There is essentially no
common code.

> 
> Atleast I wanna see a serious rebuttal of why my claim that we should
> keep this code down is such a pipe dream that we just have to go ahead
> and make a second instance of all the core request mechanics.
> And that this should be part of the commit message: "I'm duplicating
> the queue thread because (...)" etc.

As I wrote above, we need to start with the legacy API, because of
backporting and because we don't know how blk-mq will perform.

> 
> I'm sorry for being so conservative, but I am plain scared, I had serious
> trouble refactoring this code already, and I got the feeling that several
> people think the MMC stack has grown unapproachable for average
> developers (my Googledoc where I tried to pry it apart got very popular
> with developers I respect), and this is making that situation worse. Soon
> only you and Ulf will understand this piece of code.

The mmc block driver has problems, but the thread isn't one of them.

> 
> I do not know if I'm especially stupid when I feel the MMC stack code
> is already hard to grasp, if that is the case I need to be told.

mmc_start_areq() is very convoluted.  However, getting rid of
mmc_start_areq() is only the first step.  Step two: have the host controller
complete requests without the need of block driver polling i.e.
card_busy_detect() must not be called in the normal completion path.  Step
three: make it possible to issue the prepared request in the completion path
of the current request.  Steps two and three need host controller driver
changes.

> 
> What we need is an MMC stack where it is clear where blocks come in
> and out and how they are processed by the block layer, but now we
> already have a scary Rube Goldberg-machine and it is not getting better.
> If people have different feelings they can tell me off right now.
> 
> I have my hopes up that we can get the code lesser and more readable
> with MQ, as I tried to illustrate in my attempts, which are indeed lame
> because they don't work because of misc and SDIO use cases, but
> I'm honestly doing my best. Currently with other clean-ups to get a
> clean surface to do that.
> 
> As it stands, the MQ migration work size is in some spots doubled or
> more than doubled after this commit :(

Not true.  I have begun work on blk-mq for CQE and I will send an RFC in a
day or two.

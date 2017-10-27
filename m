Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbdJ0MBW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 08:01:22 -0400
Subject: Re: [PATCH V12 2/5] mmc: block: Add blk-mq support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
References: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
 <1508834428-4360-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrunZ9q6vHZLDX3ZkH+0jgZQqD6=8Qj4LTJ+4J5yYstMg@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <39cc79f4-9272-cf4d-7843-a9752c9f624b@intel.com>
Date: Fri, 27 Oct 2017 14:54:23 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrunZ9q6vHZLDX3ZkH+0jgZQqD6=8Qj4LTJ+4J5yYstMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27/10/17 12:23, Ulf Hansson wrote:
> On 24 October 2017 at 10:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Define and use a blk-mq queue. Discards and flushes are processed
>> synchronously, but reads and writes asynchronously. In order to support
>> slow DMA unmapping, DMA unmapping is not done until after the next request
>> is started. That means the request is not completed until then. If there is
>> no next request then the completion is done by queued work.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/block.c | 655 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/core/block.h |  10 +
>>  drivers/mmc/core/queue.c | 302 ++++++++++++++++++++--
>>  drivers/mmc/core/queue.h |  41 +++
>>  include/linux/mmc/host.h |   1 +
>>  5 files changed, 979 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index ea80ff4cd7f9..002446e8dc5d 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1264,7 +1264,10 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>>                 break;
>>         }
>>         mq_rq->drv_op_result = ret;
>> -       blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>> +       if (req->mq_ctx)
>> +               blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>> +       else
>> +               blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>>  }
>>
>>  static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>> @@ -1307,7 +1310,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>>         else
>>                 mmc_blk_reset_success(md, type);
>>  fail:
>> -       blk_end_request(req, status, blk_rq_bytes(req));
>> +       if (req->mq_ctx)
>> +               blk_mq_end_request(req, status);
>> +       else
>> +               blk_end_request(req, status, blk_rq_bytes(req));
>>  }
>>
>>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>> @@ -1377,7 +1383,10 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>>         if (!err)
>>                 mmc_blk_reset_success(md, type);
>>  out:
>> -       blk_end_request(req, status, blk_rq_bytes(req));
>> +       if (req->mq_ctx)
>> +               blk_mq_end_request(req, status);
>> +       else
>> +               blk_end_request(req, status, blk_rq_bytes(req));
>>  }
>>
>>  static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
>> @@ -1387,7 +1396,10 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
>>         int ret = 0;
>>
>>         ret = mmc_flush_cache(card);
>> -       blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>> +       if (req->mq_ctx)
>> +               blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>> +       else
>> +               blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>>  }
>>
>>  /*
>> @@ -1413,15 +1425,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
>>         }
>>  }
>>
>> -#define CMD_ERRORS                                                     \
>> -       (R1_OUT_OF_RANGE |      /* Command argument out of range */     \
>> -        R1_ADDRESS_ERROR |     /* Misaligned address */                \
>> +#define CMD_ERRORS_EXCL_OOR                                            \
>> +       (R1_ADDRESS_ERROR |     /* Misaligned address */                \
> 
> This looks unrelated to blkmq support.

No, it is preserving existing oor functionality.

> 
>>          R1_BLOCK_LEN_ERROR |   /* Transferred block length incorrect */\
>>          R1_WP_VIOLATION |      /* Tried to write to protected block */ \
>>          R1_CARD_ECC_FAILED |   /* Card ECC failed */                   \
>>          R1_CC_ERROR |          /* Card controller error */             \
>>          R1_ERROR)              /* General/unknown error */
>>
>> +#define CMD_ERRORS                                                     \
>> +       (CMD_ERRORS_EXCL_OOR |                                          \
>> +        R1_OUT_OF_RANGE)       /* Command argument out of range */     \
>> +
> 
> Ditto.

And ditto.

> 
>>  static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>>  {
>>         u32 val;
>> @@ -1766,6 +1781,632 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>         mqrq->areq.err_check = mmc_blk_err_check;
>>  }
>>
>> +#define MMC_MAX_RETRIES                5
>> +#define MMC_DATA_RETRIES       2
>> +#define MMC_NO_RETRIES         (MMC_MAX_RETRIES + 1)
> 
> What's are these defines about? Do you intend to use different retries
> for the blkmq case comparing to the legacy request path? If so, why?

Same number of retries but now actually explicit.

> 
>> +
>> +/* Single sector read during recovery */
>> +static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       blk_status_t status;
>> +
>> +       while (1) {
>> +               mmc_blk_rw_rq_prep(mqrq, mq->card, 1, mq);
>> +
>> +               mmc_wait_for_req(mq->card->host, &mqrq->brq.mrq);
>> +
>> +               /*
>> +                * Not expecting command errors, so just give up in that case.
>> +                * If there are retries remaining, the request will get
>> +                * requeued.
>> +                */
>> +               if (mqrq->brq.cmd.error)
>> +                       return;
>> +
>> +               if (blk_rq_bytes(req) <= 512)
>> +                       break;
>> +
>> +               status = mqrq->brq.data.error ? BLK_STS_IOERR : BLK_STS_OK;
>> +
>> +               blk_update_request(req, status, 512);
>> +       }
>> +
>> +       mqrq->retries = MMC_NO_RETRIES;
>> +}
>> +
>> +static inline bool mmc_blk_oor_valid(struct mmc_blk_request *brq)
>> +{
>> +       return !!brq->mrq.sbc;
>> +}
>> +
>> +static inline u32 mmc_blk_stop_err_bits(struct mmc_blk_request *brq)
>> +{
>> +       return mmc_blk_oor_valid(brq) ? CMD_ERRORS : CMD_ERRORS_EXCL_OOR;
>> +}
> 
> Again, this seems like a non blkmq specific thing.

Again, preserving existing functionality.

> 
>> +
>> +static inline bool mmc_blk_in_tran_state(u32 status)
>> +{
>> +       /*
>> +        * Some cards mishandle the status bits, so make sure to check both the
>> +        * busy indication and the card state.
>> +        */
>> +       return status & R1_READY_FOR_DATA &&
>> +              (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
>> +}
>> +
>> +/*
>> + * Check for errors the host controller driver might not have seen such as
>> + * response mode errors or invalid card state.
>> + */
>> +static bool mmc_blk_status_error(struct request *req, u32 status)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_blk_request *brq = &mqrq->brq;
>> +       u32 stop_err_bits = mmc_blk_stop_err_bits(brq);
>> +
>> +       return brq->cmd.resp[0]  & CMD_ERRORS    ||
>> +              brq->stop.resp[0] & stop_err_bits ||
>> +              status            & stop_err_bits ||
>> +              (rq_data_dir(req) == WRITE && !mmc_blk_in_tran_state(status));
>> +}
>> +
>> +static inline bool mmc_blk_cmd_started(struct mmc_blk_request *brq)
>> +{
>> +       return !brq->sbc.error && !brq->cmd.error &&
>> +              !(brq->cmd.resp[0] & CMD_ERRORS);
>> +}
>> +
>> +static unsigned int mmc_blk_clock_khz(struct mmc_host *host)
>> +{
>> +       if (host->actual_clock)
>> +               return host->actual_clock / 1000;
>> +
>> +       /* Clock may be subject to a divisor, fudge it by a factor of 2. */
>> +       if (host->ios.clock)
>> +               return host->ios.clock / 2000;
>> +
>> +       /* How can there be no clock */
>> +       WARN_ON_ONCE(1);
>> +       return 100; /* 100 kHz is minimum possible value */
>> +}
>> +
>> +static unsigned long mmc_blk_data_timeout_jiffies(struct mmc_host *host,
>> +                                                 struct mmc_data *data)
>> +{
>> +       unsigned int ms = DIV_ROUND_UP(data->timeout_ns, 1000000);
>> +       unsigned int khz;
>> +
>> +       if (data->timeout_clks) {
>> +               khz = mmc_blk_clock_khz(host);
>> +               ms += DIV_ROUND_UP(data->timeout_clks, khz);
>> +       }
>> +
>> +       return msecs_to_jiffies(ms);
>> +}
>> +
>> +static int mmc_blk_card_stuck(struct mmc_card *card, struct request *req,
>> +                             u32 *resp_errs)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_data *data = &mqrq->brq.data;
>> +       unsigned long timeout;
>> +       u32 status;
>> +       int err;
>> +
>> +       timeout = jiffies + mmc_blk_data_timeout_jiffies(card->host, data);
>> +
>> +       while (1) {
>> +               bool done = time_after(jiffies, timeout);
>> +
>> +               err = __mmc_send_status(card, &status, 5);
>> +               if (err) {
>> +                       pr_err("%s: error %d requesting status\n",
>> +                              req->rq_disk->disk_name, err);
>> +                       break;
>> +               }
>> +
>> +               /* Accumulate any response error bits seen */
>> +               if (resp_errs)
>> +                       *resp_errs |= status;
>> +
>> +               if (mmc_blk_in_tran_state(status))
>> +                       break;
>> +
>> +               /* Timeout if the device never becomes ready */
>> +               if (done) {
>> +                       pr_err("%s: Card stuck in wrong state! %s %s\n",
>> +                               mmc_hostname(card->host),
>> +                               req->rq_disk->disk_name, __func__);
>> +                       err = -ETIMEDOUT;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static int mmc_blk_send_stop(struct mmc_card *card)
>> +{
>> +       struct mmc_command cmd = {
>> +               .opcode = MMC_STOP_TRANSMISSION,
>> +               .flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
>> +       };
>> +
>> +       return mmc_wait_for_cmd(card->host, &cmd, 5);
>> +}
>> +
>> +static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
>> +{
>> +       int err;
>> +
>> +       mmc_retune_hold_now(card->host);
>> +
>> +       mmc_blk_send_stop(card);
>> +
>> +       err = mmc_blk_card_stuck(card, req, NULL);
>> +
>> +       mmc_retune_release(card->host);
>> +
>> +       return err;
>> +}
>> +
>> +static void mmc_blk_rw_recovery(struct mmc_queue *mq, struct request *req)
>> +{
>> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_blk_request *brq = &mqrq->brq;
>> +       struct mmc_blk_data *md = mq->blkdata;
>> +       struct mmc_card *card = mq->card;
>> +       u32 status;
>> +       u32 blocks;
>> +       int err;
>> +
>> +       /*
>> +        * Status error bits might get lost during re-tuning so don't allow
>> +        * re-tuning yet.
>> +        */
>> +       mmc_retune_hold_now(card->host);
>> +
>> +       /*
>> +        * Some errors the host driver might not have seen. Set the number of
>> +        * bytes transferred to zero in that case.
>> +        */
>> +       err = __mmc_send_status(card, &status, 0);
>> +       if (err || mmc_blk_status_error(req, status))
>> +               brq->data.bytes_xfered = 0;
>> +
>> +       mmc_retune_release(card->host);
>> +
>> +       /*
>> +        * Try again to get the status. This also provides an opportunity for
>> +        * re-tuning.
>> +        */
>> +       if (err)
>> +               err = __mmc_send_status(card, &status, 0);
>> +
>> +       /*
>> +        * Nothing more to do after the number of bytes transferred has been
>> +        * updated and there is no card.
>> +        */
>> +       if (err && mmc_detect_card_removed(card->host))
>> +               return;
>> +
>> +       /* Try to get back to "tran" state */
>> +       if (err || !mmc_blk_in_tran_state(status))
>> +               err = mmc_blk_fix_state(mq->card, req);
>> +
>> +       /*
>> +        * Special case for SD cards where the card might record the number of
>> +        * blocks written.
>> +        */
>> +       if (!err && mmc_blk_cmd_started(brq) && mmc_card_sd(card) &&
>> +           rq_data_dir(req) == WRITE && !mmc_sd_num_wr_blocks(card, &blocks))
>> +               brq->data.bytes_xfered = blocks << 9;
>> +
>> +       /* Reset if the card is in a bad state */
>> +       if (err && mmc_blk_reset(md, card->host, type)) {
>> +               pr_err("%s: recovery failed!\n", req->rq_disk->disk_name);
>> +               mqrq->retries = MMC_NO_RETRIES;
>> +               return;
>> +       }
>> +
>> +       /*
>> +        * If anything was done, just return and if there is anything remaining
>> +        * on the request it will get requeued.
>> +        */
>> +       if (brq->data.bytes_xfered)
>> +               return;
>> +
>> +       /* Reset before last retry */
>> +       if (mqrq->retries + 1 == MMC_MAX_RETRIES)
>> +               mmc_blk_reset(md, card->host, type);
>> +
>> +       /* Command errors fail fast, so use all MMC_MAX_RETRIES */
>> +       if (brq->sbc.error || brq->cmd.error)
>> +               return;
>> +
>> +       /* Reduce the remaining retries for data errors */
>> +       if (mqrq->retries < MMC_MAX_RETRIES - MMC_DATA_RETRIES) {
>> +               mqrq->retries = MMC_MAX_RETRIES - MMC_DATA_RETRIES;
>> +               return;
>> +       }
>> +
>> +       /* FIXME: Missing single sector read for large sector size */
>> +       if (rq_data_dir(req) == READ && !mmc_large_sector(card)) {
>> +               /* Read one sector at a time */
>> +               mmc_blk_ss_read(mq, req);
>> +               return;
>> +       }
>> +}
>> +
>> +static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
>> +{
>> +       mmc_blk_eval_resp_error(brq);
>> +
>> +       return brq->sbc.error || brq->cmd.error || brq->stop.error ||
>> +              brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
>> +}
>> +
>> +static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       u32 status = 0;
>> +       int err;
>> +
>> +       if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
>> +               return 0;
>> +
>> +       mmc_retune_hold_now(card->host);
>> +
>> +       err = mmc_blk_card_stuck(card, req, &status);
>> +
>> +       mmc_retune_release(card->host);
>> +
>> +       /*
>> +        * Do not assume data transferred correctly if there are any error bits
>> +        * set.
>> +        */
>> +       if (!err && status & mmc_blk_stop_err_bits(&mqrq->brq)) {
>> +               mqrq->brq.data.bytes_xfered = 0;
>> +               err = -EIO;
>> +       }
>> +
>> +       /* Copy the exception bit so it will be seen later on */
>> +       if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
>> +               mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
>> +
>> +       return err;
>> +}
>> +
>> +static inline void mmc_blk_rw_reset_success(struct mmc_queue *mq,
>> +                                           struct request *req)
>> +{
>> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>> +
>> +       mmc_blk_reset_success(mq->blkdata, type);
>> +}
> 
> I understand that all the above new line and code (around 300 lines)
> is something you need for the blkmq support, in the rest of this
> patch.
> 
> However, it looks like you are adding completely new code that either
> already exists in the legacy request path (in some slightly different
> format), or could serve as clean up/re-factorization of the legacy
> request path.

The legacy error handling is a non-starter.  Messy and convoluted.  There is
no reason to keep using it.  Structurally it doesn't fit with blk-mq because
it is split in different places and mixes in logic that is not related with
error-handling.

> 
> This is not the way you should format a path for converting to blkmq.
> The reasons are:
> *) It makes it hard to review.

But the few comments in this email suggest you have spent maybe 30 minutes.
It really looks like you haven't tried.  Where are the questions?

> **) There is no need to through away *all* old mmc blk/core code,
> which I assume is your plan for next step. Instead the proper way is
> to re-factor it, an make it possible to re-use those parts that makes
> sense.

That is just nonsense.  We definitely want to throw away the messy
convoluted legacy code.  The new code is much simpler.  Did you read it?

> 
>> +
>> +static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       unsigned int nr_bytes = mqrq->brq.data.bytes_xfered;
>> +
>> +       if (nr_bytes) {
>> +               if (blk_update_request(req, BLK_STS_OK, nr_bytes))
>> +                       blk_mq_requeue_request(req, true);
>> +               else
>> +                       __blk_mq_end_request(req, BLK_STS_OK);
>> +       } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
>> +               blk_mq_requeue_request(req, true);
>> +       } else {
>> +               if (mmc_card_removed(mq->card))
>> +                       req->rq_flags |= RQF_QUIET;
>> +               blk_mq_end_request(req, BLK_STS_IOERR);
>> +       }
>> +}
>> +
>> +static bool mmc_blk_urgent_bkops_needed(struct mmc_queue *mq,
>> +                                       struct mmc_queue_req *mqrq)
>> +{
>> +       return mmc_card_mmc(mq->card) &&
>> +              (mqrq->brq.cmd.resp[0] & R1_EXCEPTION_EVENT ||
>> +               mqrq->brq.stop.resp[0] & R1_EXCEPTION_EVENT);
>> +}
>> +
>> +static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
>> +                                struct mmc_queue_req *mqrq)
>> +{
>> +       if (mmc_blk_urgent_bkops_needed(mq, mqrq))
>> +               mmc_start_bkops(mq->card, true);
>> +}
> 
> Ditto for the two above functions.

Again it is the same functionality.  In what way is it different?

> 
>> +
>> +void mmc_blk_mq_complete(struct request *req)
>> +{
>> +       struct mmc_queue *mq = req->q->queuedata;
>> +
>> +       mmc_blk_mq_complete_rq(mq, req);
>> +}
>> +
>> +static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>> +                                      struct request *req)
>> +{
>> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>> +       struct mmc_host *host = mq->card->host;
>> +       bool failed;
>> +
>> +       failed = mmc_blk_rq_error(&mqrq->brq) ||
>> +                mmc_blk_card_busy(mq->card, req);
>> +
>> +       if (!mmc_queue_direct_complete(host))
> 
> Can you please make the changes related to completing the request in
> the mmc_request_done() into a separate patch.
> 
> It's better to first get the default behavior in place, then we can
> improve things on top. Again, that also makes it easier to review.

I am not sure what you mean.  Did you read the code?
mmc_queue_direct_complete() is a capability that is not yet used, the
default behavior is preserved the way you asked.  You can keep asked for the
same lines of code to be in different patches, but it isn't going to change
the code.

> 
> No I am giving up reaching this point. I didn't even get the actual
> blkmq converting part, which is the core part I should be spending my
> time to review. Sorry!

It looks much more like you are not trying.  Not a single technical issue
raised!  Not a single technical question!

> 
> Some final comments around the system-wide PM support below.
> 
> [...]
> 
>>
>> +static void mmc_mq_queue_suspend(struct mmc_queue *mq)
>> +{
>> +       blk_mq_quiesce_queue(mq->queue);
>> +
>> +       /*
>> +        * The host remains claimed while there are outstanding requests, so
>> +        * simply claiming and releasing here ensures there are none.
>> +        */
>> +       mmc_claim_host(mq->card->host);
>> +       mmc_release_host(mq->card->host);
> 
> This looks fragile.

It isn't.  The driver would already be broken if we could have requests in
flight but not have the host claimed.

> 
> Seems like an interface in blkmq with flushes the queue and suspend it
> is missing, however there are of course reasons why it doesn't exist.
> 
> I assume the blk_mq_quiesce_queue() guarantees no new requests is
> being pushed to us after calling it, but it still seem a bit racy to
> rely on the host claim/release thing.

Race with what?

> 
> Let's bring this up as question for the block people experts.

You have had almost a year to learn about blk-mq.  What have you been doing?

And what are you going to do to get an answer from "the block people
experts" - there is a good chance few of those cc'ed will read this.

This all looks like a weak excuse to do nothing.

You need to stop playing games.  If you are not prepared to put the effort
in, then let the CQE code go in.  After all the dependency is a figment of
your imagination.  CQE has been ready to go for ages.  Why are you making up
reasons for delaying it?

Another possibility is to make me maintainer of the block driver since it
seems I am the one that knows most about it.

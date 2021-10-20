Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB46610A3
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTGmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:42:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:59683 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhJTGmH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:42:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226167087"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="226167087"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 23:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="575146481"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 19 Oct 2021 23:39:50 -0700
Subject: Re: [PATCH v2 2/2] mmc: core: Use blk_mq_complete_request_direct().
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
 <20211018135559.244400-3-bigeasy@linutronix.de>
 <CAPDyKFrnmevHeCZ3Fb3XCOx6cHvEv6b3ktYdU-WAnuuq8L4kXQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <675b6ad0-080c-c2ad-314c-618a941f9d1c@intel.com>
Date:   Wed, 20 Oct 2021 09:39:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrnmevHeCZ3Fb3XCOx6cHvEv6b3ktYdU-WAnuuq8L4kXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/10/2021 14:32, Ulf Hansson wrote:
> + Adrian
> 
> On Mon, 18 Oct 2021 at 15:56, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> The completion callback for the sdhci-pci device is invoked from a
>> kworker.
>> I couldn't identify in which context is mmc_blk_mq_req_done() invoke but
>> the remaining caller are from invoked from preemptible context. Here it
>> would make sense to complete the request directly instead scheduling
>> ksoftirqd for its completion.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Thanks for working on this!
> 
> I have looped in Adrian, to allow him to provide us with his input too.

Thanks!

Looks good to me.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> 
>> ---
>>  drivers/mmc/core/block.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 431af5e8be2f8..7d6b43fe52e8a 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2051,7 +2051,8 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>>                 mmc_put_card(mq->card, &mq->ctx);
>>  }
>>
>> -static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
>> +static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>> +                               bool can_sleep)
>>  {
>>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>         struct mmc_request *mrq = &mqrq->brq.mrq;
>> @@ -2063,10 +2064,14 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
>>          * Block layer timeouts race with completions which means the normal
>>          * completion path cannot be used during recovery.
>>          */
>> -       if (mq->in_recovery)
>> +       if (mq->in_recovery) {
>>                 mmc_blk_mq_complete_rq(mq, req);
>> -       else if (likely(!blk_should_fake_timeout(req->q)))
>> -               blk_mq_complete_request(req);
>> +       } else if (likely(!blk_should_fake_timeout(req->q))) {
>> +               if (can_sleep)
>> +                       blk_mq_complete_request_direct(req, mmc_blk_mq_complete);
>> +               else
>> +                       blk_mq_complete_request(req);
>> +       }
>>
>>         mmc_blk_mq_dec_in_flight(mq, req);
>>  }
>> @@ -2087,7 +2092,7 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq)
>>
>>         mmc_blk_urgent_bkops(mq, mqrq);
>>
>> -       mmc_blk_mq_post_req(mq, req);
>> +       mmc_blk_mq_post_req(mq, req, true);
>>  }
>>
>>  static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
>> @@ -2106,7 +2111,7 @@ static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
>>         if (prev_req)
>>                 *prev_req = mq->complete_req;
>>         else
>> -               mmc_blk_mq_post_req(mq, mq->complete_req);
>> +               mmc_blk_mq_post_req(mq, mq->complete_req, true);
>>
>>         mq->complete_req = NULL;
>>
>> @@ -2178,7 +2183,8 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>>         mq->rw_wait = false;
>>         wake_up(&mq->wait);
>>
>> -       mmc_blk_mq_post_req(mq, req);
>> +       /* context unknown */
>> +       mmc_blk_mq_post_req(mq, req, false);
> 
> So it seems we would benefit from knowing the context here, right?
> 
> At this point, what you suggest seems like a reasonable way forward
> (assuming atomic context), but in a next step we could potentially add
> a non-atomic helper function for mmc host drivers to call, when that
> is suitable. Would that make sense you think?
> 
>>  }
>>
>>  static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
>> @@ -2238,7 +2244,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
>>         err = mmc_start_request(host, &mqrq->brq.mrq);
>>
>>         if (prev_req)
>> -               mmc_blk_mq_post_req(mq, prev_req);
>> +               mmc_blk_mq_post_req(mq, prev_req, true);
>>
>>         if (err)
>>                 mq->rw_wait = false;
> 
> Kind regards
> Uffe
> 


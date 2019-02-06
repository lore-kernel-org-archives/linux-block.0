Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7224C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE1A20B1F
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfBFMnf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:43:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:23979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFMne (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 07:43:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 04:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="297668241"
Received: from unknown (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2019 04:43:31 -0800
Subject: Re: [PATCH] mmc: block: handle complete_work on separate workqueue
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Zachary Hays <zhays@lexmark.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1549385523-20521-1-git-send-email-zhays@lexmark.com>
 <CAPDyKFofTMGXfp1sKgv1Z6OSEyM9e78B-+3qZ=a6s3s2aNWybg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6956f0d7-0dea-b100-06ec-54148f043710@intel.com>
Date:   Wed, 6 Feb 2019 14:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFofTMGXfp1sKgv1Z6OSEyM9e78B-+3qZ=a6s3s2aNWybg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/02/19 2:00 PM, Ulf Hansson wrote:
> + Adrian, Linus
> 
> On Tue, 5 Feb 2019 at 17:53, Zachary Hays <zhays@lexmark.com> wrote:
>>
>> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
>> This generates a rescuer thread for that queue that will trigger when
>> the CPU is under heavy load and collect the uncompleted work.
>>
>> In the case of mmc, this creates the possibility of a deadlock as
>> other blk-mq work is also run on the same queue. For example:
>>
>> - worker 0 claims the mmc host
>> - worker 1 attempts to claim the host
>> - worker 0 schedules complete_work to release the host
>> - rescuer thread is triggered after time-out and collects the dangling
>>   work
>> - rescuer thread attempts to complete the work in order starting with
>>   claim host
>> - the task to release host is now blocked by a task to claim it and
>>   will never be called
>>
> 
> Adrian, I need your help to understand more of this. The above
> description doesn't add up to me.
> 
> In principle, already when "worker 1 attempts to claim the host" as
> described above, it should succeed and should *not* need to wait for
> the host to be released. Right?

If it is the same queue, then yes.  Although in that case there is only 1
work for the hw queue so there cannot be another worker.  There could be
another attempt to send a request directly, but that will not block - if the
host controller is busy, BLK_STS_RESOURCE will be returned from ->queue_rq().

> 
> The hole point with the commit 6c0cedd1ef95 ("mmc: core: Introduce
> host claiming by context"), was to allow the mmc host to be
> re-claimable for blk I/O requests, no matter from what worker/thread
> the claim/release is done from.
> 
> Is it not working as expected you think? What am I missing here?

I assumed we were talking about a situation where there are multiple
internal eMMC partitions each with their own disk and queue.  In that case,
a queue waits if there is another queue that is using the eMMC.

We should clarify whether that is the scenario we are looking at.  Zachary?

> 
>> The above results in multiple hung tasks that lead to failures to boot.
> 
> Of course, during boot there is also a card detect work running in
> parallel with blk I/O requests. This work is being punted to the
> "system_freezable_wq" and it claims/releases the host as well.
> 
> Perhaps, that could have something to do with the problem....
> 
>>
>> Handling complete_work on a separate workqueue avoids this by keeping
>> the work completion tasks separate from the other blk-mq work. This
>> allows the host to be released without getting blocked by other tasks
>> attempting to claim the host.
>>
>> Signed-off-by: Zachary Hays <zhays@lexmark.com>
>> ---
>>  drivers/mmc/core/block.c | 10 +++++++++-
>>  include/linux/mmc/card.h |  1 +
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index aef1185f383d..14f3fdb8c6bb 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2112,7 +2112,7 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>>                 if (waiting)
>>                         wake_up(&mq->wait);
>>                 else
>> -                       kblockd_schedule_work(&mq->complete_work);
>> +                       queue_work(mq->card->complete_wq, &mq->complete_work);
>>
>>                 return;
>>         }
>> @@ -2924,6 +2924,13 @@ static int mmc_blk_probe(struct mmc_card *card)
>>
>>         mmc_fixup_device(card, mmc_blk_fixups);
>>
>> +       card->complete_wq = alloc_workqueue("mmc_complete",
>> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
>> +       if (unlikely(!card->complete_wq)) {
>> +               pr_err("Failed to create mmc completion workqueue");
>> +               return -ENOMEM;
>> +       }
>> +
>>         md = mmc_blk_alloc(card);
>>         if (IS_ERR(md))
>>                 return PTR_ERR(md);
>> @@ -2987,6 +2994,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>>         pm_runtime_put_noidle(&card->dev);
>>         mmc_blk_remove_req(md);
>>         dev_set_drvdata(&card->dev, NULL);
>> +       destroy_workqueue(card->complete_wq);
>>  }
>>
>>  static int _mmc_blk_suspend(struct mmc_card *card)
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index de7377815b6b..8ef330027b13 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -308,6 +308,7 @@ struct mmc_card {
>>         unsigned int    nr_parts;
>>
>>         unsigned int            bouncesz;       /* Bounce buffer size */
>> +       struct workqueue_struct *complete_wq;   /* Private workqueue */
>>  };
>>
>>  static inline bool mmc_large_sector(struct mmc_card *card)
>> --
>> 2.7.4
>>
> 
> So this change seems to solve the problem, which is really great.
> However, I think we really need to understand what goes wrong, before
> we apply this as fix.
> 
> Unfortunate, I am also in busy period, so I need a couple of more days
> before I can help out running tests.
> 
> Kind regards
> Uffe
> 


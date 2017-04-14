Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45861 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752089AbdDNUC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 16:02:57 -0400
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
 <1491839696-24783-2-git-send-email-axboe@fb.com>
 <1491933638.2654.12.camel@sandisk.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <146849ab-b865-0ba7-b434-7101e013eafb@fb.com>
Date: Fri, 14 Apr 2017 14:02:40 -0600
MIME-Version: 1.0
In-Reply-To: <1491933638.2654.12.camel@sandisk.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/11/2017 12:00 PM, Bart Van Assche wrote:
> On Mon, 2017-04-10 at 09:54 -0600, Jens Axboe wrote:
>>  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
>>  {
>> -	cancel_work(&hctx->run_work);
>> +	cancel_delayed_work(&hctx->run_work);
>>  	cancel_delayed_work(&hctx->delay_work);
>>  	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
>>  }
> 
> Hello Jens,
> 
> I would like to change the above cancel_*work() calls into cancel_*work_sync()
> calls because this code is used when e.g. switching between I/O schedulers and
> no .queue_rq() calls must be ongoing while switching between schedulers. Do you
> want to integrate that change into this patch or do you want me to post a
> separate patch? In the latter case, should I start from your for-next branch
> to develop that patch or from your for-next branch + this patch series?

I agree, we should make it _sync(). I'll just make the edit in the patch
when I send it out again. I was waiting for further comments on patch 3/3.

-- 
Jens Axboe

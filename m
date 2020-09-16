Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125FC43461
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0CC206B5
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OUqN1DrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIPGYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:24:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28244 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgIPGYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 02:24:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600237484; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UqrD1TJLMz+4j/JUwBtiW0C1hFXgtIaUbeJB1mW/BNU=;
 b=OUqN1DrITq+QsZ7WKCbDyHHrDDEmpEfA2mptNg2WblFy8SjWJwcT5t8myjOmymS47RWPUbbw
 LRWsibTFTJtRy2kGmPtEswa6EzgDKp/KQssdDYx1hIMWhs0jH/xGqOqrWlBLjj/bFLTbmYhT
 n5Lc2vrJazFqxq1VtCB1Rgu6KYc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f61afa94f13e63f045a78c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 06:24:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21B7AC433C8; Wed, 16 Sep 2020 06:24:41 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A04DAC433CA;
        Wed, 16 Sep 2020 06:24:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 11:54:40 +0530
From:   ppvk@codeaurora.org
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V1] block: Fix use-after-free issue while accessing
 ioscheduler lock
In-Reply-To: <CACVXFVMiyEs_4nReSQvupih58LU9++C-APYcfmRQarr6bUZgxA@mail.gmail.com>
References: <1600092759-17779-1-git-send-email-ppvk@codeaurora.org>
 <CACVXFVMiyEs_4nReSQvupih58LU9++C-APYcfmRQarr6bUZgxA@mail.gmail.com>
Message-ID: <d9384b6e1798396a6c3bb5237cb5f82c@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-16 06:28, Ming Lei wrote:
> On Mon, Sep 14, 2020 at 10:14 PM Pradeep P V K <ppvk@codeaurora.org> 
> wrote:
>> 
>> Observes below crash while accessing (use-after-free) lock member
>> of bfq data.
>> 
>> context#1                       context#2
>>                                 process_one_work()
>> kthread()                       blk_mq_run_work_fn()
>> worker_thread()                  ->__blk_mq_run_hw_queue()
>> process_one_work()                ->blk_mq_sched_dispatch_requests()
>> __blk_release_queue()               ->blk_mq_do_dispatch_sched()
>> ->__elevator_exit()
>>   ->blk_mq_exit_sched()
>>     ->exit_sched()
>>       ->kfree()
>>                                        ->bfq_dispatch_request()
>>                                          
>> ->spin_unlock_irq(&bfqd->lock)
>> 
>> This is because of the kblockd delayed work that might got scheduled
>> around blk_release_queue() and accessed use-after-free member of
>> bfq_data.
>> 
>> 240.212359:   <2> Unable to handle kernel paging request at
>> virtual address ffffffee2e33ad70
>> ...
>> 240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
>> 240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
>> 240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
>> 240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
>> ...
>> Call trace:
>> 240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
>> 240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
>> 240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
>> 240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
>> 240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
>> 240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
>> 240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
>> 240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
>> 240.212963:   <2>  process_one_work+0x280/0x460
>> 240.212973:   <2>  worker_thread+0x27c/0x4dc
>> 240.212986:   <2>  kthread+0x160/0x170
>> 
>> Fix this by cancelling the delayed work if any before elevator exits.
>> 
>> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>> ---
>>  block/blk-sysfs.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 81722cd..e4a9aac 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -779,6 +779,8 @@ static void blk_release_queue(struct kobject 
>> *kobj)
>>  {
>>         struct request_queue *q =
>>                 container_of(kobj, struct request_queue, kobj);
>> +       struct blk_mq_hw_ctx *hctx;
>> +       int i;
> 
> Please move the above two lines to the branch of 'if (queue_is_mq(q)) 
> '.
> 
Sure. i will address this in my next patch set.
>> 
>>         might_sleep();
>> 
>> @@ -788,9 +790,11 @@ static void blk_release_queue(struct kobject 
>> *kobj)
>> 
>>         blk_free_queue_stats(q->stats);
>> 
>> -       if (queue_is_mq(q))
>> +       if (queue_is_mq(q)) {
>>                 cancel_delayed_work_sync(&q->requeue_work);
>> -
>> +               queue_for_each_hw_ctx(q, hctx, i)
>> +                       cancel_delayed_work_sync(&hctx->run_work);
>> +       }
> 
> Now the 'cancel_delayed_work_sync' from blk_mq_hw_sysfs_release() can
> be killed meantime.
> 
ok, i will remove this in my next patch set.

> We have to call cancel_delayed_work_sync when reqeuest queue's
> refcount drops to zero, otherwise
> new run queue may be started somewhere, so feel free to add the
> reviewed-by after the above two
> comments are addressed.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
sure i will address those 2 comments and will retain your
Reviewed-by signoff on my next patch set.

> Thanks,
> Ming Lei

Thanks and Regards,
Pradeep

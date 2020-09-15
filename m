Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF0C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858A421D7F
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VE1JGt/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIOJGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:06:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24932 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgIOJG3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 05:06:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600160788; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/gztmm3SUogx3A8rgUP4jdSttGOGP22h5ZaYFlszasE=;
 b=VE1JGt/qyrLfNu7IgULZKY7MlVTz5SqOkORVfZv6UpuTxFqAvdyAwGcs69zvqSISJKnFpTlg
 3LzlVkTm/pnunwGQt0G9CyPsamUFt9OVcWxxsTMML2qMPQT5omloIcDIVFUciW+UHdkVekg+
 Y01RfEndM5IefhRaV080hgkUIcA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f60841373afa3417ee05876 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 09:06:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27870C433FF; Tue, 15 Sep 2020 09:06:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50D62C433F0;
        Tue, 15 Sep 2020 09:06:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 14:36:25 +0530
From:   ppvk@codeaurora.org
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V1] block: Fix use-after-free issue while accessing
 ioscheduler lock
In-Reply-To: <20200915031255.GD738570@T590>
References: <1600092759-17779-1-git-send-email-ppvk@codeaurora.org>
 <20200915031255.GD738570@T590>
Message-ID: <b555c0bbcdec33dd3e37635b44ed01e8@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-15 08:42, Ming Lei wrote:
> On Mon, Sep 14, 2020 at 07:42:39PM +0530, Pradeep P V K wrote:
>> Observes below crash while accessing (use-after-free) lock member
>> of bfq data.
>> 
>> context#1			context#2
>> 				process_one_work()
>> kthread()			blk_mq_run_work_fn()
>> worker_thread()			 ->__blk_mq_run_hw_queue()
>> process_one_work()		  ->blk_mq_sched_dispatch_requests()
>> __blk_release_queue()		    ->blk_mq_do_dispatch_sched()
>> ->__elevator_exit()
>>   ->blk_mq_exit_sched()
>>     ->exit_sched()
>>       ->kfree()
>> 				       ->bfq_dispatch_request()
>> 				         ->spin_unlock_irq(&bfqd->lock)
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
>>  	struct request_queue *q =
>>  		container_of(kobj, struct request_queue, kobj);
>> +	struct blk_mq_hw_ctx *hctx;
>> +	int i;
>> 
>>  	might_sleep();
>> 
>> @@ -788,9 +790,11 @@ static void blk_release_queue(struct kobject 
>> *kobj)
>> 
>>  	blk_free_queue_stats(q->stats);
>> 
>> -	if (queue_is_mq(q))
>> +	if (queue_is_mq(q)) {
>>  		cancel_delayed_work_sync(&q->requeue_work);
>> -
>> +		queue_for_each_hw_ctx(q, hctx, i)
>> +			cancel_delayed_work_sync(&hctx->run_work);
>> +	}
> 
> hw queue may be run synchronously, such as from flush plug context.
> However we have grabbed one usage ref for that.
> 
> So looks this approach is fine, but just wondering why not putting
> the above change into blk_sync_queue() or blk_cleanup_queue() directly?
> 
Thanks Ming for the review and comments.
I added it in blk_release_queue(), as i could see a similar delayed work
"requeue_work" is getting cancelled. So i put here.
blk_release_queue() will gets called from blk_cleanup_queue(), so we can
add it directly here. i will make this change in my next patch set.

> 
> Thanks,
> Ming


Thanks and Regards,
Pradeep

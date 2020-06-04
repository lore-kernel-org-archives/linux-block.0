Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB631C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2211207D3
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgFDLvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:51:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbgFDLvr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 07:51:47 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 09ED81FF9B6595E2B858;
        Thu,  4 Jun 2020 12:51:46 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 4 Jun 2020
 12:51:45 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
Date:   Thu, 4 Jun 2020 12:50:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200604112615.GA2336493@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/06/2020 12:26, Ming Lei wrote:
>> And another:
>>
>> 51.336698] CPU53: shutdown
>> [  251.336737] run queue from wrong CPU 0, hctx active
>> [  251.339545] run queue from wrong CPU 0, hctx active
>> [  251.344695] psci: CPU53 killed (polled 0 ms)
>> [  251.349302] run queue from wrong CPU 0, hctx active
>> [  251.358447] run queue from wrong CPU 0, hctx active
>> [  251.363336] run queue from wrong CPU 0, hctx active
>> [  251.368222] run queue from wrong CPU 0, hctx active
>> [  251.373108] run queue from wrong CPU 0, hctx active
>> [  252.488831] CPU54: shutdown=1094MiB/s,w=0KiB/s][r=280k,w=0 IOPS][eta
>> 00m:04s]
>> [  252.491629] psci: CPU54 killed (polled 0 ms)
>> [  252.536533] irq_shutdown irq146
>> [  252.540007] CPU55: shutdown
>> [  252.543273] psci: CPU55 killed (polled 0 ms)
>> [  252.656656] CPU56: shutdown
>> [  252.659446] psci: CPU56 killed (polled 0 ms)
>> [  252.704576] CPU57: shutdown=947MiB/s,w=0KiB/s][r=242k,w=0 IOPS][eta
>> 00m:02s]
>> [  252.707369] psci: CPU57 killed (polled 0 ms)
>> [  254.352646] CPU58: shutdown=677MiB/s,w=0KiB/s][r=173k,w=0 IOPS][eta
>> 00m:02s]
>> [  254.355442] psci: CPU58 killed (polled 0 ms)
>> long sleep 1
>> [  279.288227] scsi_times_out req=0xffff041fa10b6600[r=0,w=0 IOPS][eta
>> 04m:37s]
>> [  279.320281] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
>> [  279.326144] sas: trying to find task 0x00000000e8dca422
>> [  279.331379] sas: sas_scsi_find_task: aborting task 0x00000000e8dca422
>>
>> none scheduler seems ok.
> Can you reproduce it by just applying the patch of 'blk-mq: don't fail driver tag
> allocation because of inactive hctx'?

That's your patch - ok, I can try.

So I added some debug for when using Christoph's:

static bool blk_mq_hctx_has_requests2(struct blk_mq_hw_ctx *hctx)
{
	struct blk_mq_tags *tags = hctx->tags;
	struct rq_iter_data data = {
		.hctx	= hctx,
	};

	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
	return data.has_rq;
}


static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
		struct blk_mq_hw_ctx *hctx)
{
@@ -2386,6 +2398,8 @@ static int blk_mq_hctx_notify_offline(unsigned int 
cpu, struct hlist_node *node)
	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
		while (blk_mq_hctx_has_requests(hctx))
			msleep(5);
+		if (blk_mq_hctx_has_requests2(hctx))
+			pr_err("%s still has driver tag - but how? hctx->sched_tags=%pS\n", 
__func__, hctx->sched_tags);
		percpu_ref_put(&hctx->queue->q_usage_counter);
	} else {

And I get this:

[  366.839260] CPU46: shutdown
[  366.842052] psci: CPU46 killed (polled 0 ms)
[  366.910923] blk_mq_hctx_notify_offline still has driver tag - but 
how? hctx->sched_tags=0xffff041fa59e0d00
[  366.920870] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
[  366.920871] IRQ 113: no longer affine to CPU47
[  366.931299] IRQ 116: no longer affine to CPU47
[  366.935734] IRQ 119: no longer affine to CPU47
[  366.940169] IRQ 123: no longer affine to CPU47
[  366.944607] irq_shutdown irq144
[  366.947783] IRQ 330: no longer affine to CPU47
[  366.952217] IRQ 333: no longer affine to CPU47
[  366.956651] IRQ 336: no longer affine to CPU47
[  366.961085] IRQ 339: no longer affine to CPU47
[  366.965519] IRQ 342: no longer affine to CPU47
[  366.969953] IRQ 345: no longer affine to CPU47
[  366.974475] CPU47: shutdown
[  366.977273] psci: CPU47 killed (polled 0 ms)
[  367.063066] CPU48: shutdown
[  367.065857] psci: CPU48 killed (polled 0 ms)
[  367.107071] CPU49: shutdown
[  367.109858] psci: CPU49 killed (polled 0 ms)
[  367.147057] CPU50: shutdown
[  367.149843] psci: CPU50 killed (polled 0 ms)
[  367.175006] irq_shutdown irq145
[  367.178272] CPU51: shutdown
[  367.181070] psci: CPU51 killed (polled 0 ms)
[  367.223067] CPU52: shutdown
[  367.225856] psci: CPU52 killed (polled 0 ms)
[  367.267024] CPU53: shutdown
[  367.269821] psci: CPU53 killed (polled 0 ms)
[  367.303004] CPU54: shutdown
[  367.305792] psci: CPU54 killed (polled 0 ms)
[  367.342948] irq_shutdown irq146
[  367.346169] CPU55: shutdown
[  367.348965] psci: CPU55 killed (polled 0 ms)
[  367.387004] CPU56: shutdown][16.9%][r=869MiB/s,w=0KiB/s][r=223k,w=0 
IOPS][eta 04m:59s]
[  367.389791] psci: CPU56 killed (polled 0 ms)
[  367.419017] CPU57: shutdown
[  367.421804] psci: CPU57 killed (polled 0 ms)
[  367.447010] CPU58: shutdown
[  367.449796] psci: CPU58 killed (polled 0 ms)
long sleep 2
[  398.070707] scsi_times_out req=0xffff041fa1a89c00iB/s][r=0,w=0 
IOPS][eta 04m:29s]

I thought that if all the sched tags are put, then we should have no 
driver tag for that same hctx, right? That seems to coincide with the 
timeout (30 seconds later)

> 
> If yes, can you collect debugfs log after the timeout is triggered?

Same limitation as before - once SCSI timeout happens, SCSI error 
handling kicks in and the shost no longer accepts commands, and, since 
that same shost provides rootfs, becomes unresponsive. But I can try.

Cheers,
John

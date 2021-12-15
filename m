Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhLOKZu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Dec 2021 05:25:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4282 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbhLOKZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 05:25:49 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDWZB1dmkz685ZG;
        Wed, 15 Dec 2021 18:24:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:25:47 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 10:25:46 +0000
Subject: Re: [PATCH v2] block: reduce kblockd_mod_delayed_work_on() CPU
 consumption
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>
References: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <926c2348-23a1-5b32-1369-3deb3d6d1671@huawei.com>
Date:   Wed, 15 Dec 2021 10:25:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.135]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/12/2021 20:49, Jens Axboe wrote:
> Dexuan reports that he's seeing spikes of very heavy CPU utilization when
> running 24 disks and using the 'none' scheduler. This happens off the
> sched restart path, because SCSI requires the queue to be restarted async,
> and hence we're hammering on mod_delayed_work_on() to ensure that the work
> item gets run appropriately.
> 
> Avoid hammering on the timer and just use queue_work_on() if no delay
> has been specified.
> 
> Reported-and-tested-by: Dexuan Cui <decui@microsoft.com>
> Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1378d084c770..c1833f95cb97 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1484,6 +1484,8 @@ EXPORT_SYMBOL(kblockd_schedule_work);
>   int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
>   				unsigned long delay)
>   {
> +	if (!delay)
> +		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
>   	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
>   }
>   EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
> 

Hi Jens,

I have a related comment on the current code and interface it uses, if 
you don't mind, as I did wonder if we are doing a msec_to_jiffies(0 [not 
built-in const]) call somewhere.

So we pass msecs to blk-mq.c, and we do a msec_to_jiffies() call on it 
before calling kblockd_mod_delayed_work_on(). Now most/all callsites 
uses const value for the msec value, so if we did the msec_to_jiffies() 
conversion at the callsites and passed a jiffies value, it should be 
compiled out by gcc. This is my current __blk_mq_delay_run_hw_queue 
assembler:

0000000000001ef0 <__blk_mq_delay_run_hw_queue>:
     [snip]
     2024: a942dfb6 ldp x22, x23, [x29, #40]
     2028: 2a1503e0 mov w0, w21
     202c: 94000000 bl 0 <__msecs_to_jiffies>
kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
     2030: aa0003e2 mov x2, x0
     2034: 91010261 add x1, x19, #0x40
     2038: 2a1403e0 mov w0, w20
     203c: 94000000 bl 0 <kblockd_mod_delayed_work_on>

I'm not sure if you would want to change so many APIs or if jiffies is 
sensible to pass or even any performance gain. Additionally Function 
blk_mq_delay_kick_requeue_list() would not see so much gain in such a 
change as msec value is not const. Any thoughts? Maybe testing 
performance would not do much harm.

Thanks,
John

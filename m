Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5ADCA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42ED2086A
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 17:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfJ2Ryx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:54:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfJ2Ryx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 13:54:53 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6AE84F919CB072F9BC60;
        Tue, 29 Oct 2019 17:54:51 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Oct 2019 17:54:51 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 17:54:50 +0000
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
 <20191028104238.GA14008@ming.t460p>
 <a5e25466-c4db-c254-be37-45a9ca85851c@huawei.com>
 <20191029015009.GD22088@ming.t460p>
 <a5a7c039-ff1b-b898-884d-f415318ccb7f@huawei.com>
 <20191029100509.GC20854@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6c0f94be-3ec7-974f-3a67-7d715a374c6a@huawei.com>
Date:   Tue, 29 Oct 2019 17:54:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191029100509.GC20854@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/10/2019 10:05, Ming Lei wrote:
>>> But this patch does wait for completion of in-flight request before
>>> shutdown the last CPU of this hctx.
>>>
>> Hi Ming,
>>
>> It may actually be a request from a hctx which is not shut down which errors
>> and causes the time out. I'm still checking.
> If that is the case, blk_mq_hctx_drain_inflight_rqs() will wait for
> completion of this request.
> 
> The only chance it is missed is that the last CPU of this hctx becomes
> offline just when this request stays in request list after it is
> retried from EH.
> 
>> BTW, Can you let me know exactly where you want the debug for "Or
>> blk_mq_hctx_next_cpu() may still run WORK_CPU_UNBOUND schedule after
>> all CPUs are offline, could you add debug message in that branch?"
> You can add the following debug message, then reproduce the issue and
> see if the debug log is dumped.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 06081966549f..5a98a7b79c0d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1452,6 +1452,10 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>   		 */
>   		hctx->next_cpu = next_cpu;
>   		hctx->next_cpu_batch = 1;
> +
> +		printk(KERN_WARNING "CPU %d, schedule from (dead) hctx %s\n",
> +			raw_smp_processor_id(),
> +			cpumask_empty(hctx->cpumask) ? "inactive": "active");
>   		return WORK_CPU_UNBOUND;

We don't seem to be hitting this.

So the error generally happens after the CPUs have been hot unplugged 
for some time. I find a SCSI IO errors in the LLDD, having been run on 
an up hctx - blk-mq requeues it on same hctx, but it only dispatches 
eventually after some other SCSI IO timesout - I assume that IO timesout 
due to earlier scsi_set_blocked() call.

Continuing to look....

Thanks,
John

>   	}
>   
> 
> Thanks,
> Ming
> 
> .


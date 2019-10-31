Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71981CA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0792086D
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfJaQ2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:28:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaQ2y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 12:28:54 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A7CDDA8586A0B6B33F02;
        Thu, 31 Oct 2019 16:28:52 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Oct 2019 16:28:52 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 16:28:52 +0000
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
Message-ID: <1ad4288f-ebf3-196d-ddd1-9b584ebcba68@huawei.com>
Date:   Thu, 31 Oct 2019 16:28:51 +0000
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
>>>> ok
>>>>
>>>> Or is it still
>>>>> possible to dispatch to LDD after BLK_MQ_S_INTERNAL_STOPPED is set?
>>>> It shouldn't be. However it would seem that this IO had been dispatched to
>>>> the LLDD, the hctx dies, and then we attempt to requeue on that hctx.
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
>   	}
>   


On 28/10/2019 10:42, Ming Lei wrote:
 > +++ b/block/blk-mq.c
 > @@ -679,6 +679,8 @@ void blk_mq_start_request(struct request *rq)
 >   {
 >          struct request_queue *q = rq->q;
 >
 > +       WARN_ON_ONCE(test_bit(BLK_MQ_S_INTERNAL_STOPPED,
 > &rq->mq_hctx->state));
 > +
 >          trace_block_rq_issue(q, rq);
 >
 >          if (test_bit(QUEUE_FLAG_STATS, &q->q


I have now hit this once:

[ 2960.943684] CPU7: shutdown
[ 2960.946424] psci: CPU7 killed.
[ 2961.030546] ------------[ cut here ]------------
[ 2961.035169] WARNING: CPU: 6 PID: 6127 at block/blk-mq.c:682 
blk_mq_start_request+0x1a8/0x1b0
[ 2961.043594] Modules linked in:
[ 2961.046642] CPU: 6 PID: 6127 Comm: fio Not tainted 
5.4.0-rc1-00129-gc61cbc373a43-dirty #457
[ 2961.054981] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[ 2961.063493] pstate: 00400009 (nzcv daif +PAN -UAO)
[ 2961.068274] pc : blk_mq_start_request+0x1a8/0x1b0
[ 2961.072967] lr : blk_mq_start_request+0x34/0x1b0
[ 2961.077572] sp : ffff0022ff5e71d0
[ 2961.080875] x29: ffff0022ff5e71d0 x28: ffff00232b8c6028
[ 2961.086176] x27: ffff00232b1ad6f0 x26: ffff00232b1addd0
[ 2961.091478] x25: ffff0022ff5e7300 x24: ffff00232b1ad500
[ 2961.096778] x23: ffff00232b8c6118 x22: ffff00232b379200
[ 2961.102079] x21: ffff00232b8c6010 x20: ffff00232b1d0998
[ 2961.107380] x19: ffff00232b8c6000 x18: 0000000000000000
[ 2961.112681] x17: 0000000000000000 x16: 0000000000000000
[ 2961.117981] x15: 0000000000000000 x14: 0000000000000000
[ 2961.123281] x13: 0000000000000006 x12: 1fffe00465718c56
[ 2961.128582] x11: ffff800465718c56 x10: dfffa00000000000
[ 2961.133883] x9 : 0000000000000000 x8 : ffff00232b8c62b8
[ 2961.139183] x7 : 0000000000000000 x6 : 000000000000003f
[ 2961.144484] x5 : 1fffe00465718c40 x4 : ffff00232b379228
[ 2961.149786] x3 : 0000000000000000 x2 : dfffa00000000000
[ 2961.155087] x1 : 0000000000000007 x0 : 000000000000000a
[ 2961.160387] Call trace:
[ 2961.162825]  blk_mq_start_request+0x1a8/0x1b0
[ 2961.167173]  scsi_queue_rq+0x808/0xf38
[ 2961.170911]  __blk_mq_try_issue_directly+0x238/0x310
[ 2961.175865]  blk_mq_request_issue_directly+0xb4/0xf8
[ 2961.180819]  blk_mq_try_issue_list_directly+0xa8/0x160
[ 2961.185947]  blk_mq_sched_insert_requests+0x2e4/0x390
[ 2961.190987]  blk_mq_flush_plug_list+0x254/0x2e0
[ 2961.195508]  blk_flush_plug_list+0x1d0/0x218
[ 2961.199767]  blk_finish_plug+0x48/0x240
[ 2961.203593]  blkdev_direct_IO+0x71c/0x7b0
[ 2961.207593]  generic_file_read_iter+0x16c/0xf28
[ 2961.212111]  blkdev_read_iter+0x80/0xb0
[ 2961.212961.227500]  el0_svc_common.constprop.1+0xa4/0x1d8
[ 2961.232281]  el0_svc_handler+0x34/0xb0
[ 2961.236019]  el0_svc+0x8/0xc
[ 2961.238888] ---[ end trace aa13b886f74a98be ]---
[ 2961.465018] blk_mq_hctx_notify_dead cpu6 dead 
request_queue=0xffff00232b1d5658 (id=19) hctx=0xffff00232abf9200 
hctx->cpumask=6-11 cpu_online_mask=0-5,13-95
[ 2961.478967] blk_mq_hctx_notify_dead cpu6 dead 
request_queue=0xffff00232b1d4328 (id=17) hctx=0xffff00232aa11200 
hctx->cpumask=6-11 cpu_online_mask=0-5,13-95

But this did not seem to trigger my timeout.

John

> 
> Thanks,
> Ming
> 
> .


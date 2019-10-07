Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC8ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A706820659
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfJGQtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:49:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbfJGQtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 12:49:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D6758EC0CBA65ED0BCA;
        Tue,  8 Oct 2019 00:49:11 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 00:49:06 +0800
Subject: Re: [PATCH V2 RESEND 3/5] blk-mq: stop to handle IO before hctx's all
 CPUs become offline
To:     Ming Lei <ming.lei@redhat.com>
References: <20191006024516.19996-1-ming.lei@redhat.com>
 <20191006024516.19996-4-ming.lei@redhat.com>
 <047ecdf1-bd4b-6702-1add-83b902a6902f@huawei.com>
 <20191007150416.GB1668@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ccd2cdfa-089b-adcf-f52f-1b543ee5393e@huawei.com>
Date:   Mon, 7 Oct 2019 17:49:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191007150416.GB1668@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/10/2019 16:04, Ming Lei wrote:
> On Mon, Oct 07, 2019 at 11:23:22AM +0100, John Garry wrote:
>> On 06/10/2019 03:45, Ming Lei wrote:
>>> +	}
>>> +}
>>> +
>>> +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
>>> +{
>>> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>>> +			struct blk_mq_hw_ctx, cpuhp_online);
>>> +	unsigned prev_cpu = -1;
>>> +
>>> +	while (true) {
>>> +		unsigned next_cpu = cpumask_next_and(prev_cpu, hctx->cpumask,
>>> +				cpu_online_mask);
>>> +
>>> +		if (next_cpu >= nr_cpu_ids)
>>> +			break;
>>> +
>>> +		/* return if there is other online CPU on this hctx */
>>> +		if (next_cpu != cpu)
>>> +			return 0;
>>> +
>>> +		prev_cpu = next_cpu;
>>> +	}
>>> +
>>> +	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
>>> +	blk_mq_drain_inflight_rqs(hctx);
>>> +
>>
>> Does this do the same:
>>
>> {
>> 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>> 			struct blk_mq_hw_ctx, cpuhp_online);
>> 	cpumask_var_t tmp;
>>
>> 	cpumask_and(tmp, hctx->cpumask, cpu_online_mask);
>>
>> 	/* test if there is any other cpu online in the hctx cpu mask */
>> 	if (cpumask_any_but(tmp, cpu) < nr_cpu_ids)
>> 		return 0;
>>
>> 	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
>> 	blk_mq_drain_inflight_rqs(hctx);
>>
>> 	return 0;
>> }
>>
>> If so, it's more readable and concise.
>
> Yes, but we have to allocate space for 'tmp', that is what this patch
> tries to avoid,

Yeah, I forgot about the extra complications of the cpumask offstack 
stuff; but it does seem rarely used...

There is this:

{
	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
			struct blk_mq_hw_ctx, cpuhp_online);

	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) ==
	     cpu) &&
	     (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) >=
               nr_cpu_ids)) {
		set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
		blk_mq_drain_inflight_rqs(hctx);
	}

	return 0;
}

... which looks effectively the same as yours, except a bit more 
readable (ignoring the fixable spilling of lines) to me.

Thanks,
John

 > given the logic isn't too complicated.
>
>>
>>
>> BTW, You could have added my Tested-by tags...
>
> OK, I will add it in V3.
>
>
> Thanks,
> Ming
>
> .
>



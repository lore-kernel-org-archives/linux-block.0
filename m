Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3FC55191
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 08:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ADA2070A
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 08:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZITy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:19:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgDZITy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 04:19:54 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2E9061A6D73A09E56E00;
        Sun, 26 Apr 2020 09:19:53 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.97) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sun, 26 Apr
 2020 09:19:52 +0100
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, <will@kernel.org>,
        <peterz@infradead.org>, <paulmck@kernel.org>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com> <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590> <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590> <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de> <20200426020621.GA511475@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <16514862-905f-2e3c-40b7-8d71ea89cf62@huawei.com>
Date:   Sun, 26 Apr 2020 09:19:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200426020621.GA511475@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.97]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/04/2020 03:06, Ming Lei wrote:
> On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
>> FYI, here is what I think we should be doing (but the memory model
>> experts please correct me):

Hi Ming,

>>
>>   - just drop the direct_issue flag and check for the CPU, which is
>>     cheap enough
> 
> That isn't correct because the CPU for running async queue may not be
> same with rq->mq_ctx->cpu since hctx->cpumask may include several CPUs
> and we run queue in RR style and it is really a normal case.
> 
> So I'd rather to keep 'direct_issue' flag given it is just a constant

How about changing the function argument name from 'direct_issue' to 
something which better expresses the intent, like 'may_migrate' or 
similar? (I know you mention the reason this in the comment also).

> argument and gcc is smart enough to optimize this case if you don't have
> better idea.
> 
>>   - replace the raw_smp_processor_id with a get_cpu to make sure we
>>     don't hit the tiny migration windows
> 

I do wonder if the barrier always may be cheaper than this.

> Will do that.
> 
>>   - a bunch of random cleanups to make the code easier to read, mostly
>>     by being more self-documenting or improving the comments.
> 
> The cleanup code looks fine.
> 
> 

Cheers,
John


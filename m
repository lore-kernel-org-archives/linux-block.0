Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B8C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2F22177B
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHGJf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:35:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgHGJf7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:35:59 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8CA099167016936A645B;
        Fri,  7 Aug 2020 17:35:56 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:35:55 +0800
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        <paulmck@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
 <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
 <20200807092457.GA2112310@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e6b4032e-a5c6-0038-33b8-04a15ae75a0e@huawei.com>
Date:   Fri, 7 Aug 2020 17:35:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807092457.GA2112310@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/7 17:24, Ming Lei wrote:
> On Fri, Aug 07, 2020 at 05:04:38PM +0800, Chao Leng wrote:
>>
>>
>> On 2020/7/29 12:39, Sagi Grimberg wrote:
>>>
>>>>>>> Dynamically allocating each one is possible but not very scalable.
>>>>>>>
>>>>>>> The question is if there is some way, we can do this with on-stack
>>>>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>>>>> effect.
>>>>>>
>>>>>> If the hctx structures are guaranteed to stay put, you could count
>>>>>> them and then do a single allocation of an array of rcu_head structures
>>>>>> (or some larger structure containing an rcu_head structure, if needed).
>>>>>> You could then sequence through this array, consuming one rcu_head per
>>>>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>>>>> it would be safe to free the array.
>>>>>>
>>>>>> Sounds too simple, though.  So what am I missing?
>>>>>
>>>>> We don't want higher-order allocations...
>>>>
>>>> So:
>>>>
>>>>     (1) We don't want to embed the struct in the hctx because we allocate
>>>>     so many of them that this is non-negligable to add for something we
>>>>     typically never use.
>>>>
>>>>     (2) We don't want to allocate dynamically because it's potentially
>>>>     huge.
>>>>
>>>> As long as we're using srcu for blocking hctx's, I think it's "pick your
>>>> poison".
>>>>
>>>> Alternatively, Ming's percpu_ref patch(*) may be worth a look.
>>>>
>>>>    * https://www.spinics.net/lists/linux-block/msg56976.html1
>>> I'm not opposed to having this. Will require some more testing
>>> as this affects pretty much every driver out there..
>>>
>>> If we are going with a lightweight percpu_ref, can we just do
>>> it also for non-blocking hctx and have a single code-path?
>>> .
>> I tried to optimize the patch，support for non blocking queue and
>> blocking queue.
>> See next email.
> 
> Please see the following thread:
> 
> https://lore.kernel.org/linux-block/05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk/
> 
> Both Keith and Jens didn't think it is a good idea.
If we can support nonblocking queue and blocking queue simplely, this may be a good choice.
Please review the patch first.
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

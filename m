Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A5C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6022C7D
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhAOIc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:32:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11391 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbhAOIc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 03:32:58 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DHDss5s4Fz7Vm7;
        Fri, 15 Jan 2021 16:31:13 +0800 (CST)
Received: from [10.174.177.17] (10.174.177.17) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 16:32:14 +0800
Subject: Re: [PATCH] block: quiesce queue before freeing queue
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>
References: <20210115064352.532534-1-yuyufen@huawei.com>
 <20210115073529.GA396337@T590>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <1b970f10-dc2e-0003-b708-d48e7ee17750@huawei.com>
Date:   Fri, 15 Jan 2021 16:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20210115073529.GA396337@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.17]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/15 15:35, Ming Lei wrote:
> On Fri, Jan 15, 2021 at 01:43:52AM -0500, Yufen Yu wrote:
>> There is a race beteewn blk_mq_run_hw_queue() and cleanup queue,
>> which can cause use-after-free as following:

>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 7663a9b94b80..f8a038d19c89 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -392,6 +392,18 @@ void blk_cleanup_queue(struct request_queue *q)
>>   
>>   	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>>   
>> +	/*
>> +	 * make sure all in-progress dispatch are completed because
>> +	 * blk_freeze_queue() can only complete all requests, and
>> +	 * dispatch may still be in-progress since we dispatch requests
>> +	 * from more than one contexts.
>> +	 *
>> +	 * We rely on driver to deal with the race in case that queue
>> +	 * initialization isn't done.
>> +	 */
>> +	if (queue_is_mq(q) && blk_queue_init_done(q))
>> +		blk_mq_quiesce_queue(q);
> 
> No, please don't do that. We had several slow boot reports before caused by
> by synchronize_rcu() in blk_cleanup_queue(), since blk_cleanup_queue()
> is called for in-existed queues, which number can be quite big.

Thanks to point out this. But, can't blk_queue_init_done will avoid calling
synchronize_rcu() for inexistent queues?

Thanks,
Yufen


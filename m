Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7322C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 03:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJUDQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJUDQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 23:16:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43362158D6A
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 20:16:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtqHs1YvrzmVF4;
        Fri, 21 Oct 2022 11:11:37 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:16:05 +0800
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
From:   Chao Leng <lengchao@huawei.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
 <25cf9a6a-9224-0b35-6dec-194440d4e58d@huawei.com>
Message-ID: <99c31c6b-47ec-adb2-4f57-15ee8f7b3143@huawei.com>
Date:   Fri, 21 Oct 2022 11:16:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <25cf9a6a-9224-0b35-6dec-194440d4e58d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/21 10:47, Chao Leng wrote:
> 
> 
> On 2022/10/20 18:56, Christoph Hellwig wrote:
>> For submit_bio based queues there is no (S)RCU critical section during
>> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
>> so skip doing any synchronization.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-mq.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 33292c01875d5..df967c8af9fee 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>>   void blk_mq_quiesce_queue(struct request_queue *q)
>>   {
>>       blk_mq_quiesce_queue_nowait(q);
>> -    blk_mq_wait_quiesce_done(q);
>> +    /* nothing to wait for non-mq queues */
>> +    if (queue_is_mq(q))
>> +        blk_mq_wait_quiesce_done(q);
> For the non-mq queues, maybe we should add a synchronize_rcu.
>      if (queue_is_mq(q))
>          blk_mq_wait_quiesce_done(q);
>      else
>          synchronize_rcu();
Please ignore this, synchronize_rcu is not needed.
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>>
> 
> .

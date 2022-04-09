Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525CC433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 02:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiDICMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 22:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiDICMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 22:12:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A755BE71;
        Fri,  8 Apr 2022 19:09:56 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZz835C7yzdZLf;
        Sat,  9 Apr 2022 10:09:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:09:53 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 10:09:53 +0800
Subject: Re: [PATCH -next RFC v2 2/8] blk-mq: call 'bt_wait_ptr()' later in
 blk_mq_get_tag()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-3-yukuai3@huawei.com>
 <f6bcc53d-1419-7190-fd9a-8c5fa7178fe1@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <fbe5565e-4dbe-bb71-e3c4-c33eb470a8d2@huawei.com>
Date:   Sat, 9 Apr 2022 10:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f6bcc53d-1419-7190-fd9a-8c5fa7178fe1@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/04/08 22:20, Bart Van Assche 写道:
> On 4/8/22 00:39, Yu Kuai wrote:
>> bt_wait_ptr() will increase 'wait_index', however, if blk_mq_get_tag()
>> get a tag successfully after bt_wait_ptr() is called and before
>> sbitmap_prepare_to_wait() is called, then the 'ws' is skipped. This
>> behavior might cause 8 waitqueues to be unbalanced.
>>
>> Move bt_wait_ptr() later should reduce the problem when the disk is
>> under high io preesure.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq-tag.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 68ac23d0b640..228a0001694f 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -155,7 +155,6 @@ unsigned int blk_mq_get_tag(struct 
>> blk_mq_alloc_data *data)
>>       if (data->flags & BLK_MQ_REQ_NOWAIT)
>>           return BLK_MQ_NO_TAG;
>> -    ws = bt_wait_ptr(bt, data->hctx);
>>       do {
>>           struct sbitmap_queue *bt_prev;
>> @@ -174,6 +173,7 @@ unsigned int blk_mq_get_tag(struct 
>> blk_mq_alloc_data *data)
>>           if (tag != BLK_MQ_NO_TAG)
>>               break;
>> +        ws = bt_wait_ptr(bt, data->hctx);
>>           sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
>>           tag = __blk_mq_get_tag(data, bt);
>> @@ -201,8 +201,6 @@ unsigned int blk_mq_get_tag(struct 
>> blk_mq_alloc_data *data)
>>            */
>>           if (bt != bt_prev)
>>               sbitmap_queue_wake_up(bt_prev);
>> -
>> -        ws = bt_wait_ptr(bt, data->hctx);
>>       } while (1);
> 
> Is it necessary to call bt_wait_ptr() during every loop iteration or 
> only if bt != bt_prev? Would calling bt_wait_ptr() only if bt != bt_prev 
> help to reduce unfairness further?
Hi,

You are right, that sounds reasonable.

Thanks,
Kuai
> 
> Thanks,
> 
> Bart.
> .
> 

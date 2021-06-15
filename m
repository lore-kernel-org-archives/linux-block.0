Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75465C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1B61438
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 10:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFOKKn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:10:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3242 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOKKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 06:10:43 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G43bT1rk6z6H8Ft;
        Tue, 15 Jun 2021 17:55:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 12:08:37 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 11:08:35 +0100
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>
CC:     <linux-block@vger.kernel.org>,
        <syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com>
References: <20210609063046.122843-1-ming.lei@redhat.com>
 <YMfTBagmPCHGkhYa@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2c2fd2b2-c622-15dc-58f6-c588cab4f79d@huawei.com>
Date:   Tue, 15 Jun 2021 11:02:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YMfTBagmPCHGkhYa@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> Reported-by:syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
>> Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
>> Cc: John Garry<john.garry@huawei.com>
>> Signed-off-by: Ming Lei<ming.lei@redhat.com>
Tested-by: John Garry <john.garry@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>

 >> ---
>>   block/blk-mq-sched.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index a9182d2f8ad3..80273245d11a 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -680,6 +680,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>>   {
>>   	struct blk_mq_hw_ctx *hctx;
>>   	unsigned int i;
>> +	unsigned int flags = 0;
>>   
>>   	queue_for_each_hw_ctx(q, hctx, i) {
>>   		blk_mq_debugfs_unregister_sched_hctx(hctx);
>> @@ -687,12 +688,13 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>>   			e->type->ops.exit_hctx(hctx, i);
>>   			hctx->sched_data = NULL;
>>   		}
>> +		flags = hctx->flags;
>>   	}
>>   	blk_mq_debugfs_unregister_sched(q);
>>   	if (e->type->ops.exit_sched)
>>   		e->type->ops.exit_sched(e);
>>   	blk_mq_sched_tags_teardown(q);
>> -	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
>> +	if (blk_mq_is_sbitmap_shared(flags))

I suppose we could also have this also, but not nice to snoop around 
sbitmap internals:
	if (q->sched_bitmap_tags.sb.map)
		blk_mq_exit_sched_shared_sbitmap(q);

>>   		blk_mq_exit_sched_shared_sbitmap(q);
>>   	q->elevator = NULL;
>>   }


Thanks,
John



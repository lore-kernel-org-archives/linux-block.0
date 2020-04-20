Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD99BC3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B56206D5
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDTIXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:23:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgDTIXe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 04:23:34 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 79AE012A1BE46888B769;
        Mon, 20 Apr 2020 09:23:32 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 09:23:31 +0100
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
 <e5416179-2ba0-c9a8-1b86-d52eae29e146@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <663d472a-5bde-4b89-3137-c7bfdf4d7b97@huawei.com>
Date:   Mon, 20 Apr 2020 09:22:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e5416179-2ba0-c9a8-1b86-d52eae29e146@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.108]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/04/2020 03:43, Bart Van Assche wrote:
> On 2020-04-16 04:18, John Garry wrote:
>> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
>> dispatch loop, but the request may keep the driver tag, evaulated
>> in 'nxt' in the previous loop iteration.
>>
>> Fix by putting the driver tag for that request.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8e56884fd2e9..a7785df2c944 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>>   		rq = list_first_entry(list, struct request, queuelist);
>>   
>>   		hctx = rq->mq_hctx;
>> -		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
>> +		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
>> +			blk_mq_put_driver_tag(rq);
>>   			break;
>> +		}
>>   
>>   		if (!blk_mq_get_driver_tag(rq)) {
>>   			/*
> 
> Is this something that can only happen if q->mq_ops->queue_rq(hctx, &bd)
> returns another value than BLK_STS_OK, BLK_STS_RESOURCE and
> BLK_STS_DEV_RESOURCE? 

Right, as that case is handled in blk_mq_handle_dev_resource()

If so, please add a comment in the source code
> that explains this.

So important that we should now do this in an extra patch?

> 
> Is this perhaps a bug fix for 0bca799b9280 ("blk-mq: order getting
> budget and driver tag")? If so, please mention this and add Cc tags for
> the people who were Cc-ed on that patch.

So it looks like 0bca799b9280 had a flaw, but I am not sure if anything 
got broken there and worthy of stable backport.

I found this issue while debugging Ming's blk-mq cpu hotplug patchset, 
which I feel is ready to merge.

Having said that, this nasty issue did take > 1 day for me to debug... 
so let me know.

Thanks,
John

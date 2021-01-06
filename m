Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2131C433DB
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 02:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3D322D50
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 02:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbhAFCbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 21:31:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2937 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFCa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 21:30:59 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D9YGV0wm6z5Drq;
        Wed,  6 Jan 2021 10:29:22 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 6 Jan 2021 10:30:16 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 6 Jan
 2021 10:30:16 +0800
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_set_request_complete
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-2-lengchao@huawei.com>
 <20210105191638.GB4426@localhost.localdomain>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e4308bf9-ac47-d765-fe9a-6852a67da5c5@huawei.com>
Date:   Wed, 6 Jan 2021 10:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210105191638.GB4426@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/6 3:16, Minwoo Im wrote:
> Hello,
> 
> On 21-01-05 15:19:31, Chao Leng wrote:
>> In some scenarios, nvme need setting the state of request to
>> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
>> For details, see the subsequent patches.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   include/linux/blk-mq.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index e7482e6ad3ec..cee72d31054d 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -493,6 +493,11 @@ static inline int blk_mq_request_completed(struct request *rq)
>>   	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
>>   }
>>   
>> +static inline void blk_mq_set_request_complete(struct request *rq)
>> +{
>> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>> +}
>> +
> 
> Maybe we can have this newly added helper with updating caller
> in blk_mq_complete_request_remote() also ?
There are similar optimizations for blk_mq_request_started and
blk_mq_request_completed. It may be better to optimize it by using
independent patches.
> 
> Thanks,
> .
> 

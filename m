Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368AC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 01:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiF2Baw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiF2Bav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 21:30:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F865205C3
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 18:30:50 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXkQ13qsdzkWcQ;
        Wed, 29 Jun 2022 09:28:57 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 09:30:48 +0800
Subject: Re: [PATCH 1/2] blk-cgroup: factor out blkcg_iostat_update()
To:     Jens Axboe <axboe@kernel.dk>, <tj@kernel.org>, <jack@suse.cz>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>
References: <20220628144921.2190275-1-yanaijie@huawei.com>
 <20220628144921.2190275-2-yanaijie@huawei.com>
 <f9255ed5-e10a-90cb-5f7b-8638a42bf27d@kernel.dk>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1d4f4237-9bfb-1f9c-feaa-680af409a493@huawei.com>
Date:   Wed, 29 Jun 2022 09:30:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f9255ed5-e10a-90cb-5f7b-8638a42bf27d@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2022/6/28 22:45, Jens Axboe wrote:
> On 6/28/22 8:49 AM, Jason Yan wrote:
>> To reduce some duplicated code, factor out blkcg_iostat_update(). No
>> functional change.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   block/blk-cgroup.c | 37 ++++++++++++++++++++-----------------
>>   1 file changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 764e740b0c0f..60d205ec213e 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -846,6 +846,21 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
>>   	}
>>   }
>>   
>> +static inline void blkcg_iostat_update(struct blkcg_gq *blkg,
>> +	struct blkg_iostat *cur, struct blkg_iostat *last)
>> +{
>> +	struct blkg_iostat delta;
>> +	unsigned long flags;
>> +
>> +	/* propagate percpu delta to global */
>> +	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
>> +	blkg_iostat_set(&delta, cur);
>> +	blkg_iostat_sub(&delta, last);
>> +	blkg_iostat_add(&blkg->iostat.cur, &delta);
>> +	blkg_iostat_add(last, &delta);
>> +	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>> +}
>> +
> 
> Please kill the inline.
> 

OK. Thanks.

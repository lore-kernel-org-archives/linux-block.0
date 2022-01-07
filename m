Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3799C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiAGBIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 20:08:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16690 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiAGBIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jan 2022 20:08:19 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JVQ3z4b8wzZf4v;
        Fri,  7 Jan 2022 09:04:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 09:08:16 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 09:08:16 +0800
Subject: Re: [PATCH v5 0/2] cancel all throttled bios in del_gendisk()
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <hch@infradead.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211210083143.3181535-1-yukuai3@huawei.com>
 <ca8d39fc-48d3-cfd9-3fa4-a329bb37b91b@huawei.com>
Message-ID: <29a780c6-ad65-ece8-4fbc-acd766b681f8@huawei.com>
Date:   Fri, 7 Jan 2022 09:08:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca8d39fc-48d3-cfd9-3fa4-a329bb37b91b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2021/12/18 17:09, yukuai (C) 写道:
> 在 2021/12/10 16:31, Yu Kuai 写道:
>> If del_gendisk() is done when some io are still throttled, such io
>> will not be handled until the throttle is done, which is not
>> necessary.
>>
>> Changes in v2:
>>   - move WARN_ON_ONCE() from throtl_rb_first() to it's caller
>>   - merge some patches into one.
>>
>> Changes in v3:
>>   - some code optimization in patch 1
>>   - hold queue lock to cancel bios in patch 2
>>
>> Changes in v4:
>>   - delete rcu_read_lock() and rcu_read_unlock() in patch 2
>>
>> Changes in v5:
>>   - add comment about rcu lock
> Friendly ping...

Friendly ping ...

>>
>> Yu Kuai (2):
>>    blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller
>>    block: cancel all throttled bios in del_gendisk()
>>
>>   block/blk-throttle.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>>   block/blk-throttle.h |  2 ++
>>   block/genhd.c        |  2 ++
>>   3 files changed, 76 insertions(+), 3 deletions(-)
>>

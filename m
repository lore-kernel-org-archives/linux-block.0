Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23203C4320A
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 02:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C7260F94
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 02:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhHCC5S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:57:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13226 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCC5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 22:57:18 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gdzzy1Hg2z1CR2F;
        Tue,  3 Aug 2021 10:57:02 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 10:57:06 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 3 Aug 2021 10:57:05 +0800
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210712031818.31918-1-yukuai3@huawei.com>
 <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
 <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
 <e587c572-bcd7-87c4-5eea-30ccdc7455db@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <b124b91b-7474-fa27-b78c-01b7e7396a17@huawei.com>
Date:   Tue, 3 Aug 2021 10:57:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e587c572-bcd7-87c4-5eea-30ccdc7455db@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/03 0:17, Bart Van Assche wrote:
> On 8/2/21 6:34 AM, yukuai (C) wrote:
>> I run a test on both null_blk and nvme, results show that there are no
>> performance degradation:
>>
>> test platform: x86
>> test cpu: 2 nodes, total 72
>> test scheduler: none
>> test device: null_blk / nvme
>>
>> test cmd: fio -filename=/dev/xxx -name=test -ioengine=libaio -direct=1
>> -numjobs=72 -iodepth=16 -bs=4k -rw=write -offset_increment=1G
>> -cpus_allowed=0:71 -cpus_allowed_policy=split -group_reporting
>> -runtime=120
>>
>> test results: iops
>> 1) null_blk before this patch: 280k
>> 2) null_blk after this patch: 282k
>> 3) nvme before this patch: 378k
>> 4) nvme after this patch: 384k
> 
> Please use io_uring for performance tests.
> 
> The null_blk numbers seem way too low to me. If I run a null_blk 
> performance test inside a VM with 6 CPU cores (Xeon W-2135 CPU) I see 
> about 6 million IOPS for synchronous I/O and about 4.4 million IOPS when 
> using libaio. The options I used and that are not in the above command 
> line are: --thread --gtod_reduce=1 --ioscheduler=none.
> 

Hi, Bart

The cpu I'm testing is Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz, and
after switching to io_uring with "--thread --gtod_reduce=1
--ioscheduler=none", the numbers can increase to 330k, yet still
far behind 6000k.

The new atomic operations in the hot path is atomic_read() from
hctx_may_queue(), and the atomic variable will change in two
situations:

a. fail to get driver tag with dbusy not set, increase and set dbusy.
b. if dbusy is set when queue switch from busy to dile, decrease and
clear dbusy.

During the period a device "idle -> busy -> idle", the new atomic
variable can be writen twice at most, which means this is almost
readonly in the above test situation. So I guess the impact on
performance is minimal ?

Thanks!
Kuai

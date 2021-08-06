Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E447C4320A
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F9161184
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbhHFBur (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:50:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16052 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhHFBur (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 21:50:47 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgpHZ3pxKzZxm6;
        Fri,  6 Aug 2021 09:46:50 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:50:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:50:24 +0800
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
 <b124b91b-7474-fa27-b78c-01b7e7396a17@huawei.com>
 <07d2e6ba-d016-458a-a2ce-877fd7b72ed0@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a63fbd36-5a43-e412-c0a2-a06730945a13@huawei.com>
Date:   Fri, 6 Aug 2021 09:50:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <07d2e6ba-d016-458a-a2ce-877fd7b72ed0@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/04 2:38, Bart Van Assche wrote:
> On 8/2/21 7:57 PM, yukuai (C) wrote:
>> The cpu I'm testing is Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz, and
>> after switching to io_uring with "--thread --gtod_reduce=1
>> --ioscheduler=none", the numbers can increase to 330k, yet still
>> far behind 6000k.
> 
> On 
> https://ark.intel.com/content/www/us/en/ark/products/120485/intel-xeon-gold-6140-processor-24-75m-cache-2-30-ghz.html 
> I found the following information about that CPU:
> 18 CPU cores
> 36 hyperthreads
> 
> so 36 fio jobs should be sufficient. Maybe IOPS are lower than expected 
> because of how null_blk has been configured? This is the configuration 
> that I used in my test:
> 
> modprobe null_blk nr_devices=0 &&
>      udevadm settle &&
>      cd /sys/kernel/config/nullb &&
>      mkdir nullb0 &&
>      cd nullb0 &&
>      echo 0 > completion_nsec &&
>      echo 512 > blocksize &&
>      echo 0 > home_node &&
>      echo 0 > irqmode &&
>      echo 1024 > size &&
>      echo 0 > memory_backed &&
>      echo 2 > queue_mode &&
>      echo 1 > power ||
>      exit $?

hi Bart,

After applying this configuration, the number of null_blk in my
machine is about 650k(330k before). Is this still too low?

By the way, there are no performance degradation.

Thanks
Kuai
> 
>> The new atomic operations in the hot path is atomic_read() from
>> hctx_may_queue(), and the atomic variable will change in two
>> situations:
>>
>> a. fail to get driver tag with dbusy not set, increase and set dbusy.
>> b. if dbusy is set when queue switch from busy to dile, decrease and
>> clear dbusy.
>>
>> During the period a device "idle -> busy -> idle", the new atomic
>> variable can be writen twice at most, which means this is almost
>> readonly in the above test situation. So I guess the impact on
>> performance is minimal ?
> 
> Please measure the performance impact of your patch.
> 
> Thanks,
> 
> Bart.
> 
> .
> 

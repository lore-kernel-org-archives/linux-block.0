Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10215C4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E800660F00
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 09:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhHNJoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 05:44:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8412 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhHNJoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 05:44:05 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GmwPN2P0hz865v;
        Sat, 14 Aug 2021 17:39:36 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 14 Aug 2021 17:43:35 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 14 Aug 2021 17:43:35 +0800
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
 <a63fbd36-5a43-e412-c0a2-a06730945a13@huawei.com>
 <b4603b71-4306-4542-e4fb-bf30133f89a8@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <010fcd39-c819-8e0e-c188-62b1947603bf@huawei.com>
Date:   Sat, 14 Aug 2021 17:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4603b71-4306-4542-e4fb-bf30133f89a8@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/06 10:43, Bart Van Assche wrote:
> On 8/5/21 6:50 PM, yukuai (C) wrote:
>> After applying this configuration, the number of null_blk in my
>> machine is about 650k(330k before). Is this still too low?
> 
> That seems low to me. If I run the attached script on a six year old
> desktop with an eight core i7-4790 CPU it reports a little more than 5
> million IOPS. Has kernel debugging perhaps been enabled in the kernel on
> the test setup? Or is the system perhaps slowed down by security
> mitigations?
> 

Hi, Bart

Sorry for the delay. I was too busy with other things recently.

After disable all the kernel debuging config I can think of, the
numbers can increase to millions.

setup cmd:
modprobe null_blk nr_devices=0 &&
     udevadm settle &&
     cd /sys/kernel/config/nullb &&
     mkdir nullb0 &&
     cd nullb0 &&
     echo 0 > completion_nsec &&
     echo 512 > blocksize &&
     echo 0 > home_node &&
     echo 0 > irqmode &&
     echo 1024 > size &&
     echo 0 > memory_backed &&
     echo 2 > queue_mode &&
     echo 1 > power ||
     exit $?

test cmd:
fio -filename=/dev/nullb0 -name=test -ioengine=io_uring -direct=1
-numjobs=32 -iodepth=32 -bs=4k -rw=write -group_reporting -runtime=30
--thread --gtod_reduce=1 --ioscheduler=none -time_based

test result:
| test round | with this patch | without this patch |
| ---------- | --------------- | ------------------ |
| 1          | 4310k           | 4265k              |
| 2          | 4295k           | 4327k              |
| 3          | 4217k           | 4213k              |
| 4          | 4355k           | 4236k              |
| 5          | 4315k           | 4337k              |
| average    | 4294k           | 4275k              |

Thanks
Kuai

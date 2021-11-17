Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80D063232
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhKQIk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:40:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14949 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKQIk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 03:40:58 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HvGTh1M9WzZcwp;
        Wed, 17 Nov 2021 16:35:36 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 16:37:59 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 17 Nov 2021 16:37:58 +0800
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
To:     Ming Lei <ming.lei@redhat.com>
CC:     <damien.lemoal@wdc.com>, <axboe@kernel.dk>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-block@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <houtao1@huawei.com>
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
 <YZS4FYxtxYAXjtFJ@T590>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <774e0e26-9d2b-660f-196a-ea6651e2d845@huawei.com>
Date:   Wed, 17 Nov 2021 16:37:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YZS4FYxtxYAXjtFJ@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/11/17 16:06, Ming Lei wrote:
> On Wed, Nov 17, 2021 at 11:37:13AM +0800, yangerkun wrote:
>> Nowdays we meet the boot regression while enable lots of mtdblock
> 
> What is your boot regression? Any dmesg log?
> 
>> compare with 4.4. The main reason was that the blk_mq_freeze_queue in
>> elevator_init_mq will wait a RCU gap which want to make sure no IO will
>> happen while blk_mq_init_sched.
> 
> There isn't RCU grace period implied in the blk_mq_freeze_queue() called
> from elevator_init_mq(), because the .q_usage_counter works at atomic mode
> at that time.

Emm... It's my fault. Which add the RCU is blk_mq_quiesce_queue...

> 
>>
>> Other module like loop meets this problem too and has been fix with
> 
> Again, what is the problem?
> 
>> follow patches:
>>
>>   2112f5c1330a loop: Select I/O scheduler 'none' from inside add_disk()
>>   90b7198001f2 blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
>>
>> They change the default IO scheduler for loop to 'none'. So no need to
>> call blk_mq_freeze_queue and blk_mq_init_sched. But it seems not
>> appropriate for mtdblocks. Mtdblocks can use 'mq-deadline' to help
>> optimize the random write with the help of mtdblock's cache. Once change
>> to 'none', we may meet the regression for random write.
>>
>> commit 737eb78e82d52d35df166d29af32bf61992de71d
>> Author: Damien Le Moal <damien.lemoal@wdc.com>
>> Date:   Thu Sep 5 18:51:33 2019 +0900
>>
>>      block: Delay default elevator initialization
>>
>>      ...
>>
>>      Additionally, to make sure that the elevator initialization is never
>>      done while requests are in-flight (there should be none when the device
>>      driver calls device_add_disk()), freeze and quiesce the device request
>>      queue before calling blk_mq_init_sched() in elevator_init_mq().
>>      ...
>>
>> This commit add blk_mq_freeze_queue in elevator_init_mq which try to
>> make sure no in-flight request while we go through blk_mq_init_sched.
>> But does there any drivers can leave IO alive while we go through
>> elevator_init_mq？ And if no, maybe we can just remove this logical to
>> fix the regression...
> 
> SCSI should have passthrough requests at that moment.
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

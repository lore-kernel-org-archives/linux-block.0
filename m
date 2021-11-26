Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DAAC433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 11:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbhKZL4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:56:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4173 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346217AbhKZLyu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 06:54:50 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J0tNK6fbQz67y1l;
        Fri, 26 Nov 2021 19:50:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 12:51:35 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 11:51:34 +0000
Subject: Re: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hare@suse.de>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com>
 <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
 <9859e133-e3b8-4e53-dfad-cbf75ed3102f@huawei.com>
 <9b092ca49e9b5415772cd950a3c12584@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fbdf64cd-7d31-f470-b93c-5b42a1e1cf40@huawei.com>
Date:   Fri, 26 Nov 2021 11:51:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <9b092ca49e9b5415772cd950a3c12584@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/11/2021 11:25, Kashyap Desai wrote:
>>>
>>> I will continue testing and let you know how it goes.
>> ok, good to know, thanks. But I would still like to know what is
>> triggering
>> blk_mq_queue_tag_busy_iter() so often. Indeed, as mentioned in this cover
>> letter, this function was hardly optimised before for shared sbitmap.
> If I give  "--disk_util=0" option in my fio run, caller of "
> blk_mq_queue_tag_busy_iter" reduced drastically.
> As part of <fio> run, application call diskutils operations and it is almost
> same as doing "cat /proc/stats" in loop.
> Looking at fio code, it call diskstats every 250 msec. Here is sample fio
> logs -
> 
> diskutil 87720 /sys/block/sdb/stat: stat read ok? 0
> diskutil 87720 update io ticks
> diskutil 87720 open stat file: /sys/block/sdb/stat
> diskutil 87720 /sys/block/sdb/stat: 127853173        0 1022829056 241827073
> 0        0        0        0      255   984012 241827073        0        0
> 0        0        0        0
> 
> There is one more call trace, but not sure why it is getting executed in my
> test.  Below path does not execute so frequently but it consumes cpu (not
> noticeable on my setup)
> 
> kthread
>          worker_thread
>          process_one_work
>          blk_mq_timeout_work
>          blk_mq_queue_tag_busy_iter
>          bt_iter
>          blk_mq_find_and_get_req
>          _raw_spin_lock_irqsave
>          native_queued_spin_lock_slowpath
> 
> 

It would be still nice to know where this is coming from.

> This patch set improves above call trace even after disk_util=0 is set.
ok, fine. Thanks for testing.

So I guess that this is a regression, and you would want this series for 
v5.16, right? My changes were made with v5.17 in mind.

I am not sure how Jens feels about it, since the changes are 
significant. It would be a lot easier to argue for v5.16 if we got to 
this point earlier in the cycle...

Anyway, it would be good to have full review first, so please help with 
that.

@Ming, can you please give feedback on 3/3 here?

BTW, I am on vacation next week and can't help progress then, so any 
assistance would be good.

Thanks,
John

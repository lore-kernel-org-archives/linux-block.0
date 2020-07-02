Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9015C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6059820772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pINZSuk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBKTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:19:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37930 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgGBKTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 06:19:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702101908euoutp01b2653bd6c92ac0a4839b0d65a4e944ae~d6DLVAjhK2610526105euoutp01b
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 10:19:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702101908euoutp01b2653bd6c92ac0a4839b0d65a4e944ae~d6DLVAjhK2610526105euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593685148;
        bh=sLPAAadRwcsGHCt+msBfhSgntlGgEzYyjwwGf/BseJk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pINZSuk7keQ2RFUQ617yPsnEXxvz4uuWVP6VpjTpzHQ6NK/sZwyJEvKI5omQvKc2N
         ugqNI7f23erj9uKeX///9fio/ykTk1k/mjS/0zseDEMKZGtzb2THNqE27uEtgDvYB8
         mzuaNMIU8Ijl97u1vSdzIZsIYTzDb3d12wcGA9dI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702101907eucas1p17b7beec01027bea502353d7b6295ceee~d6DLIurFy2082520825eucas1p1I;
        Thu,  2 Jul 2020 10:19:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.42.06456.B94BDFE5; Thu,  2
        Jul 2020 11:19:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702101907eucas1p17c37bd206f8472fdff62ce30827b8664~d6DKoO8Dr2080020800eucas1p1E;
        Thu,  2 Jul 2020 10:19:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702101907eusmtrp1352bfb064ca688f59b51ec1b7e33af8a~d6DKnrUTQ2169621696eusmtrp1G;
        Thu,  2 Jul 2020 10:19:07 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-54-5efdb49b4648
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.D4.06017.B94BDFE5; Thu,  2
        Jul 2020 11:19:07 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702101907eusmtip27bc4383d984b7c31a2a54e339fe25971~d6DKQklzX2445824458eusmtip2W;
        Thu,  2 Jul 2020 10:19:06 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5acf69fb-04b2-8649-1fc4-2cfe8aa8b9c7@samsung.com>
Date:   Thu, 2 Jul 2020 12:19:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702092320.GD2452799@T590>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7qzt/yNM7jwwtRi9d1+NouNM9az
        WqxcfZTJYu8tbYtDk5uZHFg9Lp8t9dh9s4HN4/2+q2wefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlfH10DH2gjbPijlApQ2Mi+27GDk5JARMJJYsmcXaxcjFISSwglFi9vMGZgjnC6PEzN+3
        GSGcz4wSfxr2s8C0TF+9EiqxnFFif+dPJgjnPaPEkq4uRpAqYQEviUWHfoB1iAgoSdy9u5od
        pIhZYCqjRGffRiaQBJuAoUTX2y42EJtXwE5i5svL7CA2i4CKxN8zF5lBbFGBOIn1L7czQdQI
        Spyc+QRsKKeAjsSy3xNZQWxmAXmJ5q2zmSFscYlbT+aDXSQhsIhd4t5qkAQHkOMisf9OMsQL
        whKvjm9hh7BlJE5P7mGBqG9mlHh4bi07hNPDKHG5aQYjRJW1xJ1zv9hABjELaEqs36UPEXaU
        aPp6jBFiPp/EjbeCEDfwSUzaNh1qLa9ER5sQRLWaxKzj6+DWHrxwiXkCo9IsJJ/NQvLNLCTf
        zELYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgujn97/inHYxfLyUdYhTgYFTi
        4c2o+BMnxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJ
        pCeWpGanphakFsFkmTg4pRoY/T/Wm/GWHersyy4o38yqeFhO17JVNe3btm8nU4+f/89smvTM
        5JiMpN7GZPncSD2TffsMJ0t9997M1ynz40/84u7k5Q1BDV73vqpXRWxVrbqxbvOWmS4b57mv
        mr868gyPXU/tRda+LZPCuFUL58+YLKZusSz2r7TTUpUJOWJPml4UM+yYulFHiaU4I9FQi7mo
        OBEAmE7wRzMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7qzt/yNM1iwVtxi9d1+NouNM9az
        WqxcfZTJYu8tbYtDk5uZHFg9Lp8t9dh9s4HN4/2+q2wefVtWMXp83iQXwBqlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/H10DH2gjbPijlA4xoY
        F9t3MXJySAiYSExfvZKxi5GLQ0hgKaPE8kWnmSESMhInpzWwQtjCEn+udbGB2EICbxkl1h1N
        BrGFBbwkFh36wQJiiwgoSdy9u5odZBCzwHRGiR0n/rFCNExmlnh/0w3EZhMwlOh6CzGIV8BO
        YubLy+wgNouAisTfMxfBFosKxEks3zKfHaJGUOLkzCdgCzgFdCSW/Z4INpNZwExi3uaHzBC2
        vETz1tlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpec
        n7uJERhd24793LKDsetd8CFGAQ5GJR7ejIo/cUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxK
        LcqPLyrNSS0+xGgK9NxEZinR5Hxg5OeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamDs6BOLXX1c9euSOtYlecHGIs/Z6tmlfS9MOXrReVLNpMsNmu9CjITfZJ/w
        f9JorCJnt2r/QaUVwdm/k4SK8y7YHGM+XMe6feOc5hsxL6/EaLzdtJLvr6Lc6r5wcUZu62Od
        O2K4Jpin2KZHv5rYKsLEetxhynY/sy4WiZVGh5ycQuIfb7qw8ZQSS3FGoqEWc1FxIgAOHq4g
        xAIAAA==
X-CMS-MailID: 20200702101907eucas1p17c37bd206f8472fdff62ce30827b8664
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
References: <20200629094759.2002708-1-ming.lei@redhat.com>
        <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
        <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
        <20200701134512.GA2443512@T590>
        <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
        <20200702012231.GA2452799@T590>
        <1dd1fc85-fa46-29fd-5aaa-06f29440e8f4@samsung.com>
        <20200702092320.GD2452799@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 11:23, Ming Lei wrote:
> On Thu, Jul 02, 2020 at 10:04:38AM +0200, Marek Szyprowski wrote:
>> On 02.07.2020 03:22, Ming Lei wrote:
>>> On Wed, Jul 01, 2020 at 04:16:32PM +0200, Marek Szyprowski wrote:
>>>> On 01.07.2020 15:45, Ming Lei wrote:
>>>>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>>>>>> On 29.06.2020 11:47, Ming Lei wrote:
>>>>>>> It is natural to release driver tag when this request is completed by
>>>>>>> LLD or device since its purpose is for LLD use.
>>>>>>>
>>>>>>> One big benefit is that the released tag can be re-used quicker since
>>>>>>> bio_endio() may take too long.
>>>>>>>
>>>>>>> Meantime we don't need to release driver tag for flush request.
>>>>>>>
>>>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>>>>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>>>>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>>>>>> and then after a few seconds every executed command hangs. No
>>>>>> panic/ops/any other message. I will try to provide more information asap
>>>>>> I find something to share. Simple reverting it in linux-next is not
>>>>>> possible due to dependencies.
>>>>> What is the exact eMMC's driver code(include the host driver)?
>>>> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
>>> Hi,
>>>
>>> Just take a quick look at mmc code, there are only two req->tag
>>> consumers:
>>>
>>> 1) cqhci_tag
>>> cqhci_tag
>>> 	cqhci_request
>>> 		host->cqe_ops->cqe_request
>>> 			mmc_cqe_start_req
>>> 	cqhci_timeout
>>>
>>> 2) mmc_hsq_request
>>> mmc_hsq_request
>>> 	host->cqe_ops->cqe_request
>>> 		mmc_cqe_start_req
>>>
>>> mmc_cqe_start_req() is called before issuing this request to hardware,
>>> so completion won't happen when the tag is used in mmc_cqe_start_req().
>>>
>>> cqhci_timeout() may race with normal completion, however looks the
>>> following code can handle the race correctly:
>>>
>>>           spin_lock_irqsave(&cq_host->lock, flags);
>>>           timed_out = slot->mrq == mrq;
>>>
>>> So still no idea why the commit causes the trouble for mmc.
>>>
>>> Do you know it is cqhci or mmc_hsh which works for dw_mmc-exynos?
>>> And can you apply the following patch and see if warning can be
>>> triggered?
>>>
>>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>>> index 75934f3c117e..2cb49ecfbf34 100644
>>> --- a/drivers/mmc/host/cqhci.c
>>> +++ b/drivers/mmc/host/cqhci.c
>>> @@ -612,6 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>    		goto out_unlock;
>>>    	}
>>>    
>>> +	WARN_ON_ONCE(cq_host->slot[tag].mrq);
>>>    	cq_host->slot[tag].mrq = mrq;
>>>    	cq_host->slot[tag].flags = 0;
>>>    
>>> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
>>> index a5e05ed0fda3..11a4c1f3a970 100644
>>> --- a/drivers/mmc/host/mmc_hsq.c
>>> +++ b/drivers/mmc/host/mmc_hsq.c
>>> @@ -227,6 +227,7 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>    		return -EBUSY;
>>>    	}
>>>    
>>> +	WARN_ON_ONCE(hsq->slot[tag].mrq);
>>>    	hsq->slot[tag].mrq = mrq;
>>>    
>>>    	/*
>> None of the above is even compiled for my system (I'm using
>> arm/exynos_defconfig), so this must be something else.
> Hello Marek,
>
> Or can you boot the system with one workable disk(usb, nand, ...)?
> then run some IO test on this eMMC, and collect debugfs log via the following
> command after the hang is triggered:
>
> (cd /sys/kernel/debug/block/$MMC && find . -type f -exec grep -aH . {} \;)
>
> $MMC is this mmc disk name.

I have no physical access to this system now, but I managed to run a 
screen session just after the boot to have more than one shell. Here is 
the dump when the other shell locks:

# (cd /sys/kernel/debug/block/mmcblk0 && find . -type f -exec grep -aH . 
{} \;)
./hctx0/cpu7/completed:372 0
./hctx0/cpu7/merged:0
./hctx0/cpu7/dispatched:372 0
./hctx0/cpu6/completed:385 0
./hctx0/cpu6/merged:0
./hctx0/cpu6/dispatched:385 0
./hctx0/cpu5/completed:525 0
./hctx0/cpu5/merged:0
./hctx0/cpu5/dispatched:526 0
./hctx0/cpu4/completed:707 0
./hctx0/cpu4/merged:0
./hctx0/cpu4/dispatched:708 0
./hctx0/cpu3/completed:97 1
./hctx0/cpu3/merged:0
./hctx0/cpu3/dispatched:97 2
./hctx0/cpu2/completed:180 0
./hctx0/cpu2/merged:0
./hctx0/cpu2/dispatched:181 0
./hctx0/cpu1/completed:257 0
./hctx0/cpu1/merged:0
./hctx0/cpu1/dispatched:257 2
./hctx0/cpu0/completed:45 0
./hctx0/cpu0/merged:0
./hctx0/cpu0/dispatched:45 0
./hctx0/type:default
./hctx0/dispatch_busy:0
./hctx0/active:0
./hctx0/run:2126
./hctx0/queued:2575
./hctx0/dispatched:       0     6
./hctx0/dispatched:       1     2050
./hctx0/dispatched:       2     150
./hctx0/dispatched:       4     11
./hctx0/dispatched:       8     1
./hctx0/dispatched:      16     1
./hctx0/dispatched:      32+    1
./hctx0/io_poll:considered=0
./hctx0/io_poll:invoked=0
./hctx0/io_poll:success=0
./hctx0/sched_tags_bitmap:00000000: 0020 0000 1000 0000 0000 7000 0800 0000
./hctx0/sched_tags:nr_tags=128
./hctx0/sched_tags:nr_reserved_tags=0
./hctx0/sched_tags:active_queues=0
./hctx0/sched_tags:bitmap_tags:
./hctx0/sched_tags:depth=128
./hctx0/sched_tags:busy=6
./hctx0/sched_tags:cleared=40
./hctx0/sched_tags:bits_per_word=32
./hctx0/sched_tags:map_nr=4
./hctx0/sched_tags:alloc_hint={126, 78, 98, 35, 12, 83, 11, 21}
./hctx0/sched_tags:wake_batch=8
./hctx0/sched_tags:wake_index=0
./hctx0/sched_tags:ws_active=0
./hctx0/sched_tags:ws={
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:     {.wait_cnt=8, .wait=inactive},
./hctx0/sched_tags:}
./hctx0/sched_tags:round_robin=0
./hctx0/sched_tags:min_shallow_depth=4294967295
./hctx0/tags_bitmap:00000000: ffff ffff ffff ffff
./hctx0/tags:nr_tags=64
./hctx0/tags:nr_reserved_tags=0
./hctx0/tags:active_queues=0
./hctx0/tags:bitmap_tags:
./hctx0/tags:depth=64
./hctx0/tags:busy=64
./hctx0/tags:cleared=0
./hctx0/tags:bits_per_word=16
./hctx0/tags:map_nr=4
./hctx0/tags:alloc_hint={14, 0, 0, 0, 0, 0, 13, 22}
./hctx0/tags:wake_batch=8
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:   {.wait_cnt=8, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/ctx_map:00000000: 00
./hctx0/dispatch:35e4bf48 {.op=FLUSH, .cmd_flags=PREFLUSH, 
.rq_flags=FLUSH_SEQ, .state=idle, .tag=-1, .internal_tag=84}
./hctx0/flags:alloc_policy=FIFO SHOULD_MERGE|BLOCKING
./hctx0/state:SCHED_RESTART
./sched/starved:0
./sched/batching:1
./sched/write_fifo_list:ab51b2cc {.op=WRITE, 
.cmd_flags=META|PRIO|BACKGROUND, .rq_flags=ELVPRIV|IO_STAT|HASHED, 
.state=idle, .tag=-1, .internal_tag=85}
./sched/write_fifo_list:ac854e48 {.op=WRITE, 
.cmd_flags=META|PRIO|BACKGROUND, .rq_flags=ELVPRIV|IO_STAT|HASHED, 
.state=idle, .tag=-1, .internal_tag=86}
./sched/write_fifo_list:b12e714a {.op=WRITE, .cmd_flags=, 
.rq_flags=ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1, .internal_tag=36}
./sched/write_fifo_list:99383a87 {.op=WRITE, .cmd_flags=SYNC, 
.rq_flags=ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1, .internal_tag=99}
./sched/read_fifo_list:29365a9b {.op=READ, 
.cmd_flags=FAILFAST_DEV|FAILFAST_TRAag=-1, .internal_tag=13}AHEAD, 
.rq_flags=ELVPRIV|IO_STAT|HASHED, .state=idle, .ta
./write_hints:hint0: 0
./write_hints:hint1: 0
./write_hints:hint2: 0
./write_hints:hint3: 0
./write_hints:hint4: 0
./state:SAME_COMP|NONROT|IO_STAT|DISCARD|SECERASE|INIT_DONE|WC|FUA|REGISTERED
./pm_only:0
./poll_stat:read  (512 Bytes): samples=0
./poll_stat:write (512 Bytes): samples=0
./poll_stat:read  (1024 Bytes): samples=0
./poll_stat:write (1024 Bytes): samples=0
./poll_stat:read  (2048 Bytes): samples=0
./poll_stat:write (2048 Bytes): samples=0
./poll_stat:read  (4096 Bytes): samples=0
./poll_stat:write (4096 Bytes): samples=0
./poll_stat:read  (8192 Bytes): samples=0
./poll_stat:write (8192 Bytes): samples=0
./poll_stat:read  (16384 Bytes): samples=0
./poll_stat:write (16384 Bytes): samples=0
./poll_stat:read  (32768 Bytes): samples=0
./poll_stat:write (32768 Bytes): samples=0
./poll_stat:read  (65536 Bytes): samples=0
./poll_stat:write (65536 Bytes): samples=0
root@target:~#

I hope it helps.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


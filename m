Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1BC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 01:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379219AbiFQBk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQBk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 21:40:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787376353B
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 18:40:57 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPM9Q63XdzSgxx;
        Fri, 17 Jun 2022 09:37:30 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 09:40:12 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 09:40:11 +0800
Subject: Re: Races in sbitmap batched wakeups
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>
CC:     <linux-block@vger.kernel.org>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
Date:   Fri, 17 Jun 2022 09:40:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/06/17 1:21, Jan Kara Ð´µÀ:
> Hello!
> 
> I've been debugging some customer reports of tasks hanging (forever)
> waiting for free tags when in fact all tags are free. After looking into it
> for some time I think I know what it happening. First, keep in mind that
> it concerns a device which uses shared tags. There are 127 tags available
> and the number of active queues using these tags is easily 40 or more. So
> number of tags available for each device is rather small. Now I'm not sure
> how batched wakeups can ever work in such situations, but maybe I'm missing
> something.
> 
> So take for example a situation where two tags are available for a device,
> they are both currently used. Now a process comes into blk_mq_get_tag() and
> wants to allocate tag and goes to sleep. Now how can it ever be woken up if
> wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
> that's not enough to trigger the batched wakeup to really wakeup the
> waiter...
> 
> Even if we have say 4 tags available so in theory there should be enough
> wakeups to fill the batch, there can be the following problem. So 4 tags
> are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
> queue 0, one on wait queue 1. Now four IOs complete so
> sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
> wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
> waiters is woken up but the other one is still sleeping in wq1 and there
> are not enough wakeups to fill the batch and wake it up? This is
> essentially because we have lost three wakeups on wq0 because it didn't
> have enough waiters to wake...
Hi,

 From what I see, if tags are shared for multiple devices, wake_batch
should make sure that all waiter will be woke up:

For example:
there are total 64 tags shared for two devices, then wake_batch is 4(if
both devices are active).  If there are waiters, which means at least 32
tags are grabed, thus 8 queues will ensure to wake up at least once
after 32 tags are freed.

> 
> Finally, sbitmap_queue_wake_up() is racy and if two of them race together,
> they can end up decrementing wait_cnt of wq which does not have any process
> queued which again effectively leads to lost wakeups and possibly
> indefinitely sleeping tasks.
> 

BTW, I do this implementation have some problems on concurrent
scenario, as described in following patch:

https://lore.kernel.org/lkml/20220415101053.554495-4-yukuai3@huawei.com/

> Now this all looks so broken that I'm unsure whether I'm not missing
> something fundamental. Also I'm not quite sure how to fix all this without
> basically destroying the batched wakeup feature (but I didn't put too much
> thought to this yet). Comments?
> 
> 								Honza
> 

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 01:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiEPBIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 21:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiEPBIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 21:08:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1BE030
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 18:08:12 -0700 (PDT)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L1h1j00ytzhZ99;
        Mon, 16 May 2022 09:07:36 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 09:08:10 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 09:08:09 +0800
Subject: Re: [Libguestfs] Communication issues between NBD driver and NBDKit
 server
To:     "Richard W.M. Jones" <rjones@redhat.com>, <libguestfs@redhat.com>,
        <linux-block@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
 <20220515180525.GF8021@redhat.com> <87czgelidg.fsf@vostro.rath.org>
 <20220515192505.GJ1127@redhat.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1f37a75a-83b5-af8e-0dd3-6475652ab218@huawei.com>
Date:   Mon, 16 May 2022 09:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220515192505.GJ1127@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/16 3:25, Richard W.M. Jones wrote:
> On Sun, May 15, 2022 at 08:12:59PM +0100, Nikolaus Rath wrote:
>> Do you see any way for this to happen?
> 
> I think it's impossible.  A more likely explanation follows.
> 
> If you look at the kernel code, the NBD_CMD_INFLIGHT command flag is
> cleared when a command times out:
> 
>    https://github.com/torvalds/linux/blob/0cdd776ec92c0fec768c7079331804d3e52d4b27/drivers/block/nbd.c#L407
> 
> That's the place where it would have printed the "Possible stuck
> request" message.
> 
> Some time later, nbdkit actually replies to the message (for the first
> and only time) and in that code the flag is checked and found to be
> clear already, causing the "Suspicious reply" message to be printed:
Hi,

You are right, can you try the following patch?

https://lists.debian.org/nbd/2022/04/msg00212.html

Thanks,
Kuai
> 
>    https://github.com/torvalds/linux/blob/0cdd776ec92c0fec768c7079331804d3e52d4b27/drivers/block/nbd.c#L749
> 
> I'd say you need to increase the timeout and/or work out why the S3
> plugin is taking so long to respond.
> 
> Rich.
> 

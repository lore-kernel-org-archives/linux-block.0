Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9DC43463
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70A02100A
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 07:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIRH4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 03:56:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgIRH4B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 03:56:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C58304DCE8A35D27F22B;
        Fri, 18 Sep 2020 15:56:00 +0800 (CST)
Received: from [10.174.179.185] (10.174.179.185) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 15:55:56 +0800
Subject: Re: [PATCH 0/4] some improvements and clean-up for block
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <andy.lavr@gmail.com>
References: <20200918014706.1962485-1-yuyufen@huawei.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <3ca91ca7-bdf0-c645-a00e-24b288bdebf6@huawei.com>
Date:   Fri, 18 Sep 2020 15:55:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200918014706.1962485-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ignoring this patch set. There is a sloppy error in patch 2. I will resend the patch set.
Sorry for noise. Thanks for Andy Lavr to point the error.

On 2020/9/18 9:47, Yufen Yu wrote:
> Hi all,
> 
>    This series contains improvement for elevator exit, removing
>    wrong comments and clean-up code.
> 
> Yufen Yu (4):
>    block: invoke blk_mq_exit_sched no matter whether have .exit_sched
>    block: use common interface blk_queue_registered()
>    block: fix comment and add lockdep assert
>    block: get rid of unnecessary local variable
> 
>   block/blk-iocost.c |  2 +-
>   block/blk-sysfs.c  |  5 +----
>   block/elevator.c   | 19 ++++++-------------
>   3 files changed, 8 insertions(+), 18 deletions(-)
> 

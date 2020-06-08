Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E71BC433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 02:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2212067B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 02:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFHCj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:39:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbgFHCj0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 7 Jun 2020 22:39:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF6A217A2C65D4D49451;
        Mon,  8 Jun 2020 10:39:19 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.138) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 10:39:12 +0800
Subject: Re: [PATCH v2 0/2] loop: replace kill_bdev with invalidate_bdev
To:     <hch@infradead.org>, <axboe@kernel.dk>, <bvanassche@acm.org>,
        <jaegeuk@kernel.org>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <20200530114032.125678-1-zhengbin13@huawei.com>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <0857bafa-f7ba-dea9-3d5c-7889646b5a37@huawei.com>
Date:   Mon, 8 Jun 2020 10:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200530114032.125678-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.166.215.138]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2020/5/30 19:40, Zheng Bin wrote:
> v1->v2: modify comment, and make function 'kill_bdev' static
>
> Zheng Bin (2):
>    loop: replace kill_bdev with invalidate_bdev
>    block: make function 'kill_bdev' static
>
>   drivers/block/loop.c | 8 ++++----
>   fs/block_dev.c       | 5 ++---
>   include/linux/fs.h   | 2 --
>   3 files changed, 6 insertions(+), 9 deletions(-)
>
> --
> 2.21.3
>
>
> .
>


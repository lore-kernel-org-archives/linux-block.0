Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC96C433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 02:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66165207D1
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 02:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgL2CiS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 21:38:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10087 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgL2CiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 21:38:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4dpT57xSzMBhl;
        Tue, 29 Dec 2020 10:36:33 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 10:37:28 +0800
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com> <20201227115859.GA3282759@T590>
 <04c39621-0c4a-e593-5545-c4bd274c5fc2@huawei.com>
 <20201228082835.GB3304670@T590>
 <fce32e47-0e7d-39fa-611f-31ac0b422ba5@huawei.com>
 <20201229011517.GA3355551@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5204c625-a8f0-56c6-d10e-f40638084b97@huawei.com>
Date:   Tue, 29 Dec 2020 10:37:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201229011517.GA3355551@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

On 2020/12/29 9:15, Ming Lei wrote:
> Just wondering why you try to set 128 via sysfs for all disks? If you do that,
> you should know the potential result given the whole tags queue depth is just
> 128.

It's just a extreme example to show the unexpected result of "always
return true from hctx_may_queue()".

Thanks,
Yu Kuai

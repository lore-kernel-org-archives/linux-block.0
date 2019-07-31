Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A1C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 12:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCBA2089E
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfGaMBe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:01:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfGaMBe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 08:01:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AEF11CEE86DC22BCC0D7;
        Wed, 31 Jul 2019 20:01:27 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 20:01:22 +0800
Subject: Re: [PATCH] nbd: replace kill_bdev() with __invalidate_device() again
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <manoj.br@gmail.com>, <stable@vger.kernel.org>, <dwmw@amazon.com>
References: <1564542946-26255-1-git-send-email-sunke32@huawei.com>
 <20190731081536.GB3856@x250>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <46c8f7ba-1ada-f79e-4cf7-f75e59503787@huawei.com>
Date:   Wed, 31 Jul 2019 20:01:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731081536.GB3856@x250>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

OK, I will remove it.

ÔÚ 2019/7/31 16:15, Johannes Thumshirn Ð´µÀ:
> On Wed, Jul 31, 2019 at 11:15:46AM +0800, SunKe wrote:
>> CR: https://code.amazon.com/reviews/CR-7629288
> 
> Hi, this link isn't accessible for ordinary people, please remove it from the
> patch.
> 


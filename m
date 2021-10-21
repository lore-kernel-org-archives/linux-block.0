Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3DF611CE
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJUNPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:15:34 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26177 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJUNPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 09:15:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HZnv14Wskz8tqw;
        Thu, 21 Oct 2021 21:11:57 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 21:13:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 21 Oct 2021 21:13:12 +0800
Subject: Re: [PATCH 0/2] nbd: fix sanity check for first_minor
To:     Pavel Skripkin <paskripkin@gmail.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <luomeng12@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20211021122936.758221-1-yukuai3@huawei.com>
 <72fb140d-609b-c035-bdd6-d2b8639c116b@gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <17182476-e5bf-f493-9d9b-fedb2d9c8e1a@huawei.com>
Date:   Thu, 21 Oct 2021 21:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72fb140d-609b-c035-bdd6-d2b8639c116b@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/21 20:35, Pavel Skripkin wrote:
> On 10/21/21 15:29, Yu Kuai wrote:
>> Yu Kuai (2):
>>    nbd: fix max value for 'first_minor'
>>    nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
>>
>>   drivers/block/nbd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Hi, Yu!
> 
> Thank you for the fix, but this wrong check should be just removed, 
> since root case of wrong sysfs file creation was fixed, as Christoph 
> said [1]

Hi, Pavel

Thanks for your response, with the root cause fixed, patch 1 is not
needed anymore. However, the overflow case in patch 2 is still
possible.

Does anyone plan to remove the checking?

Thanks,
Kuai
> 
> 
> 
> 
> [1] https://lore.kernel.org/lkml/20211011073556.GA10735@lst.de/
> 
> 
> 
> With regards,
> Pavel Skripkin
> .
> 

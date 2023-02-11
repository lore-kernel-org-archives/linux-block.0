Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E873C636CC
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 03:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBKDqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 22:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKDqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 22:46:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796260E46
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 19:46:36 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PDGgC0L7MzRrwK;
        Sat, 11 Feb 2023 11:44:07 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Feb 2023 11:46:33 +0800
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
 <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
 <20230209095729.igkpj23afj6nbxxi@quack3>
 <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
 <20230209135830.a2lhdhnwzbu7uexe@quack3>
 <668bc362-263d-d9bc-a462-d8b851062ebc@huaweicloud.com>
 <20230210103117.hpmeqz6373smvchd@quack3>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <981958d4-01cd-54d2-b040-482d8bbf1f72@huawei.com>
Date:   Sat, 11 Feb 2023 11:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230210103117.hpmeqz6373smvchd@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/02/10 18:31, Jan Kara 写道:
> On Fri 10-02-23 09:58:36, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/02/09 21:58, Jan Kara 写道:
>>
>>> Sorry, I'm not sure what your are asking about here :) Can you please
>>> elaborate more?
>>
>>
>> It's another artificail race that will cause part scan fail in
>> device_add_disk().
>>
>> bdev_add() -> user can open the device now
>>
>> disk_scan_partitions -> will fail is the device is already opened
>> exclusively
>>
>> I'm thinking about set disk state before bdev_add()...
> 
> Oh, right. Yes, that should be a good fix to set GD_NEED_PART_SCAN before
> calling bdev_add().

Glad to here that 😀
> 
> 								Honza
> 

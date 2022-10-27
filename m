Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 02:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiJ0Ctx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJ0Ctw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 22:49:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB29345999
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 19:49:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MyVQD3SvRz15MBZ;
        Thu, 27 Oct 2022 10:44:52 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:49:45 +0800
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
 <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
 <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
Date:   Thu, 27 Oct 2022 10:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/26 21:01, Sagi Grimberg wrote:
> 
> 
> On 10/26/22 11:48, Chao Leng wrote:
>>> +
>>> +    if (set->flags & BLK_MQ_F_BLOCKING) {
>>> +        set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
>> Memory with contiguous physical addresses is not necessary, maybe it is a better choice to use kvmalloc,
>> because sizeof(*set->srcu) is a little large.
>> kvmalloc() is more friendly to scenarios where memory is insufficient and running for a long time.
> 
> Huh?
> 
> (gdb) p sizeof(struct srcu_struct)
> $1 = 392
I double recheck it. What I remember in my head is the old version of the size.
The size of the latest version is the size that you show.
Change the srcu_node array to a pointer in April 2022.
The link:
https://github.com/torvalds/linux/commit/2ec303113d978931ef368886c4c6bc854493e8bf

Therefore, kvmalloc() is a better choice for older versions.
For the latest version, static data member or kmalloc() are OK.

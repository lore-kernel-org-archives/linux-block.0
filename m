Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EAC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870D161CAD
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhF3JfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:35:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3331 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 05:35:03 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GFG464m7gz6H7qp;
        Wed, 30 Jun 2021 17:18:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 30 Jun 2021 11:32:32 +0200
Received: from [10.47.83.88] (10.47.83.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 10:32:32 +0100
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com> <YNu7rs7j5/KtQjAi@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <adf34d6d-b209-78d3-8df9-4e3398e34612@huawei.com>
Date:   Wed, 30 Jun 2021 10:25:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YNu7rs7j5/KtQjAi@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.88]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/06/2021 01:32, Ming Lei wrote:
>> Many block drivers don't use managed interrupts - to be proper, why not set
>> this everywhere (which doesn't use managed interrupts)? I know why, but it's
>> odd.
> It is just one small optimization in slow path for other drivers, not sure these
> drivers are interested in such change. It only serves as fix for callers of
> blk_mq_alloc_request_hctx().
> 
> Anyway, we can document the situation.
> 
>> As an alternative, if the default queue mapping was used (in
>> blk_mq_map_queues()), then that's the same thing as
>> BLK_MQ_F_NOT_USE_MANAGED_IRQ in reality, right? If so, could we
>> alternatively check for that somehow?
> This way can't work, for example of NVMe PCI, managed irq is used for
> the default/write queues, but poll queues uses blk_mq_map_queues().
> 
> Also it can't cover all cases, such as MVMe RDMA.
> 
> Using managed irq or not is thing of driver's choice, and not sure if it
> is good for block layer to provide such abstract. I'd suggest to fix the
> issue still by passing one flag, given we needn't it everywhere so far.

Sure, but I am just trying to suggest a more automatic way of passing 
this info. Like, for example, if we use blk_mq_pci_map_queues() on the 
qmap, then you prob want blk-mq managed interrupt support (for that 
qmap), i.e. CPU hotplug handlers.

Thanks,
John

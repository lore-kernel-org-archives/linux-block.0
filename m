Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9BC38A2D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 02:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ0Cqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJ0Cqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 22:46:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EFC8236
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 19:46:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MyVN83sY5zpW5s;
        Thu, 27 Oct 2022 10:43:04 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:46:30 +0800
Subject: Re: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-12-hch@lst.de>
 <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
 <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <969c8745-74e6-0b4e-b7f3-62bd7ee488d7@huawei.com>
Date:   Thu, 27 Oct 2022 10:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
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



On 2022/10/26 20:58, Sagi Grimberg wrote:
> 
>>> nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
>>> call nvme_dev_disable and unquiesce the I/O queues.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   drivers/nvme/host/pci.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index bef98f6e1396c..3a26c9b2bf454 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>>>       nvme_get_ctrl(&dev->ctrl);
>>>       nvme_dev_disable(dev, false);
>> Currently set the parameter "shutdown" to false, nvme_dev_disable() do not unquiesce the queues.
>> Actually we should set the parameter "shutdown" to true.
>>          nvme_dev_disable(dev, true);
> 
> But the final put will trigger nvme_remove no?
No, it do not trigger nvme_remove.
However, the controller is actually in deleting state.
Unquiescing the queues seems to be the better choice here.

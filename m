Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E545C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 08:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJJIqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJJIq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 04:46:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712135EDE3
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 01:46:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmC870VP2zVhqx;
        Mon, 10 Oct 2022 16:41:59 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:46:22 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
Date:   Mon, 10 Oct 2022 16:46:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220802133815.GA380@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/8/2 21:38, Christoph Hellwig wrote:
> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>> But maybe we can avoid that, and because we allocate
>> the connect_q ourselves, and fully know that it should
>> not be apart of the tagset quiesce, perhaps we can introduce
>> a new interface like:
>> --
>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>> {
>> 	ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>> 	if (IS_ERR(ctrl->connect_q))
>> 		return PTR_ERR(ctrl->connect_q);
>> 	return 0;
>> }
>> --
>>
>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>> self_quiesce flag and skip as needed.
> 
> I'd just make that a queue flag set after allocation to keep the
> interface simple, but otherwise this seems like the right thing
> to do.
Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
I review the code, only pci can not ensure secure stop/start pairing.
So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not PCI.
Do you think that's acceptable?
If that's acceptable, I will try to send a patch set.
> 
> .
> 

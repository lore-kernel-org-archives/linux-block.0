Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4970AC38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 01:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJYBra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiJYBrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 21:47:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886EA3B70
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 18:38:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxDxC1F39zmVJL;
        Tue, 25 Oct 2022 09:33:51 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:38:41 +0800
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
 <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
 <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <3e055ac9-7ab9-d9f4-9f07-b0a422b35967@huawei.com>
Date:   Tue, 25 Oct 2022 09:38:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/24 21:35, Bart Van Assche wrote:
> On 10/23/22 18:57, Chao Leng wrote:
>> blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
>> check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on concurrency.
> 
> Hi Chao,
> 
> I think it depends on how the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag is set. I agree if that flag is set once and never modified that there is no race. What I'm wondering about is whether there could be a need for block drivers to set the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag just before blk_mq_quiesce_tagset() is called and cleared immediately after blk_mq_quiesce_tagset() returns? In that case I think there is a race condition.
> 
Even if dynamically modify the QUEUE_FLAG_SKIP_TAGSET_QUIESCE, it still has no
impact on concurrency of blk_mq_quiesce_tagset(). It may affect atomicity of
blk_mq_quiesce_tagset(), blk_mq_quiesce_tagset() do not ensure atomicity, the caller
should ensure it if needed.

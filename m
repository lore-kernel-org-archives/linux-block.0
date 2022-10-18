Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4716C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJRJvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJRJvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:51:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C022B60D
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:51:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ms8Fk5HHhzJn2S;
        Tue, 18 Oct 2022 17:48:58 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:51:04 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <ming.lei@redhat.com>, <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
 <20221017134335.GA24959@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <50737260-4865-68f9-9bfe-a3de3d89f21d@huawei.com>
Date:   Tue, 18 Oct 2022 17:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017134335.GA24959@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/17 21:43, Christoph Hellwig wrote:
> On Thu, Oct 13, 2022 at 01:28:37PM +0300, Sagi Grimberg wrote:
>>> Because some queues never need to be quiesced(e.g. nvme connect_q).
>>> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
>>> skip the queue.
>>
>> I wouldn't say it never nor will ever quiesce, we just don't happen to
>> quiesce it today...
> 
> Yes.  It really is a QUEUE_FLAG_SKIP_TAGSET_QUIESCE.
I will modify it in patch V3.
> 
> 
> .
> 

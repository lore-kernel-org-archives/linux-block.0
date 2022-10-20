Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45EC43217
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 09:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJTJg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTJgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 05:36:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50516C239
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 02:36:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtMnL59VpzmVFl;
        Thu, 20 Oct 2022 17:32:06 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:36:22 +0800
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <paulmck@kernel.org>
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020063448.GA6246@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <6491f977-95f2-e40e-aa8b-d0671b517903@huawei.com>
Date:   Thu, 20 Oct 2022 17:36:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020063448.GA6246@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/20 14:34, Christoph Hellwig wrote:
> I though the conclusion from last round was to move the srcu_struct to
> the tagset?
If move the srcu_struct to the tagset, may loss the flexibility.
I am not sure that it is good for other modules currently using blk_mq_quiesce_queue.
Another, I am not sure if there will be a future scenario where blk_mq_quiesce_queue
will have to be used, and if it is good for such scenario.
It is a acceptable cost to allocate a temporary array for SRCU, the max memory size
is actually a few hundred KB, and most of the time it's less than a few KB.
So I did not move the srcu_struct to the tagset in patch V3.

It sounds like a good idea that explore moving the srcu_struct to the tag_set,
But we may need more time to analysis it.
I suggest that do the optimization in a separate patch set.
> 
> .
> 

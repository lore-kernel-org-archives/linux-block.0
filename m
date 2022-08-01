Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA8C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 01:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiHABqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiHABqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 21:46:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BB615E
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 18:45:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lx1BC47yczmV6B;
        Mon,  1 Aug 2022 09:44:03 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 09:45:57 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <9e9fa597-aab1-ca76-0ac6-e2bfafaa4c87@huawei.com>
Date:   Mon, 1 Aug 2022 09:45:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/7/31 18:23, Sagi Grimberg wrote:
> 
>>> Why can't we have a per-tagset quiesce flag and just wait for the
>>> one?  That also really nicely supports the problem with changes in
>>> the namespace list during that time.
>> Because If quiesce queues based on tagset, it is difficult to
>> distinguish non-IO queues. The I/O queues process is different
>> from other queues such as fabrics_q, admin_q, etc, which may cause
>> confusion in the code logic.
> 
> It is primarily the connect_q where we issue io queue connect...
> We should not quiesce the connect_q in nvme_stop_queues() as that
> relates to only namespaces queues.
Although we can do special processing for connect_q, fabrics_q, admin_q,
but this results in redundant semantics being implemented in
nvme_xxx_teardown_io_queues, these actions are confused for
nvme_xxx_teardown_admin_queue. It doesn't look clear.
Therefor, I think quiesceing queues based on namespaces is a better option.
In addition, I do not see the benefit of quiesceing queues based on tagset.
> 
> In the last attempt to do a tagset flag, we ended up having to do
> something like:
> -- 
> void nvme_stop_queues(struct nvme_ctrl *ctrl)
> {
>      blk_mq_quiesce_tagset(ctrl->tagset);
>      if (ctrl->connect_q)
>          blk_mq_unquiesce_queue(ctrl->connect_q);
> }
> EXPORT_SYMBOL_GPL(nvme_stop_queues);
> -- 
> 
> But maybe we can avoid that, and because we allocate
> the connect_q ourselves, and fully know that it should
> not be apart of the tagset quiesce, perhaps we can introduce
> a new interface like:
> -- 
> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
> {
>      ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>      if (IS_ERR(ctrl->connect_q))
>          return PTR_ERR(ctrl->connect_q);
>      return 0;
> }
> -- 
> 
> And then blk_mq_quiesce_tagset can simply look into a per request-queue
> self_quiesce flag and skip as needed.
> .

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE86C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2361547
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhKQIml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:42:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27141 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhKQImg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 03:42:36 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HvGWW3Wsdz1DJRF;
        Wed, 17 Nov 2021 16:37:11 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 16:39:34 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 17 Nov 2021 16:39:33 +0800
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
To:     Bart Van Assche <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <damien.lemoal@wdc.com>, <axboe@kernel.dk>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-block@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <houtao1@huawei.com>
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
 <59cb2cfd-3890-9fb4-9e77-a4b084d088e9@acm.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <03421fa2-fa48-3452-743b-d9cabefc58df@huawei.com>
Date:   Wed, 17 Nov 2021 16:39:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <59cb2cfd-3890-9fb4-9e77-a4b084d088e9@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/11/17 12:11, Bart Van Assche wrote:
> On 11/16/21 19:37, yangerkun wrote:
>> This commit add blk_mq_freeze_queue in elevator_init_mq which try to
>> make sure no in-flight request while we go through blk_mq_init_sched.
>> But does there any drivers can leave IO alive while we go through
>> elevator_init_mq？ And if no, maybe we can just remove this logical to
>> fix the regression...
> 
> Does this untested patch help? Please note that I'm not recommending to
> integrate this patch in the upstream kernel but if it helps it can be a
> building block of a solution.
> 
> Thanks,
> 
> Bart.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ab34c4f20da..b85dcb72a579 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -167,6 +167,7 @@ void blk_freeze_queue_start(struct request_queue *q)
>           mutex_unlock(&q->mq_freeze_lock);
>           if (queue_is_mq(q))
>               blk_mq_run_hw_queues(q, false);
> +        synchronize_rcu_expedited();
>       } else {
>           mutex_unlock(&q->mq_freeze_lock);
>       }
> .

Sorry for that it's blk_mq_quiesce_queue which actually introduce the 
RCU gap... I have try synchronize_rcu_expedited in blk_mq_quiesce_queue 
which seems useless...

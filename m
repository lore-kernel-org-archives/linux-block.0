Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF1C433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C9C20738
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCMAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:00:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgFCMAl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 08:00:41 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8ED93C327E73F3D3C7B3;
        Wed,  3 Jun 2020 13:00:40 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Jun 2020
 13:00:39 +0100
Subject: Re: [PATCH 1/1] blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE
 in blk_mq_get_tag()
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hare@suse.de>, <dwagner@suse.de>,
        <ming.lei@redhat.com>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200602061749.32029-1-dongli.zhang@oracle.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2114e1a8-253b-9ad7-0991-afc15df365bd@huawei.com>
Date:   Wed, 3 Jun 2020 12:59:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200602061749.32029-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.59]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/06/2020 07:17, Dongli Zhang wrote:
> When scheduler is set, we hit below page fault when we offline cpu.
> 
> [ 1061.007725] BUG: kernel NULL pointer dereference, address: 0000000000000040
> [ 1061.008710] #PF: supervisor read access in kernel mode
> [ 1061.009492] #PF: error_code(0x0000) - not-present page
> [ 1061.010241] PGD 0 P4D 0
> [ 1061.010614] Oops: 0000 [#1] SMP PTI
> [ 1061.011130] CPU: 0 PID: 122 Comm: kworker/0:1H Not tainted 5.7.0-rc7+ #2'
> ... ...
> [ 1061.013760] Workqueue: kblockd blk_mq_run_work_fn
> [ 1061.014446] RIP: 0010:blk_mq_put_tag+0xf/0x30
> ... ...
> [ 1061.017726] RSP: 0018:ffffa5c18037fc70 EFLAGS: 00010287
> [ 1061.018475] RAX: 0000000000000000 RBX: ffffa5c18037fcf0 RCX: 0000000000000004
> [ 1061.019507] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff911535dc1180
> ... ...
> [ 1061.028454] Call Trace:
> [ 1061.029307]  blk_mq_get_tag+0x26e/0x280
> [ 1061.029866]  ? wait_woken+0x80/0x80
> [ 1061.030378]  blk_mq_get_driver_tag+0x99/0x110
> [ 1061.031009]  blk_mq_dispatch_rq_list+0x107/0x5e0
> [ 1061.031672]  ? elv_rb_del+0x1a/0x30
> [ 1061.032178]  blk_mq_do_dispatch_sched+0xe2/0x130
> [ 1061.032844]  __blk_mq_sched_dispatch_requests+0xcc/0x150
> [ 1061.033638]  blk_mq_sched_dispatch_requests+0x2b/0x50
> [ 1061.034239]  __blk_mq_run_hw_queue+0x75/0x110
> [ 1061.034867]  process_one_work+0x15c/0x370
> [ 1061.035450]  worker_thread+0x44/0x3d0
> [ 1061.035980]  kthread+0xf3/0x130
> [ 1061.036440]  ? max_active_store+0x80/0x80
> [ 1061.037018]  ? kthread_bind+0x10/0x10
> [ 1061.037554]  ret_from_fork+0x35/0x40
> [ 1061.038073] Modules linked in:
> [ 1061.038543] CR2: 0000000000000040
> [ 1061.038962] ---[ end trace d20e1df7d028e69f ]---
> 
> This is because blk_mq_get_driver_tag() would be used to allocate tag once
> scheduler (e.g., mq-deadline) is set. 

I tried mq-deadline and I did not see this. Anyway else special or 
specific about your test?

However, I see other issues for that (setting the scheduler), that being 
scsi timeouts when I start running IO and hotplugging CPUs. I should 
have tested the scheduler != none previously for "blk-mq: improvement 
CPU hotplug (simplified version) " series ...

I'll check Ming's patch "[PATCH] blk-mq: don't fail driver tag 
allocation because of inactive hctx" for that.

Thanks,
John

However, in order to handle
> BLK_MQ_S_INACTIVE in blk_mq_get_tag(), we need to set data->ctx for
> blk_mq_put_tag().
> 
> Fixes: bf0beec0607db3c6 ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> This is based on for-next because currently the pull request for v5.8 is
> not picked by mainline.
> 
>   block/blk-mq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9a36ac1c1fa1..8bf6c06a86c1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1056,6 +1056,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>   {
>   	struct blk_mq_alloc_data data = {
>   		.q = rq->q,
> +		.ctx = rq->mq_ctx,
>   		.hctx = rq->mq_hctx,
>   		.flags = BLK_MQ_REQ_NOWAIT,
>   		.cmd_flags = rq->cmd_flags,
> 


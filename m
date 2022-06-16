Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14CEC43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 08:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359549AbiFPICq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 04:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359413AbiFPICp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 04:02:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3AAE52
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 01:02:43 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNvm86tHMz689QX;
        Thu, 16 Jun 2022 16:02:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 10:02:41 +0200
Received: from [10.126.172.137] (10.126.172.137) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:02:40 +0100
Message-ID: <ca16d940-ba6d-798f-3b21-28f29b223adf@huawei.com>
Date:   Thu, 16 Jun 2022 09:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] block: Fix handling of offline queues in
 blk_mq_alloc_request_hctx()
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "Ming Lei" <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20220615210004.1031820-1-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220615210004.1031820-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.172.137]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/06/2022 22:00, Bart Van Assche wrote:
> This patch prevents that test nvme/004 triggers the following:
> 
> UBSAN: array-index-out-of-bounds in block/blk-mq.h:135:9
> index 512 is out of range for type 'long unsigned int [512]'
> Call Trace:
>   show_stack+0x52/0x58
>   dump_stack_lvl+0x49/0x5e
>   dump_stack+0x10/0x12
>   ubsan_epilogue+0x9/0x3b
>   __ubsan_handle_out_of_bounds.cold+0x44/0x49
>   blk_mq_alloc_request_hctx+0x304/0x310
>   __nvme_submit_sync_cmd+0x70/0x200 [nvme_core]
>   nvmf_connect_io_queue+0x23e/0x2a0 [nvme_fabrics]
>   nvme_loop_connect_io_queues+0x8d/0xb0 [nvme_loop]
>   nvme_loop_create_ctrl+0x58e/0x7d0 [nvme_loop]
>   nvmf_create_ctrl+0x1d7/0x4d0 [nvme_fabrics]
>   nvmf_dev_write+0xae/0x111 [nvme_fabrics]
>   vfs_write+0x144/0x560
>   ksys_write+0xb7/0x140
>   __x64_sys_write+0x42/0x50
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7a5558bbc7f6..1c09c6017ea9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -579,6 +579,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
>   	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		goto out_queue_exit;

Ming, Did you give up on this:

https://lore.kernel.org/linux-block/20210818144428.896216-1-ming.lei@redhat.com/

Thanks,
John

>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
>   	if (!q->elevator)
> .


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34CBC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 08:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIVIsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIVIrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 04:47:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D106AEB4
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 01:47:14 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MY80x0x80z6HJ5M;
        Thu, 22 Sep 2022 16:42:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:47:11 +0200
Received: from [10.195.244.8] (10.195.244.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 09:47:11 +0100
Message-ID: <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
Date:   Thu, 22 Sep 2022 09:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220920021724.1841850-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.8]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/09/2022 03:17, Ming Lei wrote:
> For avoiding to trigger io timeout when one hctx becomes inactive, we
> drain IOs when all CPUs of one hctx are offline. However, driver's
> timeout handler may require cpus_read_lock, such as nvme-pci,
> pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> and irq_build_affinity_masks() needs cpus_read_lock().
> 
> Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> is held, so deadlock is caused.
> 
> Fixes the issue by breaking the wait loop if enough long time elapses,
> and these in-flight not drained IO still can be handled by timeout
> handler.

I don't think that that this is a good idea - that is because often 
drivers cannot safely handle scenario of timeout of an IO which has 
actually completed. NVMe timeout handler may poll for completion, but 
SCSI does not.

Indeed, if we were going to allow the timeout handler handle these 
in-flight IO then there is no point in having this hotplug handler in 
the first place.

> 
> Cc: linux-nvme@lists.infradead.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..4585985b8537 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3301,6 +3301,7 @@ static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
>   	return true;
>   }
>   
> +#define BLK_MQ_MAX_OFFLINE_WAIT_MSECS 3000

That's so low compared to default SCSI sd timeout.

>   static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> @@ -3326,8 +3327,13 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   	 * frozen and there are no requests.
>   	 */
>   	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> -		while (blk_mq_hctx_has_requests(hctx))
> +		unsigned int wait_ms = 0;
> +
> +		while (blk_mq_hctx_has_requests(hctx) && wait_ms <
> +				BLK_MQ_MAX_OFFLINE_WAIT_MSECS) {
>   			msleep(5);
> +			wait_ms += 5;
> +		}
>   		percpu_ref_put(&hctx->queue->q_usage_counter);
>   	}
>   

Thanks,
John

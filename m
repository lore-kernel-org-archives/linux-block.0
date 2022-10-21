Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F93C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 02:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUCuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUCuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:50:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182F17587
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:50:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mtplr2L9SzDsKj;
        Fri, 21 Oct 2022 10:47:20 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:50:00 +0800
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <07131141-71a4-4e44-c31d-4de6d1bda9e3@huawei.com>
Date:   Fri, 21 Oct 2022 10:50:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-8-hch@lst.de>
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> This helper is pretty pointless now, and also in the way of per-tagset
> quiesce.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7fdb744979c..0ab3a18fd9f85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   		blk_mq_wait_quiesce_done(ns->queue->tag_set);
>   }
>   
> -/*
> - * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch.
> - */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> -{
> -	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
> -
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list)
> -			nvme_set_queue_dying(ns);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			blk_mark_disk_dead(ns->disk);
> +			nvme_start_ns_queue(ns);
> +		}
>   	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
> 

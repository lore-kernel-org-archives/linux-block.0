Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58094C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJUBx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJUBxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:53:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1D158180
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:53:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtnYP3g5zzHv7B;
        Fri, 21 Oct 2022 09:53:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:53:21 +0800
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e3ab9d31-7a9e-4bad-9a04-1f20845c6268@huawei.com>
Date:   Fri, 21 Oct 2022 09:53:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.  Note that this follows the xen-blkfront version that does
> not send and uevent as the uevent is a bit confusing when the device is
> about to go away a little later, and the the size change is just to stop
> buffered writes faster.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                | 3 +++
>   drivers/block/xen-blkfront.c | 1 -
>   drivers/nvme/host/core.c     | 7 +------
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..2877b5f905579 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
>   {
>   	set_bit(GD_DEAD, &disk->state);
>   	blk_queue_start_drain(disk->queue);
> +
> +	/* stop buffered writers from dirtying pages that can't written out */
> +	set_capacity(disk, 0);
>   }
>   EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>   
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 35b9bcad9db90..b28489290323f 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2129,7 +2129,6 @@ static void blkfront_closing(struct blkfront_info *info)
>   	if (info->rq && info->gd) {
>   		blk_mq_stop_hw_queues(info->rq);
>   		blk_mark_disk_dead(info->gd);
> -		set_capacity(info->gd, 0);
>   	}
>   
>   	for_each_rinfo(info, rinfo, i) {
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..44a5321743128 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5106,10 +5106,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   /*
>    * Prepare a queue for teardown.
>    *
> - * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
> - * the capacity to 0 after that to avoid blocking dispatchers that may be
> - * holding bd_butex.  This will end buffered writers dirtying pages that can't
> - * be synced.
> + * This must forcibly unquiesce queues to avoid blocking dispatch.
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
> @@ -5118,8 +5115,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>   
>   	blk_mark_disk_dead(ns->disk);
>   	nvme_start_ns_queue(ns);
> -
> -	set_capacity_and_notify(ns->disk, 0);
>   }
>   
>   /**
> 

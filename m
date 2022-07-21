Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B5FC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 12:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiGUMMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiGUMM1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 08:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67AED863D2
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658405545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8MHABTPbxx3BGnBlN9Cx5R8uzpVbWvZekDjhk6Y+bs=;
        b=fpnRsLB4n/qEQr4O190j5o+adQVmRfKBlYwD5tSAOkAw7tFxJvtz1DP5EwWcaGxYX0hjEc
        DwJDA0XFE2sMeNVFem1OzSaGE/DTLa8CfZd9OVXiLsXU8RlQ0Ix8zXT+8ibFEO0AeYo2/T
        7qQDRSm71q9xUZ5lD2THJC8GR7NHE9E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-LxCR2fN5M0adCAM331STbQ-1; Thu, 21 Jul 2022 08:12:17 -0400
X-MC-Unique: LxCR2fN5M0adCAM331STbQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 194873C01D92;
        Thu, 21 Jul 2022 12:12:17 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 894C4401E7B;
        Thu, 21 Jul 2022 12:12:14 +0000 (UTC)
Date:   Thu, 21 Jul 2022 20:12:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] ublk: cleanup ublk_ctrl_uring_cmd
Message-ID: <YtlCmV4YuHegwiGX@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:29AM +0200, Christoph Hellwig wrote:
> Move all per-command work into the per-command ublk_ctrl_* helpers
> instead of being split over those, ublk_ctrl_cmd_validate, and the main
> ublk_ctrl_uring_cmd handler.  To facilitate that, the old
> ublk_ctrl_stop_dev function that just contained two function calls is
> folded into both callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/ublk_drv.c | 234 +++++++++++++++++++--------------------
>  1 file changed, 116 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1f7bbbc3276a2..af70c18796e70 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -813,13 +813,6 @@ static void ublk_stop_dev(struct ublk_device *ub)
>  	cancel_delayed_work_sync(&ub->monitor_work);
>  }
>  
> -static int ublk_ctrl_stop_dev(struct ublk_device *ub)
> -{
> -	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->stop_work);
> -	return 0;
> -}
> -
>  static inline bool ublk_queue_ready(struct ublk_queue *ubq)
>  {
>  	return ubq->nr_io_ready == ubq->q_depth;
> @@ -1205,8 +1198,8 @@ static int ublk_add_dev(struct ublk_device *ub)
>  
>  static void ublk_remove(struct ublk_device *ub)
>  {
> -	ublk_ctrl_stop_dev(ub);
> -
> +	ublk_stop_dev(ub);
> +	cancel_work_sync(&ub->stop_work);
>  	cdev_device_del(&ub->cdev, &ub->cdev_dev);
>  	put_device(&ub->cdev_dev);
>  }
> @@ -1227,36 +1220,45 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
>  	return ub;
>  }
>  
> -static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
> +static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
>  {
>  	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
> -	int ret = -EINVAL;
>  	int ublksrv_pid = (int)header->data[0];
>  	unsigned long dev_blocks = header->data[1];
> +	struct ublk_device *ub;
> +	int ret = -EINVAL;
>  
>  	if (ublksrv_pid <= 0)
> -		return ret;
> +		return -EINVAL;
> +
> +	ub = ublk_get_device_from_id(header->dev_id);
> +	if (!ub)
> +		return -EINVAL;
>  
>  	wait_for_completion_interruptible(&ub->completion);
>  
>  	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
>  
>  	mutex_lock(&ub->mutex);
> -	if (!disk_live(ub->ub_disk)) {
> -		/* We may get disk size updated */
> -		if (dev_blocks) {
> -			ub->dev_info.dev_blocks = dev_blocks;
> -			ublk_update_capacity(ub);
> -		}
> -		ub->dev_info.ublksrv_pid = ublksrv_pid;
> -		ret = add_disk(ub->ub_disk);
> -		if (!ret)
> -			ub->dev_info.state = UBLK_S_DEV_LIVE;
> -	} else {
> +	if (disk_live(ub->ub_disk)) {
>  		ret = -EEXIST;
> +		goto out_unlock;
>  	}
> -	mutex_unlock(&ub->mutex);
>  
> +	/* We may get disk size updated */
> +	if (dev_blocks) {
> +		ub->dev_info.dev_blocks = dev_blocks;
> +		ublk_update_capacity(ub);
> +	}
> +	ub->dev_info.ublksrv_pid = ublksrv_pid;
> +	ret = add_disk(ub->ub_disk);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +out_unlock:
> +	mutex_unlock(&ub->mutex);
> +	ublk_put_device(ub);
>  	return ret;
>  }
>  
> @@ -1281,6 +1283,13 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
>  	unsigned long queue;
>  	unsigned int retlen;
>  	int ret = -EINVAL;
> +	
> +	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
> +		return -EINVAL;
> +	if (header->len & (sizeof(unsigned long)-1))
> +		return -EINVAL;
> +	if (!header->addr)
> +		return -EINVAL;
>  
>  	ub = ublk_get_device_from_id(header->dev_id);
>  	if (!ub)
> @@ -1311,38 +1320,64 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
>  	return ret;
>  }
>  
> -static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_dev_info *info,
> -		void __user *argp, int idx)
> +static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
>  {
> +	pr_devel("%s: dev id %d flags %llx\n", __func__,
> +			info->dev_id, info->flags[0]);
> +	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
> +			info->nr_hw_queues, info->queue_depth,
> +			info->block_size, info->dev_blocks);
> +}
> +
> +static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
> +{
> +	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
> +	void __user *argp = (void __user *)(unsigned long)header->addr;
> +	struct ublksrv_ctrl_dev_info info;
>  	struct ublk_device *ub;
> -	int ret;
> +	int ret = -EINVAL;
> +
> +	if (header->len < sizeof(info) || !header->addr)
> +		return -EINVAL;
> +	if (header->queue_id != (u16)-1) {
> +		pr_warn("%s: queue_id is wrong %x\n",
> +			__func__, header->queue_id);
> +		return -EINVAL;
> +	}
> +	if (copy_from_user(&info, argp, sizeof(info)))
> +		return -EFAULT;
> +	ublk_dump_dev_info(&ub->dev_info);

The above line should have been ublk_dump_dev_info(&info), otherwise
looks fine:

Reviewed-by: Ming Lei <ming.lei@rehdat.com>

Thanks,
Ming


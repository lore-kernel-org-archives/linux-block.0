Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE51C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiKRKD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRKD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 05:03:58 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DC220D5
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 02:03:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VV4z6YF_1668765833;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VV4z6YF_1668765833)
          by smtp.aliyun-inc.com;
          Fri, 18 Nov 2022 18:03:54 +0800
Message-ID: <9512a7d2-8109-95bd-ba88-f6256b0ea292@linux.alibaba.com>
Date:   Fri, 18 Nov 2022 18:03:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/6] ublk_drv: don't probe partitions if the ubq daemon
 isn't trusted
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20221116060835.159945-1-ming.lei@redhat.com>
 <20221116060835.159945-3-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221116060835.159945-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/16 14:08, Ming Lei wrote:
> If any ubq daemon is unprivileged, the ublk char device is allowed
> for unprivileged user, and we can't trust the current user, so not
> probe partitions.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index fe997848c1ff..a5f3d8330be5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -149,6 +149,7 @@ struct ublk_device {
>  
>  #define UB_STATE_OPEN		0
>  #define UB_STATE_USED		1
> +#define UB_STATE_PRIVILEGED	2
>  	unsigned long		state;
>  	int			ub_number;
>  
> @@ -161,6 +162,7 @@ struct ublk_device {
>  
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
> +	unsigned int		nr_privileged_daemon;
>  
>  	/*
>  	 * Our ubq->daemon may be killed without any notification, so
> @@ -1184,9 +1186,15 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  		ubq->ubq_daemon = current;
>  		get_task_struct(ubq->ubq_daemon);
>  		ub->nr_queues_ready++;
> +
> +		if (capable(CAP_SYS_ADMIN))
> +			ub->nr_privileged_daemon++;
>  	}
> -	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
> +	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
> +		if (ub->nr_privileged_daemon == ub->nr_queues_ready)

Hi, Ming.

Just like nr_queues_ready, ub->nr_privileged_daemon should be reset
to zero in ublk_ctrl_start_recovery(). otherwise new ubq_daemons are
always treated as unprivileged.

> +			set_bit(UB_STATE_PRIVILEGED, &ub->state);
>  		complete_all(&ub->completion);
> +	}
>  	mutex_unlock(&ub->mutex);
>  }
>  
> @@ -1540,6 +1548,10 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
>  	if (ret)
>  		goto out_put_disk;
>  
> +	/* don't probe partitions if any one ubq daemon is un-trusted */
> +	if (!test_bit(UB_STATE_PRIVILEGED, &ub->state))
> +		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);

Can we simply check if nr_queues_ready == nr_privileged_daemon here
instead of adding a new bit UB_STATE_PRIVILEGED?

BTW, I think exposing whether ub's state is privileged/unprivileged
to users(./ublk list) is a good idea.

Regards,
Zhang

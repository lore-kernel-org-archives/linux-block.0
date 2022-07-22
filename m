Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF5C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 02:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiGVC7E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGVC7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 22:59:04 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D59965A
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 19:59:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK3N472_1658458739;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK3N472_1658458739)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 10:59:00 +0800
Message-ID: <5bb0cf22-fee8-e5fd-8f8b-93c866e522f0@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 10:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ublk_drv: move destroying device out of ublk_add_dev
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20220722023638.601667-1-ming.lei@redhat.com>
 <20220722023638.601667-2-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220722023638.601667-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 10:36, Ming Lei wrote:
> ublk_device is allocated in ublk_ctrl_add_dev(), so code will become more
> readable by just letting ublk_ctrl_add_dev() destroy ublk_device in case
> of ublk_add_dev() failure.
> 
> Meantime ub->mutex is destroyed in __ublk_destroy_dev(), but it may
> not be initialized when ublk_add_dev() fails, so fix it by moving
> mutex_init(ub->mutex) before any failure path.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f058f40b639c..d03563286c76 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1106,9 +1106,10 @@ static int ublk_add_dev(struct ublk_device *ub)
>  
>  	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
>  	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
> +	mutex_init(&ub->mutex);
>  
>  	if (ublk_init_queues(ub))
> -		goto out_destroy_dev;
> +		return err;
>  
>  	ub->tag_set.ops = &ublk_mq_ops;
>  	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
> @@ -1122,7 +1123,6 @@ static int ublk_add_dev(struct ublk_device *ub)
>  		goto out_deinit_queues;
>  
>  	ublk_align_max_io_size(ub);
> -	mutex_init(&ub->mutex);
>  	spin_lock_init(&ub->mm_lock);
>  
>  	/* add char dev so that ublksrv daemon can be setup */
> @@ -1130,8 +1130,6 @@ static int ublk_add_dev(struct ublk_device *ub)
>  
>  out_deinit_queues:
>  	ublk_deinit_queues(ub);
> -out_destroy_dev:
> -	__ublk_destroy_dev(ub);
>  	return err;
>  }
>  
> @@ -1331,8 +1329,10 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	ub->dev_info.dev_id = ub->ub_number;
>  
>  	ret = ublk_add_dev(ub);
> -	if (ret)
> +	if (ret) {
> +		__ublk_destroy_dev(ub);
>  		goto out_unlock;
> +	}

Hi, Ming.

Now, if ublk_add_dev() returns failure, __ublk_destroy_dev() is called anyway.

However, in current ublk_drv:ublk_add_dev():

...
	return ublk_add_chdev(ub);   <---- here
out_deinit_queues:
	ublk_deinit_queues(ub);
out_destroy_dev:
	__ublk_destroy_dev(ub);
	return err;


ublk_add_chdev() returns and the returned value(maybe a failure) directly
pass to ublk_ctrl_add_dev which does NOT call __ublk_destroy_dev()

please check it is correct to call __ublk_destroy_dev() if ublk_add_chdev() fails.


>  
>  	if (copy_to_user(argp, &ub->dev_info, sizeof(info))) {
>  		ublk_remove(ub);

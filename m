Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C9C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiKRJCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbiKRJCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 04:02:47 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3D697DD
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 01:02:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VV4mPZG_1668762160;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VV4mPZG_1668762160)
          by smtp.aliyun-inc.com;
          Fri, 18 Nov 2022 17:02:41 +0800
Message-ID: <e1347b5d-68d2-d434-4b1c-90a196a93e07@linux.alibaba.com>
Date:   Fri, 18 Nov 2022 17:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/6] ublk_drv: remove nr_aborted_queues from ublk_device
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20221116060835.159945-1-ming.lei@redhat.com>
 <20221116060835.159945-2-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221116060835.159945-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/16 14:08, Ming Lei wrote:
> No one uses 'nr_aborted_queues' any more, so remove it.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f96cb01e9604..fe997848c1ff 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -161,7 +161,6 @@ struct ublk_device {
>  
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
> -	atomic_t		nr_aborted_queues;
>  
>  	/*
>  	 * Our ubq->daemon may be killed without any notification, so

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

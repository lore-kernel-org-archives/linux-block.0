Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D3FA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 03:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJaDOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 23:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJaDOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 23:14:14 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539629589
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 20:14:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VTPA6NZ_1667186050;
Received: from 30.97.56.208(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VTPA6NZ_1667186050)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 11:14:11 +0800
Message-ID: <0f792bf5-f6fb-ea35-6f52-a6445b401edf@linux.alibaba.com>
Date:   Mon, 31 Oct 2022 11:14:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] ublk: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in
 case of module
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20221029010432.598367-1-ming.lei@redhat.com>
 <20221029010432.598367-2-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221029010432.598367-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/29 09:04, Ming Lei wrote:
> UBLK_F_URING_CMD_COMP_IN_TASK needs to be set and returned to userspace
> if ublk driver is built as module, otherwise userspace may get wrong
> flags shown.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 5afce6ffaadf..6b2f214f0d5c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1658,6 +1658,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	 */
>  	ub->dev_info.flags &= UBLK_F_ALL;
>  
> +	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
> +		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
> +
>  	/* We are not ready to support zero copy */
>  	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
>

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
  

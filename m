Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E2DFA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 03:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJaDQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 23:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJaDQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 23:16:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A459589
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 20:16:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VTPA778_1667186188;
Received: from 30.97.56.208(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VTPA778_1667186188)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 11:16:29 +0800
Message-ID: <3bbaa473-7481-1e2b-dde7-f7fea421b352@linux.alibaba.com>
Date:   Mon, 31 Oct 2022 11:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] ublk_drv: comment on ublk_driver entry of Kconfig
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20221029010432.598367-1-ming.lei@redhat.com>
 <20221029010432.598367-3-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221029010432.598367-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/29 09:04, Ming Lei wrote:
> Add help info for choosing to build ublk_drv as module or builtin.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index db1b4b202646..a41145d52de9 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -408,6 +408,12 @@ config BLK_DEV_UBLK
>  	  definition isn't finalized yet, and might change according to future
>  	  requirement, so mark is as experimental now.
>  
> +	  Say Y if you want to get better performance because task_work_add()
> +	  can be used in IO path for replacing io_uring cmd, which will become
> +	  shared between IO tasks and ubq daemon, meantime task_work_add() can
> +	  can handle batch more effectively, but task_work_add() isn't exported
> +	  for module, so ublk has to be built to kernel.
> +
>  source "drivers/block/rnbd/Kconfig"
>  
>  endif # BLK_DEV

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

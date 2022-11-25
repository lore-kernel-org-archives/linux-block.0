Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9263BC4332F
	for <linux-block@archiver.kernel.org>; Fri, 25 Nov 2022 07:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKYHOG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKYHOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:06 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7A22B33
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 23:14:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVe6UNA_1669360441;
Received: from 30.97.56.205(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VVe6UNA_1669360441)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 15:14:02 +0800
Message-ID: <2ec739a3-f7ba-0e97-0df6-0d198c6689b5@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 15:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH V2 4/6] ublk_drv: add device parameter
 UBLK_PARAM_TYPE_DEVT
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
 <20221124030454.476152-5-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221124030454.476152-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/24 11:04, Ming Lei wrote:
> Userspace side only knows device ID, but the associated path of ublkc* and
> ublkb* could be changed by udev, and that depends on userspace's policy, so
> add parameter of UBLK_PARAM_TYPE_DEVT for retrieving major/minor of the
> ublkc* and ublkb*, then user may figure out major/minor of the ublk disks
> he/she owns. With major/minor, it is easy to find the device node path.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 24 +++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h | 13 +++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9d1578384cba..04a28a2f2e1f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -54,7 +54,8 @@
>  		| UBLK_F_USER_RECOVERY_REISSUE)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
> +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> +		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
>  
>  struct ublk_rq_data {
>  	struct llist_node node;
> @@ -255,6 +256,10 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  			return -EINVAL;
>  	}
>  
> +	/* dev_t is read-only */
> +	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
> +		WARN_ON_ONCE(1);
Hi, Ming

ublk_validate_params() is only called by ublk_ctrl_set_params().
Why not return -EINVAL here since UBLK_PARAM_TYPE_DEVT is not
allowed in ublk_ctrl_set_params(). Then the user may know he has
made a mistake.

Regards,
Zhang

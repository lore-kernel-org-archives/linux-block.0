Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99AC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B45121726
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAWO12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:27:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbfAWO12 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 09:27:28 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D185B66AC3E76BEC59AE;
        Wed, 23 Jan 2019 22:27:24 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 22:27:14 +0800
Subject: Re: [PATCH] block: Add secure discard check in blk_ioctl_discard
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <zhaohongjiang@huawei.com>,
        <yangerkun@huawei.com>
References: <1545716663-123177-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <614c3753-a1a0-4982-e2d3-e1490b36ce0f@huawei.com>
Date:   Wed, 23 Jan 2019 22:27:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545716663-123177-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping?

On 2018/12/25 13:44, zhengbin wrote:
> blkdev_ioctl--->blk_ioctl_discard(BLKDISCARD or BLKSECDISCARD).
> If cmd is BLKSECDISCARD and device does not support this cmd,
> we will drop page cache(should not be dropped) and return
> EOPNOTSUPP to caller. This patch fixes that.
> 
> Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  block/ioctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4825c78..ee3a6af 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -212,6 +212,11 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  	if (!blk_queue_discard(q))
>  		return -EOPNOTSUPP;
> 
> +	if (flags & BLKDEV_DISCARD_SECURE) {
> +		if (!blk_queue_secure_erase(q))
> +			return -EOPNOTSUPP;
> +	}
> +
>  	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
>  		return -EFAULT;
> 
> --
> 2.7.4
> 
> 
> .
> 


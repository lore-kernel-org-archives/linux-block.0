Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59246C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D81C233A1
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfIDIky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:40:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728950AbfIDIky (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 04:40:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A32C6476AA5510B9486;
        Wed,  4 Sep 2019 16:40:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 16:40:43 +0800
Subject: Re: [PATCH v2] paride/pcd: need to set queue to NULL before put_disk
To:     <tim@cyberelk.net>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>
References: <1565695660-13459-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <9b6086dd-ddfe-acfe-0d83-34c1b3351bac@huawei.com>
Date:   Wed, 4 Sep 2019 16:40:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1565695660-13459-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2019/8/13 19:27, zhengbin wrote:
> In pcd_init_units, if blk_mq_init_sq_queue fails, need to set queue to
> NULL before put_disk, otherwise null-ptr-deref Read will occur.
>
> put_disk
>   kobject_put
>     disk_release
>       blk_put_queue(disk->queue)
>
> Fixes: f0d176255401 ("paride/pcd: Fix potential NULL pointer dereference and mem leak")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/block/paride/pcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
> index 001dbdc..bfca80d 100644
> --- a/drivers/block/paride/pcd.c
> +++ b/drivers/block/paride/pcd.c
> @@ -314,8 +314,8 @@ static void pcd_init_units(void)
>  		disk->queue = blk_mq_init_sq_queue(&cd->tag_set, &pcd_mq_ops,
>  						   1, BLK_MQ_F_SHOULD_MERGE);
>  		if (IS_ERR(disk->queue)) {
> -			put_disk(disk);
>  			disk->queue = NULL;
> +			put_disk(disk);
>  			continue;
>  		}
>
> --
> 2.7.4
>
>
> .
>


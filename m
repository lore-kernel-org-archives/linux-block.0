Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068EC352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9AD20848
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgBKNPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:15:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728958AbgBKNPk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 08:15:40 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20DB77D8FE978E7D8852;
        Tue, 11 Feb 2020 21:15:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 21:15:29 +0800
Subject: Re: [PATCH] block: genhd: skip blk_register_region() for disk using
 ext-dev
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
References: <20191111014946.54533-1-houtao1@huawei.com>
Message-ID: <47ca3cc9-35bf-6474-f4b5-6e95e94d27b5@huawei.com>
Date:   Tue, 11 Feb 2020 21:15:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20191111014946.54533-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2019/11/11 9:49, Hou Tao wrote:
> It doesn't incur any harm now when the range parameter of
> blk_register_region() is zero, but let's skip the useless call of
> blk_register_region() for disk which uses ext-dev.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/genhd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 26b31fcae217..c61b59b550b0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -739,8 +739,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  		ret = bdi_register_owner(disk->queue->backing_dev_info,
>  						disk_to_dev(disk));
>  		WARN_ON(ret);
> -		blk_register_region(disk_devt(disk), disk->minors, NULL,
> -				    exact_match, exact_lock, disk);
> +		if (disk->minors)
> +			blk_register_region(disk_devt(disk), disk->minors, NULL,
> +						exact_match, exact_lock, disk);
>  	}
>  	register_disk(parent, disk, groups);
>  	if (register_queue)
> 


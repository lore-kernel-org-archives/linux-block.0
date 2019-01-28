Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44CC282CB
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD3521736
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfA1JQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:16:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfA1JQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 04:16:31 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 792099CA54E2D762EE73;
        Mon, 28 Jan 2019 17:16:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 17:16:20 +0800
Subject: Re: [PATCH] floppy: check_events callback should not return a
 negative number
To:     Yufen Yu <yuyufen@huawei.com>, <axboe@kernel.dk>, <osandov@fb.com>
References: <20190128090646.44747-1-yuyufen@huawei.com>
CC:     <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a1de9b80-4fdf-4996-7362-e77a1386b0d9@huawei.com>
Date:   Mon, 28 Jan 2019 17:16:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190128090646.44747-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/1/28 17:06, Yufen Yu wrote:
> Since .check_events interface return an unsigned int value,
> floppy_check_events() should not return a negative error number.
> Otherwise, disk_check_events() may process wiht an unexpected path.

A typo, wiht --> with

> 
> fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")

fixes should be Fixes

> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/block/floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 6f2856c6d0f2..55481b40df9a 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4075,7 +4075,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
>  
>  	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
>  		if (lock_fdc(drive))
> -			return -EINTR;
> +			return 0;
>  		poll_drive(false, 0);
>  		process_fd_request();
>  	}
> 


Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3639C4151A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2A21773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfBLKvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:51:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfBLKvK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 05:51:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAB9AAAAF1E757B9687F;
        Tue, 12 Feb 2019 18:51:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 18:51:00 +0800
Subject: Re: [PATCH v2] floppy: check_events callback should not return a
 negative number
From:   yuyufen <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <dan.carpenter@oracle.com>
CC:     <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20190129083404.47318-1-yuyufen@huawei.com>
Message-ID: <15d715cf-0a6a-158e-a264-96baa890697c@huawei.com>
Date:   Tue, 12 Feb 2019 18:50:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190129083404.47318-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?


On 2019/1/29 16:34, Yufen Yu wrote:
> floppy_check_events() is supposed to return bit flags to say which
> events occured. We should return zero to say that no event flags are
> set.  Only BIT(0) and BIT(1) are used in the caller. And .check_events
> interface also expect to return an unsigned int value.
>
> However, after commit a0c80efe5956, it may return -EINTR (-4u).
> Here, both BIT(0) and BIT(1) are cleared. So this patch shouldn't
> affect runtime, but it obviously is still worth fixing.
>
> Fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   drivers/block/floppy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 6f2856c6d0f2..55481b40df9a 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4075,7 +4075,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
>   
>   	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
>   		if (lock_fdc(drive))
> -			return -EINTR;
> +			return 0;
>   		poll_drive(false, 0);
>   		process_fd_request();
>   	}



Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E7C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 04:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A456F20707
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 04:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgHZEPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:15:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1229 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgHZEPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 00:15:45 -0400
X-IronPort-AV: E=Sophos;i="5.76,354,1592841600"; 
   d="scan'208";a="98554170"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Aug 2020 12:15:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5376348990C7;
        Wed, 26 Aug 2020 12:15:43 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 26 Aug 2020 12:15:42 +0800
Subject: Re: [PATCH] loop: Set correct device size when using LOOP_CONFIGURE
To:     Martijn Coenen <maco@android.com>, <mzxreary@0pointer.de>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <hch@lst.de>
References: <20200825071829.1396235-1-maco@android.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <9adbdec2-6e3c-bf3c-4df3-bd205d85ff46@cn.fujitsu.com>
Date:   Wed, 26 Aug 2020 12:15:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825071829.1396235-1-maco@android.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 5376348990C7.AB16C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martijn

Look good to me. feel free to add  tested-by tag.
Also, I have sent a patch to ltp to test this. as below
https://patchwork.ozlabs.org/project/ltp/patch/1598415126-9703-1-git-send-email-xuyang2018.jy@cn.fujitsu.com/

Best Regards
Yang Xu

> The device size calculation was done before processing the loop
> configuration, which meant that the we set the size on the underlying
> block device incorrectly in case lo_offset/lo_sizelimit were set in the
> configuration. Delay computing the size until we've setup the device
> parameters correctly.
> 
> Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")
> Reported-by: Lennart Poettering <mzxreary@0pointer.de>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>   drivers/block/loop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 2f137d6ce169..fbda14840d8e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1111,8 +1111,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>   	mapping = file->f_mapping;
>   	inode = mapping->host;
>   
> -	size = get_loop_size(lo, file);
> -
>   	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
>   		error = -EINVAL;
>   		goto out_unlock;
> @@ -1162,6 +1160,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>   	loop_update_rotational(lo);
>   	loop_update_dio(lo);
>   	loop_sysfs_init(lo);
> +
> +	size = get_loop_size(lo, file);
>   	loop_set_size(lo, size);
>   
>   	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
> 



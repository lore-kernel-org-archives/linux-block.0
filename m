Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2BAC64ED8
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 22:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB0WTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 17:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB0WTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 17:19:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C27B442;
        Mon, 27 Feb 2023 14:19:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC26B80D9A;
        Mon, 27 Feb 2023 22:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74BC433D2;
        Mon, 27 Feb 2023 22:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677536359;
        bh=DffVitN1qqJ/O6j0J/Uwi0+9w5FwRcfgoO+QggDfE+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPJvE4tfPCAa6BrUw1orRTd0vrH/+XF9z9rVX63o77jQ8KGpYglSNXkawMQLMjq2P
         gkF64RkB9FO4OCCydu6Z0WcwJUIQy7P/ugGHi136eswJeYsl8vWMxkHpVP8Z1rR9PS
         ePVGVO8au8DLJ+tMFsViGq/5mRIjjTVUX8ZRgbfA=
Date:   Mon, 27 Feb 2023 14:19:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix 32-bit atomic_long_t print
Message-Id: <20230227141918.cc6ef681c32d79778595d06b@linux-foundation.org>
In-Reply-To: <20230227085629.2362316-1-arnd@kernel.org>
References: <20230227085629.2362316-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 27 Feb 2023 09:56:21 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The type used to print &pool_stats.objs_moved is inconsistent with the
> definition:
> 
> drivers/block/zram/zram_drv.c: In function 'mm_stat_show':
> drivers/block/zram/zram_drv.c:1234:44: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> Change the printing code to match.
> 
> Fixes: b7d89654a988 ("zram: show zsmalloc objs_moved stat in mm_stat")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3194e9254c6f..5c4ac0d3e850 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1231,7 +1231,7 @@ static ssize_t mm_stat_show(struct device *dev,
>  			atomic_long_read(&pool_stats.pages_compacted),
>  			(u64)atomic64_read(&zram->stats.huge_pages),
>  			(u64)atomic64_read(&zram->stats.huge_pages_since),
> -			(u64)atomic64_read(&pool_stats.objs_moved));
> +			(u64)atomic_long_read(&pool_stats.objs_moved));
>  	up_read(&zram->init_lock);
>  
>  	return ret;

Thanks.  I'm using the slightly different fix from Geert:

https://lkml.kernel.org/r/20230225121523.3288544-1-geert+renesas@glider.be

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D8EC4707C
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F53613AF
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 17:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhEURp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbhEURp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 13:45:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98DC061574;
        Fri, 21 May 2021 10:44:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a7so2674224plh.3;
        Fri, 21 May 2021 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4QkVSOOszVdWrPvz94pBsy6ZfYgC+/HXfwmVhL8xGw=;
        b=TwWyEx5iTKVucRdNH6zhy2eSM0O1FrCPfAxQkDrk0ThM1Cp0fCpPRmM+d0Kq0ylVgP
         8+xwoes439gAgC/wh4YVGUgMZ6xB00ur0bjG+vKWPE5lNKXh+8OfhaoYaqxuRinnGn/e
         72he3zYpVjns46fabfxVp2qaYW6kaPzy9BGXwcmfY8JgBxRY9jundRjINv4zQfBYJjS1
         wvycUl8Lgq6/5Z7o7fJqwj7BlcX9XUfkrD14vKpKvWo55uscLIWyAJr70gg4xwT5N3Y6
         qz60aIpna76PH8RsNyPgbNuQDDPvb3Pn4Jnwb4Alk7oI3gyW2jiztvCc4D1xLZWrVqkq
         oO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o4QkVSOOszVdWrPvz94pBsy6ZfYgC+/HXfwmVhL8xGw=;
        b=fZI6xtFceQJMe24dDFclGC09fhOp+rpqJTwRK/s9XWAqYa724ZeG0JL/k7u9P1ZuPO
         p2UfeKyabWpcPV902u3v+okOGXzS+14yB6qBh7Pibs40H/j6Sh2FQzsMvEzEr6AJjoNp
         1O24fy/u8RL/o71gHAmk9WTH00HwxyzjsZV5CshmHMm7t1Ekug11iOGRjpwvuTwDulOM
         sU4AVdSlFONg2xGEI71MSwoPZGPOofYGp0w790gpGRSg6JomYHVTJuwv7Zqdc+mu5XI9
         1OE57ummSlPB2rTxAed6X4H+NElc/jfZPokljv3Er7cHZDQfAMCmDeZMRUcdpd3KL6U0
         CVoA==
X-Gm-Message-State: AOAM5310qrjqoTBtdUbIpbyZPugqALJEts8MlREFj9Qe+cb4zpmolMq2
        hibUFSw5nPmfL3U928iMUsQ=
X-Google-Smtp-Source: ABdhPJwCvHRA3jCLNwvQyiOuvcz8bWdjIu8uz7Jx0o+d/sOcGZUFarfKrJPz7v8dynGbUF7uIhRs7Q==
X-Received: by 2002:a17:902:d2ce:b029:f4:4a5:9a8b with SMTP id n14-20020a170902d2ceb02900f404a59a8bmr13159671plc.70.1621619074605;
        Fri, 21 May 2021 10:44:34 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2a07:5416:42d3:6c55])
        by smtp.gmail.com with ESMTPSA id p6sm4681894pfh.166.2021.05.21.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:44:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 21 May 2021 10:44:32 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>, akpm@linux-foundation.org
Cc:     ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH][RESEND] zram: move backing_dev under macro
 CONFIG_ZRAM_WRITEBACK
Message-ID: <YKfxgGe6evFf7dr+@google.com>
References: <20210521060544.2385-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521060544.2385-1-zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 02:05:44PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> backing_dev is never used when not enable CONFIG_ZRAM_WRITEBACK and
> it's introduced from writeback feature. So it's needless also affect
> readability in that case.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Andrew, could you pick?

> ---
>  drivers/block/zram/zram_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 419a7e8..6e73dc3 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -113,8 +113,8 @@ struct zram {
>  	 * zram is claimed so open request will be failed
>  	 */
>  	bool claim; /* Protected by bdev->bd_mutex */
> -	struct file *backing_dev;
>  #ifdef CONFIG_ZRAM_WRITEBACK
> +	struct file *backing_dev;
>  	spinlock_t wb_limit_lock;
>  	bool wb_limit_enable;
>  	u64 bd_wb_limit;
> -- 
> 1.9.1
> 

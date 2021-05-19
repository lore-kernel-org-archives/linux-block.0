Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7CC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 19:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289A76135A
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhEST5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhEST5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 15:57:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C82C06175F;
        Wed, 19 May 2021 12:56:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so2446557plf.7;
        Wed, 19 May 2021 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q6qp+y0b7E4RD0dE7eFD/KyO3v3EYWq2TwYTARfgrfo=;
        b=DJsaMMymn/AhkUuHSDxlHhqe6L1wpqni/4qxPEFK282dnjxtLxeTs7zg8X9ZO57/x0
         iRIKvqif7q2Ce/Yapiez9RQf/Grxafr7DccqRAvwhrpC1PPXEq24ZXHebPu7g527pcX5
         oWNtY5zaIWNiEHOZt/vZw3EvyOTss8jvestBlCzJhZ7tIPU9nAVBiWMCWIVsAV179kdp
         Yv6T3YqJi5IJknSJLWsr+KkWkUqi+in6nFXy5kaDNM1mFCcuesBiJOkRA/qZNb0FAcDx
         Y9x77YbYrIVdyraHNzQ/F9h0evU88JAkVZcZTlljSuTDPl0NZdvwzUAkJaXY1bqu6HmH
         FQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q6qp+y0b7E4RD0dE7eFD/KyO3v3EYWq2TwYTARfgrfo=;
        b=YEkZHmw3SK4jeqBThjSUiqzG6/8/NjHAlxPuEIaJOdjfuTSRuP82xglKoHfrrBoHBD
         vm4+e9wdLO3WcQO5wKngjMH4ZfOOcZ2KwIjeeOxkW1UA610rY5txKfNQUlNjGr11e0K0
         EnAgK6Qdh7lX3kDXvdOIEnWP3BIfNzyTxjeXL4402VJr8aQZa+SCpIrYhyk0bOEY6zGP
         JzEIu4HfGvKitiw6Z9Y0oVjXxt01Sifg7e98pZDmcxgxWezf6UNQ3c1rUQ2W5ekHsrMR
         RsIQmgc/Mw7zfagXE8cYnTg1IZlnhEolkjvb7Zs4+6J04OUCPkA5XtbZ6BrL2G+TnAZt
         A2ng==
X-Gm-Message-State: AOAM53217GC6SKNPbLaexaTel+7WqM2nUMvdf0JmgZ7glS14BK19Rb2x
        YQymXSBmBhfbMeXdkNNvLxc=
X-Google-Smtp-Source: ABdhPJyZO5fAGR+vKyFVigDGtIUNgQqvvxyxqJhBPAITxMffW5yyiMGetXScTcimnzBCwgwngeZb7w==
X-Received: by 2002:a17:90a:55c5:: with SMTP id o5mr644852pjm.191.1621454179762;
        Wed, 19 May 2021 12:56:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4102:f4c7:9246:e6c4])
        by smtp.gmail.com with ESMTPSA id i20sm161597pgb.38.2021.05.19.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:56:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 19 May 2021 12:56:17 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] zram: avoid disksize setting when device is being
 claimed
Message-ID: <YKVtYfOM3RkS3gQh@google.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <20210423011108.11988-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423011108.11988-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 01:11:06AM +0000, Luis Chamberlain wrote:
> As with other areas of the zram diver, check if the zram
> block device is being claimed but do it early to avoid
> trying to set something up for a zram device which may
> be on its way out.

I guess you're talking about zram_remove race with disksize_store.
Please add some code sequence diagram like previous patch, which
makes thing more clear.

Otherwise, looks good to me.

> 
> This doesn't fix a known crash, however the potential for
> an issue issue is found through code inspection.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 431b60cd85c1..6051d20b88c3 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1729,7 +1729,7 @@ static ssize_t disksize_store(struct device *dev,
>  
>  	mutex_lock(&zram_index_mutex);
>  
> -	if (!zram_up) {
> +	if (!zram_up || zram->claim) {
>  		err = -ENODEV;
>  		goto out;
>  	}
> -- 
> 2.27.0
> 

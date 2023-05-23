Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE6C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjEWRAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEWRAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:00:04 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CB18F
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:59:04 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-62383441211so32208656d6.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861143; x=1687453143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwRGjqJkSXRPJHHzQwuRJHCwrUdQwcyQ9byVzjawyEc=;
        b=FSR5jEdOsl0j8RIEJVhzC0EvFeEP4gbVddyK8Yf/3+HUFp8Sc6L4Q6BGnXsG0Aqycj
         rCxcSxdufiFmqVe0jZ9wiYu6Ed7/R3JcdO/dMyXfOm1kHnDJcIzeSHpJ0HzXMEbOGwUu
         dU+InKpRZ57WE+U50XtINSkbi3DLIa5PrsUV8yqvWD+zMp+LIJIJp7t/WuJHotKl+mSg
         DvRiRe3aORaKU9fdAKDd+LtdPvOdn3ZoLY+J4XoQ9zxhr8jr/X658k+yuBvvVuaI7x5p
         tzbapJMz7wrx+TkSfyvWrVOQSlL/7bCB098I3ntjvpcoWz5QIJ2ptX6EA5lIiteMxVh+
         3PAw==
X-Gm-Message-State: AC+VfDzAQ5dk3BOW5q3tu23rrYJ4Yw3/WZxAfhSk/Yo3/qdSjGgN86w1
        5sxZqjBNZXMxX7ra5WxE4WBt
X-Google-Smtp-Source: ACHHUZ7KDQ2Jp5KWH/08+Nowc+ZerVbKYaqFsCmja4tNY6veUp3xnJBwfILDlwQLmRkuu4hWo14WpA==
X-Received: by 2002:ad4:5742:0:b0:621:64c7:235f with SMTP id q2-20020ad45742000000b0062164c7235fmr24446598qvx.27.1684861143301;
        Tue, 23 May 2023 09:59:03 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id x19-20020ae9f813000000b00759333a57adsm2666246qkh.11.2023.05.23.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:59:02 -0700 (PDT)
Date:   Tue, 23 May 2023 12:59:01 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 20/24] dm: only call early_lookup_bdev from early boot
 context
Message-ID: <ZGzw1c60WJBTNclC@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-21-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> early_lookup_bdev is supposed to only be called from the early boot
> code, but dm_get_device calls it as a general fallback when lookup_bdev
> fails, which is problematic because early_lookup_bdev bypasses all normal
> path based permission checking, and might cause problems with certain
> container environments renaming devices.
> 
> Switch to only call early_lookup_bdev when dm is built-in and the system
> state in not running yet.  This means it is still available when tables
> are constructed by dm-init.c from the kernel command line, but not
> otherwise.
> 
> Note that this strictly speaking changes the kernel ABI as the PARTUUID=
> and PARTLABEL= style syntax is now not available during a running
> systems.  They never were intended for that, but this breaks things
> we'll have to figure out a way to make them available again.  But if
> avoidable in any way I'd rather avoid that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-table.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index e997f4322a9967..c230241a76b374 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -326,8 +326,11 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
>  /*
>   * Add a device to the list, or just increment the usage count if
>   * it's already present.
> + *
> + * Note: the __ref annotation is because this function can call the __init
> + * marked early_lookup_bdev when called during early boot code from dm-init.c.
>   */
> -int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
> +int __ref dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  		  struct dm_dev **result)
>  {
>  	int r;
> @@ -346,8 +349,10 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  			return -EOVERFLOW;
>  	} else {
>  		r = lookup_bdev(path, &dev);
> -		if (r)
> +#ifndef MODULE
> +		if (r && system_state < SYSTEM_RUNNING)
>  			r = early_lookup_bdev(path, &dev);
> +#endif
>  		if (r)
>  			return -ENODEV;
>  	}
> -- 
> 2.39.2
> 

I think/hope this will be fine:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

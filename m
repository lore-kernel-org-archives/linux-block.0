Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D2C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8560B64FC4
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 21:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCJV0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:26:04 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44280 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCJVZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 16:25:38 -0500
Received: by mail-pg1-f172.google.com with SMTP id t37so1448795pga.11;
        Wed, 10 Mar 2021 13:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ms44mDQ7A9dmdKDge0JZIY094AcGXA8nwHblvXeaCyw=;
        b=SBxhnzVC+/NlrE6ONydbTQrH/u6qKKfUY+Uwuvc50ieuX/Kg7gi9KqgFoQldzj/snb
         +UzHWIHTdLYde99F7KKjilwx6oFy0MIWmc3Pn48i7FJnMoQoHDTsmDgHoxIrNZ/xH0j1
         FvaYICg2VBtCNrL8Slch+Uuz1bMRH0N6u3z/xs1Y7Tdx0meRy1MIRTle4GSAeYVMDmF5
         epYNSR7NwuygeDMZ0KHyvPq+PFrTVZjYqMX6VgIDeU5J/3Vh38JYQ9VwtTWSt3MZj98b
         R58K1B1gugQn4CgGHadXJaLH2SCdxm5KWetZ9mtbR64g4zw8pbZLSugLN6f88jR/Y/sq
         y+5Q==
X-Gm-Message-State: AOAM5314KqxM6hMeHAGMYJ9axPDgMYfDjhxDYCXfTfB8ZLTFHwZejW4W
        oKtH7zjtjIWXUstxvTQ6/Wg=
X-Google-Smtp-Source: ABdhPJwLsuwjD3NN9UlISpyn/BdzcALDlE7ZEIEbT3k9ljxnv+MXLA/1jO8yZ/TYtR97mlMP3YU3ig==
X-Received: by 2002:a05:6a00:22d6:b029:1cb:35ac:d8e0 with SMTP id f22-20020a056a0022d6b02901cb35acd8e0mr4504555pfj.17.1615411538334;
        Wed, 10 Mar 2021 13:25:38 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q184sm389753pfc.78.2021.03.10.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:25:37 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 635A34024E; Wed, 10 Mar 2021 21:25:36 +0000 (UTC)
Date:   Wed, 10 Mar 2021 21:25:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210310212536.GQ13911@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310131115.GQ4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310131115.GQ4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 10, 2021 at 01:11:15PM +0000, Luis Chamberlain wrote:
> I can try to modify it to include second patch first, as that is
> required. There are two separate bugs here.

I tried this, applying the syfs required changes first and then
applying your idea as a secondary patch ends up like this:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4b57c84ba9d4..bb45c1e0f3e0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1702,6 +1702,7 @@ static void zram_reset_device(struct zram *zram)
 
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
+	module_put(THIS_MODULE);
 
 	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
@@ -1747,6 +1748,7 @@ static ssize_t disksize_store(struct device *dev,
 		goto out_free_meta;
 	}
 
+	BUG_ON(!try_module_get(THIS_MODULE));
 	zram->comp = comp;
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);

The BUG_ON() is doable as we *know* we already have a reference to the
module due to the beginning of the other try_module_get() which would
be placed on the first patch at the top of disksize_store().

This however doesn't fix the issue. We end up in a situation where we
cannot unload the zram driver.

  Luis

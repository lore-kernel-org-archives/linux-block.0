Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68671C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 23:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FB1217D4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 23:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="H3JxqQFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAVX3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:29:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVX3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 18:29:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so157503pfi.5
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 15:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FjeXgZyteMMNJ6FNddYRfn8Rbsze0sdjcX/f6Wy+i8=;
        b=H3JxqQFYrqAdBrqoUDPmyanGoA7waPQekzvXnH+DjjUnsbHheNkhPOT8sB3fLbAqrM
         yflNJ5dQye2+Gc5jHAHPh3p9FtWE9fovE+vcBrzZe0qt04DCbQJraJIag+k05Tg26Z9c
         swsTAD/URngT49Zz8oCaIV92olpA2Nz3YRTSIvwQ3JEPUVrGXTw6mwC/oWQJNPFnkt5F
         MMw/bQe2ygS9d3QmqBFArx6KN92KZANndjSWL/+rYmqx6GmQVcBXqdZ1HpyJvIc6KF0+
         +Pjnwa/75yF/nK8iZgpo+HBjg1rtlKUjNUg3Cbobd7993AMKKB8x8u1DHUhpors81ppp
         UEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FjeXgZyteMMNJ6FNddYRfn8Rbsze0sdjcX/f6Wy+i8=;
        b=T7bVeuQt+VAfiLSLUpX+vX01cW2Lyx42OmmIpA7qxJZ79ETVlPOSc+AbbIVXnaLSek
         dwb193XeHIOqKU4ATaTXXl0W4YvuC9C8+djPIGdbUTcoZZVVXk4lLPBMI/h2orPKUFYu
         +q8a4QeUmLviCJT6jYTtg1hXV+kFocvjL+UVzd0UJG6pKJEUbYoivf+KqdgRXGAivfYO
         RgWVURSFfpUqw1fBH0kATvPo+06I6opw4u2Fb48nC1PmhoQc2kY5ONtFwPvPkjEJKv8P
         XJEFJ1nu3xDLbet+TmS3jWlkGjwfCg8YZj/46iXkYf1PfwbjrhLF7iWLawOCRtnb4vwx
         rDGQ==
X-Gm-Message-State: AJcUukcwoD5RNEmZe962Zuiw57AswGy2JGytc1Hd6aUCHu08amRVLR8J
        TQqsFl/zWR7R23S1tk0wDL7LJQ==
X-Google-Smtp-Source: ALg8bN7dzD/hGYQEB+RQ8O6LQTLftgeX87lPdAE9GZueCzRJ94M1phN0vRiQARYatYgb7tsarszKsQ==
X-Received: by 2002:a63:1204:: with SMTP id h4mr33862365pgl.51.1548199775330;
        Tue, 22 Jan 2019 15:29:35 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:930f])
        by smtp.gmail.com with ESMTPSA id b202sm26758835pfb.88.2019.01.22.15.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:29:34 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:29:33 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: no need to check return value of
 debugfs_create functions
Message-ID: <20190122232933.GC5884@vader>
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:04PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: "Ed L. Cashin" <ed.cashin@acm.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/block/aoe/aoeblk.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index e2c6aae2d636..b602646bfa04 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -207,14 +207,7 @@ aoedisk_add_debugfs(struct aoedev *d)
>  	else
>  		p++;
>  	BUG_ON(*p == '\0');
> -	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
> -				    &aoe_debugfs_fops);
> -	if (IS_ERR_OR_NULL(entry)) {
> -		pr_info("aoe: cannot create debugfs file for %s\n",
> -			d->gd->disk_name);
> -		return;
> -	}
> -	BUG_ON(d->debugfs);
> +	debugfs_create_file(p, 0444, aoe_debugfs_dir, d, &aoe_debugfs_fops);
>  	d->debugfs = entry;

Now entry is uninitialized here when we assign it to d->debugfs.

>  }
>  void
> @@ -472,10 +465,6 @@ aoeblk_init(void)
>  	if (buf_pool_cache == NULL)
>  		return -ENOMEM;
>  	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
> -	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
> -		pr_info("aoe: cannot create debugfs directory\n");
> -		aoe_debugfs_dir = NULL;
> -	}
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D19C433FE
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AE06139E
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 18:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhJDSaz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbhJDSaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 14:30:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD1C061749;
        Mon,  4 Oct 2021 11:29:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so565904pjb.1;
        Mon, 04 Oct 2021 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksk0ituITPDur7VOi1jCXxieV8Du5TeIguFZkpAVdZs=;
        b=iccVLZIu59DB5VPOrdxx0bcJFMS/iGHtuLWCAMdKR/gBUXElbZvJTn6B5bMYOsrHnZ
         xuWo7RKx36K5p+IvSTKGNUw3YM2W1xLIucrR8Z1UrutBLiLzi5mgNGVjtJAz/QJxQ9Jt
         kWB7Cmh5xaWcTrNSlXGdozrtBCeu5w5iY4y7aVE0DEwqyxChwAhcrolcXYIj1J5Uk3KC
         f/UA+RvUyKkT8c+fWJ8zmNbTMufzlrrAoqu4C6y/oP0GxY1e6n3XlDOoZ2VTRNNNIq8i
         piENPpRSmZV1YQLjeTi6b1SlzLg/LndQ8R8JQIR4+Oo7na8633EximFc9+QZ4+MIMb2t
         RxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ksk0ituITPDur7VOi1jCXxieV8Du5TeIguFZkpAVdZs=;
        b=2yZcF7Y2kT9E+r4MIx7oYk+h+ihA24voUKO80KxYQALro7N5AVKGjXHptP7c/Zz0xw
         GCT4939HzIXCIVGtQEc3NT/+qkZbiUm2x9eg65Vpl0Rhcbc89rDAb9/30g1VVtIRaYAZ
         u716kdm9MmTNXJXnMGLFOfD+NKc3QCOSokaaJxgLjM6Mimm+BvRlUks742lnCjwNa9yZ
         vhC/4/F4MJt7Or2/uH9yR2WhqZeU37Ej5XGFDRSh5CQF3hmEJ3gb5Mr+/VGRuZI+Vudt
         DJq8zPnd1swZDNKnjzYBCExQmwoYgPdHu10P18/tpQAZNhkF/osTMLiw8iYwrgW81wyX
         47RA==
X-Gm-Message-State: AOAM532NVNtN5PYQebiuJtmgag4RVsz1VTLqi+mFIomfVH6cWLWtUPgq
        RzIuJ0zfzoz1uTdPRBcPtEI=
X-Google-Smtp-Source: ABdhPJx6K9cY4Ez2SM0zDinX5vRHY+dnuuStKoVmdFQ59mUKuTYIX3wud8X0wgvomj/ZkUoS6lac+Q==
X-Received: by 2002:a17:90a:5d01:: with SMTP id s1mr32191111pji.16.1633372142227;
        Mon, 04 Oct 2021 11:29:02 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:db55:938c:e15a:4670])
        by smtp.gmail.com with ESMTPSA id 17sm15888836pgr.10.2021.10.04.11.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:29:01 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 4 Oct 2021 11:28:59 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
Message-ID: <YVtH60zyzq9AhUv2@google.com>
References: <20211001181627.394921-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001181627.394921-1-bgeffon@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> There does not appear to be a technical reason to not
> allow the zram backing device to be assigned after the
> zram device is initialized.
> 
> This change will allow for the backing device to be assigned
> as long as no backing device is already assigned. In that
> event backing_dev would return -EEXIST.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..12b4555ee079 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
>  		return -ENOMEM;
>  
>  	down_write(&zram->init_lock);
> -	if (init_done(zram)) {
> -		pr_info("Can't setup backing device for initialized device\n");
> -		err = -EBUSY;
> +	if (zram->backing_dev) {
> +		pr_info("Backing device is already assigned\n");
> +		err = -EEXIST;
>  		goto out;

Hi Brian,

I am worry about the inconsistency with other interface of current zram
set up. They were supposed to set it up before zram disksize setting
because it makes code more simple/maintainalbe in that we don't need
to check some feature on the fly.

Let's think about when zram extends the writeback of incompressible
page on demand. The write path will need the backing_dev under
down_read(&zarm->init_lock) or other conditional variable to check
whether the feature is enabled or not on the fly.
It adds locking dependency as well as performance overhead(I don't
think it's a good deal that scarfice hot path for rare event even
though it's not that big).

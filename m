Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC089C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A11208CA
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 05:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588915845;
	bh=4297OzbqU+C+5u0FCNqfNu0Ox2iiLbvWnsgYY+NE5AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f5WlCOlxq/AxhncnvGaiuyIYzGeoJJAptCX2zw2gUzzkez0YzseSbw0BFid4owTK0
	 uLcLc4QMHZQn7TlVQIr1psr+HnBMQBLS3en+Nna+AGa3ix/D4o33j+z+49C/3RYShB
	 7BTT7jh/f64oaxsupVeejndDfsUVK2F52NztL/0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgEHFap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 01:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgEHFao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 01:30:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4BC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 22:30:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l25so353418pgc.5
        for <linux-block@vger.kernel.org>; Thu, 07 May 2020 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JGaJ90mKQXY5GdgtaMTKt7BPefHrKpI80lkpK/UX+1Q=;
        b=Zm/kADQXd1GQioJYe48Be7YEVp2ww5Hki7r8nnK/OiUCMPqnJk54FcLys4YdZbdbSh
         fAIi7oxk2FRpEFNJDSwiO14mSG5zPJszrq/FNL/MRjmVHNqmZwyhFODSN9glhhLfVtvi
         2OQIt/uD0foPSaQhW+8srF9ZdlyFvY8N3VQ1QHXHpcMGqvSQTkdKHttoCecEMR36xWv4
         Nkm+unlaZ6YyjsYo67EBQ/qfFCnuKwImWe3cEaIpywX3yIjfQnB8S6oPOW9sKkZWwR1D
         zJtYR+3kDCKSOmovZx1XPiXTi56M3XN7YrM0Ib+dWQC0p+PxZJuW+9geFJYyD9Ah8d50
         ofrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JGaJ90mKQXY5GdgtaMTKt7BPefHrKpI80lkpK/UX+1Q=;
        b=Nl0EO2TLXKW9XyV5XGuA1dreu2TBMWMgxBuekBQ8kaHuEjBI+J6Tk2oD1xRb9UBvqd
         S1G7TEorZJ+JwuK2ZuS9eK4wcLFTZ3Nk54tVG+Mm8VDvONTfIhfp+L+nR1/GEz2zmkLa
         HNy+RUMXyznQxHsHnN0vAsIYporIapgfUjwdcRfrYvN0AtfAPnQw0DF6OfMllfj5QKSH
         ykrPWEC5JO/Hlf+rfkAAe+JkX7ZGD1Te6lyGKPLVsejRkurkJFSFlS0rOgMtmgd/oFJB
         1W5+ddW2b0mO+AJ+nLGP898qVPnRfZ5qbtuVzKwl9dgHykATxdLilpTX74tHIIPNCNfS
         sExw==
X-Gm-Message-State: AGi0PuYwIISo3CJBi07WjfcgkVq6j8WQXwAlYUI2QVtxaH06fnTvUM0t
        UBNFh2GQ4JdMEgNZ5zxS4pvUjkBF
X-Google-Smtp-Source: APiQypJbrb05TgWxTjxklaR7kI8A3elG3/74jGg+Cm8AW7kaxBnvtHUSVc/EwXqN7eDRzPNm6oyelw==
X-Received: by 2002:a63:3d05:: with SMTP id k5mr653314pga.302.1588915842938;
        Thu, 07 May 2020 22:30:42 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t21sm494630pgu.39.2020.05.07.22.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 22:30:41 -0700 (PDT)
Date:   Thu, 7 May 2020 22:30:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1] zcomp: Use ARRAY_SIZE() for backends list
Message-ID: <20200508053040.GB197378@google.com>
References: <20200323175008.83393-1-andriy.shevchenko@linux.intel.com>
 <20200415144747.GK185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415144747.GK185537@smile.fi.intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 05:47:47PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 07:50:08PM +0200, Andy Shevchenko wrote:
> > Instead of keeping NULL terminated array switch to use ARRAY_SIZE()
> > which helps to further clean up.
> 
> Any comments on this?

Acked-by: Minchan Kim <minchan@kernel.org>

Sorry for the late. I lost this patch in my mail box. Could you resend
this patch with Ccing Andrew Morton and Sergey Senozhatsky with me?

Thanks.

> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > ---
> >  drivers/block/zram/zcomp.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> > index 1a8564a79d8d..e78e7a2ccfd5 100644
> > --- a/drivers/block/zram/zcomp.c
> > +++ b/drivers/block/zram/zcomp.c
> > @@ -29,7 +29,6 @@ static const char * const backends[] = {
> >  #if IS_ENABLED(CONFIG_CRYPTO_ZSTD)
> >  	"zstd",
> >  #endif
> > -	NULL
> >  };
> >  
> >  static void zcomp_strm_free(struct zcomp_strm *zstrm)
> > @@ -67,7 +66,7 @@ bool zcomp_available_algorithm(const char *comp)
> >  {
> >  	int i;
> >  
> > -	i = __sysfs_match_string(backends, -1, comp);
> > +	i = sysfs_match_string(backends, comp);
> >  	if (i >= 0)
> >  		return true;
> >  
> > @@ -86,9 +85,9 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
> >  {
> >  	bool known_algorithm = false;
> >  	ssize_t sz = 0;
> > -	int i = 0;
> > +	int i;
> >  
> > -	for (; backends[i]; i++) {
> > +	for (i = 0; i < ARRAY_SIZE(backends); i++) {
> >  		if (!strcmp(comp, backends[i])) {
> >  			known_algorithm = true;
> >  			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

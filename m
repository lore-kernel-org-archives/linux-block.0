Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB30C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843A46108E
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhIFW6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhIFW6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 18:58:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C525C061757
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 15:57:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so417406wms.5
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=boZeJdNNFnOsVbWVnCJCTbH8B7u4Rp1yojauy9zSZ2Y=;
        b=mFcoi+u7nGopcLVoIZvQQfYSbDVIER36TYGAhEmouUIcf3HTfcr95USrSEMuyRMG0u
         XWsDvX6iUNDG/JioA9itdOY4h4Cibbvoaohj/R8d99xJS1ftHunZie30pQs7wrzI6WFx
         Atpxwsb67/5Cc5UVJi13Zw29JDRMoIpUBiJqnmg4HDHlgSLCURB2egA04anod9NrYZS2
         EDI5MAhQ5YBxjiOMMsy/JgHzZZqdPYiZkrG6U+IJKSwBw0JGQuf5xPSs1T3j8RczIjAy
         /HUWLZzrZwcxltnH/zucmhR+a7rE9qxTSdFvIePj+BPGzw8kopl+lKcKDXClCgamd99D
         MYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boZeJdNNFnOsVbWVnCJCTbH8B7u4Rp1yojauy9zSZ2Y=;
        b=KW7frj+NpdeP7Vaxexx5RNh42HPD7RahNY9Oy4Gq38+ah28f1QZovn9BDNj+du0+HO
         A7hfywaLdcsRfZERxnV+rYUbX2BYaI7pn4dMZAilR16/AukOGMSxf78Puk8DQpaT0h3A
         CuMs/NkE8ezXRj/YNuH82RGgcg9tFmJBDm2lLv2xT8slKmWgu4fUczQzgsm8mIziMICA
         NiuEIig5bpEE/6VRK+96p0ovuzB9H7X4vugtZQ1sDBKQfD/WuHyBUFVaNQ2jcb8lHMFX
         82jyQlwEcrempz9tbMy8BPudue0+zB4XVIVJXIkkOpRRy+Rk6mz34GXV64wrJA3YjQMO
         2PhQ==
X-Gm-Message-State: AOAM531L9Zi+4eUGvAZoZWvOlTWVTwd1NX6u1jcZ0e4oXWj8Mw28A47a
        PWPQmMu9HUQi6PtLlTnbKnKYj45AhoYg8Q==
X-Google-Smtp-Source: ABdhPJyKQjRtAsrF/B7O4VPB+y52YYdm4z2NiPz3wWkXPM1qNkixHYmFrmj2s/omQobTHvACKHspmw==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr1076386wmb.73.1630969046695;
        Mon, 06 Sep 2021 15:57:26 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id i5sm9012434wrc.86.2021.09.06.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:57:26 -0700 (PDT)
Date:   Mon, 6 Sep 2021 23:57:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTac1M6+pdwZ532J@equinox>
References: <20210829143735.512146-1-lumip@lumip.de>
 <65bf6d1a-f65d-910c-60c7-0a4911a52e9a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bf6d1a-f65d-910c-60c7-0a4911a52e9a@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 02:11:31PM -0600, Jens Axboe wrote:
> On 8/29/21 8:37 AM, Lukas Prediger wrote:
> > The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> > global state, meaning that only one process can detect a disc change
> > while the ioctl call will return 0 for other calling processes afterwards
> > (see bug 213267 ).
> > 
> > This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> > works by maintaining a timestamp of the last detected disc change instead
> > of a boolean flag: Processes calling this ioctl command can provide
> > a timestamp of the last disc change known to them and receive
> > an indication whether the disc was changed since then and the updated
> > timestamp.
> > 
> > I considered fixing the buggy behavior in the original
> > CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> > for each calling process in the kernel, which seems like a worse
> > solution than introducing this new ioctl.
> 
> This looks pretty good to me now. Adding Phillip to the CC, he's the new
> CDROM maintainer. Leaving the rest of the message below intact because
> of that.
> 
> >
...
> >

Dear Lukas,

Thank you for the patch, much appreciated and looks great. One very
minor thing though has jumped out at me after running checkpatch though:

> > --- a/include/uapi/linux/cdrom.h
> > +++ b/include/uapi/linux/cdrom.h
> > @@ -147,6 +147,8 @@
> >  #define CDROM_NEXT_WRITABLE  0x5394  /* get next writable block */
> >  #define CDROM_LAST_WRITTEN   0x5395  /* get last block written on disc */
> >
> > +#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
> > +
> >  /*******************************************************
> >   * CDROM IOCTL structures
> >   *******************************************************/
> > @@ -295,6 +297,19 @@ struct cdrom_generic_command
> >       };
> >  };
> >
> > +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> > +struct cdrom_timed_media_change_info
> > +{

This opening brace should be on the same line as the struct definition
as per current style rules.

I also got a checkpatch warning about ENOSYS being used as an error
value, but I can see this usage is standard in the driver and not a
problem so no issue with that.

I will review and test properly after work tomorrow (being new to the
role I'd like to make sure I'm taking the proper time), but I have no
doubt it will work fine. Assuming it does I will be happy to accept the
patch with the above brace change. Thanks again.

> > +	__s64	last_media_change;	/* Timestamp of the last detected media
> > +					 * change in ms. May be set by caller, updated
> > +					 * upon successful return of ioctl.
> > +					 */
> > +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
> > +					 * change was more recent than
> > +					 * last_media_change set by caller.
> > +					 */
> > +};
> > +
> >  /*
> >   * A CD-ROM physical sector size is 2048, 2052, 2056, 2324, 2332, 2336, 
> >   * 2340, or 2352 bytes long.  
> > 

Regards,
Phil

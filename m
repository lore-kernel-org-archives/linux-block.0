Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB6C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62061132
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 23:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhIIXJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbhIIXJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 19:09:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D51C061575
        for <linux-block@vger.kernel.org>; Thu,  9 Sep 2021 16:08:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so2471259wmh.4
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnsLGI7KHkf/fjZMjTQ46X+s/O77KGR30CAirGg9ymU=;
        b=NQxu1Eg4mN2kXFGR3QoIMY7mxNVZj1WS19+bqLUgiyVRIQuIY7dermQ8PNWTecXRjp
         7pU6y/0rcRy2pSwcnihYta69M3lA0m9aGjf9gsvmRUOOH881R0MlBUKfqpDfkpwvCbcZ
         BXHAQ2MhMvccV9jW22h1H13S5z+Ws22lLlrEEpUOv5QvHE0dA+m2vNFrlphVEaVLUu6V
         MhecjYnQrAPoARgZ84PBOsOMgjj7LwL7TiUee0jVFHABarqeaWLBWmhOdSYBZlfcJins
         sCOgpJt5zvj8HKgjgqGb658OH4i0jeSduaxzlwVn82JLFOyIRg8C729QVDuPtYpmperb
         HIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnsLGI7KHkf/fjZMjTQ46X+s/O77KGR30CAirGg9ymU=;
        b=7G2OXgWFYC1DBoQuBFYckKjcv7ByOjNodFXX0tKrlU+fhcj21/OcRk5cHBcMqytoYb
         hEKMNmpWnRo62d6WcixqS7aWMTm07LTWeTxjcj3ickvi0Azji8A94OsEazuL2cR1RQwI
         aHscRzmN5JNlmrfOImdCG8lLRZpNKnWLZBQAn6Py65YsJfLev3ovC2JIQI7qjo9K4CWE
         UdiJz3bavQ+JAIpWvZtH8xswGj37iOR05+U/Hn58xcRHwfaQeixdT7Xj+bW2ZnUJbFmq
         2NIH0MQhjGkSARTyKWanPnBYDlTz3jY2qWpqKE5tSW0iIO0rW9p4MCEPuBjtRFjAGv2k
         QWAw==
X-Gm-Message-State: AOAM532ZhW3mYCP3ufmyC6BTtpbBeI2r+RLASBzRVumYjDxAtJOni5Ga
        ZUgdG8spD7UuiW5MV6rwD6eFRQ==
X-Google-Smtp-Source: ABdhPJzarZwyyAIam9S3veKyBK/hpHpV6khNy25jIfPxAvddOPtne6Rch0m4HRRUvLmxut5ix8ekBQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr5343897wmg.8.1631228880698;
        Thu, 09 Sep 2021 16:08:00 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id d9sm3732984wrb.36.2021.09.09.16.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:08:00 -0700 (PDT)
Date:   Fri, 10 Sep 2021 00:07:58 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTqTzqcTCYNvm/Su@equinox>
References: <YTlMnjyIMHHIGiPe@equinox>
 <20210909180427.8100-1-lumip@lumip.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909180427.8100-1-lumip@lumip.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 09:04:28PM +0300, Lukas Prediger wrote:
> Hey Phil,
> 
> thanks for taking the time to look at this and give feedback.
> 

No problem, and great work :-)

> > Dear Lukas,
> >
> > Thank you for the patch, much appreciated and looks great. One very
> > minor thing though has jumped out at me after running checkpatch though:
> >
> > > --- a/include/uapi/linux/cdrom.h
> > > +++ b/include/uapi/linux/cdrom.h
> > > @@ -147,6 +147,8 @@
> > >  #define CDROM_NEXT_WRITABLE  0x5394  /* get next writable block */
> > >  #define CDROM_LAST_WRITTEN   0x5395  /* get last block written on disc */
> > >
> > > +#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
> > > +
> > >  /*******************************************************
> > >   * CDROM IOCTL structures
> > >   *******************************************************/
> > > @@ -295,6 +297,19 @@ struct cdrom_generic_command
> > >       };
> > >  };
> > >
> > > +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> > > +struct cdrom_timed_media_change_info
> > > +{
> >
> > This opening brace should be on the same line as the struct definition
> > as per current style rules.
> 
> I also noted that checkpatch reported this and that it is technically a style breach,
> however I kept the brace in the newline to be consistent with all the other
> cdrom ioctl structs defined above this in the same file for consistency.
> I have no strong feelings about this, though, so we could change this.
> 

I take your point, but my personal preference would be to not introduce
code that has new checkpatch errors or warnings, where possible.

Indeed, it may be worth correcting other code in the driver that would
trigger checkpatch violations, and this is something I will look at, provided
it makes sense and isn't too much churn for what are non-semantic changes to
a very stable driver. Many thanks.

Regards,
Phil

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD11C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 23:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B962A611CA
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 23:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhIPXIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhIPXIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 19:08:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A7C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Sep 2021 16:07:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso5641238wmc.1
        for <linux-block@vger.kernel.org>; Thu, 16 Sep 2021 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VJIWxjRtkF5LrHNanNrV01+oP3xoHzwDI7LlDWHvnA=;
        b=Y5w/oBZ/iwNIEzDP2JSS41d4nLrXU8K367OfjInHGu9fmcMvanYwiRm5+R2yYzEGf8
         z4GDFq8nI7r0GZJ1mt5XXgrYbLNwwGQ8e1hjvm7E4RvUT450tDkIKYw4Zoyna7P9vC+I
         zoyPTxAxwAuxRIAOIN24pyTzGIJIyOo+TitVBDeFtW9vs9jqMqOdS8/UtSAXIympbIVu
         ScI7U7jpuyR9daZIIbwnNRKWplhoe/vtcgpANaDNumM0v/M+ZyhG3Y2rP5qud5jQimMO
         ow4jEJqFW468cophMm+6/rLhe2W9AR3otIym6wzhHrYH5FbE/cEX4FAh2nUfz8e0s7ch
         yeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6VJIWxjRtkF5LrHNanNrV01+oP3xoHzwDI7LlDWHvnA=;
        b=SM3niw1fBBz/ExonwzJFyppDsJGR58ueVB7t4ZDhJde3H0VILSozk1wI1sQZUaVjsU
         AfSMedxyeHnlzVYINAJPCQnIaZgGPPOl/iy52fuWO15iR2X8y6WBTGBXALkgck0jVfAA
         MhfFJiXaVL4HiqJW0zcHVwAfCTSnnSQDOvjh5d1fJ0dk0ZRFNDvMT6cIRR4g2teJ/kzD
         /IWzjgXjOknNvMHKzuAfau7FlBDINay+6bUGuuDSZ6al1zzoRC51AkZepmOoOxcUhwpa
         SFMBUKSSCbDKu3TNv7B+Sj9kCuA1WnvMarifd7tp5gXW0G5stfXoEnfmWVfzNFXiv+Oq
         0YmA==
X-Gm-Message-State: AOAM530hxPzMpAHPALo1kPb9s+6LmU8Tw05jYvaXU9J01XWxys0GQqIc
        KbM7YUbzHzJwXCQ19RHft6KbKw==
X-Google-Smtp-Source: ABdhPJwyafJoJhWy9Y9UNXqjAbK5VSz/d3hZPVorPvYtzhAo+jn1TyTWD2ULZm8JSl7iVwrI3eBd5w==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr12052809wmb.61.1631833633425;
        Thu, 16 Sep 2021 16:07:13 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id d17sm4739196wrp.57.2021.09.16.16.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:07:12 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:07:10 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YUPOHlMtJwU3r+rG@equinox>
References: <20210913230942.1188-1-phil@philpotter.co.uk>
 <5766487b-a5b4-9590-3f56-2c1d23819ffa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5766487b-a5b4-9590-3f56-2c1d23819ffa@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 08:05:41PM -0600, Jens Axboe wrote:
> On 9/13/21 5:09 PM, Phillip Potter wrote:
> > From: Lukas Prediger <lumip@lumip.de>
> > 
> > The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> > global state, meaning that only one process can detect a disc change
> > while the ioctl call will return 0 for other calling processes afterwards
> > (see bug 213267).
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
> Applied for 5.16, thanks.
> 
> -- 
> Jens Axboe
> 

Many thanks Jens.

Regards,
Phil

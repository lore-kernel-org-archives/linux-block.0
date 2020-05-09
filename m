Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF6C54E4A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B310220CC7
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bCOSwnBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEIPHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgEIPH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 May 2020 11:07:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52269C05BD0B
        for <linux-block@vger.kernel.org>; Sat,  9 May 2020 08:07:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s9so3907157eju.1
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
        b=bCOSwnBBjfPXdvYGJ+yVECFvPTePDH1ANyISrMhvJ1qWqJvVThnHr98KsSwJqA14nC
         yCPOxIRhJYUKs+I0Z7zlDnbc2VJgVwWpDdEA4tIPWEVVkzgs6TyhzHr/LnVPIJc5YbZe
         /Ga31Bb5nRqdr5sF01D+4kD7nuppvALvlvKumT0LdbEKLra5xfeiNf57Wv0ExKnHb7Rg
         DbJPWuDEL/VR1p8vve4AZ1c4iNgOcgeDoJddMOToTohvJc+NMCp5pllqs5xHvWVFoT1b
         hZ2eMoVCvm/W3nphozJEpzuE720t10XyAVjkj8Y23QAnpJ3YgiSQvtyoRGLEW8+4DwBB
         HlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
        b=GeTcuVBOIEH7aXipp2IIuFQSyrcFUXjnRzoAA+FgHuNcxCkbs54q/bZIQ8dgh5e8s+
         Nug9k3WROM5hmtUn1zmKfsIPdtwhYAOMpDtdY4czBUiEVIetZyJypRl6Ml+PLSzrqVKE
         Lb/A3Mz7f8/Yp+56VDFVj1V0V225JW2Cntjp5RNr38lOLO2GJy7GZiisHP0GXtMyaikS
         7muNVNJ2jrGaTblMxcJeZNGW4KqKKyvGGQ8zdoW6P7RzqYX2mMQ6VcfHa62Yxe2ynUOq
         xXgJuoKfRISBlNG5dy72WTOmn6A5Ns1UaRnIa6z6wwQlACPnC4xBF8R1CkMcFEbz+dgX
         dGuQ==
X-Gm-Message-State: AGi0PuYJXV5lg2Z5Gp4c7qDU/+Ev3CcSnh2+vu6x9TDPqeDJ1yZTVCFH
        C4gnd1w/PQGbIozjdpCwklnGPC6iG61uHKdM1C68cg==
X-Google-Smtp-Source: APiQypKilW3QgeYL9j+z8BH4y4sSKlWKWi60GEoJhZT78wFbACZI36hD4PovUMVH8UfEyvLbc+3je7NxPGD32jSs39Q=
X-Received: by 2002:a17:906:855a:: with SMTP id h26mr6685025ejy.56.1589036845508;
 Sat, 09 May 2020 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de>
In-Reply-To: <20200509082352.GB21834@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 9 May 2020 08:07:14 -0700
Message-ID: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
        Geoff Levand <geoff@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 9, 2020 at 1:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 08, 2020 at 11:04:45AM -0700, Dan Williams wrote:
> > On Fri, May 8, 2020 at 9:16 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > various bio based drivers use queue->queuedata despite already having
> > > set up disk->private_data, which can be used just as easily.  This
> > > series cleans them up to only use a single private data pointer.
> >
> > ...but isn't the queue pretty much guaranteed to be cache hot and the
> > gendisk cache cold? I'm not immediately seeing what else needs the
> > gendisk in the I/O path. Is there another motivation I'm missing?
>
> ->private_data is right next to the ->queue pointer, pat0 and part_tbl
> which are all used in the I/O submission path (generic_make_request /
> generic_make_request_checks).  This is mostly a prep cleanup patch to
> also remove the pointless queue argument from ->make_request - then
> ->queue is an extra dereference and extra churn.

Ah ok. If the changelogs had been filled in with something like "In
preparation for removing @q from make_request_fn, stop using
->queuedata", I probably wouldn't have looked twice.

For the nvdimm/ driver updates you can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...or just let me know if you want me to pick those up through the nvdimm tree.

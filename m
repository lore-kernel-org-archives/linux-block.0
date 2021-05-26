Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D39C47088
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C3B613E1
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhEZIJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhEZIJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 04:09:39 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EADC061761
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 01:08:09 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id w28so302386uae.4
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrfL+UvsoUYJEVH3FOBXMPqeLzeAwHNpUWgDzMspWKw=;
        b=woqt8BnxKZukeBLeJd4w4lKnQ3cKCzoRk7QnVN0RWefRH0Lak2HbQbLhx/frNziCrW
         vzOd63E9Idh6uhMeJbijddzANEGlwhq2a94sp+UT6X33w/HJrP0R4Xxsur3qtd3UJ9V3
         RXhO2WmDqsPWGOOFe4Z1vXtU3Ajlf9H69hO1WGEkh2/q7XWi3knfCY64J+SzmkNKOe36
         kp6uvOs+ndgfRymDdtUOUv9NQPYP8RiXXMABsN8MVSRmmehasPQ8UDsDcWRSt1e77qBG
         1jHw1+BN8mfEhYZIvRTg/wyYkLYEyw3TBricpiOdb+JF5bZQWiaQ0RSSDpINkEteioTM
         z8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrfL+UvsoUYJEVH3FOBXMPqeLzeAwHNpUWgDzMspWKw=;
        b=XArraLp9zruOFwz/N3AqsFH+Fj4dhCLkX5jg3ehO9ahqadkxF/scJnMKfCm5TJvKsN
         jk150HUioh0WI0vSHD+23P+zGP3tt2tSLr+4UUlnhP4Fsr6aEVBWCFSDV6TsVC9L7/IC
         KEXUlFu8nC/9RZWghutXvjcZmFrpXfEOOGvznz08iSMhFZZjMvuvgNYVruiEPtIrb8rL
         4yEsgb0tNaRKqglCVyQOOp2VuyY+jtVMAeqQDs4Fl7pd5ev1Kxp50A+65AoQ0kRDahLi
         RXqjEhL1R8Y45WoXiRzatKpWY75TI2ARUoGZ7eqfso7k6Zj+j9Djx5U1wFM+OqObRAN/
         yi0A==
X-Gm-Message-State: AOAM5328GWYRxeJCKdVWSrVk19y8Lj2OQRqnYIJxtNfd4X9p/ISQDzsK
        bwK7WFCMsFgDfxPOs0EqFIpF04RBuguwG9wLFHTQwg==
X-Google-Smtp-Source: ABdhPJxEKZ+yyN+wbXXVH9CKQ94TxTUrIX6SVT7ztQ9Bwftr62IUqVIB3GNBh5QlN3mdzVdDkjsC7QK+8McmDny5XO0=
X-Received: by 2002:ab0:3351:: with SMTP id h17mr31776765uap.15.1622016487939;
 Wed, 26 May 2021 01:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de> <CAPDyKFpqdSYeA+Zg=9Ewi46CmSWNpXQbju6HQo7aviCcRzyAAg@mail.gmail.com>
 <20210526044943.GA28551@lst.de>
In-Reply-To: <20210526044943.GA28551@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 May 2021 10:07:31 +0200
Message-ID: <CAPDyKFpR0maO_Dj6bxWSLvh_jcGnrcZ=na42atXfNdkmMkmdig@mail.gmail.com>
Subject: Re: simplify gendisk and request_queue allocation for bio based drivers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 26 May 2021 at 06:49, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 26, 2021 at 12:41:37AM +0200, Ulf Hansson wrote:
> > On Fri, 21 May 2021 at 07:51, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > this series is the first part of cleaning up lifetimes and allocation of
> > > the gendisk and request_queue structure.  It adds a new interface to
> > > allocate the disk and queue together for bio based drivers, and a helper
> > > for cleanup/free them when a driver is unloaded or a device is removed.
> >
> > May I ask what else you have in the pipe for the next steps?
> >
> > The reason why I ask is that I am looking into some issues related to
> > lifecycle problems of gendisk/mmc, typically triggered at SD/MMC card
> > removal.
>
> In the short run not much more than superficial cleanups.  Eventually
> I want bio based drivers to not require a separate request_queue, leaving
> that purely as a data structure for blk-mq based drivers.  But it will
> take a while until we get there, so it should not block any fixes.

Alright, thanks for clarifying.

>
> For hot unplug handling it might be worth to take a look at nvme, as it
> is tested a lot for that case.

Okay, thanks for the hint.

Kind regards
Uffe

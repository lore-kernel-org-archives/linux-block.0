Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B7C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B02B21D41
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="iG3sbmf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINWJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINWJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 18:09:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955BC06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 15:09:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so685529pfg.13
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfVGsGkC0J6kcceXBBtlfVrTqXHCrQSdzH/zUBV3UYs=;
        b=iG3sbmf+Brl3OB8FA+CIDCGs3/JYZPLq9vZsEUqwbkFd1uwxWWwKOxxm5Vr9T7jV77
         L3z7RzbM7d1SOONNFC+xUuj8UGcybsJib0IKsExz5Ob5qwV3lnmua1be1GYZm5NLL0sD
         67A7R4XsKM1enP/xfmzXb93lWezNZjm7dbqlJ4RXnuJC7EcxBeDNskP1slQsi7WpEmS1
         EzP9pbmcJDdZcP6WkermSd2LRv2VBnVNKW/eV5wmGBjEg6PSJybQkFj9l+yRb/nCWZWG
         h0LAvblHiFhBA8XgG6Q3ka/FaYUl8e6PrOXbzNO8MF+dlw5SDd51JCGV2WNPxJlYav7M
         d9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfVGsGkC0J6kcceXBBtlfVrTqXHCrQSdzH/zUBV3UYs=;
        b=Yl5rXbpTGHS5tKy/O7+lxzIGJatGzvv8B7AbksR+WPkxN9HJ1O8Uk07Zbwxaq3O5RB
         /OSETc0398ORtw0nPIYkNggULGsOnTcoc5Nl3iJ7KgocaeqsdpS6JzHy49ZoXxJJ4LoU
         3C0Ec6h5TBKl8iKk3kruN+VHhxKHSChvrGSYcWnzrLxgAV+GTio1qNsv1Q91MvgHlDpA
         AURU3qF8naIYwDWhS/ULrbqWBjUJ4Uh9uUYGToCEx6bcwN2zTy5s+VRKrt/F/UWAh26g
         FDg2CXlTBFhhjWzJKfMTA7eu6oLRTKJb7rXKgLip7wXcybBARGq0qcTDtScrPUjZVVQk
         4wWA==
X-Gm-Message-State: AOAM531hHItdwfXE1GVqWHjdQ5ceZd6ZfHY0KDjAxaODONiJ1FegWIzp
        KVfZeWjUjCunkX7DOmlUuXGVFw==
X-Google-Smtp-Source: ABdhPJxGwlTZm+BIixV7cmsgTx+x9TRaDRYz1Y2lOLY3Om9AzrCD6hb0aN3F5BWDySxpvtfKtlyGfw==
X-Received: by 2002:a63:f53:: with SMTP id 19mr12492667pgp.26.1600121393447;
        Mon, 14 Sep 2020 15:09:53 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
        by smtp.gmail.com with ESMTPSA id 64sm11297529pfd.7.2020.09.14.15.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:09:52 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:09:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914220951.GD148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14, 2020 at 04:04:59PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-14 3:51 p.m., Omar Sandoval wrote:
> >> diff --git a/tests/nvme/002 b/tests/nvme/002
> >> index 07b7fdae2d39..aaa5ec4d729a 100755
> >> --- a/tests/nvme/002
> >> +++ b/tests/nvme/002
> >> @@ -10,7 +10,8 @@
> >>  DESCRIPTION="create many subsystems and test discovery"
> >>  
> >>  requires() {
> >> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
> >> +	_nvme_requires
> >> +	_have_modules loop
> > 
> > Bash functions return the status of the last executed command, and the
> > requires function needs to return 0 on success and 1 on failure. So,
> > this is losing the return value of _nvme_requires. Just chain multiple
> > checks with && to fix this (here and the other places _nvme_requires was
> > added with other checks):
> > 
> > requires() {
> > 	_nvme_requires && _have_modules loop
> > }
> 
> I noticed this too during my review, but based on my read of the current
> blktest code, the return value of the requires() function is not
> actually used. It seems to only check if SKIP_REASON is set.
> 
> If we want to ensure the return value of requires() is correct, perhaps
> we should check it after we call it and then consult SKIP_REASON? And
> WARN or fail if SKIP_REASON is set when requires() didn't return 1.
> 
> Also, we need to do more than adding &&s... _nvme_requires() will need
> to be fixed up as it calls other _have_x() functions and ignores their
> return value.
> 
> Logan

Oops, you're right, I actually changed this a few months ago in
4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
Totally forgot about that :) IMO it's still cleaner to chain them
together.

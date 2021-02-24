Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F42C64ED6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhBXIdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 03:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhBXId2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 03:33:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32FC061574
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 00:32:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g20so775336plo.2
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1A/Kwbkz4UTAAAMiX7pxPJv/hxIZpmtgyIqS3D8GBto=;
        b=ENQo8iCRt8GIck63Eo01THW6ZR0v7WvrkFcjXTV8YuHA3KlcpX4fX+zKqPgrJ2qb3D
         Isja2VlnerHW5HnoP3T3NQqiFZCBOjQXEVv//MfIC2VS4qHA2H8Y/462v10LHBSMKAjc
         7Ac4VW2uAgJA0/zrKNdRWt+vhTCkTue0xWI8KitAcBduEI0wC5OuV14zLAza0o8P86kt
         TmZPQekfxc9ei0aUxNJAPSdRCZ/YVFyaLPItICuObmnIX8vfLxY3QAb5rR688jYvBRH9
         3Vq+1fL8rQs4nSF1l5yWRxXF78IrMKcGwtD+7fU20r5sUvygO4SUghRlRgvZAKw7ljGY
         qumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1A/Kwbkz4UTAAAMiX7pxPJv/hxIZpmtgyIqS3D8GBto=;
        b=HpDr21LPiw6imml/mPz7NRAf4vQR8/ZhO0k/zEzw5Ef/iB4DBOJX2n1E3X+TTgVOPQ
         D3X1z/KPeArs+72YaYln3DFW2hDygVAQLAN/4WUJBvywn/NVOCBZRwyPNfaIRYGsOvJW
         nhQuet/V6NF/jaXS05bIBelXOhzHj8UKr8EskW5EqhZcuqWZ1VEHjL0mY0XdaBC8owj2
         YWWfJFgw7w6VipEpeSwxfDweMTbQNOIkZ46m/1LWSAgfBfPmM9+94O8qZJTklT+JE6yB
         6tSUMBRVJfFLr+5qlz1PEW5XfTM4SLTgfegJUAOJAQcaYYhhlBqS3XOvxLCZBf9dDO9U
         7VRw==
X-Gm-Message-State: AOAM5326qIB9rnWbyUc5CE2k6QzQ9qbcZXBSmZ0SHElU7kaRlcudfu0K
        myx9IZA6kwFsudLwyloT3W8uoibRGZ6omQ==
X-Google-Smtp-Source: ABdhPJwOvaCVta9p8auGUqH6NxSQzp8CdWhb+uYvAfWDvSZUXY0D3rqDAPMKareqWXhq4M95w0E30w==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr3445383pjy.105.1614155568353;
        Wed, 24 Feb 2021 00:32:48 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id 67sm1828861pfw.92.2021.02.24.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:32:48 -0800 (PST)
Date:   Wed, 24 Feb 2021 17:32:46 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
Message-ID: <20210224083246.GB2166@localhost.localdomain>
References: <20210223151822.399791-1-hch@lst.de>
 <20210224015202.GA2166@localhost.localdomain>
 <20210224072603.GA32368@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224072603.GA32368@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-02-24 08:26:03, Christoph Hellwig wrote:
> On Wed, Feb 24, 2021 at 10:52:02AM +0900, Minwoo Im wrote:
> > On 21-02-23 16:18:22, Christoph Hellwig wrote:
> > > Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> > > method, which caused the sd driver to check if any media is present.
> > > When the ->revalidate method was removed this revalidation was lost,
> > > leading to lots of I/O errors when using the eject command.  Fix this by
> > > reopening the device to rescan the partitions, and thus calling the
> > > revalidation logic in the sd driver.
> > 
> > It looks like a related issue that I've reported in [1].  And this looks
> > much better!
> 
> I don't think it fixes the block size issue, does it?

Uh... Sorry for the noise.  This reopen is not the first shot so that the
block size will not be updated because bd_openers is not 0.
set_init_blocksize is not being invoked.

Sorry please ignore this noise.

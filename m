Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B241C433E6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B722564E85
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 09:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhBXJgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhBXJfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 04:35:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060BC06174A
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 01:35:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v200so983564pfc.0
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 01:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOWf+uv6MhgdoyxkCWDCpVer1GB3oG707Q34rbrullA=;
        b=XAPhZdvMSjbXKbknn02rW3H0aCHYGxLYNRt3lMpD59KHR3jHhfvvwSgrvW0IjUDO5k
         M/fE6HwjDLBn+LFTyoahGFfdN/KszQAy7Sd5vpgkwlkEv3HVUmP4dKzQKdo8GpXw+ur6
         tveTEt4Qmw1JMHfmx0GtmI7h/VfiCRRArFry7hi3Spnb8UKZmJoVS0zMhuSVcuAi5zR9
         y9CGL0/hWVZiza+r/XLHmbQjjZ+KuwEhNtUeSQ28AikI56hpF/7RspXI1gfrs67UTe11
         GItzfnB0BjjX1Zk2uf8FdWhoNh5zC5ccJUfkwAbQIzJo7SQp2+SccFlCUML3tS2QBPSB
         /m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOWf+uv6MhgdoyxkCWDCpVer1GB3oG707Q34rbrullA=;
        b=crqmkLZN35bAPFmcgxvhQkRPRdPq1ThWxZ+jx+JuoFnFdRkxOgoF+vyHyvM1kmoFtE
         dEMC3DphJ1AUSTjLme7dSfipGTgIKh7wWwoJJpVk1JK3cNQWCAyX2tWoda84eoZr+zV5
         +x+VEjSk3xUYJWH0Sp1C4OHNll1gi5jzQwS4euscou0NQlApzTvbJr9EM6XstfvQ4d7l
         OsLHtGx1+7Y1DJUC+CEO4DMqz1eHlJ0PMm9lD4+PtcldWYHGDjlcOCmxQ11I5CltiIgW
         C7JW6Td4nWxH87SIc9qkoK/+t996kZNGNA/TmrBTss1CKPXCtwcPxm0gtHMoFqT/C8A/
         ZfdA==
X-Gm-Message-State: AOAM5338X3SHjHKxvtJMJpew9jiNpwXGvAvkkny60WtiArKMDaQ7vdpU
        5TpOI8o8Q6DfHvOBcsArre8=
X-Google-Smtp-Source: ABdhPJxQ4wbQonIxYkXbG/xppheA5orztFwxK9y3fRr/2Q65xn91YCKuypOND4qduSeE0CaPUVBTNw==
X-Received: by 2002:aa7:8889:0:b029:1ed:f38:4438 with SMTP id z9-20020aa788890000b02901ed0f384438mr28714554pfe.44.1614159301807;
        Wed, 24 Feb 2021 01:35:01 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id y123sm2042200pfb.122.2021.02.24.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 01:35:01 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:34:59 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
Message-ID: <20210224093459.GD2166@localhost.localdomain>
References: <20210223151822.399791-1-hch@lst.de>
 <20210224015202.GA2166@localhost.localdomain>
 <20210224072603.GA32368@lst.de>
 <20210224083246.GB2166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224083246.GB2166@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-02-24 17:32:46, Minwoo Im wrote:
> On 21-02-24 08:26:03, Christoph Hellwig wrote:
> > On Wed, Feb 24, 2021 at 10:52:02AM +0900, Minwoo Im wrote:
> > > On 21-02-23 16:18:22, Christoph Hellwig wrote:
> > > > Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> > > > method, which caused the sd driver to check if any media is present.
> > > > When the ->revalidate method was removed this revalidation was lost,
> > > > leading to lots of I/O errors when using the eject command.  Fix this by
> > > > reopening the device to rescan the partitions, and thus calling the
> > > > revalidation logic in the sd driver.
> > > 
> > > It looks like a related issue that I've reported in [1].  And this looks
> > > much better!
> > 
> > I don't think it fixes the block size issue, does it?
> 
> Uh... Sorry for the noise.  This reopen is not the first shot so that the
> block size will not be updated because bd_openers is not 0.
> set_init_blocksize is not being invoked.
> 
> Sorry please ignore this noise.

FYI,

the block size issue has no issue based on the current tree with
8dc932d3e8af ("Revert "block: simplify set_init_blocksize" to regain
lost performance")

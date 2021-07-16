Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9EEC12002
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EA8613F5
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhGPUFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:05:33 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:45868 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhGPUFc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 16:05:32 -0400
Received: by mail-pj1-f42.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so7707631pjh.4;
        Fri, 16 Jul 2021 13:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIO/p6fDXSOIZWjjd/3ZZaaDJCcqllKBKwCD2+daukg=;
        b=QD2TcEtN7tIrex58WvptF+sESXRBgfKI56R5EkmQ70A/p0DTQ7LzG1zDH3ScsxZoGg
         DwJeKb8nqUw007Bqzsq+Rd5z20kb6AmLQ8EkJeAv/y6lktxISpGRhhQv+MwBYXkcfPNC
         c4b7Awvl5QJkfjLgmH34OW6lGxRLJPsi7FxML/WdBSi3KzlIU7ET7LrqIn+Z64fpf9+S
         0EnwQQYkUhQiiIq2xtu/oeMQXZ1J0KDnErY3ZTHDZutbszBg9APsUF29RM7Geo6Mrgij
         GbiuqIKYo9Hssb/Qq2Zzxh55LY71BVGeZaYVdV0sqAgd2tZbhuDVUGOBc8iqb636C7sj
         urGw==
X-Gm-Message-State: AOAM533ttyZTtXNzE9JAOHn7bgGYoULX6s/h6rtLncHJ4ZsLWv90qWcj
        UM13TNc5eSjlgJYVpds6RL8=
X-Google-Smtp-Source: ABdhPJwiKVyqQAieOh5gzUSTJZrIQbGqgGRMrC+DLIJrdGIiqpN5QO5TcEWbe+a49p03l6WOUeSx2g==
X-Received: by 2002:a17:90b:1e46:: with SMTP id pi6mr1474687pjb.5.1626465756555;
        Fri, 16 Jul 2021 13:02:36 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id j129sm11377948pfb.132.2021.07.16.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:02:35 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:02:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/6] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on
 is_mddev_broken()
Message-ID: <20210716200233.3xj33cc7rmgsmkb5@garbanzo>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-4-mcgrof@kernel.org>
 <2f8c1713-2fa2-b832-9c70-c41a87df12ee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8c1713-2fa2-b832-9c70-c41a87df12ee@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 16, 2021 at 07:51:00AM +0200, Hannes Reinecke wrote:
> On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> > The GENHD_FL_DISK_ADDED flag is what we really want, as the
> > flag GENHD_FL_UP could be set on a semi-initialized device.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   drivers/md/md.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index 832547cf038f..80561bca1f51 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -766,7 +766,7 @@ static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
> >   {
> >   	int flags = rdev->bdev->bd_disk->flags;
> > -	if (!(flags & GENHD_FL_UP)) {
> > +	if (!(flags & GENHD_FL_DISK_ADDED)) {
> >   		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
> >   			pr_warn("md: %s: %s array has a missing/failed member\n",
> >   				mdname(rdev->mddev), md_type);
> > 
> Why again did you introduce the wrapper?
> Shouldn't it be used here?

Indeed, and that lets us remove the flag copy. Will fix. Thanks
for the review.

  Luis


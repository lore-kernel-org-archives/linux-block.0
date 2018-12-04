Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FAC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465562082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465562082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeLDWP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:15:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:15:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so20030084qte.11;
        Tue, 04 Dec 2018 14:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ixSjDezikF8McOAtpR6nufWD3806ERSgOMy1Cw5PMmQ=;
        b=iDG+//DRYyGyctFiwvcHEeJ4En/xtIbsN9sMVBlPqlHJPtJqQiVGHinOuFbrzjpaqm
         fBSEp4P6NkBNct8ul15WYKagXiOSnFIDFRyDtPGLsuhhQxx7U+OFIckh7sZRNbsx4ov8
         YHK6KjA5fLbp9QVQglP3xOXHOkWKA+PuYXOpylIwsSmGe20PmGh1ap5awSX0Q5iFgca4
         iq/asuZ2WXRNTtE+oEZw/VS0V7q5a6Q5HnSp1BqF4yWILSZadLW4d5Ge9fu+MsZN9E/7
         iiLPh1mxPHHPQTQW9G+YmQHPxZujudd4UU+XPvC33mIYIzuqNUjc6y0kXikJK1V2C+U8
         I41Q==
X-Gm-Message-State: AA+aEWZjc4qvl60dwj18hg6xZfhX+CtKcVvEWn8pI8MSUh1lE+DhEqKZ
        Py6P10KH23tnF6O13jW+3Mk=
X-Google-Smtp-Source: AFSGD/VlImFaszJYPM38EqGhPrCcDwXBgdMZ6FtpUIZRH0B0pa9AwNlKkMgQCTJIa3JsaomtTvXRqA==
X-Received: by 2002:a0c:f313:: with SMTP id j19mr21634021qvl.200.1543961727132;
        Tue, 04 Dec 2018 14:15:27 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:d0b1])
        by smtp.gmail.com with ESMTPSA id 86sm14568635qky.92.2018.12.04.14.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:15:26 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:15:23 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 05/14] dm: set the static flush bio device on demand
Message-ID: <20181204221523.GA14183@dennisz-mbp.dhcp.thefacebook.com>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-6-dennis@kernel.org>
 <20181204202807.GA4689@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204202807.GA4689@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 03:28:07PM -0500, Mike Snitzer wrote:
> On Tue, Dec 04 2018 at  1:35pm -0500,
> Dennis Zhou <dennis@kernel.org> wrote:
> 
> > The next patch changes the macro bio_set_dev() to associate a bio with a
> > blkg based on the device set. However, dm creates a static bio to be
> > used as the basis for cloning empty flush bios on creation. The
> > bio_set_dev() call in alloc_dev() will cause problems with the next
> > patch adding association to bio_set_dev() because the call is before the
> > bdev is associated with a gendisk (bd_disk is %NULL). To get around
> > this, set the device on the static bio every time and use that to clone
> > to the other bios.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Cc: Alasdair Kergon <agk@redhat.com>
> > Cc: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  block/bio.c     |  1 +
> >  drivers/md/dm.c | 12 +++++++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 452b8e79b998..41ebb3f8e2fc 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -2021,6 +2021,7 @@ void bio_disassociate_blkg(struct bio *bio)
> >  		bio->bi_blkg = NULL;
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(bio_disassociate_blkg);
> >  
> >  /**
> >   * __bio_associate_blkg - associate a bio with the a blkg
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index a733e4c920af..a2d6f8b33d23 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1417,10 +1417,21 @@ static int __send_empty_flush(struct clone_info *ci)
> >  	unsigned target_nr = 0;
> >  	struct dm_target *ti;
> >  
> > +	/*
> > +	 * Empty flush uses a statically initialized bio as the base for
> > +	 * cloning, &md->flush_bio.  However, blkg association requires that
> 
> Would prefer:
> "Empty flush uses a statically initialized bio, &md->flush_bio, as the
> base for cloning.  ..."
> 

Cool, that reads better.

> > +	 * a bdev is associated with a gendisk, which doesn't happen until the
> > +	 * bdev is opened.  So, blkg association is done at issue time of the
> > +	 * flush rather than when the device is created in dm_alloc().
> 
> Another nit but I think you mean "alloc_dev()" here .......^
> 

Yeah, I did mean alloc_dev(). Fixed.

> > +	 */
> > +	bio_set_dev(ci->bio, ci->io->md->bdev);
> > +
> >  	BUG_ON(bio_has_data(ci->bio));
> >  	while ((ti = dm_table_get_target(ci->map, target_nr++)))
> >  		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
> >  
> > +	bio_disassociate_blkg(ci->bio);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1939,7 +1950,6 @@ static struct mapped_device *alloc_dev(int minor)
> >  		goto bad;
> >  
> >  	bio_init(&md->flush_bio, NULL, 0);
> > -	bio_set_dev(&md->flush_bio, md->bdev);
> >  	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
> >  
> >  	dm_stats_init(&md->stats);
> 
> The top-level DM device's bdev->bd_disk is only assigned after the first
> blkdev_get(), so I can see why this is needed.
> 
> Think this type of life-cycle quirk was the kind of thing that caused
> blk cgroup issues with DM.
> 
> Left wondering whether there would be a better way of handling N flush
> bios for DM devices.  But for the now this will have to do.
> 
> Acked-by: Mike Snitzer <snitzer@redhat.com>
> 

Thanks,
Dennis

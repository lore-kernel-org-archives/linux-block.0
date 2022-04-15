Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 21:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiDOVJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiDOVJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 17:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10687DBD0F
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650056818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JV0FBdm7tqCQoUCwywcoxKy10EKetc4+nBiR3O/l8NY=;
        b=PXFawlUosMP0d8d2W+/3LlscFPaDGKzzAJO7PyY5ftdxIBZ5j3RlrliWQN5XPYOd10jE0M
        BVzny02KJuttufofekwrlGE5XP8FS7UMETTnExDqxRgk+0SWzSYABVq7QLLw6KGYeFjXdy
        WbC0NsUXnRbsBmmkniW/EhNJmZx2cRw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-MSwcI99oOQaM78SkSMto1w-1; Fri, 15 Apr 2022 17:06:57 -0400
X-MC-Unique: MSwcI99oOQaM78SkSMto1w-1
Received: by mail-qv1-f71.google.com with SMTP id dd5-20020ad45805000000b004461b16d4caso6351894qvb.16
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 14:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JV0FBdm7tqCQoUCwywcoxKy10EKetc4+nBiR3O/l8NY=;
        b=nhxhIrZN/OD/adUCbPrB+Y1A/KYytCtExw4Am3H5jNksu+6jc1XfmREWEo2vcza21r
         NA9wbJsWZ0u02I5xm3B5eepLoFzXAUa0fjFLeDr3p4FeJHYU9qq+bHJfywyTFtldoFd1
         rxOGbfLkYOsEN1XIt0NCVN4SP3vDnosaxhfzhJS8s3XJOlG4iNVDEZETZQJfttq9BOGk
         B030Trh3XU/APhQXMu16f7ZSMdZFKLhA7Jml57q/pV0va+4latBgM8vjZ77TFHv9dW91
         ni/m1cXqv2Nx53sag+LVSyvBvSV9NrCMkiBp1E2GrlPQ3Dqk1PpXkCd8cfxjVk0dTB2L
         +A4A==
X-Gm-Message-State: AOAM532Kw4NMpe31sdcvje6CgYzec0TMrakP4dQhq+sf9g/J7lsFNOHe
        JIdFXpUgM4r8eXoGu9CRti/tqqLy4pnPUTneiLAvRbtroqZueHOugoQ3a8bde4FapGhBiz5y7/t
        2m+cRI8+X6vhNgr43tXCKSA==
X-Received: by 2002:a05:6214:260e:b0:446:4518:7445 with SMTP id gu14-20020a056214260e00b0044645187445mr319563qvb.101.1650056816558;
        Fri, 15 Apr 2022 14:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7CMqmTjnyxGA/97jD6NAHM7pgxKQA/c+FLzxfl+dwSkkSqlLM6DmOcJ8Ra37lj3wR8513Cw==
X-Received: by 2002:a05:6214:260e:b0:446:4518:7445 with SMTP id gu14-20020a056214260e00b0044645187445mr319554qvb.101.1650056816357;
        Fri, 15 Apr 2022 14:06:56 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm3426950qti.20.2022.04.15.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:06:55 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:06:55 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <Ylneb0NWsCab0HqI@redhat.com>
References: <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
 <YlcPXslr6Y7cHOSU@redhat.com>
 <Yldsqh2YsclXYl3s@T590>
 <YleGKbZiHeBIJidI@redhat.com>
 <YlebwjTKH2MU9tCD@T590>
 <Ylhdvac5SY85r+1R@redhat.com>
 <Yli48LmLi7dEngLn@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yli48LmLi7dEngLn@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 14 2022 at  8:14P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Thu, Apr 14, 2022 at 01:45:33PM -0400, Mike Snitzer wrote:
> > On Wed, Apr 13 2022 at 11:57P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > On Wed, Apr 13, 2022 at 10:25:45PM -0400, Mike Snitzer wrote:
> > > > On Wed, Apr 13 2022 at  8:36P -0400,
> > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > 
> > > > > On Wed, Apr 13, 2022 at 01:58:54PM -0400, Mike Snitzer wrote:
> > > > > > 
> > > > > > The bigger issue with this patch is that you've caused
> > > > > > dm_submit_bio_remap() to go back to accounting the entire original bio
> > > > > > before any split occurs.  That is a problem because you'll end up
> > > > > > accounting that bio for every split, so in split heavy workloads the
> > > > > > IO accounting won't reflect when the IO is actually issued and we'll
> > > > > > regress back to having very inaccurate and incorrect IO accounting for
> > > > > > dm_submit_bio_remap() heavy targets (e.g. dm-crypt).
> > > > > 
> > > > > Good catch, but we know the length of mapped part in original bio before
> > > > > calling __map_bio(), so io->sectors/io->offset_sector can be setup here,
> > > > > something like the following delta change should address it:
> > > > > 
> > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > index db23efd6bbf6..06b554f3104b 100644
> > > > > --- a/drivers/md/dm.c
> > > > > +++ b/drivers/md/dm.c
> > > > > @@ -1558,6 +1558,13 @@ static int __split_and_process_bio(struct clone_info *ci)
> > > > >  
> > > > >  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
> > > > >  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> > > > > +
> > > > > +	if (ci->sector_count > len) {
> > > > > +		/* setup the mapped part for accounting */
> > > > > +		dm_io_set_flag(ci->io, DM_IO_SPLITTED);
> > > > > +		ci->io->sectors = len;
> > > > > +		ci->io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
> > > > > +	}
> > > > >  	__map_bio(clone);
> > > > >  
> > > > >  	ci->sector += len;
> > > > > @@ -1603,11 +1610,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
> > > > >  	if (error || !ci.sector_count)
> > > > >  		goto out;
> > > > >  
> > > > > -	/* setup the mapped part for accounting */
> > > > > -	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
> > > > > -	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
> > > > > -	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
> > > > > -
> > > > >  	bio_trim(bio, ci.io->sectors, ci.sector_count);
> > > > >  	trace_block_split(bio, bio->bi_iter.bi_sector);
> > > > >  	bio_inc_remaining(bio);
> > > > > 
> > > > > -- 
> > > > > Ming
> > > > > 
> > > > 
> > > > Unfortunately we do need splitting after __map_bio() because a dm
> > > > target's ->map can use dm_accept_partial_bio() to further reduce a
> > > > bio's mapped part.
> > > > 
> > > > But I think dm_accept_partial_bio() could be trained to update
> > > > tio->io->sectors?
> > > 
> > > ->orig_bio is just for serving io accounting, but ->orig_bio isn't
> > > passed to dm_accept_partial_bio(), and not gets updated after
> > > dm_accept_partial_bio() is called.
> > > 
> > > If that is one issue, it must be one existed issue in dm io accounting
> > > since ->orig_bio isn't updated when dm_accept_partial_bio() is called.
> > 
> > Recall that ->orig_bio is updated after the bio_split() at the bottom of
> > dm_split_and_process_bio().
> > 
> > That bio_split() is based on ci->sector_count, which is reduced as a
> > side-effect of dm_accept_partial_bio() reducing tio->len_ptr.  It is
> > pretty circuitous so I can absolutely understand why you didn't
> > immediately appreciate the interface.  The block comment above
> > dm_accept_partial_bio() does a pretty comprehensive job of explaining.
> 
> Go it now, thanks for the explanation.
> 
> As you mentioned, it can be addressed in dm_accept_partial_bio()
> by updating ti->io->sectors.

Yes, I rebased your patchset ontop of dm-5.19 and fixed up your
splitting like we discussed.  I'll be rebasing ontop of v5.18-rc3 once
it is released but please have a look at this 'dm-5.19-v2' branch:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19-v2

And this commit in particular:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19-v2&id=fe5a99da8b0d0518342f5cdb522a06b0f123ca09

Once I've verified with you that it looks OK I'll fold it into your
commit (at the same time I rebase on v5.18-rc3 early next week).

In general this rebase sucked.. but I wanted to layer your changes
ontop of earlier changes I had already staged for 5.19. I've at least
verified that DM's bio polling seems to work like usual and also
verified that cryptsetup's 'make check' passes.

No urgency on you reviewing before early next week.  Have a great
weekend.

Mike


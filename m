Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D380C4332F
	for <linux-block@archiver.kernel.org>; Sun, 17 Apr 2022 02:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiDQCZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiDQCZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 22:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0DA73F890
        for <linux-block@vger.kernel.org>; Sat, 16 Apr 2022 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650162173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByDiCpg32DJyEi8mcLFX5wGAkwDCrwjwCgGSWXhxCqw=;
        b=LqJ3Mqwtsh9FzcnKLGrewiIZSrTKMWpNhbc0XAx3iI7m/Sw4ACL/H5kdOixF9gTjvwdgSd
        P7QAfHuDFgTpPtSkFU8QlNPy1LgbON2jQ8lbhhR33+GYSC9xg3x8kLZDaCoLohsI5Me/HL
        ZcIWk/UfUZcnaukX/JDPUmiD1T5BIDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-1yazkfxuOmW75nm4vWDDcg-1; Sat, 16 Apr 2022 22:22:51 -0400
X-MC-Unique: 1yazkfxuOmW75nm4vWDDcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C666101AA44;
        Sun, 17 Apr 2022 02:22:51 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E86A6111DD0D;
        Sun, 17 Apr 2022 02:22:33 +0000 (UTC)
Date:   Sun, 17 Apr 2022 10:22:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <Ylt55PHHu6XShdfA@T590>
References: <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
 <YlcPXslr6Y7cHOSU@redhat.com>
 <Yldsqh2YsclXYl3s@T590>
 <YleGKbZiHeBIJidI@redhat.com>
 <YlebwjTKH2MU9tCD@T590>
 <Ylhdvac5SY85r+1R@redhat.com>
 <Yli48LmLi7dEngLn@T590>
 <Ylneb0NWsCab0HqI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylneb0NWsCab0HqI@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 15, 2022 at 05:06:55PM -0400, Mike Snitzer wrote:
> On Thu, Apr 14 2022 at  8:14P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Thu, Apr 14, 2022 at 01:45:33PM -0400, Mike Snitzer wrote:
> > > On Wed, Apr 13 2022 at 11:57P -0400,
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > > On Wed, Apr 13, 2022 at 10:25:45PM -0400, Mike Snitzer wrote:
> > > > > On Wed, Apr 13 2022 at  8:36P -0400,
> > > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > > 
> > > > > > On Wed, Apr 13, 2022 at 01:58:54PM -0400, Mike Snitzer wrote:
> > > > > > > 
> > > > > > > The bigger issue with this patch is that you've caused
> > > > > > > dm_submit_bio_remap() to go back to accounting the entire original bio
> > > > > > > before any split occurs.  That is a problem because you'll end up
> > > > > > > accounting that bio for every split, so in split heavy workloads the
> > > > > > > IO accounting won't reflect when the IO is actually issued and we'll
> > > > > > > regress back to having very inaccurate and incorrect IO accounting for
> > > > > > > dm_submit_bio_remap() heavy targets (e.g. dm-crypt).
> > > > > > 
> > > > > > Good catch, but we know the length of mapped part in original bio before
> > > > > > calling __map_bio(), so io->sectors/io->offset_sector can be setup here,
> > > > > > something like the following delta change should address it:
> > > > > > 
> > > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > > index db23efd6bbf6..06b554f3104b 100644
> > > > > > --- a/drivers/md/dm.c
> > > > > > +++ b/drivers/md/dm.c
> > > > > > @@ -1558,6 +1558,13 @@ static int __split_and_process_bio(struct clone_info *ci)
> > > > > >  
> > > > > >  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
> > > > > >  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> > > > > > +
> > > > > > +	if (ci->sector_count > len) {
> > > > > > +		/* setup the mapped part for accounting */
> > > > > > +		dm_io_set_flag(ci->io, DM_IO_SPLITTED);
> > > > > > +		ci->io->sectors = len;
> > > > > > +		ci->io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
> > > > > > +	}
> > > > > >  	__map_bio(clone);
> > > > > >  
> > > > > >  	ci->sector += len;
> > > > > > @@ -1603,11 +1610,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
> > > > > >  	if (error || !ci.sector_count)
> > > > > >  		goto out;
> > > > > >  
> > > > > > -	/* setup the mapped part for accounting */
> > > > > > -	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
> > > > > > -	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
> > > > > > -	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
> > > > > > -
> > > > > >  	bio_trim(bio, ci.io->sectors, ci.sector_count);
> > > > > >  	trace_block_split(bio, bio->bi_iter.bi_sector);
> > > > > >  	bio_inc_remaining(bio);
> > > > > > 
> > > > > > -- 
> > > > > > Ming
> > > > > > 
> > > > > 
> > > > > Unfortunately we do need splitting after __map_bio() because a dm
> > > > > target's ->map can use dm_accept_partial_bio() to further reduce a
> > > > > bio's mapped part.
> > > > > 
> > > > > But I think dm_accept_partial_bio() could be trained to update
> > > > > tio->io->sectors?
> > > > 
> > > > ->orig_bio is just for serving io accounting, but ->orig_bio isn't
> > > > passed to dm_accept_partial_bio(), and not gets updated after
> > > > dm_accept_partial_bio() is called.
> > > > 
> > > > If that is one issue, it must be one existed issue in dm io accounting
> > > > since ->orig_bio isn't updated when dm_accept_partial_bio() is called.
> > > 
> > > Recall that ->orig_bio is updated after the bio_split() at the bottom of
> > > dm_split_and_process_bio().
> > > 
> > > That bio_split() is based on ci->sector_count, which is reduced as a
> > > side-effect of dm_accept_partial_bio() reducing tio->len_ptr.  It is
> > > pretty circuitous so I can absolutely understand why you didn't
> > > immediately appreciate the interface.  The block comment above
> > > dm_accept_partial_bio() does a pretty comprehensive job of explaining.
> > 
> > Go it now, thanks for the explanation.
> > 
> > As you mentioned, it can be addressed in dm_accept_partial_bio()
> > by updating ti->io->sectors.
> 
> Yes, I rebased your patchset ontop of dm-5.19 and fixed up your
> splitting like we discussed.  I'll be rebasing ontop of v5.18-rc3 once
> it is released but please have a look at this 'dm-5.19-v2' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19-v2
> 
> And this commit in particular:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19-v2&id=fe5a99da8b0d0518342f5cdb522a06b0f123ca09
> 
> Once I've verified with you that it looks OK I'll fold it into your
> commit (at the same time I rebase on v5.18-rc3 early next week).

Hi Mike,

Your delta change looks good, thanks for fixing it!

Thanks,
Ming


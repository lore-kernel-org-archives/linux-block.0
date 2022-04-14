Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12754C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiDNRsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbiDNRsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 13:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E38EA343
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649958337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usx95EEwfrYdBbdBHcf5uEzhLX1K5ppp1W762nvmhf0=;
        b=dXzl0PFYPE/mxeStexcdzgPqhLhcaPblbxh3tDbQjvgprkJlHlgQhyDTXkj/AxmBtza1D9
        JN/uMXcVpWkhHapv5EISt0BpTG8dq5UD9Up0JSvm5NtunvfQQhPuWUzpPWwSz8wzTtajFq
        dsQewp2UnmtZcN+KAIT8PduhpHJytRY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-PebimWDyOpS7vGpCCl8pbw-1; Thu, 14 Apr 2022 13:45:36 -0400
X-MC-Unique: PebimWDyOpS7vGpCCl8pbw-1
Received: by mail-qk1-f198.google.com with SMTP id bi19-20020a05620a319300b0069c16295aabso3770178qkb.1
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 10:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usx95EEwfrYdBbdBHcf5uEzhLX1K5ppp1W762nvmhf0=;
        b=IWWhyP9bzIfrkDpqfUVccci2wKZXJdkCqHGnVS4GL7Z1ImCO7WxyT49GqQOUH5KVtY
         KoAUQ1XpQND27wbuh2AxyrTQCzxTUX/YyMo0L9772BGUlNF8kqQbPWM4DQNuL2k/UPP2
         9AtGJLpKMLg/59WjBllHmlzZIoLDp3jzGCSpBIMCxFBudS6gAe1kGxh4b7e1mkhR6dHM
         DVlpX8V5BvIWZ2bilgO2QfCqXNfrcO8lSkC7vD9+yd0j1Hb214XoiVYKPlilnI81nAp/
         8KxbZMDimZ3vJSH4pCHWNvOVWpC0SgR74r8WoknDpLFd1vLK/je9UwK6u8D3IAjDV57a
         7okg==
X-Gm-Message-State: AOAM530UUXuZ2Oq3uwrZzhTlM5EO9B8gzP1JSHLPbW9ozMpBfwhTzWbv
        Cd00jfn3NJeC/8JZX10MVj4fuqK4bmcPsyU3ZaDEJWPsEVrMpzjDpFJHzXiz0OJ7T3EhM5QSMWa
        KXCt+61mih5C6NUB9jmBPtg==
X-Received: by 2002:a05:6214:1194:b0:444:45d6:d79d with SMTP id t20-20020a056214119400b0044445d6d79dmr4402764qvv.36.1649958335398;
        Thu, 14 Apr 2022 10:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUpya9rdf13D61nFewCk4EkHcslczh8V8fddHYZSzprOrc5xsK/HVlJwVz8wlvQvvDIaifCw==
X-Received: by 2002:a05:6214:1194:b0:444:45d6:d79d with SMTP id t20-20020a056214119400b0044445d6d79dmr4402751qvv.36.1649958335179;
        Thu, 14 Apr 2022 10:45:35 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm440264qkc.19.2022.04.14.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:45:34 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:45:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <Ylhdvac5SY85r+1R@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
 <YlcPXslr6Y7cHOSU@redhat.com>
 <Yldsqh2YsclXYl3s@T590>
 <YleGKbZiHeBIJidI@redhat.com>
 <YlebwjTKH2MU9tCD@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlebwjTKH2MU9tCD@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13 2022 at 11:57P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Wed, Apr 13, 2022 at 10:25:45PM -0400, Mike Snitzer wrote:
> > On Wed, Apr 13 2022 at  8:36P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > On Wed, Apr 13, 2022 at 01:58:54PM -0400, Mike Snitzer wrote:
> > > > 
> > > > The bigger issue with this patch is that you've caused
> > > > dm_submit_bio_remap() to go back to accounting the entire original bio
> > > > before any split occurs.  That is a problem because you'll end up
> > > > accounting that bio for every split, so in split heavy workloads the
> > > > IO accounting won't reflect when the IO is actually issued and we'll
> > > > regress back to having very inaccurate and incorrect IO accounting for
> > > > dm_submit_bio_remap() heavy targets (e.g. dm-crypt).
> > > 
> > > Good catch, but we know the length of mapped part in original bio before
> > > calling __map_bio(), so io->sectors/io->offset_sector can be setup here,
> > > something like the following delta change should address it:
> > > 
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index db23efd6bbf6..06b554f3104b 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1558,6 +1558,13 @@ static int __split_and_process_bio(struct clone_info *ci)
> > >  
> > >  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
> > >  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> > > +
> > > +	if (ci->sector_count > len) {
> > > +		/* setup the mapped part for accounting */
> > > +		dm_io_set_flag(ci->io, DM_IO_SPLITTED);
> > > +		ci->io->sectors = len;
> > > +		ci->io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
> > > +	}
> > >  	__map_bio(clone);
> > >  
> > >  	ci->sector += len;
> > > @@ -1603,11 +1610,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
> > >  	if (error || !ci.sector_count)
> > >  		goto out;
> > >  
> > > -	/* setup the mapped part for accounting */
> > > -	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
> > > -	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
> > > -	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
> > > -
> > >  	bio_trim(bio, ci.io->sectors, ci.sector_count);
> > >  	trace_block_split(bio, bio->bi_iter.bi_sector);
> > >  	bio_inc_remaining(bio);
> > > 
> > > -- 
> > > Ming
> > > 
> > 
> > Unfortunately we do need splitting after __map_bio() because a dm
> > target's ->map can use dm_accept_partial_bio() to further reduce a
> > bio's mapped part.
> > 
> > But I think dm_accept_partial_bio() could be trained to update
> > tio->io->sectors?
> 
> ->orig_bio is just for serving io accounting, but ->orig_bio isn't
> passed to dm_accept_partial_bio(), and not gets updated after
> dm_accept_partial_bio() is called.
> 
> If that is one issue, it must be one existed issue in dm io accounting
> since ->orig_bio isn't updated when dm_accept_partial_bio() is called.

Recall that ->orig_bio is updated after the bio_split() at the bottom of
dm_split_and_process_bio().

That bio_split() is based on ci->sector_count, which is reduced as a
side-effect of dm_accept_partial_bio() reducing tio->len_ptr.  It is
pretty circuitous so I can absolutely understand why you didn't
immediately appreciate the interface.  The block comment above
dm_accept_partial_bio() does a pretty comprehensive job of explaining.

But basically dm_accept_partial_bio() provides DM targets access to
control DM core's splitting if they find that they cannot accommodate
the entirety of the clone bio that is sent to their ->map.
dm_accept_partial_bio() may only ever be called from a target's ->map

> So do we have to update it?
> 
> > 
> > dm_accept_partial_bio() has been around for a long time, it keeps
> > growing BUG_ONs that are actually helpful to narrow its use to "normal
> > IO", so it should be OK.
> > 
> > Running 'make check' in a built cryptsetup source tree should be a
> > good test for DM target interface functionality.
> 
> Care to share the test tree?

https://gitlab.com/cryptsetup/cryptsetup.git

> 
> > 
> > But there aren't automated tests for IO accounting correctness yet.
> 
> I did verify io accounting by running dm-thin with blk-throttle, and the
> observed throughput is same with expected setting. Running both small bs
> and large bs, so non-split and split code path are covered.
> 
> Maybe you can add this kind of test into dm io accounting automated test.

Yeah, something like that would be good.

Mike


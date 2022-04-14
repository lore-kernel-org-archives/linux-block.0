Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D8C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiDNC2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 22:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDNC2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 22:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35F1643AEE
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649903149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BQBb0f7oVDpvvl2qnf2tz1B/xNgX8iw6UNvB9T+NuU=;
        b=LfXdRuMr2t09RRUPHkVXGlpgyTdJ0b9xa/BLZM9JmIFZifEgVK77ih3SwE/w+lcWey4XU5
        xCxg3FRGD4g/VN95bD6rwsFl4yK5fRGYCqW8byMtQB8NYkY/hfcI3dw4qWWlUyjELxweRR
        7xAfYub91J8f9Gr3Q3w2b0/NjhJgr3o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-pzaIlTHgPbS0BQybCVdGGw-1; Wed, 13 Apr 2022 22:25:48 -0400
X-MC-Unique: pzaIlTHgPbS0BQybCVdGGw-1
Received: by mail-qt1-f197.google.com with SMTP id b22-20020ac84f16000000b002ef8943051eso2473191qte.0
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 19:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BQBb0f7oVDpvvl2qnf2tz1B/xNgX8iw6UNvB9T+NuU=;
        b=osXfk39/Nk5h5H/pnCzSlYId1TFefadHRkZHUOTJvl+2CieWFwwjQdkU+Qu14hWV8O
         5DdS6TsfJHc37xAyxnSlmo3K6ztZ15jHRlDoPQmOoHuVK26qBDUpDoSgOZHo+RKxM3cM
         kjxG0n1GNkGTb0YwM0CNtXiVJNkdB1djT0CTgHBik/Q7FavvTCmoDPP2ba145DYusMUX
         zngumYbi+Y43jgi+4BeIteQxjuBq0nYebGSh+1XqnMus9m4gPOHQ91Dae7v2nN5skBAS
         eWP3COfQSWdLOj2d5zGIVjoRrjaYIpAW4dRiRRinMc8H7Yd9fWv1TerxomGnyneRl289
         gXeQ==
X-Gm-Message-State: AOAM5326RcZ6J+/Mro+S7RZY7gLmLlGiuBcxJPBWoq11GQGH5Ea1T9jR
        pi/TUYA90IXbbzYXY5cWSlJpBsTQVByVK+0qFR9sfxFu8Y2vKRRxR2RVFbJ+jRaXP/gWctlZEMX
        P0zyIm9efqBE+VbEgHHJ8KQ==
X-Received: by 2002:a05:6214:2b07:b0:432:f7e6:e443 with SMTP id jx7-20020a0562142b0700b00432f7e6e443mr1521783qvb.125.1649903147624;
        Wed, 13 Apr 2022 19:25:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCuqBXHKIMDdwqi70OXn3SDNyKoxwtxfUD4IOVc8mGvD+IypAu5rmYFF1A9Y4bMUBx+TkJaQ==
X-Received: by 2002:a05:6214:2b07:b0:432:f7e6:e443 with SMTP id jx7-20020a0562142b0700b00432f7e6e443mr1521773qvb.125.1649903147426;
        Wed, 13 Apr 2022 19:25:47 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id e13-20020ac85dcd000000b002eb9458498esm426204qtx.95.2022.04.13.19.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:25:46 -0700 (PDT)
Date:   Wed, 13 Apr 2022 22:25:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YleGKbZiHeBIJidI@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
 <YlcPXslr6Y7cHOSU@redhat.com>
 <Yldsqh2YsclXYl3s@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yldsqh2YsclXYl3s@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13 2022 at  8:36P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Wed, Apr 13, 2022 at 01:58:54PM -0400, Mike Snitzer wrote:
> > 
> > The bigger issue with this patch is that you've caused
> > dm_submit_bio_remap() to go back to accounting the entire original bio
> > before any split occurs.  That is a problem because you'll end up
> > accounting that bio for every split, so in split heavy workloads the
> > IO accounting won't reflect when the IO is actually issued and we'll
> > regress back to having very inaccurate and incorrect IO accounting for
> > dm_submit_bio_remap() heavy targets (e.g. dm-crypt).
> 
> Good catch, but we know the length of mapped part in original bio before
> calling __map_bio(), so io->sectors/io->offset_sector can be setup here,
> something like the following delta change should address it:
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index db23efd6bbf6..06b554f3104b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1558,6 +1558,13 @@ static int __split_and_process_bio(struct clone_info *ci)
>  
>  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
>  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> +
> +	if (ci->sector_count > len) {
> +		/* setup the mapped part for accounting */
> +		dm_io_set_flag(ci->io, DM_IO_SPLITTED);
> +		ci->io->sectors = len;
> +		ci->io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
> +	}
>  	__map_bio(clone);
>  
>  	ci->sector += len;
> @@ -1603,11 +1610,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
>  	if (error || !ci.sector_count)
>  		goto out;
>  
> -	/* setup the mapped part for accounting */
> -	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
> -	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
> -	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
> -
>  	bio_trim(bio, ci.io->sectors, ci.sector_count);
>  	trace_block_split(bio, bio->bi_iter.bi_sector);
>  	bio_inc_remaining(bio);
> 
> -- 
> Ming
> 

Unfortunately we do need splitting after __map_bio() because a dm
target's ->map can use dm_accept_partial_bio() to further reduce a
bio's mapped part.

But I think dm_accept_partial_bio() could be trained to update
tio->io->sectors?

dm_accept_partial_bio() has been around for a long time, it keeps
growing BUG_ONs that are actually helpful to narrow its use to "normal
IO", so it should be OK.

Running 'make check' in a built cryptsetup source tree should be a
good test for DM target interface functionality.

But there aren't automated tests for IO accounting correctness yet.

Mike


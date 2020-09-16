Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC1C433E2
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 01:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D91F2078D
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 01:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm0EO52x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIPBsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 21:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgIPBsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 21:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600220902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNwe3HINJyW6+sh9yuOZWFbkL3eeDAROGcx98Bux1J8=;
        b=Pm0EO52xrZs17vDxbZDApNg4365BRQ0YJd8iMEjqvf4ZY7VIkQJ0gFvHMkZOni7/79as87
        hdzArwOO08t6NbF0H83cdUqK6uosEaQB/tlEyGpkSODBVSDEz3aLODYRIMGW6ZinAf7sGA
        YoZgKp2ljPrIWfCF0UapxG3kvXdwpas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-GI75HWNlOP2WJNlAV48f1Q-1; Tue, 15 Sep 2020 21:48:20 -0400
X-MC-Unique: GI75HWNlOP2WJNlAV48f1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61D1D1074664;
        Wed, 16 Sep 2020 01:48:19 +0000 (UTC)
Received: from T590 (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4B811002D69;
        Wed, 16 Sep 2020 01:48:07 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:48:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dm: unconditionally call blk_queue_split() in
 dm_process_bio()
Message-ID: <20200916014802.GC791425@T590>
References: <20200915172357.83215-1-snitzer@redhat.com>
 <20200915172357.83215-5-snitzer@redhat.com>
 <20200916010817.GB791425@T590>
 <20200916012813.GA23236@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916012813.GA23236@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 09:28:14PM -0400, Mike Snitzer wrote:
> On Tue, Sep 15 2020 at  9:08pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Tue, Sep 15, 2020 at 01:23:57PM -0400, Mike Snitzer wrote:
> > > blk_queue_split() has become compulsory from .submit_bio -- regardless
> > > of whether it is recursing.  Update DM core to always call
> > > blk_queue_split().
> > > 
> > > dm_queue_split() is removed because __split_and_process_bio() handles
> > > splitting as needed.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > > ---
> > >  drivers/md/dm.c | 45 +--------------------------------------------
> > >  1 file changed, 1 insertion(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index fb0255d25e4b..0bae9f26dc8e 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1530,22 +1530,6 @@ static int __send_write_zeroes(struct clone_info *ci, struct dm_target *ti)
> > >  	return __send_changing_extent_only(ci, ti, get_num_write_zeroes_bios(ti));
> > >  }
> > >  
> > > -static bool is_abnormal_io(struct bio *bio)
> > > -{
> > > -	bool r = false;
> > > -
> > > -	switch (bio_op(bio)) {
> > > -	case REQ_OP_DISCARD:
> > > -	case REQ_OP_SECURE_ERASE:
> > > -	case REQ_OP_WRITE_SAME:
> > > -	case REQ_OP_WRITE_ZEROES:
> > > -		r = true;
> > > -		break;
> > > -	}
> > > -
> > > -	return r;
> > > -}
> > > -
> > >  static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
> > >  				  int *result)
> > >  {
> > > @@ -1723,23 +1707,6 @@ static blk_qc_t __process_bio(struct mapped_device *md, struct dm_table *map,
> > >  	return ret;
> > >  }
> > >  
> > > -static void dm_queue_split(struct mapped_device *md, struct dm_target *ti, struct bio **bio)
> > > -{
> > > -	unsigned len, sector_count;
> > > -
> > > -	sector_count = bio_sectors(*bio);
> > > -	len = min_t(sector_t, max_io_len((*bio)->bi_iter.bi_sector, ti), sector_count);
> > > -
> > > -	if (sector_count > len) {
> > > -		struct bio *split = bio_split(*bio, len, GFP_NOIO, &md->queue->bio_split);
> > > -
> > > -		bio_chain(split, *bio);
> > > -		trace_block_split(md->queue, split, (*bio)->bi_iter.bi_sector);
> > > -		submit_bio_noacct(*bio);
> > > -		*bio = split;
> > > -	}
> > > -}
> > > -
> > >  static blk_qc_t dm_process_bio(struct mapped_device *md,
> > >  			       struct dm_table *map, struct bio *bio)
> > >  {
> > > @@ -1759,17 +1726,7 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
> > >  		}
> > >  	}
> > >  
> > > -	/*
> > > -	 * If in ->queue_bio we need to use blk_queue_split(), otherwise
> > > -	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
> > > -	 * won't be imposed.
> > > -	 */
> > > -	if (current->bio_list) {
> > > -		if (is_abnormal_io(bio))
> > > -			blk_queue_split(&bio);
> > > -		else
> > > -			dm_queue_split(md, ti, &bio);
> > > -	}
> > > +	blk_queue_split(&bio);
> > 
> > In max_io_len(), target boundary is taken into account when figuring out
> > the max io len. However, this info won't be used any more after
> > switching to blk_queue_split(). Is that one potential problem?
> 
> Thanks for your review.  But no, as the patch header says:
> "dm_queue_split() is removed because __split_and_process_bio() handles
> splitting as needed."
> 
> (__split_and_process_non_flush calls max_io_len, as does
> __process_abnormal_io by calling __send_changing_extent_only)
> 
> SO the blk_queue_split() bio will be further split if needed (due to
> DM target boundary, etc).

Thanks for your explanation.

Then looks there is double split issue since both blk_queue_split()
and __split_and_process_non_flush() may split bio from same bioset(md->queue->bio_split),
and this way may cause deadlock, see comment of bio_alloc_bioset(), especially
the paragraph of 'callers must never allocate more than 1 bio at a time
from this pool.'


Thanks,
Ming


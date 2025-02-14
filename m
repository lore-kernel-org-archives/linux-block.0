Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F0262171
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532005; cv=none; b=GF8s5cIyv09OKp8A+6jiYtNI8l52ZHQpfnHbDom8pIrLcaQCzZ5x9Kltn6T24YIrnrgSy7nYWQJWM3eUm07o3DnD9z/CuILt0l223rKMTywa/dOU4XDE1NDxdrI1g04XoxJENI9biCMvXS60u+qWZUosedqn9UmT/+6UehOeRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532005; c=relaxed/simple;
	bh=XWKrJhz6zxwo6vCkbOhF2YkLUgM5hHekZ+myhuDN/Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcJKP1xFdwrSRbAPKhO0uWI2M0uLfqdjkwC2o7HS1MagjlWyhwZpcCJHDJ8mVV6lE46ltHsoyfK1X6nL0D8YWQP8A9eqqMeKiaDrcIOZ9yqXk4dOWm0Tx2oDQqjhI1DuHho3mrH3KWyGFoaUF0Ulbj/xoJ/DNhXLc5Iig4nF820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IX+a4ax9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IX+a4ax9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739532002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qv3MW3fPjEXJ63WIDdOfydaF9xF2IwmlaQNlUGKVh2U=;
	b=IX+a4ax9bBgYiqe8unB4+uKCJ7TLmWoa/ieJGjfDVqMYR+k66FpshuthEkYP3y5/ngtJa6
	29VCuEiTB8i05xX16wYdVjJevR1Rvg95iRMQoD0F42wfWIlLKIa9+SFNx8oyaqEG8Nsl4u
	m23zBayfEMD/WFIgh/bIfpGEmYNy0V0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-r0nHVdYIMPeyoCw681ay0g-1; Fri,
 14 Feb 2025 06:20:00 -0500
X-MC-Unique: r0nHVdYIMPeyoCw681ay0g-1
X-Mimecast-MFC-AGG-ID: r0nHVdYIMPeyoCw681ay0g_1739531999
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20B9918EB2C6;
	Fri, 14 Feb 2025 11:19:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C44571800365;
	Fri, 14 Feb 2025 11:19:52 +0000 (UTC)
Date: Fri, 14 Feb 2025 19:19:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z68m0X9o3Mw_oPsU@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <ifgg2za26r6frfco4cky6wxywgdj3l7r6hx6sbqarizqltshfx@kccnmlr3x7nq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ifgg2za26r6frfco4cky6wxywgdj3l7r6hx6sbqarizqltshfx@kccnmlr3x7nq>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Feb 14, 2025 at 10:38:36AM +0100, Daniel Gomez wrote:
> On Mon, Feb 10, 2025 at 05:03:19PM +0100, Ming Lei wrote:
> > PAGE_SIZE is applied in some block device queue limits, this way is
> > very fragile and is wrong:
> > 
> > - queue limits are read from hardware, which is often one readonly
> > hardware property
> > 
> > - PAGE_SIZE is one config option which can be changed during build time.
> > 
> > In RH lab, it has been found that max segment size of some mmc card is
> > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> > 
> > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > as 4K(minimized PAGE_SIZE).
> > 
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: John Garry <john.g.garry@oracle.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- cover bio_split_rw_at()
> > 	- add BLK_MIN_SEGMENT_SIZE
> > 
> >  block/blk-merge.c      | 2 +-
> >  block/blk-settings.c   | 6 +++---
> >  block/blk.h            | 2 +-
> >  include/linux/blkdev.h | 1 +
> >  4 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 15cd231d560c..b55c52a42303 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> >  
> >  		if (nsegs < lim->max_segments &&
> >  		    bytes + bv.bv_len <= max_bytes &&
> > -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> > +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
> >  			nsegs++;
> >  			bytes += bv.bv_len;
> >  		} else {
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index c44dadc35e1e..539a64ad7989 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -303,7 +303,7 @@ int blk_validate_limits(struct queue_limits *lim)
> >  	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
> >  				lim->max_dev_sectors);
> >  	if (lim->max_user_sectors) {
> > -		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> > +		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
> >  			return -EINVAL;
> >  		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
> >  	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
> > @@ -341,7 +341,7 @@ int blk_validate_limits(struct queue_limits *lim)
> >  	 */
> >  	if (!lim->seg_boundary_mask)
> >  		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> > -	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> > +	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
> >  		return -EINVAL;
> >  
> >  	/*
> > @@ -362,7 +362,7 @@ int blk_validate_limits(struct queue_limits *lim)
> >  		 */
> >  		if (!lim->max_segment_size)
> >  			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> > -		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> > +		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
> >  			return -EINVAL;
> >  	}
> >  
> > diff --git a/block/blk.h b/block/blk.h
> > index 90fa5f28ccab..cbfa8a3d4e42 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -359,7 +359,7 @@ static inline bool bio_may_need_split(struct bio *bio,
> >  		const struct queue_limits *lim)
> >  {
> >  	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> > -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> > +		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > BLK_MIN_SEGMENT_SIZE;
> >  }
> >  
> >  /**
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 248416ecd01c..32188af4051e 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
> >  enum blk_default_limits {
> >  	BLK_MAX_SEGMENTS	= 128,
> >  	BLK_SAFE_MAX_SECTORS	= 255,
> > +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */
> 
> I think it would be useful to expose this value to the queue_limits and

Can you share it is useful for what?

> sysfs (and remove it from here). We can default it to PAGE_SIZE (as it has
> always been) and allow to overwrite it when the block driver initializes the

Which device driver needs to initialize it?

> limits. This allows to see we are not anymore in the range of PAGE_SIZE -
> max_segment_size 'world' but min_segment_size - max_segment_size one. Unless
> there's a reason to not increase queue_limits data struct?

Unless you provide one real hardware which needs this way, I don't think
the min_segment_size limit is useful.


Thanks,
Ming


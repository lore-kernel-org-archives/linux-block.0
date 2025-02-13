Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1220ADEE
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432071; cv=none; b=DobGs1PioyLr45y8ism/IFMtu1S0RbhYS+VxxlCEmoD/vYycGWSXVC1yYg/zFCi+qcg6Ycxjpkh9OiblMrOZ2Ta5y4o53kLwHOOxKzbb60Xga2r3yh5qMCscBovlOXAxzE0ptecXQL0JakY3uOqwt4U8aKWsTCut/Sh8t41Pz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432071; c=relaxed/simple;
	bh=7cACRMjK0SgEAnrgSmPxYW2EVnbu2Ydpgs3pXDmPo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUP2zwl4oIm0Ah6xHgUcDxtTFiBN4RmloW4wY9Peyrl6F2MNgmmC9alcrNyn/Bv6tEL0UQnLQvBD7n4Z/NHhBS/sSvDFL8Bl3oNtPx7iQOa+UYwHabdiWycMYrZKENt9fb1TANvcRlgdvgUMW2mLlsI1nrXpjDRMpjq9PUpk4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH1yDElh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH1yDElh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3029AC4CED1;
	Thu, 13 Feb 2025 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739432070;
	bh=7cACRMjK0SgEAnrgSmPxYW2EVnbu2Ydpgs3pXDmPo5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH1yDElhrRtmytOr8judkQgY3i7g9diCqxY8WfEt7ahk17uYJioLKm2L4LEspm2TW
	 BJy3sGxb08cdBEUHhVnuISqoV+V6LfhMsX8ZvtUDUSqk1apQY8AX/nMwtuvGhMHCT+
	 XcqvyaZts91MBfBEQ5/ELI6rP8mtwXD6IfiktRwp6peNyuzYfr5Xb6DGg1PlLaQFQS
	 g7Q+WG8Q+4OorSLlR3uvlfNsmTQPPxFAMNbiMi0qR55euxGgvgo1ywGneV4e9t68nj
	 zE0dr91jbL46GnFy3vbZvvU0ugDGUKTKmjnOFvCv4LqkPJFLiqVBSCwRbZph1NDxPe
	 Iru1rV9qbttWQ==
Date: Thu, 13 Feb 2025 08:34:28 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, 
	John Garry <john.g.garry@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	Keith Busch <kbusch@kernel.org>, Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qxnAEMeTVW-wK-@fedora>

On Tue, Feb 11, 2025 at 10:10:36AM +0100, Ming Lei wrote:
> On Mon, Feb 10, 2025 at 12:17:07PM -0800, Luis Chamberlain wrote:
> > On Mon, Feb 10, 2025 at 05:03:19PM +0800, Ming Lei wrote:
> > > PAGE_SIZE is applied in some block device queue limits, this way is
> > > very fragile and is wrong:
> > > 
> > > - queue limits are read from hardware, which is often one readonly
> > > hardware property
> > > 
> > > - PAGE_SIZE is one config option which can be changed during build time.
> > 
> > This is true.
> > 
> > > In RH lab, it has been found that max segment size of some mmc card is
> > > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> > 
> > This is true, but check the note on block/blk-merge.c blk_bvec_map_sg().
> > It would seem that this is a limitation of MMC/SD and that this should
> > ideally be fixed.
> 
> The mmc card works just fine in case of 4K page size, there isn't any
> limitation for the mmc/ssd from storage viewpoint, the failure is just
> because this card's max segment size is < 64KB in case of 64K page size.
> 
> > 
> > > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > > as 4K(minimized PAGE_SIZE).
> > 
> > But indeed if the block driver isn't yet fixed, then sure, we have to
> > deal with the issue, I am not convinced that the logic below addresses
> > this in a generic way, rather it seems to conflate the areas where we
> > do need the generic block layer min defined, and when we have a block
> > min segment limit.
> > 
> > > Cc: Yi Zhang <yi.zhang@redhat.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: John Garry <john.g.garry@oracle.com>
> > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > Cc: Keith Busch <kbusch@kernel.org>
> > > Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > > V2:
> > > 	- cover bio_split_rw_at()
> > > 	- add BLK_MIN_SEGMENT_SIZE
> > > 
> > >  block/blk-merge.c      | 2 +-
> > >  block/blk-settings.c   | 6 +++---
> > >  block/blk.h            | 2 +-
> > >  include/linux/blkdev.h | 1 +
> > >  4 files changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index 15cd231d560c..b55c52a42303 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> > >  
> > >  		if (nsegs < lim->max_segments &&
> > >  		    bytes + bv.bv_len <= max_bytes &&
> > > -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> > > +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
> > >  			nsegs++;
> > >  			bytes += bv.bv_len;
> > 
> > I'll note that the 64k BLK_MAX_SEGMENT_SIZE is an old "odd historic" default
> > value, ie, not a documented hard limit but some odd old thing which
> > blk_validate_limits() encourages block drivers to override, so a soft
> > max.
> 
> BLK_MAX_SEGMENT_SIZE is default or fallback max segment size if the hardware
> doesn't provide this limit, so nothing odd here because block layer has
> to use something reasonable here.
> 
> > 
> > That said, if we validate this soft max and if you also validate the min
> 
> There isn't soft max segment size.
> 
> > shouldn't value in the above instead be lim->max_segment_size instead,
> 
> min segment size is page_size and it is soft, and has been applied
> for long time. This patch just fixes it as 4k(min(page_size)).
> 
> > provided that we also address the coment in blk_bvec_map_sg()?
> 
> The comment in blk_bvec_map_sg() has been removed, and blk_bvec_map_sg
> has been re-written in commit b7175e24d6ac ("block: add a dma mapping
> iterator") by following segment limits only.

Would it be possible for the driver to split the minimum segment size, PAGE_SIZE
(64k in your case), into smaller chunks that your hardware supports? For
example, NVMe supports 512-byte I/Os while maintaining the minimum segment
boundary at 4k.

> 
> > 
> > More forward looking -- are you using BLK_MIN_SEGMENT_SIZE here due to
> > the same mmc/sd limitations ? Can we overcome the mmc/sd limitations by
> > only using this BLK_MIN_SEGMENT_SIZE only on block drivers which have the
> > scatterlists limitation?
> 
> Please see my comment above, the mmc card doesn't have any limitation,
> it is just that its max segment size is < 64K, which is absolutely
> allowed from storage viewpoint.
> 
> 
> Thanks, 
> Ming
> 

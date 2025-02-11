Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090926BD97
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239857; cv=none; b=KeupBuGTKk8fdEy7JfwSN/kYxnQbkMFudzkJOV377sNPIGyvNXKV9QdlBovNSoCc2xxyXRuIe1Q6y4yKaq5enj1rfRWfbGpKvosRy2/9Aca4yJyixQjdO+L8x9JJcNyxvrpVRzXC7lUoI0GtVcyHvmHjti0p5goWdVrDzjKfZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239857; c=relaxed/simple;
	bh=G3HykhtYVyfzFOFLBoG8rE11HjGSrrQWFGaot0gnkHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd7/6nUW/pMaazcTSqFlWwn4ZbgnC73Ofin0aQN7GSPpi2CX81NeP8gIO3OTRVAvO7vBHUkBOAXbmHQJ9atInTxsqs52WHS2tcG57Uu1HjaUSclOv9LHTiOWwt5vtMQHiQcAjp2xXPQc2b6YhXTZp+ysca9HOOiUjsOXPqhWjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhO9svYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhO9svYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739239854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bo0N8Gcm+lPnMsC7LF3je0++T3EKGJ6mYbFKX8DKF1Q=;
	b=KhO9svYwRq88Dcx8N7wdR95XVfhP90mE5TaNEZgrfOkv65JAnzqtRrn5N5Pa24oI6swc7G
	gZ06qO/Ft8saT3btmzfnPea/bhcVSrvGoIKwclbXP9Qf0a3xfhCgJz9o9DmJS++OWRpFt5
	3ssVLd7ptbUJagvu6qyHByBdvgHj+zo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-CnyoPuCwNxmMcuPjf5oxLw-1; Mon,
 10 Feb 2025 21:10:50 -0500
X-MC-Unique: CnyoPuCwNxmMcuPjf5oxLw-1
X-Mimecast-MFC-AGG-ID: CnyoPuCwNxmMcuPjf5oxLw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA841800874;
	Tue, 11 Feb 2025 02:10:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D10C1800570;
	Tue, 11 Feb 2025 02:10:41 +0000 (UTC)
Date: Tue, 11 Feb 2025 10:10:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z6qxnAEMeTVW-wK-@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6peww6d3EP5-B8n@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 10, 2025 at 12:17:07PM -0800, Luis Chamberlain wrote:
> On Mon, Feb 10, 2025 at 05:03:19PM +0800, Ming Lei wrote:
> > PAGE_SIZE is applied in some block device queue limits, this way is
> > very fragile and is wrong:
> > 
> > - queue limits are read from hardware, which is often one readonly
> > hardware property
> > 
> > - PAGE_SIZE is one config option which can be changed during build time.
> 
> This is true.
> 
> > In RH lab, it has been found that max segment size of some mmc card is
> > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> 
> This is true, but check the note on block/blk-merge.c blk_bvec_map_sg().
> It would seem that this is a limitation of MMC/SD and that this should
> ideally be fixed.

The mmc card works just fine in case of 4K page size, there isn't any
limitation for the mmc/ssd from storage viewpoint, the failure is just
because this card's max segment size is < 64KB in case of 64K page size.

> 
> > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > as 4K(minimized PAGE_SIZE).
> 
> But indeed if the block driver isn't yet fixed, then sure, we have to
> deal with the issue, I am not convinced that the logic below addresses
> this in a generic way, rather it seems to conflate the areas where we
> do need the generic block layer min defined, and when we have a block
> min segment limit.
> 
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
> 
> I'll note that the 64k BLK_MAX_SEGMENT_SIZE is an old "odd historic" default
> value, ie, not a documented hard limit but some odd old thing which
> blk_validate_limits() encourages block drivers to override, so a soft
> max.

BLK_MAX_SEGMENT_SIZE is default or fallback max segment size if the hardware
doesn't provide this limit, so nothing odd here because block layer has
to use something reasonable here.

> 
> That said, if we validate this soft max and if you also validate the min

There isn't soft max segment size.

> shouldn't value in the above instead be lim->max_segment_size instead,

min segment size is page_size and it is soft, and has been applied
for long time. This patch just fixes it as 4k(min(page_size)).

> provided that we also address the coment in blk_bvec_map_sg()?

The comment in blk_bvec_map_sg() has been removed, and blk_bvec_map_sg
has been re-written in commit b7175e24d6ac ("block: add a dma mapping
iterator") by following segment limits only.

> 
> More forward looking -- are you using BLK_MIN_SEGMENT_SIZE here due to
> the same mmc/sd limitations ? Can we overcome the mmc/sd limitations by
> only using this BLK_MIN_SEGMENT_SIZE only on block drivers which have the
> scatterlists limitation?

Please see my comment above, the mmc card doesn't have any limitation,
it is just that its max segment size is < 64K, which is absolutely
allowed from storage viewpoint.


Thanks, 
Ming


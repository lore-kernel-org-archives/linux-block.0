Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77A20B802
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433787; cv=none; b=q4PM9C16jVmkkfE6vXTqEn8y8/bDKqk4E1EFip9mG0ZtKLeCkxtU5nHA5e1clBO8nwfFxYx0MmLGjNx7btAheguNSQIQOn8xqoQatzBLAZ6icrbnCVEclDdGGE21uUdcZPJg/x0k0cM+SQy/FUgsjPvyi+TR0u6V0c1G6ax8rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433787; c=relaxed/simple;
	bh=VB+bp+1rP0Qf9Xd2cS8fE3c0fSZOq8/HTlSEv/IN/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukx3vWPp8c2WvH6jAvpWsCRFgDLh/Z0gasaFuroqqKfeHPKs/09G1//Giyxge8inUsnuIPRvvDI4E9pZdh1duJEB2N5kJPB/dDbLavIv0q325nTS70D3e63U6QLU2/pJI37xYi31XnqV1nITQ2WxG8ehjO/5an6VuJJRxhqZOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amH0nVnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amH0nVnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739433784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rU5lrJwbvejDzmw+pfNX1/cElrrJJDDfBNONzCldOA=;
	b=amH0nVnB7FYAZ89QzMoauRLzp7X+NgvDB7xHEoF5TZU1uQO4umRMIuJe3oBig7KElWwp+T
	M4tAqL9mBiPMY/MogGbPkyDW9Xrfx+eAYia1zr3VkK0xq+Xh/aB1QzY63rXG4ZaEyJxK8A
	Enj+ZuVqutIG0la9knPEzvEIE/+Slic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-eKN-s3k1OjCve4byEKEdmw-1; Thu,
 13 Feb 2025 03:03:01 -0500
X-MC-Unique: eKN-s3k1OjCve4byEKEdmw-1
X-Mimecast-MFC-AGG-ID: eKN-s3k1OjCve4byEKEdmw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D503D1800877;
	Thu, 13 Feb 2025 08:02:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7F4918004A7;
	Thu, 13 Feb 2025 08:02:52 +0000 (UTC)
Date: Thu, 13 Feb 2025 16:02:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z62nJqXu_et99D02@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
 <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 13, 2025 at 08:34:28AM +0100, Daniel Gomez wrote:
> On Tue, Feb 11, 2025 at 10:10:36AM +0100, Ming Lei wrote:
> > On Mon, Feb 10, 2025 at 12:17:07PM -0800, Luis Chamberlain wrote:
> > > On Mon, Feb 10, 2025 at 05:03:19PM +0800, Ming Lei wrote:
> > > > PAGE_SIZE is applied in some block device queue limits, this way is
> > > > very fragile and is wrong:
> > > > 
> > > > - queue limits are read from hardware, which is often one readonly
> > > > hardware property
> > > > 
> > > > - PAGE_SIZE is one config option which can be changed during build time.
> > > 
> > > This is true.
> > > 
> > > > In RH lab, it has been found that max segment size of some mmc card is
> > > > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> > > 
> > > This is true, but check the note on block/blk-merge.c blk_bvec_map_sg().
> > > It would seem that this is a limitation of MMC/SD and that this should
> > > ideally be fixed.
> > 
> > The mmc card works just fine in case of 4K page size, there isn't any
> > limitation for the mmc/ssd from storage viewpoint, the failure is just
> > because this card's max segment size is < 64KB in case of 64K page size.
> > 
> > > 
> > > > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > > > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > > > as 4K(minimized PAGE_SIZE).
> > > 
> > > But indeed if the block driver isn't yet fixed, then sure, we have to
> > > deal with the issue, I am not convinced that the logic below addresses
> > > this in a generic way, rather it seems to conflate the areas where we
> > > do need the generic block layer min defined, and when we have a block
> > > min segment limit.
> > > 
> > > > Cc: Yi Zhang <yi.zhang@redhat.com>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: John Garry <john.g.garry@oracle.com>
> > > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > > Cc: Keith Busch <kbusch@kernel.org>
> > > > Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > > V2:
> > > > 	- cover bio_split_rw_at()
> > > > 	- add BLK_MIN_SEGMENT_SIZE
> > > > 
> > > >  block/blk-merge.c      | 2 +-
> > > >  block/blk-settings.c   | 6 +++---
> > > >  block/blk.h            | 2 +-
> > > >  include/linux/blkdev.h | 1 +
> > > >  4 files changed, 6 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > > index 15cd231d560c..b55c52a42303 100644
> > > > --- a/block/blk-merge.c
> > > > +++ b/block/blk-merge.c
> > > > @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> > > >  
> > > >  		if (nsegs < lim->max_segments &&
> > > >  		    bytes + bv.bv_len <= max_bytes &&
> > > > -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> > > > +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
> > > >  			nsegs++;
> > > >  			bytes += bv.bv_len;
> > > 
> > > I'll note that the 64k BLK_MAX_SEGMENT_SIZE is an old "odd historic" default
> > > value, ie, not a documented hard limit but some odd old thing which
> > > blk_validate_limits() encourages block drivers to override, so a soft
> > > max.
> > 
> > BLK_MAX_SEGMENT_SIZE is default or fallback max segment size if the hardware
> > doesn't provide this limit, so nothing odd here because block layer has
> > to use something reasonable here.
> > 
> > > 
> > > That said, if we validate this soft max and if you also validate the min
> > 
> > There isn't soft max segment size.
> > 
> > > shouldn't value in the above instead be lim->max_segment_size instead,
> > 
> > min segment size is page_size and it is soft, and has been applied
> > for long time. This patch just fixes it as 4k(min(page_size)).
> > 
> > > provided that we also address the coment in blk_bvec_map_sg()?
> > 
> > The comment in blk_bvec_map_sg() has been removed, and blk_bvec_map_sg
> > has been re-written in commit b7175e24d6ac ("block: add a dma mapping
> > iterator") by following segment limits only.
> 
> Would it be possible for the driver to split the minimum segment size, PAGE_SIZE
> (64k in your case), into smaller chunks that your hardware supports? For
> example, NVMe supports 512-byte I/Os while maintaining the minimum segment
> boundary at 4k.

The problem[1] is that this kind of mmc card fails to be recognized as
block disk. Block layer io split code can handle this case actually.

Just because max segment size of the card is < 64K when PAGE_SIZE is
configured as 64K, the issue is in block layer limit validation code.

For mmc card, it isn't strange to see small max_segment_size.


[1] dmesg

[    5.461130] WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0
[    5.461152] Modules linked in: mmc_block(+) rpmb_core crct10dif_ce ghash_ce sha2_ce dw_mmc_bluefield sha256_arm64 dw_mmc_pltfm sha1_ce dw_mmc mmc_core nfit i2c_mlxbf sbsa_gwdt gpio_mlxbf2 libnvdimm mlxbf_tmfifo dm_mirror dm_region_hash dm_log dm_mod
[    5.492042] CPU: 2 UID: 0 PID: 397 Comm: (udev-worker) Not tainted 6.12.0-39.el10.aarch64+64k #1
[    5.492050] Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS BlueField:3.5.1-1-g4078432 Jan 28 2021
         Starting
system[    5.492054] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.492058] pc : blk_validate_limits+0x364/0x3c0
d-vconsole-setup.service
 - V[    5.492075] lr : blk_set_default_limits+0x20/0x40
irtual Console Setup...
[    5.492079] sp : ffff80008688f2d0
[    5.539494] x29: ffff80008688f2d0 x28: ffff000082acb600 x27: ffff80007bef02a8
[    5.546622] x26: ffff80007bef0000 x25: ffff80008688f58e x24: ffff80008688f450
[    5.553752] x23: ffff80008301b000 x22: 00000000ffffffff x21: ffff800082c39950
[    5.553759] x20: 0000000000000000 x19: ffff0000930169e0 x18: 0000000000000014
[    5.553765] x17: 00000000767472b1 x16: 0000000005a697e6 x15: 0000000002f42ca4
[    5.585117] x11: 00000000de7f0111 x10: 000000005285b53a x9 : ffff800080752908
[    5.595019] x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000200
[    5.605003] x5 : 0000000000000000 x4 : 000000000000ffff x3 : 0000000000004000
[    5.612556] x2 : 0000000000000200 x1 : 0000000000001000 x0 : ffff80008688f450
[    5.619684] Call trace:
[    5.622121]  blk_validate_limits+0x364/0x3c0
[    5.626391]  blk_set_default_limits+0x20/0x40
[    5.630737]  blk_alloc_queue+0x84/0x240
[    5.634562]  blk_mq_alloc_queue+0x80/0x118
[    5.638648]  __blk_mq_alloc_disk+0x28/0x198
[    5.642820]  mmc_alloc_disk+0xe0/0x260 [mmc_block]
...
[    5.751521] mmcblk mmc0:0001: probe with driver mmcblk failed with error -22


Thanks,
Ming


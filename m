Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FC234973
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878954; cv=none; b=BzaM7O9B7C/2L4WAj17Q5rAngzAsVkpa/BnTE2UmQbpT1JloflrAUgRmpw2MHAH4wO3SxdkcT4itbEZIaAtg37GVGPD+vTweF9EjL+nWDgW4FEfxeqGxmAknz3NAJKrJWp0krZCD23M5IYZxD+XBCpLEhEAmrs2XssMiI8wGS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878954; c=relaxed/simple;
	bh=nLON6OfheZoBGSaV+zb7P5m2lREsip+QHnzT3BueioE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B67FL3Hn4q2+1AVzmJZ/ov+7RjVceEcJXgj4oBmLbQhnrOiDXxwEWt0FApOO8b7kZUoVrbYpEj94wpG1Z2rWBxDJBaHTuRZABsC4kGRchsrku+2igWSoS1JjoEenYTdH76bJ/7qZLrg6vipgVMnnOPztDg9a1ec+4BbQFNB7zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdofT6kS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdofT6kS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739878952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVbiJw9ZXWSOtamTFj0uJ13pFBmoga0GCAH41APqy8E=;
	b=UdofT6kShfnIWKrQRH0QAKd5CELFn/fUNZMdPbW3AKwxOm6+Gvq5cejU1/KxbpPHPbwabm
	5m/JGhkbzWYYKsrQnchDgAwurtrIY4L6hbwBwlJheDfeJ/H8tRpKEvQ//e9JP4sdwdSIG0
	uwCgNOwl+dW7KnG3NQolpCYM5sG10bk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-FHOCpATXOMOjJe-VE3HHBw-1; Tue,
 18 Feb 2025 06:42:28 -0500
X-MC-Unique: FHOCpATXOMOjJe-VE3HHBw-1
X-Mimecast-MFC-AGG-ID: FHOCpATXOMOjJe-VE3HHBw_1739878946
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C42A18D95DC;
	Tue, 18 Feb 2025 11:42:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D0B1800352;
	Tue, 18 Feb 2025 11:42:18 +0000 (UTC)
Date: Tue, 18 Feb 2025 19:42:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7RyFb6SkxDGzlY_@fedora>
References: <20250213120040.2271709-1-ming.lei@redhat.com>
 <rthanqn7zv66456urv23nh36l7rhdav2ubldz4e3r5e52ow5a5@dicfrbdak5ia>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rthanqn7zv66456urv23nh36l7rhdav2ubldz4e3r5e52ow5a5@dicfrbdak5ia>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 18, 2025 at 11:42:43AM +0100, Daniel Gomez wrote:
> On Thu, Feb 13, 2025 at 08:00:40PM +0100, Ming Lei wrote:
> > PAGE_SIZE is applied in validating block device queue limits, this way is
> > very fragile and is wrong:
> > 
> > - queue limits are read from hardware, which is often one readonly hardware
> > property
> > 
> > - PAGE_SIZE is one config option which can be changed during build time.
> > 
> > In RH lab, it has been found that max segment size of some mmc card is
> > less than 64K, then this kind of card can't be probed successfully when
> > same kernel is re-built with 64K PAGE_SIZE.
> > 
> > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > with queue limits and checking if bio needn't split as a hint. Define
> > BLK_MIN_SEGMENT_SIZE as 4K(minimized PAGE_SIZE).
> > 
> > The following commits are depended for backporting:
> > 
> > commit 6aeb4f836480 ("block: remove bio_add_pc_page")
> > commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
> > commit b7175e24d6ac ("block: add a dma mapping iterator")
> > 
> > Cc: Paul Bunyan <pbunyan@redhat.com>
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: John Garry <john.g.garry@oracle.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V3:
> > 	- rephrase commit log & fix patch style(Christoph)
> > 	- more comment log(Christoph)
> > V2:
> > 	- cover bio_split_rw_at()
> > 	- add BLK_MIN_SEGMENT_SIZE
> > 
> >  block/blk-merge.c      | 2 +-
> >  block/blk-settings.c   | 6 +++---
> >  block/blk.h            | 8 ++++++--
> >  include/linux/blkdev.h | 2 ++
> >  4 files changed, 12 insertions(+), 6 deletions(-)
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
> 
> In which cases this "new" condition (for systems where PAGE_SIZE >
> BLK_MIN_SEGMENT_SIZE) is going to be true? In my test case below, is always

Yes.

> false, so it defaults to the else path. And I think that is going to be the
> "normal" case in these systems, is that right?

It depends on block size in your workload.

> 
> Doing a 'quick' test using next-20250213 on a 16k PAGE_SIZE system with the NVMe
> driver and a 4k lbs disk + ~1h fio sequential writes, I get results indicating
> a write performance degradation of ~0.8%. This is due to the new loop condition
> doing 4k steps rather than PS. I guess it's going to be slighly worse the larger
> the PAGE_SIZE the system is, and bio? So, why not decreasing the minimum segment

No, just one extra bvec_split_segs() is called once for any >4k page size 

Probably the opposite, effect on 64K page size could be smaller since
bio may have less bvec on same workload.

> size for the cases it's actually needed rather than making it now the default?
> 
> I've measured bio_split_rw_at latency in the above test with the following
> results:

Fine, I will add one min segment size for covering this case since you care the
little perf drop on >4k PAGE_SIZE. 


Thanks,
Ming


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3222A1FA
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007456; cv=none; b=EjCsbmME9HnGaCTRRiH5MMnj7Ei4000/mM/tZ2TkIJzrLFyDOUGuuYCpGCHYZqAOdgblDdOeIryVtdbgiRPsqtzvYfXooFJqfbB410wEzWO3MQydy49rpJQk5sM8Y/dKPsX6/3LRGXD0RSTvKIspv8NO4+9EIZLRlEpj32LEmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007456; c=relaxed/simple;
	bh=cwrTmxEF1sLoQAgJe+tsNzSYnTxLgmeMkbxo81pfIhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKEPvuh91nRjohzvBiR0CZYtQvcD7jGZIJ9HZRFlEQfgdLG5uZYNLFDXOfq1ByrYfcvesmEIpj9gB1RWWW1gsO/0yBWP8iXumWcqjRa6b0pvSIlv1s8RWZRKv3PyFFyHnw1j6htSL3E6SBjOYpCVdoNgBLm4oEdT9NMz8A+uJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qjbUx8XY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjbUx8XY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6doQPpYhjYjpofhzi8sE2USoJ4axG1fgmnATV43tg0I=; b=qjbUx8XYc7NgPims4diFcCqcfb
	ONNvdqx+s0DHxR7MNnuKg8/e4EF1huUJ0yl5py2OBflVbcZ75daRSNO7X3lLF7C+HZxxTYkFxczBa
	x9dmlMPlKWxuUEPCZelqs/h/PGBIrh5gtExekdzFOIVDGo6I51dPLlcCucplxO5dycaQb5/tyf9PH
	CTYXnSE0qsS5emSTdS2fAsAasw4vzc02XyoH52XYSdlgSiLY82WSLD+6VWs7HV7JnV/VhuBp9NLrm
	UBq32ijIq7om8FJLbVEuxE08EMVcjfXTWiuRqcyh0jYWRCMSPEyLzEa6aajRWBvyNnqpeYyRE191d
	0Fb1wung==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISab-00000003yzp-375K;
	Fri, 23 May 2025 13:37:33 +0000
Date: Fri, 23 May 2025 06:37:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB6Hdp9ZQ1gX5gr@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB3lSQRLxjDHTSE@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 07:26:45AM -0600, Keith Busch wrote:
> > Urrgg.  Please don't overload the bio_vec. We've been working hard to
> > generalize it and share the data structures with more users in the
> > block layer. 
> 
> Darn, this part of the proposal is really the core concept of this patch
> set that everything builds around. It's what allows submitting
> arbitrarily large sized copy requests and letting the block layer
> efficiently split a bio to the queue limits later.

Well, you can still do that without overloading the bio_bvec by just
making bi_io_vec in the bio itself a union.

> 
> > If having a bio for each source range is too much overhead
> > for your user case (but I'd like to numbers for that), we'll need to
> > find a way to do that without overloading the actual bio_vec structure.
> 
> Getting good numbers might be a problem in the near term. The current
> generation of devices I have access to that can do copy offload don't
> have asic support for it, so it is instrumented entirely in firmware.
> The performance is currently underwhelming, but I expect next generation
> to be much better.

I meant numbers for the all in one bio vs multiple bios approach.
For hardware I think the main benefit is to not use host dram
bandwith.

Anyway, below is a patch to wire it up to the XFS garbage collection
daemin.  It survices the xfstests test cases for GC when run on a
conventional device, but otherwise I've not done much testing with it.

It shows two things, though:

 - right now there is block layer merging, and we always see single
   range bios.  That is really annoying, and fixing the fs code to
   submit multiple ranges in one go would be really annoying, as
   extent-based completions hang off the bio completions.  So I'd
   really like to block layer merges similar to what the old
   multi-bio code or the discard code do.
 - copy also needs to be handled by the zoned write plugs
 - bio_add_copy_src not updating bi_size is unexpected and annoying :)

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index 8c541ca71872..e7dfdbbcf126 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -158,6 +158,8 @@ struct xfs_zone_gc_data {
 	 * Iterator for the victim zone.
 	 */
 	struct xfs_zone_gc_iter		iter;
+
+	bool				can_copy;
 };
 
 /*
@@ -212,12 +214,19 @@ xfs_zone_gc_data_alloc(
 	if (bioset_init(&data->bio_set, 16, offsetof(struct xfs_gc_bio, bio),
 			BIOSET_NEED_BVECS))
 		goto out_free_recs;
-	for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++) {
-		data->scratch[i].folio =
-			folio_alloc(GFP_KERNEL, get_order(XFS_GC_CHUNK_SIZE));
-		if (!data->scratch[i].folio)
-			goto out_free_scratch;
+
+	if (bdev_copy_sectors(mp->m_rtdev_targp->bt_bdev)) {
+		xfs_info(mp, "using copy offload");
+		data->can_copy = true;
+	} else {
+		for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++) {
+			data->scratch[i].folio = folio_alloc(GFP_KERNEL,
+					get_order(XFS_GC_CHUNK_SIZE));
+			if (!data->scratch[i].folio)
+				goto out_free_scratch;
+		}
 	}
+
 	INIT_LIST_HEAD(&data->reading);
 	INIT_LIST_HEAD(&data->writing);
 	INIT_LIST_HEAD(&data->resetting);
@@ -241,8 +250,10 @@ xfs_zone_gc_data_free(
 {
 	int			i;
 
-	for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++)
-		folio_put(data->scratch[i].folio);
+	if (!data->can_copy) {
+		for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++)
+			folio_put(data->scratch[i].folio);
+	}
 	bioset_exit(&data->bio_set);
 	kfree(data->iter.recs);
 	kfree(data);
@@ -589,6 +600,8 @@ static unsigned int
 xfs_zone_gc_scratch_available(
 	struct xfs_zone_gc_data	*data)
 {
+	if (data->can_copy)
+		return UINT_MAX;
 	return XFS_GC_CHUNK_SIZE - data->scratch[data->scratch_idx].offset;
 }
 
@@ -690,7 +703,10 @@ xfs_zone_gc_start_chunk(
 		return false;
 	}
 
-	bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ, GFP_NOFS, &data->bio_set);
+	bio = bio_alloc_bioset(bdev, 1,
+			data->can_copy ? REQ_OP_COPY : REQ_OP_READ,
+			GFP_NOFS, &data->bio_set);
+	bio->bi_end_io = xfs_zone_gc_end_io;
 
 	chunk = container_of(bio, struct xfs_gc_bio, bio);
 	chunk->ip = ip;
@@ -700,21 +716,38 @@ xfs_zone_gc_start_chunk(
 		xfs_rgbno_to_rtb(iter->victim_rtg, irec.rm_startblock);
 	chunk->new_daddr = daddr;
 	chunk->is_seq = is_seq;
-	chunk->scratch = &data->scratch[data->scratch_idx];
 	chunk->data = data;
 	chunk->oz = oz;
 
-	bio->bi_iter.bi_sector = xfs_rtb_to_daddr(mp, chunk->old_startblock);
-	bio->bi_end_io = xfs_zone_gc_end_io;
-	bio_add_folio_nofail(bio, chunk->scratch->folio, chunk->len,
-			chunk->scratch->offset);
-	chunk->scratch->offset += chunk->len;
-	if (chunk->scratch->offset == XFS_GC_CHUNK_SIZE) {
-		data->scratch_idx =
-			(data->scratch_idx + 1) % XFS_ZONE_GC_NR_SCRATCH;
+	if (data->can_copy) {
+		struct bio_vec src = {
+			.bv_sector =
+				xfs_rtb_to_daddr(mp, chunk->old_startblock),
+			.bv_sectors = BTOBB(chunk->len),
+		};
+
+		bio_add_copy_src(bio, &src);
+		bio->bi_iter.bi_sector = daddr;
+		bio->bi_iter.bi_size = chunk->len;
+
+		WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
+		list_add_tail(&chunk->entry, &data->writing);
+	} else {
+		chunk->scratch = &data->scratch[data->scratch_idx];
+
+		bio->bi_iter.bi_sector =
+			xfs_rtb_to_daddr(mp, chunk->old_startblock);
+		bio_add_folio_nofail(bio, chunk->scratch->folio, chunk->len,
+				chunk->scratch->offset);
+		chunk->scratch->offset += chunk->len;
+		if (chunk->scratch->offset == XFS_GC_CHUNK_SIZE) {
+			data->scratch_idx =
+				(data->scratch_idx + 1) %
+					XFS_ZONE_GC_NR_SCRATCH;
+		}
+		WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
+		list_add_tail(&chunk->entry, &data->reading);
 	}
-	WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
-	list_add_tail(&chunk->entry, &data->reading);
 	xfs_zone_gc_iter_advance(iter, irec.rm_blockcount);
 
 	submit_bio(bio);
@@ -839,10 +872,12 @@ xfs_zone_gc_finish_chunk(
 		return;
 	}
 
-	chunk->scratch->freed += chunk->len;
-	if (chunk->scratch->freed == chunk->scratch->offset) {
-		chunk->scratch->offset = 0;
-		chunk->scratch->freed = 0;
+	if (!chunk->data->can_copy) {
+		chunk->scratch->freed += chunk->len;
+		if (chunk->scratch->freed == chunk->scratch->offset) {
+			chunk->scratch->offset = 0;
+			chunk->scratch->freed = 0;
+		}
 	}
 
 	/*

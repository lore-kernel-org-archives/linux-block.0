Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812A42B311;
	Wed,  8 Jul 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527666; cv=none; b=M+fW+JGveaQrK2WbZL8JbpUMALcfEqnARpGyDhs07czu2GnGcz8FvKZEaxcUerhh0i427Tf+HyXdhl2+/mgPq2bYnRPYGgVp1aya735/iJKlAxzkn08minUzobZ/YJcptuSQICav5Lo++4rFtrIYz3CidkCmEVsS5YORdn3M18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527666; c=relaxed/simple;
	bh=A7X9xyj7ZtHp5xePR+OXO5sckXFzrlJNFGMQLZvSBno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+BIMhHFkwQ226q9PU4koXKaes4njiwEH2NB156QKKD/NsiDb4Pbjo6BEZ5I9dGFTfiVzNvFWt1oSRxm2P8dQiN5Hr8lwU2wSxkPqjSPw6E+njtr4N/gOsoZcix0SK6kw20scU8cI4cRVnaST9aF5U3vivFySsLcEykyyQ3+Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1807E68BFE; Wed,  8 Jul 2026 18:21:01 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:21:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: Re: [PATCH] block: fix bio_alloc_bioset() percpu cache fallback
 for non-reclaim contexts
Message-ID: <20260708162100.GA2502@lst.de>
References: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com> <20260708084547.GA3591@lst.de> <b8b95aeb-8443-404b-a320-e3bd3fed1598@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b95aeb-8443-404b-a320-e3bd3fed1598@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 08, 2026 at 05:49:21PM +0800, Joseph Qi wrote:
> Looks sane. So commit b520c4eef83d exposed the bug but not introduced it.

Well, there is a bug in virtio_pmem for sure.  But I also think the
bio_alloc_bioset behavior isn't quite optimal for non-sleeping
allocations.  But I'd probably go more for something like this there:

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..bdca2e60514b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -555,6 +555,13 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		bio = bio_alloc_percpu_cache(bs);
 	} else {
 		opf &= ~REQ_ALLOC_CACHE;
+	}
+
+	/*
+	 * If the percpu cache was empty, try an slab allocation with optimistic
+	 * GFP_ flags ass well before falling back to the mempool.
+	 */
+	if (!bio) {
 		p = kmem_cache_alloc(bs->bio_slab, gfp);
 		if (p)
 			bio = p + bs->front_pad;

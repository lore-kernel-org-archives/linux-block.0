Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858233D9DD2;
	Fri, 10 Apr 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835268; cv=none; b=THu+WhcHSfsEdpls7LsCmPuojcZuzi7+5xL1mYyWDzauaS9CLaKAzmLmWCRSCTuR3xxGNA1oVmN7YHXrCe+oiLf93NMhda0Yff+tMxg0XSQggDobvW8KfiN/j9rjl+e/4EkQ1haSsiXpb+4LSZpXoS52f23/+a6hXPi7l+My1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835268; c=relaxed/simple;
	bh=PvbmIdzeb9wjKZVgfkDb4H3sqoijSdhO8pVpgiUrhwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yoz9wXmYbNpygpMAfvcCJ2WDoH/NFJI6I5vb5XXoeQW/82pXcthZizj2hAMA26+sjzKoT35R1Kl7GXYPubVrmOp+uTq4OMROpsH1Vy27JoJ9E95QplN95eTLccr+JKclyXE7DW6vMXksYjFCCgmLNM+cMcFltkEuGDF11IwGDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VKVEIrls; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VKVEIrls"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id B9A1420B710C;
	Fri, 10 Apr 2026 08:34:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9A1420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775835261;
	bh=nJauujAtXOqpY8xeMLBmssIBHZiVywJc9ACUArZxTLA=;
	h=From:To:Cc:Subject:Date:From;
	b=VKVEIrlslwUJ+/jIuLvpPHB2k/jnIgvPn39AdzD180BLTuTV90gJXT9nN8f5iIxzP
	 rETQYl5aMCuBfMzlVCcjvwqQm/iGoyKp2F2nrSdNETxcLUZDYbVKRMelY0+wI56VGu
	 2AcvqzCGBan48/dkNpRzda4wLi9QgKWzo5iPEZfY=
From: Naman Jain <namjain@linux.microsoft.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	namjain@linux.microsoft.com
Subject: [PATCH v2 0/2] block: fix pgmap handling for zone device pages in bio merge paths
Date: Fri, 10 Apr 2026 15:34:12 +0000
Message-ID: <20260410153414.4159050-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When zone device memory is registered in multiple chunks, each chunk
gets its own dev_pagemap. A single bio can contain bvecs from different
pgmaps -- iov_iter_extract_bvecs() breaks at pgmap boundaries but the
outer loop in bio_iov_iter_get_pages() continues filling the same bio.

There are two problems with the current code:

1. biovec_phys_mergeable() has no pgmap check, so the request merge,
   DMA mapping, and integrity merge paths can coalesce physically
   contiguous bvec segments from different pgmaps. This makes it
   impossible to recover the correct pgmap for the merged segment
   via page_pgmap().

2. bio_add_page() and bio_integrity_add_page() reject pages from a
   different pgmap entirely (returning 0), rather than just skipping
   the merge and adding them as new bvec entries. This forces callers
   to start a new bio unnecessarily.

Patch 1 fixes the merge-path gap by adding a pgmap check to
biovec_phys_mergeable().

Patch 2 introduces zone_device_pages_compatible() which replaces the
blanket zone_device_pages_have_same_pgmap() rejection in bio_add_page()
and bio_integrity_add_page(). Pages that are safe to coexist as separate
bvec entries (e.g. MEMORY_DEVICE_GENERIC from different pgmaps) are now
accepted, while P2PDMA pages from different pgmaps or mixed P2PDMA and
non-P2PDMA pages are still rejected, since the DMA iterator caches the
P2PDMA mapping state from the first segment.
zone_device_pages_have_same_pgmap() is kept as a merge guard so pages
from different pgmaps are not coalesced into the same bvec segment.

Changes since v1:
https://lore.kernel.org/all/20260401082329.1602328-1-namjain@linux.microsoft.com/
- Reworked patch 2 to introduce zone_device_pages_compatible() which
  rejects P2PDMA pages from different pgmaps at the bio-building level,
  not just at merge time. The previous version only moved the pgmap check
  into the merge conditional without preventing incompatible pages from
  being added as separate bvec entries. (Christoph Hellwig)

Naman Jain (2):
  block: add pgmap check to biovec_phys_mergeable
  block: relax pgmap check in bio_add_page for compatible zone device
    pages

 block/bio-integrity.c |  6 +++---
 block/bio.c           |  6 +++---
 block/blk.h           | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.43.0


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0383DD52A;
	Fri, 10 Apr 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835272; cv=none; b=FtiEON1ZITzmGYthu/kgKGkbS0hd5p7MHto+21sw6OoZjsEa8akk7zeYdBPyVsgX8w0jG2IcFhCAdg+zOaRp9Ydn+fiPmaqCXnOJXUrtjxq0c8YEkIpajFgp9lL8ZsYSfW8TWYC52KlYG6oZ0AB/DI3vxtkmRR148k1LiEGjFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835272; c=relaxed/simple;
	bh=eGzaipayHpKDEOEdTlY1lonzGqc+tNdB9WEcN3BqO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1D6oJ4KrTm+vRqX1OG+FEJ87eJzcP8zrdSPXmlTI7iFkGTllTNPxbGbVTjjV/qndWRMhLi7m2LnmKDrpZ4MUq0+KFkPMJLI5/ebzEhdzxhR8uobuivh5rgL9jbo7mpi/QK3Eqm7HlLTO13+ltqEEqNmV5+zu31g4r1wgxnopq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l5I/CLHU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l5I/CLHU"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D51B20B7129;
	Fri, 10 Apr 2026 08:34:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D51B20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775835265;
	bh=Uu//OTzFLmaanXhj3JUq0IrWVw0HVHD5keaWVPbjlkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5I/CLHUs9q1OZ4vFIiO/9ihnaLZwgzOrHOpXLctQELxl1NodQFbAS5TmtJMxLcRl
	 6ZObPmibP5GOQtibsrMHe+6VKf2fUe+7GIjUcENcRxNUp93ATMzei8m6B5+GAxMzdC
	 dZSj3UnHpt3pJf0FJgnxaCbmEtU7RmBzYvznjfQ8=
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
Subject: [PATCH v2 1/2] block: add pgmap check to biovec_phys_mergeable
Date: Fri, 10 Apr 2026 15:34:13 +0000
Message-ID: <20260410153414.4159050-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410153414.4159050-1-namjain@linux.microsoft.com>
References: <20260410153414.4159050-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

biovec_phys_mergeable() is used by the request merge, DMA mapping,
and integrity merge paths to decide if two physically contiguous
bvec segments can be coalesced into one. It currently has no check
for whether the segments belong to different dev_pagemaps.

When zone device memory is registered in multiple chunks, each chunk
gets its own dev_pagemap. A single bio can legitimately contain
bvecs from different pgmaps -- iov_iter_extract_bvecs() breaks at
pgmap boundaries but the outer loop in bio_iov_iter_get_pages()
continues filling the same bio. If such bvecs are physically
contiguous, biovec_phys_mergeable() will coalesce them, making it
impossible to recover the correct pgmap for the merged segment
via page_pgmap().

Add a zone_device_pages_have_same_pgmap() check to prevent merging
bvec segments that span different pgmaps.

Fixes: 49580e690755 ("block: add check when merging zone device pages")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 block/blk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index ec4674cdf2ead..50a41db039133 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -127,6 +127,8 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
+	if (!zone_device_pages_have_same_pgmap(vec1->bv_page, vec2->bv_page))
+		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
 		return false;
 	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))
-- 
2.43.0


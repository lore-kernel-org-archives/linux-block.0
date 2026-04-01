Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD093ACEE2;
	Wed,  1 Apr 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031821; cv=none; b=IoMXff+8t3RQs8RF4GeBKLFtSIdeZPfCoTgrxX759iypruE7cox6OxrbjPRM2LtQy2gz7+7U2PjAgCEAsrEWBqnyw3VEUAwurkzm4/TmgmeZjRh6nV7vTuN1nI354qz5hRmL5bjhPphKOailXXfiP0oz6ML8voDPourVEs+hN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031821; c=relaxed/simple;
	bh=9ULHFT2xvU+3cRhd6QiFMq1zeo0k02VJcZ5sLyVH3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brlGJK7Uh37ZHEEcky937j3ScSZgzJbFGiBxCpl47ZB7tgH4npyoYEWghAdzzY2P1iRHPTputyyrSep4evD+jeQYQpupcUAqXMNXVLc4wq38zDlZeSKSalG1s2wZTvPXigziPIrFMJh92/0xHfEao54FrSBoGdNtHGUnUleDqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=evmYTOme; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="evmYTOme"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D9F020B6F0C;
	Wed,  1 Apr 2026 01:23:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D9F020B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775031820;
	bh=eXT8ERPXc0X4zBvmbDW2hTug4wT2r0O8iUGIGWSiEFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evmYTOmehPjT3tFsqAz1AEQAvCMfN9w3fF1FR5p3SOYTrGPyHEWDWbr7mx3bTCY7W
	 q1swY417ADBtLlg4+zhE/MK10h7HoM9wLtQ0/gobFwT6xAqYhjl/E37rHjyhD9pRTZ
	 A0kHVszh9uBDzxp29tpPyxQ3Z7faygHfHZpFQPcQ=
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
Subject: [PATCH 1/2] block: add pgmap check to biovec_phys_mergeable
Date: Wed,  1 Apr 2026 08:23:28 +0000
Message-ID: <20260401082329.1602328-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401082329.1602328-1-namjain@linux.microsoft.com>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com>
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
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 block/blk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 103cb1d0b9cb3..0cb3441638284 100644
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


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860DD3914F5;
	Wed,  1 Apr 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031817; cv=none; b=DPLSX2VbSPpE4IxykK8GWF+0BY4BCqffil1KawOcMJUOuo/tHdRE2qgT+K6i37xo1fkeuimY1bDMLG0rLlVRQhPEf/dmSxDI/EB3bv3Rrw3ASTKugbYA6g84o5M1XKlEjBhqpe1nTfWmUtDL6WbsJn0c2BsZgmriw7z5LaJyxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031817; c=relaxed/simple;
	bh=L7vanUhTm1pbOGW3Dn6g32AVFzgZD2RY+7jhifNatzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPidrlMafJd+40+61HxEsiLEOr2M5RyHOqclf7q369zLhPENygAL2s2G2ncSbtAUBqBTnfSae5tXNSdUe3uxlWWxU02P/6XCHnIIZ0+LQEvmZ7+fAtPBrIXKRpJIgcET+62nCUspwIJ057Bo2c7EZX6oa6KjWpjeFTv2CubtCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KhLQD0u2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KhLQD0u2"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 64EEF20B6F01;
	Wed,  1 Apr 2026 01:23:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64EEF20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775031816;
	bh=Upqu2rNJQjIJ6zpSjtTn7xB9Fu8YX/5O81h78w4m0UQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KhLQD0u2GvNc1POzzcMRGd0/7Blxl3C9ohaqguZ4/2gZKvqDNTK4Mh0gJvpmTJm4y
	 99MbWjOtvjRgXC46zwG+9yzY4F+V++zcF+uEBaAxWAOzJHZu14yGCGn6xPf9QwqAWt
	 nwtT24/UojOCAv+WVyxmav2mrd8hUEBMOWkGiyv4=
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
Subject: [PATCH 0/2] block: fix pgmap handling for zone device pages in bio merge paths
Date: Wed,  1 Apr 2026 08:23:27 +0000
Message-ID: <20260401082329.1602328-1-namjain@linux.microsoft.com>
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

Patch 2 fixes the bio_add_page() and bio_integrity_add_page() API
behavior, moving the pgmap check into the merge conditional so
different-pgmap pages can be added as separate bvec entries. This
depends on patch 1 being in place.

Naman Jain (2):
  block: add pgmap check to biovec_phys_mergeable
  block: allow different-pgmap pages as separate bvecs in bio_add_page

 block/bio-integrity.c | 6 ++----
 block/bio.c           | 6 ++----
 block/blk.h           | 2 ++
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.43.0


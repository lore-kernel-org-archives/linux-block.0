Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D023AE1AF;
	Wed,  1 Apr 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031824; cv=none; b=l2EOCQHmg6oQf7ruNliXN5GvS0otSR7R/vWG3U4qq2hue/4K6EwfV83eLa15fn6+35Auj/vvGtflpMaXXZGnORf/7hPU6SYcrvZs7opJaZMWf9AFFlSGsZlZWu4aM1nsDOSVxeeQ7Rit5JX5CrsNzlEpcogKOpDYrgRw7SlKtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031824; c=relaxed/simple;
	bh=vkLi54k3UMlyjllNBb8nTCf7muYLu3Ziarc9wCLuXHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP9Hfnk5+bcRbu8bvipLx9Uf4DdYmWh/vXoGoyyOWX0rOgPHWK7Sc1kzDM+AvWd6kHQZtu37G0zN6+sonSaxCBj6ryvtvmHN9MtF3nZhMb+2rXpVHTvMR6WdjcRecuESAGATyN3qfOkmfQCgSNYsdlqW6Z7UIA9dbx7TVcRQkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WKgfFsNp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WKgfFsNp"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8C9A20B6F01;
	Wed,  1 Apr 2026 01:23:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8C9A20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775031823;
	bh=/WQ7NqzeVLv5tsvMcYLsnedZqMBOHnSwswWgbs/GSDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKgfFsNpzVPUBJVuWA6bCdaq0xE/3ztXUZduOucsgqk4O3QRRwK7TXa591dJMu2iO
	 IchwcmzoJxvXY2w07vaLMyRwChbYxtsPiU3ySGxzPt+JhMc108FlQ7HFktbkArw7du
	 98d7nBGU92oJkDBRVE1gfyblXZ+y6yaDMQexuOt8=
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
Subject: [PATCH 2/2] block: allow different-pgmap pages as separate bvecs in bio_add_page
Date: Wed,  1 Apr 2026 08:23:29 +0000
Message-ID: <20260401082329.1602328-3-namjain@linux.microsoft.com>
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

bio_add_page() and bio_integrity_add_page() reject pages from a
different dev_pagemap entirely, returning 0 even when the page could
be added as a new bvec entry. The pgmap check was intended only to
prevent merging into the same bvec segment, not to block the page
from being added at all.

This causes callers to unnecessarily start a new bio when a buffer
spans pages from two different pgmaps, even though the bio has room
for another bvec.

Fix both functions by moving the zone_device_pages_have_same_pgmap()
check into the merge conditional. Pages from different pgmaps now
skip the merge attempt and fall through to be added as new separate
bvec entries.

This is safe because biovec_phys_mergeable() now also checks for
pgmap mismatches, preventing the downstream merge, DMA mapping, and
request coalescing paths from combining segments across pgmaps.

Fixes: 49580e690755 ("block: add check when merging zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 block/bio-integrity.c | 6 ++----
 block/bio.c           | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf0477943..3462697331890 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -231,10 +231,8 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 
-		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
-			return 0;
-
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
+		if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+		    bvec_try_merge_hw_page(q, bv, page, len, offset)) {
 			bip->bip_iter.bi_size += len;
 			return len;
 		}
diff --git a/block/bio.c b/block/bio.c
index 77067fa346d35..7715e59e68613 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1034,10 +1034,8 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
-			return 0;
-
-		if (bvec_try_merge_page(bv, page, len, offset)) {
+		if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+		    bvec_try_merge_page(bv, page, len, offset)) {
 			bio->bi_iter.bi_size += len;
 			return len;
 		}
-- 
2.43.0


Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D225680
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700132; cv=none; b=e4Ds2ZdCSzyTy6vFCG6xuHqJpuDO9D/XeWtwUm4D4Q0qskWTpb1fzuMT6Tcei5RcEnTtqCdG9bE1JEaIo4HYgaEYL3WpZCjYdkvI4pibYyAQTAYTwei8j2ZGCAIFYS/hQ7sZU1xiyFA093z6v2K8q+XqJQi/R29m+ElI4W8piVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700132; c=relaxed/simple;
	bh=pMzkvBSsEGDSxiSe+WIz7Cm6j1MOthReYmGSvreuFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eB1FaR8Uh3n8wCF5NgIER7wNAXz5zajTWSl8PqNcgEHW9vKELc5OjF2vAhciRVmS73i/XNmfGelLzwEBMDKgpd0DOeweWfUw1oE/Sg+6hM+VoGef4If6826rqwPkGO1vCT52waUY1pFZTKjqJyYrG8Z3XRPX7o9P4mM1suqgkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUxy0jLt; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUxy0jLt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741700126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v350HabhDwgp9zD4fUNhmFLJ9K3Io+OWnHuAQz6FHuU=;
	b=tUxy0jLtDhLlcLIduofCOfXjdfD+/HRsZ9hf+tH9UV9seqWsITJUqQ/vpJXpI8gD2trWq0
	RGuZoQdLpkK5yMVYHuuA/sUK6xS3CKSu9/7tE7sdIm4s3fLrAoGgwITv0dmM6KOKCeWwKA
	I5Eq3n4zWL+5l4ht7o40wq0kVm9eMvI=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: 
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Allow REQ_FUA|REQ_READ
Date: Tue, 11 Mar 2025 09:35:16 -0400
Message-ID: <20250311133517.3095878-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
the same as writes.

This is useful for when the filesystem gets a checksum error, it's
possible that a bit was flipped in the controller cache, and when we
retry we want to retry the entire IO, not just from cache.

The nvme driver already passes through REQ_FUA for reads, not just
writes, so disabling the warning is sufficient to start using it, and
bcachefs is implementing additional retries for checksum errors so can
immediately use it.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/blk-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d6c4fa3943b5..7b1103eb877d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -793,20 +793,21 @@ void submit_bio_noacct(struct bio *bio)
 			goto end_io;
 	}
 
+	if (WARN_ON_ONCE((bio->bi_opf & REQ_PREFLUSH) &&
+			 bio_op(bio) != REQ_OP_WRITE &&
+			 bio_op(bio) != REQ_OP_ZONE_APPEND))
+		goto end_io;
+
 	/*
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf)) {
-		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE &&
-				 bio_op(bio) != REQ_OP_ZONE_APPEND))
+	if (op_is_flush(bio->bi_opf) &&
+	    !bdev_write_cache(bdev)) {
+		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
+		if (!bio_sectors(bio)) {
+			status = BLK_STS_OK;
 			goto end_io;
-		if (!bdev_write_cache(bdev)) {
-			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-			if (!bio_sectors(bio)) {
-				status = BLK_STS_OK;
-				goto end_io;
-			}
 		}
 	}
 
-- 
2.47.2


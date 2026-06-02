Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C333921D5;
	Tue,  2 Jun 2026 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379189; cv=none; b=d3b/CXhXwgNKdFSpRSFBVURzczDsiJ5kPBCzdJA2/8uc+kBV2Zu9lvQZsoGQc6JdYYeqX6rJWAfz06PQkplRaFkRUq5+yu2LvjdNxG7lSeSqfHEjX17KL/CvMeXwqQT+j72HeStcG6V5CXNHBWol7hW9Nmlewc+/CJIRkVAPZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379189; c=relaxed/simple;
	bh=YvKEwf8h9mfJhzlaVVxfbW6n3bYSgJSD/xPZpCEbRBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkk5y2dBNfV75X6mOLPoRr3zPgGFnmkWKNpGqZZGCNld4YXMl6/X+pFgYBAdPM6DEzgW0CD/5f/tXk/Q1OvYKZL/pdqtMImq5bof4kMem/r7sd9HtlNfCDOLAXeW7BtHQC3oVMRfFVionIr5A2f5nrU1NbZQRc2bvGdkB4O1vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1GIiCpbt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1GIiCpbt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UsGsSWxM78oUK0Kz2DvuQb5PGBCWmLVS/o64yRyXad8=; b=1GIiCpbtF+o++5JIK5l5X4ke8V
	yRP7F3iVyfKR/psfNfIZnaxoGf9pQj46nY/NDnGBxmVkmK3awxGnc9CeDBfi5Hsz9sR+TL2Hij16L
	ttcSTSr8lefFPjIkTEY5LkC+DPxzYJqOkXiLc/TajGo+t7IA9inN5i5NGhzBoyuiznr35sOeH4RMa
	JxjZVVxmFz2SQMphOCMDGtAqSo9n6alU0csFuq6QxDSTtfecGIH+ndeqY40g91MRHlp897kG+hVXy
	ON9ilL8sWIm+bZOmpsw1huK9EYSXEA+Sc5QbhUZpkl4vyd5oj2AuAVa5/MMT55Pix2mwdg2FNJgJa
	p44JuFcg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxL-0000000CL9o-0AFe;
	Tue, 02 Jun 2026 05:46:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/9] block: consolidate the calls to should_fail_bio
Date: Tue,  2 Jun 2026 07:45:34 +0200
Message-ID: <20260602054615.3788425-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Delay the point of error injection a bit so that we have a single site
in blk-core.c after more of the submission side checks and blkcg
throttling.  This allows to make should_fail_bio static in blk-core.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 6 +++++-
 block/blk-merge.c | 5 +----
 block/blk.h       | 1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3a23af3e26a9..f35e0d3fb127 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -539,7 +539,7 @@ static inline void bio_check_ro(struct bio *bio)
 	}
 }
 
-int should_fail_bio(struct bio *bio)
+static int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
 		return -EIO;
@@ -723,6 +723,10 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
+	if (should_fail_bio(bio)) {
+		bio_io_error(bio);
+		return;
+	}
 	blk_cgroup_bio_start(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7cc82a7a6f4e..b44f8ae849b8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -130,11 +130,8 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	trace_block_split(split, bio->bi_iter.bi_sector);
 	WARN_ON_ONCE(bio_zone_write_plugging(bio));
 
-	if (should_fail_bio(bio))
-		bio_io_error(bio);
-	else if (!blk_throtl_bio(bio))
+	if (!blk_throtl_bio(bio))
 		submit_bio_noacct_nocheck(bio, true);
-
 	return split;
 }
 EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
diff --git a/block/blk.h b/block/blk.h
index bf1a80493ff1..889a39589356 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -646,7 +646,6 @@ extern const struct address_space_operations def_blk_aops;
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
-int should_fail_bio(struct bio *bio);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 bool should_fail_request(struct block_device *part, unsigned int bytes);
 #else /* CONFIG_FAIL_MAKE_REQUEST */
-- 
2.53.0


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2431079F
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511871; cv=none; b=UgpglCn5XvyRnsbZG0bEv4OJF4tRK9hWLMrlkP4/8SeKGudE6vsXwUKNGHziQBwd1J04E1MnPeQO23Hrao6VJD36sc5hLtLcEhwJ4lew+ClCdsMRJThmW9g10BMDWCx26UnH6FDm3pEHP1jUBLZ6cxVTT+YdY7jSEAQWuWeTXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511871; c=relaxed/simple;
	bh=V/fj8PbfBo7A48oGJy7WFxdOH2jN6sog5FQBthXoAms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntlqgFSN5t0xw9dzfStUttLKLmOyBeK291hYWqIEd+nz7QVl9cqTW219CTbkNqhwl+AAiBqUACKYWZmPS1SEyP6q/0mCOHuYxFzNcO3TPEiAu4al73LmfyGwqwCeg/KQ8FjJHIVbU7WJEltq/jjn9ETsSVvD362JF0wVbJ0dMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YPeWgUrA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPeWgUrA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pT5+ozYEFH7zkquGbzf64Jrb47d9l1G7wH/FYlvX+2M=; b=YPeWgUrA/8x9T+KF1WOVuMK4Ys
	RkWWArT0v2jir7PhCopE9IsfsIYUQDB3E+AHXVlxN9SfRp8qd9ShTf8AjbByJQYBdorukbQwAMkHw
	uEEoqxqLoFwR66d7kKeStfq7ibF4jzoTjoNxUCblhlVlTHlphEXs9aedCA2+u6oxr+TAxdbsklyGU
	kNaBdhcOlEoiiiEL6C9nOMLpu5u+FD9QWRkkjGZdjyOtFvaaBnMyY3dzOX0Tam5xBV2coPj/ZoQMc
	rlsseXsFGME+dwFUT7EfhCbVnkHRXw/d0W5cR8VD1meZC5GoPrSeszD46aPE8/eOCR2M2aX0Of6HY
	f4CTSIDw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unwpW-0000000784d-0dvP;
	Mon, 18 Aug 2025 10:11:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: tone down bio_check_eod
Date: Mon, 18 Aug 2025 12:11:02 +0200
Message-ID: <20250818101102.1604551-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bdev_nr_sectors() == 0 is a pattern used for block devices that have
been hot removed, don't spam the log about them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..4201504158a1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -557,7 +557,7 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors &&
+	if (nr_sectors && maxsector &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-- 
2.47.2


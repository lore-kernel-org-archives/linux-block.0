Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC54223DCF
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041469; cv=none; b=dUNO09OXwqDicScF0KgEGqmIO8AjWLzAp9M/+G7nvDck7GuuN9FgvHa1WKIGJcAnOEou0044pfedVL/7A1GldML1DaA6JFJI/1Or+lrOZGLbr/deKdEAZZa3VBfQ8mh1U6qpx25/2cTfCASDaRM5jQRFei8bhV2Tlebgk8AOQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041469; c=relaxed/simple;
	bh=1iUelnWiQ+BJZyHuEpGKvm7zbuQeLqj6NngigWl7mTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emZamR+dsXQ13KhT0zjiWBch/esFaTI8muos0H4YoZIIwP+XrBfJ27iD4OzzkSrp6dipWuGJpYlNR2f6cOp/LsMMeGPS2l1yJKTi4Lxw/IWkX0Tngnjtg/DrR/AfFIQA8PtQmfsVGeBarOtSYBDzIl4QG6QvYTrhPdnHVOq1pEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8nPrARq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8nPrARq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38112C2BCB3;
	Thu, 13 Nov 2025 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041469;
	bh=1iUelnWiQ+BJZyHuEpGKvm7zbuQeLqj6NngigWl7mTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8nPrARqB8mCc264r/JhRMokMl0iGNHGdPHhkA87NPqzLyj8jUev6R9AW+nlhg17L
	 f7E+vAGa2F3Ifh8I2gf5f9Q9sSZRZRW20c0BQuTfCEI2IbmShIi2XjtFGWRkD5yXeE
	 uUnjk/W6NIxotSKcPbXyP07hW4huTIP52jhmLMVOlm/C5DzFybEJ2syw6GFFQgTqHu
	 UA8npSlKjg063yGSpAsziV9zis4/RZtX35bLiBSVAiLyJye1BJ9JnWPYxNBtmJHYjJ
	 anaOe8L+9eQ1M3BNwU7LISAsjL0b0Uq1OfxMPcyvah0nLBxgkeuzXHBg4zGfy67p3r
	 G50cdBWP3glhQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] block: fix NULL pointer dereference in disk_report_zones()
Date: Thu, 13 Nov 2025 22:40:27 +0900
Message-ID: <20251113134028.890166-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113134028.890166-1-dlemoal@kernel.org>
References: <20251113134028.890166-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2284eec5053d ("block: introduce blkdev_get_zone_info()")
introduced the report_active field in struct blk_report_zones_args so
that open and closed zones can be reported with the condition
BLK_ZONE_COND_ACTIVE in the case of a cached report zone.
However, the args pointer to a struct blk_report_zones_args that is
passed to disk_report_zones() can be NULL, e.g. in the case of internal
report zones operations for device mapper zoned targets.

Fix disk_report_zones() to make sure to check that the args is not null
before updating a zone condition for cached zone reports.

Fixes: 2284eec5053d ("block: introduce blkdev_get_zone_info()")
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 98c26af01e24..dcc295721c2c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -854,7 +854,7 @@ static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 		     unsigned int idx, struct blk_report_zones_args *args)
 {
-	if (args->report_active) {
+	if (args && args->report_active) {
 		/*
 		 * If we come here, then this is a report zones as a fallback
 		 * for a cached report. So collapse the implicit open, explicit
-- 
2.51.1


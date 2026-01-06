Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C83093CE
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683128; cv=none; b=EZAbkqCEfkFK5T6I7qe0z1ICLNQIp9uzm4hZDbUekJXsnyuYLxZqcxLdvdgMopNmCJ89JC/MWtJRGqZmGvazGSSX5HYlwtJAVuqhmWztS1ZUvrL7adH3b+7soiXA+Glge5i5z0jW5r7a28ypboWv1Lg+BwHBzmlGeV0ZG4XFVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683128; c=relaxed/simple;
	bh=JMLft/ydl7KrOy8bRHFK5FpdZeiZKPLPzWk17IYOf3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRTJ43H5PsWM9F3NhY7i1czIWLZKnt+dZCJd8UFH7g6F2fSQVT1ubPnEoJekwYs/TUQKdZaiLhSm276Y4GGGAmph2jnO3ACI//4oM4DTt7Lp7e9t6b5ZLqUgUHosXKMzfYR/wqZefwkGgVEO+l81stdSH1J2llca13GwHFr7ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEQU4QtF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEQU4QtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8BAC116C6;
	Tue,  6 Jan 2026 07:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683128;
	bh=JMLft/ydl7KrOy8bRHFK5FpdZeiZKPLPzWk17IYOf3U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dEQU4QtF6UyXjkMoI7kSvOfCQKDzQVptgfXbnTbG4Im+5TRJtuYp4ZMlPSYMEJ1qR
	 NxV7OISSGPIs2316pWyn3kt9Da+gTL6fOQLFfmiIgPJPfa1bWxpkoOYemEx6XR+kZ0
	 /aFWPYdZ7eGCcYR8m6zghDdmj2erksTuRUtemSf6M7gUsn+rN37w+mt8QU2y1VLncR
	 xQBRjuJDPV0WBAXg0dAVzi0fVXI/tkWeonqiV/wKaZzVONkDcVXKDnskHtGeQ9L+6y
	 4hPvuSfTBpVFzm4hwczNP/BSib9UQS3YJYfC8o7Tb1okCXlXvdb3TY8SJkN3kEymUM
	 CikCb1rCS/w3Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: fix blk_zone_cond_str() comment
Date: Tue,  6 Jan 2026 16:00:56 +0900
Message-ID: <20260106070057.1364551-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106070057.1364551-1-dlemoal@kernel.org>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the comment for blk_zone_cond_str() by replacing the meaningless
BLK_ZONE_ZONE_XXX comment with the correct BLK_ZONE_COND_name, thus also
replacing the XXX with what that actually means.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 10 +++++-----
 include/linux/blkdev.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1c54678fae6b..ef3872c53244 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -112,12 +112,12 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
 #define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
 
 /**
- * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.
- * @zone_cond: BLK_ZONE_COND_XXX.
+ * blk_zone_cond_str - Return a zone condition name string
+ * @zone_cond: a zone condition BLK_ZONE_COND_name
  *
- * Description: Centralize block layer function to convert BLK_ZONE_COND_XXX
- * into string format. Useful in the debugging and tracing zone conditions. For
- * invalid BLK_ZONE_COND_XXX it returns string "UNKNOWN".
+ * Convert a BLK_ZONE_COND_name zone condition into the string "name". Useful
+ * for the debugging and tracing zone conditions. For an invalid zone
+ * conditions, the string "UNKNOWN" is returned.
  */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 72e34acd439c..63affe898059 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1044,7 +1044,7 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 	return bdev->bd_queue;	/* this is never NULL */
 }
 
-/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
+/* Convert a zone condition BLK_ZONE_COND_name into the string "name" */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
 static inline unsigned int bio_zone_no(struct bio *bio)
-- 
2.52.0


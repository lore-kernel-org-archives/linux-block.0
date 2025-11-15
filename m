Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440A29B20D
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209202; cv=none; b=P0tDz8dWTBE1p3d9IiknZAhYOD7O/vT0/3Vf+LIV8r8r0WTKjTMbtdLYOB3+NVJyjfUyvEKeFxvcxwBGdsFtKioUvmJZE/7NA6YuxIG7bmlLzteWx61oWYQ9NpgNZ4YsLK3UJwbTDUDWRR7KOcpMHOEIr8P+344nBtd663X23ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209202; c=relaxed/simple;
	bh=77H7hEFlIZa37AghadVbw+5zXwOIkJy5S402JEyur2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBLUB8yMDDW/00EhUQNwWaV2aK5C4BjUxX29PK7s8J9TqUyUm1ela95YiA7RYEd4jUJNqgFgoiIzhfA7rZsqCMVuilNyhWv46Q5Hh9uHME2dtRGC4kaYNY80ZjFxiC2ah9jpjdMxvFh7RWgD8aMU3kRz4q5hKi4o++Vi8DkBS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAriWFWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAriWFWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE3C4CEF5;
	Sat, 15 Nov 2025 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209201;
	bh=77H7hEFlIZa37AghadVbw+5zXwOIkJy5S402JEyur2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAriWFWIaOnMMWIggl5GFNhPYaGslc9dcHNvyZAZrZNqZM/Obf3LILImVEcNvmUDa
	 HuuiSzIPrqk5NCnuwb/1tv+HpIlsxdn06Ss4ii/Qe18tjQtBLOuC/tUTc5oTei7NQp
	 D+nATUEfhRAjiYN7J9bTr+h2zpAUkrsoDQryhhd4DpFKtgq6lUjPLPhjmTzwuTPIEd
	 jKfpzZ2OpuvppwG86BvpQQFBBp4hD/tZLdHFchQbUta447fHQoE2D8DEYxNsVL2/FY
	 Vopj9STu4u0tuAqJ73PLBhGtqLVW9RMeIJM3oS+4l8TcErzd7Y0fKBDezDS+VHSz/t
	 lIzvQ6xO8gklw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] zloop: simplify checks for writes to sequential zones
Date: Sat, 15 Nov 2025 21:15:53 +0900
Message-ID: <20251115121556.196104-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function zloop_rw() already checks early that a request is fully
contained within the target zone. So this check does not need to be done
again for regular writes to sequential zones. Furthermore, since zone
append operations are always directed to the zone write pointer
location, we do not need to check for their alignment to that value
after setting it. So turn the "if" checking the write pointer alignment
into an "else if".

While at it, improve the comment describing the write pointer
modification and how this value is corrected in case of error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 266d233776ad..0526277f6cd1 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -406,6 +406,11 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	if (!test_bit(ZLOOP_ZONE_CONV, &zone->flags) && is_write) {
 		mutex_lock(&zone->lock);
 
+		/*
+		 * Zone append operations always go at the current write
+		 * pointer, but regular write operations must already be
+		 * aligned to the write pointer when submitted.
+		 */
 		if (is_append) {
 			if (zone->cond == BLK_ZONE_COND_FULL) {
 				ret = -EIO;
@@ -413,13 +418,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 			}
 			sector = zone->wp;
 			cmd->sector = sector;
-		}
-
-		/*
-		 * Write operations must be aligned to the write pointer and
-		 * fully contained within the zone capacity.
-		 */
-		if (sector != zone->wp || zone->wp + nr_sectors > zone_end) {
+		} else if (sector != zone->wp) {
 			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
 			       zone_no, sector, zone->wp);
 			ret = -EIO;
@@ -432,9 +431,9 @@ static void zloop_rw(struct zloop_cmd *cmd)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
 		/*
-		 * Advance the write pointer of sequential zones. If the write
-		 * fails, the wp position will be corrected when the next I/O
-		 * copmpletes.
+		 * Advance the write pointer. If the write fails, the write
+		 * pointer position will be corrected when the next I/O starts
+		 * execution.
 		 */
 		zone->wp += nr_sectors;
 		if (zone->wp == zone_end) {
-- 
2.51.1


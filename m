Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB5418A36
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505237; cv=none; b=QKHFCVaQBXIGkUdOMLgbwSYRfmEP2Yiz064q7sduPK9Fey3OLyXeYXOvKqm4UyZQA6DaU9nrEJaJ7Q+SjM0X1Crtnf7/6BxbHrCAgMnYMOUw0KqebW2YhtTOSIj/cXeBuUMdmdVLVsq5K+lKoWlljwu16j3gLLlGpDpwgo2g76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505237; c=relaxed/simple;
	bh=+7++qRbgSPFM4c04QApbI8RaWFtmmqGmF2AT79jsF+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTo2ygLqwCP261yXfV2d+bwFYIbldx+7GcehqcR+D6gKH9cgP+igBqxA1iyN9ArPfDvoTm9GJAJ7HI1fOgWtZVWuLfYHxCF1+kQJvW0NFAJcoQsSpVLVxccVkmrRDRwHP0G7EdpvaQ2wOWTckQBAntzUpYGtKGD0E3HLg3z18UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X+OXeudT; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X+OXeudT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785505224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sPGSaNwMaHwGIch7Q+dDrYYkm9dxL9a2BQ2cqmUZOeI=;
	b=X+OXeudTqXlirTIdsI1BhC4P0vfT8SxufcwttuehcQ5lNG6F3VIhkcFA+YnduMxhWMeZSf
	0uochRTwJD2PD2gROOh7tA6pPd3atwppYD4uuBQIJGi83+eSyuHx7t+oB9vuv6iNwmfCGb
	qDfxlfP0FmV/8zGlqqp0yCSezpscw4M=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	axboe@kernel.dk
Cc: josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] block/blk-iocost: fix KCSAN data-race on iocg->cursor
Date: Fri, 31 Jul 2026 21:40:00 +0800
Message-ID: <20260731134000.70069-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

iocg->cursor is read in calc_vtime_cost_builtin() and written per-bio
in ioc_rqos_throttle()/ioc_rqos_merge() without a lock, which trips
KCSAN:

  BUG: KCSAN: data-race in calc_vtime_cost_builtin / ioc_rqos_throttle

Found via KCSAN (null_blk + sustained IO under CONFIG_KCSAN).

The races are intentional: cursor is a best-effort randio detector, so
stale values only add minor cost-estimate noise. Mark the accesses with
READ_ONCE()/WRITE_ONCE(), consistent with other racy iocost fields
(active, inuse, abs_vdebt).

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-iocost.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8b2aeba2e1e3..ae0d34609144 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2552,9 +2552,13 @@ static void calc_vtime_cost_builtin(struct bio *bio, struct ioc_gq *iocg,
 		goto out;
 	}
 
-	if (iocg->cursor) {
-		seek_pages = abs(bio->bi_iter.bi_sector - iocg->cursor);
-		seek_pages >>= IOC_SECT_TO_PAGE_SHIFT;
+	{
+		sector_t cursor = READ_ONCE(iocg->cursor);
+
+		if (cursor) {
+			seek_pages = abs(bio->bi_iter.bi_sector - cursor);
+			seek_pages >>= IOC_SECT_TO_PAGE_SHIFT;
+		}
 	}
 
 	if (!is_merge) {
@@ -2708,7 +2712,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (!iocg_activate(iocg, &now))
 		return;
 
-	iocg->cursor = bio_end_sector(bio);
+	WRITE_ONCE(iocg->cursor, bio_end_sector(bio));
 	vtime = atomic64_read(&iocg->vtime);
 	cost = adjust_inuse_and_calc_cost(iocg, vtime, abs_cost, &now);
 
@@ -2797,8 +2801,8 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 
 	/* update cursor if backmerging into the request at the cursor */
 	if (blk_rq_pos(rq) < bio_end &&
-	    blk_rq_pos(rq) + blk_rq_sectors(rq) == iocg->cursor)
-		iocg->cursor = bio_end;
+	    blk_rq_pos(rq) + blk_rq_sectors(rq) == READ_ONCE(iocg->cursor))
+		WRITE_ONCE(iocg->cursor, bio_end);
 
 	/*
 	 * Charge if there's enough vtime budget and the existing request has
-- 
2.43.0


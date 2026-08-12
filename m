Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41537FF75
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507685; cv=none; b=aPDXY290KKzYyaPQML9sGgU/5+T/O1H6K1Srb4LZE+/w3/sNhvY+vJu77CxKOlJP8MZnMWsikiZowtwuzt3AhSFrL0NR0+aVPIjmGNXu3auK8B3UwkVFnYkQp/W+mgwK2F+/M2yKxE+FqLs3ulusSWGxCnYB+MjBoH12ohLr3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507685; c=relaxed/simple;
	bh=nDkVpRCvrp68mja4VZcN608/AoFR2Rwr9LfUsHEBzh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dF/CmK4jWJV+sYohEzK5N0xvCwtGgeBB4MFqMW30BgkKEApRbr9jj6ZSrhQ6Zp1ebwNya0CGJF68pfZYBLJauPPCfooXJOqHSru82YZDR468KYFAZmftgy1JH7YfZ1uJXAts/XlmuM3DPK/h6Ujq10Yj9bQkrMAkPlyRMvENN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQGaMh1h; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQGaMh1h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P8K7GHrWP7F1k+UpCzMLZSmw8Tl4U2IKt5xr9zslkHE=;
	b=AQGaMh1hkjOmVADKRT5gXT8Pi+8+7nWtee8miFZ6Hzv1lUIgUsoNG8PjYvFNNwEPti5IHm
	dgUHE5QfHVEWyAXx6uBI82BmJfF/dBGbT5RNcl37zskLLXJy28N672VyZP1K2noIXJJXVR
	SRMTm5ciiRKCCsHQQddIv8qyD5uFBbE=
From: Hongfu Li <hongfu.li@linux.dev>
To: axboe@kernel.dk,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongfu.li@linux.dev,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH v2] block/mq-deadline: Drop unused dd parameters
Date: Wed, 12 Aug 2026 12:07:29 +0800
Message-ID: <20260812040729.27551-1-hongfu.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hongfu Li <lihongfu@kylinos.cn>

Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
left the dd parameter unused in deadline_move_request().

Commit fde02699c242 ("block: mq-deadline: Remove support for zone
write locking") left dd unused in deadline_fifo_request() and
deadline_next_request().

Remove these unused function parameters.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
v2:
- Adjust code formatting.
- No functional changes.
---
 block/mq-deadline.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 824bfc17b2c6..5f643c0ce2a8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -233,9 +233,8 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 /*
  * move an entry to dispatch queue
  */
-static void
-deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
-		      struct request *rq)
+static void deadline_move_request(struct dd_per_prio *per_prio,
+				  struct request *rq)
 {
 	/*
 	 * take it off the sort and fifo list
@@ -269,9 +268,8 @@ static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
  */
-static struct request *
-deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
-		      enum dd_data_dir data_dir)
+static struct request *deadline_fifo_request(struct dd_per_prio *per_prio,
+					     enum dd_data_dir data_dir)
 {
 	if (list_empty(&per_prio->fifo_list[data_dir]))
 		return NULL;
@@ -283,9 +281,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
  * For the specified data direction, return the next request to
  * dispatch using sector position sorted lists.
  */
-static struct request *
-deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
-		      enum dd_data_dir data_dir)
+static struct request *deadline_next_request(struct dd_per_prio *per_prio,
+					     enum dd_data_dir data_dir)
 {
 	return deadline_from_pos(per_prio, data_dir,
 				 per_prio->latest_pos[data_dir]);
@@ -334,7 +331,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	rq = deadline_next_request(dd, per_prio, dd->last_dir);
+	rq = deadline_next_request(per_prio, dd->last_dir);
 	if (rq && dd->batching < dd->fifo_batch) {
 		/* we have a next request and are still entitled to batch */
 		data_dir = rq_data_dir(rq);
@@ -349,7 +346,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&per_prio->fifo_list[DD_READ])) {
 		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_list[DD_READ]));
 
-		if (deadline_fifo_request(dd, per_prio, DD_WRITE) &&
+		if (deadline_fifo_request(per_prio, DD_WRITE) &&
 		    (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
@@ -379,14 +376,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * we are not running a batch, find best request for selected data_dir
 	 */
-	next_rq = deadline_next_request(dd, per_prio, data_dir);
+	next_rq = deadline_next_request(per_prio, data_dir);
 	if (deadline_check_fifo(per_prio, data_dir) || !next_rq) {
 		/*
 		 * A deadline has expired, the last request was in the other
 		 * direction, or we have run out of higher-sectored requests.
 		 * Start again from the request with the earliest expiry time.
 		 */
-		rq = deadline_fifo_request(dd, per_prio, data_dir);
+		rq = deadline_fifo_request(per_prio, data_dir);
 	} else {
 		/*
 		 * The last req was the same dir and we have a next request in
@@ -409,7 +406,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * rq is the selected appropriate request.
 	 */
 	dd->batching++;
-	deadline_move_request(dd, per_prio, rq);
+	deadline_move_request(per_prio, rq);
 	return dd_start_request(dd, data_dir, rq);
 }
 
-- 
2.54.0


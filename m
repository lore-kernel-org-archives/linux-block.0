Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA93403ED;
	Tue, 11 Aug 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431283; cv=none; b=p9QbBIvJGhH0UCDsZtyDTaVGVtOg1icF6yAk2VzeaBNbFnEHn8dJ7JXvTnLBnNCTOGHdz7d5Ml/ibPRx+coZ8WZQa4xk/i8KKCw7Wicm1Y9brckYTejoaGM5uFgorGoroXgPMvhpPsqeMVpFy7lM61Sm3ezlBJ0QldRoPNKD4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431283; c=relaxed/simple;
	bh=OkPcPHgsDfLjeUegS3xuML8gYRB2P193Rz89OHCP8wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srYuq+LAWboo8kprcb4RIoovGpq+pwhh/ODt58JC+qwk4s30auQ2jvnf+LjMGefIfa2Mq0ZUXrCk0R4altjyricyUX3e2eRlFD+J2IbsNoqmER5Xlcz9i5K88dCJDdKDUFih+tTxRYVK2mQ8N6+LZwLpUwWW1rUSp2xorRjIXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MftOqcqR; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MftOqcqR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786431278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cItN4y+UUMhaLTLqsBqHFFa+v/GF4IR9jqfh9nXT1s=;
	b=MftOqcqRTyLbMZpVAp67vqC6zbA214UkL68DDxjjxe3pk2YZkQunbqyv98bUgMfEQTU9SG
	K+ds9+EGuUg8zXH9IPEN0HxuUvJF3tW8m5H/pu/YL3ofq61nsWMTAwhXmIOsVIYSGb9HIn
	4/D9PhV5iRsrTtNL+mTZJ3WupyF5mlw=
From: Hongfu Li <hongfu.li@linux.dev>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongfu.li@linux.dev,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] block/mq-deadline: Drop unused dd parameters
Date: Tue, 11 Aug 2026 14:54:01 +0800
Message-ID: <20260811065401.87147-1-hongfu.li@linux.dev>
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
 block/mq-deadline.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 824bfc17b2c6..314cd1fd1f39 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -234,8 +234,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
  * move an entry to dispatch queue
  */
 static void
-deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
-		      struct request *rq)
+deadline_move_request(struct dd_per_prio *per_prio, struct request *rq)
 {
 	/*
 	 * take it off the sort and fifo list
@@ -270,7 +269,7 @@ static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
  * dispatch using arrival ordered lists.
  */
 static struct request *
-deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
+deadline_fifo_request(struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
 	if (list_empty(&per_prio->fifo_list[data_dir]))
@@ -284,7 +283,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
  * dispatch using sector position sorted lists.
  */
 static struct request *
-deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
+deadline_next_request(struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
 	return deadline_from_pos(per_prio, data_dir,
@@ -334,7 +333,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	rq = deadline_next_request(dd, per_prio, dd->last_dir);
+	rq = deadline_next_request(per_prio, dd->last_dir);
 	if (rq && dd->batching < dd->fifo_batch) {
 		/* we have a next request and are still entitled to batch */
 		data_dir = rq_data_dir(rq);
@@ -349,7 +348,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&per_prio->fifo_list[DD_READ])) {
 		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_list[DD_READ]));
 
-		if (deadline_fifo_request(dd, per_prio, DD_WRITE) &&
+		if (deadline_fifo_request(per_prio, DD_WRITE) &&
 		    (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
@@ -379,14 +378,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -409,7 +408,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * rq is the selected appropriate request.
 	 */
 	dd->batching++;
-	deadline_move_request(dd, per_prio, rq);
+	deadline_move_request(per_prio, rq);
 	return dd_start_request(dd, data_dir, rq);
 }
 
-- 
2.54.0


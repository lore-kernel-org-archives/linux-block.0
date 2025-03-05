Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB72E3364
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149130; cv=none; b=tECXG4kl+soOWOoG+MZ9tNJavyebr7uxYboaSv7AKABJ6sI85i7hdQ/+thfBQOh+3pTycjqpf6KSbwIl5y+TE02jZH2wWKM7gcdRsk//1QsVB2IpRcNyoH8cvyhUn18LeS6FLWY0LR8UpBt/UWAknwnF0lH292/SO+sO8UThY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149130; c=relaxed/simple;
	bh=FcMi33G4UmI8kEn3NoiRVsJwt+idhTnznk+//B53NGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukZFS87yaaRfi8K/bpxVVPP196gg67Zk/faaYYcJav3Hv7UDWpGM1SNtw88sWObQ1LDvEQ8wQx2ewJo7M8V7QrLab6I1l+ttmZJK8Zy7jt1M3g+c+IHomGNVqkZr/9dQ9IO5SLH4njfDmZ64XaEvj02IRQy6WRGiu8335qMEOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POmK5lX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POmK5lX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+O5anJ3PaMp0jQuVFJKKk3whExV0kfUZWEdWjnXAUVs=;
	b=POmK5lX7udPO6ZLjQ9KTVTVdtw4acNgnqOv1uCXWQerpHyKLdg7XMD4jDsgq1P+OzewRyK
	qCK9peMZ7BEwCShWGl2ugMXx3hXgpjB3iUGFcxSjFQhx7VwmqFDJnJckS5oRF5lHWQnQ0S
	BN6h5RVgXrjBQ1sDMZ1YzKiYx/VUQqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-n8r74JF8M1mOjorjGCo1wQ-1; Tue,
 04 Mar 2025 23:31:49 -0500
X-MC-Unique: n8r74JF8M1mOjorjGCo1wQ-1
X-Mimecast-MFC-AGG-ID: n8r74JF8M1mOjorjGCo1wQ_1741149108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E54BF1801A09;
	Wed,  5 Mar 2025 04:31:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA2FC1944EAA;
	Wed,  5 Mar 2025 04:31:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 3/3] blk-throttle: carry over directly
Date: Wed,  5 Mar 2025 12:31:21 +0800
Message-ID: <20250305043123.3938491-4-ming.lei@redhat.com>
In-Reply-To: <20250305043123.3938491-1-ming.lei@redhat.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now ->carryover_bytes[] and ->carryover_ios[] only covers limit/config
update.

Actually the carryover bytes/ios can be carried to ->bytes_disp[] and
->io_disp[] directly, since the carryover is one-shot thing and only valid
in current slice.

Then we can remove the two fields and simplify code much.

Type of ->bytes_disp[] and ->io_disp[] has to change as signed because the
two fields may become negative when updating limits or config, but both are
big enough for holding bytes/ios dispatched in single slice

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 49 +++++++++++++++++++-------------------------
 block/blk-throttle.h |  4 ++--
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7271aee94faf..91dab43c65ab 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -478,8 +478,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 {
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
-	tg->carryover_bytes[rw] = 0;
-	tg->carryover_ios[rw] = 0;
 
 	/*
 	 * Previous slice has expired. We must have trimmed it after last
@@ -498,16 +496,14 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 }
 
 static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
-					  bool clear_carryover)
+					  bool clear)
 {
-	tg->bytes_disp[rw] = 0;
-	tg->io_disp[rw] = 0;
+	if (clear) {
+		tg->bytes_disp[rw] = 0;
+		tg->io_disp[rw] = 0;
+	}
 	tg->slice_start[rw] = jiffies;
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
-	if (clear_carryover) {
-		tg->carryover_bytes[rw] = 0;
-		tg->carryover_ios[rw] = 0;
-	}
 
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
@@ -617,20 +613,16 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 */
 	time_elapsed -= tg->td->throtl_slice;
 	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
-					     time_elapsed) +
-		     tg->carryover_bytes[rw];
-	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
-		  tg->carryover_ios[rw];
+					     time_elapsed);
+	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
 	if (bytes_trim <= 0 && io_trim <= 0)
 		return;
 
-	tg->carryover_bytes[rw] = 0;
 	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
 		tg->bytes_disp[rw] -= bytes_trim;
 	else
 		tg->bytes_disp[rw] = 0;
 
-	tg->carryover_ios[rw] = 0;
 	if ((int)tg->io_disp[rw] >= io_trim)
 		tg->io_disp[rw] -= io_trim;
 	else
@@ -645,7 +637,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		   jiffies);
 }
 
-static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
+static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
+				  long long *bytes, int *ios)
 {
 	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
 	u64 bps_limit = tg_bps_limit(tg, rw);
@@ -658,26 +651,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
 	 * configuration.
 	 */
 	if (bps_limit != U64_MAX)
-		tg->carryover_bytes[rw] +=
-			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
+		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
 			tg->bytes_disp[rw];
 	if (iops_limit != UINT_MAX)
-		tg->carryover_ios[rw] +=
-			calculate_io_allowed(iops_limit, jiffy_elapsed) -
+		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
 			tg->io_disp[rw];
+	tg->bytes_disp[rw] -= *bytes;
+	tg->io_disp[rw] -= *ios;
 }
 
 static void tg_update_carryover(struct throtl_grp *tg)
 {
+	long long bytes[2] = {0};
+	int ios[2] = {0};
+
 	if (tg->service_queue.nr_queued[READ])
-		__tg_update_carryover(tg, READ);
+		__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
 	if (tg->service_queue.nr_queued[WRITE])
-		__tg_update_carryover(tg, WRITE);
+		__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
 
 	/* see comments in struct throtl_grp for meaning of these fields. */
 	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
-		   tg->carryover_bytes[READ], tg->carryover_bytes[WRITE],
-		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
+		   bytes[READ], bytes[WRITE], ios[READ], ios[WRITE]);
 }
 
 static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
@@ -695,8 +690,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
-		     tg->carryover_ios[rw];
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
 	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
 		return 0;
 
@@ -729,8 +723,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
-			tg->carryover_bytes[rw];
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
 		return 0;
 
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ba8f6e986994..7964cc041e06 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -102,9 +102,9 @@ struct throtl_grp {
 	unsigned int iops[2];
 
 	/* Number of bytes dispatched in current slice */
-	uint64_t bytes_disp[2];
+	int64_t bytes_disp[2];
 	/* Number of bio's dispatched in current slice */
-	unsigned int io_disp[2];
+	int io_disp[2];
 
 	/*
 	 * The following two fields are updated when new configuration is
-- 
2.47.0


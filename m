Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132813777E
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855240; cv=none; b=Y3JrGzMxXzMk33Xk6XzQCZMJ1J1Gv8xaxMc0/5hmw5uCCORo9baKPVN62OLyMGwcstDfrH7VtjS1HZedN2y8ZUtSgBfH3nOzG8pyg5p35iabacma9ii2nIlAKz0gPhmilBUbao61q+u3o/8vlFBQHDpaCNsYNca20FjRp+02YmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855240; c=relaxed/simple;
	bh=C3Vjal98J1FOs5wSVV9I5ekTyd28kserVoMl7tCkOeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyVHcj3Txhd0IGB0ZF0GsOJda/YfJv8EGU5qzNlNtkWlpspH4wUWmW4Y3imK6rhEkdq+bKGSjF6DcsS0LBuulTcloj657kQ+u7pcCIky4oBwxwgPt2iJuJQIz3SdXOOLDU8IogqZgm48rezzQwNIvoQTZWuxNYfifIMb4gP1/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZdLh46kljzsT0h;
	Thu, 17 Apr 2025 10:00:20 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EB191A016C;
	Thu, 17 Apr 2025 10:00:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 10:00:29 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 2/3] blk-throttle: Delete unnecessary carryover-related fields from throtl_grp
Date: Thu, 17 Apr 2025 09:50:32 +0800
Message-ID: <20250417015033.512940-3-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250417015033.512940-1-wozizhi@huawei.com>
References: <20250417015033.512940-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

We no longer need carryover_[bytes/ios] in tg, so it is removed. The
related comments about carryover in tg are also merged into
[bytes/io]_disp, and modify other related comments.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c |  8 ++++----
 block/blk-throttle.h | 19 ++++++++-----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index df9825eb83be..4e4609dce85d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -658,9 +658,9 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 
 	/*
 	 * If config is updated while bios are still throttled, calculate and
-	 * accumulate how many bytes/ios are waited across changes. And
-	 * carryover_bytes/ios will be used to calculate new wait time under new
-	 * configuration.
+	 * accumulate how many bytes/ios are waited across changes. And use the
+	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
+	 * will be used to calculate new wait time under new configuration.
 	 */
 	if (bps_limit != U64_MAX) {
 		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
@@ -687,7 +687,7 @@ static void tg_update_carryover(struct throtl_grp *tg)
 	__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
 	__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
 
-	/* see comments in struct throtl_grp for meaning of these fields. */
+	/* see comments in struct throtl_grp for meaning of carryover. */
 	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
 		   bytes[READ], bytes[WRITE], ios[READ], ios[WRITE]);
 }
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7964cc041e06..8bd16535302c 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -101,19 +101,16 @@ struct throtl_grp {
 	/* IOPS limits */
 	unsigned int iops[2];
 
-	/* Number of bytes dispatched in current slice */
-	int64_t bytes_disp[2];
-	/* Number of bio's dispatched in current slice */
-	int io_disp[2];
-
 	/*
-	 * The following two fields are updated when new configuration is
-	 * submitted while some bios are still throttled, they record how many
-	 * bytes/ios are waited already in previous configuration, and they will
-	 * be used to calculate wait time under new configuration.
+	 * Number of bytes/bio's dispatched in current slice.
+	 * When new configuration is submitted while some bios are still throttled,
+	 * first calculate the carryover: the amount of bytes/IOs already waited
+	 * under the previous configuration. Then, [bytes/io]_disp are represented
+	 * as the negative of the carryover, and they will be used to calculate the
+	 * wait time under the new configuration.
 	 */
-	long long carryover_bytes[2];
-	int carryover_ios[2];
+	int64_t bytes_disp[2];
+	int io_disp[2];
 
 	unsigned long last_check_time;
 
-- 
2.46.1


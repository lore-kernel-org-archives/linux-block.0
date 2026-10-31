Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466811;
	b=nv4vb34Nihq/ftntBMfLR1Qwrae01mht84pCgjtXS6gM88YLdmG8FFQQR9EdlL13yWLS
	 VUKY1iV4o0v4QMLNZIvwkNj1Gk8ois0Ha6/5Lk03N+Qb1SbaKEN9NIQji7z3v4W5LYEs2
	 tmz/5lJRAJGv+GYbmCfn4pU9Xdas3lka9UQ2oWrB4xvVAPJMMEurYqZF5siVrRQ0UsoYi
	 ukmVy+XSNdpeF9uQh/7iv3iHDavjlvBytO4BCcCzll2wN9+1UeYfp8msjgIdp5bE65ZFv
	 4JObm3jQuNQlXCpQbuxueWAFCyEQYpPp8Bfqx4j3k4vM7Bfeu/p+Fns+dFgZNUERSTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UFAtyEX/QMO092wagtIJFdMc9yPuNGCH/ra7KSp06dg=;
	b=DXx0AMuwkjPa13U9UWlKSZ0/sNQl79loKrJ8zdk9gThuyEGWprG5NJdONbneQi29OXjP
	 JXim3jD0gBh8SUGPUlpCDrg5jMnG06hJI9rCutztaYH9WaTD7W5348uD7IRqhVSV/u2/f
	 ny9aN27ZtMAblq9kMCFgVNSV1nPItbZJ2gx+OBKvNsKTlStUhjEQGukH8zmtuJMZtJKXS
	 yeIAHPTBHkhKmb3iMtqw35+cHLsHM3HkFHd15zNHwP1J3PJy6mki/lZ6q7CrlPCO6Qugh
	 46f2povfGCx9ilR96zqufp4jN/pRtXwUsXQ/91kNP4vhkAduCX/DHZFd4ZMNyo1Znlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaRtL9n6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4E606A31A
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 17:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaRtL9n6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso11330485e9.1
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466810; x=1794071610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UFAtyEX/QMO092wagtIJFdMc9yPuNGCH/ra7KSp06dg=;
        b=kaRtL9n6U1rkkhjUxMFR6xepfJGoGJ/gEOBjP6oBxpCkI2xv47FxYrSdIdxXYEhDC6
         E0DxmnpBwtxDanktL2Qjld5I6MNTOIg8R5QeeOeO1qInL+bjebkgrPXzeR9zfOmzS7QY
         7sNIicqqbKSCCs0naPvqp2uJxPHjwfBsGaR+MlqC2MO09X2wxjzBbwj9OTHtayQKiLK1
         w6aFsO6h+iLPw8e0iyjPVv/L7HdC0T6YUY5rIOxFdVQ8Z5/UxZQTVcrMP0VXUbH4yu7/
         Ij64xxvbgQkJAnwDo3Tj7sR3qBJPyX2shOrItDUhnJVOsVCwfk8jqFcrqQ3cLHJ2y+5Y
         wV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466810; x=1794071610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFAtyEX/QMO092wagtIJFdMc9yPuNGCH/ra7KSp06dg=;
        b=hV09a5c5deIehvI8QV0YH/B3EFvTz+U14PsffE89VEpBoY7A00iwGFygs1qS19/WX+
         GeFkl6pk3Orztbwo+GvVBMapumRqzji2oV4UUt0jt5WE1S1NcjSW/fWh/AyglaWtKxrR
         xBUumySPeLxHjFw6n9eDHlzDUjTu78yeBxQ1iSwOOkCG1GefnD+eGBu0yHRp2dtviJ9A
         FC+0Tni0Kr2RV4g383dKXsoQiWYya11yE7mUMHDa9ntLparDoAP+R7Jye1ciZIUVHc6q
         +Q52IMq89Om+xQ8zH2BT1+jQsXuCVuCo4oR0MfPlpSok8p2mbf9Nv+oWN5W1g5fWhJKp
         BHCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNzp9ruf/nqeaExtE36ygJU/t1/sTN3U7hlTocZWiMxJpqiIN2i3L7ud1bp//NkwGaFypQW9LjaSSu8w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIN4zeaQiKXipOeDevCCamAIRQkHprtg7u8SDjI97xk5fcjZbfW
	6Csw/i7JEo5LpGKXavrNGZqjJ8wizQZUcyxRnEK33CpF8wcR+LOW+m1h
X-Gm-Gg: AYBFou14Z5ciVk2SqnyvhUGDFILwrUUGJxJ7sFF+vdBK2BnqZbs4a+ApPoPjB5h8iV8
	ynnqEv0BoqnKnIcIP8N12LQCT77zkyTakrUTrDZCr14lcdvJLVNpNzQPi2juPPr5XSFOUbRD8N/
	mFTlOc07Oh3w2WOfangkVPVYkRfu1AJB8+DteZBEEHbxJeezyfYcE2NmX1NhikmjIS3u2Gx6WOK
	gSGTh+BIu0D85wjWwJInhB1vPntPRed3YfyLMgHMaSyc9gI19wZaATD4+8a0eKOl1FFcX2XVhec
	1bhjOwws/4s6ETlZ2McEISEzR0Dc+E62Ut8/OAwh5MpaiYhottACh60RoCUPWaGCRfW5F0Low6/
	u9HUCwRVSjhJ/lwxylEDbkEnggZnlSbRrNNAUEioaoLxGlTwGUgJ+5TrK7XkQscssGbKycqbA8j
	2jvYMNwLHlm85ydYNegkGvzH8zTOJR+1wXh3O7A71k6MU40ork4u6S6wFnVstFyyMgzclhgARHu
	Fq4uGlt7POrTzee6Rf7sv79A2iV1vfwR5JFJUgGeIYQoUY6ioyjty4kcCGKRg1YdNZfY5NJ06/H
	g2xLLEguhO04JcYF4GGKhVNemplMJGFn/Xkl
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4ac1794032cmr130809795e9.16.1793466809748;
        Sat, 31 Oct 2026 10:13:29 -0700 (PDT)
Received: from LAPTOP-AVI.lan ([2a06:c701:4773:6f00:3d62:20f2:9efe:c976])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm138714895e9.0.2026.10.31.10.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:13:29 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: avoid repeated notifications for dead disks
Date: Sat, 31 Oct 2026 19:13:26 +0200
Message-ID: <20261031171325.4073830-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mark_disk_dead() reports disk death even when GD_DEAD is already
set. For example, NVMe reset failure and subsequent namespace removal
can call it twice, repeating holder mark_dead callbacks.

Only report disk death when __blk_mark_disk_dead() first sets GD_DEAD.
Keep its existing return value for queue drain handling in
__del_gendisk().

Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 block/genhd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..a511fc192174 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -657,13 +657,15 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	rcu_read_unlock();
 }
 
-static bool __blk_mark_disk_dead(struct gendisk *disk)
+static bool __blk_mark_disk_dead(struct gendisk *disk, bool *newly_dead)
 {
 	/*
 	 * Fail any new I/O.
 	 */
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return false;
+	if (newly_dead)
+		*newly_dead = true;
 
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
@@ -688,9 +690,12 @@ static bool __blk_mark_disk_dead(struct gendisk *disk)
  */
 void blk_mark_disk_dead(struct gendisk *disk)
 {
+	bool newly_dead = false;
+
 	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-	__blk_mark_disk_dead(disk);
-	blk_report_disk_dead(disk, true);
+	__blk_mark_disk_dead(disk, &newly_dead);
+	if (newly_dead)
+		blk_report_disk_dead(disk, true);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
@@ -727,7 +732,7 @@ static void __del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	start_drain = __blk_mark_disk_dead(disk);
+	start_drain = __blk_mark_disk_dead(disk, NULL);
 	if (start_drain)
 		blk_freeze_acquire_lock(q);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0


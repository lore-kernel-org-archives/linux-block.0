Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F347CA64
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242524; cv=none; b=OgtjODAlq3MaAeOpqE6VCiFpJANv/8fbCrI6qDDDc7sKEApgpGyspB3798eMvFHXFQ/MRXGS8q7zpRWZlNlopxq9rLhgBjPBCnOcsW2QlOlCP//orEOqxXz16YHQyrHztGmEH3PawQY2sNmfSZBmAbLdc3M8AIUgnIXJ3q1UPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242524; c=relaxed/simple;
	bh=1eGaePfxo5ymP3hIkDVgAxG++Nd7qH5qFafgF59tyLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9H8vmXPcsrPjh6j1VS1jGRrfbe8Wk5jsAZgdUeLd+49WLvQaULKgb+jIM/t2TzS2BmJf4SAw5u/vwZ8Q1rzKooVGf7z9N4L6RA3c+cgFjcRRLFDA3Ui+MRS4IO0r8S5ouv1QFiSBnU8kF537foeSfXiEwuWYL5R+1D30k8m9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lgT0Rdeb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lgT0Rdeb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so899825ad.0
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1787242521; x=1787847321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9+KSVl0O6/fwQuGvA5+3KkAZNnKqB7JpSYBZ7/97m8=;
        b=lgT0RdebfDecZyQvD+eBoNlTiAzGpaTBC2PcGUD/7918pQeympPRsqBokOOk5OpbhL
         nzlFnE/358On1F7Io8kc9fvy+XNCJm0zcbokJ4ZfvO4REcqpqpIU2C+Kek8GvmIRJvwL
         od3qlNr5MZmkisCud/F8nC11q90YAvrgQlyn5SYiJacfCgJbS9m30WII6IqJ2HTpZfmO
         uWiMHKBt+vMNh72bANIZCU3ZqnGSiJ2PaTuj7EpeVrjDxxAjo/r3wOz8cHIxNWpcQX5I
         6YMar4w1EML3LIsJ/W+zQsYmi9alKQgxxLVKmGNrIJde4iwXeLhQIWko40Y41KCVj8jf
         yTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787242521; x=1787847321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9+KSVl0O6/fwQuGvA5+3KkAZNnKqB7JpSYBZ7/97m8=;
        b=mH8IOKhQFC+JWz+oL7cn18FixflGY6BgvzvbReSwU/U3WfjSGszrmsiN+MJFbC+ogz
         X2yXFQUv9TIwhK86m8azdR0fCOficXvxr02M/R83w9EclnE3JjxZV6VTaHDcBrk80ijP
         wZIbB5H9QOAMnE8rz+//9J7VDRPgBHL0Ubj4w4Kbluzy/oBNJUalXDxc2fYDwxsRxmg3
         ygDSvieqNN/OA9VXXqKQpw8tByMBNd8pF0npaM4wbjdXJ0a4OQ5Kl5BfU3RvYbgwO3qO
         WOTvlxexyw862LqjFtZiGlZ41+1gV/rpMX8Kd3lt6TwTc2PVwIsI9H7HUzBHXhuH3Lzd
         ia2Q==
X-Gm-Message-State: AFuF++my0uZfQoK5iKbqEL3hId1wZszHdbXgJLEV3tAoRXm+6ncUXMTY
	CmH2+MxmpRquzSGna6OV+7fQfhyF8SWw+dWKp7t/C2ShynkH9jvcc1boWvdU1nmFxio=
X-Gm-Gg: AR+sD10sNpZWz1OJeeH+ec+IbaX1vaVBveeHwAGgqoCrOV4J1F1aqnawRFNL3TKE9gc
	f46j4E/GJJqP++XXPVjfoOKQFQIaaN40fLIGV6RbHRS896EghAf9QtgyUalR6yVr8UKFPmIvMf+
	WImynls2T0LXgo6rUl1elzS3O/RCOsp4Eo2738id56/f7MFBqpCIMVC0SxqMsnZBZjthhz6mY85
	+1FSBiuvOXVnAL34Axc8wiqkSSuTli6gwAkv+1qQBTeS3vOLiF1gKARxy1RLe7kW5p6Y8ivyZIG
	LkNaUqxwON1gpA+DVgCHAijivLV0WqyPXtGm4XsVQcQq8DwvMj3xpMIU2a8dbNIf2lxGFcZIW5z
	e/YnomyIQzlM1SkLXy+dj1Eqzk8odGuXANclJzeVlX8zyxPOWV1dV/cN73Y7Xjx3Meh6i/4kqVL
	3gXPfe5sHCrzPPY0IKUO5PIKqJtaqj7xUG8c8kDnJqCzCM0g==
X-Received: by 2002:a17:902:ef01:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d5fd6fe255mr299825305ad.11.1787242521354;
        Thu, 20 Aug 2026 09:15:21 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3c1924sm9221345ad.67.2026.08.20.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:15:20 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	guzebing1612@gmail.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai@fygo.io,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2] blk-wbt: Always change enable_state to MANUAL when setting latency
Date: Fri, 21 Aug 2026 00:15:14 +0800
Message-ID: <20260820161514.371181-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
state") compares only the boolean enabled state in the no-op check.
Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
is therefore still skipped, and enable_state is not changed to
WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
WBT through wbt_disable_default(), silently discarding the explicit
sysfs setting:

  # enable_state = WBT_STATE_ON_DEFAULT, min_lat_nsec = 2000000
  echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
  echo bfq > /sys/block/nullb0/queue/scheduler
  cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled

Skip the update only if the stored latency matches and enable_state
already equals the exact target state: WBT_STATE_ON_MANUAL for a
non-zero value, WBT_STATE_OFF_MANUAL for zero.

A write that passes the check then reaches wbt_set_min_lat(), which
performs the actual transition to the MANUAL state.

Rename the helper to wbt_lat_changed() to improve readability.

Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
Reviewed-by: Yu Kuai <yukuai@fygo.io>
Reviewed-by: Guzebing <guzebing1612@gmail.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
v2: Pick Yuai and Guzebing's Reviewed-by tag.
 block/blk-wbt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 953d400fd013..4f12a064286e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -813,7 +813,14 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
 	wbt_update_limits(RQWB(rqos));
 }
 
-static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
+/*
+ * Return true if writing @val would change the WBT state:
+ * 1) @val differs from the stored min_lat_nsec, or
+ * 2) @val matches, but enable_state is not the corresponding manual state
+ *    (WBT_STATE_ON_MANUAL for non-zero @val, WBT_STATE_OFF_MANUAL for 0),
+ *    so the write still has to update enable_state.
+ */
+static bool wbt_lat_changed(struct request_queue *q, u64 val)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	struct rq_wb *rwb;
@@ -825,7 +832,8 @@ static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
 	if (rwb->min_lat_nsec != val)
 		return true;
 
-	return rwb_enabled(rwb) != !!val;
+	return rwb->enable_state !=
+	       (val ? WBT_STATE_ON_MANUAL : WBT_STATE_OFF_MANUAL);
 }
 
 static void wbt_exit(struct rq_qos *rqos)
@@ -1021,7 +1029,7 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 		val *= 1000ULL;
 
 	mutex_lock(&disk->rqos_state_mutex);
-	if (!wbt_set_lat_changed(q, val)) {
+	if (!wbt_lat_changed(q, val)) {
 		mutex_unlock(&disk->rqos_state_mutex);
 		goto out;
 	}
-- 
2.43.0


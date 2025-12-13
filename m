Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39486329
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633793; cv=none; b=pW5gYS9hFWTZnFwbVBYg28/XX1rtX1vtHxaXhssj2cWOIWVzSM6a6Kqf3byZGcxN3Xv9lkDDI4En4867FnvxR0J6Pu+GxPMCgszFi2cmOc5xSaUr+98h0eIhcbWpX6xIbIPMsWgQ0q1QDIv7OAN4PD7MNk/w3Qh8bs9tFPVZTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633793; c=relaxed/simple;
	bh=14QvH3naHSF+Cn/H04n4ZyUdDGC2wxyRozONCtj/aYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bE91Xd/Wqv+ymmjU67IYW9vvdSkY3IAe1wVS+NndTHDepjHkp53gPTTHO46xDQYUUh9/1PlvRWbjSC5oUxpjaw1qGGRZSaDpWq9ps7TLdOgr5zxIJjbNJ7rf3oc3cb1lln7z+Y4EsqPJO+39sVytdqG1MDUIoFK5tyx8i+VdPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhad+no+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhad+no+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29ba9249e9dso29317865ad.3
        for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765633791; x=1766238591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4lr+SsdP9C1poChLly+9BIV9STN5LJ5GiutjjK6FKg=;
        b=nhad+no+xFVFv5bRlGH6v6FR7IJg3w4xzFHhTUv1iYx1HVN8Mg4YoLuuN0cf1R/5K/
         GEmXwK6QRswPojlLW7S+6a6oz4gGqYBttV85uItaIvcRqi3JPYCaGDLjXg3NImQ1TV1z
         wVL8W9LLJ9kNZUaqVGjshJmLhwtEhSYRmCzndBM/CQzv1WuloAoY+/JUmB1s77eYJ7aL
         l7FLJoHjZV++qQ2eOHj7ts942YgxHUXZ8BfGyw/MpVAY3FRZReA7V8U9/5qfv1tupRLk
         E2KxhDQ0yBhRBNonDqHyc4BNQ1Rn4nZ+KW8Iyxh+kU8QKA/YJRN4EbyBAj38XwWnPT/0
         YLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765633791; x=1766238591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4lr+SsdP9C1poChLly+9BIV9STN5LJ5GiutjjK6FKg=;
        b=XbZWwehn4JtHUk+q3BoL2QNpdkc6GU0HMINuuoigdiSxE1Alsjv7q+DjsYyYif7A+Y
         t2+qnKZnajBgVNaTombKKlo8H+DACIEAuv+j2LvMw32UwQxPJB9xwQ5pGKs+8L6VcAlr
         E1Kocb0GuTxcl76xjVv+twdV4FGhC4zEuuYynIoF+g06Xs1EwR/s8ddV1qvab7n5zr8W
         y7ReIRyxY/ZSMpdK6bKHsBwMmeckVibcUhoUVaS8243Cw3zsWxQJX9J6s4K8rcLLEbbi
         yyD5vW2islyH++JPgD1lYEOk9g8IUgs1OtFIvrw9EfY6orJpZr/Shpmq2T6bizdd8p7m
         jOew==
X-Gm-Message-State: AOJu0Yxyw9Li7YJ1YL1nHksYI9VyCmySBl4E9sAmE1rRLpaJYPi8mLvD
	YTzjKxKqp7TimQfF0/O0X2kiMJ8c8+twD4JzfQjUEDC4bx1A5KVlOktA
X-Gm-Gg: AY/fxX7ESd1LEQeo7w8lo3YDvMZXXOWHeB3yZJIebI2yOphMwBx3z/D2M6XhkkrRrlB
	fVf+faue1K0UliMLG4NYnTPyM2OQrIaW8qhAnIl1887Pug9Cpx4KZc4PGxcOKQD2qOwlJZPlFS3
	xMTOfzlDawuIqDfWemusg/yEOniIPEeEU2SzoLGv6MzLceD5m7ZBJXweTNPTzRbCQgb7xPkYdUg
	lZyn28H/01IFcYvQoje7vGUayLf4b8hB9UcCZGKmqaZSOIcLcfAPnqGrjb6n01kJT+tTBCk86dm
	OSs1JpoCYyl5QgUUcDUY0Zo7EFKUcLQE5Bch63mJZJsSxxz4yJOnN7Xyni1UItoG5le1ycGZrqq
	AZeDIcCkkRIjKHXNtA6mqQGN8rypYG3Tp0otQVO953GvGUS6elBzV8Z2UbtuFIbMaKJUTuKne4r
	Vr+zAYkFU5QDAxHWTlTcLJmVIlFKw=
X-Google-Smtp-Source: AGHT+IFato5PcIpwQUol4/S1MGGE4lqoGRgge6oekSsxwohpfVKqcKcwtpJOwm4npRUErkjP043/Fw==
X-Received: by 2002:a17:903:1b28:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-29f23b6f49amr54688215ad.23.1765633791046;
        Sat, 13 Dec 2025 05:49:51 -0800 (PST)
Received: from monty-pavel.. ([120.245.114.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea0594e8sm82214395ad.87.2025.12.13.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 05:49:50 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v2 1/1] zloop: ensure atomicity of state checks in zloop_queue_rq
Date: Sat, 13 Dec 2025 21:45:46 +0800
Message-ID: <20251213134545.207014-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The state check of zlo->state in zloop_queue_rq() fails to guarantee
atomicity. This patch changes zlo->state to an atomic_t type variable,
avoiding the use of the zloop_ctl_mutex lock for protection.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v2:
- Change zlo->state to atomic_t type instead of using zloop_ctl_mutex
for protection.
---
 drivers/block/zloop.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 77bd6081b244..6eb4bbab374c 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -110,7 +110,7 @@ struct zloop_zone {
 
 struct zloop_device {
 	unsigned int		id;
-	unsigned int		state;
+	atomic_t		state;
 
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*disk;
@@ -146,6 +146,16 @@ struct zloop_cmd {
 static DEFINE_IDR(zloop_index_idr);
 static DEFINE_MUTEX(zloop_ctl_mutex);
 
+static inline int zloop_get_state(struct zloop_device *zlo)
+{
+	return atomic_read(&zlo->state);
+}
+
+static inline void zloop_set_state(struct zloop_device *zlo, int state)
+{
+	atomic_set(&zlo->state, state);
+}
+
 static unsigned int rq_zone_no(struct request *rq)
 {
 	struct zloop_device *zlo = rq->q->queuedata;
@@ -697,7 +707,7 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
 
-	if (zlo->state == Zlo_deleting)
+	if (zloop_get_state(zlo) == Zlo_deleting)
 		return BLK_STS_IOERR;
 
 	/*
@@ -726,16 +736,10 @@ static const struct blk_mq_ops zloop_mq_ops = {
 static int zloop_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct zloop_device *zlo = disk->private_data;
-	int ret;
 
-	ret = mutex_lock_killable(&zloop_ctl_mutex);
-	if (ret)
-		return ret;
-
-	if (zlo->state != Zlo_live)
-		ret = -ENXIO;
-	mutex_unlock(&zloop_ctl_mutex);
-	return ret;
+	if (zloop_get_state(zlo) != Zlo_live)
+		return -ENXIO;
+	return 0;
 }
 
 static int zloop_report_zones(struct gendisk *disk, sector_t sector,
@@ -1002,7 +1006,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		ret = -ENOMEM;
 		goto out;
 	}
-	zlo->state = Zlo_creating;
+	zloop_set_state(zlo, Zlo_creating);
 
 	ret = mutex_lock_killable(&zloop_ctl_mutex);
 	if (ret)
@@ -1112,9 +1116,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		goto out_cleanup_disk;
 	}
 
-	mutex_lock(&zloop_ctl_mutex);
-	zlo->state = Zlo_live;
-	mutex_unlock(&zloop_ctl_mutex);
+	zloop_set_state(zlo, Zlo_live);
 
 	pr_info("zloop: device %d, %u zones of %llu MiB, %u B block size\n",
 		zlo->id, zlo->nr_zones,
@@ -1171,13 +1173,14 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 		return ret;
 
 	zlo = idr_find(&zloop_index_idr, opts->id);
-	if (!zlo || zlo->state == Zlo_creating) {
+	if (!zlo || zloop_get_state(zlo) == Zlo_creating) {
 		ret = -ENODEV;
-	} else if (zlo->state == Zlo_deleting) {
+	} else if (zloop_get_state(zlo) == Zlo_deleting) {
 		ret = -EINVAL;
 	} else {
 		idr_remove(&zloop_index_idr, zlo->id);
-		zlo->state = Zlo_deleting;
+		zloop_set_state(zlo, Zlo_deleting);
+
 	}
 
 	mutex_unlock(&zloop_ctl_mutex);
-- 
2.43.0


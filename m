Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FC27B4FB
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791947; cv=none; b=AzcmjMibWmRe4nurKFroRD8FUsZA4QetUy3I/Glm66Z1a7LvX9H9ALYlN6yy7EcEmpElYjrLBmchXanhKWp0K3FgiTGWAlvnNjmC3WpWl5tf/2Xmr/EA2ww3spKx2BLZ7d0FUgOeWAzGZ3NVQIGUEXyvB3K5XY46hkGmAcnnRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791947; c=relaxed/simple;
	bh=APezoHdPu1DViME6Oncq9HwVeocybLrY1MRb8ArqmSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R99czD2EZ2G3arZeJXGJuBdpkc4N+F6tXV0c1B3A2HVwPsdF7ZMDt+KGQwqsZ7L/PzDKZfRR/PrPbRsnC7CEvFYnfpeuwaoxk8tBzOWrCYBUfdiWUvlwyk/7BfrCI4b5BYFBLsVGFRduyU5dx09+JM4uzXLO/CLVPCajezh3UBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4d1h8FN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4d1h8FN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a110548cdeso4002655ad.0
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765791945; x=1766396745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd7dfA0AJM2VweKhIo1xBGZXen3y5JniKwSqf40IL9o=;
        b=J4d1h8FNoiFqTNsy7mUy/SJdnAhmxOQIMEmiPJ0GR8Rafav7SelsNT6ITAp5y/JmdJ
         NpMTWUDivnvB9gxFW5pYex7c/XgOwNq8M/os8p2PLL4kKvz/xyY0mgl0IUWobUNpGEV9
         JSiFvHU9BX4kQ4Z3hxKq9FeNETZtuMgSvrGXidaVuE1/xMfpdFWNVL7BJUpLVZt//f1l
         hZv+HxeREDS/tdzepQrIoeW+kkU747m+KxU/2J8LZjsrGezrIYdaZrv6On9mW5bWTFVU
         6oc0nRAGA4S1sgnWnlOG3r8XZiXC241A5eJWWiQa0CpkCu4ocPQlJtSNw2cHkHe+TC0o
         lKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765791945; x=1766396745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd7dfA0AJM2VweKhIo1xBGZXen3y5JniKwSqf40IL9o=;
        b=jXxnQsWtfNpq3X1GucB022KMvp7xoKoeBHdLDNplqteSGkuTosPAwbCH5KiDcTBH0x
         vUHxtP8Mfj1w8uGHPF09vCeB76NL0OyEBjqr5ZsiLDw/GxjjcNFu4XVdr5dGsaIxR0E9
         LjXvTlqpcX0y95uIUgp58OM8FvuuNOqgLdMQIbHyYeurtIvWiB02obkoIqAKWegSI9Eb
         taU60qVbG5bS/ikFJY+s+9RXAD/rS+lsrjd+ayyDKX/qjinONVw6wpYoalOWZn6xDqoU
         JxEytvWbBeX/AyqKlYocNGaDOu0o62u/RVokE11c1QpUqvZVDH3VtccFFhzzz02/B0Gj
         dmBA==
X-Gm-Message-State: AOJu0YyW+OIvuWEraLO05VyezNW3FSYUH3b6lXkr/1rEpYErPEy3iINE
	xdEAGrW596DKdO6rN0Lf0Jca7CGGRsELx36g3GH1ETn8OLuL7MErpHbo
X-Gm-Gg: AY/fxX6fWNOYsO6OoolOmoE37dCHZVR/InlWwcXndc1oLku1Z1zQyNaeD6PdHdcjJHt
	WY8xIs+pRE/l9+vkpLRltSW9vN3RIPiMDELDQSXVIGrhXWAbBXOvId9PvwRgZzLG0wXGmf95ON0
	K1NEs4WMHWU/olLAv/s20+alyyIWnaEEg9s5Sa0/s9o27VD1gTVFqGX0A7cIss1ssGUOA2nPjXW
	vvCBeY4Da+HF5nIkTmjkLfWtsFoskwqbz+MoZMYQS92s9TrH8mV8RsscyE45NbvngbJ+7/6Kb87
	T2qRxKIpSqY9uKAjwTzQnQ/vDXY0cI+1mjXztQdB9InAd4YKXmY6fRlcHQr6Hnl+9J/UzMYOBx4
	3W6bgfPDfhZ1Sk8pXqNESystNx70b2inQwOnThE80jh0MHRmwTIWdgdRg7SW6X4e0P17i8lH4/e
	dwkZnGtLZdsrRtdbab9DlZSfjDHj9LlBholgSrAjOXeQfYPlv6uxtQUpaF6w==
X-Google-Smtp-Source: AGHT+IF1qmaygzWMmhzfXE7ldSEYqHlAHFh+ELM0vNqoKgVchN9xhHUAEcWINA46JNGOsW+VZbA8bg==
X-Received: by 2002:a17:903:1b45:b0:27e:dc53:d239 with SMTP id d9443c01a7336-29f26eb2a1cmr94934955ad.35.1765791944661;
        Mon, 15 Dec 2025 01:45:44 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06b651sm129401435ad.94.2025.12.15.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:45:44 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v3 1/2] loop: use READ_ONCE() to read lo->lo_state without locking
Date: Mon, 15 Dec 2025 17:45:22 +0800
Message-ID: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When lo->lo_mutex is not held, direct access may read stale data. This
patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
code checkers, and changes all assignments to use WRITE_ONCE().

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v3:
- Use WRITE_ONCE() instead of assignments to update lo_state.
v2:
- Use READ_ONCE() instead of converting lo_state to atomic_t type.
---
 drivers/block/loop.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 272bc608e528..b196387a85cf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	/* Order wrt reading lo_state in loop_validate_file(). */
 	wmb();
 
-	lo->lo_state = Lo_bound;
+	WRITE_ONCE(lo->lo_state, Lo_bound);
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -1179,7 +1179,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	mutex_lock(&lo->lo_mutex);
-	lo->lo_state = Lo_unbound;
+	WRITE_ONCE(lo->lo_state, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
 
 	/*
@@ -1218,7 +1218,7 @@ static int loop_clr_fd(struct loop_device *lo)
 
 	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 	if (disk_openers(lo->lo_disk) == 1)
-		lo->lo_state = Lo_rundown;
+		WRITE_ONCE(lo->lo_state, Lo_rundown);
 	loop_global_unlock(lo, true);
 
 	return 0;
@@ -1743,7 +1743,7 @@ static void lo_release(struct gendisk *disk)
 
 	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_state = Lo_rundown;
+		WRITE_ONCE(lo->lo_state, Lo_rundown);
 
 	need_clear = (lo->lo_state == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
@@ -1858,7 +1858,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	if (lo->lo_state != Lo_bound)
+	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
 		return BLK_STS_IOERR;
 
 	switch (req_op(rq)) {
@@ -2016,7 +2016,7 @@ static int loop_add(int i)
 	lo->worker_tree = RB_ROOT;
 	INIT_LIST_HEAD(&lo->idle_worker_list);
 	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
-	lo->lo_state = Lo_unbound;
+	WRITE_ONCE(lo->lo_state, Lo_unbound);
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2174,7 +2174,7 @@ static int loop_control_remove(int idx)
 		goto mark_visible;
 	}
 	/* Mark this loop device as no more bound, but not quite unbound yet */
-	lo->lo_state = Lo_deleting;
+	WRITE_ONCE(lo->lo_state, Lo_deleting);
 	mutex_unlock(&lo->lo_mutex);
 
 	loop_remove(lo);
@@ -2198,7 +2198,7 @@ static int loop_control_get_free(int idx)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
 		/* Hitting a race results in creating a new loop device which is harmless. */
-		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
+		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
-- 
2.43.0


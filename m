Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5B2F4A19
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812172; cv=none; b=pCSAFaYDFhld7BpNMKEe+qyDxl7Ai0YFabhCuNMSrxpR6oWCbQ9ZsNhwp7FcbNfZFfd12S0J5tfkMvzONT5lSzDEoeAJwlm3vp1spkb0HNS64naqK2e8ILlUa8KbSk+Vd63pEcKW2ED29TDrUSJIdAepioxYfJsb9A5syZAM7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812172; c=relaxed/simple;
	bh=GrYDMkkVM83L+OZOHC2tdHm5Nvoq9LJwSFJjtoZ140o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fd0FGs4hsCDpTgzcsQj7NOmGPv80rN5qWmE2p9V7hsBdcGphB4QG/zI+nBZy5lZt1fu5+EUW69x6Xj76uoVJpnMuP7/1G+uj5NS2vpxW5yZGOvUKxPgzuoVjZLc59vj6YVgX9F79txyxyv1ZQvBvIGgZCQ0/Gag37PTI5q1vmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHE84JJ1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHE84JJ1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0ac29fca1so14965385ad.2
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 07:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765812170; x=1766416970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4bcEz+r3wsA6a6lIVDd7kXO2VpMzjI5i/1DPs2Ga+w=;
        b=BHE84JJ1ih5Qpd3z6cmBd7NJAu4LOMcAtXU2ViVXtjmdBBbWNy1hWkTPhTYxhFxPNl
         AyWb4hp+zNLPCaK6seQmQuwmkXQT9/uN8Pt0ARKghtsF8z/gtk4c+cR7dyDLBugpC8V5
         qlP7p0AIJKZRMZUUnAw28e4Epk9DIwual6o8++EKe4eoNdIoKJI3KGmDMOYE59v29zBR
         Z2fDNkty3k1FIHkQnc1FhmeVZxF6OV3SwHpEDaRuTkAbaczuy4VpfLTsiYyeoU69k8qQ
         ubRxrmFqs6GBgh0Z1UKp5PBs066XINAVONQ00IoMWrrOk5krinFDuy2qyHsMod2UINPY
         PJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812170; x=1766416970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4bcEz+r3wsA6a6lIVDd7kXO2VpMzjI5i/1DPs2Ga+w=;
        b=VN7/DK4y5yU8lwsisOk5P8mTqBBichccv9EcfcBpXYT00qpCK85CAv63mEEsrUxafK
         QmNcPNA2f00gSwczB5f37JkBMVnUshCDBte1XXElj5vB3o9ssm7aHrcCbenq3QFfAxCs
         4z4OPtLChr9VOGgOrFlLxcZhKGcVRNe8Y9iZrpUSGm2qhumTGiFQAns21qX9LTXPZLXh
         MWof7f+ShYu0/95ugTk6NIQrFgEH9f4zKkTbyCVb8YsWF8Sgfd4PvpzKmHxP0SQvBUYR
         Kf9tsFShHDjUbOVm7Ocx0YVgjNKhMM7tYTi+/E/ARLIkhYaLR2LMwsgx17LUAIbeomDk
         Uqgg==
X-Gm-Message-State: AOJu0YxOgoxdglInwOyq/PhNHKp6UIBwsY/cs4Tv+m3OCwBpvrF5g5yZ
	V2rUMUNF5+NYUKPgXppOFak66HNiUmel+/o9/UNoBjSwLP17MUWYc+PL
X-Gm-Gg: AY/fxX4BWXEtiEI2FkXolOVeonExDnzjROuPhIAr+3gm9jz/Mblana/61hcVNpPXVW7
	Dx7nPqBGaVUMQgjMulCkJ+lXej8juqL+eJG+cP0BC6cI/xLcT39lfoda0tCLjCddGlxHD/OGCBF
	zU3AgpthdNNkyATUC8Iwj9KW6kx0kDVVx1UtzQXbJ8YjfaD79ALDrUZypFqmejUtR3k+L9PFkFu
	fXTNuYm1oc6w4UP6e9p8yMDQMOQyayp3aH7C+guJXoDl9u5TO7MTjJPUJ30nQ+IKIkmeUc1I51k
	I1yoP+QVPTXLaMhMZWQI92PsBWLkeYC3fqVtvwKT9LhcEKMxM49mpercRYIxb7QJC8pOj32hN4R
	V36G6WEDaWvJ519P4EpVf0/UFgDiZma44fhFATy/msQ9K2Px5aNOW4kP7v9znvyJaYTq436hor8
	9eexHc/e8u9sb0XNuupXnkIllf+0xWP547pA4TjA==
X-Google-Smtp-Source: AGHT+IHW+9oynqQB2aY8f7o9iV61NDcxe/Rj5G+E5ZaXZrpSiEw0CZLpUB+oBbB4QrAF/MHgrD6WOw==
X-Received: by 2002:a17:902:f609:b0:2a0:906b:ac35 with SMTP id d9443c01a7336-2a0906bb316mr96262925ad.42.1765812169545;
        Mon, 15 Dec 2025 07:22:49 -0800 (PST)
Received: from monty-pavel.. ([120.245.114.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0b0a708a6sm59372525ad.97.2025.12.15.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:22:49 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v4 1/2] loop: use READ_ONCE() to read lo->lo_state without locking
Date: Mon, 15 Dec 2025 23:21:04 +0800
Message-ID: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- Avoid the overly long line in loop_control_get_free.
v3:
- Use WRITE_ONCE() instead of assignments to update lo_state.
v2:
- Use READ_ONCE() instead of converting lo_state to atomic_t type.
---
 drivers/block/loop.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 272bc608e528..32a3a5b13802 100644
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
@@ -2197,8 +2197,12 @@ static int loop_control_get_free(int idx)
 	if (ret)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
-		/* Hitting a race results in creating a new loop device which is harmless. */
-		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
+		/*
+		 * Hitting a race results in creating a new loop device
+		 * which is harmless.
+		 */
+		if (lo->idr_visible &&
+		    data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
-- 
2.43.0


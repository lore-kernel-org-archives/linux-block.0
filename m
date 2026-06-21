Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A137238166
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782006040; cv=none; b=FhpMkpPLQSEBb5RmdO+NC+S6lqpQRmIdk+3rZIdBsKwEGNCgolTh7eD8Mpd4eRHsx6pznOyraV3a0OynG/OayLXCQOwyQ4D0r+SqwPYimSMpaBNkW70XcjgXXnXv9hUyHD1eSYY4zjkMz0C2a734Zulve3UuFLEe4keEDMJqa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782006040; c=relaxed/simple;
	bh=L50Ya9H4qA7s0O4Aw3FWQ09DEha+hIy9UvEc9gvFjCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Juee3oris7CHdQ2n5bCFcnYyqZrzU+gFlSeVo8rfA9XgqZtCsXBKieFJKHZhcywCgQPBmcayBVeNhaL9Eq5xwNM9HYmXfbeUO/hNJXAulLZSMv390LlFBCZBrhhUJYMP9yNagA3Zzf7AMpuGJyZhGj8Ru+34F0eAbp5xXWzTmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeRFlCVJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeRFlCVJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso16810565ad.1
        for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782006038; x=1782610838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QP0vHpV7SRNJLf3qOdU/AwmER/PkJI4+g3ZMkna9Rt8=;
        b=XeRFlCVJwM28rzth+Bf1wVhwGtxgkGtO8fpXnf7wj3E4kIibnGlNWSKpMbOokjbsDd
         b8+Mp+127Q14Hhn9lvq+bC7MSeu2UtLL9xLv8HdT6ZL7VUfRsrDO7bX41oaCZNla3HMH
         GS/C8PBCACmG7lzHcctX/yD8fYAFZgdYbDwA/GiE85EcsqSqxkTHHgW/BA6yj7mI4dBB
         GBbryBEdpthEcszq9t+cygGs9BVKQIVSYnINHKn2VmQ26V53RI/wDGUVyGcGdSnv+wIz
         8Gul1hViF79GEDvPN9101BFhHsatq4nqBeE/5HOLnm8LxN4NTlYTA52+T2DPKIE0zXKi
         boLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782006038; x=1782610838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP0vHpV7SRNJLf3qOdU/AwmER/PkJI4+g3ZMkna9Rt8=;
        b=TuMs6mE7JJ/48vQTuT9z1uVSknFt42Vjr/W60Xmy0qyQZOvGIBfG+b6iSwAmLVTj5w
         QigYNgwEWS6+Fo/rsbQ51TfA6cEu+Z0nnsMRvhAJiiWOOkvbkfNtVrEEKnnVMXyb0c9J
         TsnxUkV0o0R/Q06+57CF8BuL46iouqfJS7YFK1tYKHkb/0HD9hzcFigLtPFQqX1TENmk
         J42c7n736sRUN8GXn8/V6PMUtNjcy1e37mHt2fv6qGz2oF/j8zrRzeqc4kSBVdjXAg2V
         p/be+DXxaZvwYJaS64KEUjB+Q3iEYgKVuc0VhdWmyws4L9tsJ/wWStFW/CAH1sAGOppN
         tJqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7Utvu4//FvX2YkvBJQWaI8EnQXdBOq2rE/xUDEP9DuNEG1AuvVaLcszp7GuWEoKkLjshHEoiCeYz4JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHSix9fGLSMIojHfgS2w09j9m2NGK2xg3us98AST/Jz5AhdKE
	YRQJ+fQ+l99K/+BB3LFqWREntJftJGQ0gz6AkDJbFYQkj6QICHgzrie6hJ6XOA==
X-Gm-Gg: AfdE7ckvDxO9nz+87XwlbZUnVlHdMfDXXcLH9CxM5qdognsOQz0uRWLqy1yStwG/ZTy
	L1abAzcFPxEGyiTjnkL6pj4EJz75kK2BxvVNpHhv1Xme4LfQ22MVlRSgFEO6D1SILzHgBYiZGFW
	lrFQS/73fiKk44Y1XjZzg3O+bE05xZVYBlArY5di+oguptWZH1lwe8f9bTU8E8JhC/zjZq/wdbV
	d1QEuggTiFPEBY+3grsYmEZ0odHDU8x1oSwbCB6ZNKrimTKvppZrp1UyqJG6JWy+PQ09iLLObt3
	Tmf6VWtpDeeRiGpGpnw2coOKuJR9IZFpNzzL7D0RD/sOJq9RGViJ+i3hiyX2OFyUwcbZH8cYF1u
	+Az+hS+FUW3WgNAMp3LdrcxfxLaJqLny7m9g2qs+YaLS8oJyu37SE90Tf2bFmcnhqpQpyh4mo4e
	moq2QR4jDGdXsdKFd+sIrv2X/t/ZezALc=
X-Received: by 2002:a17:902:ec8b:b0:2c6:b7d5:27ea with SMTP id d9443c01a7336-2c725d37e2bmr77924395ad.17.1782006038171;
        Sat, 20 Jun 2026 18:40:38 -0700 (PDT)
Received: from n232-175-066.byted.org ([36.110.163.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436afdfesm34711505ad.7.2026.06.20.18.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 18:40:37 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Guzebing <guzebing1612@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Make WBT latency writes honor enable state
Date: Sun, 21 Jun 2026 09:40:30 +0800
Message-Id: <20260621014030.1625306-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guzebing <guzebing1612@gmail.com>

queue/wbt_lat_usec controls both the stored WBT latency target and the
effective WBT enable state.

The old no-op check skipped updates whenever the converted latency
matched the stored min_lat_nsec. That check ignored whether the current
WBT state already matched the state requested by the write. For a queue
disabled by default, attempting to enable WBT by writing the default
value through sysfs could return success while the enable state was left
unchanged.

Treat a write as a no-op only when both the stored latency and the
effective WBT enabled state already match the converted value.

Signed-off-by: Guzebing <guzebing1612@gmail.com>
---
Background:

The issue can be reproduced on an NVMe namespace when BFQ is available:

  echo bfq > /sys/block/nvme0n1/queue/scheduler
  cat /sys/block/nvme0n1/queue/wbt_lat_usec
  echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
  cat /sys/block/nvme0n1/queue/wbt_lat_usec

After BFQ selects the queue, WBT is disabled by default.  On a
non-rotational NVMe namespace the stored default latency remains
2000000 nsec, while the sysfs file reports 0 because the effective WBT
state is disabled:

  queue/wbt_lat_usec = 0
  debugfs enabled = 3
  debugfs min_lat_nsec = 2000000

Writing the default value succeeds, but the old no-op check skips the
state transition because min_lat_nsec already matches the converted
value:

  echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
  # echo returns success, but:
  queue/wbt_lat_usec = 0
  debugfs enabled = 3
  debugfs min_lat_nsec = 2000000

As a control, writing a non-default value first does work:

  echo 5000 > /sys/block/nvme0n1/queue/wbt_lat_usec
  queue/wbt_lat_usec = 5000
  debugfs enabled = 2
  debugfs min_lat_nsec = 5000000

Writing the default value after that also works, because the stored
latency changes from 5000000 nsec back to 2000000 nsec:

  echo 2000 > /sys/block/nvme0n1/queue/wbt_lat_usec
  queue/wbt_lat_usec = 2000
  debugfs enabled = 2
  debugfs min_lat_nsec = 2000000

With this patch, writing the default value after BFQ default-disables
WBT also re-enables WBT as expected:

  queue/wbt_lat_usec = 2000
  debugfs enabled = 2
  debugfs min_lat_nsec = 2000000

 block/blk-wbt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index dcc2438ca16dc..953d400fd0137 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -813,6 +813,21 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
 	wbt_update_limits(RQWB(rqos));
 }
 
+static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_wb *rwb;
+
+	if (!rqos)
+		return true;
+
+	rwb = RQWB(rqos);
+	if (rwb->min_lat_nsec != val)
+		return true;
+
+	return rwb_enabled(rwb) != !!val;
+}
+
 static void wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
@@ -1005,8 +1020,12 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	else if (val >= 0)
 		val *= 1000ULL;
 
-	if (wbt_get_min_lat(q) == val)
+	mutex_lock(&disk->rqos_state_mutex);
+	if (!wbt_set_lat_changed(q, val)) {
+		mutex_unlock(&disk->rqos_state_mutex);
 		goto out;
+	}
+	mutex_unlock(&disk->rqos_state_mutex);
 
 	blk_mq_quiesce_queue(q);
 
-- 
2.20.1

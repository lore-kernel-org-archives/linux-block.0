Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D572393DE0
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856788; cv=none; b=o/vGUQ5CzKz7PY+hTLQUzi2Gv5ZpgyTJNAr0apvhl+WNBr35ET00HGUM7+zNMDWez3yOzrmPIJWFGGRA5GOxCkBqIsKppzVhBrmOxr1i5wTVpnRKYcuw04DObNRheQ1So3+xcQSTQfOskaemtv6QibWNO+/PtcEThdJoTy7h7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856788; c=relaxed/simple;
	bh=+MdI4r6n10gDS+p4YVUaZONpes94VhcY87e85kZMofE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV+gpZLR1kr7Bl4/iuK/TErb5TK44XlZkd9+vVMrJuIXHb4CsnDUkSYNty23m76zZHdfpLGtEWtffKDsiUeAwPdJOfM2mWFJuNBRFK17dhnMHcuaVF+ScdNoz51DgbfGTnaAQIAF3dHd68jGMX2+C07Isd38bynuqH/nrtk0c2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3az9Lf0; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3az9Lf0"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so22458025ad.3
        for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856785; x=1790461585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/g+orwBOaMljS/JJ6ICfCzvcRhieOLrMuJNELTyKpxI=;
        b=S3az9Lf0TD44ncVbRuSYmGonqLpsANDxcAaKrvYX+5UOOvKbSHpmW2VJZUlXT1iJFX
         wA84iZrN6KPtOA0tqxX3m3LFfhaucS+zUXda0Mep6RMEXXoVmz5tz1XY+uARI3YvOB95
         VNZAJ2jpniORc2bt7xJiNCUak/ne1L1CXDVRX573OR458YNzCNU2GtsmZMTve6Lnt7Mz
         uFHpbo0YOoE0Z6FQOP8P5JTFhrjuvQjUWuHlZ7p8jjdsB3lXtmO5FbG/5KcOe+OqyxNS
         VrHlftUQ3Dd5uUkFw5LPB/Rx7Zz4JAhZVRANa4PhZZa/sOaRndM+l7mz9MeSU25K4D28
         jWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856785; x=1790461585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/g+orwBOaMljS/JJ6ICfCzvcRhieOLrMuJNELTyKpxI=;
        b=ELly3bZd6u0nWmjeAfha6SLv2HTtel0rFCG/gC7ZuPXFzx/F38sO9CpzUJ17N7QHMH
         YVNBWGMTjcZru2VEIhmCaxIeuPwYMZPt4NeNruwntUmtbzCZaN2rRgrQw22qbAZlQXvJ
         IPtTVVPCL0LjROKCbgyn1ZmVa4KzFe7NjHKnGICtd4w7rSwEqDV7U7s92kZztP/hjs8u
         HQ2BQvNET4nrkmN1BBYtP3a5ppYJnTOHLxPgkJvYdypWOcdB0rjv9HKVhmImvvMsc3NR
         BOoBGGDYFP6u1raGcjr+FDTv+w2aZCJ7OsrQYhBx8vN7QY9qgQfLXEpzcxoDkbtWyFPk
         e8rg==
X-Gm-Message-State: AFuF++kelza4IzpxFEJO2yIfn+r3vfNc6+i8+E2EHCXxdO+TlQIq1Gn+
	i5G7MoC0vf9PZJl/RX5megWXXUVyNA0f52h3N9uOsWLtm/raGzZ2QLMQbfgFjgpM
X-Gm-Gg: AYBFou18IKH+rk4F73YrGturcHAW6GQJd7U6C4yUYHSWs+oRLrcjelNyjvaVc/TAQwT
	vAL2kYLJV1ZR6Fzt7CXbiI4Yo6+97YL32zHxa2QSNo2Lfh9DTDeQV9bgQ5cjOjgRx4Vx9AxNIm2
	wr/56Qqe+/QjVD5tmvlmvfM0us87H12s553X2ptfJLo2diaWVbbuGEQgh9vs50v+NddQbaS+Qnp
	h65AUCkx+C2p3D+HtvCa1Yl4f0tOEokN9qyiI/2h6TkUYAsAK2rXOE83bc92sOPubbVNXQ2O+XP
	SGskTAPQ39z/dMrd8rRn4YCJJlrjlMTOUTnGjCAooYO/3T2reKxIJnxDxqlKePLYYsO9ON9aAkd
	M3LNbi/ThJxIvU06OZnVINnP46UIIkhTYxorUMZzjuUU7OqXcMAqRtL1269663USQJ9/SedB6SX
	MPlSPb8+ltDmuz6BwGteaXh5aC/u66DG87dSssRderdDELuwDnhRxlsWH4I7KeU+0c6y1F5boFu
	p6X1fXGKCwqe7VQt07qRR0VrAU+xobGwLAuwoqW2MY6RhWyikStU38BbizOO2jUFqppxrQbmLuR
	LA3hrmigGw==
X-Received: by 2002:a17:903:2312:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ddb1b899famr115123815ad.14.1789856785398;
        Sat, 19 Sep 2026 15:26:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm13208235ad.70.2026.09.19.15.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:24 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] loop: restore lo_backing_file, gfp_mask, and uevent_suppress on loop_configure() error
Date: Sat, 19 Sep 2026 22:26:24 +0000
Message-ID: <20260919222624.3797511-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In loop_configure() (drivers/block/loop.c), if
loop_set_status_from_info() or blk_mq_unfreeze_queue() fails after
lo->lo_backing_file has been assigned, reset lo->lo_backing_file = NULL,
lo->lo_device = NULL, lo->lo_flags = 0, mapping_set_gfp_mask(mapping,
lo->old_gfp_mask), and dev_set_uevent_suppress(disk_to_dev(lo->lo_disk),
0) before calling fput(file) so a dangling struct file * pointer is not
left in lo->lo_backing_file with lo_state == Lo_unbound.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..8fae858c9df7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1086,8 +1086,15 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	loop_update_limits(lo, &lim, config->block_size);
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error = queue_limits_commit_update(lo->lo_queue, &lim);
-	if (error)
+	if (error) {
+		mapping_set_gfp_mask(file->f_mapping, lo->old_gfp_mask);
+		spin_lock_irq(&lo->lo_lock);
+		lo->lo_backing_file = NULL;
+		spin_unlock_irq(&lo->lo_lock);
+		lo->lo_device = NULL;
+		dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 		goto out_unlock;
+	}
 
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back

Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D64A498F
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066030; cv=none; b=Ocray4PsMwqaPFpoIxLEjHbqk//4Y+auW2XlROuETXATi1f52fq38/P7AIPJZ/QVb3xdRZ6bFzxM8SuCnvvDaO5Bvdzahk9c7TlgYzG0iA4+akoPxhO7nb11OoIHQPVFgiSFxjMu77m9k6rTzcn3+vqMr38HrkVQN/ISuNOM8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066030; c=relaxed/simple;
	bh=tFirq9WK8z4MHqUYry8B+dBatiOov7iRGGmpOlMjYDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EM1eS5TQD58qBunX/q2XCRlESpC9vwoB+LAZoHy6W+TW2ctl1JoPkDQt5gGfCva/JuYrj8NV+XJEMehlUzw0tu5+eP+ndhsPQ4KcMbOvHGoC49MfTBB8AVXTd4VvDqYThYh2R4Suhyyz2yXtrAuxWZr3DqmV25+bamkNhchjHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piI71mZr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piI71mZr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so3230313a12.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066028; x=1792670828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKMqH5LXFbN7kyYU7PnKFmn1gNr+IrqxQUbfeXE0apY=;
        b=piI71mZr/EC1EnT15UjAompgtYIQHB1dUfxdcJzIPNsxLEwjptdnhbw3xdtCGTfh3p
         wgf+QZiWBYa42b2gcXDQi6M1hn/v2aBJ0fNtsuR9hgrzr4JD2IedioJHvBfrKf2lYoWy
         p6yj23BZUfc13+gwJyLlmVree5TYWFy4iZqHBuwv519Vcw5kdrsoNGZXtXj1KYIHkmEK
         xru0wyzBLqhDKM9Isp+uO/TGIJ0oaTfjs/Jjm91wgak2BuvE+eH9bHOBPHevlUL1WoaV
         Qfw5CQk3hATTnxipz7O08Ptd8OBEiLC5zwon66Y94HCQ9AW1g8UIXfQIWVOm9zOzoWMP
         mPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066028; x=1792670828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKMqH5LXFbN7kyYU7PnKFmn1gNr+IrqxQUbfeXE0apY=;
        b=spVr/dE65kwWCNI5iY4cVkVip4btiXzA0c3DDKz+tbax5dKcsh2XACmR8VfWRpe58H
         bcLlixHz7RG2ZbokxKpNdAg6tdj9doObmLylOZQiKjzprFbY8MR3fTUux8H+jxWHSSuP
         xNQpsNH999rhvd1JxpE9mWEenabU6ho+LTUhEgaKx5XSEjFFjE+ZfZkQlAB8Aoi/rqsW
         hurV6j2HAHvB589LndjurwpqX7rqpgjuLKB8DEQ2aHoSoEkr37M787CYgVNRuVM23jYU
         b64gmo1rBGNM2nVsEXcbSRygM30OIlV7yOpP0WzHrG5bQhA1yB2MoFcPJywZWllnXUjK
         eYVg==
X-Gm-Message-State: AFq9FYJsDmhmVN8zV1znK+aI7u64Fzm+eQuAuDGmm48NDuGRqWv4YrDg
	U16m034W+BYkaUEWktIoCmt0Jh95C/cwh96VTR6Fr/YPEHeuQNbfAqYd
X-Gm-Gg: AYBFou1GqIboGU5qD29c+IjC1XiLU5YNVYVtUSSAKf7vVCVj8SuaczyMObraGGIKQ1D
	gAAP2edpoQW0ScAzGMblNxsj56K+hnyGmViVCPFHBjScOj3LrX4S1NSIjw3zSBOLytbRK37m34V
	Ou8Gq3Pr3h+6cwjRZNr0iA5+InP4LUqafVsVcqygVhJJvJG7lPV16Xhi0DWVp9P3/+/i605GNCE
	rl24tRTjSpmtbwhnKRBOFfTb6YuREC6BP314Hcp4LpLfX34J6+3Cmfxiq60JB2zuB8JYSZvfpxe
	ALDyBNo3kVW2Pe25qZ3M5jLaJTTaT5kgXWWxe6wlSmATk4vIKcXD+FFAAtetaqlattZi5N/KTWc
	qA688Lgah0Of+se/7eQ6IpEARnULOcqWfU+2k8XqBvR8ecitDIa4jwywCOGN6c9cBU2Phsb9793
	BBFO5FNQQ0HvmgrByx8Te1bEvCiGBafUzPAoipQa9rOS/ln5BQ2hqUQE9MjMIPzyDO/zyxcAkDr
	aHtFJJJ
X-Received: by 2002:a17:90b:1a82:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3ab3ab209f3mr9754562a91.25.1792066027993;
        Thu, 15 Oct 2026 05:07:07 -0700 (PDT)
Received: from localhost.localdomain ([106.101.11.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944b0bfasm4399621a91.16.2026.10.15.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:07:07 -0700 (PDT)
From: sonotri <sono7ri@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sonotri <sono7ri@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: pin module while release work is pending
Date: Thu, 15 Oct 2026 21:06:54 +0900
Message-Id: <20261015120654.241354-1-sono7ri@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_release() takes a device reference and queues exit_work.  The VFS
module reference held through the file operations is dropped after
->release() returns.  A queued work item does not acquire its own module
reference for the callback.

Consequently, normal module removal can start while exit_work is pending or
executing.  In addition to the worker callback itself, the final device put
can invoke ublk_cdev_rel(), which is also module code.

Take a module reference while ->release() is still covered by the file
operations reference and drop it only after the worker has completed its
final device put.  A rearming worker retains the same reference.

Merely canceling exit_work during module exit is insufficient.  The worker
is the terminal path for the device reference taken by ublk_ch_release(),
so its cancellation would strand that reference and skip the associated
cleanup.

Fixes: c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk char dev is closed")
Cc: stable@vger.kernel.org
Signed-off-by: sonotri <sono7ri@gmail.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e71..71556c34a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2613,6 +2613,7 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 
 	/* put the reference grabbed in ublk_ch_release() */
 	ublk_put_device(ub);
+	module_put(THIS_MODULE);
 }
 
 static int ublk_ch_release(struct inode *inode, struct file *filp)
@@ -2625,6 +2626,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 */
 	ublk_get_device(ub);
 
+	/* Keep the worker's callback and final device release code resident. */
+	__module_get(THIS_MODULE);
 	INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
 	schedule_delayed_work(&ub->exit_work, 0);
 	return 0;
-- 
2.34.1


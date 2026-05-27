Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E401E0DE8
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892853; cv=none; b=GOJ/YQCk4c8jEYcJUWrZIM8Dd1VFKcrFoP16DhwB7FDAF9rrF8WDASpPWyPhMhZtLBU2NRIcZ/7LLix4SLpev3aEwyGh/kmkwvKwDN1IzHjan02fNnhH9/Mf2DKn3YawMD87qd65/Ga/EosMMNhC1e997Lo7zCPg6sO2zOrjoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892853; c=relaxed/simple;
	bh=FV2IXyx8/nXIVg9/1caDReqPID5Up9lhiiFamfUSihg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAhfXuho/m1jb11KIglSud2KBmRas57AfmwUHlweAQ32eR9QOd1xA88/+VVvRCBdxdf9Gic0PYIqXz//AsfzYK0bQj+qLIhh0rOgf0lzSkGLxDNJFn/dt1xEsY1RBvoSfHQ6cenmZ2sUIMgIFha+zHjQiMm3wHM2MCKlm+6cujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMA2nLCU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMA2nLCU"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb856a674so142896376d6.0
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892851; x=1780497651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUpH0zdc8ebub+ihvp1zMWEIICrgVcJA+p65eXs6JeA=;
        b=gMA2nLCUqdzeg+BxQvalycQRBIyUqR8MQv+4pVqdHZr8Po/8CgAavGp7cLWLbe9+6W
         wI0FjCGRxj8JEWdIThXxpwrQHLJG2pkJRX5te6fnt+/MSOtvUAh1OxidqhS+JYEnNHKy
         gjpMOgTiGXoLtBcHI4py+AzozrkuhwAmGWFi5uPDSzT5k2kY11xJfawdyf7exAv7Prsc
         dRTD48EzXrD+Ns1iaiUPbwoRXjqkkh97NRvyekE9vIxNwOY5ljXauZK9ySkrKl+kqxwN
         ueGI5n1mSmIJwvMCChAjzRHT7M+eOajsJDnQHr6Z9XYuafGCwNpUqrqB1oPj5OHSBpPu
         npKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892851; x=1780497651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUpH0zdc8ebub+ihvp1zMWEIICrgVcJA+p65eXs6JeA=;
        b=KqbQrEjf3nbcQTkbyRt7SXi7mSGah+V52toFjmASI9rB6ZaxjhWxxQCEWoqIpYsgjc
         sjCRN2JDYCl8nU4hcsk7BE72KB91zngjc+B+DG0YNyu+T3jAy5giMMq/eAx7ljobtxL5
         Be2luKPvp7bQ5El9HEszDL8J1k0uBt/EJ3gZhHnriEW1gG0+Xh305DV/TI0om4wwrLge
         6QJl5hQcXOjTxVY5jsXDP+7TvMS3lmOeXEJYHqIHdeOH1pbM+jPaY9IUEK1v/Lp+9cxf
         UAIHCzMkh+gP+PK6a/CoK3qKzHt0rH+D77Oavr7FiCbQnRmOxThvKET4081oQFYfeBAi
         k9hQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Yn6Hmjf5lt2+FXymLEwKOFmG2IpY9ChGM4ZD5zm5Ry/A2MunRHK7zTgxklaVumhSyK2+PhPYGao42Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlqt9dVj7LJRs0PzewcZoYHdUYULWViFx1ew+DX7/OeZd94jF
	lDMKvJg6oy5kN4YQYGX6rCnO5iBQROGNxtGqNsDvJdZjc6F06c3mncda
X-Gm-Gg: Acq92OGZabD9LaL+EapPIUCbM1adWIPDQF8AHOG5t8WWW1kaxeVNSbQLnTbtg3BD1Gv
	cgb2dxOIv6CLMwMIwurau0/eSj/xRNK/kEMMcuft8yNl7PjBSYd9Fd8HTffpRAxySNuarP/xgo1
	iY6TR+veRv/7lokZ4NxjwesyjIF1S2GO/v1BLLlOHMmwbLvHomI8QBKn+xubTpHb7Jl9GQ92dC6
	EdrKG6DDXpLhNzvYcrwNrDPtvWuqYyWWo1ZqHUToueU6ugZ7HeBYRNiXF8tmlC1B/Xu31kUIMza
	yYtE1DutSU9id7gL5tNtl28seRU/6wPP1+Ziw9FS7xJyaLakX4N5MI5b7I3IzXzvFFIaYjFdgmo
	kPkaxnUjMTSYOXAEwcmrrT8dc4hVH+/kHiTAuDmvDgGlPYdenaxUkO5yqyFzDIlr4IwLic9BH1V
	KWYUwz19RthR6HKcha3+ZDGbx+oLCMJSYOz5lK5zRBOzFNNRylmCweZeKX4DEEq01NkrEyFOfIa
	lyxEFcVaOckmdlsgcOl5VBLpPQIJOYaV/X/o1R+pGsEhA==
X-Received: by 2002:a05:6214:3287:b0:8cc:e17:7d16 with SMTP id 6a1803df08f44-8cc6e3568d5mr305317246d6.7.1779892851095;
        Wed, 27 May 2026 07:40:51 -0700 (PDT)
Received: from fedora.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf895sm189097276d6.1.2026.05.27.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:40:50 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: set canceling flag even when disk is not allocated
Date: Wed, 27 May 2026 09:40:42 -0500
Message-ID: <20260527144042.2095194-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_start_cancel() previously bailed out early when ublk_get_disk()
returned NULL, treating it as "our disk has been dead".  That is correct
for the post-teardown case, but it also wrongly covers the pre-start
case: ublk_ctrl_start_dev() has not assigned ub->ub_disk yet, while
io_uring is already tearing down the daemon's uring_cmds via
ublk_uring_cmd_cancel_fn().

In that window, the cancel path skips ublk_set_canceling(), so
ubq->canceling stays false, even though ublk_cancel_cmd() goes on to
NULL out every io->cmd.  ublk_ctrl_start_dev() then proceeds to set
ub->ub_disk, call add_disk(), and schedule partition_scan_work.  When
ublk_partition_scan_work() runs bdev_disk_changed() and the resulting
read reaches ublk_queue_rq() -> ublk_queue_cmd(), the ubq->canceling
check passes and the code dereferences the NULL io->cmd:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  RIP: ublk_queue_cmd drivers/block/ublk_drv.c [inline]
  RIP: ublk_queue_rq+0x73/0x100
  Call Trace:
   blk_mq_dispatch_rq_list+0x1c5/0xca0
   ...
   bdev_disk_changed+0x3d4/0x5e0
   ublk_partition_scan_work+0x89/0xe0
   process_one_work+0x344/0x8a0

Fix it by always setting ub->canceling / ubq->canceling under
cancel_mutex.  When the disk is allocated, keep the existing
quiesce/unquiesce dance so the flag is observed across the
ublk_queue_rq() barrier.  When the disk is not yet allocated, there is
no request_queue and ublk_queue_rq() cannot be running concurrently, so
simply flipping the flag is sufficient: any subsequent I/O - including
the partition scan started by ublk_ctrl_start_dev() - will see
canceling set and be aborted via __ublk_queue_rq_common().

Fixes: 7fc4da6a304b ("ublk: scan partition in async way")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a08593b9f862..4f6d9e652187 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2727,23 +2727,27 @@ static void ublk_start_cancel(struct ublk_device *ub)
 {
 	struct gendisk *disk = ublk_get_disk(ub);
 
-	/* Our disk has been dead */
-	if (!disk)
-		return;
-
 	mutex_lock(&ub->cancel_mutex);
 	if (ub->canceling)
 		goto out;
-	/*
-	 * Now we are serialized with ublk_queue_rq()
-	 *
-	 * Make sure that ubq->canceling is set when queue is frozen,
-	 * because ublk_queue_rq() has to rely on this flag for avoiding to
-	 * touch completed uring_cmd
-	 */
-	blk_mq_quiesce_queue(disk->queue);
-	ublk_set_canceling(ub, true);
-	blk_mq_unquiesce_queue(disk->queue);
+
+	if (disk) {
+		/*
+		 * Quiesce to serialize with ublk_queue_rq(), ensuring
+		 * ubq->canceling is visible when the queue resumes.
+		 */
+		blk_mq_quiesce_queue(disk->queue);
+		ublk_set_canceling(ub, true);
+		blk_mq_unquiesce_queue(disk->queue);
+	} else {
+		/*
+		 * Disk not yet allocated by ublk_ctrl_start_dev(), so
+		 * there is no request queue and ublk_queue_rq() cannot
+		 * be running.  Just set the flag; if start_dev proceeds
+		 * later, new I/O will see canceling and be aborted.
+		 */
+		ublk_set_canceling(ub, true);
+	}
 out:
 	mutex_unlock(&ub->cancel_mutex);
 	ublk_put_disk(disk);
-- 
2.54.0


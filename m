Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC631E7C23
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777865354; cv=none; b=cvp9I6nvSjDYV0ajUyOuc9NU8YzoRjJEY6pDFKq+KoDyKcutzPYfpMhJoaKh5YfOLKxlnKOHsRAFTdB7kMw42szYdKevuHGGYUYywBjDAG+WESnk5Sa2Nsbw02Wr0W7gfdBUbmrdPkk8DWRncWQiYDiatqjJFNO99lwcyBuHJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777865354; c=relaxed/simple;
	bh=e3c1aJi9cdRikhG1TAYQtDgXPR7Exc/+fRN0Oa3H2c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrHzYW7s8ohoq1+1DMtC+61c44JqUb9up3hsqK2qoZ7eM6kNA125+S/aXmkdtbn4hTCpMa+r9av2FlztFZSPtHmOYpljhZTClRiTfF5ruQ+/8WPUr5ZNxLbTlEAdvCgrbSp/scAq7V3fROUiybFb33ijdzUBQdnE5Gc3zTzgp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnKtApdR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnKtApdR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso2733544b3a.2
        for <linux-block@vger.kernel.org>; Sun, 03 May 2026 20:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777865352; x=1778470152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z41zW/n/iQloyMt7R2rXQjfcS9X6TQ9nrqVkTfnUhDQ=;
        b=AnKtApdRcEFYzL25TQaksEwTl+ktUsR3Q8opMNnMxpWgKDEBeN/tVCd57yBod6exy0
         PddBrNumcLG7xjaWQ6BlrOepHty1HWJa1CeAb8k8yNJXc664RuZXg/rpYEbZyd1bKdzQ
         BzD+Fqzrh8+ftchnNKLrlR3WSKIzA3f5xzeNYivWum/E7NV7jYPyQL2jc2L9daPuIXw4
         6QL5w/2oairtZ2IbDL1AWUt56pmShgHzr+InSZhVDA95UbjYSknySTSA55K0mLnceJvm
         RG5CQniPsSQJyiLZs6sV8Cynt3d3s33aL/CZ6S1KJ+oNUVEry0v3voVfoSW3B92bkbOm
         efRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777865352; x=1778470152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41zW/n/iQloyMt7R2rXQjfcS9X6TQ9nrqVkTfnUhDQ=;
        b=qHmdqQSaRG3dSwL4x6oalMskzUa9p+z29Dx1yVVDPBGXFsx4U8wIJrvccC5QAzDva+
         iXiYEHXy7u+XMy+LbQ3VvJnFQR0Fp20j7t6qZHMgDWAouv+0lvC8ZJKtGrFrt1NEb802
         rrD9987ikTUhxjvQtdoVwjlRnceIIzxLDFD928wT92sfi7ltpiHxH0pDnONpdwRUwPmf
         27FN1bap7Rb5QuSOrtB/iOR4VJozpiHiISGV7upvo5RFLAQvP7JpGsVKOflwvjWMlSW9
         3D0MTdXCpdDLL41+jTQjD0nH5NKxs+INv5SiT8PzBO/Ozokuj66/FsHvcbFODIylpNue
         yGfg==
X-Gm-Message-State: AOJu0YyBLj+2hqcXg/I8ylE9MFuVQ/GX3C0MCNBhjbDoOCi4jiVzx5q1
	ojQJWyPCkyS064QkzcmXekKPz2fmtQTnNIhFxq6GULzVwCuYVL1bwPUs
X-Gm-Gg: AeBDietP7D9Z+Q5CSeZSvO1NUYO5k4iO0/ZPIRzT7UJbjKKEnTemeM3Cmkn+am2ybUw
	ArgnLO3T+hAhGEG5iLBDGqEUeDirVmgMAic4Dbel475IRSTZAOhuq08f9u/a1bWfi+9NmRd0M5R
	hBG9GQ6CCqqvZBjnCTQmRFr7Yfe0SgO/pUAasQjgLSdZwH6A8LIXy2melj22Jp8ITH4qhtp1Bq4
	VEAXhwC1CrDeOGQSqRioUO0Yg4ionJIecSoWC5ifEnLTcG4i05BQMv9mneSdJKYqHJzhn5Wm8QZ
	IrP420rLUfyZsMcvdzTXsRgBL4KtdAFjiZ5AJd/3EsP/aM1b3XTYQNv4Xbxi0njk6qxkTWtpAcl
	Y5qZjWCdKcSnSqIUwiRGYFWx03iSsEATIdO6cHM5OW1JjpfAqL0n2KBRwsrA6q3fIM+4l+XqwwG
	PvMwFHAalp1o7tJ/VWDqkqZVigWss7
X-Received: by 2002:a05:6a00:4286:b0:837:7e7d:3d2 with SMTP id d2e1a72fcca58-8377e7d086bmr2405512b3a.31.1777865352437;
        Sun, 03 May 2026 20:29:12 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm11128941b3a.31.2026.05.03.20.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 20:29:12 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] floppy: select FDC before arming timeout work
Date: Mon,  4 May 2026 11:28:53 +0800
Message-Id: <20260504032853.316099-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

floppy_shutdown() uses current_fdc to choose which controller state
to mark for reset when fd_timeout expires. lock_fdc() currently arms
that timeout before set_fdc() has selected the drive/FDC and updated
current_drive/current_fdc.

drive_params[drive].timeout is user configurable, so the timeout
can be immediate. Even with a non-zero timeout, a delayed caller can
leave the timeout work running while set_fdc() is still testing
fdc_state[fdc].rawcmd and updating the adjacent reset bitfield. The
timeout can then use stale selected-controller state or race the reset
bitfield update.

Move the timeout arm after set_fdc() in lock_fdc(), and keep the
same ordering for the direct floppy_queue_rq() path. This ensures
fd_timeout cannot run until the selected-controller state describes
the operation being timed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a64371..f9b924a2f276 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -894,8 +894,8 @@ static int lock_fdc(int drive)
 
 	command_status = FD_COMMAND_NONE;
 
-	reschedule_timeout(drive, "lock fdc");
 	set_fdc(drive);
+	reschedule_timeout(drive, "lock fdc");
 	return 0;
 }
 
@@ -2874,8 +2874,8 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&floppy_lock);
 
 	command_status = FD_COMMAND_NONE;
-	__reschedule_timeout(MAXTIMEOUT, "fd_request");
 	set_fdc(0);
+	__reschedule_timeout(MAXTIMEOUT, "fd_request");
 	process_fd_request();
 	is_alive(__func__, "");
 	return BLK_STS_OK;
-- 
2.43.0


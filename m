Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45E3DBD4F
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243881; cv=none; b=PjZF0J+BFum+oqS4ww6oc7QK8GLOKxL1giUaaVAAlt8gf16uzGnBXdTDWTttShW+09/6z/OAzAiPxWVPIKGz+YgHHqPZAJrQnfBSi7CTClW7SoRWmtw4xyRvKBfDC+yfXIoOZNMhouxAPmLu49uBuEKdtMVJTGLKehqmZddHYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243881; c=relaxed/simple;
	bh=kNG+BTWckXJP3rn8FWqYelB+Q8L5smtnIax0JqqYgnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bByLN4csWWLMge+4zeehHmQHTrc//PZA7CjFco0/9cwwfqo/jnt4Ei8Z4a5Uo8gYKjqR3Q53kWZdeO6s1H/kPslzXVz08/RV/XjbY65ufqCSc0D2MqHpdW62QcXM9LrLkxB/I78i+QgJ/ikx/dwqZSuPErbnOEz4pSi7j0lOL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBWG424P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBWG424P"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso12358345e9.3
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778243878; x=1778848678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGFRVzseIrgSG0kT51YhALCYAmsMxi9AbMkzYLus09Q=;
        b=EBWG424PKKFyICs6AIN9B1JvXvfxFgKS/zsPor+vPyXY/76mP9nr3xralzrbLxUqmh
         1u6+1U/Cgxu2J8DtaQ9/9i26fme4emvaNP+LEENxrdJbvHGQB/4H31AtBR2VUz6iIKPa
         ZKi+Pt7teFqTjRcY99dSdnrRtYgvSIVKhqwxm9Kk8Q0f8iUfYtr2omy201hurjxr9xZR
         RSvZwQcoVQYAGRQRoPfo6GEFcqJsnE+jM5wYq/KXBIIlwH7maQHKeCSxGyVSVPV67Zyl
         ew97lkhztW6+ToQz5XdrAh9DlcVuWIOn0iCMnzQ+UpNdcl/4jX7Gjdt1RePFKsGeGbOl
         opAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243878; x=1778848678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGFRVzseIrgSG0kT51YhALCYAmsMxi9AbMkzYLus09Q=;
        b=r516R0Pewnce92M5hhTUSCyz/GpebctEoV2CkwZhUPRsKITrScM3pbMR5L0u6hipEH
         fYSHEqCVS7MrSAaYpFOlTX9iAofJX/ifdeT6WTWWFVlmcvRO0kiKvn59li8JWhZvJ4pa
         GH8Px9yWBYKh3+oF9Ep6et2eiN2q2YQqBbJ2/r/CvEXh98+p+1iOCrH6D60bIKo6us0n
         bG+TQR1kooP48XdY8yD2A9HXMODUXPfcPZhhPNhWPFGCKbM7ojkNqgsj9jGiSIrNCy8U
         fkzXwyQUX6bZIz5n2zHPzA0UC8CEA6KBRtm4Vxthirdzqt/8q9TC44q3owcwuTEec0Gu
         nyQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kJ7bTrJZQ0fyCklQIPzEv4bPTmCwlBZKnPgm4ZxtVQrsBDZ/qnG63vCTHAvWljYnSu80Ajg57vuQk7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6eOLGTHfjB6x8WKT0M+NGUi6jfQY56+qcmsomwcKyKFnJu/C
	R/APLlqy7okJ/UEFRqhABsB1CCksNehsrjASsJjccM8QDsoAFRXWyiw1
X-Gm-Gg: AeBDietJLNvVegHdrk7lk5jg8oh5xMDAW+UibzB+HMyEOQJBlUp9Jxe7m5FFrRM0NUq
	iZc5lgKbpl3OXQjuEn/GRlm1IzqIp1m86GmtenIzIPpkdXe4rAJ0yDWWtGpkqJhz9d5ke388euP
	m6gCRTxCkjJcbg5soJzl9XqtsXOswbVh6QIphQlp160Mk1mZs+DJtPeq4JdfEyeBux35U8p+UWT
	oSGTd/7s3e1ptbdbwCZ2sDiix52IHnNbe/jQzM9uUKcFfmBmbwMKgzVpPzWlnZc80WXuIep8UjG
	TnQ5obbxI1+AV+3y0YamQKtXhAxyjgyaQuUp3qTFMnFjoTKjwi7UBfYbHzNppF220CbiPvlKUa9
	VPv4Dj1dYFFMH36o7wR8b5RFEcDaSj5nci9FOgqjZR5aqKq61LDBBHFTsjKkxEGiXqweMVnilyJ
	O1GEY5HM2U7i7apgCrFclLH35qL1KEf+bh9Ikehw+Y2Cnbj9KgyD6ZWmHXZn08nmajbi3nQztfe
	mJD
X-Received: by 2002:a05:600c:8485:b0:48d:5c1:bc47 with SMTP id 5b1f17b1804b1-48e51f32a6fmr205237325e9.15.1778243877989;
        Fri, 08 May 2026 05:37:57 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e65a09f2asm24169455e9.5.2026.05.08.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:37:57 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: fix use-after-free in ublk_cancel_cmd()
Date: Fri,  8 May 2026 20:37:46 +0800
Message-ID: <20260508123746.242018-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ublk_reset_ch_dev() clears io->cmd via ublk_queue_reinit()
concurrently with ublk_cancel_cmd(), ublk_cancel_cmd() can read a
stale pointer and pass it to io_uring_cmd_done(), causing a
use-after-free.

Fix by synchronizing the two paths with ubq->cancel_lock:

- ublk_cancel_cmd(): read and clear io->cmd under cancel_lock,
  then call io_uring_cmd_done() on the saved local copy outside
  the lock.

- ublk_reset_ch_dev(): hold cancel_lock across ublk_queue_reinit()
  so that io->cmd and io->flags are cleared atomically with respect
  to ublk_cancel_cmd().

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 57ec900f0ce0..6d13f1481de0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2411,8 +2411,14 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 {
 	int i;
 
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		/* Sync with ublk_cancel_cmd() */
+		spin_lock(&ubq->cancel_lock);
+		ublk_queue_reinit(ub, ubq);
+		spin_unlock(&ubq->cancel_lock);
+	}
 
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
@@ -2753,6 +2759,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 {
 	struct ublk_io *io = &ubq->ios[tag];
 	struct ublk_device *ub = ubq->dev;
+	struct io_uring_cmd *cmd = NULL;
 	struct request *req;
 	bool done;
 
@@ -2775,12 +2782,15 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
-	if (!done)
+	if (!done) {
 		io->flags |= UBLK_IO_FLAG_CANCELED;
+		cmd = io->cmd;
+		io->cmd = NULL;
+	}
 	spin_unlock(&ubq->cancel_lock);
 
-	if (!done)
-		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
+	if (!done && cmd)
+		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
 
 /*
-- 
2.53.0


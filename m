Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39905477981
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459578; cv=none; b=G/kxneymI9HSUJGRLl9NGVGfauwXe5S5ooI2ndNEK2wpjyfzXuZ5AZXhLF5Dn/KRHOcbalIPlmCRxDm0qL7nsRtJIBu9Pk5nZgtWox0OUM7RM2bR35gk9DgEAdjyijeUkN2lg3tiHkFtfkYzZMs2gmIp1VMmxzCtT6t5jPgfuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459578; c=relaxed/simple;
	bh=oUyzpLntyEgJF+f9grjWYn6w5iSVBhX5j8Y+i+9jafg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD8M+FbR71CbkqSui5w5oJKklI9QWoP5hsndBjovPFfpqUCzzrLljtry5oSHclfK50u5TbMEFGH7x6L5nmDUweTdW5dRT6lreYUxtM0n3080Fcy4piKQKqFd3kLsXG9Ph1wzC/eOECXQlIndcggqqmGDeEcnmMIBfTk7A7y1WiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObTmEqt6; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObTmEqt6"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-81b54d0cb17so2436435a34.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459576; x=1792064376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=355CzK4j7uNkVtDtuyRXZSw8VPaaw6+P9Oy+XhPlNpA=;
        b=ObTmEqt6pbLmwx5Qi57liJRf5km1Trc8TM7HJ+ofDT2r3WA1uTbdRHJeZzUPi8f8dZ
         Z7743PvTBaFBsI3tPGkd9yeeKKzs25vv5Ayu5pGPtTpkU1yBiK5i7xYPr3qwgP+1+WV3
         32Q/d/4o5Ko6rBeCli6waykRwDu1SmCYmfgbBZnBI8eJ70aT42Ygp7M+lMRnxK53+b5e
         Tn/RN2w36JGAyFtes+4W9t4GswT89vQiAEpTKFpeQ7eOqR4qLbnDrfHDNdBoKCqgw0FJ
         YCLtBtA7io2p+JCYxpLUC7V37N5RWJuGY8wczhUee3v/U8GxZrM9IjcliLHxYEMrsZXT
         qAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459576; x=1792064376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=355CzK4j7uNkVtDtuyRXZSw8VPaaw6+P9Oy+XhPlNpA=;
        b=W5pknD7ToejvznHKwO6tA6kIPDxlcjLiF/FVZ/nVkzDGJXXWNaRgaccyEFj6h0l7ID
         eyVI7JDOws3mJO8Z0RdDeXiny4EpBoD48AgT8r9HFTxMng9a3cBFWX5DinEqgxs1i3x4
         WTLGB5yK/daBpiJ6FJe144fL2th4wrrniCHFg5X5AiJhGyf8yzKXz6FpRSR/IZYcBp+A
         iAQrQal9rJaY0djNclwNW1lCncZxYz9Htwp57CUwytihUH9B+1O4TlwgD1xoNEzS6G8x
         gCEbY4fJcICViOff2/H0Uak1DdvZal54Q5aVzuo77JL0/yCS9NrQAxLy6QO+Pjn406NW
         1SIw==
X-Gm-Message-State: AFuF++m5hEOf7F+xTg/SopyhNnGsAty7lJU/WHDhYs/6cbPipwGqrFq/
	d4uD8UvpqBzisdI5v/uMdKJ6WtyJAxOJQIfX/amy3K9fplDhr5EOylyVvQsYs10B
X-Gm-Gg: AYBFou1rI4RUIYecx4MFFaO72xRG1wN02qqXbUDT8HOswIK2llQii/Urymr3CuqE4Jy
	CcmQG7NmBXB/D9OiPXFzIDKGj8dZnPgZBPLdi9UiqlbuzLPphQdvqbiENyRzekmzxdfJyau+VpO
	FxsBTHWaeK9xeh8UfHyLbV8T0LlC9vOOXJHCXI0ZoLLj3OyIJ0DjmGV0JQhsdpjpSxVitwd1dqf
	uZC4uu/8ZEUFrLK7Hj9vbYCRvDiL5RJP2WGEw3Oy0VVI3voNAHFAD5uHC/koktiK3Hy9xIHAkI8
	UsiG1y5Qg/Wj7WNmCyJEwD7pmqyzW5hxHFD7zc0ZtRIq0+DtC/iAl5mZz1jV81VTLkaPFiNbo8n
	Wgx4QgRlvZg/Uak3isstoADSS546DSUiuNmEd7M95Cr1557FoHGUd338WtYBGi0RMXqHP1qzWC/
	3KAslCPgzhIeOStrQ+TqOTU86r5OCDg+Utz2ipikqjysU9+9JSANrxwomVQ9DUYAnjd2F+jKPTC
	zD4yh1EZLV/0fdLervBCVvesTQzU69S5mDblPx+A44zDf3uZ4rz4WDCnYGIAjPAJq184mjVC0+9
	Cbza0Si56At6uHbgMEh4CsfFNMA=
X-Received: by 2002:a05:6830:dca:b0:817:bb8:cb7d with SMTP id 46e09a7af769-82ad0abcb46mr5915336a34.18.1791459576004;
        Thu, 08 Oct 2026 04:39:36 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:35 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 08/11] ublk: refuse to go live after an io command was canceled
Date: Thu,  8 Oct 2026 06:39:04 -0500
Message-ID: <20261008113907.4000838-9-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Since commit "ublk: keep a canceled FETCH round canceling until the
server is gone", a device whose FETCH round saw a cancel keeps its
queues canceling until the server goes away, but START_DEV and
END_USER_RECOVERY still bring it up. Without UBLK_F_USER_RECOVERY, or
with UBLK_F_USER_RECOVERY_FAIL_IO, every request of the new disk fails.
With UBLK_F_USER_RECOVERY, requests are requeued and never kicked: after
START_DEV the partition scan hangs under disk->open_mutex, and after
END_USER_RECOVERY every read parks while the command returned 0. The
server cannot fetch the canceled commands again, so the device can't
serve I/O until it restarts anyway.

Return -EBUSY from START_DEV and END_USER_RECOVERY while ub->canceling
is set. In ublk_ctrl_start_dev() check it and publish ub->ub_disk in one
cancel_mutex section, and have ublk_start_cancel() read the disk in its
cancel_mutex section. Today ublk_start_cancel() samples the disk before
taking the mutex, so a server dying during its own START_DEV can mark
the queues without quiescing a disk START_DEV published in between, with
its first I/O past the canceling check. Now either START_DEV sees the
cancel, or the cancel sees the disk and quiesces it before marking. The
END_USER_RECOVERY check is best effort: the disk exists there, and a
cancel after it is the ordinary death of the new server, which
ublk_start_cancel() handles by quiescing and marking.

Assisted-by: LLM
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/block/ublk.rst | 10 ++++++++--
 drivers/block/ublk_drv.c     | 38 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index ed3285e361ad..f07611b0d489 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -118,7 +118,11 @@ managing and controlling ublk devices with help of several control commands:
   After the server prepares userspace resources (such as creating I/O handler
   threads & io_uring for handling ublk IO), this command is sent to the
   driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
-  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
+  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device. The command
+  fails with ``-EBUSY`` if an I/O command fetched by the current server
+  was canceled, because its io_uring is gone. The server can't fetch it
+  again, and the device can be started again once the server has closed
+  ``/dev/ublkc*``.
 
 - ``UBLK_CMD_STOP_DEV``
 
@@ -202,7 +206,9 @@ managing and controlling ublk devices with help of several control commands:
   command is accepted after ublk device is quiesced and a new process has
   opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
   returns, ublk device is unquiesced and new I/O requests are passed to the
-  new process.
+  new process. It fails with ``-EBUSY`` if an I/O command of the new
+  process was canceled already. The recovery can be started over once the
+  new process has closed ``/dev/ublkc*``.
 
 - user recovery feature description
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 176fbf84737c..ecadcf5e3e33 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2759,9 +2759,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 static void ublk_start_cancel(struct ublk_device *ub)
 {
-	struct gendisk *disk = ublk_get_disk(ub);
+	struct gendisk *disk;
 
+	/* sync with ublk_ctrl_start_dev() publishing the disk */
 	mutex_lock(&ub->cancel_mutex);
+	disk = ublk_get_disk(ub);
 	if (ub->canceling)
 		goto out;
 
@@ -4575,6 +4577,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		.dma_alignment		= 3,
 	};
 	struct gendisk *disk;
+	bool canceled;
 	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
@@ -4665,8 +4668,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	disk->fops = &ub_fops;
 	disk->private_data = ub;
 
+	/*
+	 * A command of this FETCH round was canceled and can't be fetched
+	 * again, don't bring up a disk over it.  Check and publish the disk
+	 * in one cancel_mutex section: either this sees ub->canceling, or
+	 * ublk_start_cancel() sees the disk and quiesces it before marking
+	 * the queues.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ub->canceling;
+	if (!canceled)
+		ub->ub_disk = disk;
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		put_disk(disk);
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
-	ub->ub_disk = disk;
 
 	ublk_apply_params(ub);
 
@@ -5238,6 +5257,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
 	int ublksrv_pid = (int)header->data[0];
+	bool canceled;
 	int ret = -EINVAL;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
@@ -5261,6 +5281,20 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+
+	/*
+	 * As in ublk_ctrl_start_dev(), a canceled command can't be fetched
+	 * again.  Best effort: the disk exists here, and a cancel after this
+	 * check is the ordinary death of the new server, which
+	 * ublk_start_cancel() handles by quiescing and marking.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ub->canceling;
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
-- 
2.55.0


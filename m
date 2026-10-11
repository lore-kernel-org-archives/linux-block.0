Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00139A07B
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700597; cv=none; b=DkR/PYzPh9sp2+LEG1RLLpploKNKIcTqKonAtWZcr02CVZt0+5T2un67E1P6TElq0VqSnEpmZKExAFnIyzN6+d2M7rg4lzC56wjxYK8o3VAiTZ8KUMaSQZsCvQGrK/AZDAzwj6I+taUe12xRRY6WKWgQycFriIAs2GORjFsAHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700597; c=relaxed/simple;
	bh=RpcUXo8JS3Tnr+IjBRaJ28jv2kPklpyCxmGiXtOkWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTNv10eCO0e0XhdCLj9S47PFo9JnP89/sn5pujfEelUElT/S/Xkx1fPKzA0IZE/DYIm9BgUxzSE0pNk6timgR7dgWTmeLOCSU88H+SM69oVNGw0JDsKYDyUGxwNFvPNYpjrUuqsaYPATq4nVFO2T/DpvBq1Huw8gvle/ysqezew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzspeA2u; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzspeA2u"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-81c5aac8478so702911a34.0
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700595; x=1792305395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4J8rnXiyNcxfokn0csdzG80qUwxn8x6ELC14oqLC1E=;
        b=VzspeA2unTNlh6fOmnCpaBT9uMKSSvLOb5E1h7O+RQeBFVn9K1ewOAXFZsYH6ouaEY
         Qd4nNhFZzHnRRzlcC9goa+lqrUITgvMaDNo7xRL1SNfLNaE8HtpfcX6cDKF2uIzP2DXR
         DZ95Inmt8dTXVJxJkU/Mi3f+/LAaeC80Lq6Q6SbVIH7IZ6CAs0PH9KvyIwTxIQli+2Vn
         vqg5SPPYNTT4gmp7dZaOuk7B/qiDWiWGoJs1l4JpuZroXfkzJhmzM8q4S1LpvV5Sh0bY
         EhwtJd3Y0gjyPsztk5NtkpzheH2cE9Vd/fIKG16UOnRD7Dn2JMwYaY3UhzS5oqnvthE/
         dbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700595; x=1792305395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4J8rnXiyNcxfokn0csdzG80qUwxn8x6ELC14oqLC1E=;
        b=UtPaLReknak8lWIsUb6Jr5wqUlV0QgXaQKdd3UtVDxfH42ENfuNwqplMkSlCpLiJ3G
         ryoNjo7l8llef64k3rNlIFh8mY8oMF0ZHDA7ocj4HApA2QNYtRiOL+G/W1wVhsyTQG1D
         s19fpouua6W3At+f8F4uleAU37LTbwEekmolC0f4gRzIsTuj8iyPrmQoLTbXTlF6QDPR
         pzuSBKf2WvBXTtsw/5yRe0aOoooQDleTUGZuqdXohk5JYuydqDDHP7Xmslpy5Mc+aZKl
         AYt8r7/sM+C3uSJCTJ1FQwgz5ZdDyrF4ywSrVMSKVL+IVIrhsDWiQDwcD7ixggpTIxxN
         Yv4w==
X-Gm-Message-State: AFq9FYJvQQ5s6RxgyKLNIYp9HZg/OD1euxvfxm9XUAw6PiAUdo4MVinN
	qe8M/ed4BlCTpeGrElaHJbWx6G15oE3Gg1tYeFp+PekwVUmlVe9kZmtbopaHNBYQ
X-Gm-Gg: AYBFou2iRXbkBqroMZ2Tfdvb8N8hJd2DyIfJWepAqfSwSfbukC6jA7G1ZxOowVlC+o8
	5w2ifu9ewDTh8V0Y6IiR2m9BfzU+y8hCcm4Xdn777Cu/65Cx8JHW7qMdLUpPSzeaTji7MTWTm22
	WB9i62bYVwUp7wuEOMXH22GTwbBRmLhtWClpa2txR6SpiMBgJ5pDGTsBEjSB8H7hYpx3JRQsB7M
	Rcx97RnugHer7bKpAmphuqFEzGwhcfW2t5OgdNOEi0h1bmV8uTJ/242oquveKsfMs7zLhNJ6c3N
	XSlr55eTET2IeGDapZ7DsUGyNlr9r1dehsasvdCgu8LIe5WSfnkIsa5ec0gpFc7ZK9jAkVvi6Tl
	2zkiJ6QPb2MrT/6Q55CfF87yAY+WK6TpWIi28bu5C1HN8Bqz8F7INkdePb58Y6iNCDl+HoSv6Rp
	u9e3T4g08nHTRvWZEYPHmvSXJ9kGC5XtQ2t0O2PkVnB9vZayy1N34y1QVUWMHZO3Sc2fAlo8XJJ
	uQg/WirpKaliQvApFgaB9afQIM5I1T0UkuPeLaTRSVDfA/uhkACXGPbDBWIgB8QehRzyBZvMpsx
	G821aAAy6Xul3uUV8dDvUNMzip7TZDL4q5zOSw==
X-Received: by 2002:a05:6830:6a8e:b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-83097c63007mr5772120a34.25.1791700595335;
        Sat, 10 Oct 2026 23:36:35 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:35 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Li RongQing <lirongqing@baidu.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 08/12] ublk: refuse to go live after an io command was canceled
Date: Sun, 11 Oct 2026 01:35:51 -0500
Message-ID: <20261011063555.1142277-9-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
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
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
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
index a0b8b730e4f5..24a7f80e191c 100644
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
 
@@ -5243,6 +5262,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
 	int ublksrv_pid = (int)header->data[0];
+	bool canceled;
 	int ret = -EINVAL;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
@@ -5266,6 +5286,20 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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


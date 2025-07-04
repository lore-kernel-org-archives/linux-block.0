Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA63596B
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607679; cv=none; b=sB3Uavz2xu1fqD4Dw6ThHL0ewiRDLXXwjT0AtyGT/LPOu+1+R5+y4K9K6g3QkXU3wojWftrPyw6u2H0q4tlTpeB/0hhbABjaa1C9YEJe2vhcJWiZTGjg24RoxvsjjfzVc4p4A7JOpHak/5uGREMQGZRu84jBBdNHDcugHO751iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607679; c=relaxed/simple;
	bh=Fg51ED44Cb/JxeAVmuqNG45QRkyh40lG+n/GThA3vD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7tdhCyrAmrTLkn7+bvKpWFxv7erQRYp1BlLGC3sKhFzLdk0y+CL2ugIDl0M3vN1qwaB/FmlIq9rDjnke8xiyLrb0XYneRuNdpdljkgei6joZ1lVwfv+IsEkv5vek80EI1qnoihRSW0/7YCb7La2WrFuq1kKmuHB6BGoypO7dQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SPPFxq7J; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SPPFxq7J"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6119b103132so433876eaf.1
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751607675; x=1752212475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z165PrXv3BJ0BcHgHGYWGHF17lZMLHb3yK1ZvsXvaI=;
        b=SPPFxq7JzpGmiJx9+v5uRA5fum0WNUq6aVCTlv0HrJQuYgjxi3pVhwUlT+/53ETpG6
         6M0CYsw/nGtJWz8h34hZBaHtbj77eGS4mVHWr1/nHNclW0INAhNvr0vTbMQLRoxSugHe
         BGGdnEgy8tFa+uj8CgEyw84E5xmxHUXh93tw3CivjGK7yPW1+Ew8ml1R6VkpNomB1HSa
         Iw4LjsMoOEf3Q45xnvqsqDxEIaA3xBRZLBUKepihiFybUK2FHDULpAyYqDkjtgT4ndRV
         e+8JkKtJEj32tv5QWyxwBqwEmLpUDIvDw2xyFePzVFcPrkuy+REASGmaLdUAxFG0JcjJ
         bBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751607675; x=1752212475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z165PrXv3BJ0BcHgHGYWGHF17lZMLHb3yK1ZvsXvaI=;
        b=SQybu0znse/SGT5REdEZaKOY3rFdk/fYXk9UqYlp6zCAYLmqI0FsQ96Y1VCEx7mT6D
         B9ntxNfjYaTytVa02DtGbDWwUllvoMIMuE6KgrAEppt0EsfRb3eU2SIQUChCXrNmgijG
         4QPUk12/nen33nX+iqcxWvNc2gES+bsMgeEGIQ5AJRehM3ZJFOIrm7C9TdXd+otC1jpJ
         J+ChmWhzOkcrZlUDw62eKZypndsmJzd3CVz7dOktNt62AKuRTNgByz2e+yXWoSi+IRzO
         lZf+ZkSGSR28ZYL3O0ZyOp3bIwecUeG4utqwIqaShni8BAvHN8NpF2MucfeCF8DVeJ7F
         s6iw==
X-Gm-Message-State: AOJu0Yw7ki4lQ1qrRzndrmhJZoog0lkWgL7O34I0xNkbiYCwOD+vBIsP
	SgbgAP9nu7nC+BqDSEuL9h6z1WKDwZgyo1/c8dIJ+Y5yQHLZXpZiplGqsr077Tbt4obsN8B5nDE
	JYJ0cNXMYXzsgmP+/Akf80+ROt5QoyRdKTOawQrp6bZPXJ6fN0D7G
X-Gm-Gg: ASbGncvVgqMFNz9ddmcXglEwx4MyYaDGv+NSqOP8sPq0VRSfYy+oxVi82M0OgV9yZXg
	1pjmzVrBb1iX/i0iul3YcDKACzUzF5SuweDndHlaPhczOOUfkOUySoPvPHYm4Kvj9uh+38RF3Zy
	g8qK65G1JDLuNIqP0Xx9tKtxwafM7tEQj6owRcb5DMzfMWfhQDRwENNh+2psHt+66GCurtAaHcx
	s/0zCTHwjY3uIMDwy781TcPNv9F9mDnv8WhVlvrHrL3CJngNz1s39/ulZGY8kZgOch3Q7h23H2Z
	aJeFhA1UFnag1XH2i1kc2IdP2Wy+wP0VJnzCv72wTA==
X-Google-Smtp-Source: AGHT+IEHP7W8q9Ymv8RowzNqMGdGUIns5hNjdgM2O9rjomtNhtwApxc6Hp2rqupqJw6scpkC5pB9OXxSU3mV
X-Received: by 2002:a05:6820:1693:b0:611:5a9e:51c4 with SMTP id 006d021491bc7-6138ecb5b6cmr1330683eaf.4.1751607675201;
        Thu, 03 Jul 2025 22:41:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6138e568c85sm32309eaf.12.2025.07.03.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 22:41:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5F17340531;
	Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 851E1E4165D; Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 03 Jul 2025 23:41:08 -0600
Subject: [PATCH v2 2/2] ublk: introduce and use ublk_set_canceling helper
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-ublk_too_many_quiesce-v2-2-3527b5339eeb@purestorage.com>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

For performance reasons (minimizing the number of cache lines accessed
in the hot path), we store the "canceling" state redundantly - there is
one flag in the device, which can be considered the source of truth, and
per-queue copies of that flag. This redundancy can cause confusion, and
opens the door to bugs where the state is set inconsistently. Try to
guard against these bugs by introducing a ublk_set_canceling helper
which is the sole mutator of both the per-device and per-queue canceling
state. This helper always sets the state consistently. Use the helper in
all places where we need to modify the canceling state.

No functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 54 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 870d57a853a481c2443337717c50d39355804f66..a1a700c7e67a72597e740aaa60f5c3c73f0085e5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1563,6 +1563,27 @@ static void ublk_put_disk(struct gendisk *disk)
 		put_device(disk_to_dev(disk));
 }
 
+/*
+ * Use this function to ensure that ->canceling is consistently set for
+ * the device and all queues. Do not set these flags directly.
+ *
+ * Caller must ensure that:
+ * - cancel_mutex is held. This ensures that there is no concurrent
+ *   access to ub->canceling and no concurrent writes to ubq->canceling.
+ * - there are no concurrent reads of ubq->canceling from the queue_rq
+ *   path. This can be done by quiescing the queue, or through other
+ *   means.
+ */
+static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
+	__must_hold(&ub->cancel_mutex)
+{
+	int i;
+
+	ub->canceling = canceling;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_get_queue(ub, i)->canceling = canceling;
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
@@ -1591,13 +1612,11 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 * All requests may be inflight, so ->canceling may not be set, set
 	 * it now.
 	 */
-	ub->canceling = true;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = true;
-		ublk_abort_queue(ub, ubq);
-	}
+	mutex_lock(&ub->cancel_mutex);
+	ublk_set_canceling(ub, true);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_abort_queue(ub, ublk_get_queue(ub, i));
+	mutex_unlock(&ub->cancel_mutex);
 	blk_mq_kick_requeue_list(disk->queue);
 
 	/*
@@ -1723,7 +1742,6 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 static void ublk_start_cancel(struct ublk_device *ub)
 {
 	struct gendisk *disk = ublk_get_disk(ub);
-	int i;
 
 	/* Our disk has been dead */
 	if (!disk)
@@ -1740,9 +1758,7 @@ static void ublk_start_cancel(struct ublk_device *ub)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	ub->canceling = true;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
+	ublk_set_canceling(ub, true);
 	blk_mq_unquiesce_queue(disk->queue);
 out:
 	mutex_unlock(&ub->cancel_mutex);
@@ -1942,10 +1958,11 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 		for (j = 0; j < ubq->q_depth; j++)
 			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
 		spin_unlock(&ubq->cancel_lock);
-		ubq->canceling = false;
 		ubq->fail_io = false;
 	}
-	ub->canceling = false;
+	mutex_lock(&ub->cancel_mutex);
+	ublk_set_canceling(ub, false);
+	mutex_unlock(&ub->cancel_mutex);
 }
 
 /* device can only be started after all IOs are ready */
@@ -3417,7 +3434,7 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	/* zero means wait forever */
 	u64 timeout_ms = header->data[0];
 	struct gendisk *disk;
-	int i, ret = -ENODEV;
+	int ret = -ENODEV;
 
 	if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
 		return -EOPNOTSUPP;
@@ -3435,14 +3452,11 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 		goto put_disk;
 
 	/* Mark the device as canceling */
+	mutex_lock(&ub->cancel_mutex);
 	blk_mq_quiesce_queue(disk->queue);
-	ub->canceling = true;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = true;
-	}
+	ublk_set_canceling(ub, true);
 	blk_mq_unquiesce_queue(disk->queue);
+	mutex_unlock(&ub->cancel_mutex);
 
 	if (!timeout_ms)
 		timeout_ms = UINT_MAX;

-- 
2.34.1


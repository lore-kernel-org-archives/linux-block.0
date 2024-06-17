Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C38187567
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653501; cv=none; b=LLXIy1WvZJUWPLRMHhZRPDOLaOKxiHk7n3P6q72fTwtbMD1/ip692QD5MoWlyoPsFT/l+V4PaJ6bEePMxRoSWfCuzBp88dslwfH4TnA+SbShh0bkcLW6OUSkhisOQ41G8bHZPVbvAduEQwSVVJDc7Nv+WJ2ijuC50eZYO54dKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653501; c=relaxed/simple;
	bh=2+LwCHEVwTKte1Sqyy+VNnEqZA9WS1/s0+xVs/pbhiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rlb8CabSMLQLs6WJlr+ZSRXO3cha6sO5OXAOEjbsNga1uytz4mWrFvpzGaLe46wKxM6b0/rmBoQYALzLyWZ4uDOnHrbU0ICgVkASDDTAKjD1/5wsdBBs/DLeyDHZQ86Cw+NqepNxe62ewogK0hpRcbxtSunN/wMH6VowVLuC7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KkXohA/D; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KkXohA/D"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso6476756e87.1
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1718653497; x=1719258297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7qhPXyAkeQjB7Mf6zuo0q5cuZeT1DLbeNHHlB7kG+A=;
        b=KkXohA/DvPoMb6YvQTtdZUcDEjyQ/bLW8emVAFB5EmR/qK97Q1Wqjh4IYBdX/f0EaK
         1O8saF4my/Qefla+0WRhn3uE8N/1evQzOSgKtnuur8YvffnoptmHTVxsarbsnMs4PC++
         /wFZSU+DJPSDB1hoMxuutYvav7AmPb851LZkiCiMiRpadAJskeFIqKhk9vxSDOdlyK1i
         e33qkAgPtKRidPO/ltTm1hfOog0Fknk3pfFl0PHymN5WGOeiY/HDc/M+K1ZaisdPeIh/
         bGRu7rzhQgGrdminhAp4Bfxy0LdvQJ+JV/t4MkX3/55kI80v6bmZbsWnf4Z7DV5GUBlj
         zrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653497; x=1719258297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7qhPXyAkeQjB7Mf6zuo0q5cuZeT1DLbeNHHlB7kG+A=;
        b=q3TdlBw3Zeh8Clg/qZn0DK7oWysyhxhq7YGSXtCtuWoyhcD9ujTunUeGRLK83WweTt
         AJ3X4NozVv3iImZv5f2ry5UJvKnB4cef5NptFF0cgtiunoaqej1gdttRlQOTmzqCaSUH
         SDVi4Pi86fSkqIYnKtjHekd2R0zl7gTpdAtolPSZZtd4EbG54pQEVSFHCmttF9UVVnfz
         2wzHKBQFqCUZjvMCUYmzUA7/JPabkCgDl5xkFkTAQoOO6kT1bXQKWr01WZ/urWmGiNlp
         xeNO77p1AfgellBpcsFTr9xd+tFhMoipqBGwwMHiHnfMnUecLc1mOY4FOTXmnt98M7Qe
         Shvg==
X-Forwarded-Encrypted: i=1; AJvYcCUNeR9dZXLFScGtlRGK07GVnB2flPGABJE9XHs54AF+8qoByLmperhAfchjAOx35YX6dBqOFTdxg5FmMshWmA2gKQfKOOTjlGbWiUs=
X-Gm-Message-State: AOJu0YxphZt/ooRR4CHK5UEMMGeYtKEOPRVvY0HHmLywMj0EboNfNs1e
	WZpnSP2s1lZv2CSpLer5vUYgSGb1Pl85c0ga11jwwvXyELkp2X5kCoYsRP1BghvBW0DzhfPF7Ur
	Mh1xUtKr7ZKKvTFCxJrFfffXjAqQAZmKd4Suh6CdR6dipk4n9
X-Google-Smtp-Source: AGHT+IFXBpoa/4oXdqrSvu3k47reQw7dFd15KWYnB4XNzjtajTuXuVi4ykjkH4aNUjF/GA9PXItgVhwnnG75
X-Received: by 2002:a05:6512:3d10:b0:52c:8ed1:21fe with SMTP id 2adb3069b0e04-52ca6e924cbmr10582961e87.53.1718653497256;
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a6f56d8c61bsm12994066b.83.2024.06.17.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F07993407A1;
	Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EAE73E41412; Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] ublk: merge stop_work and quiesce_work
Date: Mon, 17 Jun 2024 13:44:50 -0600
Message-Id: <20240617194451.435445-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617194451.435445-1-ushankar@purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save some lines by merging stop_work and quiesce_work into nosrv_work,
which looks at the recovery flags and does the right thing when the "no
ublk server" condition is detected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 64 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e8cca58a71bc..0496fa372cc1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -182,8 +182,7 @@ struct ublk_device {
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
 
-	struct work_struct	quiesce_work;
-	struct work_struct	stop_work;
+	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -1229,10 +1228,7 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		struct ublk_device *ub = ubq->dev;
 
 		if (ublk_abort_requests(ub, ubq)) {
-			if (ublk_nosrv_should_stop_dev(ub))
-				schedule_work(&ub->stop_work);
-			else
-				schedule_work(&ub->quiesce_work);
+			schedule_work(&ub->nosrv_work);
 		}
 		return BLK_EH_DONE;
 	}
@@ -1482,10 +1478,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_nosrv_should_stop_dev(ub))
-			schedule_work(&ub->stop_work);
-		else
-			schedule_work(&ub->quiesce_work);
+		schedule_work(&ub->nosrv_work);
 	}
 }
 
@@ -1548,20 +1541,6 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 }
 
-static void ublk_quiesce_work_fn(struct work_struct *work)
-{
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, quiesce_work);
-
-	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-	__ublk_quiesce_dev(ub);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
-}
-
 static void ublk_unquiesce_dev(struct ublk_device *ub)
 {
 	int i;
@@ -1610,6 +1589,25 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ublk_cancel_dev(ub);
 }
 
+static void ublk_nosrv_work(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, nosrv_work);
+
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		ublk_stop_dev(ub);
+		return;
+	}
+
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+		goto unlock;
+	__ublk_quiesce_dev(ub);
+ unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_cancel_dev(ub);
+}
+
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
@@ -2124,14 +2122,6 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	return ret;
 }
 
-static void ublk_stop_work_fn(struct work_struct *work)
-{
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, stop_work);
-
-	ublk_stop_dev(ub);
-}
-
 /* align max io buffer size with PAGE_SIZE */
 static void ublk_align_max_io_size(struct ublk_device *ub)
 {
@@ -2156,8 +2146,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->stop_work);
-	cancel_work_sync(&ub->quiesce_work);
+	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2412,8 +2401,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
-	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
+	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2548,9 +2536,7 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->stop_work);
-	cancel_work_sync(&ub->quiesce_work);
-
+	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
-- 
2.34.1


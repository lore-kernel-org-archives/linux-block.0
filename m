Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B24C7C
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532536; cv=none; b=B6At0j4GQrM/pV8xQoVUMk1GU31AJlXEW/P4O34PUKisVeY9UI+5z4+gwcQNKkNub7FE+s4OMqTcgR1yboQ07EvHOmIcLoOxVcIouv/+LW1o3wQXRKGI9eqdF3pmsNGbLL0+s632qHOOM6CZUjsjEy7md0hIzRIoCG9SmNwiD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532536; c=relaxed/simple;
	bh=+PaiOJ2ZWWP0cyowrwmAS/YacNa41wjh6wut2sqDk8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jU2C0SWHdtognpYgEd5X6YbYvpMuW/OFc35d1/hqJ1e8F1E/P1XSxyhfwX0XlMAbw5PmcRqyGw0lRFPMzDkSfbwIkaDPrxLYRCtB1L29+XyF9s934ozk7Nagejq/YUZJF93YrAi3SnkPyMz6+wBm8fJexmExq+wrbfqzm9cxjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A94+vRA3; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A94+vRA3"
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso3330501276.1
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532534; x=1727137334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmkb4TQvPiWQD4+HIkIf+BpaSPlDYzwxRM06LpNqV00=;
        b=A94+vRA366kviVxZeNqeCLQsdCSe+DNeaLJOzjjhijvZjxiR5M7C15YSCprKwc/EVw
         OPwi5jBpfqnAFAzatL9eKCEa3jX7s5FQ4frhmOX1F5yaSU3+9TvE1pWGGfHDS/jNqWNa
         mHUDedMc6xXpdI4KacfMKgRPD6OsedQBHexzIcvdyt/1WEjaSQIOZBuzZPA7MIxH8Yo+
         /JnNCPMHZF0+pfHfcXml/qBUt+RUJlVl2poKYdjHLsb3omjKzzhTd42oWYkvE7IlZLzQ
         21mLIiWm/2bPbx/ue33ciQarHgXh3n56M5azyvRz/E/KrMDVupqgVhoqC9NNzXTajTYy
         pl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532534; x=1727137334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmkb4TQvPiWQD4+HIkIf+BpaSPlDYzwxRM06LpNqV00=;
        b=TejwysfKyjgAHUa3sMC637pK/dFGKBP+fz4RSuOAW3nsYSEG9vIMam3FGfVRTVIrKC
         CT5VAdrTCwhkCrU1ZtD79CF4Y7lZA7Jl4DdXbL4vjxbwtcmmADlHMzaWOOyA2epeJX7c
         RU76JnAr1ng+q5v/C7jwyHefiLlqcgKFIV+PUQM7+6eZvx7QFAZt8KceIFvTBB6kyav4
         pc8Dw69+PYfdqmmwle8bQk2donnhUmtbvyWeoM8dKnZYzaMF+b2Bgse0MMaYUsBnj8Cm
         1x7dhDGRXdA/wu5rrdNeIujewGOEOMW8hxJvR3Y70xGsvPZxnMbSUE8IWkkieLT05+a9
         OL/g==
X-Forwarded-Encrypted: i=1; AJvYcCVe13j63yb23yOqHgEfi3NcpU91ANHilFKvwkTDzZQmn6dLO7rS5DO3zSNnwaKY2EK3l919oaf0VpUl7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQ73kOguaW1HrpF4Bd3jzNnvtCHVzH47lYELn//nktwtYD0+l
	Yq8fREzNj1Nk66H9AKpKo5C1SlLIGX6zZtsoVdf5vF5wqZUGyb6d2a/+YXo3WP2riGSdZt8q7rU
	1iSWNywXRCv6ivFlZ8l9YyOeFWjKnayOUY5xjwN8YsVvPSk0t
X-Google-Smtp-Source: AGHT+IHb8ySTGmOlmQuqd84mgsM8TfFnqyG0L9ra5kd50Uj66OqTCohoSrkg8V34iu6lgEN6EKOCZIygRglx
X-Received: by 2002:a05:6902:268a:b0:e1d:436c:3b4f with SMTP id 3f1490d57ef6-e1db00ffb23mr8250377276.50.1726532533578;
        Mon, 16 Sep 2024 17:22:13 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e1dc1121f5dsm279444276.9.2024.09.16.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:22:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 719F9342243;
	Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6B17AE40F10; Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 3/4] ublk: merge stop_work and quiesce_work
Date: Mon, 16 Sep 2024 18:21:54 -0600
Message-Id: <20240917002155.2044225-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917002155.2044225-1-ushankar@purestorage.com>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 64 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b069f4d2b9d2..c7a0493b3545 100644
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
@@ -1262,10 +1261,7 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
@@ -1515,10 +1511,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_nosrv_should_stop_dev(ub))
-			schedule_work(&ub->stop_work);
-		else
-			schedule_work(&ub->quiesce_work);
+		schedule_work(&ub->nosrv_work);
 	}
 }
 
@@ -1581,20 +1574,6 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
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
@@ -1643,6 +1622,25 @@ static void ublk_stop_dev(struct ublk_device *ub)
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
@@ -2157,14 +2155,6 @@ static int ublk_add_chdev(struct ublk_device *ub)
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
@@ -2189,8 +2179,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->stop_work);
-	cancel_work_sync(&ub->quiesce_work);
+	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2450,8 +2439,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
-	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
+	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2586,9 +2574,7 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
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


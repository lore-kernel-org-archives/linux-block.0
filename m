Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848C198E7A
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906995; cv=none; b=FjYQdujYMBTJC0ZM2jENBoUVxFEefx+3ahnZPtcYV1585ABukw+O9laodr4pu5csg9LMUmCmDlskL6bNywKHuP4hUvyp0gs/tydgjl+YJPeps4tSSpasrElA0GToVwCmB/9fANwalHEyL4nRPte3CpwPTJgajhYRaLtsJkE3Spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906995; c=relaxed/simple;
	bh=w6LdgIOhjc250dIk7Rx+Ytl+Sk5e4esszP6YKCo9TGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfzNbbg2Da1d+AXC26ASB8sduf6eu7M3t1w5v3zC3Cfiq8u/SL9uLUdKLPMKPmLkgXROpAMhAHvEOtbDnDvO34o3hbn+AmPgSz3PiGmQVYPnpxvtq34eRWGWxwEWGG/2YFhy1FBNi9Fe3pIRt0xbRGJ4oIFNf7TqhxrI9Xlp8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KW4+umiQ; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KW4+umiQ"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so16383439f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727906993; x=1728511793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiJLzYaJNgoKuqGrz0VXF67d0Soid/dfAGjb8HjQkE0=;
        b=KW4+umiQq9uBdRCdBz2vDTZsq9R54lG/N4YsIdpcvjiUiroQhN6AEuW529dqpAPTh9
         YAbevZpr+G5UPUsLgUoCsbNPVFIR2LUBX4PyzIyYgWT/4+KZO8qCIkb5XKEEbx5BE4od
         wARaRSOLQmxqjVx7R7EH6foLzBBEVv3/16mvktE6Kgvk8VSC5Q7uQCJWHyNv5nNxViDS
         tANKVzthd8zUFn8hGNr3Xx2bmMzSHJfsr2OGVvOvferkPM8/fVrkVP1cAJD9SGsHVAWc
         ebAhIGCNruPuF3/XClpKjRox+kr/igfL7QAZ3oGR7EXfqjzRKxiV/KKULOA4jJyqdaJl
         HN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906993; x=1728511793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiJLzYaJNgoKuqGrz0VXF67d0Soid/dfAGjb8HjQkE0=;
        b=R9w9y55vnwPCo/Leq00d16sJAnCDwxX26kUrKXxD91Qtd+xXNUhs54XfWsADUZt1WX
         BJXT4EG2plWeRUrSFCy6wMKuC47mkDKR1iIuXPD8jpTodsQKBJJF7B99pxG/Ro1us+OB
         WW/pMxNsW69f51jqm/Fn0MjNPlTODzOJ++jpvq0+OkLnlehtHbMo5CyiGjU+P7ZO6zLB
         pH1HzM4Y1ESZT5Uu/zOzEJaOL8nZmZ1j448w1f91Xf2j69uUpCwC6zB590XVy9n/v0GH
         VDksSd5JObYYENGkHK92PLqvG+wMB14mgF7WZ/jSYKatlrY+hM7wHhpHK0jdcYKJkbum
         CVWA==
X-Forwarded-Encrypted: i=1; AJvYcCUNlZBFyDbR/gUnY9AY3n20zhD7CLGYXuYXqTv+az4FkoHOEzLJz3GbGR0KRZHXM/begUvbiQLbqm4oPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqxgIrWXjxe8hsh6AEqTbmb4FkIuvJtcScW5ZxDplO1WQfQh/
	n8GJOkB4q3cNUcmrfCrO4ZQ1I+zfKcmwQQ6IviYa5Spay8bBO6AkbWwEVXfPlRvJelkbar5xA6C
	dnhjGX/dPTTvIvjET1MKFoIR06W6hXU6J
X-Google-Smtp-Source: AGHT+IGDZBNcNqOi/fFQOZi/FHKO/gRftK9dCUgQlP8bLraKXhNfI2ylwnHKc9btpRHgn1fYn+hNaxL6WTnJ
X-Received: by 2002:a05:6602:148c:b0:82c:d67d:aa91 with SMTP id ca18e2360f4ac-834d83bd384mr608534539f.1.1727906993172;
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-834936df5d6sm22219839f.18.2024.10.02.15.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 67EDC3407A2;
	Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 64CC3E51EFD; Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 3/5] ublk: merge stop_work and quiesce_work
Date: Wed,  2 Oct 2024 16:09:47 -0600
Message-Id: <20241002220949.3087902-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002220949.3087902-1-ushankar@purestorage.com>
References: <20241002220949.3087902-1-ushankar@purestorage.com>
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
index a838ba809445..d5edef7bde43 100644
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
@@ -1261,10 +1260,7 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
@@ -1514,10 +1510,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_nosrv_should_stop_dev(ub))
-			schedule_work(&ub->stop_work);
-		else
-			schedule_work(&ub->quiesce_work);
+		schedule_work(&ub->nosrv_work);
 	}
 }
 
@@ -1580,20 +1573,6 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
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
@@ -1642,6 +1621,25 @@ static void ublk_stop_dev(struct ublk_device *ub)
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
@@ -2155,14 +2153,6 @@ static int ublk_add_chdev(struct ublk_device *ub)
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
@@ -2187,8 +2177,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->stop_work);
-	cancel_work_sync(&ub->quiesce_work);
+	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2448,8 +2437,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
-	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
+	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2584,9 +2572,7 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
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


Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002B22332E
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689498; cv=none; b=o0/p/ijaoXipeZAYvbLPCiNxAbp9xxNFAKJ/4L5Ske+FQVbycj8aOSY/+rF2Cb1T7jvGoGNUmP2C15eDJmdhHju7/2uXsyomZ1OLHQezUT/9XyGtxLX04fLG0nxC+2IAkmI8wfMP6abMg8Ry+WWDnYOyuYhPCNeIIQzhIQ9jRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689498; c=relaxed/simple;
	bh=Psiyix0cybmLPw2qvgnpcPuv24hLwDnQg8oW0/Ayuok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n9LLKxq7jp+eX/uzNTQ/AifEz2POW/0MzvjyU6SCNG6KQI82R1vnYJh0Df82oX0kpwN6vvgQEmLIPAdBJGHN+FcCoYL/tj1wlrSSshCym9mlpA0EXuGgo2pbjvi/nypPOOoQ4v60m5uL84i0qyou/q0tvYBmuCYocbIWAkex4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F4Xk9FmS; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F4Xk9FmS"
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e9033498768so2741768276.2
        for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754689495; x=1755294295; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6B6X3LEogA2yB8U1J4u8F6lwwIO7b99mUj1gg85SlI=;
        b=F4Xk9FmSEwx+yG3/DxlqYzrp+Pu1VRW6nBpAwv+eGu+sj8lHFp21Dr4jE2lPIVfhhG
         kA6FfoBc85TokJ3/M/T1YRrEnYBZFHkAQO7IBHJAdv2FRJnkuB1uizpA5cwqQ8zwVJbA
         wxK+z2+G6gbS9GAbQ8po6kdfKbpRNvyjLlJmjA+7HO8RYQtVpa/lrgDeIPtTq+4DOpFR
         MyRxsGAC1gP03bz6uqjmXfQHOr8FmtKetI5KxvLUwKQmhy+/2Gb6NweOCt/8xw8Imf+4
         h8ungFHo6Y+4wVdi7BPlGDhEryj8pXase1TTC3Pg0eIIyWHSL1qxZmV4SYEdWVRerXdO
         6mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689495; x=1755294295;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6B6X3LEogA2yB8U1J4u8F6lwwIO7b99mUj1gg85SlI=;
        b=bTHCXZM6u6bI8dPpfLqlu0h0X+ueS9AtV3+1rXYQiBVg/6jBl8l7xoys5uTvYMb+oh
         GYdc2BMgf2rOFuzEAxF0zNTP5PkeXpQ+4KsleourbK8htvvysLnmqyOzNSRxDEFgwZX1
         u+WBfmb0pYO503EWtZI4YGEEassZYLHdbgiKTLvwc9F+SOQyraA7VPdnkDh8Z3Uxn48m
         59ZEQXYyd9ufQqaSFrDgtIURZLxt8VO7nRGnxwzUaPEh4w0zWyojgMoz0r0euKGGfMxM
         KebiSNg1yyLzG9EZTlK6Gkhj+QmDHQBr4hl+OKbCePBkvwZGjRMvHG+R5w5Fxxm486Ys
         mjRw==
X-Gm-Message-State: AOJu0YxBukFAJwUpabzar8l16h4xaDCbn+J5kyXhLiuFnqIqEYgMunpM
	Llnf53CoGvGtWBTRzSKvOPS60boIVD3FXkw/odFh5Co24QU1uKlEDS4rJtqSo8cMScqeXef44GV
	YEwm8L/VboAMU/dIroZfY6HD+fUkusrVQIC5e
X-Gm-Gg: ASbGncve5soT5rGPZUUZBOaJZZTiSAcIrNAsWfdlvTqdbWKxP3wVxPnKd1a4pemb8az
	osVuWK9tuHUC+P0Kjn31KisXoImOtjfggqBegGOf+Lz3o6IHOJosfzjaiKJjczBhDOoEWgMuM0i
	thdzuz35E8xUuLcK9lV2LCILOaXGBUPSpBryeIKCOSpFidVlE1aDfS7kj85ReXoJTn/Eib+L20q
	yHQ2R/G+tNJNI3ceI7jYZm/V5W6lNyns/9GL2pTh5VhVTDdV900oiDdysgcW7JDwEoUCeeJBfYC
	0oKdLpBtcb1XZ+iYJSUZTvROWAnn8qxvVbzLXH1tyYFBPbg4eHIuG0WFiaDo9pv2z7cwjfXBLg=
	=
X-Google-Smtp-Source: AGHT+IEUsFB/3InQf9mBgnCvVVgl2Kn5BSU+C88gAveLZqjCjYTBqHfERzpLfFiBAunx9a7IefUfsmoHoLFB
X-Received: by 2002:a05:6902:6d15:b0:e8b:7bac:2254 with SMTP id 3f1490d57ef6-e904b5a0f0bmr5652333276.33.1754689494587;
        Fri, 08 Aug 2025 14:44:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e904d6efc19sm153888276.1.2025.08.08.14.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 14:44:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B5985340237;
	Fri,  8 Aug 2025 15:44:53 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 81FC1E53908; Fri,  8 Aug 2025 15:44:53 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 08 Aug 2025 15:44:43 -0600
Subject: [PATCH] ublk: don't quiesce in ublk_ch_release
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAMtvlmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3dKknOz4wlKgnuRUI92k5OTkFENDs8QUA1MloJ6CotS0zAqwedG
 xtbUA7+L4t18AAAA=
X-Change-ID: 20250808-ublk_quiesce2-bcccd116ad05
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

ublk_ch_release currently quiesces the device's request_queue while
setting force_abort/fail_io.  This avoids data races by preventing
concurrent reads from the I/O path, but is not strictly needed - at this
point, canceling is already set and guaranteed to be observed by any
concurrently executing I/Os, so they will be handled properly even if
the changes to force_abort/fail_io propagate to the I/O path later.
Remove the quiesce/unquiesce calls from ublk_ch_release. This makes the
writes to force_abort/fail_io concurrent with the reads in the I/O path,
so make the accesses atomic.

Before this change, the call to blk_mq_quiesce_queue was responsible for
most (90%) of the runtime of ublk_ch_release. With that call eliminated,
ublk_ch_release runs much faster. Here is a comparison of the total time
spent in calls to ublk_ch_release when a server handling 128 devices
exits, before and after this change:

before: 1.11s
after: 0.09s

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6561d2a561fa7ea570475494f0ed68d9ca85989a..6b95cf48ae77fff5661f9a7a2c7efdbcbcff7493 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1389,7 +1389,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 {
 	blk_status_t res;
 
-	if (unlikely(ubq->fail_io))
+	if (unlikely(READ_ONCE(ubq->fail_io)))
 		return BLK_STS_TARGET;
 
 	/* With recovery feature enabled, force_abort is set in
@@ -1401,7 +1401,8 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
+	if (ublk_nosrv_should_queue_io(ubq) &&
+	    unlikely(READ_ONCE(ubq->force_abort)))
 		return BLK_STS_IOERR;
 
 	if (check_cancel && unlikely(ubq->canceling))
@@ -1644,7 +1645,6 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 * Transition the device to the nosrv state. What exactly this
 	 * means depends on the recovery flags
 	 */
-	blk_mq_quiesce_queue(disk->queue);
 	if (ublk_nosrv_should_stop_dev(ub)) {
 		/*
 		 * Allow any pending/future I/O to pass through quickly
@@ -1652,8 +1652,7 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		 * waits for all pending I/O to complete
 		 */
 		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-			ublk_get_queue(ub, i)->force_abort = true;
-		blk_mq_unquiesce_queue(disk->queue);
+			WRITE_ONCE(ublk_get_queue(ub, i)->force_abort, true);
 
 		ublk_stop_dev_unlocked(ub);
 	} else {
@@ -1663,9 +1662,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-				ublk_get_queue(ub, i)->fail_io = true;
+				WRITE_ONCE(ublk_get_queue(ub, i)->fail_io, true);
 		}
-		blk_mq_unquiesce_queue(disk->queue);
 	}
 unlock:
 	mutex_unlock(&ub->mutex);

---
base-commit: 45fa9f97e65231a9fd4f9429489cb74c10ccd0fd
change-id: 20250808-ublk_quiesce2-bcccd116ad05

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


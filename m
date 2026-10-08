Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1144443C04
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459570; cv=none; b=qZO2NDdsKmCJ45zGDhCaDyamXRvE+9oRMKmWFcwgt+qEHekKV+OnHVO/drwr1ANFr89pAYGBynF05yKFWThXJ+EUPXrwI57/LBnZo5UYHc1eXWw4xzUN80FeSif/uhx+HNJmkVnjZUkjs80rtSW/x6IagH9HZ2I6fjTK+g67PME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459570; c=relaxed/simple;
	bh=UkWsVduEA2mJ11zFVAq+S6hGobEjcSbkdjpu2pRW8LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ1rW2EaAfB491WdjFEdqaB57fiP80opnXHr/moW8mJKa5ABeKqfNI6vxnQxqWsrCGNHEsYRUVUP6BH/GHpB1W68PDo8NrOW8J2r9Hp/LUi4AQBVIFllYaLsMuLiyeeD9vIVRXfSUtSdNe/FndCnJFacR7C+eVDxh9/8SxM/3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBu85GtU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBu85GtU"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7fccba9c675so603958a34.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459567; x=1792064367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8chXXo3mzv5Us8TfEJwfeycmi2DMMev2tWA5unBQek=;
        b=HBu85GtU/deSb/jt5/UG/YaEFB6bUzqahZ47rpix5K5unUW7RRfEhOQWNWqzThC9AH
         RbzJA+AGXSIAK44E8s5phVmgOPbcaGrzdoQARvFtE1gDpYCH2nXGq3TWLCJkdqxk9c9P
         SPyZuZkmpgD20oBFVeXykQKP3CVe95TnqHfVoZHISLxRNfLBrCZVOHQEtzC5687+9unG
         KNOSJRX+5XnmHIRnk/owWMdJtvcsft1rK2EoH5GFAk2ya12aGk8nr6XE2OF84Bb9gxQl
         tbezvUI2PnsYeu0vEUklkOS/ZoaKoIARmm70YV39A7uZUV5+jRY5OO49Ih3mWtdhprvn
         D9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459567; x=1792064367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8chXXo3mzv5Us8TfEJwfeycmi2DMMev2tWA5unBQek=;
        b=AtvyuibKf8ql4tvT7i1VEEFk4Zcr0z+KcOyW58Nn8at58fPukol/+ksEk/IcmFKYkl
         PhQYR96Lojy08J1T87snHUfbBNah5L8uSXAs7sPWGTCYntE2886Nq9WfVWv0PMDbR0BK
         0HF4lmaeKSJt9Xyyf3jJEn99T5kO0ymuJf/88clTzO8XTAu2Zsp1BJtgMeufi96RwtjP
         BJwaL4PJMPSlNIMmFF6oUaXBRT5xoQw6Wx/SSfH880+BrlNlkOZvlxO7IgL9EZgTIYeG
         nDZMmvyChLqKcMcDxHIfdx6l+LU35wzlvq20RvT2xUtbCsa7MiuClx3AMT9Lj/FSVCJ/
         t9FA==
X-Gm-Message-State: AFuF++lC9lbedZB8oMEVVZcPHujeiLoyCdJH+gmr7T+b8V9kbeBYV5Sg
	pTcnQCn6RC9Y3Ys8SwdmL3a++Igu0ZKEdNHMekWrXBFRG+XnUU2OXE0NHs4lsf1k
X-Gm-Gg: AYBFou0xAagNVCy0wNMQDIJVo1G5ynTrwidHx4Q2JQos0/c+rEqBzg5zHcUUImBjQjd
	mUKjBLtktQv5QFRssBtJy7tIKTqSrTHMz8xv0/+B56ZyV2g09YN/+e7I4HKDZXeMaWn7UHYVigF
	rSOXvMv6P4tEHhU7g8AGM2BxOY+MC2RO9pw5OYvEq1prZ2eSisL/iciHGzVPzhy3UykZhPdFQu4
	gCcMxJP2ruQ6wzlm8NqjMzHjkt26Hs4Oef+JSmcXNcDPFceK0+X0OnqIxitOPB1GqlfRAxgd38w
	z+oeEL4jtIW7BP3GibfdhoLANcbWKakEZNbCvgNZhcnmURl8bYQkijEf5JzgaclAbLnLrlf/MAr
	rFypbKIzwSH7flmbderduc5O66MQm4EziYM+Q26NvrjZtSSDCDadMVZ/16aCWE5zK2fJri2xpYj
	q+zikdXX6B1DpXiP7DbajmCBLTuzU9egFiP+DlqQy6mOK5MGISDUnca+cqTahzl97PtIY2nyFCN
	XHdbLNys67pc8HnnbFv9evyvMxxAjFqmrqt4IQi7Xrd/4Rzp+OS4waK0hr+/vtFeuQ2YIpzJPBZ
	thUB2ow9xi1+LLQ6kRu809nHuiY=
X-Received: by 2002:a05:6830:719c:b0:822:1216:d9e2 with SMTP id 46e09a7af769-82d59773e36mr1498090a34.14.1791459567583;
        Thu, 08 Oct 2026 04:39:27 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:27 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 05/11] ublk: reset the FETCH round under ub->mutex
Date: Thu,  8 Oct 2026 06:39:01 -0500
Message-ID: <20261008113907.4000838-6-tom.leiming@gmail.com>
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

The release work resets the FETCH round without ub->mutex, while
START_DEV checks it under ub->mutex:

  START_DEV (ub->mutex)               release work
  all queues ready? yes
  ublksrv_tgid matches? yes
                                      ublk_reset_ch_dev():
                                        io->cmd = NULL, nr_queue_ready = 0
  go live: a request then reaches ublk_queue_cmd() with a NULL io->cmd

Do the reset under ub->mutex. Then START_DEV sees the round either ready
or reset. The work already takes ub->mutex when there is a disk, after
it has aborted the requests; nothing holding ub->mutex waits for it.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8bf0739539c0..162a4d1a2e2a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2556,8 +2556,10 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	 * reset, so that a new server can fetch and start the device.
 	 */
 	disk = ublk_get_disk(ub);
-	if (!disk)
+	if (!disk) {
+		mutex_lock(&ub->mutex);
 		goto reset;
+	}
 
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
@@ -2589,7 +2591,7 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 
 	/* double check after grabbing lock */
 	if (!ub->ub_disk)
-		goto unlock;
+		goto reset;
 
 	/*
 	 * Transition the device to the nosrv state. What exactly this
@@ -2615,12 +2617,14 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 				WRITE_ONCE(ublk_get_queue(ub, i)->fail_io, true);
 		}
 	}
-unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_put_disk(disk);
 reset:
-	/* all uring_cmd has been done now, reset device & ubq */
+	/*
+	 * All uring_cmd has been done now, reset device & ubq. Under
+	 * ub->mutex, so START_DEV sees the round either ready or reset.
+	 */
 	ublk_reset_ch_dev(ub);
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
-- 
2.55.0


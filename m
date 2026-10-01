Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9D345EB8
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859289; cv=none; b=Vk2t066cXDLH1kAsRtElX2dCK8W+SoNXs0eljHl467yQSTZcVWxxWLTjxBT/YKE8RtZXQG4ztxv/bKwpKPHFAzZ7PumMFXa/VTDxiZg84d+Lt6r/bh0HjEx0gS/eNyWaGZISgqUHO58M3eeDlgy0yRx+RqEknngQ7O+8DSIIRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859289; c=relaxed/simple;
	bh=shIxhRKOWCImScQ+VvZmV5T7sNEBKoLv8RYq5Mu0P9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA5w4lRU5N2tVl26AiAygvuFHf+33kpzwuIzwmO2AOqes0T4B9Hatyir8SzncmnJC4E5kF76G1dbVqU7qUuF3+HFE3gOHpIm/qyWNbBqxLYW+1Sf7l3/CoyCsfaz7TJPgY/bYVajH9tsfGfbjV4FdWuTUTk5RoADH0S63FBCbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZxk/sjR; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZxk/sjR"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8167e0d1f90so4233057a34.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859287; x=1791464087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsrVgX/at9zdMnaMyWNp3hQXCBXx4PtpqKfQ2p0vjYE=;
        b=PZxk/sjRne9kBUYfMVWWXW8qN0EbHF+kWeXEfkO67W4J2HHo1kiGA5jd4i8TFfPccQ
         +MO9INv1kDWjHumnKmSVPNuj8KYEKRdZExROKVSC3F7A6ymrCzgFXzbQqY6/FMisdZV0
         KxHmcANCNqDca5AKr9VP4XGn5630aZ8CyUTfRnk+hcQyBOd0wt0ozo26sg65jpgTm7cC
         1cLxrOxZJ0Z9fVIeMww0mr1ELJVZD4ANFMHAVuoUAOctVtZk0F/ABeq+a2LLR33w18O4
         jpVqbWT1YJIZuoo+DJn2NpDAkwoeS2feDmt8ldmTuiaEm9L+3scFY/NfRZXqd9x2geQ0
         z04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859287; x=1791464087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsrVgX/at9zdMnaMyWNp3hQXCBXx4PtpqKfQ2p0vjYE=;
        b=OnJNrjqOTa5Nn65bfKe8jn2RAm8ptRDLCUl8g6qe2him21qu3Uq8HtKowkYJD9gJgd
         d2m7LG74GAAmcQ6X/f3T5iDuss3viz3iulr+BocVP96KTyTH91qHFFkMSkCgk1P2rJuO
         2ErNzzElvtjbSdBGk9I2QNaMElq8EDx5MdjV4SBotjAahVx7jt5JZOS3RLQWaDzIdG0s
         /+cU+YS07mgZFxjmnkSECI2wOmHnbOvUho4yFzZ7Iqf5UKgCqkG59P20dao5Lno2VlkQ
         c3BJkMcEZL+/KN6AEv1S01GSDxWv3PnvsLEzUy9b1T1iuLxCtyZL/udML/FxJrVkt7BK
         PBvw==
X-Gm-Message-State: AFuF++lV69Qwn91b88csOck1sHL07lygB3Qv4tGLfOo4TmBU2hyq18Si
	2ozsa9vRjNMR2fjrtUAbWTh+kwWqNDCnB44aqMzNI8Dv/9YOzYZYH0bJnatluA==
X-Gm-Gg: AYBFou2+ln+9tIssYVt7i7AfJqijwRll17PJ8UfGPoFs83eiEIrmwtkCnwr/yGz/mVA
	GoClSrWxowgzg5sGuj+VxjTqkuHZsYmb1A0d9TlevYfSrB2j5Dj0894Npg91gyHEYHmZYygJarO
	kO0WfEPKLTV2QA3d+CtBY/T871PVpXbxuL/e5XT+vcBI3HGb3WX+rI5WEu8vyUvqRHOUSw5l/+Z
	jogHcFPmVzP9mPxWXYxLMfIRBuU1MU+eJiOklAgZ3psSW9B7+uskGiYXWZiqSSV74Jl065r8c5/
	8vMob1Wi9eoKoVJtKUdfQOsodShhed/BmbUMTeIQNnMnZHigWLWGo84oTHsa52xeTCDmQuu9b68
	f3KNdWv66RWXbETnYO4SMynGaC/MIbnpFdMYFovClFQVQXJChchHtxXFSaJdliM5n3mqr8qQjGd
	958yKFIABFxqFHndXjiZB9gEH9PQ30w1znRhPR/XBbQfow+GvO/0H3lWW+IypCnY7a1hqQ6U1yY
	jrnq++3ag/347KpdpoyjtWQwOUkyrXMkR+H6RXN3kEkaDVarL6dmRjOyrAlbqpkrOOCg1uQ8ObY
	jKSc/RWZ9e5iyjSdfm4jXowvhFQ=
X-Received: by 2002:a05:6820:4b93:b0:6d9:5232:1779 with SMTP id 006d021491bc7-6dcf50532cemr4670295eaf.38.1790859286700;
        Thu, 01 Oct 2026 05:54:46 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:46 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5/8] ublk: reset the FETCH round under ub->mutex
Date: Thu,  1 Oct 2026 07:54:19 -0500
Message-ID: <20261001125422.1364260-6-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
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


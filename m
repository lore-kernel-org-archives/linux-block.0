Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32574397E96
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824253; cv=none; b=dpW6A8Ps4fhDjDfOKoiyJHyxNOTgCEvPXylEQ/ry6IZ7indWaO4JZI1ibRykzK3J9TzDtLimWWbkbMwnxHHmlAja08/Pbf+rAokiO+cEp8zs0f0RL7xMUBFUtK7k0PC2eyM5BHCbVMqvk9I4ZLJ9xmsrmYq9KpsVUOiMxw8JixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824253; c=relaxed/simple;
	bh=TAte18zOMn93bR8XRFFWxm1cVoOW/U+R0wMOuUoYc0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h6cSxSP+MpwVVUdEIELL7+dmRLCX4SuPo/vDwVPZKqN5LndjsASiteyx/qI8+dRyqA72gueKA9/RFFN0hABxBqK59s0a768n5kW5nSQsQuxJkQ1Sck9wawNdyc4OGJrONQnqgMTCbJLB4OAk5DXiGP7xh71/pwQ1GLI2Hk01i54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKor5eIm; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKor5eIm"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso9366439eec.1
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790824251; x=1791429051; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RjqjSmJYD2hGrFXmbh8r2sbLcORlAU84VyhXxxLNgFA=;
        b=JKor5eImY7XQFwLFOdnohyopCiYLhha+Bvf9eEBGFjf7jjTPMJNz47UNBn5263l8+L
         wXaCFrcSKR3QCS7ifhCkbMrUb1WoS1JfX2piO1YJTIUAPpI+sDZaqUHuJPFyVsK2Mv0V
         zgi0NBovSBjXJHtvuuFrwioyChb+xfvFG52eQ1zBooAj2zYNhN5bBpIaw9DdHxzmsPOg
         /cRJvkRcN1C32y1fpz7c/aJPACikJ9SWL5bQoy7WPnxbuSLNwghwVO9SThkOhPOk+6rb
         SJgDkybNV8cyUk8RUaqKIihYKLN/zOq9lHvYHHSgKBNUhQA5vnEFg8rpIVTm6sDgJMYn
         TP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824251; x=1791429051;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RjqjSmJYD2hGrFXmbh8r2sbLcORlAU84VyhXxxLNgFA=;
        b=yb7ArakL4S8bQdky0THRVoSiEUDf44EQM+TW8tjxVzZ620ehG5vaa9SRG6zUBLsdTa
         kRsyBGBLetyQDDWjAanOqT68hktRIkcnu5C4+agtZHO8yO8WWYHAp6e3joVngR59h0Eb
         Rp6b1F0Jer766WEb9j3ZsNX+tm6oWiqnygJaJMScC8g4zXcIymS4dJyDGLuhLpOOR602
         2jGa7kidkNC0vmgh41bA8RYyGJVZD3T6VCm+/djXiNas/A22mLAR6NGZ6iPzj/72I6QG
         xnOrpacLDiCMitajXmrn/pZhONNNoGYv7C0854oAqwxR4CCXnkIQaTbUcdCn6X3NXXpm
         6a3w==
X-Gm-Message-State: AFq9FYLb7rZP/qLvKKVfaZYwSUSVBvqr7zy/fjMc23PjYsX97sNBZYhP
	6fxE90MVTk2yeLz+Codj7J3czqzL60aAV+bph7YElP9dzUjoOP7CdKPc
X-Gm-Gg: AYBFou1izPvDtLuFKgTXPrIt9T+hDxZFd52vI6YcqE4sKKmjfXh1EVn2Tdzb694nXMR
	9YlIgmQqm3UacV7NqQdGQ1k3gHJsR7AQstQA5pdV8e2t7hnzHo+z2XHiAbDIi/kSdvGBaBFQNZ+
	7HQqckjgni68xkCssgJCmUtY63i8QXUMaxFCKY+6bawH5HvR21tleICPbQwFoAJfVoBnm8HGJ4y
	kQcNfHsdE3Jf+djBZSXxtGVA6g4qMJhe9srui7DH2XxfdM8VrEk6x6qd3LGlPKbFGKU6M1zZnQ4
	JL8LS1CiVf5fdYz/LNXANzoKIj6h49FABN1uuxIxSvSpNTa3y7eKaJH5UYNz6h7VBycJNXJ7bOW
	Ky+ZE7BZuurJ9GJXoGDToCnZNRs2nZvsqL5DhaZUHsoShyQGEuW302vR7Xn8lHwsYisRfx9BhnN
	+g+e+RIq1UQOLmSmC+hlkweSHRIolq9aZAWCUvJIxt3gwb05CA702QjYrhVoQd46i7hg==
X-Received: by 2002:a05:7301:2624:b0:34c:7d49:35cd with SMTP id 5a478bee46e88-34cdbbd5d9dmr3934437eec.11.1790824250861;
        Wed, 30 Sep 2026 20:10:50 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4c1ef93sm3249517eec.28.2026.09.30.20.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:10:50 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 11:10:47 +0800
Subject: [PATCH] ublk: drop the device reference outside ublk_ctl_mutex in
 DEL_DEV
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-ublk-del-dev-put-unlocked-v1-1-18e9bb9be727@gmail.com>
X-B4-Tracking: v=1; b=H4sIADbPvWoC/x3MMQqAMAxA0atIZgOpQ1GvIg61jRosVVorgnh3i
 8Mf3vIfSByFE/TVA5EvSbKHAlVXYFcTFkZxxdBQoxWRwikvmCe/oWNfuvDIJ+bgd7uxQ9NZq4g
 1mbaD8jgiz3L//2F83w9M2O9ybwAAAA==
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

ublk_ctrl_del_dev() drops its reference to the device while holding the
global ublk_ctl_mutex. When this is the last reference, ublk_cdev_rel()
frees the tag set, and blk_mq_free_tag_set() waits for the pending SRCU
callbacks of the tag set with srcu_barrier(). Every DEL_DEV thus waits
for an SRCU grace period with the mutex held, and deleting devices from
several threads serializes on it.

The release path doesn't need ublk_ctl_mutex. The device number is freed
under ublk_idr_lock, and the last reference is already dropped without
the mutex when the ublk server still has the char device open at
DEL_DEV time, from ublk_ch_release_work_fn().

Drop the reference after unlocking ublk_ctl_mutex.

ublk null target, 4000 single-queue devices, STOP_DEV + DEL_DEV issued
from N threads, 16 vCPU KVM guest:

  threads     before      after
        1     77.6 s     77.6 s
        4     20.1 s     19.4 s
        8     19.3 s      9.0 s
       16     19.2 s      4.1 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/block/ublk_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e5..5d237aae51b7b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4901,10 +4901,15 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
 		set_bit(UB_STATE_DELETED, &ub->state);
 	}
 
-	/* Mark the reference as consumed */
+	mutex_unlock(&ublk_ctl_mutex);
+
+	/*
+	 * Drop the reference outside ublk_ctl_mutex: if it is the last one,
+	 * the release frees the tag set, which waits for an SRCU grace period,
+	 * and holding the mutex would serialize concurrent deletions on it.
+	 */
 	*p_ub = NULL;
 	ublk_put_device(ub);
-	mutex_unlock(&ublk_ctl_mutex);
 
 	/*
 	 * Wait until the idr is removed, then it can be reused after

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20261001-bug-ublk-del-dev-put-unlocked-a9cc10e60a89

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


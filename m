Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC473ED137
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948961; cv=none; b=RPYKEDJP2viepc27gI36DPupG1tZmFDi/PUrQPhXedy+l+XL9naAge2b3jBIMoZXqiLR6ZRVN2UNT3Wq62WXD3IrOW9bAEecd/I2aSFesyfWbPUlBSTq1jYV1rQ7lh5sgVIHEmkQU/YgpmPuNdjamH3OFrQaqgFS5NWQrT8HyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948961; c=relaxed/simple;
	bh=gFRQZa+5+6T/UvUfG+iSQp84/qWQUKfeR2MbrBywW4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATGS3R3SMoWSVk3nowS6XgtHQoJV/p+8+PBidLz9BBdqrOK9SbubIoMgdFlEU08ssmCQppb58Jg6N6sxQ0atzRrvO90LXt/PGPedQHTIQFZLrdh7OWveozR9iD73QdqvkwXkK+/65V7orpXuixLBhTTHB205svP4o7en/cwghCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av/y1B1l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av/y1B1l"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so30518615e9.0
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776948957; x=1777553757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnRdDLrWpQ9VAViP+Lb+FjcuP4xTGaJIWlgeZ0peEtU=;
        b=av/y1B1lrej3T/vobG74hzQ2dW8Ku/bUTC+WW23Qt3Kdh4tQyxZq7TzurPLzove91s
         RFm0iT9EY23YPcvdX6PpE0GG1nPtv3V7HyRHp/FYAQ+tpjX3jZ3XxAPIyulCcTrojWtL
         VKWqF3uIQrDphJ0cw1zlBXFh2wpSO4b4OgQXsEBqX4JyI3hIdiAS0R5YwbhmLkPev3gl
         XrdQTsEBmaUQmbaJ2Il9OCwsSP38sADmAvZo7IWrIl17tFvFvpD23Rrxc9pjnk5szZrk
         p/f6iFHgsFfqQoyvlRBmwnNz1ep/kiDP8sCJFN4mOVW+I+XY28xLabjdUehad5W7j2r1
         EKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776948957; x=1777553757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnRdDLrWpQ9VAViP+Lb+FjcuP4xTGaJIWlgeZ0peEtU=;
        b=MUm93iLJBDMTTOGIK2rQdnw4P66StL2WmX84336/11JZIq1Xt+gD682iskcljeaFHx
         0/WKcAZ2+wNUMxCFmb9XC0Ni+JogZNlFV23TfcG6VE7tkCNeO6lvaB3Px/B3VSnmMurg
         hITrVfJpY203kCe5WQ754zx6KPsA2tud7dxsr0MnY6ujwI2fCmP7KWt0fReUOrDapHB8
         oMSH/q5EV/Utatn24rf6PmP2R0KNYyoaAWWavQs2dmryw9L6NQUcf/0ZBn7PRbYQwysH
         qeMDtfOyZe/Zqr2VPnyR8WiNmhDBYDRP/nsav5y0sUegROEOQvXPv2NdtSxsSjqEZaA/
         AMuA==
X-Forwarded-Encrypted: i=1; AFNElJ+q0/PsQIDSJkMcjD3y0+qS4FkPJmxalkCIjuIM+sBKFFmPIaDQnrlV9VUNB5BAI1sqgrcHPXL1ETaoOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqF5CDynn5CFaHNfIng0Eow4o+EB34hvAFzG/ScX2E2PLHknx
	P0tSY1sH6t3y3+LyM+9Bb2hDg3x+LOJp+xzRR5+FKx9+6x1n8jalOVHpX7VCimWa7JY=
X-Gm-Gg: AeBDiet7d02KG8Q2YKdHq53+EVjSTiHYDL6Y6El4yO+QtOf0n+/SCkYG7yLtVUQeXUD
	ET9diNzU82HAgtG0MVI0A8H30BqjNTqFzHiIkTwdtVQ6XZfZwoT01RQwWAnOmEWxe+9JwdHAOHY
	AVlz5ahi9Iy0MHs3lEcLl0IfzmEm7wnu44eAjXMW7R9mD8YFLax6ATuGJVZTp5hpI5QPQCRZTY8
	4xmWXJeMwTQcizujXxvemRXrL9p8+fMiQ5/VQGqZKSAeIdogOGSWJJVwqcFIC/lN3Qxme2AR5XE
	j1vqZ79hnEqRc60fIS5Ed/Dy6zvrh8rmxDkmWCxPhN1h78J+eMNehsE+kczOFIwVXH+4uSmxD6X
	MjqAsBz4Lyuh3jNf4spzAXA6Fx6UH7LAQnzZGQOzCgO+qY+wV2zkrcrDv2eFPZZoah6UWnTjKXn
	prI6UpG913spBfpSUES4ry0wKPAnMjtSC4z61i8rnVDeZMxkjn5fmXN+v9uzHqNL2IkBtlxXdem
	9pOrn+R07aWLXMwaZs=
X-Received: by 2002:a05:600c:570f:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-488fb882f13mr284091745e9.4.1776948956507;
        Thu, 23 Apr 2026 05:55:56 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm54409368f8f.3.2026.04.23.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:55:55 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>,
	Michael Wu <michael@allwinnertech.com>
Subject: [PATCH] sched: disable preemption around blk_flush_plug in sched_submit_work
Date: Thu, 23 Apr 2026 20:55:28 +0800
Message-ID: <20260423125528.2917171-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On preemptible kernels, a three-way deadlock can occur involving
blk_mq_freeze_queue and blk_mq_dispatch_list:

- Task A holds a filesystem lock (e.g., f2fs io_rwsem) and enters
  __bio_queue_enter(), waiting for mq_freeze_depth == 0
- Task B holds mq_freeze_depth=1 (elevator_change) and waits for
  q_usage_counter to reach zero in blk_mq_freeze_queue_wait()
- Task C is going to sleep waiting for the filesystem lock. Before
  sleeping, schedule() calls sched_submit_work() -> blk_flush_plug()
  -> blk_mq_dispatch_list(), which acquires q_usage_counter via
  percpu_ref_get(). If Task C gets preempted before percpu_ref_put(),
  it will not be scheduled back because the task is already in
  uninterruptible sleep state (TASK_UNINTERRUPTIBLE). This means it
  holds the percpu_ref indefinitely, preventing freeze from completing.

This is fundamentally an ABBA deadlock between queue freeze and the
filesystem lock, exposed by preemption creating an artificial hold
on q_usage_counter during the plug flush.

Fix by disabling preemption around blk_flush_plug() in
sched_submit_work(). The _notrace variants are used since this runs
in scheduler context. preempt_enable_no_resched_notrace() is correct
because we are already inside __schedule() and about to pick the next
task.

Fixes: 73c101011926 ("block: initial patch for on-stack per-task plugging")
Reported-by: Michael Wu <michael@allwinnertech.com>
Tested-by: Michael Wu <michael@allwinnertech.com>
Link: https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e..4217aaaa8e47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6966,7 +6966,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
 	 */
+	preempt_disable_notrace();
 	blk_flush_plug(tsk->plug, true);
+	preempt_enable_no_resched_notrace();

 	lock_map_release(&sched_map);
 }
--
2.53.0


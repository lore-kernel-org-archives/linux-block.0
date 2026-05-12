Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308483A6EF6
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576404; cv=none; b=gHeurFLnGLlcGf/MLGX3c28HA6uH8dBCmD7R/P5hxQf8b0fzqrXPAJfHYR2TpQZoP78XmeK9DRnoGg9/Dn++Wj/OFkkW19bxlBkDyik3Wxr+PdQOan4k4yR7kQ/1w3agFzFwyu7MBf+C4ca14dDiW2TmlF8l7yB5/k+lH9nBh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576404; c=relaxed/simple;
	bh=Q+QHwwgYYTgOE6IMG48xeqIiYes94pcMNAmk+a/eooo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwb9WMHTNQfJuAQqWl0FI92k5oh2pmeU9NljjbpiC32zxNthsHavLtj5hddLzWQLExVYYCS926ZngWnXslKA4TSEAmeprWxEP/LHG2qS+16vtyhvPhmuPydbNfnX3iS91yW8sgahb3u4dUxlLZwkLAaoi+gT0sDo9jPIp4AdBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+sSIOxM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+sSIOxM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dca5f64e86so4175536a34.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778576398; x=1779181198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaFtxWK89jaAnT34s5zWN9wQ86Ea5BISvP/eISI2Ato=;
        b=o+sSIOxMBtyaJeITe/y+yPPPDCyMZfU3JnJybzyvFrKUYzrw5sbLthrLB6+qh2ZYwO
         GoTV0ynmEtldvXtCVAWSOw5YJTfWWyeVzwRgNEyO3vQCoZXpc/CBHWCZ5ePBQeqO1NhK
         lPYdIzBUSgTrlvLO7Bu6oCJ5136TULUPuGy40Plf+zTwINaRoZlA8SKVVWtDIJwcKgi3
         eSlPOECofDLCBvgVlk42G80PR6X0oNQszMAAkjZqm8fa0SiHASdRRrjH3x4g7feyYjXT
         +owYL5iw6YKnQY0pdkBJMW70cTs1Rma99gWHPrF5HdbL6w47HlN77ha4MaakKEm5lXNv
         AZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576398; x=1779181198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaFtxWK89jaAnT34s5zWN9wQ86Ea5BISvP/eISI2Ato=;
        b=bV1mQtj0n7PrQlg66xV5j8uPt8RUcu2/ue7mHgPu6heKvbg1t134tl7LxALDwlUmo2
         PRbprto5HrY0vYPOI3EvUsffWIvlOVuMvkGADKxSwd/hBBoSWvxzgEZ1Nd0Tw5BtYGv5
         jQxe39BwTp5xvtF1eHGeNPzjI99tQOoiiJlDHY9C+HS1HNtItO8PrkGpAkX1YCwAiWEG
         +AsvTrf4+oa/oD6av0VqGNi3lsplg5eKznplUeCSO2bumZFaW/93c6cOZREB68/ZIlM9
         /5MBiGunL81K5wWbw9zg5QomhwraFK4A6yOe8hlmNV4Mdou3G9UQXgmgBKmsbWjvUVyc
         HZPA==
X-Forwarded-Encrypted: i=1; AFNElJ/0YzQPoHgJWvj3J7bnypdNgABU27IupCW4ii9GNNN471+VYugEqhMURe7gDhL+NgzUa6upujBVm6SX2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NQuld1RsNtprEX4gfKC0DLKVoGBgmJVb/DnHYXk1HTahb/61
	xxwf4M1HaLVvfSEzD9UP42+x9y2o9+3/1nlYxIirmZgg58wk6inJwOZB
X-Gm-Gg: Acq92OGcUpubJO915mqT87Mi+hC12yF2UPdNaiZBi3kMF/zsNMrHH3OVK6/4nE8hzrh
	N5LE6ZKXHGUWZEBh6kgbfQWBUsaT6LWCl75jH4uJxLj+cUsNsS2Hy9TXcDWI79rEnhPjfYWmEtt
	FDkBm7U84Sp7AP0o+mEoruNIVeoEfLED8rqPUvmWAoCPHqCGhuO9kzIyx5/0SUerhk0FMJbQN00
	VMLQYyhrPFs9KMgEx+1QkrznPK/q6hBc8kEQQvTTveFrKaDuhlcn6HYkgdqOt1+UtQ2gk/4dUVN
	WUL+3q+puKKAqbWsIhAvMK6VyczqM+Hf/im+PP3yThGxfCoVZsCBaW1SYQ7ccTrXfo/Kh7i0+m0
	V/sdqXNyWLdE1KkRHlnkI5l8ZPK3VGOSJ6dEmYsqowde05mDCFAsMZAnmlVoblPh5t51/s9HtuW
	TlhzVQS7z6BUAJlWf5lNB6GhdPchu+dRVKJvLZU2eXXzQad+KOo+yzzdu6BGZDWH8/6hvQgkh0s
	EAcv57wUJfrB/tWUt6d
X-Received: by 2002:a05:6830:44aa:b0:7db:a184:2b35 with SMTP id 46e09a7af769-7e1def0c8f1mr16773819a34.8.1778576397965;
        Tue, 12 May 2026 01:59:57 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367df7a26sm8501737a34.26.2026.05.12.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:59:57 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>
Subject: [PATCH] sched: flush plug in schedule_preempt_disabled() to prevent deadlock
Date: Tue, 12 May 2026 16:59:39 +0800
Message-ID: <20260512085939.1107372-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On preemptible kernels, a deadlock can occur when a task with plugged IO
calls schedule_preempt_disabled():

  schedule_preempt_disabled()
    sched_preempt_enable_no_resched()  // preemption now enabled
    schedule()                         // <-- preemption can happen here
      sched_submit_work()
        blk_flush_plug()

After sched_preempt_enable_no_resched() re-enables preemption, the task
can be preempted (e.g., by a higher-priority RT task) before reaching
blk_flush_plug() in sched_submit_work(). Since the task's state is
already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
requests in current->plug remain unflushed for an unbounded time.

If another task depends on those plugged requests to make progress (e.g.,
to release a lock the sleeping task needs), a deadlock results:

  - Task A (writeback worker): holds plugged IO, preempted before
    flushing, stuck on run queue behind higher-priority work
  - Task B: waiting for IO completion from Task A's plug, holds a lock
    that Task A needs to be woken up

Both reported deadlocks involve mutex/rwsem slowpaths, which are the
primary callers of schedule_preempt_disabled() with non-running task
state.

Fix by flushing the plug in schedule_preempt_disabled() while
preemption is still disabled. This ensures the plug is empty before the
preemption window opens.

Fixes: 73c101011926 ("block: initial patch for on-stack per-task plugging")
Reported-by: Michael Wu <michael@allwinnertech.com>
Tested-by: Michael Wu <michael@allwinnertech.com>
Reported-by: Xiaosen He <xiaosen.he@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..c1efe110c54d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7336,6 +7336,8 @@ asmlinkage __visible void __sched schedule_user(void)
  */
 void __sched schedule_preempt_disabled(void)
 {
+	if (!task_is_running(current))
+		blk_flush_plug(current->plug, true);
 	sched_preempt_enable_no_resched();
 	schedule();
 	preempt_disable();
-- 
2.53.0


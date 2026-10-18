Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A63B9D9F
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792307803; cv=none; b=M+eRRbfUHYeS2uvZslXbePtDOndYfk4dQ0p11EOWLn5TS8GPU29voH/vtDeq6zeO/q0shVG4CoKOS7w0U1MUOWv/gVhVgLOEsCweM16fZbmhugecfK1RoJu8WtIviYzcoOLl8vv5Lq+IcDkiAp0OQ9ewHZXgtzOuriI+9tO9Pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792307803; c=relaxed/simple;
	bh=nvVFUq/61qzab7zOKRtEl9kkbUwupZvr5gTkYS91nQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ7EReND4aqiFHSrasBRD4mUPhKyIX/R5VcpRztQPu3poE/XIqPJJP9eSkg+ph4Ti56Bn2ERBlybjo59rqtsq+It4WGvF7Tgf+5hjVzLl4lye2jbnXDcaTNdhVWB72sS4SmTj7ZJB5y28ikSWFfIij3JM0X/nofOua2784BA43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj1iBFTd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj1iBFTd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8fe8e343fso4752905ad.2
        for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792307801; x=1792912601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fm+8hE4os7LvlJdHIvQMczxhBtCibQ83SWWXxfbxmcs=;
        b=aj1iBFTdSwsKANMPlPG0PyzmeE6Ym+3QmMHp6nleL2ctUTQRbK74jj5m10EtAbJ+zq
         eoSnHTpaN6nVF/4VnLnAXBZGyZXA8pioglIEAf9F8oTJ1u1okkUlrQIFSMuchJVfZpRt
         ifew6+ncepgYjCwaUwxh5n3EPpFr7KfC3LJn5APhmwoSBmkUQs3QtINEtpa4KsLp7Ph+
         19mG1q22g4biYJliI1Hx3A76MVUB+UAJEyiajSHp8qWrDSDf9bDAIYMyPLZxib90sRKz
         oQbszV5t/ydq43kYtJErGC8+RKUkDYmtDmLx+VuQ4mKnIHsWS/il/50mB90fsN0zoVjQ
         817w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792307801; x=1792912601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fm+8hE4os7LvlJdHIvQMczxhBtCibQ83SWWXxfbxmcs=;
        b=waVOMPPKsiEtn3wkaDNrcnpsxZDR3kPvt/Ds1dC63Bn+oqS0g0k5zdQeU/Ys6njByl
         rv+hFj6WakC3OrqsCRv9WkPCrWAtZHr2HXfjSrksZ5aD4/yF6DjPJHY2Tl+wPKu+XNtg
         W6POnzOwSaN8+1bfN8UI4qrHJOhAHPJa9SXdIVH+2DlPra07LNfJSrWDTZoYEf3vmWP1
         pto0HmOBflU/VSUOjhaInOZUUZ/l+MzHwodZ0h5wPEypAS2ax2Z5UUHpkPhKx8mUxwPq
         kU1ATeYl4PTK6kiBNnLBkqmLjR7XDGGfwyLmxJqyHs+LO8fxTq2oZ/Rx/MTepj4/Vrvx
         QYoA==
X-Gm-Message-State: AFq9FYJv+zBp6XpZze2sDYKHCs2rf3yDDGlpbT5c5FF5KgzBKqXAG+qt
	i44ZQfjJN7aNxYn81Wk+OlfNrUs5EDlg7xHqlPQoICPkEPY18JIvUGse
X-Gm-Gg: AYBFou3UgKrfrrfgXBlaIumC8hUug9Zif1CKSNrCfHxNt7D4vaDSr8isM4a8zb5o7mf
	DcgxhNHykaeWBDtFmwc34XNwz3yU5w1QagW4e4bz5fnSfWcAzVQ/xIMPE5c9Y0f6tM4YCxaGv3e
	k4O+x0To5lcwPpXr1c7Do970yC3xpI9A5/L0GZNK3nsdk/XH63Eplx6xSTzXSlVnZKy832vd7JF
	B6N0x5mNLGW+nFWXRs2RuS+1DiUuULsGaLuoYMkgMHK/KV99IwsmkYgQlZ/MNG5eJUkTeUH6GXx
	qzrNrKqDxFwSqIiL2RK5YE7oziUUMjZQ1N4qhHg9stjl/LvipKQA/URkczdN1eLQ9/CYVZS8upg
	sGu5c68nqUhD70iQjJy6ZNurhmxg7k8XyPHkR6pE7BAHIsVr1aZVXxinIQsGn8CKQ8PvUgdijR8
	hUeYf+IW3BNR6Ru91RHDqCj8qLeGbj2d37Z7AgTcl0GyViXt0v0YIYoGc56Rzk8eTRXIGA0g==
X-Received: by 2002:a17:902:ce11:b0:2e2:e24e:a88a with SMTP id d9443c01a7336-2e9a68d91bfmr36318835ad.22.1792307801324;
        Sun, 18 Oct 2026 00:16:41 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ac0:50::3d0:3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e835063sm26509325ad.33.2026.10.18.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 00:16:40 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Subject: [PATCH] block: annotate lockless task ioprio accesses
Date: Sun, 18 Oct 2026 14:16:36 +0700
Message-ID: <20261018071636.79198-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__get_task_ioprio() reads task->io_context and ioc->ioprio without
task_lock() when called on current, e.g. from init_sync_kiocb() on every
write.  set_task_ioprio() can update both for another task at any time,
including the first publication of a new io_context.  KCSAN reports it:

  BUG: KCSAN: data-race in __kernel_write_iter / set_task_ioprio
  value changed: 0x0000000000000000 -> 0xffff888109813730

A stale or torn value is harmless, a task simply gets the old or new
priority, but the compiler may tear or refetch the accesses and the
io_context fields must be visible before the pointer is.

Publish the pointer with smp_store_release(), read it with READ_ONCE()
(address dependency orders the ioprio load), and mark the ioprio
accesses.

Reported-by: syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=feeb9b5352b9ff89618a
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested with a KCSAN kernel in QEMU. syzbot's coredump repro is too slow to hit
the window, so a thread loops pwrite() on a tmpfs file while the main thread
does the first ioprio_set() on its tid (~35k iterations per run). Same pair,
same "0 -> pointer" value change: 26 reports per run before, 0 in two runs
after. No Fixes: tag, the history I have is grafted.
 block/blk-ioc.c        | 5 +++--
 include/linux/ioprio.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..12ddc672f41d 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -277,9 +277,10 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 		if (task->io_context)
 			kmem_cache_free(iocontext_cachep, ioc);
 		else
-			task->io_context = ioc;
+			/* Pairs with READ_ONCE() in __get_task_ioprio() */
+			smp_store_release(&task->io_context, ioc);
 	}
-	task->io_context->ioprio = ioprio;
+	WRITE_ONCE(task->io_context->ioprio, ioprio);
 out:
 	task_unlock(task);
 	return 0;
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 5210e8371238..56371e9ea306 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -56,7 +56,8 @@ static inline int task_nice_ioclass(struct task_struct *task)
  */
 static inline int __get_task_ioprio(struct task_struct *p)
 {
-	struct io_context *ioc = p->io_context;
+	/* Paired with smp_store_release() in set_task_ioprio() */
+	struct io_context *ioc = READ_ONCE(p->io_context);
 	int prio;
 
 	if (!ioc)
@@ -66,7 +67,7 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
 
-	prio = ioc->ioprio;
+	prio = READ_ONCE(ioc->ioprio);
 	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
 		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
-- 
2.43.0


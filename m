Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500758;
	b=w5/l08IjGU5ivrB1fvRVr1RB935Af840fxb+Y6+PyaSS1xYePUYzU32H5q1MsyjFv5jD
	 yJEoL6+8c40LQjCOvLLmLZ5rIgfEZDLEl3oOUOlPrN2316QTQdW+nQ3FwFhdT2NJ78FFT
	 t8Q8FLoqogqfegDWbCl4LonLOVFLJqK7PIjsmcbApsfiohYRbf8dYS7TaCA03M+jTZa3I
	 rIaNiowaPvErYh8tO59z43CFY8WU6pQt0/V1jjGSMPC9fvd3c2mEqpCa6Vz/vQqZ/tr+a
	 Sf+A1cvkY351mbLNIU4aajpOOIilYQyay59fUGcA8EaNN/H9VLzhBA7hDhxeA1Wo+Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K5OlwiJN896d/1knLEJqlVUMXIymRAuCbtD548JnU1U=;
	b=kj4o1mOYAAS+SY4xNTcobJ1QvRZa5k72uFQxsX2vacvXsYso91m0v3powHJK96eO5iVR
	 JWDngOY/jagbl+BEii9vbcKvkyurHQx0yoH/fd+BtlwfNIfG9qVo7elzW/irH14h4c1K/
	 vIt4jqzYi0lZUqDm5ZUDZNyczCaLkIQ/2v01VyIbU0YysdykkR3B3uAf7vIDiLbl9E3YF
	 upUImW0AogbmYjK3kPcffdy8UiRzfVUJgVvBGutJR4ZLls7gLGom6BnvG8EtD62AGvGDg
	 nUaNH6+F1+P6wCp4y7/LIpEXkBGyX0HQ2RBONRcsYXFBN+yWozUjraEeL98NYkl9F2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbB64Y7e;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB1606A325
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 12:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EB1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbB64Y7e
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e98798cbddso12257515ad.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500758; x=1793105558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5OlwiJN896d/1knLEJqlVUMXIymRAuCbtD548JnU1U=;
        b=SbB64Y7eN2RD+RzP36Nk12lzyoC78uMs/jtg3ulnjCE+SZgFf742palyn6vO+gzoJy
         BNF3IKahm4H7eNwKLRDi3gWuKHgXe8boMG9TUVO9LWn+IF8LMgM7DLOvyk8NegBUXK9C
         kTcGmPje1wvvuWR1tD6uoU3/cabpn1cn/Ufe+kP5+QjFvC8VSJGC0aLpjKwLeNzxJGas
         iDgSkMEjzvy9ryjY89LndWNLMkcb5js9lcYU1D6rxGRn9WHHwL85tiryvbvoCrNQkOCD
         hr81ZmSDV0zJm9zEbAuZjkK+KS6Byv8BfxtVJavhY/Nd8WSoyWrguL8GDIbugKR1jVCn
         vVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500758; x=1793105558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5OlwiJN896d/1knLEJqlVUMXIymRAuCbtD548JnU1U=;
        b=FdSaBg7Roi8K0J0x1Xrq7wI8d08rAJrMeqGByD4NB9sJtZTlAAnvLMwxMoZZ3v1S6g
         RVHPuSeu6lUPs2RgSe9PPNhzgLWhi3T0NMudqzRre039PPg88k1G+aoKBK6YVCkB/zBe
         BmyRrPObPo9rZ/x3Ajx25bdlC5oP4YOutNBOuTliUOQ2r81bDbXfOIRu+6QpXUlwO1HE
         1SjVLsG6ILRDollcxqTDN1gf9ADAN6GRcyrGu2MHPLfe2P7b0H1GtOg2ejzOIGdbz5gi
         noligOXT6oyvUiZKEGjOBFHbaI1QRYyol0jb+gK7c2DNDdT4gNYehcseBXjaAxiiLc10
         VBpg==
X-Forwarded-Encrypted: i=1; AKwUvByWsfzeQflT4Re7qwNwVaMvS9c6b34s8E6hErPkVOQeZWGBlWMhuCFlVv0doITFHHXjK8iynn3Lp/rHqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIslUw+wA/AYcbUMk6H5tgGi99jP/9qjda7Xo1sCZkukRPPmGeK
	WYQelqt7CuVUWmLHZ0mpPYivagMXOlkLH7L+9JfJ2pahUCPWm5TDfol4G3Dnc11T
X-Gm-Gg: AYBFou2msDcWaEmM6Ns3N+XycN0u5e2drv1BuVsHATiR/1XdCGTtNXzNbNo85xxRtll
	1Q1b+fhlZt7Gp1PI3+H1BngXDP31ayPCciw2ouCS45YliH5+YZi0z698Hvkootb/m6F8tFYaq6G
	YjsY30EYLqgVCbQSdVlZevucatzLLLyJ+AeRzgT7IDjerDkgiMfudiDqXsUDv/xBpveQygi+NRJ
	s3NtqIOmVnD9eGwkIZg6p9EZN3PkUCHpvUWsbpzds107nPvlAI+av2B5g/IE4RS5e7DuZQ6nzsS
	U3UCcDSGRjKxKNrkQhT2kMp2jPwL/lvCsvUJbvgEsdDQpdfY1cMVolkQdaVEIUXAe93pMQ1KvMl
	RxkPvy8v/0lZTuZrTY6QS3rZDWU127CY/prJiAucbzB/RzTd/6jpeIRn4YKzz+slFv5ZvMsn34x
	imGwr/kM8auXqLgM5C14W6+whlDpPpjbk8E6q0569kG0wpS5kRnJo/wzjsjicOI8WK6qMc7pjB0
	laYG+Un7+5xRDbhtuxHelHF19wVq75Vv3rLKOcAlCr45oqN5ASwsh/tJQ==
X-Received: by 2002:a17:902:fc86:b0:2e9:5971:122 with SMTP id d9443c01a7336-2e9a69eaa37mr87787165ad.12.1792500757958;
        Tue, 20 Oct 2026 05:52:37 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:2646::3d0:4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151b6899sm11223135ad.76.2026.10.20.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:37 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Subject: [PATCH v3] block: annotate lockless task ioprio accesses
Date: Tue, 20 Oct 2026 19:52:33 +0700
Message-ID: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019125811.21666-1-ngocthang2710.1999@gmail.com>
References: <20261019125811.21666-1-ngocthang2710.1999@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
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

The io_context itself needs no extra protection: only the owning task
drops it, in exit_io_context(), so it cannot be freed under a lockless
reader running as current.

Publish the pointer with smp_store_release(), read it with READ_ONCE()
(address dependency orders the ioprio load), and mark the ioprio
accesses.

Reported-by: syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=feeb9b5352b9ff89618a
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v3:
- Move the comment out of the declarations and reword it (Damien).
  No code change.

v2:
- Document why no RCU is needed: only the owning task drops its io_context
  (Damien).  Comment in __get_task_ioprio() and a paragraph in the commit
  message.  No code change.
- v1: https://lore.kernel.org/r/20261018071636.79198-1-ngocthang2710.1999@gmail.com
- v2: https://lore.kernel.org/r/20261019125811.21666-1-ngocthang2710.1999@gmail.com

Tested with a KCSAN kernel in QEMU: 26 data-race reports per run before, 0
in two runs after (v1 code, later versions differ only in comments).
 block/blk-ioc.c        |  5 +++--
 include/linux/ioprio.h | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

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
index 5210e8371238..be999cbe7c91 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -56,9 +56,16 @@ static inline int task_nice_ioclass(struct task_struct *task)
  */
 static inline int __get_task_ioprio(struct task_struct *p)
 {
-	struct io_context *ioc = p->io_context;
+	struct io_context *ioc;
 	int prio;
 
+	/*
+	 * Only the current task itself drops its io_context, in
+	 * exit_io_context(), so a non-NULL ioc is always valid.  However,
+	 * another task may change ->io_context or ioc->ioprio, so make sure
+	 * to get the latest value with READ_ONCE().
+	 */
+	ioc = READ_ONCE(p->io_context);
 	if (!ioc)
 		return IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
@@ -66,7 +73,7 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
 
-	prio = ioc->ioprio;
+	prio = READ_ONCE(ioc->ioprio);
 	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
 		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
-- 
2.43.0


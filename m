Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0C193077
	for <linux-block@vger.kernel.org>; Sun,  9 Nov 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674272; cv=none; b=TcALHc4Mhk643Iu5i5ZjKZtCw5A97511GSGXjizFefawb4Y/wKrUKVfB2PV8RKEhrGUlLAtuDL8/Epe76aitAwN2kbZLJzKoDeAfYBlrw6B6C89ncgmNlOrKv5ZJrujdmmUV9RqtOu4QCFIJ0mKE91eUSUsnhDBnKfqKb5CZAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674272; c=relaxed/simple;
	bh=CIyrpfTNwo+r3ux8nGQ3CcKAu9xjmMHIRHwqsv003x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mw8aBjRwULHDaE5YXWLBAbWCm8Iw87F4AcdysfTT7QmcV+V8sW670y4bY9TUIw+7ntahHnDgM8sVe54Gtc0sZh/JebScq92MxKP6RcTz1mXD0wZ6MG9gdHPk+BFNDmX+Gt9Es0edSX6xe7MZGJtJvtKk6jxtZhS/5ZbTzpni5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx9CKc4h; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx9CKc4h"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437af8444cso409549a91.2
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 23:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762674270; x=1763279070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b14aDsmji/7PVHezr8Axy3n7TuJRR+JLjw9V6CCyUcg=;
        b=dx9CKc4hzvh3fEGg4TGSV6st2IMjOeo0UBiSrDCL89E/CFtlxQeEVMB3miC4nVuqwo
         pUUwnykypn5wOWU3pTFStmUnT8OBgEkbDc2eTCREtNGdyZxdWqovlPATTXyOd3EymDCV
         q8mYG9z13JPzziUpOewJH0Tfmjkcufs9ul7mKRT8Wocm2Z+EBVltTsppJnnV7xBxZD5o
         oqtTFABM2XLYqZiMZe5JVLNSG6tLWqAB19+4ATqV4R7SuxcwfcWCrohdTxMWkJfAwONz
         rUOKgBJ92ok9/t7cJidFBcCbUOtI73aevZNIReKq0SnkO/+GdPdScXG3N1zu3GyDuO4A
         07Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762674270; x=1763279070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b14aDsmji/7PVHezr8Axy3n7TuJRR+JLjw9V6CCyUcg=;
        b=Vxt9vNW0yAWJe4ssltPIQc36mzl/4jZ5JGPZVqN+XAiaSWtt/gW4qGM+PH4lSruUzr
         ML+cvmY0QB8yCN2wXsKzs9Dtlm3TCyyK5HxNapvO1+N7YhFJq329zTTNrwwU53uFsd8A
         NiGndppUsv/HYJTPlwddVF3xXJTmCElCbSL7CO/lw6/hhLQO/y4M2RT9O+jDWLmbnmJ0
         9TDvv5kP042b/dV6VdwgkSa2toTrS5WCrKRtvLzNKVrR3b/hhHWtF3MWOEQNRJILwTqw
         whE1OzY0I1mdtkUPP79ohkrfu4exdPvCnicM+M5L/mFyfo4QeJTCxuNHEzz2yBS0rjyM
         h5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWEYMvUlwZ0t0epdmdg9VNKbNOmSQ5c7WnHyb9XRbArazjOQ2myQ2uhK1xKJOZM3fnvSfktexZcpFO5Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2098Dg2jHsAJC3tFqqiuNMf1vS5n8MJ6WBU5ne7wtIlvgktOl
	fKp9pp2mjO+RfCRpYLuP7JuJibuGk85n/BmUCJq2gFIy4rQCxXAUUbeO
X-Gm-Gg: ASbGncsfRLDZpaotQFRZ9jV/ffn+b7YOe+pKrZ+EWBPHkt2U7OAXVaDNKTMm5WKwx4z
	Ff1j/hb1LJpWWQc7lEU/OGYHyxGom4z/dvrI0EjvS3OsZvxJOGwFrHg8Zms5oEsCs5Zm5GUqYBr
	dY3+1sGjriP/lrDWzBfLaDSGhqkuD9f4lMrZXT7dBk8RJ/K7NPOJ9+7O0YWnuYAqKu0rINYgvBx
	1HgAoH8bsIZ+GZI3yoOnGf/DOvbuiy6zpR+1exTEetJjYW/KSL6udvJjFk/bm9ZX6kA4zRLr0+O
	XUz3ba2xXy9hPRYQw0oPSGmPRRtMT+k68xU0Wb16vo8rrmkiZeJH5usqA9Jd1q5Txa2kqJTrzSR
	pey/0X1XeqAW82j5+JGN4OwJl6HR/EK3suiryZeKa80FPX8c5hwA7tTKpbB58Gkas9XkZOt/z3W
	ByXwwmUwSAwNnKUEKN8CUqm7z+H6o99dvbyQqF
X-Google-Smtp-Source: AGHT+IGzI6ODn8UFkgPxgRGrX14lmOnwNQhhxui354pIxQag2tMTdOwoHtxZibXHQG0lMIBHIJBqSg==
X-Received: by 2002:a17:90a:e710:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-3436cb739d3mr5935076a91.7.1762674270398;
        Sat, 08 Nov 2025 23:44:30 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a67e2f82sm14157009a91.0.2025.11.08.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:44:30 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] block: add lockdep to queue_limits_commit_update()
Date: Sat,  8 Nov 2025 23:44:26 -0800
Message-Id: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_limits_commit_update() expects q->limits_lock to be held by
the caller (via queue_limits_start_update()).

The API pattern is:

  lim = queue_limits_start_update(q);  /* acquires lock */
              /* modify lim */
  queue_limits_commit_update(q, &lim); /* releases lock */

  OR

  queue_limits_commit_update_frozen(q, &lim);
   lim = queue_limits_start_update(q); /* acquires lock */
  queue_limits_commit_update(q, &lim); /* releases lock */

Add lockdep_assert_held() to report incorrect API usage.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

With this patch incorrect calls to queue_limits_commit_update() will
report following :-

[  800.055674] ------------[ cut here ]------------
[  800.055676] WARNING: CPU: 36 PID: 5507 at block/blk-settings.c:559 queue_limits_commit_update+0xc2/0xd0
[  800.055691] Modules linked in: test_lockdep(O+) snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore bridge stp llc ip_set nf_tables rfkill nfnetlink tun sunrpc xfs squashfs loop intel_rapl_msr intel_rapl_common kvm_amd ccp kvm ppdev parport_pc parport irqbypass i2c_piix4 joydev pcspkr i2c_smbus qxl drm_exec drm_ttm_helper bochs ttm drm_shmem_helper drm_client_lib virtio_net drm_kms_helper net_failover ghash_clmulni_intel virtio_blk failover drm ata_generic serio_raw pata_acpi qemu_fw_cfg ipmi_devintf ipmi_msghandler fuse [last unloaded: test_lockdep(O)]
[  800.055785] CPU: 36 UID: 0 PID: 5507 Comm: insmod Tainted: G           O     N  6.18.0-rc4lblk+ #103 PREEMPT(voluntary)
[  800.055792] Tainted: [O]=OOT_MODULE, [N]=TEST
[  800.055794] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  800.055797] RIP: 0010:queue_limits_commit_update+0xc2/0xd0
[  800.055801] Code: e8 f3 b8 89 00 44 89 e0 5b 5d 41 5c c3 cc cc cc cc 48 8d bf f8 06 00 00 be ff ff ff ff e8 06 2f 89 00 85 c0 0f 85 5b ff ff ff <0f> 0b e9 54 ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[  800.055805] RSP: 0018:ffffc90007e37b30 EFLAGS: 00010246
[  800.055809] RAX: 0000000000000000 RBX: ffff88815afaae40 RCX: 0000000000000001
[  800.055812] RDX: 0000000000000000 RSI: ffffffff8294deb9 RDI: ffffffff829e7716
[  800.055815] RBP: ffffc90007e37b50 R08: ffffc90007e37b50 R09: ffff88815afaae40
[  800.055818] R10: ffff8897df0a0000 R11: ffff88983fed3bc0 R12: 0000000000000000
[  800.055820] R13: 000055d8c85e62a0 R14: ffff8881761b24a8 R15: ffffffff8457b4e0
[  800.055825] FS:  00007faf1f802b80(0000) GS:ffff88985c0e7000(0000) knlGS:0000000000000000
[  800.055834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  800.055837] CR2: 000055d8c85e9eb8 CR3: 000000021fc44000 CR4: 0000000000350ef0
[  800.055842] DR0: ffffffff845fdc70 DR1: ffffffff845fdc71 DR2: ffffffff845fdc72
[  800.055844] DR3: ffffffff845fdc73 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  800.055847] Call Trace:
[  800.055850]  <TASK>
[  800.055853]  ? __pfx_test_lockdep_init+0x10/0x10 [test_lockdep]
[  800.055860]  test_lockdep_init+0x1f1/0xff0 [test_lockdep]
[  800.055881]  ? lock_acquire+0xe3/0x2f0
[  800.055889]  ? find_held_lock+0x2b/0x80
[  800.055895]  ? __kmalloc_cache_noprof+0x5d/0x770
[  800.055906]  ? lock_release+0x14a/0x2b0
[  800.055911]  ? fs_reclaim_acquire+0x48/0xd0
[  800.055923]  ? __pfx_test_lockdep_init+0x10/0x10 [test_lockdep]
[  800.055929]  do_one_initcall+0x58/0x2b0
[  800.055941]  do_init_module+0x64/0x260
[  800.055952]  init_module_from_file+0x8a/0xd0
[  800.055969]  idempotent_init_module+0x17b/0x280
[  800.055980]  ? netif_queue_set_napi+0xe0/0x150
[  800.056007]  __x64_sys_finit_module+0x66/0xd0
[  800.056012]  ? do_syscall_64+0x38/0xb00
[  800.056064]  do_syscall_64+0x76/0xb00
[  800.056072]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  800.056076] RIP: 0033:0x7faf1f32bddd

---
 block/blk-settings.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 78dfef117623..51401f08ce05 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -556,6 +556,8 @@ int queue_limits_commit_update(struct request_queue *q,
 {
 	int error;
 
+	lockdep_assert_held(&q->limits_lock);
+
 	error = blk_validate_limits(lim);
 	if (error)
 		goto out_unlock;
-- 
2.40.0


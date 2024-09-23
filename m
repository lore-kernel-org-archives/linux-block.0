Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79ACA6F;
	Mon, 23 Sep 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078561; cv=none; b=FDlAiqmVLtWHz/Wh5BduVxhj5iRdkeGhfyqZSm8BkjE0j4sZCqrSAeTULzOBYW5X8B5tVCa2kgGL92e+LhNbJltz4q5E5K6K///22xLUjv+ABU/I5DqYAMLd2p6umtRHQX2VnOUvvCK2KydeUJd7MtDdzW8GB+V11aAkZIDGJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078561; c=relaxed/simple;
	bh=3Ir7lWe8xvbZFUrMoVcf+O1wblb/ZvCOwshJcToeboY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmIGpClWw6whqXuMFJTwkjC1FLiq9Qk/g5JkBdBiDe2sB71JF2zTq0WBE6u7y5ImsZypJOJxojaOvljz0DzScgcbRuo7bp/W3KGVqcLZlzUZNixEeuXTqwKEIVcyAw9K9XouPg5L+NnY9b2gzxgr6eCAs9AgvktSlVOIWnFoZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8vr47Cx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8vr47Cx"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365392cfafso4020126e87.0;
        Mon, 23 Sep 2024 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727078558; x=1727683358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wys2gYMU6qguUwcMVWUSB7Sc9FyEhhilq8cU/armaOk=;
        b=J8vr47Cx/hiEIYGf7v0Y1H/Oba8S6TnakS4Kn/DitganJnsg/4pKnC1T6DMB/3KLly
         yieofPKCxbhk4U9XByVEX0UkK0vrPjatfHsSr88BFBARGD791kY8N3S5jVdOZUOlfHy7
         sQVz77rdBU+GrFidCSyNxnh31vwNvKLI4twNJKzEus2Ct9eIi2e0SHloGBRg7q/n1q/l
         yrabyAwuYHAOx+F6H3ET07zJk8X6XpSM+b45c7MUy4oJ8kQGOUbDDrURX3btBB6q4sSk
         FPLh8RzlVZPTKylVCINz3kxnEokrwooNucREKWJG/ITokgIGjJUMEm/lyPE4alX+CGlW
         /yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078558; x=1727683358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wys2gYMU6qguUwcMVWUSB7Sc9FyEhhilq8cU/armaOk=;
        b=ugUEZwr5umpS4kyfnXSGmxYLYGU4QPYJWKPgqfiyDL5Y5oAB9nGN+vmG3RENzFhAzj
         SQdDoqQAy4nu8y5TsCZj2xsX5JR3KX0qzimgVEAFACrmeOIpIFcnP3buMFome23NDbC4
         qy+C0b7RCh+wUPsRl/YHMh6QbAGIES1xWtpekd1jjX0xJ7zpoosw70T8+VBpzS6vccaz
         VQTDiVi6MTU31egTA20apLEVVHEuywU9BSQhADbvpYKyN1qyqOpXUykwvIJp/358K1ze
         vC3AZkb7IZkxpiZhhJFGI7VKa9c0P0d2sHp12v3ROkBbEf9iaw38dwbWEKQXZm+GSYQr
         KR3A==
X-Forwarded-Encrypted: i=1; AJvYcCWFlCcRU4KsIk2fbl2KmAdUHWaCN0RL3QbMJOIQr5fRbskYdwvbDThVIsZdEQyL8DsfQ5myfBEsxLd/3A==@vger.kernel.org, AJvYcCXUL22cCEEzyV92sQS6RQQdsIEtt4SQXhY5Y5slNXwUWQiLdkCb4XftmmK3rDq+ogbtVuZkFBBS@vger.kernel.org, AJvYcCXbPfRbmnImG2rC6qSS8dqJQBCsg4yORtwP7qnR/N28DDqeBwj9XoUO3ak5ZX0M9V5uQrEluHOEUrfLqbNX@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxjytYPDVmCn3vSv6+mBIFhPGsMsozGnyQeSVb8gimTKNgxQS
	POap5bozDiY3WAhoMtdr+kTqOLyzBgRbiLBYvsgNOIy38j0YAa56
X-Google-Smtp-Source: AGHT+IGxkIf61c8ONIfqrOaTVz5ev2haC8bTjrGechxcNQzDms2jYEfwKOtzceUljR71SivaxkqdSA==
X-Received: by 2002:a05:6512:b9b:b0:536:a695:9429 with SMTP id 2adb3069b0e04-536ac2d683fmr5303219e87.10.1727078557929;
        Mon, 23 Sep 2024 01:02:37 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870966f6sm3207191e87.151.2024.09.23.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:02:37 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] zram: don't free statically defined names
Date: Mon, 23 Sep 2024 11:02:11 +0300
Message-ID: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change is similar to that is used in comp_algorithm_set.
This is detected by KASAN.

==================================================================
 Unable to handle kernel paging request at virtual address ffffffffc1edc3c8
 KASAN: maybe wild-memory-access in range
 [0x0003fffe0f6e1e40-0x0003fffe0f6e1e47]
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000427dc000
 [ffffffffc1edc3c8] pgd=00000000430e7003, p4d=00000000430e7003,
 pud=00000000430e8003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] SMP

 Tainted: [W]=WARN, [C]=CRAP, [N]=TEST
 Hardware name: Pine64 PinePhone (1.2) (DT)
 pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kfree+0x60/0x3a0
 lr : zram_destroy_comps+0x98/0x198 [zram]
 sp : ffff800089b57450
 x29: ffff800089b57460 x28: 0000000000000004 x27: ffff800082833010
 x26: 1fffe00000c8039c x25: 1fffe00000ba5004 x24: ffff000005d28000
 x23: ffff800082533178 x22: ffff80007b71eaa8 x21: ffff000006401ce8
 x20: ffff80007b70f7a0 x19: ffffffffc1edc3c0 x18: 1ffff00010506d6b
 x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000808e85e4
 x14: ffff8000808e8478 x13: ffff80008003fa50 x12: ffff80008003f87c
 x11: ffff800080011550 x10: ffff800081ee63f0 x9 : ffff80007b71eaa8
 x8 : ffff80008003fa50 x7 : ffff80008003f87c x6 : 00000018a10e2f30
 x5 : 00ffffffffffffff x4 : ffff00000ec93200 x3 : ffff00000bbee6e0
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffdffc0000000

 Call trace:
  kfree+0x60/0x3a0
  zram_destroy_comps+0x98/0x198 [zram]
  zram_reset_device+0x22c/0x4a8 [zram]
  reset_store+0x1bc/0x2d8 [zram]
  dev_attr_store+0x44/0x80
  sysfs_kf_write+0xfc/0x188
  kernfs_fop_write_iter+0x28c/0x428
  vfs_write+0x4dc/0x9b8
  ksys_write+0x100/0x1f8
  __arm64_sys_write+0x74/0xb8
  invoke_syscall+0xd8/0x260
  el0_svc_common.constprop.0+0xb4/0x240
  do_el0_svc+0x48/0x68
  el0_svc+0x40/0xc8
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x190/0x198
 Code: b26287e0 d34cfe73 f2dfbfe0 8b131813 (f9400660)
==================================================================

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 684826f8271a ("zram: free secondary algorithms names")
Cc: <stable@vger.kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c3d245617083d..d9d2c36658f59 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2116,7 +2116,9 @@ static void zram_destroy_comps(struct zram *zram)
 	}
 
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-		kfree(zram->comp_algs[prio]);
+		/* Do not free statically defined compression algorithms */
+		if (zram->comp_algs[prio] != default_compressor)
+			kfree(zram->comp_algs[prio]);
 		zram->comp_algs[prio] = NULL;
 	}
 
-- 
2.45.2


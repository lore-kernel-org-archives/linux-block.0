Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134852F6918
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572176; cv=none; b=jL3442dxSp4UxU/CgZZlg/CxFed9VF71GiC2y39aqKmd/dZoX3ZQCnrcaWGABtSFYSTv5gSxD38b5KO9i1k/QqyG/cfuB4hnujt4qoanXYvgI3rtXQ7mwGVxERaAO8ZIMqohuY0Y2HNx4Jimfb48qdgdEHGKRkhs06hdkrI0oKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572176; c=relaxed/simple;
	bh=ygaH+2wsFcmG/zLT9vuTLDnDQTwm/pe2WCSsYbTR67A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTBRE53uGBmIxNsPQW7WvHqACMegrTV2j6Sy5ztK+NJepZvfWpr2f86BdgGX191FhJP/K8Humv48Ho/2nhlzHBY/NgaliMvYSNgrB+f98pBl750ZNRfIh5HtAkJ6amvO2zmvkLf2EbJ9lnKw8YcUC6A6xKcr71CqD6oC/qZnzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgNI8xyH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgNI8xyH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc860066a6so21005625ad.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778572174; x=1779176974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UR6rLERhiUgj6UCn2Pmol6DViHNRfs8NhBRMn+AmWuM=;
        b=SgNI8xyH16c23MyQQW1H7nDX+hDs4VMwAowv2GUbFd5BBZXBoLvAtvr1fQt/pE+Gzz
         eSDvkwia+5MXVyua5x16SjXkOybBL2pIGhe91+/t3SuXJkFmJettpYHdZiP1F5f/bYKB
         tcUXmeZrnly36zCy9HZHDnpaOsb5gN/ZDUVFSNYhg4i11Zblnc3ukB2RELpekvasti0b
         vbAvo3ppkVsMcKpRxs2pQTSN3+5u92cPH2xByN90kFW6Tc1JIEsGLI4pAiSrjm1M1S4E
         3k+0I8D9OfXZwcsPhUfxooyBwW4C6Xqt/NP67mGpq+fXkiYqWzqDefQWTK+6YqzKCKVO
         4bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572174; x=1779176974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR6rLERhiUgj6UCn2Pmol6DViHNRfs8NhBRMn+AmWuM=;
        b=szfM8nJ/D97XbBZx67odVS5O4t2ootdH50idjMksyyk8U0z8rPxUuH3hh02GmHHn5W
         idoY8UqT+BQTtfi/JakPBTnVnSWQEwV7Rlnem7jnyc2y+s1Rr/mEPN19I0XRSyLWTg00
         bhC0sjTYoJaENtdAswSRdxafgyp1A+Z+Emwz7rHarYJMQ4M0q1irF8eBz47YrwFzoSkE
         peUgz93RnAtExMfJ6FNErzO4RbcPiIeFJh4ziNy/nlBShkItkLj7sK14PYLAXEKqC8rl
         o7mfDUOI3E+kzigcvrb1pui5zKzNAoNBje6Vq2C3mUDVEeKC3p0mxDFuetUP2W/Kr3OQ
         izEw==
X-Forwarded-Encrypted: i=1; AFNElJ/JOAh88TkVkOoUC/ZxrB+FnqjeZdT24GaCNpoFvCx71VpGCSS/e4WHAMGydmIlRHg604uL2a6JkFCuhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBYUzgnYaBaP648m1pllw5RdwVPAVLuud7f/AccvRL/fxUp0H
	ozCw7toADZnk4OtDQGPqOB/bW2r2zehhK22I1Bb7MsEIZAZz81gbw5yYqOqcGRjHZWk58b/U3/1
	EzP7HfO4IL0QdgoR2hJ5x
X-Received: from plhu11.prod.google.com ([2002:a17:903:124b:b0:2ba:792a:18a7])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:287:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2bd010f4ccfmr21818475ad.6.1778572174022;
 Tue, 12 May 2026 00:49:34 -0700 (PDT)
Date: Tue, 12 May 2026 07:49:18 +0000
In-Reply-To: <af6ZT9oR7GGmMFSC@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <af6ZT9oR7GGmMFSC@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512074918.2606208-1-richardycc@google.com>
Subject: [PATCH v3] zram: fix use-after-free in zram_writeback_endio
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A crash was observed in zram_writeback_endio due to a NULL pointer
dereference in wake_up. The root cause is a race condition between the
bio completion handler (zram_writeback_endio) and the writeback task.

In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
releasing wb_ctl->done_lock. This creates a race window where the
writeback task can see num_inflight become 0, return, and free wb_ctl
before zram_writeback_endio calls wake_up().

CPU 0 (zram_writeback_endio)     CPU 1 (writeback_store)
============================     ============================
                                 zram_writeback_slots
                                   zram_submit_wb_request
                                   zram_submit_wb_request
                                   wait_event(wb_ctl->done_wait)
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
wake_up(&wb_ctl->done_wait);
                                   zram_complete_done_reqs
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
                                   while (num_inflight) > 0)
                                     spin_lock(&wb_ctl->done_lock);
                                     list_del(&req->entry);
                                     spin_unlock(&wb_ctl->done_lock);
                                     // num_inflight becomes 0
                                     atomic_dec(num_inflight);

                                 // Leave zram_writeback_slots
                                 // Free wb_ctl
                                 release_wb_ctl(wb_ctl);
// UAF crash!
wake_up(&wb_ctl->done_wait);

This patch fixes this race by using RCU. By protecting wb_ctl with
rcu_read_lock() in zram_writeback_endio and using kfree_rcu() to free
it, we ensure that wb_ctl remains valid during the execution of
zram_writeback_endio.

Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
Cc: stable@vger.kernel.org
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Richard Chang <richardycc@google.com>
---
V2: use RCU to manage the wb_ctl lifetime
V3: add stable tag

 drivers/block/zram/zram_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..07111455eecf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
 #include <linux/kernel_read_file.h>
+#include <linux/rcupdate.h>
 
 #include "zram_drv.h"
 
@@ -504,6 +505,7 @@ struct zram_wb_ctl {
 	wait_queue_head_t done_wait;
 	spinlock_t done_lock;
 	atomic_t num_inflight;
+	struct rcu_head rcu;
 };
 
 struct zram_wb_req {
@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 		release_wb_req(req);
 	}
 
-	kfree(wb_ctl);
+	kfree_rcu(wb_ctl, rcu);
 }
 
 static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
@@ -964,11 +966,13 @@ static void zram_writeback_endio(struct bio *bio)
 	struct zram_wb_ctl *wb_ctl = bio->bi_private;
 	unsigned long flags;
 
+	rcu_read_lock();
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
 	list_add(&req->entry, &wb_ctl->done_reqs);
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	rcu_read_unlock();
 }
 
 static void zram_submit_wb_request(struct zram *zram,
-- 
2.54.0.563.g4f69b47b94-goog


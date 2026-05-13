Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828518E025
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666529; cv=none; b=FTtV4TCDCPeQiwAlOen+gLC8O/cynl7mw4ANr/hbZqhaSKvNwr/i7LnNIZHH42By4knVZk0bKDrEruI4U0mYc0HU8ziH5PgXvfCocQ4BVNsW2jnnBmNBPS/zUR/y9GBIDsD2h2VlP7gPsw1sFMZoWWh3u+NjYToOMcou6Rt9kCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666529; c=relaxed/simple;
	bh=XBhpQvK3T+edJhMt8EhdXq9DxSizRHtjPZnPWlSgLKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGAqwa+xl+IwKCNb5IXrtv1ICC+8VJuJx3WMzmEocEdlU+IsRsU2f7DOi4sYJldOGYxyoQbSwSdB1ePCYL+nYJfi67mSHmM9Oi89s2LD6z7uAxW38FLeFaJFd9cVEhzNMX1YACIw87RJSNQynobE7gDj9/ZJe9u9fxbGCE1Cp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0wK/84p; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0wK/84p"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47c35be02fdso2581113b6e.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666527; x=1779271327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAN0h+mM2+Lo8kjVDsvWN1dVVgYzyYf7/o84sgnLVTQ=;
        b=X0wK/84pXkt3Z3YJgd7T6hmyAaQF5kjlJAq5nyA+cdIRGkUZt6J612Esw/v2UFOKXQ
         g5BLhh98kua908ajvknKtXQJjevik3d5I9D69waJqkd4jl/auTz+j+YIOmBusc9+m0iS
         I1Awzo1Dg954TYWDbGByjwNYkfuaNzF0vFK8q/F7sCSxGDHyYdAjyVhfV77sv77yC2g/
         w16eLAopPIff/KRbQ90LTU6RTceprFUTxzXbBQxpgrkaknuMFUonxHWByhQjEO69Rz0x
         Uvzm6rU/0wXcD3KuRQcjtbECezwxuKLaeKbK58kaUJUh1lcgtbXEYKCzWYxkPWZtNjYX
         olHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666527; x=1779271327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAN0h+mM2+Lo8kjVDsvWN1dVVgYzyYf7/o84sgnLVTQ=;
        b=iWodbVhEKOXVTspvmIMhRUg0FeeiUhRp8RZbHGAe7uNgAOCbflec6OFzR8ShFp0L1/
         xBiK/1FooAuQ1rTNusGhJdWurpR4GGaZpa9r/S25+0k8dYvBq0H0+wsTREKqXD5LTtrg
         B4AWRMpqaf2AuYEnkm91+CJRvtjd/e+d+IfvSYKW7NIbdxgaG2fMYpwphnOOo6KjAWmm
         sHdlHk0sydfc3GcdtsCYXxQhY0fGNdQElwspcXMgCMTRFD+ftssjlSMtpFow21f2x/jc
         9XILINhel4PdvpfPcSEpjexe3QzZKxSjRjmeyl9tCbAQ+ixdixTDYaEsCecidv+rhLJ4
         yCHg==
X-Forwarded-Encrypted: i=1; AFNElJ+ASQjpqZADGl1Qj/rYJPKM8hM/tOZkTmKDwPVyi8FYezK14rzkfhtVwCcHbx9XQHEN3VzV13Gi2sOoag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8cFoQwcmlO1BFCNvOUfbl3VDUtBsWQHP79yBwIW93hCbPcjs
	752Tsq28f7ajLFZMMUr362gReA7j99lxTcdZsdntg9pWrbWjXPwanSuG
X-Gm-Gg: Acq92OGF7EB5oHnm20DHnXnXyjtyuoKFIqevZ/zMAnlPyjD9xQA6byhbw4WJYX6SI8S
	yMkI4PySiJBv4uup7F/zflysYq4J14EsD+Dj0gblZXEnsOdFO8cP0qzX42w+DZ77qQEGLZGv5Ci
	65G525hEcX4/Gvo1mn16M3s1n8aT3LMl+9+kmDSj0LbZyntTYau9Zvkl9f+7tZH/K4FJpduBe7Z
	F1CgxJlqyv6ILO/KGHNN3KSPCpIWWQFe6VPeNhJ9XAxAd5p6y2o38yuWDy+hCtfFqdTSU3rcmvX
	7n2XaOidBlNBAlnlynmBmpF0f/Y1EKlt2eCgZG1jZgUfLOlPzZN5kg6qdmmznNe5ZCG7unq/8M0
	GcHMS40/wLZ+qiJVJ75R1C/KBJFEBKR97/laaelfAAAtoT7NAFPkBCznMevS3whenhQC1luOR8k
	IdljZouXAY/izFuYEPnNbBJtcLdP8dWrK58cLqg9k1RTEfDOa8N2vskq09+kpTH2GuraPF3MuWW
	4id7B+gO4oE8nUk/6di
X-Received: by 2002:a05:6808:3096:b0:479:eb19:6e6a with SMTP id 5614622812f47-482b2db3069mr1565767b6e.34.1778666526961;
        Wed, 13 May 2026 03:02:06 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935637sm24053821b6e.12.2026.05.13.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:02:06 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: cap nthreads to kernel's actual nr_hw_queues
Date: Wed, 13 May 2026 18:01:42 +0800
Message-ID: <20260513100142.1371363-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

dev->nthreads is derived from the user-requested queue count before the
ADD command, but the kernel may reduce nr_hw_queues (capped to
nr_cpu_ids). When the VM has fewer CPUs than requested queues, the
daemon creates more handler threads than there are kernel queues.

In non-batch mode, the extra threads access uninitialized queues
(q_depth=0), submit zero io_uring SQEs, and block forever in
io_cqring_wait. In batch mode, the extra threads cause similar hangs
during device removal.

In both cases, the stuck threads prevent the daemon from closing the
char device, holding the last ublk_device reference and causing
ublk_ctrl_del_dev() to hang in wait_event_interruptible().

Fix by capping dev->nthreads to the kernel-returned nr_hw_queues after
the ADD command completes. per_io_tasks mode is excluded because threads
interleave across all queues, so nthreads > nr_hw_queues is valid.

Fixes: abe54c160346 ("selftests: ublk: kublk: decouple ublk_queues from ublk server threads")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index fbd9b1e7342a..0b23c09daea5 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1735,6 +1735,17 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		goto fail;
 	}
 
+	/*
+	 * The kernel may reduce nr_hw_queues (e.g. capped to nr_cpu_ids).
+	 * Cap nthreads to the actual queue count to avoid creating extra
+	 * handler threads that will hang during device removal.
+	 *
+	 * per_io_tasks mode is excluded: threads interleave across all
+	 * queues so nthreads > nr_hw_queues is valid and intentional.
+	 */
+	if (!ctx->per_io_tasks && dev->nthreads > info->nr_hw_queues)
+		dev->nthreads = info->nr_hw_queues;
+
 	ret = ublk_start_daemon(ctx, dev);
 	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);
 	if (ret < 0)
-- 
2.53.0


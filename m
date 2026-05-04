Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613593D3319
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897989; cv=none; b=dWDej1xHXbRgQLpECu4FMnmbwGk1RtdRYa0ftELIuKUG0ZJRZ/vSU93Rhq8sYUzn3eBJMc+RTIr9xGMX6fwTnwy45VfaDTGTbfSRv0XgMcic2K5TnCYHNiMt5sT8iEgTkK/fPNldDDf410qgTk+vLkhsDSUUFF5tuUayVXDx2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897989; c=relaxed/simple;
	bh=yBqzeljeCYAWMfvKpILNF3nSvYdFoDwPi6LXBX0tD48=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jVJlwagW2uGTrfZ95npdHqogJf8k4CmVvBHj4KnvmGmRoKwUB9vUU8WQ2zLXqlcQQj1gWbUccnCPdEjvit/tDQk5OlHIVkuUaUgEOtVoKEzhfBKcjt4XTNBYA3wVWdaKGdC4ZQKIdpEflpg5dR/xcf3UKtjOWGuzqXzUJgkecPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKQwjQRb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKQwjQRb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835423c69ffso550364b3a.1
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777897988; x=1778502788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8/CDtnGvalUzgGFzgyiRHcKrsHnUrOiavCD5LiN7Ac=;
        b=DKQwjQRbrBKyaP29/7VWl0cRhivrxZq/Z+93tXrAr0iamjMNRA2P1BvvSVer56ErC1
         +yPIhyPzP96lA0Ojv1biVLaNXBziRBJ+YWNg83uqocBgi25ZYOPo07I1IDPDAVj6da/5
         Rpej3IomOvrf5iJz8tTqODt4ejklGo0zj051JoAai0POboLQXRnnY4ohUt6l0ZU9d4kv
         Wh2Fxd1BC6Atx0mhsZO5uK83pEIUZRSuZKOEJuNRkEJLf69bbevv9ibRxRwWBQYw5hQl
         YugcfCiS4CBSdB5HBu8BSnMywUQzbNW1hdsQigNyOIcVnhWm4u74KVWn0vma163GYDEF
         rN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897988; x=1778502788;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8/CDtnGvalUzgGFzgyiRHcKrsHnUrOiavCD5LiN7Ac=;
        b=nAy7SOHdiCfrlsxZrLKIVbNmF+cGXIBfc/Ccn0PAK6BxsVDyeuDIJV1cDgKGLc4osV
         u8F2eSmH2+xp34KlsRzDPXsc8iezxNx8+hBHkwYfk8a+DF0t5eEdR7uWWd/VLc55CL9b
         GOnPh2A6kw6j7F9kUUpA1RqklS0P/wI/vE/jG7VEi25tevfB4y9vnfry75EjHwdvLkHu
         TRrIDRGuIn3Bm9ESBy7at4K+GnrDAQF+WMW0xdMA/FTgeJDV7YJlKPY1PP/HVzd+/Qa/
         hmF0KBw76pM7Y06MyASKwUVlk5Q/QleXA2R0rSM9WFNb76MpeeMTB88etuw81PKGgHBl
         HR8A==
X-Forwarded-Encrypted: i=1; AFNElJ94W7u6mhbm1E3B5xJpM7TblHyHWgLRJSVMwhCZoSG5hRHoCz/gqjwpDE7XQodfoaGS8iESde4yqnUGwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VbDDS9tG09hxUyILqNtrEgc6CsF90/kChcpDLU7Brrkve9dK
	KQ245oxCVma0kgkCC20ulq+MNHnjeZwULsAsQB79+BgGxbluOQdjVYOmm7GABdN3xljR7MMzud+
	bos8EFrx06l9puxMlHrv5
X-Received: from pfblu21.prod.google.com ([2002:a05:6a00:7495:b0:82f:86c3:55ba])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8ccb:b0:835:3c9f:1a15 with SMTP id d2e1a72fcca58-8353c9f1f13mr4332851b3a.25.1777897987531;
 Mon, 04 May 2026 05:33:07 -0700 (PDT)
Date: Mon,  4 May 2026 12:32:30 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504123230.3833765-1-richardycc@google.com>
Subject: [PATCH] zram: fix use-after-free in zram_writeback_endio
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

A crash was observed in zram_writeback_endio due to a NULL pointer
dereference in wake_up. The root cause is a race condition between the
bio completion handler (zram_writeback_endio) and the writeback task.

In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
releasing wb_ctl->done_lock. This creates a race window where the
writeback task can see num_inflight become 0, return, and free wb_ctl
before zram_writeback_endio calls wake_up().

CPU 0 (zram_writeback_endio)       CPU 1 (zram_complete_done_reqs)
============================       ============================
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
                                   while (&wb_ctl->num_inflight) > 0)
                                   spin_lock(&wb_ctl->done_lock);
                                   list_del(&req->entry);
                                   spin_unlock(&wb_ctl->done_lock);
				   // num_inflight becomes 0
                                   atomic_dec(&wb_ctl->num_inflight);
                                   returns to writeback_store();
				   // frees wb_ctl
                                   release_wb_ctl(wb_ctl);

// UAF crash!
wake_up(&wb_ctl->done_wait);

Fix this by moving wake_up() inside the done_lock critical section.
This ensures that zram_complete_done_reqs cannot consume the request
and decrement num_inflight until zram_writeback_endio has finished
calling wake_up() and released the lock.

Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
Signed-off-by: Richard Chang <richardycc@google.com>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..a457fdf564f8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -966,9 +966,8 @@ static void zram_writeback_endio(struct bio *bio)
 
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
 	list_add(&req->entry, &wb_ctl->done_reqs);
-	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
-
 	wake_up(&wb_ctl->done_wait);
+	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 }
 
 static void zram_submit_wb_request(struct zram *zram,
-- 
2.54.0.545.g6539524ca2-goog


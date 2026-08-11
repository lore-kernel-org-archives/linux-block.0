Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB82EBBB7
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446290; cv=none; b=Fce4Ij4tfiZsEz8FfDGo+1mdCGLSkf6+OYUCOBEw9Bv/LEnn31Fe0QvDrN8wz0/pc5qZY8a8y8A3uIjkiG+MNbhLmN2ukGWcSOh/Kn0azVb5YD+QOEUpbiQU7FX68LNUKZnyKtusOkdjlXjh7IkuYcm5SwRbgRHufHA6OYt72tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446290; c=relaxed/simple;
	bh=atCxkuYL4hRzLwzbyOunU2UxpM3YWWuI9Tod9XDOHxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARAW56LBHQe2MF5WCWnE9Naj8kWYh0auTWr60F+w2/qNC2wjEJnH5HsqTyfqisZ7YNG7AfobQ8eDe+avEwPypk/59ou+t9xb+U+9yfc+cwrM/QSL0dJwAT/Q8VyAJ71hLHr51f/F7K+MiqtS3a4VbOw0qAMC54GvC0hgnjbBrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nneAstkH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nneAstkH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1220749f8f.3
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446286; x=1787051086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEHATZupNKkhi1i84uPxQjWjLcsCZYtEP5bp/4g/DpQ=;
        b=nneAstkHsY22j6wQMmPAVcGZBGnv3EKFyomdG3I/1hYHJExFM3n0HsRWTwFqjINyij
         V2x3mEAfhkyBzTqDb23rLHmfFWpEFGAWkOzJEwbEPG47ZgN7B/GlazbbVJfDM0eO4zws
         2uen8h67cR8SHkRhTjpiebYX/I29mC1aNnZ5Pxj31JLynS6IPKLqwAapFM+7pkqXDWme
         2VDWCjC653f0pijo9xi2GQKib1UOZsbVzmUd8ATxKrvU6ces2dlcKnj8xuxXSDb6AL5H
         mpBZT4ADC6dTaWGh8w/L/bNkQNoQj6d+tMu9TqLgWOZlPdMaPJ9D1V9LFtHfH+8ddIx9
         nouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446286; x=1787051086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEHATZupNKkhi1i84uPxQjWjLcsCZYtEP5bp/4g/DpQ=;
        b=sH00AWExGkW54njyFM4hs9dIBMIzxMmhDDYZCoLZRr3xvCMt/CWIzJQEETUt0JIy8S
         ZYKER9BzS8wixfyShUKp7RJIV+2K8vHMmaA78HHwE4NQMQqEv9CLZg8oHfu6kJqXfSmV
         2OiEMo3t48/4xrV2vWWHO1+6WxTOxFbTQYjxnM6vuo4pKGuq9sLRgiLvNEavC/UJ1Ygf
         jahrqUoSaor5t6cAfLsIFOYpzCoyQWjF+bsaeInlfv+zQ4PO34L97c0ZQ+lC3snVQHaJ
         QVyXBjkp7J0FaW4P4rWE59+39pDmaCrfqgUX+SeqaFD7RTsk5jex+/XnsU2J9bAo1Nce
         /nAg==
X-Forwarded-Encrypted: i=1; AHgh+RqFlDPGm7L5Nc6MIWGUgKWFILJ6nWl1pRvGY65Gxcre1js89AbbR7Jm0Y3xSU2o51da8lxJPqS61DzY8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUryeFfVQm2bTOF0K916Rax4zqaMMx5hzvL0uXsULNWy+Ma9lU
	msmxm0JrYxuZcy6Wwaux64H3wGR8XQhkXk0Ih8ZYu5+sn8kQtyxHUh1b
X-Gm-Gg: AR+sD13xlNn9dGPZLUBF2rSwNmsvft2/vbcO8IYW4pGa7NoJ0GQUdG8RtACqhHgODvk
	TdaKoiwgwTOaH+J4L5JbI3HKy3yEyBbt+ggUEdJlThY/Xc2p9KYHdB5e1en44exTdOuHQRWR3ts
	YfvV3qb4zuz35Qhv2UBjLzuIevtk5C3p0MqXLmRKqAJnv7ohMXfxBM3xhwcj+4v00JUSs2O3VDi
	OhzgR/ICD6DRxkS5h8XUAI1LzBBpdMnXxihMvDeom79TN35Cd/GruGu8SM2OUkn1vRHbV4Y623M
	ezAnfc7uTpSeysBM5rb/unSn27NoRq5xiUtyRtts3zVInHKq0tBV/a7rng5O5fBAOKvvMNHFOnt
	D1ibInB1CCRHuQUx38s/TIAHS191yhA83Yxzmn3GcvkwOkqJBvZTGcbOzW85/Z/MbzS6R3dCsuo
	MuivKNsbqbkXLS9Bm5bBvO/CpzLlg/WY/3hbN9ZyVH5eK82sID/uf+TnrHoJDH466Niw9gdIVIT
	t3JZkGQUmtelKSTAV1UN6lEoHGwwdo3moF0bpKV17viubwGQwfQSSqJ567+BxMc8U8WZb4c0MKt
	1Bcb02oL0hs5cUwW7IVivvSVrSX0wW++ZeTT+T27SoUQAHGAIIDWr/TBnRHCV3qiCpAK
X-Received: by 2002:a05:6000:4008:b0:47f:f3d4:26da with SMTP id ffacd0b85a97d-4814ad8ed6amr4076784f8f.11.1786446281619;
        Tue, 11 Aug 2026 04:04:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cdb8sm3593881f8f.35.2026.08.11.04.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 04:04:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Yi Zhang <yi.zhang@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix lost wakeup in blkg_destroy_all()
Date: Tue, 11 Aug 2026 13:04:21 +0200
Message-Id: <20260811110421.50747-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wake_up_var() requires a full barrier between making the wait condition
true and its lockless waitqueue check. spin_unlock_irq() has only
release semantics, so it does not order q->root_blkg = NULL against
that check.

During disk rebind, blkcg_init_disk() can therefore miss the wakeup and
sleep indefinitely. Add the required smp_mb(). Also mark the store with
WRITE_ONCE() since the waiter reads root_blkg locklessly with
READ_ONCE(). An LKMM model permits the missed-wakeup outcome without
the barrier and forbids it with the barrier.

Fixes: 3dbaacf6ab68 ("blk-cgroup: wait for blkcg cleanup before initializing new disk")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
LKMM (herdtools7 7.58), with the store modeled by WRITE_ONCE(). flag
is q->root_blkg (1 = set), lk the queue_lock, wq the var waitqueue
occupancy. To model the fixed code, insert smp_mb() in P0 between
smp_store_release(lk, 0) and READ_ONCE(*wq):

  C blkcg-rebind-buggy
  { flag=1; }
  P0(int *flag, int *lk, int *wq)
  {
  	int r0;
  	WRITE_ONCE(*flag, 0);
  	smp_store_release(lk, 0);
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *lk, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  herd7 -conf linux-kernel.cfg blkcg-rebind-buggy.litmus

  without smp_mb(): Sometimes
  with smp_mb():    Never

 block/blk-cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d9676126c5b5d..2b3cf9caeaa31 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -604,9 +604,11 @@ static void blkg_destroy_all(struct gendisk *disk)
 			__clear_bit(pol->plid, q->blkcg_pols);
 	}

-	q->root_blkg = NULL;
+	WRITE_ONCE(q->root_blkg, NULL);
 	spin_unlock_irq(&q->queue_lock);

+	/* Order q->root_blkg store before wake_up_var()'s waitqueue check */
+	smp_mb();
 	wake_up_var(&q->root_blkg);
 }

--
2.53.0

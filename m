Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5F1A9F8D
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434578; cv=none; b=RMGulv/8Yhjxx1jNevIN1WYjJ0bRCmaVTs4MVuM99XNXgV8GWC2rUF1XhCWl0I6x7neVY+zy8JAFUjrFaJKk112xb2GIZYGKEN+AuCjKUgvaj+ny5dNocE+gxz22yJlROrAn9niKJZOQmFCoinxNvJOeMvGet8WEs5knY1ZAvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434578; c=relaxed/simple;
	bh=o+vEFROiqUoDAPTJIDN1NXPMAkTeLu+cB5g1KoffBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTuqpguBvMNt6QH6rtvNxW/JX8+VYofX6M28vIHJvMh701HUTfbgjK3s4RBQooJqcyYhEyh3F5XsbE/YtPBvDha9V3MuzDnLVHYJ2JLpgxTHu0rZTLmMvI+e4lJkRnw6vkQaMk4dqkh79CZgyL2K8QvSH9rQWKJ1cvmUh90I13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgHTrhDa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgHTrhDa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a137692691so50335725ad.0
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766434576; x=1767039376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=NgHTrhDaWxgLy5d2rvpOBnTTvvfF1rnRysmlCB5uWDsfO9ieNB5TNv/BygfS9EW6Xj
         VjEUO68u5qGnDUmcw2Of2CjPodC+OyiLpGM1bMlXlFde30tuuGjrEV8X2648HElW8Y1Z
         1Y3KZpuzivSD+yvPY+bzJ18TrC+Khgve50tRNHEebwlyKtX5ORADT+ZKM3Ddhchhri0Q
         bkr+eZqpIRxoBCon7hs0qbW+HIwxFRnfB3CNI0/7b9mLzYH3jT+ATzvD2UvI+MW8Ka/0
         7ABxTTdRZgMjRayCCrhgG1pYQeYFiJAaVMkz406yb0hOlNHFnWScJ5C8uDpE8KJ7icYd
         me6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434576; x=1767039376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=fo+fJ22yLlVXu0gwDY3Xck+p/E0Rga2f1FT/43swwUbT9oPZcG6yXqUlgRndsvqExr
         ekZmMl6O2aBy9im1QNhKCHPLIoonnyR87/IEo5mNhgnyIz/x9bLAy0h14VzInjA32YdB
         mNTgZQQfQkbOYUqnfyj1/Gn8YfXdCs/0+ionJRt0ugVB54Om9lytsnuA5s+t6warj8hy
         aqriCaBlkNXjxL+OyAGEwCai5ue/glRc7jAaG5MJgfRbRFFYvWio/eboaXvfJ8RR6phX
         yyV7E/1IsTBXaaqjM35SS87WzLMJokt5CENhxpHXx6AHo0phYKSDzzSRzKGxhKXYjj2X
         INUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8F28j7Mb3dcSmNFbg6Dh7wRT3HfRUUgHvqXpfhBs647vGTH5ImJCT/K14kkGqLreicRJE2QhEAVkpQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzB7cw9CFy+zvqcUq9Un5svyR17vUhAtnl7QaJa/tzx9nklOQo
	CmZbRNQay17Crm+1LOC947C5EPAXlPX0n5HTLkf2Giv7ctO+dGOLunWE
X-Gm-Gg: AY/fxX6Z2/mtFhOBTwIsY5XNA5PPsR8KS6VuNJ1qjh/uRyIpB/imL43ZUbwz8E4liPz
	7fTG5Qlvvu1ubeIhXET/41mgJoD+ocOGbmq6tylWs7Fb2/A6zCjR7vP3Sxm7OCR8yd59ZaY8X6d
	vjCSwHRvqwizQ1Bg1+vEQoicwTdNy2clbIsXlBac5z2mQaWy3wvmFb0eGtib/8Zqeh5Fxu49Rus
	DdczgfBKuPAl1ur+ZeqvYrgYsQV7NZ/ZiJ+R7SmcdgjQS40vAvwWNmzH61U2wagrbP5SS3P/2PK
	kKG8Qa+H2TLn7op+yN3SFRE6PRGgMoUJLgl1mKrt6BJoOEpod0J3Os7r081Ek/S10LHi3ua05aG
	D4ADWf13w5zD0gY9i8o9haWzXWxLmdCIyKjYfTQ5h7AsfleS6WU7xwU+nxy4IMl0GbHrlIom2/a
	NbaGHaepDGA4Ue/q79pNzGWjxmMudhlEbK7iXDk5XxSFk/
X-Google-Smtp-Source: AGHT+IGGCPRsUbtdnSyNVH6HcSffxoPpOEnbF7UGpOntHaM5661Ya5XibckfxkPrf4FjkYaBiYk8BQ==
X-Received: by 2002:a17:903:120b:b0:294:def6:5961 with SMTP id d9443c01a7336-2a2f2840071mr108551835ad.45.1766434575985;
        Mon, 22 Dec 2025 12:16:15 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f07:6016:fa00:48f6:1551:3b44:fd83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f330d25esm104358905ad.0.2025.12.22.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:16:15 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Mon, 22 Dec 2025 22:15:40 +0200
Message-ID: <20251222201541.11961-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222201541.11961-1-ionut.nechita@windriver.com>
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Commit 679b1874eba7 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding") introduced queue_lock acquisition
in blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks.

On RT kernels (CONFIG_PREEMPT_RT), regular spinlocks are converted to
rt_mutex (sleeping locks). When multiple MSI-X IRQ threads process I/O
completions concurrently, they contend on queue_lock in the hot path,
causing all IRQ threads to enter D (uninterruptible sleep) state. This
serializes interrupt processing completely.

Test case (MegaRAID 12GSAS with 8 MSI-X vectors on RT kernel):
- Good (v6.6.52-rt):  640 MB/s sequential read
- Bad  (v6.6.64-rt):  153 MB/s sequential read (-76% regression)
- 6-8 out of 8 MSI-X IRQ threads stuck in D-state waiting on queue_lock

The original commit message mentioned memory barriers as an alternative
approach. Use full memory barriers (smp_mb) instead of queue_lock to
provide the same ordering guarantees without sleeping in RT kernel.

Memory barriers ensure proper synchronization:
- CPU0 either sees QUEUE_FLAG_QUIESCED cleared, OR
- CPU1 sees dispatch list/sw queue bitmap updates

This maintains correctness while avoiding lock contention that causes
RT kernel IRQ threads to sleep in the I/O completion path.

Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-mq.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5da948b07058..5fb8da4958d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2292,22 +2292,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
+	/*
+	 * First lockless check to avoid unnecessary overhead.
+	 * Memory barrier below synchronizes with blk_mq_unquiesce_queue().
+	 */
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
-		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
-		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		/* Synchronize with blk_mq_unquiesce_queue() */
+		smp_mb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
-
 		if (!need_run)
 			return;
+		/* Ensure dispatch list/sw queue updates visible before execution */
+		smp_mb();
 	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
-- 
2.52.0


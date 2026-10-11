Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86D332909
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736785; cv=none; b=TEj3/OItvPT8Aa33RJe3EHog6Pb5wUKbE2SpT5W053mzpZxHE+TwPT/MubgELHlrCPRxfsKX+ci4Vr+25alfMrWSmTK5uRq5aVtTXwTNkF5vPIC3BtywAglQTH64qXffREQNJdCZz6ZAuos0rVQ/NuPmHi+i4gXSI5MuF+Tu9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736785; c=relaxed/simple;
	bh=dl5hrH+smJip14LzvfHJH3jCTVWaPluDa+G3BDxYydM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poIKM4OAL2Bpe27OwdZ48/UqTiZ/iaXtng7ucx5oqCZxew9kTeLz08znMU6FPJ593LB8oJJB796V8cyXGGfNwbGjZsWEBxVlt8k54pKFY3pEdIQEuu8TnU6x8LFnyC9y5imXUNGOiFeXkQX98tkJ3F3b52aisVnUCvMF221hQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiOh+Z+L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiOh+Z+L"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-890d52c7c7bso983457b3a.2
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791736782; x=1792341582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyWt7m8yvkMD5S5xv62WgOXim74V6tY37hkhkyC0Oj8=;
        b=BiOh+Z+LN8Oj7lEy9rFuCUAZYd/HQA7BKiBKa2fnONl5dt7QRfy9tyOpf7d8umXgu1
         SZe2tARSGhlPFBKurwy72p0fIIX2XiG/dmNgCbvMqT5XEhXUDOTkbkZhhZANXhseKYlt
         0mA0NLerw/U6Eh7UNILHORMFw67Uf+zUPS3AzC1Di+nahrBld97hHdLDqFOSqcav8kRU
         C1KCekahW470QkDVJYuVsNpib9F1tEUzVutU44h3bZnml+lpyIqdaSl6IkMbfIj9yk6H
         7XMcg8bhwmV/J+I2rxru1fvkeIZWRDe7rJH9KmKW5IQGBkpjMYLdEI0Yp0U6fgn/+xkV
         3xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736782; x=1792341582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyWt7m8yvkMD5S5xv62WgOXim74V6tY37hkhkyC0Oj8=;
        b=Vs8x2Ia3vkmmCAyGmpMdnEkFqYAV6dtqh23LtOEUqEpuvmGzhB4o6TuDOy/3L6SsD/
         SEmWgRcIJFWBgP8VZ97ghBOj9oxhKGuT9XCt8FW1sDt90rA8fIOFbbxYD3CfzgagYX1N
         eW8RcME/hXbSQ9S9AXFw31OgrwptFjAKi+WqAIBE2H3/s8t1aS/3ZMABB9hnWfgG6qU0
         RNg+lq0uVExWcMM5FQOoxjRYOGFlkLVCDtWejEqHHLQSOeKc24hqVs9YcCEMXktOAH3n
         QAYBNvYHh6BSLF2KfEkGty1NS+xv9ImavWN1D3R1crWwz/FYdzkIdqnRkkw/yWQr/MRl
         Wi/A==
X-Forwarded-Encrypted: i=1; AKwUvBz2Bs6tWGMB2KhnGanlVKuF4M+3K+jec5cv9E1x0TMqJBJJSV0NoHtN65LBK1ooguCFQy3aH9gIyEbE3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJWZE+oxf4446Pa2x+9qODJ9tK/wZHH0ECglJ7hgScWLMzv3vYa
	pcqvlosfgu8XauAx7iewe5gggJK9LubmBqOcPNDX/jCQhotJxCbJGnjI
X-Gm-Gg: AYBFou3r5eJuGMXWMOHZ1t7+mWY99A6Xuzija/bdShI0v6gAHT8WKxTwTEe7/1G0u2U
	Y/1tmlS1A6GwT1Rl1WNAa8/ax6I9eKIIT1tAAAB/hG8xvFrsoIYGgbiszt7DmFHteZafJE0EmdD
	ONYOc0RjGr2ynZdsIkPmi37rPJ/8K9sAy9DeBMk5Xm9FVpwpx5r0DrZAT/rZkJBU1K57l06vQ95
	5LsZfmmEJxjoa1eqNSTP5E16SK8ua6U72RH1RMyiD0ku5AEPLWkpcF2vfpaQSvnAN1xX3ZqQ0mw
	SPj7e7npVllKgslPster/oOa66OCtrImsbCo4pV4F3jedzMxBGf4CqgKYWBwtgEGfu/EiwIqX4N
	anaEplBM2cKPWYVCCqb2ZP/yUkUXFBK0BYG3dEysNrQYjCcc9BV1R+XQIOV/Xeu7qRy7XGH/Ees
	Ywc3F/re9f9Ruy1v9zmWzRRaqW76H0FHFteEV7vLtDzuLa2tsEqh3fQnZYC2PwH1muhZ0JjWd3
X-Received: by 2002:a05:6a00:b8d:b0:857:726d:2e96 with SMTP id d2e1a72fcca58-897c70107f9mr6888598b3a.19.1791736782085;
        Sun, 11 Oct 2026 09:39:42 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:2646::3d0:17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3106de6sm3201429b3a.14.2026.10.11.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:39:41 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+1eb53c83ab8b0a0302a6@syzkaller.appspotmail.com
Subject: [PATCH] block: release the freeze lockdep maps under mq_freeze_lock
Date: Sun, 11 Oct 2026 23:39:36 +0700
Message-ID: <20261011163936.22576-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lockdep maps taken for a queue freeze are released based on
q->mq_freeze_disk_dead and q->mq_freeze_queue_dying, which are sampled
when the outermost freeze starts. __blk_mq_unfreeze_queue() drops
mq_freeze_lock, and only afterwards the callers release the maps. In
that window the depth is already zero, so a new freezer can rewrite the
flags, e.g. del_gendisk() on a disk that owns its queue, which sets
DYING and GD_DEAD first. The old owner then skips the release and
returns to userspace with the maps still held:

  WARNING: lock held when returning to user space!
  syz.0.452/6787 is leaving the kernel with locks still held!
  2 locks held by syz.0.452/6787:
   #0: (&q->io_lockdep_map){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
   #0: (&q->io_lockdep_map){++++}-{0:0}, at: blk_throtl_init+0x1f0/0x420 block/blk-throttle.c:1332
   #1: (&q->q_lockdep_map){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
   #1: (&q->q_lockdep_map){+.+.}-{0:0}, at: blk_throtl_init+0x1f0/0x420 block/blk-throttle.c:1332

It is triggered by writing a blk-throttle limit while a null_blk device
is being removed through configfs.

Release the maps from __blk_mq_unfreeze_queue() while still holding
mq_freeze_lock, where the flags can't change. del_gendisk() then only
needs the explicit release when the queue is not unfrozen there.

Reported-by: syzbot+1eb53c83ab8b0a0302a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1eb53c83ab8b0a0302a6
Fixes: 6f491a8d4b92 ("block: track disk DEAD state automatically for modeling queue freeze lockdep")
Fixes: f6661b1d0525 ("block: track queue dying state automatically for modeling queue freeze lockdep")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Reproduced in QEMU (KASAN + lockdep). The window is tiny, so I widened it
with a 300ms msleep() after mq_freeze_lock is dropped in
blk_mq_unfreeze_queue_nomemrestore() for nullb1, while threads write
"<maj:min> 1" to blkio.throttle.write_iops_device and the main thread
toggles null_blk power via configfs. Unpatched: the warning above (2 locks
held) within ~10s. Patched, with the same delay after the unfreeze: no
warning. Only the null_blk path was tested.

---
 block/blk-mq.c | 13 +++++--------
 block/blk.h    |  2 +-
 block/genhd.c  |  8 +++++---
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..da52e3ab5c7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -208,10 +208,8 @@ void blk_mq_freeze_queue_nomemsave(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_nomemsave);
 
-bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
-	bool unfreeze;
-
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
@@ -221,16 +219,15 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
-	unfreeze = blk_unfreeze_check_owner(q);
+	/* release under the lock: a new freezer may rewrite the lockdep flags */
+	if (blk_unfreeze_check_owner(q))
+		blk_unfreeze_release_lock(q);
 	mutex_unlock(&q->mq_freeze_lock);
-
-	return unfreeze;
 }
 
 void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q)
 {
-	if (__blk_mq_unfreeze_queue(q, false))
-		blk_unfreeze_release_lock(q);
+	__blk_mq_unfreeze_queue(q, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_nomemrestore);
 
diff --git a/block/blk.h b/block/blk.h
index 50abfd932886..16388de6c541 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,7 +55,7 @@ const char *blk_status_to_tag(blk_status_t status);
 blk_status_t tag_to_blk_status(const char *tag);
 enum req_op str_to_blk_op(const char *op);
 
-bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..97dd290909c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -772,11 +772,13 @@ static void __del_gendisk(struct gendisk *disk)
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
-	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
 		__blk_mq_unfreeze_queue(q, true);
-	else if (queue_is_mq(q))
-		blk_mq_exit_queue(q);
+		return;
+	}
 
+	if (queue_is_mq(q))
+		blk_mq_exit_queue(q);
 	if (start_drain)
 		blk_unfreeze_release_lock(q);
 }
-- 
2.43.0


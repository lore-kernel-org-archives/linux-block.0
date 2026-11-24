Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497628;
	b=Jdz5nXoYxldrGr6pks4eAfsJLTLPm7I7BGBrG2ACigCtvlturWxD6+MGDHBHDI4D8u9b
	 Rb7GcPPIRYsGdgOKlsCH+w1c1RrpLGSm9p5wM6wI+Yl7Iam4oA74JlX73xY9ahXi7ymqp
	 12UJarzGfF20eoxMkkMN2g3S4XRP9tQYLgKKZzekHPpEKpuzvcA4bvwT2WLqpH6xWcyWV
	 GkOdGoG+akxNRWO2xrNhzGfAKELLgsQJt8UP3S0t69W4etEYT3rvz8LGX9y0rM2e/FMdl
	 pD7Ll0L/yEX/sjE5e04izq5/8He/O9WWk2nKmNBiQDNatdnbsKyuHPGYi2uU3HFZ4wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mVtjzQmPQKIEc4dGp9Zs/tHMBCi6CBGBAodRqCIBW78=;
	b=43LlPm/LgOwbnhhkKzQ/36px2bsI9baWt/dAyfdYhWwIrOzC2/izYQEwJ+RA1JHrh+e/
	 7e6XrauYfEEJcjYfZsdrMFobitviFgjZOmKeK0EYz1xoUx3uvVaYn3lgAONUtrh4oyHWi
	 +KKtiggLuYL362v9LHpIEy8IFfXHCfx/3upNA7zGZezkmwF6INQFP5G4ALajiIcKu6Qb4
	 15brZiSRwuCDc41Sh5V/RzYbpZpSs2ldodXrDnV8CZ9h1zFjUSiRu33qEYZi7l+nr4E1Z
	 +87ISd/rBu1olx5K3qRnYDjtneB+bTXND4PLzyUSQYzOUNrFyRbrh3XXEwE9WKF32nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUdhtoTo;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27C606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 05:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A27C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUdhtoTo
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f048476ab9so28475165ad.0
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 21:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795497627; x=1796102427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVtjzQmPQKIEc4dGp9Zs/tHMBCi6CBGBAodRqCIBW78=;
        b=dUdhtoTodP04LDlKygoQBNZjzBBCpCBROX9Ei+GIJwwEKJUXGVxd/k0FzMWlWHZVgc
         uC7k2VmwdqoE1VGIC9okJn+R18CsoB3ULWhSNzpOrvH1Ay3YchTYG7VtPnDr2lo30rXz
         O9lEOJoKYiPzVE0TtET/kyVjf80C2rWNbaFdcAKWMmRGE7Ki9CyKs/c5d/Fr1X97vgq7
         d88HUUEmUOFs2ySjUFdB5BT4t1Ke/VGDKOUsFDtj0GHlFUqh5+BzUvfPGVzDdpkgaWnR
         k+5lAiYVWk9r259Ee9aHhcKXOK+xpCs9B78mrDLlz6t3wQA65ALhvVMdeaepK+sG37Qr
         bLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497627; x=1796102427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVtjzQmPQKIEc4dGp9Zs/tHMBCi6CBGBAodRqCIBW78=;
        b=0xwFha79oo530CxjtAdoOuWwEx3NJR7FdeYtLmDZXRjAMNLZJQUudyIAIYdRCsaJMG
         LOl4vounzNy0zz7+eB+GBvao2/xdUGH5eTRn5eFrBavMq5e1q9kxMYmk1kQCYjmLtDRA
         4eL0cd9sVLzTLYhF+BIN6AMlkMdqGTjbxElIhafoe1lLBjPYwl/IjYGgvakY1YQvsh7I
         fxTJJBJ51EBFO1J7jCbigcIDR2O7DuaccVd4olJCeEK5YNZUNYqsh+m1yCf+klJZvlQW
         dFbjV5yeFA6F0sGHadf7cbqkfM8A8+l4M9dteNp6EZYnBy4bIyntkuk6B8Cto0NJTDtH
         weJQ==
X-Forwarded-Encrypted: i=1; AL+hErHO/ODku1qNfjgOIBvmFEetxn2CDa97/9yhLIOZOOTh3ED6Ac6aawfHSHNv/SMoJZk7dvfvc5ywvOsAwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9i06Xt5nno3Rg07bcR76VPmVPq77Dcm+YR9GosbQLTrvGEHnv
	L/cv00l7pJsQTrn2tdOgbfFJfc0bQ9r7Bn+I9x1fZdh57uY58YLc8rNb
X-Gm-Gg: AZFdTZfxWTGthCjlc0IAPTwZyc0ZlZ61/JSSfG4cewXrH9G5KD/LMhFwZKICUMwEtCe
	jUOr9BE4JjPXNBJHVQ+1ztFz0T910boa9q1T/EZ0hItSfOUiOKeA2rnAyRuUpI5asCR1IChB0am
	P/2cgVahASKPJk1oyAmS2lZVl9Ik8hTUK3fPq6fV4fTA9CkEb3/n2E6JxsGEvo7h8nfzY34Tg/r
	ANrK1G60pQjk2P7xDkyPt4d9JpgU/FFPcidVFhxpPPR1bY10bgwnZ82pg+JWk5CQIO/ZE/Eb1Nn
	UrFxkHuti9hD24yIoqkTMPsXC9X/IMes16VqHlRjtK4vLAH9eHfpTDGy5TYFW8+91syeNEX9nEP
	RwvUCjI9QzTwjCf8jlqWafjovE06N6p/OWJPv1zIJYo9e183ylkGcrySmeoV/uFar7OhNVxSy92
	Osd3LVhoSeB27NLU6svalTyJk/1FarN2/JiPyrvNpLwJNRIlTwV9byMEcQaatvjmWs+w3papelc
	yBWkDt4nfbybPx8e+x6ZJtUIMmhceNDvW3M5PluVR6CBCiBVXmFeBwSTqdNmkkrSytI4IcMEs7e
	33IdxAl8Iahc9K3jDXKmBh9x1SEKy+yM
X-Received: by 2002:a17:903:19cb:b0:2f0:3d60:9165 with SMTP id d9443c01a7336-2f03f0fcd4dmr130546855ad.11.1795497627540;
        Mon, 23 Nov 2026 21:20:27 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac1:7ac0:e88::247:18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a74sm65038495ad.12.2026.11.23.21.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 21:20:27 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org,
	syzbot+48ca80a8587c1d97c433@syzkaller.appspotmail.com
Subject: [PATCH] block: release freeze lockdep map under mq_freeze_lock
Date: Tue, 24 Nov 2026 12:20:23 +0700
Message-ID: <20261124052023.63506-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The outermost freezer records the lockdep state of the queue in
q->mq_freeze_disk_dead and q->mq_freeze_queue_dying, and the unfreeze
path checks them again to decide which lockdep maps to release.  That
check runs in blk_mq_unfreeze_queue_nomemrestore() after
__blk_mq_unfreeze_queue() has dropped mq_freeze_lock.  At that point
mq_freeze_depth may already be zero, so another task can start a new
freeze and overwrite both flags before the old owner reads them.

syzbot hits this with device-mapper: DM_TABLE_LOAD calls add_disk() and
freezes the queue in elevator_change() while the queue is still alive,
so q_lockdep_map is acquired.  A concurrent DM_DEV_REMOVE calls
blk_mark_disk_dead(), which sets QUEUE_FLAG_DYING and starts a new
freeze right after the elevator unfreeze drops mq_freeze_lock.  The new
freeze sets mq_freeze_queue_dying, the old owner skips
rwsem_release(), and lockdep reports:

  WARNING: lock held when returning to user space!
  #0: (&q->q_usage_counter(queue)#22){+.+.}-{0:0}, at: elevator_change+0x194/0x480

Release the lockdep maps in __blk_mq_unfreeze_queue() while
mq_freeze_lock is still held, so a new freezer cannot change the flags
first.  __del_gendisk() now relies on that release in its unfreeze
branch.  In its GD_OWNS_QUEUE branch the queue stays frozen, so it
still releases the maps directly.

Fixes: f6661b1d0525 ("block: track queue dying state automatically for modeling queue freeze lockdep")
Reported-by: syzbot+48ca80a8587c1d97c433@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48ca80a8587c1d97c433
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (x86_64, 4 vCPUs, PROVE_LOCKING) with a C reproducer that
races DM_TABLE_LOAD of a request-based multipath table against
DM_DEV_REMOVE.  With a debug-only msleep(5) right after mutex_unlock() in
__blk_mq_unfreeze_queue() to widen the window:

  base: 3/3 runs hit "lock held when returning to user space" within 1s
  fix:  5/5 runs clean for 120s (~7.5k load/remove collisions each)

Without the delay, the fixed kernel ran 2x120s clean (~5k collisions
each) with debug_locks still 1.

 block/blk-mq.c | 16 ++++++++--------
 block/blk.h    |  2 +-
 block/genhd.c  | 14 ++++++++------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54ccfc43c27c2..11abb296c3bb4 100644
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
@@ -221,16 +219,18 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
-	unfreeze = blk_unfreeze_check_owner(q);
+	/*
+	 * Release under mq_freeze_lock: once it is dropped, a new freezer may
+	 * overwrite the mq_freeze_{disk_dead,queue_dying} flags it checks.
+	 */
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
index 105fff157bfbd..13648d3483930 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,7 +55,7 @@ const char *blk_status_to_tag(blk_status_t status);
 bool tag_to_blk_status(const char *tag, blk_status_t *status);
 enum req_op str_to_blk_op(const char *op);
 
-bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
diff --git a/block/genhd.c b/block/genhd.c
index 69204d44adae1..2f478f320aa48 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -772,13 +772,15 @@ static void __del_gendisk(struct gendisk *disk)
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
-	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
 		__blk_mq_unfreeze_queue(q, true);
-	else if (queue_is_mq(q))
-		blk_mq_exit_queue(q);
-
-	if (start_drain)
-		blk_unfreeze_release_lock(q);
+	} else {
+		if (queue_is_mq(q))
+			blk_mq_exit_queue(q);
+		/* still frozen, so the freeze flags are stable */
+		if (start_drain)
+			blk_unfreeze_release_lock(q);
+	}
 }
 
 static void disable_elv_switch(struct request_queue *q)
-- 
2.43.0


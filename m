Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD442214A9B;
	Wed, 22 Jul 2026 03:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690375; cv=none; b=s2NQmYf0BV8Del6FOO+IgBFfUmGJqAxLKbWn0i8HQxox79jp6nLz5L/qgEf0v4IwUXBGM2uvlKgFAfUDoiGhmZyleS2MCAYWzYkLQSKfI8un+WLNh3N/xiR+Q3nou+57HTb3zuOxXN7PvvkQQrcI5GKl2nwA+5OCZHReMkGMVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690375; c=relaxed/simple;
	bh=nDf+vYOIeQDAMqzBUMHPkjbOGcT3WO3h0OAi7R/XQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcKC+ikVtcGYsek11gOPPr/NlbzEsXt1gxfPcVJdlZJLooFMuvA+kVU6A3YFnvLTLJdPbN5zXo/qnhrQLh7AR87Tvn5wKlETBXKGtlBI9DxQ/4KlSaHGac02S3H9aTeBAOCqDQWMPRdAyXSBJCJce1Z4QEx9rt/3Y/cS47cCoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 22b0a204857c11f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:39252bc1-79fe-456e-9a2c-c7cfc5b5d928,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:91a7fb767f8edd80604abc8f2047e50e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22b0a204857c11f1aa26b74ffac11d73-20260722
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1772511243; Wed, 22 Jul 2026 11:19:22 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1] block/mq-deadline: hold elevator_lock in debugfs next_rq show
Date: Tue, 21 Jul 2026 14:30:32 +0800
Message-ID: <2e689b2c4021.1784615432.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

deadline_*_next_rq_show() dereferences q->elevator->elevator_data without
holding elevator_lock.  Concurrent elevator switch to "none" clears
q->elevator under that lock and tears down the scheduler, so readers
crash with a null-ptr-deref.

Hold elevator_lock around the show path and bail out if the elevator has
already been removed, matching other blk-mq debugfs readers that look at
elevator state.

Reproduced on linux-next with KASAN by reading write1_next_rq via debugfs
while switching the elevator from mq-deadline to none under fio load:

 BUG: KASAN: null-ptr-deref in deadline_write1_next_rq_show+0x3c/0xf0
 Read of size 8 at addr 0000000000000010 by task cat/140857
 Call trace:
  deadline_write1_next_rq_show+0x3c/0xf0
  blk_mq_debugfs_show+0x58/0x78
  seq_read_iter+0x254/0x6f8
  seq_read+0x1a0/0x220
  vfs_read+0x14c/0x528

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 block/mq-deadline.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 824bfc17b2c6..e7c4a91b2d08 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -842,14 +842,22 @@ static int deadline_##name##_next_rq_show(void *data,			\
 					  struct seq_file *m)		\
 {									\
 	struct request_queue *q = data;					\
-	struct deadline_data *dd = q->elevator->elevator_data;		\
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
+	struct elevator_queue *e;					\
+	struct deadline_data *dd;					\
+	struct dd_per_prio *per_prio;					\
 	struct request *rq;						\
+	int ret;							\
 									\
+	ret = mutex_lock_interruptible(&q->elevator_lock);		\
+	if (ret)							\
+		return ret;						\
+	e = q->elevator;						\
+	if (!e)								\
+		goto unlock;						\
+	dd = e->elevator_data;						\
+	per_prio = &dd->per_prio[prio];					\
 	rq = deadline_from_pos(per_prio, data_dir,			\
 			       per_prio->latest_pos[data_dir]);		\
 	if (rq)								\
 		__blk_mq_debugfs_rq_show(m, rq);			\
+unlock:									\
+	mutex_unlock(&q->elevator_lock);				\
 	return 0;							\
 }
 
-- 
2.43.0


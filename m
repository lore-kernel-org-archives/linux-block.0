Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0941A840A
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171123; cv=none; b=HD6Y7NFZz3oI3WoXmxNDgbtIBQOdHqkL4Vn1GgHEL3g12YIXVSHnxomZ6d8WFgB15sdZCb/x2vQhFoveJKsU5EShvbmCplPRhAiQ5bhIERSWrBSYy8rc4DoTKu7/V8JrxT3ZNljO4LAiS5mwkx38IBZCEsuI8tRduHlGZfXSQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171123; c=relaxed/simple;
	bh=aeM7O4lphlkhJ3T9qJ9dEiElr+wJetBu/4Ui8Le+7y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAdtFOVGkgHtP9ctn2Mtr/bZDhY1zf280nCFWD5X5I19snjUZNps7p9JTjjW87N3cCh6xCGMVD/MvvnMf6v7idAtkRQljVzSpxunh/VDQoq1IplEC2qKTNiXECwYbaYiML9xiYzQSjAvvIf+TKb8zCdTA5bQeFQJkvXO0a9cGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A52C19421;
	Wed, 31 Dec 2025 08:52:01 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 15/16] blk-rq-qos: remove queue frozen from rq_qos_del()
Date: Wed, 31 Dec 2025 16:51:25 +0800
Message-ID: <20251231085126.205310-16-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231085126.205310-1-yukuai@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the one hand, nest q_usage_counter under rq_qos_mutex is wrong;
On the other hand, rq_qos_del() is only called from error path of
iocost/iolatency, where queue is already frozen, hence freeze queue
here doesn't make sense.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-rq-qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 20d8e53f063e..44d15aa09e27 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -347,11 +347,10 @@ void rq_qos_del(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
 	struct rq_qos **cur;
-	unsigned int memflags;
 
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->rq_qos_mutex);
 
-	memflags = blk_mq_freeze_queue(q);
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
@@ -360,5 +359,4 @@ void rq_qos_del(struct rq_qos *rqos)
 	}
 	if (!q->rq_qos)
 		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
-	blk_mq_unfreeze_queue(q, memflags);
 }
-- 
2.51.0


Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03992DE6EB
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488746; cv=none; b=tLEBgv3RCqNeNalNp8Z4eKnPhebgcANXE4cmaC1LqJWoL8L+ZErPzOGVrj7g/6T3f2+AzInNtgaEgUSpi5m4r0w7b/a2QgylC/yuaDBAWKeEoqx/gcy8XSnRgRpOKC9ubRbTUAjetbPTMNmBASbrFbQ+5a9jfreldv9amNt/Wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488746; c=relaxed/simple;
	bh=8vsM1GbHXCsXRBZzNoVfmHzN9834N1CprVpPXZrNhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+rz42xZCPvNL3gtTWB8ypQRLuL9sddjicKraHw0gm5wx59HEDqiKMBlxP464eolPr4uk+QIxT5s+oJLvSZAFB6zc9fw81jWn31N6pPsPF0qtImgXVhAmPGWfizM4Ob/KDhzEIOGx86id0/GYTWeqfNfS4tLKGp1D6APSK0p14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DP2otu/9; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DP2otu/9"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWvq6vyxzm0dhj;
	Wed,  2 Jul 2025 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488742; x=1754080743; bh=dn2g3
	RsXeCvYhhZv7/Q2Fdj/r5cQmNWJxvLuLTxXEYw=; b=DP2otu/9pkxYdwkJFD2jN
	cjHwDfVMJURJEN0Q5jl70ZaZjiS4vYbZtBekno9ocZ/DbSJOx4/8FE5LVv4fcFWq
	zDdG7lqsBBvp47HqcpakNWMQH7oKdEdFgcoAjKwjBO1eDDvIDwF7vRZ2jcrqSWEQ
	zOjrBfW9EhPqJSYGOQFc9MyX9pBq4Mv6kbTkaNNxKoCPN1e31UgHCPyGLd8gnrLm
	+WZnpcYUWSmJAAKFYI/8294dDug7Gg9K1H7hWn7mKxSkONYwaBjwc7xx3LOVqQMT
	+Ucy/34PaOG2w91WV+1LsliGsJbYyHgRa71lHvFQVu+QST3r5e1k6t+vzq2KvL50
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W02NzB05vFV7; Wed,  2 Jul 2025 20:39:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWvl0td3zm0gcJ;
	Wed,  2 Jul 2025 20:38:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/8] block: Introduce QUEUE_FLAG_FROZEN
Date: Wed,  2 Jul 2025 13:38:36 -0700
Message-ID: <20250702203845.3844510-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for checking whether or not a request queue is frozen from the ho=
t
path with a minimal performance overhead.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       | 1 +
 block/blk-mq.c         | 1 +
 include/linux/blkdev.h | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..001a4ac997ae 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -376,6 +376,7 @@ static void blk_queue_usage_counter_release(struct pe=
rcpu_ref *ref)
 	struct request_queue *q =3D
 		container_of(ref, struct request_queue, q_usage_counter);
=20
+	blk_queue_flag_set(QUEUE_FLAG_FROZEN, q);
 	wake_up_all(&q->mq_freeze_wq);
 }
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0c61492724d2..7919607c1aeb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -218,6 +218,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q,=
 bool force_atomic)
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
+		blk_queue_flag_clear(QUEUE_FLAG_FROZEN, q);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 	unfreeze =3D blk_unfreeze_check_owner(q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a51f92b6c340..77b9067d621a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -641,6 +641,7 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
+	QUEUE_FLAG_FROZEN,		/* queue has been frozen */
 	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
@@ -676,6 +677,7 @@ void blk_queue_flag_clear(unsigned int flag, struct r=
equest_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
+#define blk_queue_frozen(q)	test_bit(QUEUE_FLAG_FROZEN, &(q)->queue_flag=
s)
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_=
flags)
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->qu=
eue_flags)

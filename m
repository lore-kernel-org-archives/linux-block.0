Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805835FB86;
	Fri, 22 Mar 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129260; cv=none; b=deoi59Tbnae4d0mpwMs/tRp9qe92gbPpLI2tLVPE6dWTSgNm4unhSIiRquq6LbVp9fpk9Y55xPe2EfhNh26Ym/ybzT6RnBTIO6DuHjOksEKfZwim3aRMu1UutpN5O9iOXH4R+iAEgTefGLnPFhl9mSZw8E2xuMjb7FLvzWsyPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129260; c=relaxed/simple;
	bh=hUUZk0R0PklOcj1oYkJC2u/GzExzR1VpkkAZTNMFvYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhciXvWF8gWTzsBXwexrj4Pjj0v/Uu2S1b91Kih6KXR4hxXJbxBbLqKUftO1EZvRBF4MnJ5uSbzIoYkl8WleVOTHXN8ymhBi4Hxs0iLHr1TEeh+89GpJsvX9pPYpnBiyBJnsVATLHAV8GbIx9uJNQKAmH0vOzJDfX5SFu1NmwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3BUT3iqW; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3BUT3iqW"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V1V3s5kJTz6Cnk95;
	Fri, 22 Mar 2024 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1711129251; x=1713721252; bh=Qqz9pnUZk4VENbBV5sZn2Phs3CDKV7Ml0ZC
	g9USpZEg=; b=3BUT3iqWpS7rsVhRcht6YBVLhS4Yi7oDCH1Smci86A8PRCumJXM
	euOzoMcWdDYKDbqiECNeNFnJXp44+YveZHXZhLv1xDzEqLpQIzCfKTkjBHAaQ6Dr
	+sEesZHXz4rxHraOWJuNMApi8fGo4Cm7sHF4/d46ub0UXf/KSoVaMor/qj983yIC
	dNSxCewKq6tvkkqAK2g7NMu5WTK8k9BDEUOdcZWZhKfVMg3TReOnTiJR3vXZb3rY
	rIv4vDN/vOgSzWpXVDsW6loU1+bpPQ17veHxEA/wwrS3DB3YTCn3uh7btop0dH2L
	IHc3aNTuubzv4jcoK9g7A8c7xocsc9gvAVw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tauoE5ubG2xo; Fri, 22 Mar 2024 17:40:51 +0000 (UTC)
Received: from bvanassche-linux.mtv.corp.google.com (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V1V3j3cbcz6Cnk94;
	Fri, 22 Mar 2024 17:40:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	kernel test robot <oliver.sang@intel.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] blk-mq: release scheduler resource when request completes
Date: Fri, 22 Mar 2024 10:40:14 -0700
Message-ID: <20240322174014.373323-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Chengming Zhou <zhouchengming@bytedance.com>

commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf upstream.

Chuck reported [1] an IO hang problem on NFS exports that reside on SATA
devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
submission path for post-flush requests").

We analysed the IO hang problem, found there are two postflush requests
waiting for each other.

The first postflush request completed the REQ_FSEQ_DATA sequence, so go t=
o
the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
failed to blk_kick_flush() because of the second postflush request which
is inflight waiting in scheduler queue.

The second postflush waiting in scheduler queue can't be dispatched becau=
se
the first postflush hasn't released scheduler resource even though it has
completed by itself.

Fix it by releasing scheduler resource when the first postflush request
completed, so the second postflush can be dispatched and completed, then
make blk_kick_flush() succeed.

While at it, remove the check for e->ops.finish_request, as all
schedulers set that. Reaffirm this requirement by adding a WARN_ON_ONCE()
at scheduler registration time, just like we do for insert_requests and
dispatch_request.

[1] https://lore.kernel.org/all/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@orac=
le.com/

Link: https://lore.kernel.org/linux-block/20230819031206.2744005-1-chengm=
ing.zhou@linux.dev/
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@=
intel.com
Fixes: 615939a2ae73 ("blk-mq: defer to the normal submission path for pos=
t-flush requests")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20230813152325.3017343-1-chengming.zhou@l=
inux.dev
[axboe: folded in incremental fix and added tags]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bvanassche: changed RQF_USE_SCHED into RQF_ELVPRIV; restored the
finish_request pointer check before calling finish_request and removed
the new warning from the elevator code. This patch fixes an I/O hang
when submitting a REQ_FUA request to a request queue for a zoned block
device for which FUA has been disabled (QUEUE_FLAG_FUA is not set).]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ed6b9469f97..07610505c177 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -675,6 +675,22 @@ struct request *blk_mq_alloc_request_hctx(struct req=
uest_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
=20
+static void blk_mq_finish_request(struct request *rq)
+{
+	struct request_queue *q =3D rq->q;
+
+	if ((rq->rq_flags & RQF_ELVPRIV) &&
+	    q->elevator->type->ops.finish_request) {
+		q->elevator->type->ops.finish_request(rq);
+		/*
+		 * For postflush request that may need to be
+		 * completed twice, we should clear this flag
+		 * to avoid double finish_request() on the rq.
+		 */
+		rq->rq_flags &=3D ~RQF_ELVPRIV;
+	}
+}
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q =3D rq->q;
@@ -701,9 +717,7 @@ void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q =3D rq->q;
=20
-	if ((rq->rq_flags & RQF_ELVPRIV) &&
-	    q->elevator->type->ops.finish_request)
-		q->elevator->type->ops.finish_request(rq);
+	blk_mq_finish_request(rq);
=20
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
@@ -1025,6 +1039,8 @@ inline void __blk_mq_end_request(struct request *rq=
, blk_status_t error)
 	if (blk_mq_need_time_stamp(rq))
 		__blk_mq_end_request_acct(rq, ktime_get_ns());
=20
+	blk_mq_finish_request(rq);
+
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
 		if (rq->end_io(rq, error) =3D=3D RQ_END_IO_FREE)
@@ -1079,6 +1095,8 @@ void blk_mq_end_request_batch(struct io_comp_batch =
*iob)
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
=20
+		blk_mq_finish_request(rq);
+
 		rq_qos_done(rq->q, rq);
=20
 		/*

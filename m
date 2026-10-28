Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231383;
	b=3r4RM7uco0lW0qS7ZRzpZDIo85SzYw+fJ1q9s+nVylUjJDPL1M1jZtvvA7chT6n9BBK/
	 KS+4X4cLy97glK0d3AI4egIRQccaqeOYJdP+EYt2BBG0CV1CnPL4xVhfl/vwArUPSrs9g
	 MtqTstfu4dn6tOp37AGWLehaxqO0BnPapWcHR9FB1tZT90jg/etQrHTaKrnnrwLzeP9gc
	 VCcjS1kJVazrhJ2ZKHi+64lLouhHkMjr0aGbxuNMiYzHsQzXYVQpoyuZ5ZOG5lbpI/rVi
	 98ORiKPeKoIZSV4+xgwab/Zun9dwCRFph7Yu4MWMtkMSndnjkiVtdgRl2m1EQaktU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ex6YOu7e9L89CbVLpgJNSRno9vfswRWpN3f8iIESdN8=;
	b=TpVLZ/46zH/RPdUMoeC1aT/mImT8f+Bo8sZ9g5/6SBlPWBaEiGRg1TV/7ZJ2oYaB8cmu
	 gDRoAz3PxHQFyI/E7eq2mp9gDSaggwusDLziRjaWxL43Yu9m1pVxvyOEuIw/P/PPTnS5F
	 rYvC1/ODDhKxMt22FPQ++UrTRHNk3+9BT/pDPtoYbgjxOmD2w+XmXZLP3tGgHilIDreq/
	 YdWRwr2Um4QtIJGPCNPMJAzHBXJSQ2UphCGpz11prHwFAdkyoZ2iEq5tdbQnm6XGJE9BN
	 s5UVym/f9OJV2PpBjClwS0JDzY4FZp631N68RXoCElcPUQd7d1DTcwVDm2Tq4CCTKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=X+GHvJVE;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F0606A320
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405F0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=X+GHvJVE
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGt5mJyzlfvpy;
	Wed, 28 Oct 2026 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231376; x=1795823377; bh=ex6YO
	u7e9L89CbVLpgJNSRno9vfswRWpN3f8iIESdN8=; b=X+GHvJVElavJqDhkI68/P
	gApjpBPludKUjEiQezKRCZ4WctSPOI18Tl5M0FB/8FTa7L2Lu8GxOfY5r1rI+82r
	0dDtJ+bQsj340CWONfuJKKFoXiu0Lrj/tE55DL/pchlMlqWeOArtwzQjF7nR9jkt
	I2kDSn7WjCzwJW0scRIQ2fo/SC3pqEt7k226wTl7xHb238fDIlvn80S/zSS4PzZt
	1aBdlzgBfg7iWM45mwdilKZzVJntzuCJUrJO3vYCCLk2k+iGYaDrDpZnUL0hMqeX
	4j1nFv3ZIi0sQIRP4hB/U/POTUXK7KCBjGNVmq3XeYhJl7orcUCkcFOHj47xQ7Fi
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EPtD3IlFFG9x; Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGk6YrJzlfvpc;
	Wed, 28 Oct 2026 23:49:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 97/98] nvmet-rdma: hold sq->ref to post a T10-PI Read's SEND
Date: Wed, 28 Oct 2026 16:49:14 -0700
Message-ID: <20261028234917.3067347-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-98-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-98-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:42, Jens Axboe wrote:
> +	if (unlikely(!percpu_ref_tryget_live(&queue->nvme_sq.ref))) {
> +		nvmet_rdma_release_rsp(rsp);
> +		return;
> +	}
> +
>  	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
>  		pr_err("sending cmd response failed\n");
>  		nvmet_rdma_release_rsp(rsp);
>  	}
> +
> +	percpu_ref_put(&queue->nvme_sq.ref);

In nvmet_rdma_free_queue(), nvmet_sq_destroy(&queue->nvme_sq) calls
percpu_ref_exit(&sq->ref) before nvmet_rdma_destroy_queue_ib() calls
ib_drain_qp(queue->qp). Because nvmet_req_complete() still drops sq->ref
immediately after posting &rsp->write_cqe, nvmet_sq_destroy() can reach
percpu_ref_exit(&queue->nvme_sq.ref) while the T10-PI RDMA WRITE is in
flight, and nvmet_rdma_write_data_done() will then call
percpu_ref_tryget_live() concurrently with or after percpu_ref_exit().

percpu_ref_tryget_live() is only valid between percpu_ref_init() and
percpu_ref_exit(): __percpu_ref_exit() and percpu_ref_exit() perform
unmarked writes to ref->percpu_count_ptr that race under KCSAN with
percpu_ref_tryget_live_rcu()'s unmarked read. (As a side note, patch
96/98 has the same tryget_live-vs-exit issue in nvmet_rdma_error_comp()
and should also be folded into patch 69/98.)

Here we do not need percpu_ref_tryget_live() at all:
nvmet_rdma_queue_response() runs while the request's own sq->ref is
still held, so it can take an extra percpu_ref_get() on
queue->nvme_sq.ref when preparing a T10-PI RDMA WRITE and drop it either
on synchronous ib_post_send() failure or at the end of
nvmet_rdma_write_data_done(). Because __nvmet_rdma_queue_disconnect()
calls rdma_disconnect() (transitioning the QP to IB_QPS_ERR and flushing
outstanding WRs) before scheduling release_work -> nvmet_sq_destroy(),
holding sq->ref across the RDMA WRITE cannot block disconnect and keeps
sq->ref live until the SEND has been posted.

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 994a668f45d6..ec54e3706e6c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -758,6 +758,7 @@ static void nvmet_rdma_queue_response(struct nvmet_re=
q *req)
 		container_of(req, struct nvmet_rdma_rsp, req);
 	struct rdma_cm_id *cm_id =3D rsp->queue->cm_id;
 	struct ib_send_wr *first_wr;
+	bool hold_sq =3D false;
=20
 	if (rsp->invalidate_rkey) {
 		rsp->send_wr.opcode =3D IB_WR_SEND_WITH_INV;
@@ -767,12 +768,20 @@ static void nvmet_rdma_queue_response(struct nvmet_=
req *req)
 	}
=20
 	if (nvmet_rdma_need_data_out(rsp)) {
-		if (rsp->req.metadata_len)
+		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+		    rsp->req.metadata_len) {
+			/*
+			 * Hold sq->ref until nvmet_rdma_write_data_done()
+			 * posts the SEND ahead of ib_drain_qp().
+			 */
+			percpu_ref_get(&rsp->queue->nvme_sq.ref);
+			hold_sq =3D true;
 			first_wr =3D rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
 					cm_id->port_num, &rsp->write_cqe, NULL);
-		else
+		} else {
 			first_wr =3D rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
 					cm_id->port_num, NULL, &rsp->send_wr);
+		}
 	} else {
 		first_wr =3D &rsp->send_wr;
 	}
@@ -786,6 +795,8 @@ static void nvmet_rdma_queue_response(struct nvmet_re=
q *req)
 	if (unlikely(ib_post_send(cm_id->qp, first_wr, NULL))) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
+		if (hold_sq)
+			percpu_ref_put(&rsp->queue->nvme_sq.ref);
 	}
 }
=20
@@ -849,6 +860,7 @@ static void nvmet_rdma_write_data_done(struct ib_cq *=
cq, struct ib_wc *wc)
 				ib_wc_status_msg(wc->status), wc->status);
 			nvmet_rdma_error_comp(queue);
 		}
+		percpu_ref_put(&queue->nvme_sq.ref);
 		return;
 	}
=20
@@ -866,6 +878,7 @@ static void nvmet_rdma_write_data_done(struct ib_cq *=
cq, struct ib_wc *wc)
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
 	}
+	percpu_ref_put(&queue->nvme_sq.ref);
 }
=20
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len=
,

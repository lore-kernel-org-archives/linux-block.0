Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030158;
	b=nz4Xw4sKYlg+ca+36vF5XTNBQzm7OHPJag+45xtuBJrY79+zeWzRPm99vCiwUM7hAVWh
	 qQUQwuN+dfCFwT8iPxsSeuRpWImWoZF0yOFZVVlEaDtuJY0fdqQ1rKhc/p0KYsIW2Ag6X
	 5rwTV7gysJgZgkTl2IGGUk1ndoBt6UMYTirk+LPzyZDwiC7amDStqoOrQqgzjcId0AKCK
	 z9X+fMup5atjZ4Cbt/paEAT0UlU1R2Q0LVGiDkk3pOxUhqQJXs/BOrTyYgnxHCS9WoAZb
	 Hbbqfhkarvazhdz/P7XO4MoKA6z4+Am7bCXKLpp2lVi7VPU2NlK0hkVQfzXHrdMZB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030158;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=saGdpj4r3L96cDSsR2+wXxIGDapfklTmNU2pm+8TxUw=;
	b=xxMDOP3B64Yza5WovfCuWR2g2K65OY2RhclDmdvvjdVsv8OnTV5AHijb1uf2ht4OPUqS
	 k7Ega5qNhdAvoHt1rg0S4hbPAC7Uu+wgsR6M0XZ88uHuQMxU/PxO0Xq+mYLDdMXLZwPoh
	 gp9xSKu3BAygFU/Oms9+XuWsyKaWaNlHZ8UKmmjzRwwlfDCj6270TnXoJQTRpFxndkH0P
	 teJBDCzEP4DtQ1hoxJzp4TWK7EA19/5agAvtEXPIA5cqg+ePEEO0rLi67Cz8as7tZykmW
	 r1hdBo68aVNPZSEV6bvIDk5Uww8wk35nx+jtAgZPL2U2SMBsoz/Cv6ETeR2Wdyh7Imw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=p8G9gPpb;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7861606C709;
	Wed, 18 Nov 2026 19:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7861606C709
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=p8G9gPpb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=saGdpj4r3L96cDSsR2+wXxIGDapfklTmNU2pm+8TxUw=; t=1795030157; x=1795894157; 
	b=p8G9gPpb4gjdfab3+A2OwF7P2YZEd8tTuQU1zW+KlAd2OZ6S0yH8LG0pS8FZGdYvJZR40tByma9
	GbeRo3VEBWf799YSGwVxXDB6FfyQ5mldSvOJ9TQXaRDZ1h/gLD2JFMQi/xfN6BIkAZQS6fnL/ZWo3
	UUsbP/PsH04M19HucQIz2rFmmPx8l9DaYgBXnK3iDi5lmxlEeL5tlWjTlfroae2o6TjvhhrXt/ruC
	vMFxAeut5e4upEggfknHkXkLtTxcWC5d5bm+yTT8io5vvmoyXWdp+RF9TwhYN0i7T+xs00ANT9WX+
	2HeIZvtKGju88ApwY1eCV9akH0azSOstq4Vw==;
Received: from [49.207.212.66] (helo=[127.0.1.1])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xTlLB-00HZUt-Vn;
	Wed, 18 Nov 2026 14:29:10 -0500
From: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Date: Thu, 19 Nov 2026 00:58:44 +0530
Subject: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
X-B4-Tracking: v=1; b=H4sIAGv8/WoC/x2MWw5AMBAAryL7bRMlnlcRH6VbNqpoEYm4u8bnT
 DLzgCfH5KGJHnB0sefVBhBxBMMk7UjIKjCkSVoIISrUfGNvZlx2tKcxuB0OFTnSWOqsLAaVS1U
 nEPotSL7/d9u97wf7WD3tawAAAA==
To: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, 
 "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
X-Mailer: b4 0.13.0

Add NULL pointer validation in blk_mq_complete_request_remote() to
prevent kernel crashes when block drivers pass freed request structures.

When NVMe devices experience hardware failures or firmware bugs,
completion queue corruption can occur, leading to scenarios where
drivers attempt to complete already-freed requests. The NVMe genctr
validation in nvme_find_rq() catches most stale completions, but when
corruption produces a command_id whose genctr bits happen to match,
the freed request passes validation and reaches the block layer. The
block layer's __blk_mq_free_request() sets rq->mq_hctx to NULL,
but blk_mq_complete_request_remote() lacks validation before
dereferencing this pointer.

This manifests as a kernel crash like shown below (the stack trace
was obtained from a crash observed in a Linux VM on Hyper-V):

  nvme nvme0: resetting controller due to AER
  nvme nvme0: request 0xe3 genctr mismatch (got 0x0 expected 0x5)
  nvme nvme0: invalid id 227 completed on queue 6
  nvme nvme0: request 0x26 genctr mismatch (got 0xb expected 0x9)
  nvme nvme0: invalid id 45094 completed on queue 94

  BUG: kernel NULL pointer dereference, address: 00000000000000fe
  RIP: 0010:blk_mq_complete_request_remote+0x1b/0x150
  Call Trace:
   <IRQ>
   nvme_irq+0x182/0x320 [nvme]
   __handle_irq_event_percpu+0x47/0x180
   handle_irq_event+0x38/0x60
   handle_edge_irq+0x87/0x1a0
   __common_interrupt+0x3f/0xa0
   common_interrupt+0x42/0xa0

The crash occurs at offset 0xfe when accessing rq->mq_hctx->nr_ctx,
where mq_hctx is NULL.

Add a NULL check that returns true (signaling to callers that the
request has been handled) to gracefully drop freed requests, with a
WARN_ONCE to flag the condition for diagnosis.

Fixes: 40d09b53bfc5 ("blk-mq: add a new blk_mq_complete_request_remote API")
Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
---
I'd like to call out a few unresolved aspects about this patch for
review attention:

1. I'm not sure if the NULL ptr check should be placed before or after
the rq->state update to MQ_RQ_COMPLETE. Do we need to update that
state even if we don't proceed with the complete-request operation?

2. While this was a real bug that I hit in one of my systems, I don't
have a way to repro that same scenario anymore (i.e., hardware/firmware
bug that introduces the corruption), so validating this kernel fix
against the original crash has been a bit of a challenge.

Still, I wanted to post this patch to report the bug and seek guidance
on how best to fix it and harden blk-mq against this NULL ptr dereference.

Thank you!
---
 block/blk-mq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..5dc9d7d806b5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1307,6 +1307,15 @@ static void blk_mq_raise_softirq(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	/*
+	 * Validate request is not freed (__blk_mq_free_request() sets
+	 * mq_hctx = NULL).
+	 */
+	if (unlikely(!rq->mq_hctx)) {
+		WARN_ONCE(1, "%s: attempt to complete freed request", __func__);
+		return true;
+	}
+
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*

---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261118-fix-blk-mq-null-ptr-deref-7f376cd5ad90

Regards,
Srivatsa


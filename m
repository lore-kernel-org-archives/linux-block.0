Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C314CA27E;
	Wed, 14 Oct 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964020; cv=none; b=iTyCYs8WLSsL9QoxqfbbfhjL2qLVUmeWcg4HcD52e/CIA6WBaxFiLg15rfCL/vEnAlhL1uzPZul3DXorJB58puIZuC0BP5clx34EJsYaTQy/Bn7g8FxKXLBMitn2CL4Q3crV9QVwrA6a56Sye7/GFnaPPz5EedXXxJqR6FnI0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964020; c=relaxed/simple;
	bh=3DEo33YUDuQwvPKQ2f8xQGwPaPDI7kPE/XscXAKMfU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdXQwGIyNKR9EcYIb1OV0okYMLpCbd6BUTVtoO29KSElqzBzM0x6gZsSH6lKqZ/4ubgK23xtxfZTCJj2x2An0YGgC1Etrpclwcvs7u4pasZSa/juWF8Z8+tOYk3YRbJLDnM7hjkfg0vzZlsW2FJsxyRR152ENCLX7PmOWNQgBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1rKGJwfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=itqyUvXd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1rKGJwfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=itqyUvXd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1rKGJwfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itqyUvXd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1rKGJwfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itqyUvXd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEF1E1F7C9;
	Wed, 14 Oct 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=1rKGJwfLGtGUtPKk7PG1ULitToQnzBBj5E2n40XaDTjMG37x5oXj10u8q3AymyafFuziel
	+QBHDSFBTlJWBpu8EYyDBDt61mzAn3BiiuMCwtEw/HcYlmxmCzxbI6NBSknY3Kk01wNskp
	70bADXAfFnf2JAMOYv8a5ryOc7/B/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=itqyUvXdYVJce8n7XuWNC8k1ho6fD/j2YyFx6uQpCC0Pz8ZzNJFmicdFYSusHW1LHU9k4h
	P++Rm69CjHGXWtAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=1rKGJwfLGtGUtPKk7PG1ULitToQnzBBj5E2n40XaDTjMG37x5oXj10u8q3AymyafFuziel
	+QBHDSFBTlJWBpu8EYyDBDt61mzAn3BiiuMCwtEw/HcYlmxmCzxbI6NBSknY3Kk01wNskp
	70bADXAfFnf2JAMOYv8a5ryOc7/B/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=itqyUvXdYVJce8n7XuWNC8k1ho6fD/j2YyFx6uQpCC0Pz8ZzNJFmicdFYSusHW1LHU9k4h
	P++Rm69CjHGXWtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0958133F1;
	Wed, 14 Oct 2026 07:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Gk6JXAzz2qyOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:56 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:40 +0200
Subject: [PATCH 2/5] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-2-355156be27b2@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>, 
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Aaron Tomlin <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL67935bhfdkbndpbo95z3ogoo)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

From: Daniel Wagner <wagi@kernel.org>

Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs") isolated CPUs are removed from hctx->cpumask.  That
commit assumed the mask is only used for kworker placement and CPU
offline handling, but blk_mq_alloc_request_hctx uses it to pick the
software context of the request.  If only isolated CPUs are mapped to a
hardware context, the mask is empty and blk_mq_alloc_request_hctx fails
with -EXDEV, although the isolated CPUs still submit I/O to it.

The nvme fabrics transports allocate the Connect command for every I/O
queue this way, so connecting a controller fails with isolcpus=domain
or an isolated cpuset partition as soon as a hardware context only has
isolated CPUs.

Passthrough requests are inserted directly into hctx->dispatch, so
their software context only selects the CPU the completion runs on and
the hint for freeing the tag.  Use the software context of an online CPU
which is neither isolated from the scheduler domains nor from managed
interrupts for them.  Other requests and inactive hardware contexts
still fail.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..79fb08400c48 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -697,6 +697,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+/*
+ * Return an online CPU which is neither isolated from the scheduler domains
+ * nor from managed interrupts, or nr_cpu_ids if there is none.
+ */
+static unsigned int blk_mq_housekeeping_cpu(void)
+{
+	unsigned int cpu;
+
+	rcu_read_lock();
+	for_each_online_cpu(cpu) {
+		if (!cpu_is_isolated(cpu) &&
+		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
+			break;
+	}
+	rcu_read_unlock();
+
+	return cpu;
+}
+
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
@@ -747,8 +766,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		/*
+		 * Isolated CPUs are not part of hctx->cpumask, so it can be
+		 * empty although online CPUs are mapped to this hardware
+		 * context.  Passthrough requests are inserted directly into
+		 * hctx->dispatch, so use the software context of a
+		 * housekeeping CPU for them.  Inactive hardware contexts have
+		 * no online CPU left.
+		 */
+		if (!blk_op_is_passthrough(opf) ||
+		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
+			goto out_queue_exit;
+		cpu = blk_mq_housekeeping_cpu();
+		if (cpu >= nr_cpu_ids)
+			goto out_queue_exit;
+	}
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (q->elevator)

-- 
2.56.0


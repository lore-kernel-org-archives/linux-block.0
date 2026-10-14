Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41E4CC604;
	Wed, 14 Oct 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964020; cv=none; b=MJtWTfW3U0ED990ts94o9K/ipQMeGeVKTHLrXnG3/oO3lN9qnpKQfNRkUEpZFKixz6DzJbsTjTQ5lGDPrJ1xW0FTKhM3v5tsm+4zCmmKlkjU9SnQiHsMtGDEIN7Po6EOMgv2RBW53s65R8xZ61CWMhB4vhR17f65iibS2tkfe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964020; c=relaxed/simple;
	bh=7YcRDwUYFcYi4qQv3Wh5O+seIw+8qGT55KvXu43jlaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBfUeRURUdyFWbR4EZTeMbF2Oij14HsMbM/qGmkqIqr33IsVy46BnvD80XayA3klphqk4QR3+2hfBFnw7bAsxxDQE1w/XNdd3KIKiSGH+w7KydCA4CGVx1RSctisGiBEDpI5Ej+bID6ZQ0vp0sBS8vGoYDFuCQ/A5RwJ/YqZ1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jZauYSYu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYE+zoQE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jZauYSYu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYE+zoQE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jZauYSYu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYE+zoQE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jZauYSYu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYE+zoQE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D2871F88F;
	Wed, 14 Oct 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqZ/LtFYXZbY4tnxo+Y2y338DHABkSGDQWphlXXl9sU=;
	b=jZauYSYupdzB72p3Cyllgv3TALhTj65siJCvY4cgYxlZIHGF+2lIYw5DV46WsQhBwj7TkL
	NMNYJ7N7DkiSFlxNUlFlY0UW3i6iKYAPb/KIrpzRPVbbDGfXMwckggxr+ZBJW5enmBYJ+1
	zcSUEgb9QkUz2b6IZqBPUogSU8c0TPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqZ/LtFYXZbY4tnxo+Y2y338DHABkSGDQWphlXXl9sU=;
	b=EYE+zoQEJgdQaz9DjGY2bSUpN4rV814OezP2el03OmYfPvVmIzFsTJBnXJ6dvQlmhAEmFz
	GPAwMkfra7PMGuAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqZ/LtFYXZbY4tnxo+Y2y338DHABkSGDQWphlXXl9sU=;
	b=jZauYSYupdzB72p3Cyllgv3TALhTj65siJCvY4cgYxlZIHGF+2lIYw5DV46WsQhBwj7TkL
	NMNYJ7N7DkiSFlxNUlFlY0UW3i6iKYAPb/KIrpzRPVbbDGfXMwckggxr+ZBJW5enmBYJ+1
	zcSUEgb9QkUz2b6IZqBPUogSU8c0TPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqZ/LtFYXZbY4tnxo+Y2y338DHABkSGDQWphlXXl9sU=;
	b=EYE+zoQEJgdQaz9DjGY2bSUpN4rV814OezP2el03OmYfPvVmIzFsTJBnXJ6dvQlmhAEmFz
	GPAwMkfra7PMGuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E609D133F1;
	Wed, 14 Oct 2026 07:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w43pMW8zz2quOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:55 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:39 +0200
Subject: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating the
 controller
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

From: Daniel Wagner <wagi@kernel.org>

Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
and startup") the I/O tag set is allocated before the I/O queues.
blk_mq_alloc_tag_set calls nvme_tcp_init_request for every request,
which takes pf_cache_lock of the request's queue, but nvme_tcp_alloc_queue
initializes that mutex only later.  With CONFIG_DEBUG_MUTEXES the first
connect triggers DEBUG_LOCKS_WARN_ON(lock->magic != lock) in
__mutex_lock and lock debugging is disabled.

Initialize pf_cache_lock for all queues when allocating the controller
and keep it for the lifetime of the controller.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/tcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ec678ed07af8..f876375dffd2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1531,7 +1531,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-	mutex_destroy(&queue->pf_cache_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1861,7 +1860,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
-	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -2002,7 +2000,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
@@ -3028,7 +3025,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -3098,6 +3095,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	/*
+	 * The I/O tag set is allocated before the I/O queues, and initializing
+	 * its requests already allocates the PDUs from the page frag caches of
+	 * the queues, so initialize their locks here.
+	 */
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		mutex_init(&ctrl->queues[i].pf_cache_lock);
+
 	ctrl->net = get_net(current->nsproxy->net_ns);
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);

-- 
2.56.0


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775474CEE4B;
	Wed, 14 Oct 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964022; cv=none; b=BLWrysKEGLu7vkmPegd4z51OgriDyhFi1APpvSgEwVmf8iMP/ylYnZYojGLwpQPbt3/ucae+nPG7TFnbpTfWD3/1sTP3fJtzeLZg5M+kgtHXepdEVL8E3dFTH/8VxKBN2bEtdk5VB1SUhYWwAYsxVkZPDDfn7W69N1ha6ESyVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964022; c=relaxed/simple;
	bh=up+qV8WmZXuvowHKpdkZxu6moIXCGY9MvHD+KjM5DoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJDTZZw1UttbDDGvQ2MgRihk7bWul3zQGCkM0917TGG19uqj9Eowvszf3eb6LnAoHm0aTePJCrz9ZxAGRvlpC5UJtIddXwdOzMmlAIoxZab7sxBJ7+Jt7rh4HtJ1XA5Seei7GfS8G1LMMB+j00qiyezU+z5+R9U7/pkDPvWrYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c6Z5aev3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MLF5Q6NV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c6Z5aev3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MLF5Q6NV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c6Z5aev3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MLF5Q6NV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c6Z5aev3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MLF5Q6NV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E69C22199;
	Wed, 14 Oct 2026 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKCzGCY/gL86qo8WhiokBey3V91SlyPmrYEP4qzZh+I=;
	b=c6Z5aev3ONLXjlC78cLt3jJog67FfoSDWKT8c+2twBRW6343N9nurm/HigRy9BhXicx5OI
	Jc74Rtec+Y5nRelAnKc3uGihGFFsIKATJRA4/kCHwoFRMNpOxJhOkUzJLEo+aHSm+O3AHI
	S7+QQ6DxH887/yS/wL2NcW4KekZAprQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKCzGCY/gL86qo8WhiokBey3V91SlyPmrYEP4qzZh+I=;
	b=MLF5Q6NVng6Vmlsxfn9yfrBYXy78Kljs5EosNpvsyfZuIFAKe4hV5XMEpM2EobvXkHzZmh
	W3L/rAnuHBTb3ZDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKCzGCY/gL86qo8WhiokBey3V91SlyPmrYEP4qzZh+I=;
	b=c6Z5aev3ONLXjlC78cLt3jJog67FfoSDWKT8c+2twBRW6343N9nurm/HigRy9BhXicx5OI
	Jc74Rtec+Y5nRelAnKc3uGihGFFsIKATJRA4/kCHwoFRMNpOxJhOkUzJLEo+aHSm+O3AHI
	S7+QQ6DxH887/yS/wL2NcW4KekZAprQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKCzGCY/gL86qo8WhiokBey3V91SlyPmrYEP4qzZh+I=;
	b=MLF5Q6NVng6Vmlsxfn9yfrBYXy78Kljs5EosNpvsyfZuIFAKe4hV5XMEpM2EobvXkHzZmh
	W3L/rAnuHBTb3ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B708133F1;
	Wed, 14 Oct 2026 07:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +a9lDHIzz2q7OQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:58 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:42 +0200
Subject: [PATCH 4/5] nvme-fabrics: limit each queue type to the number of
 online CPUs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL67935bhfdkbndpbo95z3ogoo)];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

From: Daniel Wagner <wagi@kernel.org>

nvmf_nr_io_queues limits each queue type to the number of online CPUs
when asking for I/O queues, but nvmf_set_io_queues hands out the
granted queues without these limits, and only nr_io_queues is clamped
when parsing the options.

E.g. with 2 CPUs, nr_io_queues=2, nr_write_queues=10 and
nr_poll_queues=10, 2 + 2 + 2 = 6 queues are requested, but handed out
as 4 default, 2 read and 0 poll queues.  blk_mq_map_queues can't create
more CPU masks than there are CPUs, so default queues 2 and 3 take over
the CPUs of default queues 0 and 1, and connecting the I/O queue of
default queue 1 fails with -EXDEV.

Apply the same limits in nvmf_set_io_queues.  A queue type with more
queues than online CPUs always has a hardware context without an online
CPU, so no working setup changes.  The options are not modified, so the
limits follow CPU hotplug on reconnect.

Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
Fixes: a249d3066de6 ("nvme-fabrics: add queue setup helpers")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fabrics.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 571de549fbaf..27a8ce51d2b3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1125,18 +1125,27 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
 			u32 io_queues[HCTX_MAX_TYPES])
 {
+	/*
+	 * Each queue type is mapped to the CPUs separately, so a type with
+	 * more queues than online CPUs has hardware contexts without an online
+	 * CPU.  Use the same limits as nvmf_nr_io_queues.
+	 */
+	u32 nr_io = min(opts->nr_io_queues, num_online_cpus());
+	u32 nr_write = min(opts->nr_write_queues, num_online_cpus());
+	u32 nr_poll = min(opts->nr_poll_queues, num_online_cpus());
+
 	memset(io_queues, 0, sizeof(*io_queues) * HCTX_MAX_TYPES);
 
-	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+	if (nr_write && nr_io < nr_io_queues) {
 		/*
 		 * separate read/write queues
 		 * hand out dedicated default queues only after we have
 		 * sufficient read queues.
 		 */
-		io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
+		io_queues[HCTX_TYPE_READ] = nr_io;
 		nr_io_queues -= io_queues[HCTX_TYPE_READ];
 		io_queues[HCTX_TYPE_DEFAULT] =
-			min(opts->nr_write_queues, nr_io_queues);
+			min(nr_write, nr_io_queues);
 		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
 	} else {
 		/*
@@ -1145,14 +1154,14 @@ void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
 		 * sufficient queue count to have dedicated default queues.
 		 */
 		io_queues[HCTX_TYPE_DEFAULT] =
-			min(opts->nr_io_queues, nr_io_queues);
+			min(nr_io, nr_io_queues);
 		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
 	}
 
-	if (opts->nr_poll_queues && nr_io_queues) {
+	if (nr_poll && nr_io_queues) {
 		/* map dedicated poll queues only if we have queues left */
 		io_queues[HCTX_TYPE_POLL] =
-			min(opts->nr_poll_queues, nr_io_queues);
+			min(nr_poll, nr_io_queues);
 	}
 }
 EXPORT_SYMBOL_GPL(nvmf_set_io_queues);

-- 
2.56.0


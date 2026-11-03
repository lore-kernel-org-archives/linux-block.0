Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717848;
	b=kXV8xyx2Q8Tj9JXHutSb1eObcENJEUjgyAbPfzfc3qlXYIUyFzdBiyefPHaTfgA+R5Xn
	 +6r6+hY/vE6Bt1lTk7xWyQG2OkFSEBLRwlURkIPyApU0XpUgW+qnNwCiCB+xNJVNRdcp2
	 Upbc+OAdu8Un0+H8Z0IBlULM89Z9AEQxvePHTaSV0NSbEm5+l8iyTEkNu7EL7OyusvRdg
	 t2gwn6WwTCQefeCWOwRqgsid2tz2xoWTUPA7lAEgy2o/QJT24OsGiMQgKsSxVjISkvyfI
	 WFG57Lv5Mh9PVzltzVzu5q0FYKz8wu0lR63XXAlRKRTsmtOXjbBwatTk/cwrpQTi+xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717848;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=SI+4+3+usaqn/QJk403KP0hoB8huPiz8Q28IoF20v0Y=;
	b=gVpOY7fsnJMyhQCrMxp3kJNLDO11qSSevsG5R5yhDasl8uiHN9IhoRM+aV5B1+6Mkbho
	 b3oKnRfmzV2LXpDj8Ws7r7A5rKdcN5D+Uvbv056gAy6Q8pm0bk7dduOxipGpUT4+0pyLY
	 LbWlRjOPPenXui5INCBWSKwzVYanGvLi3dfgxDm1pKKKBpToRoXpwlrp1qT6ZowxcT7mJ
	 KD5cNYunBthDB9G58bg+ufMBof5KyFBPLYnnyBQDW6yqzw6nUsp8kSPSD3Xn8wtUYMPt9
	 3OTBf7Q0V9QIMfx4f3948msqHTs5+IbMG+qIm/5RtkPGCzvTlbyIFWfn92mAU82BuQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mSAQi4Il;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dpuSkBmx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DImAWeuU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="TMU/jrrT";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A9606A789;
	Tue,  3 Nov 2026 14:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF1A9606A789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mSAQi4Il;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dpuSkBmx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DImAWeuU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TMU/jrrT
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D77432203B;
	Tue,  3 Nov 2026 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SI+4+3+usaqn/QJk403KP0hoB8huPiz8Q28IoF20v0Y=;
	b=mSAQi4Il1Cjtwz7R7et/GkGFi7TlEwL4b+RU2KlUuslz16IpbstmdmDHEl31yVcbaZJf1u
	TT+Vna9jjdb+4YBod4cO6y9vrUpHEGysfQKUCDBPlB8DrkyHfFvi42R5mXL8cww1J/jWqk
	Wkz+2gYerXK7Tb44HHYcF9pj8knyKPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SI+4+3+usaqn/QJk403KP0hoB8huPiz8Q28IoF20v0Y=;
	b=dpuSkBmx3sFcCvcaWkP8vZfWZkOtOjQdUpIj9/DHULyK3WLF+HCzxXEw/vPSKkgREuSXum
	lVsR6FUNy8PdIUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DImAWeuU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="TMU/jrrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SI+4+3+usaqn/QJk403KP0hoB8huPiz8Q28IoF20v0Y=;
	b=DImAWeuU7gMtjpuAdgxjiONkT/63uNjHqxU3YyzYXBnbpPIcunFXjwX7BGVAoXBmjP9hEk
	E4qoh1XaseahqZObbRrMvEqBJaEAV9JPC+Pyekph+LZDBTDxOUA9WF3ZCjioCVBxYd1Quo
	zFa3PwRfRcVIYgmV8bZkcE3phOm+h98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SI+4+3+usaqn/QJk403KP0hoB8huPiz8Q28IoF20v0Y=;
	b=TMU/jrrTQZ56fpXixeJ9AhinWZOH8KRxfziqHqrWIUoTtazyB00UXrrXVJVV4xRa84oVkb
	AaJZ2oijGuvDvIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 768121350A;
	Tue,  3 Nov 2026 14:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MF9dE1X26WolHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 14:57:25 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 03 Nov 2026 15:57:22 +0100
Subject: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough requests
 on isolated hctxs
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
Message-Id: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr2K6dgwtFNGV9zAsaB1gFFsyhUZDu
 LuAcefyJf+/N4mATBjEeTcJxkiBvFtA7XfCtpVrEOi2sFCJymUiU3DxiVBXhskGoOA724+gTXb
 KijRXdVGI5doz1vTatNfyy2E0d7TD6loXLYXB83vrRrnufonsfyJKSCDVWurcoDoadXkgO+wOn
 htRzvP8ASBspR/LAAAA
X-Change-ID: 20261013-nvme-fabrics-isolcpu-5b4948362f88
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>, 
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Aaron Tomlin <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,msgid.link:url];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D77432203B

blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
select the software context for a request.

Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
context is mapped only to isolated CPUs, the mask is empty and
blk_mq_alloc_request_hctx fails with -EXDEV.

The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
the Connect command for each I/O queue. As a result, connecting to a
controller can fail when using isolcpus=domain or an isolated cpuset
partition.

Passthrough requests bypass the software queues and go directly to
hctx->dispatch. Their software context is only used to select the
completion CPU and as a hint when freeing the tag.

Use the software context of an online housekeeping CPU for passthrough
requests.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Tested-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Connecting a fabrics controller fails when all CPUs of a hardware
context are isolated with isolcpus=domain or an isolated cpuset
partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
kworker on isolated CPUs") the CPU mask of such a hardware context is
empty and blk_mq_alloc_request_hctx() fails the Connect command with
-EXDEV. This patch lets passthrough requests use the software context
of a housekeeping CPU instead.

The nvme fabrics fixes from v1 (patches 1 and 3-5) are in nvme-7.4, so
only the blk-mq patch is left. The blktest for this patch is nvme/070,
posted separately.
---
Changes in v2:
- Only the blk-mq patch left, the nvme patches are in nvme-7.4.
- Reword the commit message to describe what the fix does (Hannes).
- Add Tested-by from Maurizio.
- Link to v1: https://patch.msgid.link/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org
---
 block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5fca78778c31..77685e6283fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -717,6 +717,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
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
@@ -767,8 +786,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		/*
+		 * Isolated CPUs are not part of hctx->cpumask, so it can be
+		 * empty although online CPUs are mapped to this hardware
+		 * context. Passthrough requests are inserted directly into
+		 * hctx->dispatch, so use the software context of a
+		 * housekeeping CPU for them. Inactive hardware contexts have
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

---
base-commit: c8c53d669d4e45b3a804013251a34387d7e11bfb
change-id: 20261013-nvme-fabrics-isolcpu-5b4948362f88

Best regards,
--  
Daniel Wagner <dwagner@suse.de>


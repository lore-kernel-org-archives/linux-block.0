Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802100;
	b=n/i/4yTYJ9NjYRN/y9wlWGzH/BV80+4+0+6Idq01wdON6KFsMHdHrf4o5tqQ/n6lmnj2
	 rg/Ctka7IrRZ+I6JnUBLK/uyboQI7ymDmy1RD1sxg87PsIL5Vzizo3S6ZvGX/BTjHsSBR
	 oTQdQ/I3uudL+iyqADPLx8SJsQRqWdLBLsrKdNZKJ8F01HvGQrhQQd68RKclqvtSesAOY
	 oUElB4ACPdSYcQsfrquH4Pzv1q/o9czFliQueplF5Nw+as7VJEk4DVtpn+w5lGq9ZNixm
	 9LQ1XWkHGYLBzPN0ibMeuA1NGOYtsDaXWAFx7grwbjW0pC8sU5Yb5DfY1g1PXE8xkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802100;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=155soI0NjMRHG9x/t6NIXG7vkNWhZFwefv6i2KS25W0=;
	b=UJZXLbu77VZtdlyj/coX+JpFUFvMuXlnxqr7qDzx11Lw3tefd85Mchr40ma0ypJDW0lr
	 kwh8yDgxkR5OWoEb0pYerFWN11M/ngTY+uaffsCcds3K7PeP0DcPIXIsAtwD3JY9y88EK
	 dDd88hjY7+V16V5tv9Ta9cSu4FpWvv0/UzZmQlYs5HTdEuSo89Yaor4WEgKKD6kAVs6wF
	 Z24ugUeTYkAizOQjQ+m/Yr4j9QnYQUJv7UDnl7uUs0BxTs6NDNEk2SLDfaPbXSQlzhHOI
	 EHkWiYzW1Jdjg21OpVqaV7pZMjI8Lx74pk3rzbey42nJjb/+ywYuV119NngdF5Al/xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KNDr2QNa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tofYHgW6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KNDr2QNa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tofYHgW6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F0606A326;
	Wed,  4 Nov 2026 14:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KNDr2QNa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tofYHgW6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KNDr2QNa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tofYHgW6
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0413621F30;
	Wed,  4 Nov 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=155soI0NjMRHG9x/t6NIXG7vkNWhZFwefv6i2KS25W0=;
	b=KNDr2QNaR10OIJ0iEM00jdiZR6mNTrurnjTW0VTH2tqzNNd+l3MUsqocI8/rAbqoqJi8qF
	NwjblGXShiorSRTFv0f5HsKoHspzihKbH4o/+zaWD2kEqYyI3xKoYV6GQhrIqim8m3bmkG
	FWu6/P2JeJxY42ovRUDTjIhEnQ0Fyac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=155soI0NjMRHG9x/t6NIXG7vkNWhZFwefv6i2KS25W0=;
	b=tofYHgW6d5OCtFEehjycsLCB1AwcGDVFIKyu1d4qs5W5AnFCEG0ENWZ9LMUoLmoAHpCyXq
	KYWUbEw8tERwXkDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KNDr2QNa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tofYHgW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=155soI0NjMRHG9x/t6NIXG7vkNWhZFwefv6i2KS25W0=;
	b=KNDr2QNaR10OIJ0iEM00jdiZR6mNTrurnjTW0VTH2tqzNNd+l3MUsqocI8/rAbqoqJi8qF
	NwjblGXShiorSRTFv0f5HsKoHspzihKbH4o/+zaWD2kEqYyI3xKoYV6GQhrIqim8m3bmkG
	FWu6/P2JeJxY42ovRUDTjIhEnQ0Fyac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=155soI0NjMRHG9x/t6NIXG7vkNWhZFwefv6i2KS25W0=;
	b=tofYHgW6d5OCtFEehjycsLCB1AwcGDVFIKyu1d4qs5W5AnFCEG0ENWZ9LMUoLmoAHpCyXq
	KYWUbEw8tERwXkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA50134F0;
	Wed,  4 Nov 2026 14:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VHDaHHE/62pWZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:21:37 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:21:33 +0100
Subject: [PATCH v3] blk-mq: allow passthrough requests on hctxs without
 online CPUs
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
Message-Id: <20261104-nvme-fabrics-isolcpu-v3-1-41953b5dfba0@suse.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBAGX4X07JK2UEBPvofhQMsC9aeYLjQaw
 rsLGONFj5N8O7MTI/QWiR2iiXkMlmzvFkh2ETNd5VoEWy/MJJeZ4CIBF24ITaW9NQSW+qu5j6B
 0uk+LJJNNUbDl9O6xsY9NeyrfTKM+oxlW17roLA29f27dINbdJ5H+TgQBHBKlhMo0ylzL4wW9w
 2vc+5atjSC/FsH/PBokCNgrNDmvVSFVeqSRMK6RlfM8vwDRlDYjDgEAAA==
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,msgid.link:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0413621F30

blk_mq_alloc_request_hctx() picks the first online CPU in hctx->cpumask
to find a software context for the request. If no CPU in the mask is
online, allocation fails with -EXDEV.

This triggers in two scenarios:

 1. Commit 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with
    each possisble CPU") maps all possible CPUs to hardware contexts. If
    certain CPUs are offline (e.g. booted with maxcpus= or offlined via
    sysfs), a hardware context may end up mapped entirely to offline CPUs.

 2. Commit a46c27026da1 ("blk-mq: don't schedule block kworker on
    isolated CPUs") strips isolated CPUs from hctx->cpumask. If an hctx
    is mapped exclusively to isolated CPUs (isolcpus=domain or an isolated
    cpuset partition), hctx->cpumask ends up empty.

NVMe fabrics transports allocate the Connect command for each I/O queue
using blk_mq_alloc_request_hctx(). If an hctx only maps offline or
isolated CPUs, connecting to the controller fails. Skipping these queues
is not an option because isolated CPUs still submit I/O through them,
as will offline CPUs once brought online.

Passthrough requests bypass the software staging queues and dispatch
directly. For these requests, the software context only serves to pick
a completion CPU and provide a hint when releasing the tag.

Fall back to an online housekeeping CPU's software context when allocating
passthrough requests on an hctx without an online CPU in its mask.

Hardware contexts whose last online CPU went offline are inactive.
blk-mq drained them for the CPU offline, so allocations on them still
fail.

Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Tested-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Connecting an NVMe over Fabrics controller fails in current upstream if
a hardware context has no online CPU in its CPU mask, which happens with
isolated and with offline CPUs. The commit message explains both cases.

Testing, QEMU VM with 8 CPUs, nvme-loop and nvme-tcp against nvmet in
the same VM, nvme-tcp also against nvmet in a second VM:

  - Isolated CPU: blktests nvme/079 fails without the patch and passes
    with it.
  - Offline CPUs: booted with maxcpus=4, the connect fails with -EXDEV
    on I/O queues 3 and 4 without the patch. With the patch the connect
    works, also I/O from the CPUs after bringing them online. blktests
    nvme/080 fails without the patch and passes with it.

The blktests are posted separately.
---
Changes in v3:
- Same code as v2, update the code comment and the commit message.
  Sashiko pointed out that the patch also allocates on hardware
  contexts mapped only to offline CPUs. This is intended: connecting
  fails in current upstream while CPUs are offline too, since commit
  20e4d8139319, so add it as a second Fixes tag.
- Link to v2: https://patch.msgid.link/20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de

Changes in v2:
- Only the blk-mq patch left, the nvme patches are in nvme-7.4.
- Reword the commit message to describe what the fix does (Hannes).
- Add Tested-by from Maurizio.
- Link to v1: https://patch.msgid.link/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org
---
 block/blk-mq.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5fca78778c31..c87f2d597126 100644
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
@@ -767,8 +786,24 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		/*
+		 * Only isolated or offline CPUs are mapped to this hardware
+		 * context. Isolated CPUs are not part of hctx->cpumask, and
+		 * offline CPUs may come online later and need the hardware
+		 * context then. Passthrough requests are inserted directly
+		 * into hctx->dispatch, so use the software context of a
+		 * housekeeping CPU for them. Inactive hardware contexts lost
+		 * their last online CPU and were drained for the CPU offline,
+		 * don't allocate requests on them.
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


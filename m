Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEE3B14AB;
	Wed, 14 Oct 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964019; cv=none; b=MLl+yTah/F1JQdEOVFVBL67qsRg0TNdorUzrdVHb+cKIUUnG2Lkj3IsyG6953d8+qFjl5JzOuXukBgNmEPUUzduRvZDnRCHKIGfa3WCeIwJcd0qympRRbzfBfBBa0z1+ntoAkDLVaPGA+ctI6XAeAA6SXd0+g3AGZ3ixwbHbCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964019; c=relaxed/simple;
	bh=nakmzizRVI+rhLZDdW3n1SCdKCL9f6+MbjYyhdFIFcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jzjTDbqrRf+bm8zJDDj+SF5G4Ae8X8OXh4Q294ehzLbfZm/n2IMPmI4d2RVSIBt4/XUdVGmOxVcy930aa+EA52I8lmZ0hZ8Am2mxTfpId3oPCqqdUiTHNojnpYDaJk85fDxBYSxEic+8h2Dt5x4zhCASUoA8EKb/OrVKJPCwx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PoTEBqF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4eH5R8N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PoTEBqF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4eH5R8N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PoTEBqF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4eH5R8N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PoTEBqF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4eH5R8N"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5883C1F7C5;
	Wed, 14 Oct 2026 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS/5jOFbNyfDPEHsFzDNVztzhczMDu2qyxlv8WOPUvw=;
	b=1PoTEBqF5FpZMwlRIEvx3ZyiH9UyLOFTUHV20BQpBAfOcTbZwDoxrUTQJfAdmFBDiO/jAS
	bxw7iFI9vgfWXT+CY1eQnT5QPC4aXovis6p3Ykz/vy/vg2lI5kJ7/eLNn46YzyFNJ1GBsY
	7m1UuT3k0D2FaWGWAZQtavcuNRBDGJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS/5jOFbNyfDPEHsFzDNVztzhczMDu2qyxlv8WOPUvw=;
	b=X4eH5R8NqLvA+PGaqCDiARC6m2sB1Ze+q5yusMVgB0XMSP3AdhXVhbRAOVEB4sbvLX+PRI
	ZE07IG13hY5OqGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1PoTEBqF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X4eH5R8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS/5jOFbNyfDPEHsFzDNVztzhczMDu2qyxlv8WOPUvw=;
	b=1PoTEBqF5FpZMwlRIEvx3ZyiH9UyLOFTUHV20BQpBAfOcTbZwDoxrUTQJfAdmFBDiO/jAS
	bxw7iFI9vgfWXT+CY1eQnT5QPC4aXovis6p3Ykz/vy/vg2lI5kJ7/eLNn46YzyFNJ1GBsY
	7m1UuT3k0D2FaWGWAZQtavcuNRBDGJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tS/5jOFbNyfDPEHsFzDNVztzhczMDu2qyxlv8WOPUvw=;
	b=X4eH5R8NqLvA+PGaqCDiARC6m2sB1Ze+q5yusMVgB0XMSP3AdhXVhbRAOVEB4sbvLX+PRI
	ZE07IG13hY5OqGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CCEE133F1;
	Wed, 14 Oct 2026 07:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ojM6O24zz2qrOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:55 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/5] nvme-fabrics: fix connects with isolated CPUs and
 queue mapping bugs
Date: Wed, 14 Oct 2026 09:46:38 +0200
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB0w8YfUq4gLk07aEY2SUSmId
 29ql9/ivROEIpNAm50Q6WDhJSSoPAP3HsKLkJ/JoAvdqEKVGI6Z0A82shNkWSa37ljb6lGZstH
 eGEjpGsnz5952/d+y25Hc9nvBdX0Bb5IqO3gAAAA=
X-Change-ID: 20261013-nvme-fabrics-isolcpu-5b4948362f88
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
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 5883C1F7C5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Connecting a fabrics controller fails when all CPUs of a hardware
context are isolated with isolcpus=domain or an isolated cpuset
partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
kworker on isolated CPUs") the CPU mask of such a hardware context is
empty and blk_mq_alloc_request_hctx() fails the Connect command with
-EXDEV. Patch 2 lets passthrough requests use the software context of a
housekeeping CPU instead.

Patches 3-5 fix the fabrics queue mapping:

  - Stale io_queues[] entries after a reconnect with fewer queues crash
    blk_mq_map_swqueue().
  - A queue type can get more queues than online CPUs, so connecting
    fails with -EXDEV.
  - Without queues left for polling, the queue claims poll support and
    polled I/O ends up on a non-poll queue.

Patch 1 fixes a regression in nvme-7.4 found while testing: since commit
61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
nvme_tcp_init_request takes a mutex before it is initialized, which
disables lock debugging on the first connect.

I found the fabrics queue setup problems while working on the isolcpus
series for the block layer, which Aaron Tomlin has since taken over and
which has not been merged yet. Maurizio Lombardi reported customer bugs
with isolcpus and nvme fabrics. This series doesn't depend on the block
layer work.

The bugs fixed by patches 3-5 predate commit a249d3066de6
("nvme-fabrics: add queue setup helpers"), which moved the tcp and rdma
code into fabrics.c, so kernels before v6.5 need manual backports.

Testing, QEMU with 8 CPUs, nvme-tcp and nvme-loop against nvmet:

  - isolcpus=managed_irq,domain,2-3: without the series, connecting
    with nr_io_queues=8, with and without nr_write_queues=8
    nr_poll_queues=8, fails on I/O queue 2, whose hardware context only
    has CPU 3. With the series connect and I/O work.
  - New blktests, posted separately:
      nvme/070  connect with an isolated CPU             -> patch 2
      nvme/071  more write and poll queues than CPUs     -> patch 4
      nvme/072  no queues left for polling               -> patch 5
      nvme/073  reconnect with fewer queues              -> patches 3, 5
    Without the series all fail, nvme/073 crashes the kernel. With the
    series all pass.
  - blktests block and nvme (loop, tcp): no regressions.

Reconnecting after all CPUs of a hardware context went offline still
fails, with and without this series: blk-mq marks the hardware context
inactive, but tcp, rdma and loop connect the I/O queues before updating
the CPU mapping. I'll fix this separately, together with moving the
fabrics reconnect sequence into common code.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (5):
      nvme-tcp: initialize pf_cache_lock when allocating the controller
      blk-mq: use a housekeeping CPU for passthrough requests on isolated hctxs
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

 block/blk-mq.c              | 37 +++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c | 30 ++++++++++++++++++++++++------
 drivers/nvme/host/tcp.c     | 13 +++++++++----
 3 files changed, 68 insertions(+), 12 deletions(-)
---
base-commit: 31b8a6af19b73e6167c4b655cd5e86681bac1c41
change-id: 20261013-nvme-fabrics-isolcpu-5b4948362f88

Best regards,
--  
Daniel Wagner <wagi@kernel.org>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414068;
	b=MrtvynTRE6jpQMxeISXdbLLtLLMm6UmaAJXvg+jlpbAxturTYBHUkwb5fvwBYeayuflt
	 c4uBTHqvzZIPulhEuWshRzeNzo2W+rXqtO26104+IYXhKkKQOqocM3SRi3asx1FWd/+9i
	 TGUWdYR2sjc5S0x4rIG6nghDHxyBatJa9weVVgm+wH6O9RY2K3G/6IYpxc6ZrFBPz+gSk
	 sAtq2UIoFDRs3hJxYEW0W9+LNa6XZ+9R8XdjOc+ia0soBXOwPsZhVsP7mUBTOthoN3n9v
	 l0w2bbeg+qemNo2YXu3rWifGAnMYRoX1ZejDsF0jWk3dVnPJlhTwMS88YvuomsZ54lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414068;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=FxBAbV0izYrRrCVmV/Lhrk7G0zfUxlgRLfpCEF5MJuI=;
	b=hNyuJtgUC3WJpKk5e6TcA/VLfXCymLwn8T6wE2ihtiEmchAlHmenwW369A/amvJx6pf2
	 P51TmugzzsAn/LLnVCIx/xF808UsqaLPxqO2avx/LEW6EWv3Lb4R/qfIBGaVnYOdwTZ7w
	 OJR7GMZy+KcsyJ3XTd85OQqvyBBCjTZNGngqoFQowbWNvo4aXysVbgtUL8j7ZBXLA6EkU
	 f9H9+BlDqOdlGOtQ6X0eQHtcMSefm6JZmo0buO9NJKMd/HZPn8rwibAarWyDA5TmZo5Z4
	 VUswZoQbVOgrELrHKapvqKfXbrpoBUOiiE7znHDja75x/m91l3DTvwyojDuUXwVGkdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=M7quML3H;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=M7quML3H;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6A606A321;
	Wed, 11 Nov 2026 16:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=M7quML3H;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=M7quML3H
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66E5F21E20;
	Wed, 11 Nov 2026 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxBAbV0izYrRrCVmV/Lhrk7G0zfUxlgRLfpCEF5MJuI=;
	b=M7quML3H12c0bAAZGKdWgSNbhHrMX2cQ/KIUENvcQab+UQKzNMfDyWewk5hUbNAzZhN6qB
	7VltbfEk/wurt5lRzDCS27Py5BPsW62Gf7iFeGICy1N4FZboyjoet7qp3k+Kx+6LrFtpHn
	0UF+MrmkeJ7mmzCp3I5zFh08uoy47NE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M7quML3H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxBAbV0izYrRrCVmV/Lhrk7G0zfUxlgRLfpCEF5MJuI=;
	b=M7quML3H12c0bAAZGKdWgSNbhHrMX2cQ/KIUENvcQab+UQKzNMfDyWewk5hUbNAzZhN6qB
	7VltbfEk/wurt5lRzDCS27Py5BPsW62Gf7iFeGICy1N4FZboyjoet7qp3k+Kx+6LrFtpHn
	0UF+MrmkeJ7mmzCp3I5zFh08uoy47NE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 108C3134E5;
	Wed, 11 Nov 2026 16:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jphANPGV9GoGAwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 11 Nov 2026 16:21:06 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 1/3] xen-blkback: Remove statistics logging on console
Date: Wed, 11 Nov 2026 17:20:56 +0100
Message-ID: <20261111162058.804033-2-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162058.804033-1-jgross@suse.com>
References: <20261111162058.804033-1-jgross@suse.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66E5F21E20
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -12.01

The xen-blkback can print I/O statistics data to the console every
10 seconds. This functionality has been present since the introduction
of xen-blkback, but retrieving the data is possible via sysfs, too.

So remove the console logging, as there is no need to have the same
functionality twice.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/blkback.c | 25 -------------------------
 drivers/block/xen-blkback/common.h  |  1 -
 drivers/block/xen-blkback/xenbus.c  |  1 -
 3 files changed, 27 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 88526e349ce1..f3a8f3eae86b 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -126,10 +126,6 @@ MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the
  */
 #define LRU_PERCENT_CLEAN 5
 
-/* Run-time switchable: /sys/module/blkback/parameters/ */
-static unsigned int log_stats;
-module_param(log_stats, int, 0644);
-
 #define BLKBACK_INVALID_HANDLE (~0)
 
 static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
@@ -536,21 +532,6 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id)
  * SCHEDULER FUNCTIONS
  */
 
-static void print_stats(struct xen_blkif_ring *ring)
-{
-	pr_info("(%s): oo %3llu  |  rd %4llu  |  wr %4llu  |  f %4llu"
-		 "  |  ds %4llu | pg: %4u/%4d\n",
-		 current->comm, ring->st_oo_req,
-		 ring->st_rd_req, ring->st_wr_req,
-		 ring->st_f_req, ring->st_ds_req,
-		 ring->persistent_gnt_c, max_pgrants);
-	ring->st_print = jiffies + secs_to_jiffies(10);
-	ring->st_rd_req = 0;
-	ring->st_wr_req = 0;
-	ring->st_oo_req = 0;
-	ring->st_ds_req = 0;
-}
-
 int xen_blkif_schedule(void *arg)
 {
 	struct xen_blkif_ring *ring = arg;
@@ -614,17 +595,11 @@ int xen_blkif_schedule(void *arg)
 		else
 			gnttab_page_cache_shrink(&ring->free_pages,
 						 max_buffer_pages);
-
-		if (log_stats && time_after(jiffies, ring->st_print))
-			print_stats(ring);
 	}
 
 	/* Drain pending purge work */
 	flush_work(&ring->persistent_purge_work);
 
-	if (log_stats)
-		print_stats(ring);
-
 	ring->xenblkd = NULL;
 
 	return 0;
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index f5890b3f1df9..0a60e29a7cc3 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -277,7 +277,6 @@ struct xen_blkif_ring {
 	unsigned long           next_lru;
 
 	/* Statistics. */
-	unsigned long		st_print;
 	unsigned long long	st_rd_req;
 	unsigned long long	st_wr_req;
 	unsigned long long	st_oo_req;
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 8d0ff8fcac22..62e3bad4ab0e 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -158,7 +158,6 @@ static int xen_blkif_alloc_rings(struct xen_blkif *blkif,
 		init_waitqueue_head(&ring->pending_free_wq);
 		init_waitqueue_head(&ring->shutdown_wq);
 		ring->blkif = blkif;
-		ring->st_print = jiffies;
 		ring->active = true;
 	}
 
-- 
2.56.0


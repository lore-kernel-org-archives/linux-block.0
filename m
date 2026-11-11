Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414074;
	b=wuTxglNm6mtc8T5c7iLKMQzS8eCCysW4HeoorDzMcl5PzS6yMTfHRR0TxVNzDKFdaVd9
	 m10T4PiV0UUEarVI8znhKvpbtQmlFoW12oC7XPw3SJbPcGMDp2ugRESdp9poZC4k7JOpl
	 IejWUyws5Cmc0kdISPbUgc+wrMcUj2V1k3JykZ9LhKTdcYbsxB8wgCX+j8n6BOo4eqQwc
	 1Fseog1IpzsmjATI/YvCjsx6FG9FtJjjusiSKrr1yxXtRS1LkVZYUqmYzntzZoUYnr/BY
	 P9SSP6dBZaJz9iGpnYxxtTTznj9E+HvnT8yU3AAPYZthScs/u+00IvjNzMKnjrwc11g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414074;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=saitawIKx4KwcKVQs3zXZcaCqHPuFnuj001Oa7m/5Wo=;
	b=H1+pi9kPH+SFOfxQ3ubaNKxQwzg4Xnc5HY1BrFWhffuxxBkrUoA8NDUaDEekbydnMJWN
	 uuGQF/NWXAVBKomMq41Ot+LRrnapJDpm7tX+8zUiOTQiZyhbuJ2ITudZmTO7HiLdF2Ki5
	 c2+GfDP4VQ3cmZk+YRS1e+5eH9ecmqg28CdERtXhXiZJKwz48TdkWNXpMzAbgxDWRcgJ5
	 A39PU97Yguh3SEXtPQamqQZ/SmnENcHKi5wJFgDwWCyJ9o43N6Ivj37ux02sYjGhZELP2
	 2JgxLgtsyVSbBWzNYsbxfQTSD1O5pd+JvHAv5kugyN0EgYf9UFlOqOWJfOj1iSmJA+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=l3qeiwj3;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=WvTBTjvR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E86606A32A;
	Wed, 11 Nov 2026 16:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E86606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=l3qeiwj3;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=WvTBTjvR
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0D371F80D;
	Wed, 11 Nov 2026 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saitawIKx4KwcKVQs3zXZcaCqHPuFnuj001Oa7m/5Wo=;
	b=l3qeiwj3cDHv4ZxDgABEfcpkZBwISLXe+befvEqV/ZIaO8tfrykrnGaTeeC2tXXa7wWRRy
	msLQ/PpAGvoqBTwzNH3CPsSbIY9Qfm+O+JxkwPiHIKM3AHNI/6c2cRds3OPd14AMeigCAe
	hRh7jEzL5ylny6bggBfbPkYcrVkQQC8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saitawIKx4KwcKVQs3zXZcaCqHPuFnuj001Oa7m/5Wo=;
	b=WvTBTjvR6xrw1dqmvdaEcXbjWYmBCvPYvCw/+t99Xxpy0jpxAMa7GgLgmeDW2mLvCY+g+7
	Ri4nmoJ9XGxU4fLm+W6yiKqXoiv9JBBtUa3NZswB78SnF87mAuenipGexPBYQUNVIijIpd
	GWiMTNrD585fB2gcb0IMiN+R8OV0Bds=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A668A134E5;
	Wed, 11 Nov 2026 16:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JF4yIfeV9GoXAwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 11 Nov 2026 16:21:11 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 2/3] xen-blkback: move statistics data into sub-structure
Date: Wed, 11 Nov 2026 17:20:57 +0100
Message-ID: <20261111162058.804033-3-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80

Move the statistics data into a dedicated new struct xen_blkif_stat.

This is done in preparation of not losing statistics in case of
disconnect/reconnect cycles.

No functional change intended.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/blkback.c | 14 +++++++-------
 drivers/block/xen-blkback/common.h  | 19 ++++++++++++-------
 drivers/block/xen-blkback/xenbus.c  |  2 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index f3a8f3eae86b..e2f09bd4e84e 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -958,7 +958,7 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 			preq.sector_number + preq.nr_sects, blkif->vbd.pdevice);
 		goto fail_response;
 	}
-	ring->st_ds_req++;
+	ring->st.ds_req++;
 
 	if (blkif->vbd.discard_secure &&
 	    (req->u.discard.flag & BLKIF_DISCARD_SECURE))
@@ -1198,7 +1198,7 @@ __do_block_io_op(struct xen_blkif_ring *ring, unsigned int *eoi_flags)
 
 		pending_req = alloc_req(ring);
 		if (NULL == pending_req) {
-			ring->st_oo_req++;
+			ring->st.oo_req++;
 			more_to_do = 1;
 			break;
 		}
@@ -1297,11 +1297,11 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 
 	switch (req_operation) {
 	case BLKIF_OP_READ:
-		ring->st_rd_req++;
+		ring->st.rd_req++;
 		operation = REQ_OP_READ;
 		break;
 	case BLKIF_OP_WRITE:
-		ring->st_wr_req++;
+		ring->st.wr_req++;
 		operation = REQ_OP_WRITE;
 		operation_flags = REQ_SYNC | REQ_IDLE;
 		break;
@@ -1309,7 +1309,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		drain = true;
 		fallthrough;
 	case BLKIF_OP_FLUSH_DISKCACHE:
-		ring->st_f_req++;
+		ring->st.f_req++;
 		operation = REQ_OP_WRITE;
 		operation_flags = REQ_PREFLUSH;
 		break;
@@ -1445,9 +1445,9 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	blk_finish_plug(&plug);
 
 	if (operation == REQ_OP_READ)
-		ring->st_rd_sect += preq.nr_sects;
+		ring->st.rd_sect += preq.nr_sects;
 	else if (operation == REQ_OP_WRITE)
-		ring->st_wr_sect += preq.nr_sects;
+		ring->st.wr_sect += preq.nr_sects;
 
 	return 0;
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 0a60e29a7cc3..f8385c4b9d30 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -248,6 +248,17 @@ struct persistent_gnt {
 	struct list_head remove_node;
 };
 
+/* Statistic data. */
+struct xen_blkif_stat {
+	unsigned long long	rd_req;
+	unsigned long long	wr_req;
+	unsigned long long	oo_req;
+	unsigned long long	f_req;
+	unsigned long long	ds_req;
+	unsigned long long	rd_sect;
+	unsigned long long	wr_sect;
+};
+
 /* Per-ring information. */
 struct xen_blkif_ring {
 	/* Physical parameters of the comms window. */
@@ -277,13 +288,7 @@ struct xen_blkif_ring {
 	unsigned long           next_lru;
 
 	/* Statistics. */
-	unsigned long long	st_rd_req;
-	unsigned long long	st_wr_req;
-	unsigned long long	st_oo_req;
-	unsigned long long	st_f_req;
-	unsigned long long	st_ds_req;
-	unsigned long long	st_rd_sect;
-	unsigned long long	st_wr_sect;
+	struct xen_blkif_stat	st;
 
 	/* Used by the kworker that offload work from the persistent purge. */
 	struct list_head	persistent_purge_list;
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 62e3bad4ab0e..b3ef483a92fd 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -408,7 +408,7 @@ void xen_blkif_interface_fini(void)
 		for (i = 0; i < blkif->nr_rings; i++) {		\
 			struct xen_blkif_ring *ring = &blkif->rings[i];	\
 									\
-			result += ring->st_##name;			\
+			result += ring->st.name;			\
 		}							\
 									\
 out:									\
-- 
2.56.0


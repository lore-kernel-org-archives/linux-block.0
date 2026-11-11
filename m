Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414080;
	b=GweBq5QTt1ElM+8Oj7atqHE3Ab2klDPzgcoO6hJWTYNRByB2qPMI0LhYlgJ7bI8K/1Ra
	 CunHt8ear6SFWe9I39C5q7WwsPUDnSNerqV0dyyyhrztpXtewtxXKjITqgO6wJ1fhnfyK
	 X6vIsoisuzZFTI0nQ87qI7BBAN6wK1/XPnFDRP4lBJvVdneAgJvpPF6wkh/vnUg9bRNLZ
	 CV67gDiCnZp65Li0tjDL9i3+khytKGtNDO262ibU0DkheTOLImzHTpO9kppWGqDOHHZIl
	 ncGOEJEltWaZSerIHKJ7ePFC1qUhP2HxlRIFCocYEz7DApqSBkuLqAzxinM2HuXthjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414080;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=bSSv9eG1iTWrGFTeMHmS2DVPwf3MYF59DxWDnGZ5sCE=;
	b=G2VmcCuPA27hZ3j/G/jrIsiNXIEUulvPANyqwRA5ElzI20lGe0tk2+i2t0SWuan02SW3
	 9mFpujjBeJuSMGjga8DPdiFTpVOZWleD7tUwwyYfwohRTZ6IUjSI3Sn0ZUGZXzJlOYiQe
	 ddzmqbd8GWXqYK6cnHGg47GgL22GfmkjO2BG8VPVyTtjrhr51zhS/9+r4YutWahD0Ra1B
	 i+/EukHdvGKHv3/w6BbiAUSfsUN+CVR+iQv+mCcMaY4CBRfM7QHGnFRsoPXFcyimjtNc2
	 /z9AsAHEjsRa1ciyNqkFcEYRHfE8p57ljt/SU/5c5vnzMGgZC3klzs6rBVYpIWD8oog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=tg5PpfpL;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=tg5PpfpL;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41265606A32E;
	Wed, 11 Nov 2026 16:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41265606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=tg5PpfpL;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=tg5PpfpL
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEAB621D93;
	Wed, 11 Nov 2026 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSSv9eG1iTWrGFTeMHmS2DVPwf3MYF59DxWDnGZ5sCE=;
	b=tg5PpfpLp/dgUzWIDV/iSAU0nguXlNp6hSiYcOS2zsUh9F8aeKmpYS2xNtgMMZj5NrJXWp
	j5jbkXYSPf9jx4mCvwI5gphXASoF8HgrHDrsJBSvHBRiYAqDvvTjcNlsvHVa8yvkEJw0nA
	esAZUn8gyTcAM46y8pDLpWjWGT4iS5k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSSv9eG1iTWrGFTeMHmS2DVPwf3MYF59DxWDnGZ5sCE=;
	b=tg5PpfpLp/dgUzWIDV/iSAU0nguXlNp6hSiYcOS2zsUh9F8aeKmpYS2xNtgMMZj5NrJXWp
	j5jbkXYSPf9jx4mCvwI5gphXASoF8HgrHDrsJBSvHBRiYAqDvvTjcNlsvHVa8yvkEJw0nA
	esAZUn8gyTcAM46y8pDLpWjWGT4iS5k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5767C134E5;
	Wed, 11 Nov 2026 16:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AuQhCv2V9GocAwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 11 Nov 2026 16:21:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 3/3] xen-blkback: make statistics data persistent across disconnect/connect
Date: Wed, 11 Nov 2026 17:20:58 +0100
Message-ID: <20261111162058.804033-4-jgross@suse.com>
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
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 
X-Spam-Flag: NO

Today the statistics data is living in struct xen_blkif_ring only.

This means that a disconnect/connect cycle will reset the data, as the
rings are freed and re-allocated in this case.

Add a struct xen_blkif_stat in struct xen_blkif and sum up the per-ring
data there when freeing the rings, and add those values to the printed
statistics data.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/common.h |  2 ++
 drivers/block/xen-blkback/xenbus.c | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index f8385c4b9d30..c35ec207b31d 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -327,6 +327,8 @@ struct xen_blkif {
 	unsigned int		nr_rings;
 
 	unsigned long		buffer_squeeze_end;
+
+	struct xen_blkif_stat	st;
 };
 
 struct seg_buf {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b3ef483a92fd..f0d4cec4432a 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -346,6 +346,18 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	 */
 	write_lock(&blkif->rings_lock);
 
+	for (r = 0; r < blkif->nr_rings; r++) {
+		struct xen_blkif_ring *ring = &blkif->rings[r];
+
+		blkif->st.rd_req += ring->st.rd_req;
+		blkif->st.wr_req += ring->st.wr_req;
+		blkif->st.oo_req += ring->st.oo_req;
+		blkif->st.f_req += ring->st.f_req;
+		blkif->st.ds_req += ring->st.ds_req;
+		blkif->st.rd_sect += ring->st.rd_sect;
+		blkif->st.wr_sect += ring->st.wr_sect;
+	}
+
 	rings = blkif->rings;
 	blkif->rings = NULL;
 	blkif->nr_rings = 0;
@@ -399,13 +411,14 @@ void xen_blkif_interface_fini(void)
 		struct backend_info *be = dev_get_drvdata(&dev->dev);	\
 		struct xen_blkif *blkif = be->blkif;			\
 		unsigned int i;						\
-		unsigned long long result = 0;				\
+		unsigned long long result;				\
 									\
 		read_lock(&blkif->rings_lock);				\
-		if (!blkif->rings)				\
+		result = blkif->st.name;				\
+		if (!blkif->rings)					\
 			goto out;					\
 									\
-		for (i = 0; i < blkif->nr_rings; i++) {		\
+		for (i = 0; i < blkif->nr_rings; i++) {			\
 			struct xen_blkif_ring *ring = &blkif->rings[i];	\
 									\
 			result += ring->st.name;			\
-- 
2.56.0


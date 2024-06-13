Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861A130E40;
	Thu, 13 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296731; cv=none; b=lC3kWV4UNcGrTNG7CSkLcojVa5DO+2KV3yImemGzzPqlylzu0aPB23WAGjGIAqt2RbrjuSBshjePX1we3NEJ/pFqNNHQFXnepd6tIGZlUs/oWC6AQIB/9yDrt5tBFgeMdVfyfIWKf/iZKBPKz9u7dgayvTDTgYn5GT+R90KMwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296731; c=relaxed/simple;
	bh=WIWoLopAa7nL+GTMFCvAMWUmXOkjTNiVhQy5GnVLsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfpprU1R4AeVe00ciwo+68oCPirDF8fW3Os9ix+Ge0fuAGoZG5ybVz9C5VCE6iUzQTn5jFnoLIisxcdPIVlDk9HMndWdO8u2bL4JlUJmbsHZIB06EJFzVkS07UeEuZ754LNKMsVdc2Kpntr3sCNgL+9dnSK+2BwWORRyAI7rgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nqv9h1tq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4grW3Fo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nqv9h1tq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4grW3Fo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nqv9h1tq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4grW3Fo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nqv9h1tq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4grW3Fo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8541E5D596;
	Thu, 13 Jun 2024 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718296727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4nUkg9NVlWWxj+lARzOpGjJQ4KFFGWnMZ6IxK3R6c=;
	b=Nqv9h1tq8d3V5f+og17WGxk/37rb/aEO5qZ5oqjJHZmE5rJZ/SCjLSy53FnJcfEHDXlvOi
	KQCvgaZI5DsHstd4akI6QisHQUEsVrc4b8z92WwXlLXBv62kyPG/51g80e4oe4jPL1Z5T7
	ONYqBM8DInf1wItp2EKprryCcRMuoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718296727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4nUkg9NVlWWxj+lARzOpGjJQ4KFFGWnMZ6IxK3R6c=;
	b=H4grW3FoOR5J/zk+YHBtiilUpvsivCaHAvdqfTocg1FQ5LMlZ09UTE9/lgmQ4VHdU0s42Y
	amnMoUtJm2js2LBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718296727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4nUkg9NVlWWxj+lARzOpGjJQ4KFFGWnMZ6IxK3R6c=;
	b=Nqv9h1tq8d3V5f+og17WGxk/37rb/aEO5qZ5oqjJHZmE5rJZ/SCjLSy53FnJcfEHDXlvOi
	KQCvgaZI5DsHstd4akI6QisHQUEsVrc4b8z92WwXlLXBv62kyPG/51g80e4oe4jPL1Z5T7
	ONYqBM8DInf1wItp2EKprryCcRMuoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718296727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4nUkg9NVlWWxj+lARzOpGjJQ4KFFGWnMZ6IxK3R6c=;
	b=H4grW3FoOR5J/zk+YHBtiilUpvsivCaHAvdqfTocg1FQ5LMlZ09UTE9/lgmQ4VHdU0s42Y
	amnMoUtJm2js2LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74D9713A7F;
	Thu, 13 Jun 2024 16:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 06U5G5cga2Y1dwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 13 Jun 2024 16:38:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] loop: Disable fallocate() zero and discard if not supported
Date: Thu, 13 Jun 2024 18:38:17 +0200
Message-ID: <20240613163817.22640-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

If fallcate is implemented but zero and discard operations are not
supported by the filesystem the backing file is on we continue to fill
dmesg with errors from the blk_mq_end_request() since each time we call
fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
ends up propagated into the block layer. In the end syscall succeeds
since the blkdev_issue_zeroout() falls back to writing zeroes which
makes the errors even more misleading and confusing.

How to reproduce:

1. make sure /tmp is mounted as tmpfs
2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
3. losetup /dev/loop0 /tmp/disk.img
4. mkfs.ext2 /dev/loop0
5. dmesg |tail

[710690.898214] operation not supported error, dev loop0, sector 204672 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898279] operation not supported error, dev loop0, sector 522 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898603] operation not supported error, dev loop0, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898917] operation not supported error, dev loop0, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899218] operation not supported error, dev loop0, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899484] operation not supported error, dev loop0, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899743] operation not supported error, dev loop0, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900015] operation not supported error, dev loop0, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900276] operation not supported error, dev loop0, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900546] operation not supported error, dev loop0, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0

This patch changes the lo_fallocate() to clear the flags for zero and
discard operations if we get EOPNOTSUPP from the backing file fallocate
callback, that way we at least stop spewing errors after the first
unsuccessful try.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

v2:
   - move the code into a separate function
   - use unlikely() in the condigtion

 drivers/block/loop.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b..1153721bc7c2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -302,6 +302,21 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+
+	if (mode & FALLOC_FL_ZERO_RANGE)
+		lim.max_write_zeroes_sectors = 0;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		lim.max_hw_discard_sectors = 0;
+		lim.discard_granularity = 0;
+	}
+
+	queue_limits_commit_update(lo->lo_queue, &lim);
+}
+
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
@@ -320,6 +335,14 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
+
+	/*
+	 * We initially configure the limits in a hope that fallocate is
+	 * supported and clear them here if that turns out not to be true.
+	 */
+	if (unlikely(ret == -EOPNOTSUPP))
+		loop_clear_limits(lo, mode);
+
 	return ret;
 }
 
-- 
2.44.2


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4571405F8;
	Fri,  7 Jun 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751789; cv=none; b=BQDEIf5g5IOgU/FGdnspmVw//OsxM7PRqwW53i5eX10OVhbg5cGy/HlN2NS9dUNDx6y5b9NTbU3wzUCtqNtAGFu2K3YB0HFipxv9LP6XgXEZVm/4KO0aInsMnfQMif364I/DRuhkycKYnvCX8Jgwurp1AfPFTiowPn+VwvzWl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751789; c=relaxed/simple;
	bh=J1iEPJ3kSS7y0Kh1gVO3QoyMg5RlWljzZPeVPqAGHWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qj4jXhN474zMK3WkbmUClM2bE5veuGzaHRW65Z1bCWvW+2W9by91U7SdOeUCMZqIpmO7lllFKStd35yXQWZkq4zPUof2ZLgajgk+KPWmpZo6TUHAw4CCg+k+EgOpgKlnZvqukefjAVPelMQ5DVSYdjhxk8eeblc4i3A0UWga5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNlg/biH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kK7KAn+b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNlg/biH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kK7KAn+b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNlg/biH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kK7KAn+b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNlg/biH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kK7KAn+b"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A52CC21991;
	Fri,  7 Jun 2024 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=;
	b=LNlg/biHGPum4Bc4R1OrKDL9eSYMepFT1pXWpUzrN76bDqQzhgmGdvOlLJOfhgOXX2/27y
	KBDW+uJ4pIq7ITXlS6f/cAWT3juzQjfWdE+ZQ/82pBhKrb3rV7juQBjzltJ5OcG+VPUL7L
	iw7EyloetoN347RpdJ84PWDJtsl14rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717751785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=;
	b=kK7KAn+bBIHtsosPc98UNh1lRiQxt05qFsr2PkDnQgCOCxLMKJ7n6lbi+HP97WQYr6MryR
	d0KwLRox+kHE0dBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LNlg/biH";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kK7KAn+b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717751785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=;
	b=LNlg/biHGPum4Bc4R1OrKDL9eSYMepFT1pXWpUzrN76bDqQzhgmGdvOlLJOfhgOXX2/27y
	KBDW+uJ4pIq7ITXlS6f/cAWT3juzQjfWdE+ZQ/82pBhKrb3rV7juQBjzltJ5OcG+VPUL7L
	iw7EyloetoN347RpdJ84PWDJtsl14rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717751785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvfvtJ2vwLjq4w/MiB+bS7Kf8HpDDJ7m58lQDYUYOx0=;
	b=kK7KAn+bBIHtsosPc98UNh1lRiQxt05qFsr2PkDnQgCOCxLMKJ7n6lbi+HP97WQYr6MryR
	d0KwLRox+kHE0dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94AFB13A42;
	Fri,  7 Jun 2024 09:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6nsrI+nPYmZZHQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 09:16:25 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] loop: Disable fallocate() zero and discard if not supported
Date: Fri,  7 Jun 2024 11:15:55 +0200
Message-ID: <20240607091555.2504-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A52CC21991
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]

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
 drivers/block/loop.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b..315c76e3ef4a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -320,6 +320,21 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
+
+	if (ret == -EOPNOTSUPP) {
+		struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+
+		if (mode & FALLOC_FL_ZERO_RANGE)
+			lim.max_write_zeroes_sectors = 0;
+
+		if (mode & FALLOC_FL_PUNCH_HOLE) {
+			lim.max_hw_discard_sectors = 0;
+			lim.discard_granularity = 0;
+		}
+
+		queue_limits_commit_update(lo->lo_queue, &lim);
+	}
+
 	return ret;
 }
 
-- 
2.44.2


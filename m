Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414063;
	b=Uom7sF7yW15phuhoAnuPoGoc5cSPl8pCgVm1bWzW/4lfWsoEwnFLYCmmb3tlgdfZjZxL
	 ZlMGBCXDgnadpMvJFdDDluWD9iW+1gaqeCCeFyVltUt9nqJ7QNwQ+3AMtdKeaaflcO/PU
	 /A2RxPA5HYNw9XO6tEkEwD7MWW2LAHVCfP7r3QfvrVkjwPT1LT82qHyjmIGbvCReBDaKv
	 UbKYyU+36TqcQZKbZdFCUq4yQc6XxmMjx3XbfN6LaCZmgsTv0xOGJEhVVEdVNouR0cptx
	 uLIrE/zAbCYsv5F1Nt7HVTWUMRZdROY6a6bzCSbCVS0Q5oYICnEWinZqOJisRWFYP9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414063;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=ovtHzQePYK6PCYm9IDijsu/IhzPBWBbP8apsONau8Uw=;
	b=lpNwgar4s810Bf6EJmd57RU8++vqTc3aTdPuhFI+9GDzHm8mK3KBFOcN7czVOCldx+vB
	 qGzFsCISPTSlGRB1TkQ30PDXTNvslSM+v/zNzyeyce5cFXvfANqRvsZO/VWT//iSQbali
	 2RG+V0szg0K2aOi55z7B12lN8ZohfrTvb9AtryWP1d2jiJc99+I2n6dlCR2Wzjz9nP9Fu
	 K6H60cOqJe78/j8EOQ2b91ICmd1qcSMG7SkGSnf/4VmVi4c7YKNj8Rki/0Ca3QHPM1Hk7
	 ay8pejUMCGo8hw6Wn7khrdbFd47/DN3OP8p2Hn6w1W7OGl9B+Q5OwjfycZ2QWUZlUcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=fv66gJBZ;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=fv66gJBZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A4606A339;
	Wed, 11 Nov 2026 16:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C07A4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=fv66gJBZ;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=fv66gJBZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1B6121EF2;
	Wed, 11 Nov 2026 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ovtHzQePYK6PCYm9IDijsu/IhzPBWBbP8apsONau8Uw=;
	b=fv66gJBZLsCDMyh5pQG7nVcNzpA4yEh5AkPU688Q2KboxeRUP8ND+MObvTOI6ypgmPCLgh
	b6jD39b7EXsl8DVih6dxXGA8lQxtrQh1Yh53VC0S3LdWVcchCZuYBFQ3BrsYLjHotRw2Il
	0m8t4Iruy5nISemX984c+bhGJve4V1Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fv66gJBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794414060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ovtHzQePYK6PCYm9IDijsu/IhzPBWBbP8apsONau8Uw=;
	b=fv66gJBZLsCDMyh5pQG7nVcNzpA4yEh5AkPU688Q2KboxeRUP8ND+MObvTOI6ypgmPCLgh
	b6jD39b7EXsl8DVih6dxXGA8lQxtrQh1Yh53VC0S3LdWVcchCZuYBFQ3BrsYLjHotRw2Il
	0m8t4Iruy5nISemX984c+bhGJve4V1Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54DCB134E5;
	Wed, 11 Nov 2026 16:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wT6iCuyV9GrxAgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 11 Nov 2026 16:21:00 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 0/3] xen-blkback: do some I/O statistics rework
Date: Wed, 11 Nov 2026 17:20:55 +0100
Message-ID: <20261111162058.804033-1-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B1B6121EF2

Some rework of the blkback statics data handling.

Juergen Gross (3):
  xen-blkback: Remove statistics logging on console
  xen-blkback: move statistics data into sub-structure
  xen-blkback: make statistics data persistent across disconnect/connect

 drivers/block/xen-blkback/blkback.c | 39 ++++++-----------------------
 drivers/block/xen-blkback/common.h  | 22 ++++++++++------
 drivers/block/xen-blkback/xenbus.c  | 22 ++++++++++++----
 3 files changed, 38 insertions(+), 45 deletions(-)

-- 
2.56.0


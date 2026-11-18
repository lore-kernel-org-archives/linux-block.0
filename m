Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991354;
	b=NcZT9WWeDx2qxZL9Q1YIvkR7avzod5rbJJItUYwX4WsjNilPnYKI4GQaBdAS4F5orsBF
	 1HjPQMuQQxlGiKsZcHZkWm4M9ZOECJ829WUH1tX4woDdGy5nYDXRp+MCOgAnaLZrjzgJ+
	 oNhObafYGjVkuZ4TEG6OzFJjBOhtM6tG6bfFbzJ6KNGLrA45Imx41DOgkES/Fx6hSKklN
	 IMsAGZ1PsetvpkE5G04pnf3uDvEBHj0+yTqKstx5becgXqo3mYtCBh/Mq5SpWEXGvZKeF
	 PF+zgY8hTd4ZTkhsRNIJxEo4nxQDvadY8SRxeL1AiETR3XcSKR9SnkKcKHsmLU+tqgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991354;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=Oj/ln2HN3I2OuZvLU7qgfD4AI5z0SOg7zq1Uq16/Kyg=;
	b=pgV3rBdI+JxtWd5mFbs5ek8s+Y2ISMLTitdLLeOtTtGQcSKAOIp06s0ZlChOZd4Ns7dO
	 GWu2UYQRRah+RVwx9Pfq6qJGmCb7C5q8KvfD4KJ7f4QJlbxs4BaS/mBq8q+OEE7Wb3R/m
	 8Jn1T3RqmZ2JLVUOpLOuj/83ndEgfR2iMK349KTrPeBkYknOHIRDhNd9W9gX0q3S9hqqu
	 VgWOWN5/ePocu5qUOxbKvqaWw/7GXA4DYHajvr5C1XiH0idEpFm9x9sNJaFN54nGo8nV0
	 Q58OfRrT8rJam+/4mz4gjXmrC7/fuoUwyWhOZ7NkHJ74VGubBTohWdZIFfohH4aJKtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4H77+Pw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KpxU0FX0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4H77+Pw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KpxU0FX0;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E0606A88E
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1E0606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4H77+Pw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KpxU0FX0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4H77+Pw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KpxU0FX0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 224B321E66;
	Wed, 18 Nov 2026 08:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj/ln2HN3I2OuZvLU7qgfD4AI5z0SOg7zq1Uq16/Kyg=;
	b=y4H77+Pw8QjNUtQY87ZD2pqcKkaGOjJ2Vys73Bx3Fr5wOotEp5/kkEJjn1tEIiYMe8POsL
	Iw+oO5AS31ajSERkMKRqufxVjhsDI/FRbkD4n55ZKKDltq/y4znHCQFe6gVyzKo1pcdYju
	+SBzo2eM2iKPJsXrrOVTF6AtxHpORYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj/ln2HN3I2OuZvLU7qgfD4AI5z0SOg7zq1Uq16/Kyg=;
	b=KpxU0FX0PJlmTYiyL0uOPB7YmlfFIT/brrZ5TZQ3y/JaU5reG2AXvZmKlLv8eiVbDo5V6H
	HlCDLpwRVP7ZIpBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y4H77+Pw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KpxU0FX0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj/ln2HN3I2OuZvLU7qgfD4AI5z0SOg7zq1Uq16/Kyg=;
	b=y4H77+Pw8QjNUtQY87ZD2pqcKkaGOjJ2Vys73Bx3Fr5wOotEp5/kkEJjn1tEIiYMe8POsL
	Iw+oO5AS31ajSERkMKRqufxVjhsDI/FRbkD4n55ZKKDltq/y4znHCQFe6gVyzKo1pcdYju
	+SBzo2eM2iKPJsXrrOVTF6AtxHpORYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj/ln2HN3I2OuZvLU7qgfD4AI5z0SOg7zq1Uq16/Kyg=;
	b=KpxU0FX0PJlmTYiyL0uOPB7YmlfFIT/brrZ5TZQ3y/JaU5reG2AXvZmKlLv8eiVbDo5V6H
	HlCDLpwRVP7ZIpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6D97134E9;
	Wed, 18 Nov 2026 08:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6asK/Jk/WrfTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:26 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:23 +0100
Subject: [PATCH 3/5] nbd/003: skip if mkfs.ext4 is missing
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
Message-Id: <20261118-skip-missing-deps-v1-3-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
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
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 224B321E66

nbd/003 runs mkfs.ext4 without checking for it, so it fails instead of
being skipped on a host without e2fsprogs. Check for it in requires().

Fixes: f7b47c58e87c ("nbd/003:add mount and clear_sock test for nbd")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nbd/003 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nbd/003 b/tests/nbd/003
index 4fabdebc8f6a..fdcfe0182653 100755
--- a/tests/nbd/003
+++ b/tests/nbd/003
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_have_nbd
 	_have_src_program mount_clear_sock
+	_have_program mkfs.ext4
 }
 
 test() {

-- 
2.56.1


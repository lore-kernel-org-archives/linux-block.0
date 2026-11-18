Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991355;
	b=HhlEqz/UOwDbMUHu/xedr5X2UvPF3zZTW9Kt56duuwmyEPJwUZhm7F1+GSpkHHVSpaxF
	 zQ9A0S/dLkTbhBTJy1qERqqSPWj7pNLBKAZDe2O7ycl+PK8oEmplCmM1erqGr5J1MZLU7
	 eIGyqsElv4yKoO0HDKCx0yO/vLs6IDU6BiQB0dTywnSCWvUcPiz3TGDslroJO89h4zP4C
	 hck3LmJU7SxLS4/5k6C00D4gD7MeK0ApzALFH9u8lpHsaRb/3gymOg4XHpE053Pvsegtr
	 37YJodzFDEOou0qXS32HJjiSXWpkGSWNnc+rk7vtkkjt0KKOztA3R+XHPLT/aNpRfQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991355;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=pEVr5iiJYsEiInfBFuDaXu6hyv4OnmV8KJEF4DSAeqGqTxbR55Sqlfx7wf65cBsAsVqw
	 2J2NYAdJCZkYi55gzaPSI4Lm144dcmaC5h1Cua3kgP8v985zFaZHaG7h9HVdkrg2qHVA9
	 1fI0E7HCYDpwBFBb4Bj+Qb0Rj2Emq2LzvYChKdDgcw/MQXKJbHLspdHW3RcgUajn1x06Y
	 2AefgX2xbWSNgvnVGjjoaqCt56XGZ2bVufoYPUiVEDb/QGtp735sHgFNWU1xClsf4Abf9
	 JNCsVW9C8yZwtDipezqVDbTwaOoGFRQYJ4PM1nnRmopPjzjeq3oHjWbEGWg+vNKy6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="bw6eRs/k";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="bw6eRs/k";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25E606A330
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A25E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bw6eRs/k;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bw6eRs/k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YXA2qfnt
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A9A21F7CC;
	Wed, 18 Nov 2026 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=bw6eRs/knqf8gHKfwQCl5w4vo+ZpyWzzRwxX6JVXsT9SRCnXlI6BI2KwDmhtV4FLULxJgr
	2j9+FRDHv4wZ2iH8fgdopnVlTBbZ66ySRm9ktEsx98jE684zDnlBCParkt2WQ+IV104vWq
	gdBJEJyHDer8xrxlgp6z5ST+wA4QlZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=YXA2qfntGus0fvyx2cgRudfFg8mp2bck06/nEpbwVll/NYc+V0YlvUAjtyeqvjEIUEgjs3
	wFe1OrxgwqWf02Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=bw6eRs/knqf8gHKfwQCl5w4vo+ZpyWzzRwxX6JVXsT9SRCnXlI6BI2KwDmhtV4FLULxJgr
	2j9+FRDHv4wZ2iH8fgdopnVlTBbZ66ySRm9ktEsx98jE684zDnlBCParkt2WQ+IV104vWq
	gdBJEJyHDer8xrxlgp6z5ST+wA4QlZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHPIeTIdoyMxv1inp0XOK44VmkqKh9j4OW9a476K2/A=;
	b=YXA2qfntGus0fvyx2cgRudfFg8mp2bck06/nEpbwVll/NYc+V0YlvUAjtyeqvjEIUEgjs3
	wFe1OrxgwqWf02Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41929134E9;
	Wed, 18 Nov 2026 08:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RMHpBvlk/WoMTwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:33 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:24 +0100
Subject: [PATCH 4/5] block/009, block/012: skip if hexdump is missing
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
Message-Id: <20261118-skip-missing-deps-v1-4-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30

block/009 and block/012 compare the device contents with hexdump, which
some distributions ship separately from util-linux, e.g. Debian in
bsdextrautils. Check for it in requires().

Fixes: 576668a4a6b1 ("add: Check page-cache coherency after BLKDISCARD")
Fixes: 3aeec46f048b ("block/012: add test for BLKROSET/BLKROGET ioctls")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/block/009 | 1 +
 tests/block/012 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/block/009 b/tests/block/009
index 8995646e5d21..1e3bc8ece8cf 100755
--- a/tests/block/009
+++ b/tests/block/009
@@ -14,6 +14,7 @@ DESCRIPTION="check page-cache coherency after BLKDISCARD"
 requires() {
 	_have_loadable_scsi_debug
 	_have_program xfs_io
+	_have_program hexdump
 }
 
 test() {
diff --git a/tests/block/012 b/tests/block/012
index c92f5b4b8dd2..430a3ac7f0b6 100755
--- a/tests/block/012
+++ b/tests/block/012
@@ -11,6 +11,7 @@ TIMED=1
 
 requires() {
 	_have_program xfs_io
+	_have_program hexdump
 }
 
 test_device() {

-- 
2.56.1


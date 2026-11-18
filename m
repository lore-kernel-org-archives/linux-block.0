Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991359;
	b=V72bvnFBHlm/AiSRnHb0eMA10TFUXm1yyZhb1xl2FJWCVQ3Q2j4yt/jsKg/yzURaVXQ4
	 con7CEQF8b3hRSK1eO0Dy/MOhAupm6jy/jQcA2G2957WNZWjIDYJN/FshU1ufodBvf0li
	 EPCflpUn4zD8YAZ4htAkDmNm1+wDt1M5xKrDlIGDntewS8uumiGY7zv0ESsdA4xgUBPBk
	 C2KuShVcoyeMRQPleabrXScs6MMqfXucxIHp3I9u/oZkwyOofh+nHFKZIvh+YdobwrpLw
	 qN1gnyhCFGrr9ukI36M0x+L5l964PxHB61MTuwBtS5vqNT4Xu+VbEr2rDD9zRsnyexg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991359;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=DPURHpeVscEk5DGm5z+p0HGWC1+6BaSZbPmok+lBrbg=;
	b=coOX3ZMlj9G5NLRTMr1Mo3cHbb1oakhUNm7LvS8omgZD8dUPTQGueQRU+queHQSIVtzp
	 Z5IOpmfYLfh0AwryGVUE+TeplFgzdM0hM76rP/IdyXm1AwQe6/3Wa9+zapfmfXlpxnLCN
	 agF2st/9KMyoR5ZFCRB8pGhDw3i21rIEz8XLz1fodThgBKns/rAUW6WzfqjLxDJTEYLZ9
	 w71s24ErLcBMpQh7HQZrI/hLI1XvQYxlqr6k8kaTw+A8Pmez8JT7ENfcyCA4LXtsnry5n
	 bfVHwA0nEY3iRhHpOwXnlYIp8TJN+Iho/F1o5Mqsu3i5VgpwN38uOD0u334jGS6REyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bVrNzIWe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="t7+f/cjI";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jfAzeqgB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IAwakQlw;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1B606A890
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E1B606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bVrNzIWe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7+f/cjI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jfAzeqgB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IAwakQlw
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3C4322376;
	Wed, 18 Nov 2026 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPURHpeVscEk5DGm5z+p0HGWC1+6BaSZbPmok+lBrbg=;
	b=bVrNzIWeoOsdOyXMA2CnI8FM962wGhdolIem2VU+5Nd6yeWwCyfgqLDTHicW3dy7xQv5au
	s8/QxKo5OTWVvQafY7K6IJcUHNZBi7j2596Azjto6aGvWgEAuFEjsLUcCh+xMubTsgdYM1
	rPMIuj22jaxn0g4Y+XhtBh6oJZjRPsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPURHpeVscEk5DGm5z+p0HGWC1+6BaSZbPmok+lBrbg=;
	b=t7+f/cjIxNNUX4cezod3TgITQh1cbQ83e7qifktv1v0gpTSlMDiJKJ4c9Ky/HUhtiIBYXc
	wJY1APYtSYWrrYDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jfAzeqgB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IAwakQlw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPURHpeVscEk5DGm5z+p0HGWC1+6BaSZbPmok+lBrbg=;
	b=jfAzeqgBT7kz+GMSzC9K+u1QL3UStDxC1YQobVvYprWCGmEhmMTPzPAjmhnHorsHVcwajr
	MzeiS4nmVVjdefzB8b5s4QD11nvnm36Omf3a9Ij+48zNTAGTBf949Ocp0DBQDrv1lqZPzX
	852VB2rO2wvu9hfLYGneWwyGeg3TKug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPURHpeVscEk5DGm5z+p0HGWC1+6BaSZbPmok+lBrbg=;
	b=IAwakQlw6y8/I8s4q5a7LKxT6kETpBCNEQSkgwIb8yNP7ZpsoOeiuiLhftraLrvE4kAlMz
	luV4QjHMWC7VtuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9DEC134E9;
	Wed, 18 Nov 2026 08:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MT9LIPxk/Wo+TwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:36 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:25 +0100
Subject: [PATCH 5/5] zbd/008: skip if fio or hexdump is missing
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
Message-Id: <20261118-skip-missing-deps-v1-5-a9b4a5a7cc94@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: F3C4322376

zbd/008 runs fio and hexdump without checking for them. Check for them
in requires().

Fixes: a2737bbd421a ("zbd/008: check no stale page cache after BLKRESETZONE ioctl")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/zbd/008 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/zbd/008 b/tests/zbd/008
index cdfbedfd7976..480b3d55a122 100755
--- a/tests/zbd/008
+++ b/tests/zbd/008
@@ -15,7 +15,9 @@ TIMED=1
 requires() {
 	_have_loadable_scsi_debug
 	_have_module_param scsi_debug zbc
+	_have_fio
 	_have_program xfs_io
+	_have_program hexdump
 }
 
 test() {

-- 
2.56.1


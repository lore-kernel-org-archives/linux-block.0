Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643C55792
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014460; cv=none; b=bdyuGHen3+Yy3Einxvrim4TXKCXMHnPHmARxiSVhnmr9yt8B7OYgX+75pSSALVVy9ckpe67UkwHxZUu/WqG/cyVGyG6Q2sO9XR/b+sVNMXHXzELS4YkHnXrLNOSLz5no85hgwFsDZSFGBUa7UBCmeKsmkrrlYIDhDUofLRfX29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014460; c=relaxed/simple;
	bh=427UI0q+gFxS02r9zeJ677KQIVMVpQvHECRYTSpZaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vzi55DrYzskkCxPj4i38LV2dH4HLpq43nzDSq94aDBn6f9vQ9bUTm7VaywrvYB4Zwb61LzIcDX6+WOpscLwoE+DsbKkfQg+2XmLnsIGuWxXwMLmTcosNIBQUZt0Uxxc9NsieXQB47JrPgACi6ATSgUjO/lvPVlCpEym0uGlKCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c0U/kVyG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G71NIniz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wD1CJSp3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gdGUj4GT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0U/kVyG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G71NIniz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wD1CJSp3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gdGUj4GT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEAA137159;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=c0U/kVyG/Z5I9t/Uo1NSqp382Xjk9hs8voGPPx3bg8hXlft6HgWQXk/ljd3dVBOTwTAzku
	+CPYizW2NdmY47EICtgXxli45LsGYOLYeL2jPH7jshnqDetgW7aA4Z4L7vrUAZyxShK4oO
	9KyWrQhKQKOoF4V75Uachr99Q72P6Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=G71NInizG4SRjfq8/GCxgFm/RfS1A59V2pDL6Nf7lsu9MnnBcErqBAi48CuKuYCHBnQNfP
	ycP6W6oEUY5ABIBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=wD1CJSp3q7eT6Unx592irbm3bhb27hnWdevzykN0J0IMUgDp0CGTvIlViHx9IAs1uhpG0r
	HU5dTlU678vyJq6KukaOXRimiWTe2RYhE/dg8DRRHnS8VJQFTFTfblv9hqRvlPGMhKnSJW
	PbqhxWy2gVaZINtQIZAS5mMKFqRxtsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=gdGUj4GTxWjzmEX0ot4BZ6d2Y8u+0bpdIJNPKqCV0oA8miMhKeBK3w8WWqHx/yMscd139t
	cAvFhXOGkqf6NACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA2113976;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MnJuNDIC/GW2DwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:30 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 01/18] nvme/rc: silence error on module unload for fc
Date: Thu, 21 Mar 2024 10:47:10 +0100
Message-ID: <20240321094727.6503-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.37
X-Spamd-Result: default: False [3.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.976];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.35)[76.46%]
X-Spam-Flag: NO

The other transports silence the error output when trying to unload the
module. Do the same for FC.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2d6ebeab2f6f..78d84af72e73 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -332,7 +332,7 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
 				"${def_remote_wwnn}" "${def_remote_wwpn}"
-		modprobe -rq nvme-fcloop
+		modprobe -rq nvme-fcloop 2>/dev/null
 	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-- 
2.44.0


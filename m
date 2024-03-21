Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EED56B76
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014464; cv=none; b=mPO0tTaf3oUQ828mV+wVWUE5nnEc3Me33QDj6ssD9mwD1hwP8mnLJyvENHMj/E4vh+kVHRbcv48yuGgwZCQY7Nf2DKQZJGQ5vIPvms/OPIVmVRzqPvEqaaOmU1dLoE+VkDQu4IGi0lMhJEWZ0U0BJ910mPaS0OK5mLIMb2zB8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014464; c=relaxed/simple;
	bh=JqKE2N8SMV1Emk1mDNVMBkXmRjUMBJQkCJuJmbGqV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKgtSv85EivdcPaR9bodMVKpwvTubGtHyVomRaDgh+fAON41hkgGCzta1SmmrxbS7ZSvgR79jVZfvnJZb2u2rhVzryB4Syu2Ip8oFkcySdXtPXxqtgw/NP9taZXZRxnoYeK8Jgr4hbmM3xb/oJkKs+vWztc8FpGj4grB9d2GA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RVslSzAr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//TN9HGf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RVslSzAr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//TN9HGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RVslSzAr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//TN9HGf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RVslSzAr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//TN9HGf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58C385CBCC;
	Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=RVslSzArKJDfiohV2a64oRr66E2t9iyYVMre+McVXgiFpE1lYG9GwzbffINPUXq0EQgw2x
	tH5oXgSZ5atahwqt+HhKpejs5RFKNGaRksQDaAm16x599pPYfvkGImZp27bhUiHi5AU8rE
	7pEF2aNlBeGv4Nt8tY1TVezDnQs/uKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=//TN9HGfmgPwoXTbvT7zWssKCS+o3+Xd0GfTV9fOKY/DUwJoRwmU1H4WacIAtemWyUmVnk
	1oV2WKSB1EeErvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=RVslSzArKJDfiohV2a64oRr66E2t9iyYVMre+McVXgiFpE1lYG9GwzbffINPUXq0EQgw2x
	tH5oXgSZ5atahwqt+HhKpejs5RFKNGaRksQDaAm16x599pPYfvkGImZp27bhUiHi5AU8rE
	7pEF2aNlBeGv4Nt8tY1TVezDnQs/uKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=//TN9HGfmgPwoXTbvT7zWssKCS+o3+Xd0GfTV9fOKY/DUwJoRwmU1H4WacIAtemWyUmVnk
	1oV2WKSB1EeErvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481F113976;
	Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSgqED0C/GXxDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 18/18] nvme/028: drop unused nvmedev
Date: Thu, 21 Mar 2024 10:47:27 +0100
Message-ID: <20240321094727.6503-19-dwagner@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RVslSzAr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="//TN9HGf"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.95 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.94)[99.73%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.95
X-Rspamd-Queue-Id: 58C385CBCC
X-Spam-Flag: NO

Nothing uses nvmedev, so just remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/028 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/nvme/028 b/tests/nvme/028
index 4710bba1f416..9f4a90581984 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -20,15 +20,10 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
-
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-- 
2.44.0


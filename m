Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD413C69A
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479435; cv=none; b=K01xQqSJkwyUpyJLme6ZuQwhQmWyATaHO96Qd8p+MNQrZBJQDyKCKkw6/sejxdGmu13zFBLclCSNgP7LbtNDkiyHiKT4hfwFRsjTfTA61DCSPL8qMPgZojkxmrmet3cMk6Df5MXv8Fbfm9qT/IuCCPDd5JB+aDVM3Wp5igitGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479435; c=relaxed/simple;
	bh=AR6zqvdAKOqbvcSCNdVoIrsVo814XjFKli0AhWq7oaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpzjQv8tCjbgpwpyTqnGbHgZw1yR6hbPknwWc0ElQKS89nLd60WWyUzUdWm77MDYq95dxgi3DMKK2mucqHXWWyMtEysY3jUS2FfdNfglaWmrIcXYF2kBtJ9ZEP5ocPBIhb3LSEKGoOp/kTG70OcEoJEaRLpyf1Ypi+xSGl6yN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nEIuchUc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pzKpR2xX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nEIuchUc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pzKpR2xX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nEIuchUc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pzKpR2xX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nEIuchUc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pzKpR2xX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 415D01FBB2;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=nEIuchUcGD43EelAryCcNYc66hdkWHRb6BlptaF1wVKvBXO4dh9KLMlMw13dB4af9v9EQr
	jvL+ta1W4mlKmYKBX6ie9DuyBPrXd4o5iC0NZeInQ5z+c+TpG7Fjhokka7dKWLIRl5kuQv
	GRypWCJt/qrUlL9XXq1bOUwDjPzofgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=pzKpR2xX8wEsHtb49chnzo95DW1vchReri9mlar9zEzd9ojEg9ho6CurNFtIXkw2TzOVTo
	MzLzI9omNGZjvUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=nEIuchUcGD43EelAryCcNYc66hdkWHRb6BlptaF1wVKvBXO4dh9KLMlMw13dB4af9v9EQr
	jvL+ta1W4mlKmYKBX6ie9DuyBPrXd4o5iC0NZeInQ5z+c+TpG7Fjhokka7dKWLIRl5kuQv
	GRypWCJt/qrUlL9XXq1bOUwDjPzofgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/2zxRrftkm3PhLdkZY5e2sc9YCePDPdk4+R6WJPSbI=;
	b=pzKpR2xX8wEsHtb49chnzo95DW1vchReri9mlar9zEzd9ojEg9ho6CurNFtIXkw2TzOVTo
	MzLzI9omNGZjvUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3289D1384C;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hQt0C4gsfWbAFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 09:10:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/3] nvme/030: only run against kernel soft target
Date: Thu, 27 Jun 2024 11:10:15 +0200
Message-ID: <20240627091016.12752-3-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
References: <20240627091016.12752-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

This tests is exercising the target code and not so much the host side.
The problem with nvme/030 is that it depends on interface to interact
with the target which is not covered by the standard. Thus we can't
run it against a real target. Just skip it when we run against a
real target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index b1ed8bc20908..ae7081d55354 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4465dea0370b..5e2e440ccd47 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -225,6 +225,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_nvme_target() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		SKIP_REASONS+=("Linux kernel soft target not available")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.45.2


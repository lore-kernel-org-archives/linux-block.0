Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF12D043
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754754; cv=none; b=VzNsr7f0ZDwWLUfEshTynJon1Cxu9FgnS7Q7p+RdJuxmYDEketn4sjsSN1BA+8Im+Xta3o+H5zj1v5ZSuzv6Ru9YFYErzKTEgQJVKlkt6caEot8ku8IexGByq/fKU9YfqEFl4OgOQ++abYXjob+21D8jydYWBHgPqvH210RCx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754754; c=relaxed/simple;
	bh=Quic52JaxahkASnvqi0v7mHdMYzimRmyk2u1RB9VgK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGRZBR5cB5xEcleTZhHEVxHj0DbZrahhtHicBt5aH80Y2Mzybe38nKIZQMDB/n7pqxUzGjH3MbfFdOHjNJABzzWgarSSC2S24Lb/LckzUju2kEnltI3rSBz2qiCeNbfV6xcBQuR9P12QAJNWDJTEb2so71kpCiVO64JJI5O4+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uK/9Q4iw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F4f3UHsk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uK/9Q4iw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F4f3UHsk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uK/9Q4iw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F4f3UHsk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uK/9Q4iw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F4f3UHsk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8325C33A;
	Mon, 18 Mar 2024 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihE/ZmLSZBt2P9PqVkuN+IyPeedmfxE4zSjNnO6UW7A=;
	b=uK/9Q4iwyelsxoetRQBPSDL/NJsL6yyLbnSXoQN+zksJLJc6lUUv1Q6QkWHm17USMze42F
	zaX76iG60a4KcYcx+MagV09fHbGCBsuHZomGAXgcg7wdaRkjTOcge4ixjFs+eqbNl8jf0B
	wzU04ZYgG4DLHnHHd2E3Ho2v0GUxBUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihE/ZmLSZBt2P9PqVkuN+IyPeedmfxE4zSjNnO6UW7A=;
	b=F4f3UHsk+QVoNVSdbhDgAe7Qm4QCoJg3YfLOQBj2Dgfl30rH8URh7fDJv+vOjlfhaqPnA9
	xB8jCt2RjAba4OBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihE/ZmLSZBt2P9PqVkuN+IyPeedmfxE4zSjNnO6UW7A=;
	b=uK/9Q4iwyelsxoetRQBPSDL/NJsL6yyLbnSXoQN+zksJLJc6lUUv1Q6QkWHm17USMze42F
	zaX76iG60a4KcYcx+MagV09fHbGCBsuHZomGAXgcg7wdaRkjTOcge4ixjFs+eqbNl8jf0B
	wzU04ZYgG4DLHnHHd2E3Ho2v0GUxBUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihE/ZmLSZBt2P9PqVkuN+IyPeedmfxE4zSjNnO6UW7A=;
	b=F4f3UHsk+QVoNVSdbhDgAe7Qm4QCoJg3YfLOQBj2Dgfl30rH8URh7fDJv+vOjlfhaqPnA9
	xB8jCt2RjAba4OBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B27139A1;
	Mon, 18 Mar 2024 09:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bP8zCL8L+GXMUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 10/10] nvme/030: only run against kernel soft target
Date: Mon, 18 Mar 2024 10:38:56 +0100
Message-ID: <20240318093856.22307-12-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.68%]
X-Spam-Flag: NO

This tests is exercising the target code and not so much the host side.
Thus just skip it when we run against a remote target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>

merge
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index 9251e1744f61..6d51e0ada07c 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_target
 }
 
 test() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 35eb4cc5e954..41ec30af7787 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -185,6 +185,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_target() {
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
2.44.0


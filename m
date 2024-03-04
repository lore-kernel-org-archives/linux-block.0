Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F4487BC
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568792; cv=none; b=MSdn2ENzGJdZLH4yXDusPOKGwIc1YZRvntGM+rfD+eXDloqbdJjMxWPyJ0JBbxx6/2VteGelW8BF6EmlJQlqs0jX6HdQhYG5D7vAmUBs9sfZXRncXY2s9O9A3hEFExPHPPJ7UJIPyASHFYrCMpmKgaSbl7QUVbw7dPu1/e3K8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568792; c=relaxed/simple;
	bh=DGhBRdk12GbpigB1Yey6yaiVh7uj6W7S3ihJc2/UpBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRL0UMmSPde83Xg7Hm+Ahfi78qxU7VkLSrGbJJZI7aFk/y78P2dIG7kZ792aKv4jc9RV/R6hvzLbV3vjgve8ZjI4sO4yoeSdBjFXOYkrhASTEJWKSne4+Q0FNj+oooK6L+ISjvyeO+I3LUTCNDWqhkR+XbfiJTgTFxUX2GdWSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OMq4djdn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66e2w2w4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OMq4djdn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66e2w2w4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OMq4djdn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66e2w2w4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OMq4djdn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66e2w2w4"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1089221C9;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwhifBsP50/OuPcCY1SUaDMyx7CnuqI2f8QeBy4NTg=;
	b=OMq4djdnkeM8IJYL7rX9cbTKJ8ziapWvO8y15xiCUFMoOjr+SBqcuhHosmpO9U74gdk7NI
	RhfUMG9AzKBwVuRFlUndaVaRXZely9TBg/POw07+Yo9WdcktZcZM9nA9vAYZw35x5nRQ+l
	yodB2YzdIDziEJeTAi05QSpKH1luWGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwhifBsP50/OuPcCY1SUaDMyx7CnuqI2f8QeBy4NTg=;
	b=66e2w2w4Beylr2ZOoiQSH4MQphop0Slspn4n9HsV6EtNvx1qhqqur2kGiMwQylS0L1+yQ1
	bAqEBaqylvA1L4Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwhifBsP50/OuPcCY1SUaDMyx7CnuqI2f8QeBy4NTg=;
	b=OMq4djdnkeM8IJYL7rX9cbTKJ8ziapWvO8y15xiCUFMoOjr+SBqcuhHosmpO9U74gdk7NI
	RhfUMG9AzKBwVuRFlUndaVaRXZely9TBg/POw07+Yo9WdcktZcZM9nA9vAYZw35x5nRQ+l
	yodB2YzdIDziEJeTAi05QSpKH1luWGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwhifBsP50/OuPcCY1SUaDMyx7CnuqI2f8QeBy4NTg=;
	b=66e2w2w4Beylr2ZOoiQSH4MQphop0Slspn4n9HsV6EtNvx1qhqqur2kGiMwQylS0L1+yQ1
	bAqEBaqylvA1L4Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ABBE3139C6;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Al95KBTz5WUaewAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:13:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/2] nvme/rc: add reconnect-delay argument only for fabrics transports
Date: Mon,  4 Mar 2024 17:13:02 +0100
Message-ID: <20240304161303.19681-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304161303.19681-1-dwagner@suse.de>
References: <20240304161303.19681-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.86 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.56%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.86

The loop transport is also considered a fabric transport. But not
connect options are supported, in particular the reconnect-delay option.

nvme-cli can't figure this out as the kernel reports the option support
for all transports (union). Thus, we have to filter out this option for
this loop transport in blktests.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2d6ebeab2f6f..5facbe8f2d2f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -122,13 +122,25 @@ _require_nvme_test_img_size() {
 	return 0
 }
 
-_require_nvme_trtype() {
+_is_nvme_trtype() {
 	local trtype
+
 	for trtype in "$@"; do
 		if [[ "${nvme_trtype}" == "$trtype" ]]; then
 			return 0
 		fi
 	done
+
+	return 1
+}
+
+_require_nvme_trtype() {
+	local trtype
+
+	if _is_nvme_trtype "$@"; then
+		return 0
+	fi
+
 	SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
 	return 1
 }
@@ -513,7 +525,8 @@ _nvme_connect_subsys() {
 	if [[ -n "${keep_alive_tmo}" ]]; then
 		ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
 	fi
-	if [[ -n "${reconnect_delay}" ]]; then
+	if ! _is_nvme_trtype loop &&
+	   [[ -n "${reconnect_delay}" ]]; then
 		ARGS+=(--reconnect-delay="${reconnect_delay}")
 	fi
 	if [[ -n "${ctrl_loss_tmo}" ]]; then
-- 
2.44.0


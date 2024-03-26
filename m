Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC697580E
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458858; cv=none; b=p2teFGhgO+3FxVZGh+f0lDZAm65ipJhWTUNlxny0WIWAYbgEL1xpwxO0AfNpbpdth+AATjUOhCcOLq5RQgkxJi5zkAH3Ww6f1z2FGCJ1sk5iQxLoJ4oVdEFB2FwF4oeekWL6bMkU/Ujl0RuOLMTu2mWNlvzFr11lCXXZvm7XUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458858; c=relaxed/simple;
	bh=8FTG64vvVBMMD6INy+QP3ubqYs6kS2IGcvffk6/eX18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfB8ebEDZEfgsU/Y1ie6Hby4Vi5n9VxL2c4SO4Ghv2RFvF0NnHk6zW5bg+k7BGycuqeBAU73ZGAq7/T1sk//WWl3oVQzp4r2Pg7b9qOw75dJhWU9JToLv/JzCq4JuTn3tT20T3TW2+u2blB6oKQMLYPXoWQ9zG1xmoOy1pJrJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRqnJBmu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mQR7TVNt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRqnJBmu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mQR7TVNt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRqnJBmu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mQR7TVNt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRqnJBmu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mQR7TVNt"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AA0F37C51;
	Tue, 26 Mar 2024 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnFAh6yCTmKI/Y+oikSQG++m293PK8pS6qKLAj5RedU=;
	b=lRqnJBmu66DcaAqmLCDuSY+ydDx7R2VSxTHZCsvfu1yhNnrKFPRHpsE/5I4/O+PPqB/tgi
	alKehllrcDqau9YiF4bPNihcOtLtsE5ml2r7wWBbq5je9B1ykH/2BpvM1sSSv7hmrK/dQo
	Asn/2BEZ1JaiHlnEbCTNjUeJPIYV0Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnFAh6yCTmKI/Y+oikSQG++m293PK8pS6qKLAj5RedU=;
	b=mQR7TVNtGrRFsAiCWHBBbdhbMXLFKAtNqPC7WdBgGAShDe2GgmtnA5c294giEpApW1JRCv
	dd9DD2V5tJH3TsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnFAh6yCTmKI/Y+oikSQG++m293PK8pS6qKLAj5RedU=;
	b=lRqnJBmu66DcaAqmLCDuSY+ydDx7R2VSxTHZCsvfu1yhNnrKFPRHpsE/5I4/O+PPqB/tgi
	alKehllrcDqau9YiF4bPNihcOtLtsE5ml2r7wWBbq5je9B1ykH/2BpvM1sSSv7hmrK/dQo
	Asn/2BEZ1JaiHlnEbCTNjUeJPIYV0Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnFAh6yCTmKI/Y+oikSQG++m293PK8pS6qKLAj5RedU=;
	b=mQR7TVNtGrRFsAiCWHBBbdhbMXLFKAtNqPC7WdBgGAShDe2GgmtnA5c294giEpApW1JRCv
	dd9DD2V5tJH3TsCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4917B13587;
	Tue, 26 Mar 2024 13:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id geo+ECbKAmYdNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 14/20] nvme: drop default trtype argument for _nvmet_passthru_target_connect
Date: Tue, 26 Mar 2024 14:13:56 +0100
Message-ID: <20240326131402.5092-15-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lRqnJBmu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mQR7TVNt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7ufrgpbk1ee76mmzdtnzc641)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 5AA0F37C51
X-Spam-Flag: NO

Every invocation of _nvmet_passthru_target_connect passes in the default
nvme_trtype argument. The argument is not evaluated anymore, thus just
remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 | 2 +-
 tests/nvme/034 | 2 +-
 tests/nvme/035 | 2 +-
 tests/nvme/036 | 2 +-
 tests/nvme/037 | 3 +--
 tests/nvme/rc  | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 6cc4f57e6d60..cb120e20b573 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -53,7 +53,7 @@ test_device() {
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
 
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 3bd1c3ad2f61..98a7db859b36 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -23,7 +23,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 01aa09077d6a..c17e8be6ce46 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -29,7 +29,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
 		echo "FAIL: fio verify failed"
diff --git a/tests/nvme/036 b/tests/nvme/036
index 89ccd256a67c..a1ae74fa95ea 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -21,7 +21,7 @@ test_device() {
 	local ctrldev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index a2815b3ff2d7..eb47839a4289 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -23,8 +23,7 @@ test_device() {
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup "${subsys}${i}"
-		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
-				"${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
 
 		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
 		_nvmet_passthru_target_cleanup "${subsys}${i}"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9ce2fd787f8d..1dd1072f9ffb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -897,8 +897,7 @@ _nvmet_passthru_target_setup() {
 }
 
 _nvmet_passthru_target_connect() {
-	local trtype=$1
-	local subsys_name=$2
+	local subsys_name=$1
 
 	_nvme_connect_subsys "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
-- 
2.44.0


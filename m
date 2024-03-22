Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16A47A66
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115430; cv=none; b=kUiwDAnG6xgjFNpQtxDBqqdusiVa2EbusYmkAV6flbTy5xZp/R/i4YdC6hrazBkCsTng4bt44k4n7BeucTLAZnvNS3QB2iX4DsV4P9gvMuke+Dn8FChRnKbCnF7nf/h45h9M/eMJZqjRojMIKWNwHvhhOdMuEV7nZxZQx0LLe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115430; c=relaxed/simple;
	bh=8FTG64vvVBMMD6INy+QP3ubqYs6kS2IGcvffk6/eX18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8Xd1SMO+rUeZX0bmotZaehWFMCFOOQUZGCR4E5AsbZ8eG6xoHWxX0O76G2M9ynM/BmaQKj41/7V6BHVRE+q+quHPJ3cP/uxIRCBm79ro/0MeCFrKD0vvnahvv1+rBdLNc0WZ4aWLNnv/+pzOQORjTmocA3IOqu/o25kqY0byAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D387E3855D;
	Fri, 22 Mar 2024 13:50:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C271C136AD;
	Fri, 22 Mar 2024 13:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KzAILqOM/WWcJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 14/18] nvme: drop default trtype argument for _nvmet_passthru_target_connect
Date: Fri, 22 Mar 2024 14:50:11 +0100
Message-ID: <20240322135015.14712-15-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: D387E3855D

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


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4273518
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458859; cv=none; b=SnXLWMP+pWg3yoFS7dC/88nRMuQO9tKLLTEpgFvx3AJHJGF33CezWMbYFSWQNiB4o9KSJiUOKvCowG5o6fjf10wvm4fG+dA+GjqIvQHmNUQ4Y4fHVkb1fHsuMT7JEgS/BCOjBEW0uvmlG1h9gXJHgDycUGxHAQV8Hy1zhz5mnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458859; c=relaxed/simple;
	bh=N3lTcugoj4/ywDFKBaaQ4dAnbNd7cZDh+nc8y5M0co4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmWHi+wM5SJdL5Wg0gjZGpvc26MurOCi0eA9e4gqJBGxGSNgFWHB7mJKqct/bMCXZzMFkeDdB/JpLZyBphwuyEO/pysD76PgWCzWL1nXdjhdIPe/NvQUvdpv1iXCRYNoQwHKb8ZQggPNPM2IO/ZmPFdhg8Orm6FVkf9HhzppVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=It/4g95V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uojd8yiZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=It/4g95V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uojd8yiZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="It/4g95V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uojd8yiZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="It/4g95V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uojd8yiZ"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 416F2373A9;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=It/4g95Vvoubbl3G6fi5Aeb1NIl9GSbhIgR6hz1aHSLlXP9+sJz4XJa7D4GBARusvNx8Pg
	nu9kxjvR+MSmIqDnzdd0T9st+BhFUp5p6Yv7FwbJU1y9DJljfWn/hBqRRHe9qB2b6xf+4b
	/haYd7e6DSBHTyRwLvJpMjyXLtBMo9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=Uojd8yiZsJOK/BwH8IVgJG+a7bUTw/5C0asFegihug2IVx8bWjUu+OpBvelD2JUkcbqDOk
	ZlwpETwR3VKQx0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=It/4g95Vvoubbl3G6fi5Aeb1NIl9GSbhIgR6hz1aHSLlXP9+sJz4XJa7D4GBARusvNx8Pg
	nu9kxjvR+MSmIqDnzdd0T9st+BhFUp5p6Yv7FwbJU1y9DJljfWn/hBqRRHe9qB2b6xf+4b
	/haYd7e6DSBHTyRwLvJpMjyXLtBMo9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=Uojd8yiZsJOK/BwH8IVgJG+a7bUTw/5C0asFegihug2IVx8bWjUu+OpBvelD2JUkcbqDOk
	ZlwpETwR3VKQx0Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FAD713587;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NjOeCijKAmYjNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 17/20] nvme: drop default subsysnqn argument from _nvmet_passthru_target_connect
Date: Tue, 26 Mar 2024 14:13:59 +0100
Message-ID: <20240326131402.5092-18-dwagner@suse.de>
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
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Remove the last positional argument for _nvmet_passthru_target_connect
which most test pass in the default subsysnqn anyway. There is little
point in cluttering all the test textual noise.

While at it, also use subsysnqn as variable name everywhere, instead of
subsys_name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  2 +-
 tests/nvme/034 |  2 +-
 tests/nvme/035 |  2 +-
 tests/nvme/036 |  2 +-
 tests/nvme/037 |  3 ++-
 tests/nvme/rc  | 19 ++++++++++++++++---
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index f7d9f04450a8..70a73b8c7b6a 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -53,7 +53,7 @@ test_device() {
 
 	_nvmet_passthru_target_setup
 
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	compare_dev_info "${nsdev}"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index e5518d497377..409324aafb39 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -23,7 +23,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8a66c2c15218..ecf6b7285ee5 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -29,7 +29,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
 		echo "FAIL: fio verify failed"
diff --git a/tests/nvme/036 b/tests/nvme/036
index 20cd3af7081a..36ea792e3d40 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -21,7 +21,7 @@ test_device() {
 	local ctrldev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index 2fe37a7a7340..3e733d201d6a 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -23,7 +23,8 @@ test_device() {
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
-		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect \
+				--subsysnqn "${subsys}${i}")
 
 		_nvme_disconnect_subsys \
 			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
diff --git a/tests/nvme/rc b/tests/nvme/rc
index fca7408062ee..fb7a5fa864e8 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -922,10 +922,23 @@ _nvmet_passthru_target_setup() {
 }
 
 _nvmet_passthru_target_connect() {
-	local subsys_name=$1
+	local subsysnqn="$def_subsysnqn"
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
 
-	_nvme_connect_subsys --subsysnqn "${subsys_name}" --no-wait || return
-	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
+	_nvme_connect_subsys --subsysnqn "${subsysnqn}" --no-wait || return
+	nsdev=$(_find_nvme_passthru_loop_dev "${subsysnqn}")
 
 	# The following tests can race with the creation
 	# of the device so ensure the block device exists
-- 
2.44.0


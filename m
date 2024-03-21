Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F395677C
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014463; cv=none; b=copuWP9PfflMh0FCq9A5vfq6deCsARPC0OMJRhjmHiLuJdNfBE5iN+ZGRuW8tD4x2lLVaKuym914aftum0yotMqUHSk5kjuFPHQXttO9XNZRMcDWAwW23Ts+7/HqF2wXNSxLn7v5tPBjttRFBaU3LBSKBIpqmh8FRAJAYQrzTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014463; c=relaxed/simple;
	bh=GPh/b5Yj4VT4znQOSdVxrn1nzxgvULja6G93t9FYclE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfuA/pFXZbcAt9EF5QLWdljAfSn8C/bcFgWn2NqdZyQy4Eg/5OlUiW5PjeFvEYjsVbMF3u6WQlyXzNd6c/daa2fIXfLs2qOzvjUAUZ3qE7kcChLCbkiZEcmk9Jm4wwVJokW8C486w2JCldoeomDLxV4gNPNTpclUtBywk9yx4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KU9XoXRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z9CjUzyx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KU9XoXRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z9CjUzyx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KU9XoXRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z9CjUzyx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KU9XoXRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z9CjUzyx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DAF55CBCB;
	Thu, 21 Mar 2024 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=KU9XoXRSvKrcthmxdKxBeX7Jmc4K152+bDU4pm3XRtzZxfVIZgbrbV+QCkE7JCs4bh0Z3t
	484tHE5a8WvKPthlyQRsEQXLuQ8JCfRy8bGYU0BNoSaWE3oCWD+0DKrd6Mhhwh+3Enla4h
	gFCqqsbxVmlIy05z9sI7syvEJPvOoDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=Z9CjUzyxiwXr8/ALSo2Apj32nJieiDFh/9fssPL0KBl58eVvdOaqwM2AluJeKstgfJRv1P
	f1BF31bSceDouKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=KU9XoXRSvKrcthmxdKxBeX7Jmc4K152+bDU4pm3XRtzZxfVIZgbrbV+QCkE7JCs4bh0Z3t
	484tHE5a8WvKPthlyQRsEQXLuQ8JCfRy8bGYU0BNoSaWE3oCWD+0DKrd6Mhhwh+3Enla4h
	gFCqqsbxVmlIy05z9sI7syvEJPvOoDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=Z9CjUzyxiwXr8/ALSo2Apj32nJieiDFh/9fssPL0KBl58eVvdOaqwM2AluJeKstgfJRv1P
	f1BF31bSceDouKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3A513976;
	Thu, 21 Mar 2024 09:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oh/0BDwC/GXsDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 16/18] nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to _nvme_connect_subsys
Date: Thu, 21 Mar 2024 10:47:25 +0100
Message-ID: <20240321094727.6503-17-dwagner@suse.de>
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
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

There is no point in passing the default values to
_nvme_connect_subsys, thus drop these arguments.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 |  7 ++-----
 tests/nvme/042 |  8 ++------
 tests/nvme/043 |  8 ++------
 tests/nvme/044 | 16 ++++------------
 tests/nvme/045 |  4 +---
 tests/nvme/048 |  4 +---
 6 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d6845628726e..f1fa00c0f420 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -38,16 +38,13 @@ test() {
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}"
+	_nvme_connect_subsys
 
 	_nvme_disconnect_subsys
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index 480e1cba9d19..a9e79c6a13b4 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -41,9 +41,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
@@ -57,9 +55,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
diff --git a/tests/nvme/043 b/tests/nvme/043
index dd48035dd967..4589423d4335 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -45,9 +45,7 @@ test() {
 
 		_set_nvmet_hash "${def_hostnqn}" "${hash}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
@@ -58,9 +56,7 @@ test() {
 
 		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
-		_nvme_connect_subsys  --hostnqn "${def_hostnqn}" \
-				      --hostid "${def_hostid}" \
-				      --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
diff --git a/tests/nvme/044 b/tests/nvme/044
index 624b832c0cc6..8b8859068660 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -49,18 +49,14 @@ test() {
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
 
 	# Step 2: Connect with host authentication
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
@@ -68,9 +64,7 @@ test() {
 	# Step 3: Connect with host authentication
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	_nvme_disconnect_subsys
@@ -79,9 +73,7 @@ test() {
 	# and invalid ctrl key
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/045 b/tests/nvme/045
index 257898724ca0..adc86b89ccc5 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -51,9 +51,7 @@ test() {
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	echo "Re-authenticate with original host key"
diff --git a/tests/nvme/048 b/tests/nvme/048
index 79620e0d0879..0b299a91288b 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -99,9 +99,7 @@ test() {
 	_nvmet_target_setup --blkdev file
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --keep-alive-tmo 1 \
+		_nvme_connect_subsys --keep-alive-tmo 1 \
 				     --reconnect-delay 2
 
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
-- 
2.44.0


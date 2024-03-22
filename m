Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E997481DD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115433; cv=none; b=lpTrHkA8IqgzSI4M3ux8joNUSgXYJRqWKgVkRU5m+cNBrCrR7QU9pur8HMpA/rwtW9PSYdZsGYY/Qr9RmZ70MalbRIX08qIH7fWnUbyY1TR0FbsfmIbC3AkWDloxIHIAVTJZaqsXSaBMbOtQDuh2J/CSIi4Qx3v3k8ETPAEOb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115433; c=relaxed/simple;
	bh=4bpSVLZdZpyIxbCq/ZqQb9QaMFYJMevz+2v3LoSG2kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdLkRVFy48pZ47lAO3w1UGq4y9baIoHSODnT8XepYq5GB7+zTyOUYuuyiFhsOFQ6lLF5DaTY/uxypUScb50qUGzNnF5HEXSIt7tkHXsbBiuoif5vkVYDSk8ZU5wfgNoN3HQ5h/mi1VySyrdCxW2EBP+C9PzDA7PF34pugyKEzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N8mZ5YOk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=14eIX+dU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N8mZ5YOk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=14eIX+dU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N8mZ5YOk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="14eIX+dU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N8mZ5YOk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="14eIX+dU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 272285FE2A;
	Fri, 22 Mar 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=N8mZ5YOkfi5ntma4oGIYB0BsjpBNrHe0o111WzWzWpEvjp3WsCfb1DmfykvD69aahnMqPd
	0F5/BnGG4zBWAMx2SHFpTuSkwqJYoAgvU71BnIg1FXd60W4GSkuPfOAksoUBz5l9bvkpBf
	4WZ9b8nKu+R9tUpY4dYAnTyW7HbIR3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=14eIX+dUDFhggQqNl2/y1BwuPJnR4XtHJ7hiFpBTEwRrTMAlmo3p/e+T1AQIFfxp796beg
	1TnKz30rHfkkgiBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=N8mZ5YOkfi5ntma4oGIYB0BsjpBNrHe0o111WzWzWpEvjp3WsCfb1DmfykvD69aahnMqPd
	0F5/BnGG4zBWAMx2SHFpTuSkwqJYoAgvU71BnIg1FXd60W4GSkuPfOAksoUBz5l9bvkpBf
	4WZ9b8nKu+R9tUpY4dYAnTyW7HbIR3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=14eIX+dUDFhggQqNl2/y1BwuPJnR4XtHJ7hiFpBTEwRrTMAlmo3p/e+T1AQIFfxp796beg
	1TnKz30rHfkkgiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159B9136AD;
	Fri, 22 Mar 2024 13:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9nPA6WM/WWnJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:29 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 16/18] nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to _nvme_connect_subsys
Date: Fri, 22 Mar 2024 14:50:13 +0100
Message-ID: <20240322135015.14712-17-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
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
index 3a5df7c0946c..87ac3c019970 100755
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


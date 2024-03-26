Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FB73177
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458859; cv=none; b=Wo2Ll4X0FpS7gPGMM3FhsfFz0qBq+xNt/SjiXFN0gpkECYuq/pD01/Bk9kk9IpvxZ7N98hPtBVheF9kFzMeqh/k/Id5Cx5kEGFkeW2mw91wxN75gByzaOn60wyDllj1g+p7V9I5BueOQbVilEYYHGqDxqq9pSkhpKVbZ84Fu1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458859; c=relaxed/simple;
	bh=sJ1Xo+75YH5DeCvtn+fFmb0CGWJZ1HiruKaHb+t7dp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoZUTq+hjoH30QsAXttAtzjzcvAa/9HKoaazR2D1LgC87BnptHnXDsQggKaNlBcmBMyXyZMhoTQupvPg7CWRnMQ4JSGdlC9tA3jv2Q8oXMRefA7dzXsScyPXjaHKrfKs5r/Gyp+nYjqzpoZB1UT+3OIGnZ+IsyY552RLkhc0ClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GXuZbJAx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YwBByO0e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GXuZbJAx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YwBByO0e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GXuZbJAx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YwBByO0e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GXuZbJAx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YwBByO0e"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 053A35D660;
	Tue, 26 Mar 2024 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysoMXDNPWj2T9LYd7LzazOKeW05nqV5soOfX6P+WVDU=;
	b=GXuZbJAxgN0c5n7dFePpO7bnoTLUmeHY6PCdSVN+nvXqdReJG5PVzrBMew9vHaaXLrj4lJ
	VXLeMCU8uN77I3Nnn00mPuRFdPMlEqzAAEAZxP3Vop7KtQLnjQ+Yz3yxnV8PAAHTLVarOw
	Sc90HTQRDvDdcd/wgfJsCLz5gOOusJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysoMXDNPWj2T9LYd7LzazOKeW05nqV5soOfX6P+WVDU=;
	b=YwBByO0eJH8hQXZPaeAaL1ncP0dC7PZAvGOILSRBg3wuq4JvoURb/uwt6XMTS7ZQH6q53U
	/0nTOoBiEE7se1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysoMXDNPWj2T9LYd7LzazOKeW05nqV5soOfX6P+WVDU=;
	b=GXuZbJAxgN0c5n7dFePpO7bnoTLUmeHY6PCdSVN+nvXqdReJG5PVzrBMew9vHaaXLrj4lJ
	VXLeMCU8uN77I3Nnn00mPuRFdPMlEqzAAEAZxP3Vop7KtQLnjQ+Yz3yxnV8PAAHTLVarOw
	Sc90HTQRDvDdcd/wgfJsCLz5gOOusJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysoMXDNPWj2T9LYd7LzazOKeW05nqV5soOfX6P+WVDU=;
	b=YwBByO0eJH8hQXZPaeAaL1ncP0dC7PZAvGOILSRBg3wuq4JvoURb/uwt6XMTS7ZQH6q53U
	/0nTOoBiEE7se1Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E076D13587;
	Tue, 26 Mar 2024 13:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lBdaNSbKAmYfNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 15/20] nvme: drop default subsysnqn argument from _nvme_{connect|disconnect}_subsys
Date: Tue, 26 Mar 2024 14:13:57 +0100
Message-ID: <20240326131402.5092-16-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GXuZbJAx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YwBByO0e
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
X-Rspamd-Queue-Id: 053A35D660
X-Spam-Flag: NO

Remove the last positional argument for
_nvme_{connect|disconnect}_subsys which most test pass in the default
subsysnqn anyway. There is little point in cluttering all the test
textual noise.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  4 ++--
 tests/nvme/005 |  2 +-
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  4 ++--
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  4 ++--
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  4 ++--
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/031 |  4 ++--
 tests/nvme/033 |  2 +-
 tests/nvme/034 |  2 +-
 tests/nvme/035 |  2 +-
 tests/nvme/036 |  2 +-
 tests/nvme/037 |  3 ++-
 tests/nvme/040 |  2 +-
 tests/nvme/041 | 10 ++++------
 tests/nvme/042 | 10 ++++------
 tests/nvme/043 | 10 ++++------
 tests/nvme/044 | 20 ++++++++------------
 tests/nvme/045 |  6 ++----
 tests/nvme/047 |  6 +++---
 tests/nvme/048 | 11 +++++------
 tests/nvme/rc  | 30 +++++++++++++++++++++---------
 38 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index 9a7c41f0856b..be6b4e18ec30 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
@@ -38,7 +38,7 @@ test() {
 		echo "Fail"
 	fi
 
-	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
+	_nvme_disconnect_subsys --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/004 b/tests/nvme/004
index 024ac986e5c1..b751746c6c91 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -24,13 +24,13 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	local nvmedev
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_nvme_disconnect_subsys ${def_subsysnqn}
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 80a5359e862e..f17174d40dfc 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index fb1726723d43..a5d06818c6e4 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -24,12 +24,12 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index a9d83b675ba2..a1655d43e56f 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -23,12 +23,12 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 496f6e5c6a52..7d875989a01c 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -32,7 +32,7 @@ test() {
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 14a17a774d5f..0acc8b1dbaed 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -32,7 +32,7 @@ test() {
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8dbf8eb1a9f0..a0bff298ab29 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -28,7 +28,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -37,7 +37,7 @@ test() {
 		echo "FAIL: fio verify failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index eb22933fdec6..5e5026eabe17 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -36,7 +36,7 @@ test() {
 		echo "FAIL: fio verify failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 20ff69176231..da4b4c13b347 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" --namespace-id 1
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 634c42c07a86..b82f2253c011 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" --namespace-id 1
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index 9225f7d58377..bd6e5e930e35 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -39,7 +39,7 @@ test() {
 		--block-count 0 --data-size "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 9cf9f5299305..4d7de8191da7 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -26,7 +26,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -34,7 +34,7 @@ test() {
 	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index f6a204e6e417..c734210c5bd9 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 73e414e9db47..358e209d0458 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 31435cd2e9c7..7ce33ddbf006 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index c4c292899f32..abbb35a0b580 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -34,7 +34,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index b0d6f5a3c0b9..3ee18822e26b 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		>> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 107eb38ba787..3cd62d0b4e5e 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index ff4ff91d5d4f..5d54b0ff3d28 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -34,7 +34,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index a15e6d6e92d0..053fd58f9369 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: ns-rescan failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 41dcb6ef7a4f..4710bba1f416 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: list-subsys"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7bde5565b020..8dbe49ba15cc 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -58,7 +58,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
@@ -84,7 +84,7 @@ test() {
 		echo 0 > /proc/sys/vm/nr_hugepages
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 19854ccb903f..0bf823dbbb0d 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -43,8 +43,8 @@ test() {
 		_nvmet_target_setup --subsysnqn "${subsys}$i" \
 			--blkdev "${loop_dev}"
 
-		_nvme_connect_subsys "${subsys}$i"
-		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys --subsysnqn "${subsys}$i"
+		_nvme_disconnect_subsys --subsysnqn "${subsys}$i" >> "${FULL}" 2>&1
 
 		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
 			--blkdev "${loop_dev}"
diff --git a/tests/nvme/033 b/tests/nvme/033
index cb120e20b573..c0482c808d43 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -57,7 +57,7 @@ test_device() {
 
 	compare_dev_info "${nsdev}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/034 b/tests/nvme/034
index 98a7db859b36..8bb2d8cd8d62 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -27,7 +27,7 @@ test_device() {
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/035 b/tests/nvme/035
index c17e8be6ce46..1d1b5e4ac46e 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -35,7 +35,7 @@ test_device() {
 		echo "FAIL: fio verify failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/036 b/tests/nvme/036
index a1ae74fa95ea..0e9c3bf3486c 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -29,7 +29,7 @@ test_device() {
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/037 b/tests/nvme/037
index eb47839a4289..159d9d990bb7 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -25,7 +25,8 @@ test_device() {
 		_nvmet_passthru_target_setup "${subsys}${i}"
 		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
 
-		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
+		_nvme_disconnect_subsys \
+			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
 		_nvmet_passthru_target_cleanup "${subsys}${i}"
 	done
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 06d0d0d47368..f00fc16b643f 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -26,7 +26,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${def_subsysnqn}"
+	_nvme_connect_subsys
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	# start fio job
diff --git a/tests/nvme/041 b/tests/nvme/041
index 02452fd52628..d6845628726e 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -38,20 +38,18 @@ test() {
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index 961301ff6993..480e1cba9d19 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -41,12 +41,11 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${def_subsysnqn}" \
-				     --hostnqn "${def_hostnqn}" \
+		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvme_disconnect_subsys
 	done
 
 	for key_len in 32 48 64; do
@@ -58,12 +57,11 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${def_subsysnqn}" \
-				     --hostnqn "${def_hostnqn}" \
+		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvme_disconnect_subsys
 	done
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/043 b/tests/nvme/043
index ed18869a5977..dd48035dd967 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -45,12 +45,11 @@ test() {
 
 		_set_nvmet_hash "${def_hostnqn}" "${hash}"
 
-		_nvme_connect_subsys "${def_subsysnqn}" \
-				     --hostnqn "${def_hostnqn}" \
+		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvme_disconnect_subsys
 	done
 
 	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
@@ -59,12 +58,11 @@ test() {
 
 		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
-		_nvme_connect_subsys "${def_subsysnqn}" \
-				      --hostnqn "${def_hostnqn}" \
+		_nvme_connect_subsys  --hostnqn "${def_hostnqn}" \
 				      --hostid "${def_hostid}" \
 				      --dhchap-secret "${hostkey}"
 
-		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvme_disconnect_subsys
 	done
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/044 b/tests/nvme/044
index 8e2b4131b969..624b832c0cc6 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -49,46 +49,42 @@ test() {
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	# Step 2: Connect with host authentication
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	# Step 3: Connect with host authentication
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	# Step 4: Connect with host authentication
 	# and invalid ctrl key
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvme_disconnect_subsys
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index f89378836e67..3a5df7c0946c 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -51,8 +51,7 @@ test() {
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
-	_nvme_connect_subsys "${def_subsysnqn}" \
-			     --hostnqn "${def_hostnqn}" \
+	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
@@ -108,8 +107,7 @@ test() {
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
 	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}"
-
+	_nvme_disconnect_subsys
 	_nvmet_target_cleanup
 
 	echo "Test complete"
diff --git a/tests/nvme/047 b/tests/nvme/047
index 162bd3bf70fa..75aad7d06a36 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -35,15 +35,15 @@ test() {
 	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
-	_nvme_connect_subsys "${def_subsysnqn}" \
+	_nvme_connect_subsys \
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index 44fdffe287c8..79620e0d0879 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -99,11 +99,10 @@ test() {
 	_nvmet_target_setup --blkdev file
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
-		_nvme_connect_subsys "${def_subsysnqn}" \
-					--hostnqn "${def_hostnqn}" \
-					--hostid "${def_hostid}" \
-					--keep-alive-tmo 1 \
-					--reconnect-delay 2
+		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
+				     --hostid "${def_hostid}" \
+				     --keep-alive-tmo 1 \
+				     --reconnect-delay 2
 
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
@@ -112,7 +111,7 @@ test() {
 			set_qid_max "${def_subsysnqn}" 2 || echo FAIL
 		fi
 
-		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvme_disconnect_subsys
 	else
 		SKIP_REASONS+=("missing attr_qid_max feature")
 		skipped=true
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1dd1072f9ffb..6493aa30adef 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -400,15 +400,27 @@ _nvme_disconnect_ctrl() {
 }
 
 _nvme_disconnect_subsys() {
-	local subsysnqn="$1"
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
 
 	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
 		grep -o "disconnected.*"
 }
 
 _nvme_connect_subsys() {
-	local positional_args=()
-	local subsysnqn=""
+	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
 	local hostid="$def_hostid"
 	local hostkey=""
@@ -424,6 +436,10 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
 			--hostnqn)
 				hostnqn="$2"
 				shift 2
@@ -469,16 +485,12 @@ _nvme_connect_subsys() {
 				shift 1
 				;;
 			*)
-				positional_args+=("$1")
+				echo "WARNING: unknown argument: $1"
 				shift
 				;;
 		esac
 	done
 
-	set -- "${positional_args[@]}"
-
-	subsysnqn="$1"
-
 	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
 	if [[ "${nvme_trtype}" == "fc" ]] ; then
 		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
@@ -899,7 +911,7 @@ _nvmet_passthru_target_setup() {
 _nvmet_passthru_target_connect() {
 	local subsys_name=$1
 
-	_nvme_connect_subsys "${subsys_name}" --no-wait || return
+	_nvme_connect_subsys --subsysnqn "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.44.0


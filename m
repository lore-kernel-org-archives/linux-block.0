Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985D56B68
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014464; cv=none; b=lcbyGE3EtQfJUedLvmENyDCQtcTVMQ7JKcPmMW0jeigagJEV2rbyFOadkTgzvui98vXu0BuIhVPV9UjU2QQfVOYkmX7uOVGhjbrtD2yCecnvOZX+2n2QLnmTXYfeOo4mHVPQlwNoyYwCZSyc/btNgjZrtjah5b2FuqImmUsKk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014464; c=relaxed/simple;
	bh=3Sf7e2azTAtgQjTL2PI9/yJTg5Yvw3o6UXppdOcyWak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3yvg8oZcDMvLKZ8qXb8d2j2ao+bkWtZRm1xuhllSVxeX+wRDPf2rQWlvaleM4RlsA527YBP22SGiHcpYt01F2hmce1e42nOLfaV4KfUalP38npxYjXOZyHdArdRWMYsD99sZFW0d7LHxZR1cumaL4p7+VkXYDwbvvmFyDmzqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yfl+lYSv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3bbsA29+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yfl+lYSv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3bbsA29+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yfl+lYSv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3bbsA29+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yfl+lYSv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3bbsA29+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FC7A3715E;
	Thu, 21 Mar 2024 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCgJs3cl3qSz8cdEBO9oHuFamWa0vG+sDjG9BJvAsZQ=;
	b=Yfl+lYSvyxJoSHvsg7bZQ7C/lmsjAgUqBnOHQXsfW2gVJXMit+mr0HTZoX0e+nQ61gXn8n
	OEgoLzjhIF+T3+gQphDuxLn4hYWzr5XuuVU9NlmEHiczqHFMj5Fy4xbKFFoCayyMn6vSdD
	pfnsuMF8KgQqRXZ6qFY1c6NH/Or9Iic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCgJs3cl3qSz8cdEBO9oHuFamWa0vG+sDjG9BJvAsZQ=;
	b=3bbsA29+xHbGqxUW5dRJ2BZQG4/VXcOa3RrG5rI6T47QeD1NEZlotSBKmKTyjFgNVmim+c
	EcmE8JwUsfKRssCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCgJs3cl3qSz8cdEBO9oHuFamWa0vG+sDjG9BJvAsZQ=;
	b=Yfl+lYSvyxJoSHvsg7bZQ7C/lmsjAgUqBnOHQXsfW2gVJXMit+mr0HTZoX0e+nQ61gXn8n
	OEgoLzjhIF+T3+gQphDuxLn4hYWzr5XuuVU9NlmEHiczqHFMj5Fy4xbKFFoCayyMn6vSdD
	pfnsuMF8KgQqRXZ6qFY1c6NH/Or9Iic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCgJs3cl3qSz8cdEBO9oHuFamWa0vG+sDjG9BJvAsZQ=;
	b=3bbsA29+xHbGqxUW5dRJ2BZQG4/VXcOa3RrG5rI6T47QeD1NEZlotSBKmKTyjFgNVmim+c
	EcmE8JwUsfKRssCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7873613976;
	Thu, 21 Mar 2024 09:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id opH/GzsC/GXpDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:39 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 15/18] nvme: drop default subsysnqn argument from _nvme_{connect|disconnect}_subsys
Date: Thu, 21 Mar 2024 10:47:24 +0100
Message-ID: <20240321094727.6503-16-dwagner@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.72
X-Spamd-Result: default: False [0.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.980];
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
X-Spam-Flag: NO

Remove the last positional argument for _nvme_connect_subsys which most
test pass in the default subsysnqn anyway. There is little point in
cluttering all the test textual noise.

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
 tests/nvme/040 |  2 +-
 tests/nvme/041 | 10 ++++------
 tests/nvme/042 | 10 ++++------
 tests/nvme/043 | 10 ++++------
 tests/nvme/044 | 20 ++++++++------------
 tests/nvme/045 |  6 ++----
 tests/nvme/047 |  4 ++--
 tests/nvme/048 | 11 +++++------
 tests/nvme/rc  | 28 ++++++++++++++++++++--------
 33 files changed, 97 insertions(+), 98 deletions(-)

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
index f2a4e817e137..943cac984877 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -42,8 +42,8 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_target_setup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
 
-		_nvme_connect_subsys "${subsys}$i"
-		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys --subsysnqn "${subsys}$i"
+		_nvme_disconnect_subsys --subsysnqn "${subsys}$i" >> "${FULL}" 2>&1
 
 		_nvmet_target_cleanup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
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
index f89378836e67..257898724ca0 100755
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
+	_nvme_disconnect_subsys "${subsysnqn}"
 	_nvmet_target_cleanup
 
 	echo "Test complete"
diff --git a/tests/nvme/047 b/tests/nvme/047
index 162bd3bf70fa..7a2432a769e5 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -37,13 +37,13 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
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
index 91c80aea59e8..214744edf44e 100644
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
-- 
2.44.0


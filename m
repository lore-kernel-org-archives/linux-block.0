Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909C7441C
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458861; cv=none; b=H+tntDx2HT7l2r4QBOzXu3sy028DfE3Dcy59InJTRnohN3HC5HTyqooENnja3uAO5PtlT60h3GZMhKVYtzK+24IDa1LgwZ4Lz+Jl1ZUBX4odKxmtvPu9xd5zOrgz2ad5ArBb2+EhztAd2JPlF3dhtRsMcgXE8qIdo5P6Dz3AjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458861; c=relaxed/simple;
	bh=fqbFFnHQZ/zoXzINpj4R45Ipq7ulXgFAO4B5EyeUrKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrXV+8s56MGu8Fjt9Ej89vVN51fLZ1/xLtvoGxswxkh9FX3FKJ1jRo7k1vkXTKxzdQervnY3URH50e2t1Zipa6Wcraf224xa4ZFD+wqx/GPbKLWdvyWM5OXXecwd/4j1XGwcEKaUHb9HY2Ne+m5a+MVehCQp5chyEclFE28USTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8zv9m2j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CfS0xNe6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8zv9m2j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CfS0xNe6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8zv9m2j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CfS0xNe6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8zv9m2j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CfS0xNe6"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DCF9373B6;
	Tue, 26 Mar 2024 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pfBlJ3j2sxsjcJkqhxqJdCf/QTLgKASybT1WMxghXQ=;
	b=D8zv9m2j4twuu6qHYba2YkvMmCefirc41Ji8LWtCyOwSRMi0owkPrb0rpbS3K121xkaIQV
	l08HMFmVwZQSC8V7dCYGSoP3EgxC3/rHY+7G81avMJ+EBS9sYrPJ+FU00Zx+2gYmE0yiMP
	4WfWfEjtIuTFTNNv4rF55Rm29bA8sIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pfBlJ3j2sxsjcJkqhxqJdCf/QTLgKASybT1WMxghXQ=;
	b=CfS0xNe6he6et7q7NOPIKcLBnwADWDRWNOopHonAr8V12xnTeBgQEr4M+dG3XiBqbYfEs/
	DyAg4djLhghNWxDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pfBlJ3j2sxsjcJkqhxqJdCf/QTLgKASybT1WMxghXQ=;
	b=D8zv9m2j4twuu6qHYba2YkvMmCefirc41Ji8LWtCyOwSRMi0owkPrb0rpbS3K121xkaIQV
	l08HMFmVwZQSC8V7dCYGSoP3EgxC3/rHY+7G81avMJ+EBS9sYrPJ+FU00Zx+2gYmE0yiMP
	4WfWfEjtIuTFTNNv4rF55Rm29bA8sIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pfBlJ3j2sxsjcJkqhxqJdCf/QTLgKASybT1WMxghXQ=;
	b=CfS0xNe6he6et7q7NOPIKcLBnwADWDRWNOopHonAr8V12xnTeBgQEr4M+dG3XiBqbYfEs/
	DyAg4djLhghNWxDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B36413587;
	Tue, 26 Mar 2024 13:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BBrAGCnKAmYoNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 19/20] nvme: don't assume namespace id
Date: Tue, 26 Mar 2024 14:14:01 +0100
Message-ID: <20240326131402.5092-20-dwagner@suse.de>
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
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D8zv9m2j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CfS0xNe6
X-Rspamd-Queue-Id: 7DCF9373B6

The tests assume that the namespace id is always 1. This might not be
correct in future (e.g. running real targets), thus harden the test by
using the uuid to lookup the correct namespace id.

The passthru test already do this, so it makes also sense to update the
other tests as well.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/010 |  7 +++----
 tests/nvme/011 |  7 +++----
 tests/nvme/012 |  7 +++----
 tests/nvme/013 |  7 +++----
 tests/nvme/014 | 13 ++++++-------
 tests/nvme/015 | 13 ++++++-------
 tests/nvme/018 | 15 +++++++--------
 tests/nvme/019 |  8 +++-----
 tests/nvme/020 |  7 +++----
 tests/nvme/021 |  7 +++----
 tests/nvme/023 |  8 +++-----
 tests/nvme/024 |  9 ++++-----
 tests/nvme/025 |  7 +++----
 tests/nvme/026 |  8 +++-----
 tests/nvme/029 |  7 ++-----
 tests/nvme/040 |  4 +++-
 tests/nvme/045 |  5 +++--
 tests/nvme/047 |  8 ++++----
 tests/nvme/rc  | 18 ++++++++++++++++++
 19 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/tests/nvme/010 b/tests/nvme/010
index 7d875989a01c..6feb39153e99 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -20,17 +20,16 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${nvmedev}n1"
+		--filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 0acc8b1dbaed..eee044cbb4f8 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -20,17 +20,16 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${nvmedev}n1"
+		--filename="$/dev/{ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index a0bff298ab29..64cb6ecf0191 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -24,16 +24,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+	if ! _xfs_run_fio_verify_io "/dev/${ns}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 5e5026eabe17..68d07cbc4afa 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -23,16 +23,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+	if ! _xfs_run_fio_verify_io "$/dev/{ns}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index da4b4c13b347..e56e3212cf28 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local size
 	local bs
 	local count
@@ -29,17 +29,16 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	size="$(blockdev --getsize64 "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 	count=$((size / bs))
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+	dd if=/dev/urandom of="$/dev/{ns}" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}" --namespace-id 1
+	nvme flush "/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index b82f2253c011..f0621dab681b 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local size
 	local bs
 	local count
@@ -29,17 +29,16 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	size="$(blockdev --getsize64 "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 	count=$((size / bs))
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+	dd if=/dev/urandom of="/dev/${ns}" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}n1" --namespace-id 1
+	nvme flush "/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index bd6e5e930e35..b8c16354a01b 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -21,21 +21,20 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
+	local sectors
+	local bs
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	local sectors
-	local bs
-	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	sectors="$(blockdev --getsz "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 
-	nvme read "/dev/${nvmedev}n1" --start-block "$sectors" \
+	nvme read "/dev/${ns}" --start-block "$sectors" \
 		--block-count 0 --data-size "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 4d7de8191da7..1cd5378e9dd4 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
@@ -28,10 +28,8 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
-	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	nvme dsm "/dev/${ns}" --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/020 b/tests/nvme/020
index c734210c5bd9..0364c4e0dd4f 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -19,7 +19,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
@@ -27,10 +27,9 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+	nvme dsm "/dev/${ns}" --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/021 b/tests/nvme/021
index 358e209d0458..7ee1f078cd60 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -20,16 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme list 2>> "$FULL" | grep -q "${nvmedev}n1"; then
+	if ! nvme list 2>> "$FULL" | grep -q "/dev/${ns}"; then
 		echo "ERROR: device not listed"
 	fi
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index abbb35a0b580..d8f17ae7a8ea 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -20,17 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 3ee18822e26b..a5121940a543 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -20,19 +20,18 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns ${def_subsys_uuid})
 
-	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
+
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/025 b/tests/nvme/025
index 3cd62d0b4e5e..3f9a615e542e 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -20,16 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme effects-log "/dev/${nvmedev}" >> "$FULL" 2>&1; then
+	if ! nvme effects-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: effects-log failed"
 	fi
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5d54b0ff3d28..28fd151d9a77 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -20,17 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme ns-descs "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme ns-descs "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-desc failed"
 	fi
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 8dbe49ba15cc..559c0b4feabe 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -53,16 +53,12 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
 	local reset_nr_hugepages=false
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
 	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
 	# from HugeTLB pool.
@@ -72,7 +68,8 @@ test() {
 		reset_nr_hugepages=true
 	fi
 
-	local dev="/dev/${nvmedev}n1"
+	local dev
+	dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 513 > "$FULL" 2>&1 || echo FAIL
diff --git a/tests/nvme/040 b/tests/nvme/040
index f00fc16b643f..bb9ed5ef57e9 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -23,15 +23,17 @@ test() {
 
 	local nvmedev
 	local fio_pid
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" \
+	_run_fio_rand_io --filename="/dev/${ns}" \
 		--group_reporting --ramp_time=5 \
 		--time_based --runtime=1d &> /dev/null &
 	fio_pid=$!
diff --git a/tests/nvme/045 b/tests/nvme/045
index 87ac3c019970..f387eadcbda3 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -33,6 +33,7 @@ test() {
 	local new_ctrlkey
 	local ctrldev
 	local rand_io_size
+	local ns
 
 	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
@@ -100,10 +101,10 @@ test() {
 
 	echo "${new_hostkey}" > "${hostkey_file}"
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
-	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
+	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
 	_nvmet_target_cleanup
diff --git a/tests/nvme/047 b/tests/nvme/047
index 75aad7d06a36..9bbe84d4f145 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -22,7 +22,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local rand_io_size
 
 	_nvmet_target_setup
@@ -30,10 +30,10 @@ test() {
 	_nvme_connect_subsys \
 		--nr-write-queues 1 || echo FAIL
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
+	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
@@ -41,7 +41,7 @@ test() {
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
+	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index fb7a5fa864e8..203cf0c7903b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -797,6 +797,24 @@ _find_nvme_dev() {
 	done
 }
 
+_find_nvme_ns() {
+	local subsys_uuid=$1
+	local uuid
+	local ns
+
+	for ns in "/sys/block/nvme"* ; do
+		# ignore nvme channel block devices
+		if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
+			continue
+		fi
+		[ -e "${ns}/uuid" ] || continue
+		uuid=$(cat "${ns}/uuid")
+		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
+			basename "${ns}"
+		fi
+	done
+}
+
 _find_nvme_passthru_loop_dev() {
 	local subsys=$1
 	local nsid
-- 
2.44.0


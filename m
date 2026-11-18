Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994017;
	b=aZ0FYI1GvQR+CtObckC5OjefAksJkMr8fJuPuUTAbUdw7j5oMxr3DaqBvhGneYh0yddO
	 GvPE5AZL2X6RalWnFv3Y7MS1Qrgo17xdl6DjJUbK5eDx4/9ho2kaQbAcvIdGWDdzo0bGb
	 dT0RTIEVjl55cEWb5oRZ6j+UEzbVwO1mgJSCI06TzlMFWiRmVB74V0WUkKiMQfmcKR3V3
	 vOkYX7lzlFU2hVA62rO2xl1Pa0yiWGEtazOwbROr0yrzchdPUusTdSSBWqH7uCixNl+Ef
	 eddoVaITfL8iBmP64xy2aXrDjqOpyVN8PeL+8yY9cqvldtu/+olu3IoYPSO8HQI6qcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994017;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=shFvEHBx3cjoEpPdz6OhgkYWYjuT9Se5p/hkhNNqzqc=;
	b=1XyAbn69ySgt5kp5ZbhEzm8hpaQxiclSLEKsrptFp2YsnxZZtleRXyvQj/7CFqIUhFSi
	 ioH8R1Awvb0y1RBk7brm8aTFMYfG/Me0xWl9JKIyHtyZZltxvrfP5Ki1jezac8STN1CSt
	 f20du/Js/kqNr8KuWo21MMhTurZaCarK/Ss6ij2Uby1JCCQcmoZzNM1idehIiGGtCIFCr
	 PwBToQRsTcGKLNNyMN3vuWD5r1ygZ6FkJzJ/IH4vNDbhoJOey3AKFZr7hOvdB+ZQHFayV
	 7vfbTJvOwT3mezjtgDwUJt+47M1onZwUkGGAX12JIWMq1FHf5lVnzFwVmQy4u8XWn/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zW9pXvdC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJctw+Q3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zW9pXvdC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJctw+Q3;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22185606A31C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22185606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zW9pXvdC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJctw+Q3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zW9pXvdC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hJctw+Q3
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6937922258;
	Wed, 18 Nov 2026 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shFvEHBx3cjoEpPdz6OhgkYWYjuT9Se5p/hkhNNqzqc=;
	b=zW9pXvdC+/9jP4Y1364OoM4r9MhJH2Td+Joe5msYjN+IMkboo6GDPnFc7J3KC6pAFWI8B5
	7xaqyt0Rly6e71ZiYLaVzCfVH+U6Rz3ZueuXFPEsfajZ78Mr25OCxd122YjivdXNvx+aEJ
	4aGzYRb2r2imdGnnxXMIEHa4F09IqF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shFvEHBx3cjoEpPdz6OhgkYWYjuT9Se5p/hkhNNqzqc=;
	b=hJctw+Q3b6oBRtCQUzE4SPJ0VqDPFpz7mEjG6fy2l1XiiDQ1f8OEvfCrd6HJ1cx5lXpq7K
	6vY65QwptMBSD9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shFvEHBx3cjoEpPdz6OhgkYWYjuT9Se5p/hkhNNqzqc=;
	b=zW9pXvdC+/9jP4Y1364OoM4r9MhJH2Td+Joe5msYjN+IMkboo6GDPnFc7J3KC6pAFWI8B5
	7xaqyt0Rly6e71ZiYLaVzCfVH+U6Rz3ZueuXFPEsfajZ78Mr25OCxd122YjivdXNvx+aEJ
	4aGzYRb2r2imdGnnxXMIEHa4F09IqF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shFvEHBx3cjoEpPdz6OhgkYWYjuT9Se5p/hkhNNqzqc=;
	b=hJctw+Q3b6oBRtCQUzE4SPJ0VqDPFpz7mEjG6fy2l1XiiDQ1f8OEvfCrd6HJ1cx5lXpq7K
	6vY65QwptMBSD9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22ABC1334C;
	Wed, 18 Nov 2026 09:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pNRLO15v/WpOfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:55 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:44 +0100
Subject: [PATCH blktests v2 6/9] nvme: skip the DH-HMAC-CHAP algorithms the
 target doesn't support
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-6-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30

The authentication tests fail against a target that can't do
DH-HMAC-CHAP, and nvme/042 and nvme/043 fail on every hash or DH group
the target doesn't support.

Skip the authentication tests if the target doesn't list dhchap-sha256,
the hash every DH-HMAC-CHAP target supports, and skip just the steps of
nvme/042 and nvme/043 for the other algorithms the target doesn't list.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  7 +++++--
 tests/nvme/041                 |  1 +
 tests/nvme/042                 |  3 ++-
 tests/nvme/043                 |  4 +++-
 tests/nvme/044                 |  2 +-
 tests/nvme/045                 |  2 +-
 tests/nvme/063                 |  2 +-
 tests/nvme/rc                  | 31 +++++++++++++++++++++++++------
 8 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index b66bdf9cb2e8..d556f1d3b7cc 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -261,8 +261,11 @@ The blktests expects that the script interface implements following
   --subsysnqn SUBSYSNQN
 
 config --show-features prints the optional commands the script supports,
-e.g. add-port, set-ana or set-host, and tls if the target can set up TLS.
-blktests skips the tests which need a feature the list lacks.
+e.g. add-port, set-ana or set-host, the DH-HMAC-CHAP hashes and DH groups
+the target supports, e.g. dhchap-sha256 or dhchap-ffdhe2048, and tls if
+the target can set up TLS. blktests skips the tests which need a feature
+the list lacks: the authentication tests without dhchap-sha256, and
+nvme/042 and nvme/043 only the steps for the other missing algorithms.
 
 contrib/nvme-target-control implements this interface. It configures a Linux
 nvmet target over ssh and can be extended for other targets, see
diff --git a/tests/nvme/041 b/tests/nvme/041
index 9c3d9aaf4e12..2571c851be4d 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -16,6 +16,7 @@ requires() {
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_require_nvme_target_control_feature dhchap-sha256
 }
 
 set_conditions() {
diff --git a/tests/nvme/042 b/tests/nvme/042
index e771cb6ca4aa..f9019e9640c4 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -16,7 +16,7 @@ requires() {
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
-	_require_nvme_target_control_feature set-host
+	_require_nvme_target_control_feature set-host dhchap-sha256
 }
 
 set_conditions() {
@@ -37,6 +37,7 @@ test() {
 
 	for hash in none sha256 sha384 sha512; do
 		echo "Testing hash ${hash}"
+		_have_nvme_target_dhchap "${hash}" || continue
 		hostkey="$(_nvme_gen_kxchap_secret --hash="${hash}" 2> /dev/null)"
 		if [ -z "$hostkey" ] ; then
 			echo "couldn't generate host key for hash ${hash}"
diff --git a/tests/nvme/043 b/tests/nvme/043
index eb8f8b035f6d..695edaab9741 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -17,7 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
-	_require_nvme_target_control_feature set-host
+	_require_nvme_target_control_feature set-host dhchap-sha256
 }
 
 set_conditions() {
@@ -45,6 +45,7 @@ test() {
 	for hash in sha256 sha384 sha512; do
 
 		echo "Testing hash ${hash}"
+		_have_nvme_target_dhchap "${hash}" || continue
 
 		_set_nvmet_hash "${def_hostnqn}" "hmac(${hash})"
 
@@ -56,6 +57,7 @@ test() {
 	for dhgroup in ffdhe2048 ffdhe3072 ffdhe4096 ffdhe6144 ffdhe8192; do
 
 		echo "Testing DH group ${dhgroup}"
+		_have_nvme_target_dhchap "${dhgroup}" || continue
 
 		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index c1a48f1e3d86..01a153e1f2a0 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -17,7 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
-	_require_nvme_target_control_feature set-host
+	_require_nvme_target_control_feature set-host dhchap-sha256
 }
 
 set_conditions() {
diff --git a/tests/nvme/045 b/tests/nvme/045
index 14f4949e198e..52d04ce40860 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -18,7 +18,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
-	_require_nvme_target_control_feature set-host
+	_require_nvme_target_control_feature set-host dhchap-sha256
 }
 
 set_conditions() {
diff --git a/tests/nvme/063 b/tests/nvme/063
index 20aabd91ca80..578cb8799a6d 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -19,7 +19,7 @@ requires() {
 	_require_nvme_trtype tcp
 	_require_nvme_cli_auth
 	_have_systemd_tlshd_service
-	_require_nvme_target_control_feature set-host tls
+	_require_nvme_target_control_feature set-host tls dhchap-sha256
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 41811c033069..0d74c427313c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,18 +155,37 @@ _require_remote_nvme_target() {
 	return 0
 }
 
-# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
-# the optional commands and e.g. tls, see Documentation/running-tests.md.
-_require_nvme_target_control_feature() {
-	local features feature
+# Check if the NVME_TARGET_CONTROL target lists the feature, one of the
+# optional commands or e.g. tls, see Documentation/running-tests.md. The
+# local target has all of them.
+_have_nvme_target_control_feature() {
+	local features
 
 	if [[ -z "${nvme_target_control}" ]]; then
 		return 0
 	fi
 	features=" $("${nvme_target_control}" config --show-features) "
+	# shellcheck disable=SC2076 # match the feature literally
+	[[ "${features}" =~ " $1 " ]]
+}
+
+# Check if the target supports the DH-HMAC-CHAP hash or DH group, e.g. sha384
+# or ffdhe2048, and log it if it doesn't. Every target which can do
+# DH-HMAC-CHAP supports sha256, a secret with hash none needs no support.
+_have_nvme_target_dhchap() {
+	if [[ "$1" == none ]] || _have_nvme_target_control_feature "dhchap-$1"; then
+		return 0
+	fi
+	echo "Target lacks $1, skipped" >> "$FULL"
+	return 1
+}
+
+# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features.
+_require_nvme_target_control_feature() {
+	local feature
+
 	for feature in "$@"; do
-		# shellcheck disable=SC2076 # match the feature literally
-		if [[ ! "${features}" =~ " ${feature} " ]]; then
+		if ! _have_nvme_target_control_feature "${feature}"; then
 			SKIP_REASONS+=("NVME_TARGET_CONTROL target does not support ${feature}")
 			return 1
 		fi

-- 
2.56.1


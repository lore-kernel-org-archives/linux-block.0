Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994012;
	b=zDrR6orgs7RaAQEhcyg4fk+/5s1WVev+s9WJ8cQkhtI5oRvZ8AIJmc0k5R1+bSD7+JdT
	 IUUZT2As9Rbn8haGUDY+oIK/QUCX3MaXjioaA56RmWVpxTDEgQRWDi0HSLX+wEAuT/2ZO
	 rbr/vR/2SYr4K0SXqgNwquPXpQ556gD0Oq61Ov+BuWS7gx4UdO02E/2bOF79pFIgYNMf6
	 LpMGLhMJgWUSt7UG0z9P5H0aTuQlpKnTPDB2NEf2y+ByuL8MFBHY+nbK4BM3UTmHmO5ot
	 GKu6HWR7wxjW95G0f+dBlx/93fLKZmhNhqJXDH+5kqrQRdQDv+i9gWkUdJOWEIXMTZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994012;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=0jxNMbujW2sXv66jA7D7BEh1/+fBKPn0HahV99klBUw=;
	b=pw6Qi8+bGe0V0tugiImbYZfzhK8L+SpD8ppw7iyiSty+M2pypjd8HLUnD2Zon5GZ4lPS
	 KaXDCNq8c2CjouvnOMxUk0MdmZz7guK5vZjMSdG5h1rCR2+Iy5FF+FaHHE4parfoYluDZ
	 7UEY7o+TiCkjgAZwWrd4uCs+NOd0wfuwnkdAS9C2F4/z9v03HD0z3iGLjh/2cCQuOKAnR
	 ErSIiACr/JpaSgzWnJkHb9/KUN/U4oVBCy0uTu6hjBbn7KpN5iHNdjZP8t0nkZmg2ADHc
	 AqF9uYQmzhRFgh2iirjnixRuuTBZ+EIuCYyvI9F6HPZYz/DXxPPjehswRk0fzzWsuTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SbM6HesZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DCNIESZ+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SbM6HesZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DCNIESZ+;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4295E606A325
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4295E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SbM6HesZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DCNIESZ+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SbM6HesZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DCNIESZ+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97E681F387;
	Wed, 18 Nov 2026 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jxNMbujW2sXv66jA7D7BEh1/+fBKPn0HahV99klBUw=;
	b=SbM6HesZoe/1WHXntvmlb05zP0yK/sAXT0jPQHOc9oKMd/ThzkwmKzcUKf0b2mEzoYr+ll
	QElg6+90StClS+M+/NVTL3ISlLwqLIfSwkvDBvayk8R4svXuUGb5+NOFJ6O+hLznNmRfk0
	8/auLKdHsoYKQE4Xw4QmjTF4zUEnFvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jxNMbujW2sXv66jA7D7BEh1/+fBKPn0HahV99klBUw=;
	b=DCNIESZ+i3qfmJlGXOZNEbICmJSA1N9eTR0VLJgZHxkgOcM+DXvdpGqlPHpVV7dcmxmgsL
	C/G44VtF/5nidJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jxNMbujW2sXv66jA7D7BEh1/+fBKPn0HahV99klBUw=;
	b=SbM6HesZoe/1WHXntvmlb05zP0yK/sAXT0jPQHOc9oKMd/ThzkwmKzcUKf0b2mEzoYr+ll
	QElg6+90StClS+M+/NVTL3ISlLwqLIfSwkvDBvayk8R4svXuUGb5+NOFJ6O+hLznNmRfk0
	8/auLKdHsoYKQE4Xw4QmjTF4zUEnFvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jxNMbujW2sXv66jA7D7BEh1/+fBKPn0HahV99klBUw=;
	b=DCNIESZ+i3qfmJlGXOZNEbICmJSA1N9eTR0VLJgZHxkgOcM+DXvdpGqlPHpVV7dcmxmgsL
	C/G44VtF/5nidJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 553EA1334C;
	Wed, 18 Nov 2026 09:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qh+kC1pv/WpDfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:50 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:42 +0100
Subject: [PATCH blktests v2 4/9] nvme: skip tests that need a feature the
 remote target lacks
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
Message-Id: <20261118-nvme-target-control-v2-4-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -17.30
X-Spam-Level: 
X-Spam-Flag: NO

A remote target does not have to implement the optional commands, e.g. a
storage array has fixed ports and manages the ANA state itself. Tests
that use a missing command fail instead of being skipped.

Add a _require_nvme_target_control_feature helper that checks the output
of "config --show-features", and use it in the tests that need ports,
ANA, host keys or TLS. No target lists tls yet, as blktests can't pass
a TLS key to the script.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/031                 |  1 +
 tests/nvme/042                 |  1 +
 tests/nvme/043                 |  1 +
 tests/nvme/044                 |  1 +
 tests/nvme/045                 |  1 +
 tests/nvme/057                 |  1 +
 tests/nvme/062                 |  1 +
 tests/nvme/063                 |  1 +
 tests/nvme/rc                  | 19 +++++++++++++++++++
 10 files changed, 32 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 095d6aa4e18e..b66bdf9cb2e8 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -248,6 +248,7 @@ The blktests expects that the script interface implements following
   --show-trsvid
   --show-subsys-uuid
   --show-subsysnqn
+  --show-features
 
 setup:
   --subsysnqn SUBSYSNQN
@@ -259,6 +260,10 @@ The blktests expects that the script interface implements following
 cleanup:
   --subsysnqn SUBSYSNQN
 
+config --show-features prints the optional commands the script supports,
+e.g. add-port, set-ana or set-host, and tls if the target can set up TLS.
+blktests skips the tests which need a feature the list lacks.
+
 contrib/nvme-target-control implements this interface. It configures a Linux
 nvmet target over ssh and can be extended for other targets, see
 contrib/nvme-target-control/README.md.
diff --git a/tests/nvme/031 b/tests/nvme/031
index cd69e8ef13ac..b12e24489740 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -21,6 +21,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_target_control_feature add-port remove-port
 }
 
 set_conditions() {
diff --git a/tests/nvme/042 b/tests/nvme/042
index 7c558e287805..e771cb6ca4aa 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -16,6 +16,7 @@ requires() {
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/043 b/tests/nvme/043
index f85916c842fe..eb8f8b035f6d 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -17,6 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/044 b/tests/nvme/044
index 1d9202143cf4..c1a48f1e3d86 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -17,6 +17,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/045 b/tests/nvme/045
index 78a1c607e9c6..14f4949e198e 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -18,6 +18,7 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_crypto_algorithm dh-generic
+	_require_nvme_target_control_feature set-host
 }
 
 set_conditions() {
diff --git a/tests/nvme/057 b/tests/nvme/057
index 0a5cfa4df1a8..6c45af8b5ed9 100755
--- a/tests/nvme/057
+++ b/tests/nvme/057
@@ -13,6 +13,7 @@ requires() {
 	_have_loop
 	_have_fio
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_target_control_feature list-ports show-port set-ana
 }
 
 set_conditions() {
diff --git a/tests/nvme/062 b/tests/nvme/062
index eabe2d99bdcc..4402b848ecee 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -18,6 +18,7 @@ requires() {
 	_require_nvme_cli_tls
 	_have_libnvme_ver 1 11
 	_have_systemd_tlshd_service
+	_require_nvme_target_control_feature tls
 }
 
 set_conditions() {
diff --git a/tests/nvme/063 b/tests/nvme/063
index ff8e0ab90026..20aabd91ca80 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -19,6 +19,7 @@ requires() {
 	_require_nvme_trtype tcp
 	_require_nvme_cli_auth
 	_have_systemd_tlshd_service
+	_require_nvme_target_control_feature set-host tls
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8abd14eeb112..41811c033069 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,6 +155,25 @@ _require_remote_nvme_target() {
 	return 0
 }
 
+# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
+# the optional commands and e.g. tls, see Documentation/running-tests.md.
+_require_nvme_target_control_feature() {
+	local features feature
+
+	if [[ -z "${nvme_target_control}" ]]; then
+		return 0
+	fi
+	features=" $("${nvme_target_control}" config --show-features) "
+	for feature in "$@"; do
+		# shellcheck disable=SC2076 # match the feature literally
+		if [[ ! "${features}" =~ " ${feature} " ]]; then
+			SKIP_REASONS+=("NVME_TARGET_CONTROL target does not support ${feature}")
+			return 1
+		fi
+	done
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }

-- 
2.56.1


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBD131728
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225430; cv=none; b=ukpxuC7cKiY3i53FgPUGASQnV9uFflJS+VUniAHwFrAeAksU1U9dhqUlXxW3sGWLvrDZbRRT037bWeL5GkuZyGOYe6bilu34U312Xosye2vMRgVaVmgZz4frMMeQQ7fmBU21kYv27FT9atgm0UxZEhAlacP7OKVp1C5pZ9Tv/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225430; c=relaxed/simple;
	bh=Iwuw2bsU5Vl8of4cz/mFZ1LrqPqa7fv+hRNeZCfx9oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8gat58F+mxk5C6f01uSGM/Wfm8HbT4kkxGPxwTEhxXP063SzIRwU3xXSdA1RrnH0iloT3y7daOePSgk0a0oU1P2opqxa/CIYPfrF5IqC5vhEe3GwfG76fluVuX5U07egiNbTaBInoWVnA2u2U5m+uN2SBxOtqmVUUx0Pg0QsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19D7A221B2;
	Tue,  6 Feb 2024 13:17:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034A4132DD;
	Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XGf+OlIxwmV7OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 5/5] nvme/rc: revert nvme-cli context tracking
Date: Tue,  6 Feb 2024 14:16:55 +0100
Message-ID: <20240206131655.32050-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 19D7A221B2
X-Spam-Flag: NO

This feature is not needed anymore, after fixing nvmet-fc. The nvmet
target code is able to handle parallel operations and doesn't crash
anymore. Furthermore, it can't prevent from discovery controller created
by the udev rules, so let's rip it out.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 62 ---------------------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index cdfc738d3aec..dfc4c1ef1975 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -189,57 +189,6 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
-_have_nvme_cli_context() {
-	# ignore all non-fc transports for now
-	if [[ "${nvme_trtype}" != "fc" ]] ||
-	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
-		return 1
-	fi
-	return 0
-}
-
-_setup_nvme_cli() {
-	local local_wwnn="${1}"
-	local local_wwpn="${2}"
-	local remote_wwnn="${3}"
-	local remote_wwpn="${4}"
-
-	if ! _have_nvme_cli_context; then
-		return
-	fi
-
-	mkdir -p /run/nvme
-	cat >> /run/nvme/blktests.json <<-EOF
-	[
-	  {
-	    "hostnqn": "${def_hostnqn}",
-	    "hostid": "${def_hostid}",
-	    "subsystems": [
-	      {
-	        "application": "blktests",
-	        "nqn": "blktests-subsystem-1",
-	        "ports": [
-	          {
-	            "transport": "fc",
-	            "traddr": "nn-${remote_wwnn}:pn-${remote_wwpn}",
-	            "host_traddr": "nn-${local_wwnn}:pn-${local_wwpn}"
-	          }
-	        ]
-	      }
-	    ]
-	  }
-	]
-	EOF
-}
-
-_cleanup_nvme_cli() {
-	if ! _have_nvme_cli_context; then
-		return
-	fi
-
-	rm -f /run/nvme/blktests.json
-}
-
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -272,9 +221,6 @@ _setup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
-	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
-			"${remote_wwnn}" "${remote_wwpn}"
-
 	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
@@ -317,8 +263,6 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
-
-	_cleanup_nvme_cli
 }
 
 _cleanup_blkdev() {
@@ -544,9 +488,6 @@ _nvme_connect_subsys() {
 	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
-	if _have_nvme_cli_context; then
-		ARGS+=(--context="blktests")
-	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
@@ -618,9 +559,6 @@ _nvme_discover() {
 	ARGS=(-t "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
-	if _have_nvme_cli_context; then
-		ARGS+=(--context="blktests")
-	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.43.0


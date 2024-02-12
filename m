Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3C38DFA
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734457; cv=none; b=rgLQQAStmmNponxLBnxMeqX/Iwz6UTjWXVyuxTH9lUL3iNhdD2o/16eaDF9ZGrWg3NoDyLB1W9JuXf4BqtN1XdOAP0a+h+V7mVF8GRzUz3io/UvNezzdSKauRzh0RPY6JaKro7pjApXTWkSR1WZeqS0j0e8lvBAdwYQ3g6pCcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734457; c=relaxed/simple;
	bh=UEYknxtIQjRWS/tYmot9NYFFLx51f+oUQAc74WEY4RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg/8BguaQLwbOSfVdILLSGydCujupbLn9V320JWur1UITVySqsvWo1Mpk+OEB/LnriqkC6DqeOcU9aVhcmTQbGJzStC3vcWcDllc0mm+ZP8Wqd6i8qFsty8Y/SuTFeijbtPy6z1fD4lHVPs3ZME6qUyx0+QJHD56ef/t6Ae3kRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=urQMEDf+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ztqwqiAX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=urQMEDf+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ztqwqiAX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="urQMEDf+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ztqwqiAX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="urQMEDf+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ztqwqiAX"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA02A1FBB6;
	Mon, 12 Feb 2024 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tUgVZPpKQtpnPdnm1mUMfI+3j25667VECTSsnvZnqQ=;
	b=urQMEDf+aJspl9Pn/RJ0MMlU2Fa8BuWWWWv+W157g3igIG29ZJuTtUHFyG2LmpU5JXiJ6N
	3IjW2DvibZqfKM61kHf/7M521BE5ZLmpSS+BD3Y1cT4b9XSnwQSuCcYXGkhWZ6KnGLt1Kg
	b912dBjYSN9x6i9iz/BqaSdw0D6WKRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tUgVZPpKQtpnPdnm1mUMfI+3j25667VECTSsnvZnqQ=;
	b=ztqwqiAX0zLd95XJfQb5SzN8nt53ChZowbWmT8ZM0i78ZvYw8Ir4YXCs2KJ7dPjQishoTf
	pT5j6hbHUGj+c7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tUgVZPpKQtpnPdnm1mUMfI+3j25667VECTSsnvZnqQ=;
	b=urQMEDf+aJspl9Pn/RJ0MMlU2Fa8BuWWWWv+W157g3igIG29ZJuTtUHFyG2LmpU5JXiJ6N
	3IjW2DvibZqfKM61kHf/7M521BE5ZLmpSS+BD3Y1cT4b9XSnwQSuCcYXGkhWZ6KnGLt1Kg
	b912dBjYSN9x6i9iz/BqaSdw0D6WKRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tUgVZPpKQtpnPdnm1mUMfI+3j25667VECTSsnvZnqQ=;
	b=ztqwqiAX0zLd95XJfQb5SzN8nt53ChZowbWmT8ZM0i78ZvYw8Ir4YXCs2KJ7dPjQishoTf
	pT5j6hbHUGj+c7CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 98DFA13A0E;
	Mon, 12 Feb 2024 10:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HzbkI7X1yWX0CwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:53 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 5/5] nvme/rc: revert nvme-cli context tracking
Date: Mon, 12 Feb 2024 11:40:46 +0100
Message-ID: <20240212104046.13127-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=urQMEDf+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ztqwqiAX
X-Spamd-Result: default: False [2.58 / 50.00];
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
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nvidia.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.35%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.58
X-Rspamd-Queue-Id: AA02A1FBB6
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

This feature is not needed anymore, after fixing nvmet-fc. The nvmet
target code is able to handle parallel operations and doesn't crash
anymore. Furthermore, it can't prevent from discovery controller created
by the udev rules, so let's rip it out.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


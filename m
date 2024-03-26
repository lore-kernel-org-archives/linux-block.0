Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E67745CB
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458852; cv=none; b=lMieCsfCznuXXcPtSfipJkp7i8O3XePdesOi8rXnqcyipNqc+xsy7VATbXI9rYcDq5sbsawEeDafLXvSeDJfolj13lYszqMXh8REbQTDU4Gp8FZ8eIbNdr19VVLv8+Wrw8s1ap5fyLqZGtHb6PLKqxfKqHJBSDt4O0feHxXTKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458852; c=relaxed/simple;
	bh=aRAzDTd6GCU3/nhsdEv7HiRGUV5nf9n66G14txiEZCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGM6zN9Ptlohq0ZgYg1YklRX35m2FtjUoFu/jQjKz/QHUTH/OYqibk3/Gv3eDRzo9e6tenEUNpfIeMgQWku9CIkaSQKNFxw3V0SzxsZZ4/Ito50owRwajLt3tfz3ffi3m/lzkuvhDCyjYnMBmzpOotLjbHo/fxjV+z6QocyxbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uh3mOKkO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5qnIRV16; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uh3mOKkO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5qnIRV16; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uh3mOKkO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5qnIRV16";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uh3mOKkO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5qnIRV16"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFC537BBA;
	Tue, 26 Mar 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=Uh3mOKkOhx+HVFMSZ5k7AADCuvrdgHvpTNjddVV5MyqmOIFgNEKc51kasLlB51LeVwS7nd
	CkYXcESc5SfBjN7E2ygO99A8HIP55lvMYLqqBjaaDyOtahTcISGYEX0lc3fo/xj1ITdkr1
	YJ1H+es6nIAREuNqZwDh8SXmAEINEbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=5qnIRV16JM10yK5H3YWWMZELV/TSP7EO0rXjqLsfAUP5iLTOY8ekdIm3qePv3tTIICuzw9
	fFz2pcIXfkE7nLAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=Uh3mOKkOhx+HVFMSZ5k7AADCuvrdgHvpTNjddVV5MyqmOIFgNEKc51kasLlB51LeVwS7nd
	CkYXcESc5SfBjN7E2ygO99A8HIP55lvMYLqqBjaaDyOtahTcISGYEX0lc3fo/xj1ITdkr1
	YJ1H+es6nIAREuNqZwDh8SXmAEINEbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=5qnIRV16JM10yK5H3YWWMZELV/TSP7EO0rXjqLsfAUP5iLTOY8ekdIm3qePv3tTIICuzw9
	fFz2pcIXfkE7nLAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8B913587;
	Tue, 26 Mar 2024 13:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0mu8CSHKAmYJNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 06/20] nvme/rc: use long command line option for nvme
Date: Tue, 26 Mar 2024 14:13:48 +0100
Message-ID: <20240326131402.5092-7-dwagner@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uh3mOKkO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5qnIRV16
X-Rspamd-Queue-Id: 4CFC537BBA

The long format of the command line option are more descriptive and more
likely to stay stable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e67bb846ab77..6bf2e3ae37c5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -148,7 +148,7 @@ _require_nvme_trtype_is_fabrics() {
 }
 
 _require_nvme_cli_auth() {
-	if ! nvme gen-dhchap-key -n nvmf-test-subsys > /dev/null 2>&1 ; then
+	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
 		return 1
 	fi
@@ -396,13 +396,13 @@ _setup_nvmet() {
 _nvme_disconnect_ctrl() {
 	local ctrl="$1"
 
-	nvme disconnect -d "${ctrl}"
+	nvme disconnect --device "${ctrl}"
 }
 
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}" |& tee -a "$FULL" |
+	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
 		grep -o "disconnected.*"
 }
 
@@ -496,11 +496,11 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
@@ -565,13 +565,13 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(--transport "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	nvme discover "${ARGS[@]}"
 }
-- 
2.44.0


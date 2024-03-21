Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5F5472A
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014457; cv=none; b=eh3pTwwp/pewYapp/caS9LRJOJhqcILN614VjxhOpazmBsXbkLTmisXZKyiXft4Qw4V1JVtec7YlGhhRuL9nZqidIUruQK+JkJX/BLFXdLQTp+uNShvI51WVy/muZPdR50bupNpYlE9ldPSWsArSAeaVd+sU7mIVOM4/nnyr0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014457; c=relaxed/simple;
	bh=62QX67pPG7Trr/NpLghixhX2vMiWq4U2av/UWRlF5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHZcCpimjlrt30/3wikwdMs6k1ILAmGANnRi3caH9ooCG3z5GPE8D8zK2AazQhpdD8aX2AOG/0FK5mGMyuFzfZ0oAEOvlagHeCeTPZxyrDn3kZ44uFdbc//q5cV3CYwU9C3lWu4lKwW4mzNMT4Bgf2hZ9exPVu8OD/dw9VKugAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vyg0BDIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+QIshHt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vyg0BDIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+QIshHt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vyg0BDIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+QIshHt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vyg0BDIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+QIshHt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 098FF5CBC4;
	Thu, 21 Mar 2024 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU+W8jWSw/g0+BVz/oBmRDbvxTlP0TFnSeTNrv8knUI=;
	b=Vyg0BDIfextnXpBWmxmFbEMn4/x7uXPHqzBA7wPvL/MIGZRAZ2KTiCD7pIJneWL1Ng4s4w
	sQxOzfyYdr4gXaBenhsdW2qWbJhxm7E9k1ouVc061q0+m4oGRUCPTEDjy4JUYuCVx4L3d5
	nfhT2hYlNrdwVi1i+FCd/BNzyu7Fvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU+W8jWSw/g0+BVz/oBmRDbvxTlP0TFnSeTNrv8knUI=;
	b=6+QIshHtVbZmqbQxCFGyczyrjHyhi0pte5pu1HZ/BefZakUTViYPGJ2EI8I7ca7RBK2Lmx
	RSzz0iVzljJ8mjBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU+W8jWSw/g0+BVz/oBmRDbvxTlP0TFnSeTNrv8knUI=;
	b=Vyg0BDIfextnXpBWmxmFbEMn4/x7uXPHqzBA7wPvL/MIGZRAZ2KTiCD7pIJneWL1Ng4s4w
	sQxOzfyYdr4gXaBenhsdW2qWbJhxm7E9k1ouVc061q0+m4oGRUCPTEDjy4JUYuCVx4L3d5
	nfhT2hYlNrdwVi1i+FCd/BNzyu7Fvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU+W8jWSw/g0+BVz/oBmRDbvxTlP0TFnSeTNrv8knUI=;
	b=6+QIshHtVbZmqbQxCFGyczyrjHyhi0pte5pu1HZ/BefZakUTViYPGJ2EI8I7ca7RBK2Lmx
	RSzz0iVzljJ8mjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED12E13976;
	Thu, 21 Mar 2024 09:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hmRuODUC/GXDDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:33 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 06/18] nvme/rc: use long command line option for nvme
Date: Thu, 21 Mar 2024 10:47:15 +0100
Message-ID: <20240321094727.6503-7-dwagner@suse.de>
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
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ***
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

The long format of the command line option are more descriptive and more
likely to stay stable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b4c88c37f6c..f8bbad873a5f 100644
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


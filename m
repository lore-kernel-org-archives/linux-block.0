Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF902C6A8
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754751; cv=none; b=kdipoqXpGf3V/wxilJ7Lbh58/lzhaVkll1CVZ70QhcfuOUJVvjJFIuff8Jy3TVgZMA5ZnN3fBfPeGASQNFlG7ek8QPZ9LVXJE0bR7RzoFPMXjieAcqbWFVJeEd2RhZWWBLZu6kqOMeDqWk28oLYCcfYdycHDCLq5MR7HhgjdOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754751; c=relaxed/simple;
	bh=kHPfNXEhuMPCDiYIuRhkw+jYzPfJZ6HRWqE5dOZXYnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkXKZLaQ8EicIjBq0MHaORcZKwfQ2gJLkAD3zvIlTTAoGRVCxZPvNTWU4ph2lrDeAYSM625ZIs7RXCDoA+I6Rsr4RHr82zW6wCPW/45E7k9NgbR+6vYUhqcHezK5fMdzSSk4f/iymEYldAArWtdpn0+LV41QLG5GWI3YXNVX0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DfoZ1Zog; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2WDy+rI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DfoZ1Zog; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2WDy+rI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DfoZ1Zog";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2WDy+rI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DfoZ1Zog";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2WDy+rI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EEA55C33B;
	Mon, 18 Mar 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4PSsr4X2cIGMy5fwcBg3lof96My0QkkEzHK6F7hK6w=;
	b=DfoZ1ZogbBk/d2ycutjx7n+5axl1h0k2u2pHtUDAd4fn6j0T+Jsy1KzoogsYLNtvsWBl0G
	FnK4VuxbwbmkhdsXnKLESWkmqOEgMxFWL6g2CddnKIHov0Ru6wfaxmA2XFAHHpoJv+IAKM
	eJTE8/521riXhEmSc4oXSm22qzcsh9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4PSsr4X2cIGMy5fwcBg3lof96My0QkkEzHK6F7hK6w=;
	b=n2WDy+rIPic1RQJmjNx3B7FPb1ovPOLuDZaUoWDfSI0GFkGIAzrVpISG/RKGWDef3FlThf
	A6JCZRDp/GvxbeCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4PSsr4X2cIGMy5fwcBg3lof96My0QkkEzHK6F7hK6w=;
	b=DfoZ1ZogbBk/d2ycutjx7n+5axl1h0k2u2pHtUDAd4fn6j0T+Jsy1KzoogsYLNtvsWBl0G
	FnK4VuxbwbmkhdsXnKLESWkmqOEgMxFWL6g2CddnKIHov0Ru6wfaxmA2XFAHHpoJv+IAKM
	eJTE8/521riXhEmSc4oXSm22qzcsh9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4PSsr4X2cIGMy5fwcBg3lof96My0QkkEzHK6F7hK6w=;
	b=n2WDy+rIPic1RQJmjNx3B7FPb1ovPOLuDZaUoWDfSI0GFkGIAzrVpISG/RKGWDef3FlThf
	A6JCZRDp/GvxbeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CBF91349D;
	Mon, 18 Mar 2024 09:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHqSBbwL+GW6UAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 06/10] nvme/rc: remove unused connect options
Date: Mon, 18 Mar 2024 10:38:51 +0100
Message-ID: <20240318093856.22307-7-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
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
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

These options are not used, thus remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c23f6fe09b6a..af48593e2cb7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -422,9 +422,6 @@ _nvme_connect_subsys() {
 	local positional_args=()
 	local trtype=""
 	local subsysnqn=""
-	local traddr="$def_traddr"
-	local host_traddr="$def_host_traddr"
-	local trsvcid="$def_trsvcid"
 	local hostnqn="$def_hostnqn"
 	local hostid="$def_hostid"
 	local hostkey=""
@@ -440,18 +437,6 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
-			--traddr)
-				traddr="$2"
-				shift 2
-				;;
-			--host-traddr)
-				host_traddr="$2"
-				shift 2
-				;;
-			--trsvcid)
-				trsvcid="$2"
-				shift 2
-				;;
 			--hostnqn)
 				hostnqn="$2"
 				shift 2
@@ -510,9 +495,9 @@ _nvme_connect_subsys() {
 
 	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
+		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
+		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
-- 
2.44.0


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0D46546
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115423; cv=none; b=NS1FcjAw5qyx9dZlLtNwptliccXkrExI6pwIC+18WT5/ufSqc3ltWE1+XU0KYlOLfT5ThYXViVmmqS55OZ6HPgHJ7/dmRhKO3o4JeuwR5WpCPCO/GjXe8aanluvsIzFwaScPr2hV1WSPMnTtLaDLcOYgumdA5gRRkw6kAI5OmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115423; c=relaxed/simple;
	bh=427UI0q+gFxS02r9zeJ677KQIVMVpQvHECRYTSpZaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLh83kbosxP7Al1B/hSExvCMs+3P8wGJItDLZR1AY5wrm+Qo9GyrVKItPO0Rgtf+T7+Lq4vvM4w+0vYCYgup/mCK56Wl0HAaxUCxElicGVm4pTzMrMsbyMkld4eArEaq9/ps/Zowvg3QIbNab5l1w0te0ar+dQQckRXWCOyrgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w4YR8eKh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GOKSuBO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w4YR8eKh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GOKSuBO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w4YR8eKh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GOKSuBO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w4YR8eKh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GOKSuBO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A486938566;
	Fri, 22 Mar 2024 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=w4YR8eKhxIiZYeHFCV5s+ujMJVMaPa/ucQT98HW137Za9+dMITcn/tSkycqmxD3RKGLHtd
	DFYWByHp0YFAv5GjjjuV2/jIOJtQ5kopF4E98lWB+5cU2rBRbEA8QzpowZz1kDAETmk3VH
	mngD+cavPSsE+3yOLobowgWp8MhtsT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=4GOKSuBOcabJQ7DiRdVAvVvEkGok366qPSyd7V5+cDXRpZ4F8s+d46ANBV2lPy8NQGGR5g
	bKtxQcYMVMzs0qCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=w4YR8eKhxIiZYeHFCV5s+ujMJVMaPa/ucQT98HW137Za9+dMITcn/tSkycqmxD3RKGLHtd
	DFYWByHp0YFAv5GjjjuV2/jIOJtQ5kopF4E98lWB+5cU2rBRbEA8QzpowZz1kDAETmk3VH
	mngD+cavPSsE+3yOLobowgWp8MhtsT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=4GOKSuBOcabJQ7DiRdVAvVvEkGok366qPSyd7V5+cDXRpZ4F8s+d46ANBV2lPy8NQGGR5g
	bKtxQcYMVMzs0qCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 937FB136AD;
	Fri, 22 Mar 2024 13:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uUWSIpuM/WV7JAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:19 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 01/18] nvme/rc: silence error on module unload for fc
Date: Fri, 22 Mar 2024 14:49:58 +0100
Message-ID: <20240322135015.14712-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.65
X-Spamd-Result: default: False [1.65 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.55)[98.00%]
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

The other transports silence the error output when trying to unload the
module. Do the same for FC.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2d6ebeab2f6f..78d84af72e73 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -332,7 +332,7 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
 				"${def_remote_wwnn}" "${def_remote_wwpn}"
-		modprobe -rq nvme-fcloop
+		modprobe -rq nvme-fcloop 2>/dev/null
 	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-- 
2.44.0


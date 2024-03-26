Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B56CDA1
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458849; cv=none; b=h0KOV4V7rM4Yb8fkVH9YxBvRIKCYj4ZUBTzcKfj+BkTHYyY8iymDX9fUvJIvqxll7YrxqpXk+0tQZURPFczgfkRlZa7QKY+zUBvKtgPO8TsW45rUCeXukCDbZgSQ8KruK6zxP+SpFmPmKC8ht3GTMY5SyDZIkXQNMe11MFejoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458849; c=relaxed/simple;
	bh=427UI0q+gFxS02r9zeJ677KQIVMVpQvHECRYTSpZaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9aZ52HBmxEmcclXEI51MrWeFTDytLyTt3G7CZT5tS5+bEdufKIsdS9i3xpwxeG/vRH3m308GssHFblHsXH5+nDgler22lAFHqdFrtEQWsaNbFCUIjaJ9MlBR7MCaZ+rhC9OK6XlsjHPGPuR+EAU8fTrIqRLlnsiQ7T6chPy7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ovuhBFWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBegQxT9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ovuhBFWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBegQxT9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ovuhBFWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBegQxT9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ovuhBFWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBegQxT9"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDFB5D652;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=ovuhBFWwdn/dYh+5enRJmkPMmIoBAh9sSvl+hXlync638ZqkDENZMm3acOrKkjoyc9vr25
	8zYiNal0ODShwhSs50OH2oj6G+qHFJZOPrcaUV6LwhCJVuaPLPF4o118tXYj85zgVG8M1Z
	8U2wBX5Rd8j4NZGrumV1FxYI/KoHUiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=CBegQxT9aqXCnWtOEeZ1U7W3xRarZ4wKLQh9lxHdLhcrPTyE49nU8E1aNSn6YCEASBzmx3
	sKrqo6HdrjcvecCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=ovuhBFWwdn/dYh+5enRJmkPMmIoBAh9sSvl+hXlync638ZqkDENZMm3acOrKkjoyc9vr25
	8zYiNal0ODShwhSs50OH2oj6G+qHFJZOPrcaUV6LwhCJVuaPLPF4o118tXYj85zgVG8M1Z
	8U2wBX5Rd8j4NZGrumV1FxYI/KoHUiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcXhbsfc56xlq1mnzBpFBPcMEmf7LzKv1U7zLuZmvMc=;
	b=CBegQxT9aqXCnWtOEeZ1U7W3xRarZ4wKLQh9lxHdLhcrPTyE49nU8E1aNSn6YCEASBzmx3
	sKrqo6HdrjcvecCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D8F213587;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hKD1AR7KAmb8NgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 01/20] nvme/rc: silence error on module unload for fc
Date: Tue, 26 Mar 2024 14:13:43 +0100
Message-ID: <20240326131402.5092-2-dwagner@suse.de>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovuhBFWw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CBegQxT9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.58 / 50.00];
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
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.91)[99.62%]
X-Spam-Score: 0.58
X-Rspamd-Queue-Id: 1EDFB5D652
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


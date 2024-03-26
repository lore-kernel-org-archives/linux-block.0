Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61567A00
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458850; cv=none; b=chheRTqxXErcJTY/bcUY8P72/+AAE3r2RYAqdc2OT5qB6rtZ87lZGbVNZPCErdYT8BnAWDqvRlI5vTIiq4zZtxYCvfTerN/FtaI1inZ3Lmlt8+xhcf1GqB8IVeP1BUQlmzjHjBaNKGb2uxXV0EcF2myquWM1OP6iLakVsdRAoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458850; c=relaxed/simple;
	bh=DnVwCt5EWeuVuNmxdizQCr7Wj4BTezqAxCx2nVwmcu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7MorZlIElIWgkodt158edpW+1id3JzWxuY5fp0ssYM2BbbkiBnFEjqescoZ096ay3XP8NoOuQumD36np7moZjTsWAFNh7ZcJgtZ0JDZtkaT4oSO3DfKQ88fS3G3u1bpmhjM9JGgRRfoxNmh+GixajA/O5Qlqj+szy2acoGaFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AeprotHU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CL0WREfQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AeprotHU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CL0WREfQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AeprotHU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CL0WREfQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AeprotHU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CL0WREfQ"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 580E55D655;
	Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=AeprotHUM0W6b6YSUDMjpoDfRzPd1Kpy8EGYmHyZpGTw6ieYfz3uOveB3ZWmrdLk8wJ3lH
	3sLBNO6BTPaDsEuceV2vRKWhGWutq6IwDUjeEriPDlDzuhm9fGeG6LP3EBmHicKh4z6/7J
	v/ni/KGDZ0RWawAATXFbNstZrRKE/8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=CL0WREfQ6QYRV4kkpvIp1xd+qdY4K4eTlseloCE1maCJiOqw0zMFEg/SUpLtaCzviMtf7W
	hFJLtInzNCDT4xCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=AeprotHUM0W6b6YSUDMjpoDfRzPd1Kpy8EGYmHyZpGTw6ieYfz3uOveB3ZWmrdLk8wJ3lH
	3sLBNO6BTPaDsEuceV2vRKWhGWutq6IwDUjeEriPDlDzuhm9fGeG6LP3EBmHicKh4z6/7J
	v/ni/KGDZ0RWawAATXFbNstZrRKE/8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=CL0WREfQ6QYRV4kkpvIp1xd+qdY4K4eTlseloCE1maCJiOqw0zMFEg/SUpLtaCzviMtf7W
	hFJLtInzNCDT4xCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4715913587;
	Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5hrvDx/KAmYANwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:07 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 03/20] nvme/rc: log error if stale configuration is found
Date: Tue, 26 Mar 2024 14:13:45 +0100
Message-ID: <20240326131402.5092-4-dwagner@suse.de>
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
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AeprotHU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CL0WREfQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.84 / 50.00];
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
	 BAYES_HAM(-1.65)[92.81%]
X-Spam-Score: 1.84
X-Rspamd-Queue-Id: 580E55D655
X-Spam-Flag: NO

It's possible that a previous run of blktest left some stale
configuration left. E.g. when the module unload doesn't work (the bug
might in the kernel we are testing). In this case error out and avoid
confusion.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 865c8c351159..e67bb846ab77 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -658,6 +658,11 @@ _create_nvmet_host() {
 	local nvmet_ctrlkey="$4"
 	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -d "${host_path}" ]]; then
+		echo "FAIL target setup failed. stale host configuration found"
+		return 1;
+	fi
+
 	mkdir "${host_path}"
 	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
-- 
2.44.0


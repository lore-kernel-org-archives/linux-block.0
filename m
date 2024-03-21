Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598555C3E
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014461; cv=none; b=tg2rJnvguBAAqj81Tw151IGQmMSQDRCBmMiv0Qr3/Bjd2QGy2pQ53r6ZroUtnsdlVVpdhCSQLBfwgMFYGwJ3MXS+/z8BSUQdyKw0ud81Jwu5Rtorz2uGNgm25K+ht8s2IasjGJPx8DTw38FbYK6fYa+vn1oAblq7FzNJRyNuZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014461; c=relaxed/simple;
	bh=foSF3oEoPrhYnxXgoSK4+5LEAMTOqNqA4ppUZN5gjxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfOPWa60I+ZTQH21175dk60c308s3JOvhXLsFDipjBQWMu/GdhcEPEPJ8FKDEZjUby49sjs1ffkYdsBqvBPus3f4Zo5Csoqp/FbJQGQKZaIw0k05sZzZk6jbdl3hKj4iJDWqC9Gd4U9gd62ir9kRKTpzFeFnf+PNT+s+j04+5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bwLUK99a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Djaw7sbu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bwLUK99a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Djaw7sbu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bwLUK99a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Djaw7sbu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bwLUK99a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Djaw7sbu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3298F3715A;
	Thu, 21 Mar 2024 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGeLl5WEAa793vjrOKZVLNQhTJwlJbFni6zh2vQYVkk=;
	b=bwLUK99aPbsYDgFcsp49HShNMvShdONfYnH4uUYFtAw6irlWU88TX4h/1J4tPiFnojS2ub
	t+gLtMwWntsBOnZf7ahmcU6lKbCu8VABKa8Ec6Z6im1B1nZp1HqsKaLhO2FFOiMfuUETGe
	N2YqOBZ7pFepvmxwEKClrhwIqtdODnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGeLl5WEAa793vjrOKZVLNQhTJwlJbFni6zh2vQYVkk=;
	b=Djaw7sbujYNSbcKWVDSPpcQKycoGrj8+KDOpjxloi7emsxkE4+0ycjskpURYMEm43eo1kF
	Sc7yDClrX1auM2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGeLl5WEAa793vjrOKZVLNQhTJwlJbFni6zh2vQYVkk=;
	b=bwLUK99aPbsYDgFcsp49HShNMvShdONfYnH4uUYFtAw6irlWU88TX4h/1J4tPiFnojS2ub
	t+gLtMwWntsBOnZf7ahmcU6lKbCu8VABKa8Ec6Z6im1B1nZp1HqsKaLhO2FFOiMfuUETGe
	N2YqOBZ7pFepvmxwEKClrhwIqtdODnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGeLl5WEAa793vjrOKZVLNQhTJwlJbFni6zh2vQYVkk=;
	b=Djaw7sbujYNSbcKWVDSPpcQKycoGrj8+KDOpjxloi7emsxkE4+0ycjskpURYMEm43eo1kF
	Sc7yDClrX1auM2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F61B13976;
	Thu, 21 Mar 2024 09:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZKQrBjQC/GW8DwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 03/18] nvme/rc: log error if stale configuration is found
Date: Thu, 21 Mar 2024 10:47:12 +0100
Message-ID: <20240321094727.6503-4-dwagner@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.72
X-Spamd-Result: default: False [3.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.976];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.20%]
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
index 53fa54e64cb2..0b4c88c37f6c 100644
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


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125046435
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115429; cv=none; b=tgt6D7BpVqdqLxDqpU2p7z6AHj2IVNUSKbl1XLy0/8rCDIp3vdL1iPcP/vwcmU6RiQkrz39ga8H1oONNxnE2aYSvNvwcUf6jpy8v+k9o7sKGlhsxwnJ9cRD66BeORiQrM4xXSZ+nUa4PH/NlBD7qHG73nvMChK1HFMetztC2iSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115429; c=relaxed/simple;
	bh=5MRnSWLpW8hj/Oqu2KDlVtApORbWtKK+RCzEKYe7gzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8unuBT8ssw0sc/kqTGJWy/Dr942hGxZKrT8ItdrYoUjP4mZBagr8dZGWEvVx6cBU54v1ZJg4tRiwiMO/J0qVNOK5DTTEMUQh2sM82KtEKwkCjJ9VfDCW8rni8p/Y+DCLzXXTlCRmFJTaP4jteJfo8gqCQg601CWq9d0/EphI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYCLQaAC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+XqR3yW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYCLQaAC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+XqR3yW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYCLQaAC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+XqR3yW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYCLQaAC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+XqR3yW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95D6238563;
	Fri, 22 Mar 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=GYCLQaACP+BibsfMIHwOXYAA4iNTO9oXfhNwQYzc4qSeqGDa4NWylWH4UGVqhOupWuNq79
	VYDJJCFiLFQpwu13E1+N14ZSW0rOygvh5MHZOYzUqMV2GjgBhysy8Bveo7EgDOISGmFZcI
	c+QdkOcp9gC9AUv7BVAoMgHyVllJXyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=6+XqR3yWByZGy8zfxZIIeSK5+msfFEitTGQDUo6Bocgp2Nrz95avj2P2esjz46eRFGQCpl
	r3H2118qtn00/wBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=GYCLQaACP+BibsfMIHwOXYAA4iNTO9oXfhNwQYzc4qSeqGDa4NWylWH4UGVqhOupWuNq79
	VYDJJCFiLFQpwu13E1+N14ZSW0rOygvh5MHZOYzUqMV2GjgBhysy8Bveo7EgDOISGmFZcI
	c+QdkOcp9gC9AUv7BVAoMgHyVllJXyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxxqfi5Ng/DrXSdCBEaIZL1gVtEAJyeAtVHnguQ9pk=;
	b=6+XqR3yWByZGy8zfxZIIeSK5+msfFEitTGQDUo6Bocgp2Nrz95avj2P2esjz46eRFGQCpl
	r3H2118qtn00/wBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8344B136AD;
	Fri, 22 Mar 2024 13:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BI+JHqKM/WWWJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 12/18] nvme/031: do not open code target setup/cleanup
Date: Fri, 22 Mar 2024 14:50:09 +0100
Message-ID: <20240322135015.14712-13-dwagner@suse.de>
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
X-Spam-Score: 1.88
X-Spamd-Result: default: False [1.88 / 50.00];
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
	 BAYES_HAM(-2.32)[96.83%]
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

No need to open code the target setup and cleanup step. Just use the
common helper to setup and cleanup the target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/031 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index ed5f19668674..204ba7d2892f 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -40,14 +40,14 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
-		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
+		_nvmet_target_setup --subsysnqn "${subsys}$i" \
+			--blkdev "${loop_dev}"
+
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
-		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
-		_remove_nvmet_subsystem "${subsys}$i"
-		_remove_nvmet_host "${def_hostnqn}"
+
+		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
+			--blkdev "${loop_dev}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.44.0


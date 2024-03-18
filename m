Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F72CCB3
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754753; cv=none; b=V8j8UCsdI67+PifUpsQMbVun1W9TWK/pkd3k0llc76L9FnETHl8rNkdk3VXxrv6wPxON+vCVAYxmnk88ZVh5PW3Lceb2nbpq9vudHKqVLlkjuvW1xx5Ab2G+IyH4q31EJfqlzKTN8jP+A27pKVYemHojEhjBtNICXG46o0RwbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754753; c=relaxed/simple;
	bh=ePQEE4FlagJFJPTNc1c+7l36gxxdHk2H1DGNV7IhTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU0m6ot1ntedkFMG5wzcIBON4VqvTZrBcQ+puwKYoMVmY0XvKICqUuuZEV8h0rg8Vc6xA0U/yoxPlwemJO2okLr3/K6bVfPPnNCGvGey+dUV1EsoQ34zEqayFZhsDUVtVM6WHutUu3Ci1sij+zUKo+qudfB4ecKGNrKmlEvPxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlJr2Qf3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iGBZS/B5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlJr2Qf3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iGBZS/B5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlJr2Qf3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iGBZS/B5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlJr2Qf3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iGBZS/B5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 033F634880;
	Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=NlJr2Qf3YeogvOMi8IwuzUlxL2PU9NpdK6h7jBMaDbN0/kqxADEdi0AMH34C7bJJIBLsKh
	rcfgM+8G6FruR0pjbPK1L4UKJu/jUBHb8i6eF5d8aLKYWMBRwLin9wztmZ9JWWdKGCRAhq
	x4hr9wc5k7bf2DIOe/CJTbta/jJkZRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=iGBZS/B5BPrEVXUMCQAl9gpZm/zSorlXZh1gt259ZP428ocuDK2HjJl6ITH9O2XTsPPLMQ
	TySliGGt+Uza9QCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=NlJr2Qf3YeogvOMi8IwuzUlxL2PU9NpdK6h7jBMaDbN0/kqxADEdi0AMH34C7bJJIBLsKh
	rcfgM+8G6FruR0pjbPK1L4UKJu/jUBHb8i6eF5d8aLKYWMBRwLin9wztmZ9JWWdKGCRAhq
	x4hr9wc5k7bf2DIOe/CJTbta/jJkZRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=iGBZS/B5BPrEVXUMCQAl9gpZm/zSorlXZh1gt259ZP428ocuDK2HjJl6ITH9O2XTsPPLMQ
	TySliGGt+Uza9QCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E57651349D;
	Mon, 18 Mar 2024 09:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a052Nr0L+GXCUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 08/10] nvme/031: do not open code target setup/cleanup
Date: Mon, 18 Mar 2024 10:38:54 +0100
Message-ID: <20240318093856.22307-10-dwagner@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.38
X-Spamd-Result: default: False [-1.38 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.09)[88.09%]
X-Spam-Flag: NO

No need to open code the target setup and cleanup step. Just use the
common helper to setup and cleanup the target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/031 | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index ed5f19668674..892a52170ce9 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -40,14 +40,12 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
-		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
+		_nvmet_target_setup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
+
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
-		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
-		_remove_nvmet_subsystem "${subsys}$i"
-		_remove_nvmet_host "${def_hostnqn}"
+
+		_nvmet_target_cleanup --subsysnqn "${subsys}$i"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.44.0


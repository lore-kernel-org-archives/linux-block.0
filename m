Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983456B62
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014463; cv=none; b=JLC8a428C2n5iUfSjEQDzOg1fQUmb2LwiWf9Zvxcp9/ad03kSQQyGZVvlAIX87xQaRwgPORA6pH9bltTQrp9jkyDFrUEAI2XJv6yK/xGc1kgWtPbmU+MD8i1SWHvEao2EVHo845hkfLLFmYZfiANc1CJkb7DVs3OkQ+TAhIq/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014463; c=relaxed/simple;
	bh=ePQEE4FlagJFJPTNc1c+7l36gxxdHk2H1DGNV7IhTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGnEBaAMSNitiPdRaWV92XHVsKbn2tjrQ+3Ldjip9PBt56h2PhMBGcYuEyDfUoml1ZNxKJkB1ZGPkaNbwTT5YoSyJGTP25RrSFGrQINHLUXbZCh4CnqR/kzDwuIlH2XbRpmkErd48DA4WPh+HSLa/JgaWfhpX9seN3PB7Y4Q/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x5I8yBjv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IhiRnrJN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x5I8yBjv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IhiRnrJN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x5I8yBjv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IhiRnrJN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x5I8yBjv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IhiRnrJN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B67D43715D;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=x5I8yBjvFxWXWXFDBCvQDdgJeeSrMdqg+oNHLKJ6Xx4HJvwiZ6f/afHbb6YSaGZxoJhuse
	dujqKibsnrJ/Ttz56DdESMSYccVk3JPz4WOx0AHjFSZZ1PFpYKuQWdrd+4xhCGqREytoBE
	O/jZe8pj1YXq8/4xeEHe+2Aq17ZYB28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=IhiRnrJNAj1YIj+uMO6SfFuPB69WPHImeSJsBozPVQNJQ/6zx3oU3bCTf2OI/1D4+8k7tz
	VOmoFvoJSLxTbwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=x5I8yBjvFxWXWXFDBCvQDdgJeeSrMdqg+oNHLKJ6Xx4HJvwiZ6f/afHbb6YSaGZxoJhuse
	dujqKibsnrJ/Ttz56DdESMSYccVk3JPz4WOx0AHjFSZZ1PFpYKuQWdrd+4xhCGqREytoBE
	O/jZe8pj1YXq8/4xeEHe+2Aq17ZYB28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyzDDp3p3lrp1DsUfN/vs/oKyxmll6oQP8NBXF15qX8=;
	b=IhiRnrJNAj1YIj+uMO6SfFuPB69WPHImeSJsBozPVQNJQ/6zx3oU3bCTf2OI/1D4+8k7tz
	VOmoFvoJSLxTbwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4EEF13976;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id osDWJjkC/GXdDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 12/18] nvme/031: do not open code target setup/cleanup
Date: Thu, 21 Mar 2024 10:47:21 +0100
Message-ID: <20240321094727.6503-13-dwagner@suse.de>
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
X-Spam-Level: **
X-Spam-Score: 2.31
X-Spamd-Result: default: False [2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.978];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.41)[91.01%]
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


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41D55E4F
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014461; cv=none; b=ByDpFx6JQkrUOhZYaSIWKxRwSC5xfCzcKLBrsh5F+gdwjrLRus+8pP+24xt2fahUEFPMoZNmyqR8mQWhxYW+pDp33z7XpwY7E5RO5g9bettGbZPL51T/lv/6PHirm/fYXcWd1UlGo7x0P48s8qBRNWInfB9b6aB1WkRMrTuQSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014461; c=relaxed/simple;
	bh=ZMuiMm2YBbt9BkhqcRyU/ZId3xKi8LNTjgFaTJYb/wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htDhjw6NVDq7tNxdA+tWs7/F9Hhm1Y9/NvqXVqRmtmHQU8vQdVCZ1A6BhXjPMoLSJ+sp+jwiD2DtG2LD+8an/yGTHgZMH+W00vp7OswNylss4nyvH0B5GeTPtyARgng7WiDSZYGu2hka8dlA7IYg+Ut+uGiRHcxVL2qv/gdJ+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q7tmfp6h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MWFA+urw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q7tmfp6h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MWFA+urw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q7tmfp6h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MWFA+urw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q7tmfp6h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MWFA+urw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548CD5CBC8;
	Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=q7tmfp6hi2dtoZTo/ojsmHtopM70td/ZVJoFQ1fAhAVmPq2dbiI/Z9R5MWg+w7JFmrmkgz
	aJNfetjTKd5SXpWzLrVrD8BhhzCBbsF/LyvYKYlAoO3fLB9XNFsnKDtWamwv02C8ZALFd1
	l/tn5thFtPw1VgD4PdiRuSA+gnVUOz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=MWFA+urwDm/7whjt1gtdSYqZR4RpJ4Z19kC2lmTkCBImJUXLc/BE8/lellTgLkwRT/EBvp
	fbLKazjW0ZIhEFCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=q7tmfp6hi2dtoZTo/ojsmHtopM70td/ZVJoFQ1fAhAVmPq2dbiI/Z9R5MWg+w7JFmrmkgz
	aJNfetjTKd5SXpWzLrVrD8BhhzCBbsF/LyvYKYlAoO3fLB9XNFsnKDtWamwv02C8ZALFd1
	l/tn5thFtPw1VgD4PdiRuSA+gnVUOz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=MWFA+urwDm/7whjt1gtdSYqZR4RpJ4Z19kC2lmTkCBImJUXLc/BE8/lellTgLkwRT/EBvp
	fbLKazjW0ZIhEFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 425B713976;
	Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ky7DjoC/GXfDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 13/18] nvme/{rc,031}: do not cleanup external managed loop device
Date: Thu, 21 Mar 2024 10:47:22 +0100
Message-ID: <20240321094727.6503-14-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.60
X-Spamd-Result: default: False [3.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.977];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[67.21%]
X-Spam-Flag: NO

If the test setups a loop device itself (not created by
_nvmet_target_create), do not cleanup automatically.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/031 | 2 +-
 tests/nvme/rc  | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index 892a52170ce9..bfc43282411e 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -45,7 +45,7 @@ test() {
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 
-		_nvmet_target_cleanup --subsysnqn "${subsys}$i"
+		_nvmet_target_cleanup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
 	done
 
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d74a5418557d..e6e7b113ca8b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -855,9 +855,14 @@ _nvmet_target_cleanup() {
 	local port
 	local blkdev
 	local subsysnqn="${def_subsysnqn}"
+	local blkdev_type=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -878,7 +883,9 @@ _nvmet_target_cleanup() {
 	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
-	_cleanup_blkdev
+	if [[ "${blkdev_type}" == "device" ]]; then
+		_cleanup_blkdev
+	fi
 }
 
 _nvmet_passthru_target_setup() {
-- 
2.44.0


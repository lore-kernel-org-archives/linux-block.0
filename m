Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7347A7A
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115429; cv=none; b=jeAWrhrq4i0VY9aca44k/tRNoXX4+mPAqqlzkPRoHPsAQ2Kv20cG5UZKH0NdsUHZisSY65hPGJ0ZloLsoCOzANk0Hg8i8royr0hPCV5faB7de1AY63+qjRiZojZeAzc1UVC5CCrNSQT+d2WvACZf+Xfs8touAOPZ7Kpqkp/TIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115429; c=relaxed/simple;
	bh=gsNU7h7keSEkO72yj8qqSUmR9M8p6D1Zx0HQ1kQW7Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwkBAfOFP+noU/HwAA/PoDCB4tfjN5tOt7CEAkoMbjn9LyDavPMpuJy38ae99it9N5R0uxQFi8dpX53InDHS8gqfEtZT3QlglRmRDrgefI1RR3sZqChSgXA5uuZLFKUyuzIm3aUoubGfcBcboKN9IGhaLPpPiaL5sv304ZMY5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ME82K/oW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q/VTt3Yz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SmRpG85B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zBnM+US+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ME82K/oW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q/VTt3Yz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SmRpG85B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zBnM+US+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBAA33856B;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=ME82K/oWdiEFfq87+g255APUS3QSdhh1jH6c+ZDOB/Frf+o2qU1eZJ04wOCqvhrPX0Vn7v
	9xOPV8kd+O2RHCmm67ljSmF9UHhsYbS+shwV3K2vY+Dz0j9yOti17iQiynM2SPp+RZT29+
	XcJj1vxUdH/xLnFwWiPs9yLZV5jltM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=Q/VTt3YzrGchJYhCVbFGhWC4cEjW19vyzSpjPp3n53lmNv5tGQsNWQ+UF+eijQTIxrxGXI
	V/FUoyRSCrHwyBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=SmRpG85BUV4/V1Dy3DVTosobvKku+rKtonnVpTVepZ0Pl8pETl0c/K3re74+3T61Xa2Il5
	wOixFWIX7xPt2ihUdUGDct5qHQG8EFBlYvegNbJNZ3xLcq4WS78EjRIhCFpmgLvilzRZ7E
	8ejG8Zw0QisLGuojTB89rzdCAzV1kIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=zBnM+US+C3q+rIElXZj+EWOhstxsQt0+tu4O6fqbaMFow/Kt680Zfsgz5rou1+jtri+PaY
	LP6yeZHkxG085xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAF5F136AD;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YxobNKGM/WWUJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 11/18] nvme/rc: do not cleanup external managed loop device
Date: Fri, 22 Mar 2024 14:50:08 +0100
Message-ID: <20240322135015.14712-12-dwagner@suse.de>
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
X-Spam-Score: 3.04
X-Spamd-Result: default: False [3.04 / 50.00];
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
	 BAYES_HAM(-1.16)[88.80%]
X-Spam-Level: ***
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

If the test setups a loop device itself (not created by
_nvmet_target_setup), _nvmet_target_cleanup should not cleanup the block
device automatically.

Because _nvmet_target_cleanup has no way to figure this out by itself if
it is managed or not, the caller needs to pass in the block device type.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4ad6cb640627..9d47c737f9b0 100644
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


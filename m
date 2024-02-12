Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E502BAE3
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734455; cv=none; b=kDIqfTRFbiUW3VExHBEZkhQ8terouBacDBkArBAg3Gw+Pv8yE0xoPZ1lAj7VSWN6ZtYyn+JFXqlvv+pNZX+NjKuCSnilIwGCPjNtnUa4QiWGNlKAOO6ul2mMr+U6M72Kz6nklUXnNRcgzCH7vjVfgr//PLIVPXNIYJXVdNPUC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734455; c=relaxed/simple;
	bh=0e7qnMi4iDs30y9LcEpAjotTvJ2Ld9cm6VRChGZN5DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2tXKfKy5yDfKxicUctZl8ktEDtVh5pzswt5x/A3QCevt6PDsDoeGZ6186cehkIbrvrn/qIdZZbDHEfamQzhjOVE1MnFJWiRGgwqzaK5umXlw3+En7/vrszFgdH/2TDFJcROl5Jyyv8zrFc6hVwoCKev0Kg/wbrq4paykCZvyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feXXkulG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RYaeIo1y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feXXkulG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RYaeIo1y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feXXkulG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RYaeIo1y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feXXkulG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RYaeIo1y"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84C71FBAF;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=feXXkulG+ZmbY3LZrDlJ4DVbmLQPxHyXlMg1lC+cGqDDk/Fl9jISd6y6pTBreAuJmMDNja
	AcNKFlG+KD7JbexZ6pICKw34MGYNrqRggLtp2UTUx2bGV4Vtn72sKrJuwkh/AbK8OJozQW
	4RP863Tbt9o+oaLAxUabVxbOkeShqzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=RYaeIo1yAg/+y5PmxEP1W4TgCVLeQ98BXFf/PDsm+B0zmgIeuRZWf7UsFTwBYcoRCmfdP7
	s6zvetRxM2EwN7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=feXXkulG+ZmbY3LZrDlJ4DVbmLQPxHyXlMg1lC+cGqDDk/Fl9jISd6y6pTBreAuJmMDNja
	AcNKFlG+KD7JbexZ6pICKw34MGYNrqRggLtp2UTUx2bGV4Vtn72sKrJuwkh/AbK8OJozQW
	4RP863Tbt9o+oaLAxUabVxbOkeShqzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MZGe7xbvFWzEvcOYAPbHp3XTRaDLXD1TMzZeTrCBNs=;
	b=RYaeIo1yAg/+y5PmxEP1W4TgCVLeQ98BXFf/PDsm+B0zmgIeuRZWf7UsFTwBYcoRCmfdP7
	s6zvetRxM2EwN7BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B741113A0E;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ny9KK7P1yWXtCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/5] nvme/rc: filter out errors from cat when reading files
Date: Mon, 12 Feb 2024 11:40:43 +0100
Message-ID: <20240212104046.13127-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feXXkulG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RYaeIo1y
X-Spamd-Result: default: False [-0.31 / 50.00];
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
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: C84C71FBAF
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroyed while the tests
are running. This races with the cleanup code and also the
_find_nvme_dev() which iterates over all device entries and tries to
read the connect of transport and subsysnqn sysfs attributes. Since
these steps are not locked in anyway, the resources can go away in
between.

Thus filter out 'cat' reporting non existing subsysnqn or transport
attributes. The tests will still fail if they can't find the device etc.
But without filtering these errors out the tests fail randomly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e0461f1cd53a..9cc83afe0668 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -350,7 +350,7 @@ _cleanup_nvmet() {
 
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
@@ -840,7 +840,7 @@ _find_nvme_dev() {
 	for dev in /sys/class/nvme/nvme*; do
 		[ -e "$dev" ] || continue
 		dev="$(basename "$dev")"
-		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
 		fi
-- 
2.43.0


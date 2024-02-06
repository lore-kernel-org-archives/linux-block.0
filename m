Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D13130E4F
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225428; cv=none; b=mpKqWvY3OFmS12l18dtfVcM5Yh9/EArQPQrz5JHA0B29PDH26uDbLX6sIiy0+AB40HoojaSs88PgTPrfZGTaFI63xYlmN2ydp7ChuzbQ15FoUjbQnNR6zn8H6rpwCYfi6J5Pvxkl/TO8PGClGJ00tKSulPpV5UHO43JXyJD+m5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225428; c=relaxed/simple;
	bh=tUOB6wqH7Ru5G0CZVs6zIUs+NNYQNuvjg12ci17Koeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llderLjjnYjdeiCLVjWrB2wbxnqcONcfcvagXw3aLwMjwZz2b/j3+tbMz7yArFAcDXVxwT33E00YNu0195bFLwI8k0d+L8aVZRfjC1ZhsNQTw/ofxXayoPpFay/9BmWzeAjJUdMzDF6CNOFVkOQvUdYKrtMiaLr6+rHU1kxlrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=voXOhrLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/U8FEUyl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=voXOhrLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/U8FEUyl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="voXOhrLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/U8FEUyl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="voXOhrLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/U8FEUyl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 380F51F385;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=voXOhrLpyCMvH+katTJ7JXo91KMWauGNPnOmSMaLqsxGFd7pMZrdcDX7LnqF2p5i6jXPwe
	wOoFPPUPfm2wMJlWxtUa+kfmXwXCR7rvKaic6O1HWnDIcF8mOu3eAENVS70vjjM9OMum1D
	R8b/r4rCYC0V58d30dDxK8zLH9FB7UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=/U8FEUylyR/YKVllKObbSeMW1vjM2+ZqrRyI7Ap1cEoRqLf5Cw7Ydssujii55wAoL8sHS5
	IwdvLU48pTSUw0AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=voXOhrLpyCMvH+katTJ7JXo91KMWauGNPnOmSMaLqsxGFd7pMZrdcDX7LnqF2p5i6jXPwe
	wOoFPPUPfm2wMJlWxtUa+kfmXwXCR7rvKaic6O1HWnDIcF8mOu3eAENVS70vjjM9OMum1D
	R8b/r4rCYC0V58d30dDxK8zLH9FB7UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=/U8FEUylyR/YKVllKObbSeMW1vjM2+ZqrRyI7Ap1cEoRqLf5Cw7Ydssujii55wAoL8sHS5
	IwdvLU48pTSUw0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D8E132DD;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gWZoBFExwmV0OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/5] nvme/rc: filter out errors from cat when reading files
Date: Tue,  6 Feb 2024 14:16:52 +0100
Message-ID: <20240206131655.32050-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.89%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.87

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroys while the tests
are running. This races with the cleanup code and also the
_find_nvme_dev() which iterates over all device entries and tries to
read the connect of transport and subsysnqn sysfs attributes. Since
these steps are not locked in anyway, the resources can go away in
between.

Thus filter out 'cat' reporting non existing subsysnqn or transport
attributes. The tests will still fail if they can't fine the device etc.
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


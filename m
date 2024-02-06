Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25C130ACB
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225429; cv=none; b=KL/1GB7S5P6fLvHsc8qxTPnIKWRpGGdLXCLNxFjyae/YVhilcbVrb2B90BoQtEL3tZ+8/X4O0bs3uDNadCdjtfRqF9XKNlMfrIS/41Dr3BP9IdMMR6WzwC9Kqxq4ewRS4khymRTzEC17e59WlI8q+Ke21HwOT0Hxb23WDakiCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225429; c=relaxed/simple;
	bh=QEI6CCAK6WlBbQ19G4HxQ/wmiiapINcpvN/wqAwnMd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bayBL3jaohqr3Uf7Ka1aCliysx1Pjop/mxIAd4CkQE4d8b/yv4J7k4rX0UAS7bWhPHp5KmIU0NemA/rGRowVrk064czPmNoWlSZJeTAuII3/zIqdfIfgn+0EzR0tK+NsfPVmOzkFWuCBA2DvciCWDiNqr4Y+xhJt8118i42qgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0B1n+p6r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hfg5g6eo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0B1n+p6r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hfg5g6eo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0B1n+p6r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hfg5g6eo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0B1n+p6r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hfg5g6eo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8D95221B6;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=0B1n+p6r6cirVgvHxUj/0XZ6kGCfWe5q2s6A8+RrNq17J0enXkh1isctzOBM/5hz07zP2z
	2/FILAeWqrMDPdEh0UcMVbZ9lW776qr0UoOkggPNSciKXvlrLcGTqEY/sIC5odWCiZqOLH
	SWf5fMqP2M685q0fDtsyGu57vlYsNTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=Hfg5g6eomPTIU3ayWFG1irg3it7FEzUBy/CwG2JNvxNrxIBC+/dAArFl6mw1Tm7UPpJcLD
	RQBzptaL738eAhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=0B1n+p6r6cirVgvHxUj/0XZ6kGCfWe5q2s6A8+RrNq17J0enXkh1isctzOBM/5hz07zP2z
	2/FILAeWqrMDPdEh0UcMVbZ9lW776qr0UoOkggPNSciKXvlrLcGTqEY/sIC5odWCiZqOLH
	SWf5fMqP2M685q0fDtsyGu57vlYsNTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=Hfg5g6eomPTIU3ayWFG1irg3it7FEzUBy/CwG2JNvxNrxIBC+/dAArFl6mw1Tm7UPpJcLD
	RQBzptaL738eAhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B628E132DD;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9G4TK1ExwmV2OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 3/5] nvme/rc: do not issue warnings on cleanup when using fc transport
Date: Tue,  6 Feb 2024 14:16:53 +0100
Message-ID: <20240206131655.32050-4-dwagner@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.44%]
X-Spam-Flag: NO

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroys while the tests
are running.

The cleanup code expects that all devices are under blktetsts control,
but this isn't the case. So just disable the warning as it is reporting
a lot of false positives.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9cc83afe0668..ca6a284a1e25 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -352,7 +352,10 @@ _cleanup_nvmet() {
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
-			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			# if udev auto connect is enabled for FC we get false positives
+			if [[ "$transport" != "fc" ]]; then
+				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			fi
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
-- 
2.43.0


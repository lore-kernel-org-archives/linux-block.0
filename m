Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9412FF91
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225429; cv=none; b=r1sT/+bTZWrLUUZCD9FUstV+k021LsyYRLzdrowuXcVH1qMAUoWLIUry3PN3OVEfIcACzweV11dm4tz7eqmUoQWFigoTUzvMTzlQSM0thlVB7AGHD1uNUOuLIcpGJ6embWY9VeQ4GvipEQmoF8DNEwO83dteqFSAgFs7wNnStmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225429; c=relaxed/simple;
	bh=zk+h+FPK8JpczcZ1evk8bYqROUtN7vA0wsCRxuD+5Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9mcuY9PodXusOpsVS+Scn28QFSOHeQObxWdnJ8xFk/B/a7r7vz6SatmyhLEAGhOaKVaXvXg+KrtXRNKFbewTry9UhWN64/Cg2Toga2PDf49EDr/t7rW1ut+Fj89Ch3MZUzvLK77e48WugLtpcjIxA6dFT7e2P95849BDvVsSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XJIT8AcE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wIL9t65s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XJIT8AcE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wIL9t65s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XJIT8AcE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wIL9t65s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XJIT8AcE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wIL9t65s"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 706B31F8B2;
	Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGE813DC4wgn02v3l+3zDYwYzJaXSH1sngaH71ya6uo=;
	b=XJIT8AcEsblh2XfQiuffEcytISHeWW8550YsO4tTbzPQFL5N/DpclBPvyO9SjZmraE+Jc7
	uvBnCEd1616RQA2hfrhF6mEPUIpVoC0FfZuKK5s4L9tL5Rc5hE/B4RLTKlmcEGuvVEe4Gb
	7dGK8sRfjjdZ4NMYXeRzBr3Fwk7g3Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGE813DC4wgn02v3l+3zDYwYzJaXSH1sngaH71ya6uo=;
	b=wIL9t65svwznXEYuvcRenRwmoompwG/hhng9wo2tGcRloJBiIRk36BSJNidhcYz5AeMn3+
	tCHu1jPOhkfH1eBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGE813DC4wgn02v3l+3zDYwYzJaXSH1sngaH71ya6uo=;
	b=XJIT8AcEsblh2XfQiuffEcytISHeWW8550YsO4tTbzPQFL5N/DpclBPvyO9SjZmraE+Jc7
	uvBnCEd1616RQA2hfrhF6mEPUIpVoC0FfZuKK5s4L9tL5Rc5hE/B4RLTKlmcEGuvVEe4Gb
	7dGK8sRfjjdZ4NMYXeRzBr3Fwk7g3Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGE813DC4wgn02v3l+3zDYwYzJaXSH1sngaH71ya6uo=;
	b=wIL9t65svwznXEYuvcRenRwmoompwG/hhng9wo2tGcRloJBiIRk36BSJNidhcYz5AeMn3+
	tCHu1jPOhkfH1eBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4DE132DD;
	Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6UZFVIxwmV5OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when disconnecting when using fc transport
Date: Tue,  6 Feb 2024 14:16:54 +0100
Message-ID: <20240206131655.32050-5-dwagner@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -0.35
X-Spamd-Result: default: False [-0.35 / 50.00];
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
	 BAYES_HAM(-0.05)[60.12%]
X-Spam-Flag: NO

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroys while the tests
are running.

The cleanup code expects that all devices are under blktetsts control,
but this isn't the case. Thus filter out disconnect failures as well.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ca6a284a1e25..cdfc738d3aec 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -356,7 +356,7 @@ _cleanup_nvmet() {
 			if [[ "$transport" != "fc" ]]; then
 				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			fi
-			_nvme_disconnect_ctrl "${dev}"
+			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
 		fi
 	done
 
-- 
2.43.0


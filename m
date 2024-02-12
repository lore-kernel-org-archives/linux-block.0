Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3838DE0
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734456; cv=none; b=uczxfd2zI2rDrmVBnPy95b/D3KqSWRqhPtO4/mFOmdnuBiIjz3nOk/k3QwBsGqRmxkER/lPqzxbCD3ucI3Bx3NWjLubNjQe+xdL7Hc1PvM1M68pDge9Fzpth8R4gRp078Ht0Pvt2MOwjWssKuXMnoYpGJp2ci4IWhdTG3ndTSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734456; c=relaxed/simple;
	bh=an6wMHi9l/AjaIBGt2xbeSsRIe0SwRCRMEs6P214p4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCayWRK9kGLSOIg5iPWbn1ox7XNWBZl8uJ2+ey+jK+f2dQsRMg7hu5wsbhG+TmeTYG82EH087K0mVjH3yo2dXkywenfgbxdgBlWykOkzabLwVwrT8AIkM5l66rrrYt5Ed/eUsMELTKYcbdAg1ig9r2JPZivcJJJjPPUVyx78gZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtiuk9NO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lJkMiqkx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtiuk9NO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lJkMiqkx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtiuk9NO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lJkMiqkx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtiuk9NO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lJkMiqkx"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB3622156;
	Mon, 12 Feb 2024 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=xtiuk9NOpemU3uORvgcriN7381bzxyPbmSc7Unpeahcts0tYRG4d5XmIGxCkjgIF141CVn
	q+d3ary0uXW03uKtEr99wbAfplyKaaAQZwkNNjWvVVmALX19huHA8tKrqhe5EVd03DqW8G
	MQMUyC2UmShvBTd6qHp0alq8oQ3YwKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=lJkMiqkx2bbwFf0k/qAHaIHynMCMqEg1gTZIpgbDeDXuSNoOIbfWyq5jX5FCxLWDcArrq6
	FkoJdJTYoZv5W+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=xtiuk9NOpemU3uORvgcriN7381bzxyPbmSc7Unpeahcts0tYRG4d5XmIGxCkjgIF141CVn
	q+d3ary0uXW03uKtEr99wbAfplyKaaAQZwkNNjWvVVmALX19huHA8tKrqhe5EVd03DqW8G
	MQMUyC2UmShvBTd6qHp0alq8oQ3YwKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=lJkMiqkx2bbwFf0k/qAHaIHynMCMqEg1gTZIpgbDeDXuSNoOIbfWyq5jX5FCxLWDcArrq6
	FkoJdJTYoZv5W+Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0092913A0E;
	Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4pJKOrT1yWXxCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 4/5] nvme/rc: do not issue errors when disconnecting when using fc transport
Date: Mon, 12 Feb 2024 11:40:45 +0100
Message-ID: <20240212104046.13127-5-dwagner@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.55
X-Spamd-Result: default: False [3.55 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.81%]
X-Spam-Flag: NO

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroyed while the tests
are running.

The cleanup code expects that all devices are under blktests control,
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


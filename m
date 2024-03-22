Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD145BED
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115427; cv=none; b=twhYK7h1N5oURX3ho+zPoqjeIi85hBC5ly0Xm4/ymL+ILBZ5LsfPiKqz4whikKeLcAL6BVgx6q0u/UGEwy2qd+bux6mwjVNa1B5sabcTM7V1MiaGCGsyv7JWueGESeQ9Sn4KcJjYiRGg9jgQDAvSaGD1UQpPDmjp1aI33RLtgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115427; c=relaxed/simple;
	bh=5KiipQ64s/I5PBbKNSKuLWLNW4oveJRJ3hohF8wMQzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI2wU1TusCCiWahUi959OmaWQF6ViSY0EtxSAiXr41vDty70eZ71ZIRdeEsaggTbVcnuTr46HTOGSE511h+HJQb9MdPTlW9DTcFzuVRGm7cuiqt/f+wW2oGJhkumMxNhMV/0ItI8BpVSqANTJoxilYDDqhRArWWyqLSQHyIDTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jVs2g5/A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CLDTc1QI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jVs2g5/A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CLDTc1QI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jVs2g5/A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CLDTc1QI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jVs2g5/A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CLDTc1QI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19D2538568;
	Fri, 22 Mar 2024 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=jVs2g5/Az+QkzcaRPXyirH6Czfh4lvQwtchsxnMJndsPgHijwxmQ6iLQy2M2aRaDQKuBf5
	F9/UQEVd0Q/8PAkoLEiNbMw5dZQKyDHKDrOgUz3BkiJOec2INlemNmy0gPn6ZjAkcnyVqd
	yVlPgMmKmazH/ihlU0UL05P3YoLutI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=CLDTc1QIC0nZHGp3F9Ie2JUxbbGdhxAYKgrOX/cFyEbrc/5Rs3XXARiLwUw0+7KML3J/TI
	bgaJ2pTcGJUEPGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=jVs2g5/Az+QkzcaRPXyirH6Czfh4lvQwtchsxnMJndsPgHijwxmQ6iLQy2M2aRaDQKuBf5
	F9/UQEVd0Q/8PAkoLEiNbMw5dZQKyDHKDrOgUz3BkiJOec2INlemNmy0gPn6ZjAkcnyVqd
	yVlPgMmKmazH/ihlU0UL05P3YoLutI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=CLDTc1QIC0nZHGp3F9Ie2JUxbbGdhxAYKgrOX/cFyEbrc/5Rs3XXARiLwUw0+7KML3J/TI
	bgaJ2pTcGJUEPGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 086EE136AD;
	Fri, 22 Mar 2024 13:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FpbuAKCM/WWLJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 08/18] nvme/rc: connect subsys only support long options
Date: Fri, 22 Mar 2024 14:50:05 +0100
Message-ID: <20240322135015.14712-9-dwagner@suse.de>
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
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

There is no user for the short command line options, thus
remove the short options to reduce the parsing overhead.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6bf2e3ae37c5..535bd869bf58 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,55 +428,55 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
-			-a|--traddr)
+			--traddr)
 				traddr="$2"
 				shift 2
 				;;
-			-w|--host-traddr)
+			--host-traddr)
 				host_traddr="$2"
 				shift 2
 				;;
-			-s|--trsvcid)
+			--trsvcid)
 				trsvcid="$2"
 				shift 2
 				;;
-			-n|--hostnqn)
+			--hostnqn)
 				hostnqn="$2"
 				shift 2
 				;;
-			-I|--hostid)
+			--hostid)
 				hostid="$2"
 				shift 2
 				;;
-			-S|--dhchap-secret)
+			--dhchap-secret)
 				hostkey="$2"
 				shift 2
 				;;
-			-C|--dhchap-ctrl-secret)
+			--dhchap-ctrl-secret)
 				ctrlkey="$2"
 				shift 2
 				;;
-			-i|--nr-io-queues)
+			--nr-io-queues)
 				nr_io_queues="$2"
 				shift 2
 				;;
-			-W|--nr-write-queues)
+			--nr-write-queues)
 				nr_write_queues="$2"
 				shift 2
 				;;
-			-P|--nr-poll-queues)
+			--nr-poll-queues)
 				nr_poll_queues="$2"
 				shift 2
 				;;
-			-k|--keep-alive-tmo)
+			--keep-alive-tmo)
 				keep_alive_tmo="$2"
 				shift 2
 				;;
-			-c|--reconnect-delay)
+			--reconnect-delay)
 				reconnect_delay="$2"
 				shift 2
 				;;
-			-l|--ctrl-loss-tmo)
+			--ctrl-loss-tmo)
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
-- 
2.44.0


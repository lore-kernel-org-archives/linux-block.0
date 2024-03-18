Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489E2C694
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754750; cv=none; b=L85pXNR5Cr66FkqL9BY1+nNawwqLdbSUy3F1hkyZlthefuEQ7UX/5CqSacqS6lCwvrJJhiXkoCxYKXzF/8iD+3rwnsUDeVo3CcnVurdVLkgnF+92xObt+bMm01nhldgf80qt3OydmHbwsDEWi0ZnfnA2ol3K7/4Vh0FIIRmbJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754750; c=relaxed/simple;
	bh=AdQhlXtycaex1GnAKMFbJe/VA7Epry+rTX60hL5kemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlJzDkibVi5SJYRK9J0RjwI6YjZZrJGkhnDIgbXoaIk7q3v2I3cJBl5ZxNNyL/5Ly1dXIwhchAloYZExaavQnIiRrifcpBtI55qGDWLEb74Urc/fU1i1I4cbSC87h4p6cARScP7ToJ2YpV+/IDvb+XiUUqR5mXwzc6Tf/FbuDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xiYgOH4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0j2RX4bF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xiYgOH4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0j2RX4bF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xiYgOH4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0j2RX4bF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xiYgOH4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0j2RX4bF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB223487F;
	Mon, 18 Mar 2024 09:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI4Fbsyv4s/TL+dwOLd6KnCcwke45wlOjVFHWgJ2F8=;
	b=xiYgOH4mGYA9F9KrHQOvkcwgYSlJQNYlb2dT85ljR74d77MJkGlYr1zsOIs9AnKO4h4fhl
	us4KbCVk7cfpvGT4LiwtuQ0V+nGduhlas+KxOioSBeg4awQO7gisNBKsw1U+BYn1TKoviJ
	EyGPSy4jmHwwiub1dANswdfAhGBZ26s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI4Fbsyv4s/TL+dwOLd6KnCcwke45wlOjVFHWgJ2F8=;
	b=0j2RX4bFMuB4nJnnfLzyDeAdp11bWBUkoXpstEoHxqvRL2E7ofBshKQQQtZDTAxAZkGxvC
	VPFweqmB4y0CjUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI4Fbsyv4s/TL+dwOLd6KnCcwke45wlOjVFHWgJ2F8=;
	b=xiYgOH4mGYA9F9KrHQOvkcwgYSlJQNYlb2dT85ljR74d77MJkGlYr1zsOIs9AnKO4h4fhl
	us4KbCVk7cfpvGT4LiwtuQ0V+nGduhlas+KxOioSBeg4awQO7gisNBKsw1U+BYn1TKoviJ
	EyGPSy4jmHwwiub1dANswdfAhGBZ26s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI4Fbsyv4s/TL+dwOLd6KnCcwke45wlOjVFHWgJ2F8=;
	b=0j2RX4bFMuB4nJnnfLzyDeAdp11bWBUkoXpstEoHxqvRL2E7ofBshKQQQtZDTAxAZkGxvC
	VPFweqmB4y0CjUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D6211349D;
	Mon, 18 Mar 2024 09:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5wtHbsL+GW4UAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:07 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 05/10] nvme/rc: connect subsys only support long options
Date: Mon, 18 Mar 2024 10:38:50 +0100
Message-ID: <20240318093856.22307-6-dwagner@suse.de>
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
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.977];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.89%]
X-Spam-Flag: NO

There is no user for the short command line options, thus
remove the short options to reduce the parsing overhead.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c8f13819ca21..c23f6fe09b6a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -440,55 +440,55 @@ _nvme_connect_subsys() {
 
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


Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB056B6B
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014463; cv=none; b=LG+dvHLAn11exbUc01d6s7zWGeKvvlPjMYZdabiK48nFG0VGtqsEND414ybBXygbf328IHzNJhofTnqx76v/+jwQT8iUmrQlfvwePmTGErzhX1uJFkOC5t/j7qWxrgTm9iqaeBL5R0S2dwgNQIWo9xP9qZ0XzcycfvvF8W/XeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014463; c=relaxed/simple;
	bh=I2S6/4FYIgi2d6pEO4PnYWc9n7IYvya6tYWqeq+ZEqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBEhzGaY2BkRSNVTk0JDdKGSWMVzvYMLqHmygs6kuoSC0hPKjO+OB1i5WCCM8YrSTbfNBqk8XV31jIsTcxWopyJS9hCWZK2nfrn5kLGthwI7jX09VDx5BNZHm+H66ztA/Jd3mPq8aHqwcNuxZx3ubeLibj5cYju6gJcrHlITUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eMHAi94f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYO180vi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eMHAi94f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYO180vi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eMHAi94f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYO180vi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eMHAi94f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYO180vi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 592C13715B;
	Thu, 21 Mar 2024 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/kqbhd0zcVIUz21Ia4QDLT6jzWbUrNtvXJHBzIZ/bc=;
	b=eMHAi94fGikLZXI9KzyQpGsTK4pBKr+jJ1gNMyc4UrNrBNLNo6UeVIkSxI7vdVJ7wyQuP2
	oI6AHj6Kl4gcjQqSLrcKAwlvAYa5mqeD2iwhbXWTrbhqnKERyidNEPHmmSTytGj1AYN2FM
	kWT2idWHxhApgGjlMVi3VCxwyHVmGfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/kqbhd0zcVIUz21Ia4QDLT6jzWbUrNtvXJHBzIZ/bc=;
	b=vYO180viMBM+TYiCWryVUmJ03DezmSduw7wVLAn4mSNx0yOcAg5gJ+1XcwtIdyymSh/KDC
	cIT9QrB4YF+a8LAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/kqbhd0zcVIUz21Ia4QDLT6jzWbUrNtvXJHBzIZ/bc=;
	b=eMHAi94fGikLZXI9KzyQpGsTK4pBKr+jJ1gNMyc4UrNrBNLNo6UeVIkSxI7vdVJ7wyQuP2
	oI6AHj6Kl4gcjQqSLrcKAwlvAYa5mqeD2iwhbXWTrbhqnKERyidNEPHmmSTytGj1AYN2FM
	kWT2idWHxhApgGjlMVi3VCxwyHVmGfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/kqbhd0zcVIUz21Ia4QDLT6jzWbUrNtvXJHBzIZ/bc=;
	b=vYO180viMBM+TYiCWryVUmJ03DezmSduw7wVLAn4mSNx0yOcAg5gJ+1XcwtIdyymSh/KDC
	cIT9QrB4YF+a8LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C63D13976;
	Thu, 21 Mar 2024 09:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xUZUDTcC/GXIDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 08/18] nvme/rc: connect subsys only support long options
Date: Thu, 21 Mar 2024 10:47:17 +0100
Message-ID: <20240321094727.6503-9-dwagner@suse.de>
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
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.64%]
X-Spam-Level: ***
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
index f8bbad873a5f..1cd4833bae7d 100644
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


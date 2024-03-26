Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394474BEF
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458854; cv=none; b=cz+2xqjYMGyCqcYjfqfmsGaaqbY7PBf8x85ibzTak6s4LBWYR5L1ptJU0WZHvEiKf3eljhTDtWtEGS7mFJfuCWE3T/57y9l1B1Zu+qxV1+vG1V5Aqdqg6eCm1hFKYhYZno5idQbedwj0J6aVx5QqTkiKH5L3ZN7QQA9mitV4LL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458854; c=relaxed/simple;
	bh=5KiipQ64s/I5PBbKNSKuLWLNW4oveJRJ3hohF8wMQzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXr6PAkto+l5rM9K4/09BQIeJCq2QJtBot+kwT7wfVPudUClV1OCKnHVuc4w79RiMVTJ6WazP69BkShuDdTfJM5MClM9cCgyitd6C9ganhJaoDDNsKZf2HTASDTfPmIlG4rXIbo1H5NUinnXaaEKgc479pjXJVIIMfswUxwwXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tGzPAElW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmfnFJEC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tGzPAElW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmfnFJEC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tGzPAElW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmfnFJEC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tGzPAElW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmfnFJEC"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A03E65D65B;
	Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=tGzPAElWRME7fltT1u2z++CApOPF0DF+YxVqrojlLCdUjTx7onso9vPdEOHGv7+GBy7Yv/
	5DlsqFr0gmHmx4BLreEob7aGCbAn3VTEnXPBSSj1DoqJlUT1zYSctD5//mQMeb6g43/rag
	PQPaR+iGLWj444wt08q+mfhEJTF4q9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=QmfnFJECWfQucLkRQRHl02zrM3xXJPtr5VDBTJNfxZc7W1xcYL6MBr/9oa8IV64bUD6mj8
	YhFwtdw5tVWvN3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=tGzPAElWRME7fltT1u2z++CApOPF0DF+YxVqrojlLCdUjTx7onso9vPdEOHGv7+GBy7Yv/
	5DlsqFr0gmHmx4BLreEob7aGCbAn3VTEnXPBSSj1DoqJlUT1zYSctD5//mQMeb6g43/rag
	PQPaR+iGLWj444wt08q+mfhEJTF4q9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=QmfnFJECWfQucLkRQRHl02zrM3xXJPtr5VDBTJNfxZc7W1xcYL6MBr/9oa8IV64bUD6mj8
	YhFwtdw5tVWvN3Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC4013587;
	Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pbcWISLKAmYONwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 08/20] nvme/rc: connect subsys only support long options
Date: Tue, 26 Mar 2024 14:13:50 +0100
Message-ID: <20240326131402.5092-9-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tGzPAElW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QmfnFJEC
X-Rspamd-Queue-Id: A03E65D65B

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


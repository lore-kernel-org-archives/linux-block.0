Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE02F28EF
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994867; cv=none; b=kiEwNysaOB5dtD+V0uw/0EofTc0hdz+vs5RHw5JOIplWmptIr8qSlZR5seK4XNFcC8jA+m0TKOSbqRQtSsVCwzxlGBi20Vuzmx8wLwM5HgbGhlUs4HJtL4/RrREi0H4M4qzvLK1NZIbVt0OTqh2eO66NXY97xvOnEqqn/PrSD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994867; c=relaxed/simple;
	bh=B4lPUGEYjpm2SdaQ+jA1UbIw10I88xxZxR0qkWF4Zmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvTgOqIFhcuu6UvonPTieRYblYQ2XoJQoMuKVqdPTCyiY9U9ruGJyZ0ZrlSp8+aoiLXnp5UxqwmOjBirzuYhSBxjXKbCR+gXnBRC6cWjoNlH0MPK8RD/2mYyNSHc2cgWaGbfjCk6lBK8SiuSdvqvkILBJNvNd+ch4HKfosUJo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vAPf79tD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=naRtddYQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLrqkagr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1U+Po9Pu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vAPf79tD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="naRtddYQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLrqkagr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1U+Po9Pu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 075CD3368B;
	Wed, 21 Jan 2026 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768994864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0HQOO1Ui1MzjGdYk8Ez4fIlrbo8rhrSedMz/5tpkD5Q=;
	b=vAPf79tDJD/Qb5OOgf5xsvDbhraGuX10FbU4cJKnBkpBlnSdJ0KuxiAGO8/cnq1EKD8rw2
	eL8Ukjr7QWsi/C7Ep7Nc7XUsqhi+PIU9HJdVI+1Ba41sGkmk0AB/KQB8l4yPyEY2syUZZh
	8cVkd/hP4TcBoetJj9plItSVejaMDmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768994864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0HQOO1Ui1MzjGdYk8Ez4fIlrbo8rhrSedMz/5tpkD5Q=;
	b=naRtddYQ/8Kb/x80ic7gOBKII61hsHNmNZQCW/FnPTYbWK7/v3U22+yrZe1CEeLp+ouT0O
	7j+uHPQOvcrSO9Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wLrqkagr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1U+Po9Pu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768994863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0HQOO1Ui1MzjGdYk8Ez4fIlrbo8rhrSedMz/5tpkD5Q=;
	b=wLrqkagrV+dXVDXTJEpu/T4ceYRZXykBEcuPIm62jXXpiLxbrzkdLhhbJeX6BISZWZ56bY
	xIJ/ICPDpgsv/kvm4NtepqWEGv51GcKO5Re1Yktxvh15rqjCjBLCmCpAf3kS2odvCa0UcA
	ZBKDfQSTcRnD4AnK2CaWBJR/StnWZIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768994863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0HQOO1Ui1MzjGdYk8Ez4fIlrbo8rhrSedMz/5tpkD5Q=;
	b=1U+Po9PuGNYGx7yE7ptgvHe+OwkshyIwmCZg6XwEL804EyKLxxPsvzjyd9y6LK1Miv44TH
	vmnvT27slpvjPXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C60CA3EA63;
	Wed, 21 Jan 2026 11:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y9FTMC64cGlANQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 11:27:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D50DA09E9; Wed, 21 Jan 2026 12:27:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bernd@bsbernd.com,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	<linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2] flex_proportions: Make fprop_new_period() hardirq safe
Date: Wed, 21 Jan 2026 12:27:30 +0100
Message-ID: <20260121112729.24463-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344; i=jack@suse.cz; h=from:subject; bh=B4lPUGEYjpm2SdaQ+jA1UbIw10I88xxZxR0qkWF4Zmo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpcLghZHz/mPEpvXafP6EvFPDeo1VP5Yqf+dp5f 2Wxp3+dA9mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaXC4IQAKCRCcnaoHP2RA 2SC2B/4/ISO+pbAGxc05NOqVRTTU3B+Q5TeQ5IscQRnlXg1ndRkNRN6/k1PQMC6qggs4MggY0cr vWhBoje8CFiMQ9hgsst06EQfSU1mzBXo2f1kJYWqM1dztGWKm5aK2Q2Cub17t1qe3ZVVMpul+y4 uy5N7QjYy31D5jcdT0XWKIQ8AN6NNeCqILugQIE1i2r1rCSa4eLYiC/1VYeUotA8YXPO3ntIeKd tB8wI+Xye6Ejvar+cUKKHTtDzBgXRnpqSI0hOAZY0PNE40yoGGfm0fHo0i1mFM1j04YgJAnqiBl uLwRmggXS9HUjbyCy6TBkXwrld3S/rWokPIekC5shkhWSLhP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bsbernd.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,szeredi.hu,vger.kernel.org,suse.cz];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 075CD3368B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Bernd has reported a lockdep splat from flexible proportions code that
is essentially complaining about the following race:

<timer fires>
run_timer_softirq - we are in softirq context
  call_timer_fn
    writeout_period
      fprop_new_period
        write_seqcount_begin(&p->sequence);

        <hardirq is raised>
        ...
        blk_mq_end_request()
	  blk_update_request()
	    ext4_end_bio()
	      folio_end_writeback()
		__wb_writeout_add()
		  __fprop_add_percpu_max()
		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
		      fprop_fraction_percpu()
			seq = read_seqcount_begin(&p->sequence);
			  - sees odd sequence so loops indefinitely

Note that a deadlock like this is only possible if the bdi has
configured maximum fraction of writeout throughput which is very rare
in general but frequent for example for FUSE bdis. To fix this problem
we have to make sure write section of the sequence counter is irqsafe.

CC: stable@vger.kernel.org
Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")
Reported-by: Bernd Schubert <bernd@bsbernd.com>
Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/flex_proportions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Sending v2 because I've messed up Andrew's address and forgot some tags in
the first posting...

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 84ecccddc771..012d5614efb9 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -64,13 +64,14 @@ void fprop_global_destroy(struct fprop_global *p)
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
 	s64 events = percpu_counter_sum(&p->events);
+	unsigned long flags;
 
 	/*
 	 * Don't do anything if there are no events.
 	 */
 	if (events <= 1)
 		return false;
-	preempt_disable_nested();
+	local_irq_save(flags);
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -78,7 +79,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
-	preempt_enable_nested();
+	local_irq_restore(flags);
 
 	return true;
 }
-- 
2.51.0


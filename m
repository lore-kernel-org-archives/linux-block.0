Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8F612FA;
	Tue, 23 Jan 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032718; cv=none; b=XHIsJjF+eIlnkv2Cer7tVxTCTnwLsIllVYOPPiPT0Ec5iMVl/5CO2qH0Bhs3AMt5+1v7kGlZ/L8Q4IC5M1sbdSF5T3waHjeOwjIySMs5O4b9EiOfw3FNCvRWANf+1JDfWyn9abpbh2DacVz6TEUmUV+9rCyqwnblSIBlhN2TNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032718; c=relaxed/simple;
	bh=jpLoGydIB3tav2QE6M4GnD7Apq48ELE0E5GJMLGOCc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ItIdc91/HpbXzEpfq/MKfrsLLuEDgcDQQrwDHHQEQK50nMhkhXmJVNtGwELEv4JhofwaQ0182W39NneNLKqvDuJgF4G3nO69UMoJpyNJgqK0HlnCQU/5Z6kRDkw71zhk9HtDFtrT2cbQxUohukXlVC3VxMaPposKpiSSR2B+1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxMlGxDI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Er6rgKv4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxMlGxDI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Er6rgKv4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxMlGxDI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Er6rgKv4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxMlGxDI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Er6rgKv4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF1B12229B;
	Tue, 23 Jan 2024 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZjAYddRoJjm/AdsSm5U0TY8TiC0zrK+IKe/4Cv1WMIs=;
	b=HxMlGxDIe85OL5RU7U57wA3ufP5HCB5C8uID6j5eTJYEgdxaUXueZmjy3r6OmkFsa9ZQNI
	VhNrSPwX+M/2IrNMH7tGgZtqKts663nkKC74Jp4MhB1MViigNDRnqBQ3dGddzgSPpeC4e7
	50cyeEcqpzlgeYfPbNwFPNmxtzWbFgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZjAYddRoJjm/AdsSm5U0TY8TiC0zrK+IKe/4Cv1WMIs=;
	b=Er6rgKv4P5qf2ERWCvjWR2fVGKXV6CVbKENrYNfH7jA9cbfHQxQZ+tgkG7tVs4V5A3ccsS
	6E0zhiKpelNYBSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZjAYddRoJjm/AdsSm5U0TY8TiC0zrK+IKe/4Cv1WMIs=;
	b=HxMlGxDIe85OL5RU7U57wA3ufP5HCB5C8uID6j5eTJYEgdxaUXueZmjy3r6OmkFsa9ZQNI
	VhNrSPwX+M/2IrNMH7tGgZtqKts663nkKC74Jp4MhB1MViigNDRnqBQ3dGddzgSPpeC4e7
	50cyeEcqpzlgeYfPbNwFPNmxtzWbFgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZjAYddRoJjm/AdsSm5U0TY8TiC0zrK+IKe/4Cv1WMIs=;
	b=Er6rgKv4P5qf2ERWCvjWR2fVGKXV6CVbKENrYNfH7jA9cbfHQxQZ+tgkG7tVs4V5A3ccsS
	6E0zhiKpelNYBSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE24B136A4;
	Tue, 23 Jan 2024 17:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3vULMkr+r2UVKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 17:58:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52A38A0803; Tue, 23 Jan 2024 18:58:34 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] blk-wbt: Fix detection of dirty-throttled tasks
Date: Tue, 23 Jan 2024 18:58:26 +0100
Message-Id: <20240123175826.21452-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3970; i=jack@suse.cz; h=from:subject; bh=jpLoGydIB3tav2QE6M4GnD7Apq48ELE0E5GJMLGOCc4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr/4IlwLEdVGJQTlCFa9sj6UVm5KCFerHaP+6XiHI OXTGhjyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/+CAAKCRCcnaoHP2RA2Um7B/ 499x13YeG9oMijMrENiH8eWvlaAW6r15qa5/mQFniTSKNcvtqkzcaZ8ES78IJYbbbn3fdCd7R9UF4M UTKtn1/zarUpM3ac9sdtZ1MSAZRp4B1bBc8eQZ5IDhmai2KcfadVU0ycF8gCsc0KJkf1f0dEMloiW7 I1JLuWrRxvbS9EzOeONPJILgj9IZGDAyE7DDUW9ZDTtWIio2QasgL4PmGI3YZtUhvx2uLLpSV/+kSX VCaATee4g+oG692AxBchc/koFia1pBFlfSg4J9QBBiKV9NrHVBA1dU5+qPCfUZrl1JH49waDDtvQSl JrDWIkqh/K3N2/Q5tnElQFu2iofJi9
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The detection of dirty-throttled tasks in blk-wbt has been subtly broken
since its beginning in 2016. Namely if we are doing cgroup writeback and
the throttled task is not in the root cgroup, balance_dirty_pages() will
set dirty_sleep for the non-root bdi_writeback structure. However
blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
structure. Thus detection of recently throttled tasks is not working in
this case (we noticed this when we switched to cgroup v2 and suddently
writeback was slow).

Since blk-wbt has no easy way to get to proper bdi_writeback and
furthermore its intention has always been to work on the whole device
rather than on individual cgroups, just move the dirty_sleep timestamp
from bdi_writeback to backing_dev_info. That fixes the checking for
recently throttled task and saves memory for everybody as a bonus.

CC: stable@vger.kernel.org
Fixes: b57d74aff9ab ("writeback: track if we're sleeping on progress in balance_dirty_pages()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-wbt.c                  | 4 ++--
 include/linux/backing-dev-defs.h | 7 +++++--
 mm/backing-dev.c                 | 2 +-
 mm/page-writeback.c              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5ba3cd574eac..0c0e270a8265 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -163,9 +163,9 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 
-	return time_before(jiffies, wb->dirty_sleep + HZ);
+	return time_before(jiffies, bdi->last_bdp_sleep + HZ);
 }
 
 static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ae12696ec492..ad17739a2e72 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -141,8 +141,6 @@ struct bdi_writeback {
 	struct delayed_work dwork;	/* work item used for writeback */
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
-	unsigned long dirty_sleep;	/* last wait */
-
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -179,6 +177,11 @@ struct backing_dev_info {
 	 * any dirty wbs, which is depended upon by bdi_has_dirty().
 	 */
 	atomic_long_t tot_write_bandwidth;
+	/*
+	 * Jiffies when last process was dirty throttled on this bdi. Used by
+ 	 * blk-wbt.
+	*/
+	unsigned long last_bdp_sleep;
 
 	struct bdi_writeback wb;  /* the root writeback info for this bdi */
 	struct list_head wb_list; /* list of all wbs */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1e3447bccdb1..e039d05304dd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -436,7 +436,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
-	wb->dirty_sleep = jiffies;
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
@@ -921,6 +920,7 @@ int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
+	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40..cc37fa7f3364 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1921,7 +1921,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			break;
 		}
 		__set_current_state(TASK_KILLABLE);
-		wb->dirty_sleep = now;
+		bdi->last_bdp_sleep = jiffies;
 		io_schedule_timeout(pause);
 
 		current->dirty_paused_when = now + pause;
-- 
2.35.3


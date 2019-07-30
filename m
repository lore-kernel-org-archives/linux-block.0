Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25630C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E920C01
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfG3SSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfG3SSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 14:18:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so30478879pgl.11
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 11:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFp9+o4E7VKCVhlwOxMGCQuuRQqPt+GbjAIC7nxwu+8=;
        b=NGSvMitL0iAInqLmoijEtAdoPcNAFW06yNzZH8Q4QsCYvHK5xc+kG0y+vZ2Is29WUt
         abzit3cXNIjH61jUxIDlumW8lbjzD84aMy095B3G91gO7KOshisx5+vnf4hH2f7D6ha1
         bB+E/pBSTjtIl+evX9kMuXUeRCSKj9ESN4RKHD5o3IvPS59KpRTXMCwy/AuEGMAK5udJ
         oG2HqAnhaZuHiDjqZ/inzEG5XeIkIADfJuwltw9abEtQjlPTQU5dfqAkWyKt71FiGbib
         JUioj0op70xmyvmTZbqut3XOG2isHIz2Ie23TJPGJuHTacgitkoZjRXl1F2HlZuH1pX5
         he/Q==
X-Gm-Message-State: APjAAAUaeaDy+31MSqMbpX2f/2v+vGs3YPOraQzwaTpF3TsqmrNPvv8n
        5Edivgov/bHeH8j/cFTSatg=
X-Google-Smtp-Source: APXvYqwHE1c+Ytj3cnmgoskQoyh6tpJ92pebY0Uz7xwSyE1dSwrsByKbZ1W7cQvNIOm/H3GEhQHmBw==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr42345864pfb.210.1564510687406;
        Tue, 30 Jul 2019 11:18:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 32sm12165895pgt.43.2019.07.30.11.18.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:18:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com
Subject: [PATCH 2/2] block: Fix a race condition in submit_bio()
Date:   Tue, 30 Jul 2019 11:17:57 -0700
Message-Id: <20190730181757.248832-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181757.248832-1-bvanassche@acm.org>
References: <20190730181757.248832-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

generic_make_request_checks() needs to be protected by a
blk_queue_enter() / blk_queue_exit() pair because it calls
blkcg_bio_issue_check() and because that last function calls
blkg_lookup().

This patch fixes https://syzkaller.appspot.com/bug?id=ff9ab4a23afa7553fb79f745a92be87ba4144508.

This patch also fixes the following kernel warning, triggered by
blktests:

WARNING: CPU: 5 PID: 10706 at block/blk-core.c:903 generic_make_request_checks+0x9c6/0xe60
RIP: 0010:generic_make_request_checks+0x9c6/0xe60
Call Trace:
 generic_make_request+0x7a/0x5c0
 submit_bio+0x92/0x280
 mpage_readpages+0x2b1/0x300
 blkdev_readpages+0x1d/0x20
 read_pages+0xd9/0x2c0
 __do_page_cache_readahead+0x2e0/0x310
 force_page_cache_readahead+0xfb/0x170
 page_cache_sync_readahead+0x28d/0x2a0
 generic_file_read_iter+0xc13/0x1530
 blkdev_read_iter+0x7d/0x90
 new_sync_read+0x2c5/0x3d0
 __vfs_read+0x7b/0x90
 vfs_read+0xc6/0x1f0
 ksys_read+0xc3/0x160
 __x64_sys_read+0x43/0x50
 do_syscall_64+0x71/0x270
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ff27c3080348..cd844c54e9f1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1150,6 +1150,9 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	struct request_queue *q = bio->bi_disk->queue;
+	blk_qc_t ret;
+
 	if (blkcg_punt_bio_submit(bio))
 		return BLK_QC_T_NONE;
 
@@ -1182,7 +1185,15 @@ blk_qc_t submit_bio(struct bio *bio)
 		}
 	}
 
-	return generic_make_request(bio);
+	if (unlikely(blk_queue_enter(q, 0) < 0)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_end_io(bio);
+		return BLK_QC_T_NONE;
+	}
+	ret = generic_make_request(bio);
+	blk_queue_exit(q);
+
+	return ret;
 }
 EXPORT_SYMBOL(submit_bio);
 
-- 
2.22.0.709.g102302147b-goog


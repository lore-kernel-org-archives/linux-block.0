Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C8CC0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68632064A
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfG3ShE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:37:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40806 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfG3ShE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 14:37:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so29180263pla.7
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 11:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8PYXK4K9FmQm/Qr0PK2yNVvdfScvC1ohjK9lKgPxuIw=;
        b=TRADkoXvwWE0aB5whTHx6Gurxa0d2dghPlcjvtIZAKanIm/pVdCYid0xuYoCrqWqgv
         PqW7FJEPceBZNMvJB2Ht2LrBtEKhc6hsqfk2TZtN3jHUOlo5Mwqhz5mSrmq9vIdLyHXc
         53QiyVCcj2C/ghFlXGTJOlN0EwKhc5gurvS1VobglckxqZHEq0k7/waFwFtdROl4KCKi
         Lni3+1EjSKbk7pHEtdKSED08bythw9imxiKK2XgloDPxsGFqOgjiMAoEJrs56RPviHtg
         2uoewVm8TeeQry5hQG/jx0ow6f7Q5vuJilBBSEF7csR7HTtJ9h3QJRLeX7p6qtyIl/Wu
         zfig==
X-Gm-Message-State: APjAAAWNnuUCaJZdnXfNn1g7eGpkKBOdEaPkL8YYTBrMuvvOO4WHmUp/
        vWH/1dSgRKNoWx+jFVM8h4g=
X-Google-Smtp-Source: APXvYqxrHZpsrtW7oGDkOtFdpf5q8hRYW7uF7idrsTfAOBt+SLGcOelmzLFOxUpXyYiU+LuiVy+uEA==
X-Received: by 2002:a17:902:4201:: with SMTP id g1mr208520pld.300.1564511823433;
        Tue, 30 Jul 2019 11:37:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a128sm73759777pfb.185.2019.07.30.11.37.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:37:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] block: Fix a race condition in submit_bio()
Date:   Tue, 30 Jul 2019 11:36:53 -0700
Message-Id: <20190730183653.253579-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730183653.253579-1-bvanassche@acm.org>
References: <20190730183653.253579-1-bvanassche@acm.org>
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
Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
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


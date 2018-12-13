Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6836C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39002087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39002087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeLMOzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:51484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbeLMOzW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E72FFAD5C;
        Thu, 13 Dec 2018 14:55:20 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 05/12] bcache: do not mark writeback_running until backing dev attached to cache_set
Date:   Thu, 13 Dec 2018 22:53:50 +0800
Message-Id: <20181213145357.38528-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

A fresh backing device is not attached to any cache_set, and
has no writeback kthread created until first attached to some
cache_set.

But bch_cached_dev_writeback_init run
"
	dc->writeback_running		= true;
	WARN_ON(test_and_clear_bit(BCACHE_DEV_WB_RUNNING,
			&dc->disk.flags));
"
for any newly formatted backing devices.

For a fresh standalone backing device, we can get something like
following even if no writeback kthread created:
------------------------
/sys/block/bcache0/bcache# cat writeback_running
1
/sys/block/bcache0/bcache# cat writeback_rate_debug
rate:		512.0k/sec
dirty:		0.0k
target:		0.0k
proportional:	0.0k
integral:	0.0k
change:		0.0k/sec
next io:	-15427384ms

The none ZERO fields are misleading as no alive writeback kthread yet.

Set dc->writeback_running false as no writeback thread created in
bch_cached_dev_writeback_init().

We have writeback thread created and woken up in bch_cached_dev_writeback
_start(). Set dc->writeback_running true before bch_writeback_queue()
called, as a writeback thread will check if dc->writeback_running is true
before writing back dirty data, and hung if false detected.

After the change, we can get the following output for a fresh standalone
backing device:
-----------------------
/sys/block/bcache0/bcache$ cat writeback_running
0
/sys/block/bcache0/bcache# cat writeback_rate_debug
rate:		0.0k/sec
dirty:		0.0k
target:		0.0k
proportional:	0.0k
integral:	0.0k
change:		0.0k/sec
next io:	0ms

v1 -> v2:
  Set dc->writeback_running before bch_writeback_queue() called,

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 08c3a9f9676c..1696b212ec4e 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -777,7 +777,7 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 	bch_keybuf_init(&dc->writeback_keys);
 
 	dc->writeback_metadata		= true;
-	dc->writeback_running		= true;
+	dc->writeback_running		= false;
 	dc->writeback_percent		= 10;
 	dc->writeback_delay		= 30;
 	atomic_long_set(&dc->writeback_rate.rate, 1024);
@@ -805,6 +805,7 @@ int bch_cached_dev_writeback_start(struct cached_dev *dc)
 		cached_dev_put(dc);
 		return PTR_ERR(dc->writeback_thread);
 	}
+	dc->writeback_running = true;
 
 	WARN_ON(test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags));
 	schedule_delayed_work(&dc->writeback_rate_update,
-- 
2.16.4


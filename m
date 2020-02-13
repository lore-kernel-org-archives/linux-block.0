Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8CC2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 07:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E822173E
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgBMHkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:40:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:41064 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbgBMHj4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 02:39:56 -0500
Received: from [192.168.15.156] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j295u-0001Tm-IL; Thu, 13 Feb 2020 10:39:30 +0300
Subject: [PATCH v7 5/6] block: Add blk_queue_max_allocate_sectors()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        darrick.wong@oracle.com
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 13 Feb 2020 10:39:30 +0300
Message-ID: <158157957022.111879.2458344432302909777.stgit@localhost.localdomain>
In-Reply-To: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a new helper to assign max_allocate_sectors
limit of block device queue.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-settings.c   |   13 +++++++++++++
 include/linux/blkdev.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8d5df9d37239..24cf8fbbd125 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -259,6 +259,19 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_allocate_sectors - set max sectors for a single
+ *                                  allocate request
+ * @q:  the request queue for the device
+ * @max_allocate_sectors: maximum number of sectors to write per command
+ **/
+void blk_queue_max_allocate_sectors(struct request_queue *q,
+		unsigned int max_allocate_sectors)
+{
+	q->limits.max_allocate_sectors = max_allocate_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_allocate_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 40707f980a2e..f5edbfea7b84 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1088,6 +1088,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_allocate_sectors(struct request_queue *q,
+		unsigned int max_allocate_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,



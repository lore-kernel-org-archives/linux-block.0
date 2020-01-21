Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FDC2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 10:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D7B24656
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 10:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgAUKmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:42:53 -0500
Received: from relay.sw.ru ([185.231.240.75]:57354 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgAUKmx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 05:42:53 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itqzf-0006QF-AK; Tue, 21 Jan 2020 13:42:47 +0300
Subject: [PATCH v4 5/7] block: Add blk_queue_max_allocate_sectors()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com, ktkhai@virtuozzo.com
Date:   Tue, 21 Jan 2020 13:42:47 +0300
Message-ID: <157960336718.108120.10388241536544475227.stgit@localhost.localdomain>
In-Reply-To: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
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
---
 block/blk-settings.c   |   13 +++++++++++++
 include/linux/blkdev.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 81468cd454a6..8d2fcbd693f9 100644
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
index 20c94a7f9411..249dce6dd436 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1089,6 +1089,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_allocate_sectors(struct request_queue *q,
+		unsigned int max_allocate_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,



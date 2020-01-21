Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C12C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98E424673
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgAUKm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:42:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:57398 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgAUKm7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 05:42:59 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itqzl-0006Qk-6Q; Tue, 21 Jan 2020 13:42:53 +0300
Subject: [PATCH v4 6/7] dm: Directly disable max_allocate_sectors for now
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
Date:   Tue, 21 Jan 2020 13:42:52 +0300
Message-ID: <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
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

Since dm inherits limits from underlining block devices,
this patch directly disables max_allocate_sectors for dm
till full allocation support is implemented.

This prevents high-level primitives (generic_make_request_checks(),
__blkdev_issue_write_zeroes(), ...) from sending REQ_ALLOCATE
requests.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/md/dm-table.c |    2 ++
 drivers/md/md.h       |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0a2cc197f62b..e245c0d882aa 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -489,6 +489,7 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 		       (unsigned long long) start << SECTOR_SHIFT);
 
 	limits->zoned = blk_queue_zoned_model(q);
+	blk_queue_max_allocate_sectors(q, 0);
 
 	return 0;
 }
@@ -1548,6 +1549,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
 			       dm_device_name(table->md),
 			       (unsigned long long) ti->begin,
 			       (unsigned long long) ti->len);
+		limits->max_allocate_sectors = 0;
 
 		/*
 		 * FIXME: this should likely be moved to blk_stack_limits(), would
diff --git a/drivers/md/md.h b/drivers/md/md.h
index acd681939112..d9088122674d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -798,5 +798,6 @@ static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio
 	if (bio_op(bio) == REQ_OP_WRITE_ZEROES &&
 	    !bio->bi_disk->queue->limits.max_write_zeroes_sectors)
 		mddev->queue->limits.max_write_zeroes_sectors = 0;
+	blk_queue_max_allocate_sectors(mddev->queue, 0);
 }
 #endif /* _MD_MD_H */



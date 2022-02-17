Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F57C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 06:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiBQG1Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:27:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQG1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B901EAC8;
        Wed, 16 Feb 2022 22:27:07 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jzl9t26CJz1FD6v;
        Thu, 17 Feb 2022 14:22:42 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 17 Feb 2022 14:27:04 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] block: update io_ticks when io hang
Date:   Thu, 17 Feb 2022 14:42:47 +0800
Message-ID: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the inflight IOs are slow and no new IOs are issued, we expect
iostat could manifest the IO hang problem. However after
commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
precise counting"), io_tick and time_in_queue will not be updated until
the end of IO, and the avgqu-sz and %util columns of iostat will be zero.

Because it has using stat.nsecs accumulation to express time_in_queue
which is not suitable to change, and may %util will express the status
better when io hang occur. To fix io_ticks, we use update_io_ticks and
inflight to update io_ticks when diskstats_show and part_stat_show
been called.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 block/genhd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---
v2:
* add part_stat_lock() & part_stat_unlock() to protect update_io_ticks().
v1: https://www.spinics.net/lists/linux-block/msg78931.html

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..781dc78f97d8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -913,12 +913,17 @@ ssize_t part_stat_show(struct device *dev,
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	part_stat_read_all(bdev, &stat);
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, bdev);
 	else
 		inflight = part_in_flight(bdev);
 
+	if (inflight) {
+		part_stat_lock();
+		update_io_ticks(bdev, jiffies, true);
+		part_stat_unlock();
+	}
+	part_stat_read_all(bdev, &stat);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
@@ -1174,12 +1179,17 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
-		part_stat_read_all(hd, &stat);
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
 			inflight = part_in_flight(hd);
 
+		if (inflight) {
+			part_stat_lock();
+			update_io_ticks(hd, jiffies, true);
+			part_stat_unlock();
+		}
+		part_stat_read_all(hd, &stat);
 		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
-- 
2.31.1


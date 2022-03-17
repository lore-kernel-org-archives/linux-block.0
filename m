Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D8C433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 11:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiCQLNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiCQLNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 07:13:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E741E3184;
        Thu, 17 Mar 2022 04:11:47 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK4Dm5bbBzfZ2q;
        Thu, 17 Mar 2022 19:10:16 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 19:11:45 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 19:11:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <mpatocka@redhat.com>, <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/3] block: don't show disk stats if io accounting is disabled
Date:   Thu, 17 Mar 2022 19:26:51 +0800
Message-ID: <20220317112653.1019490-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317112653.1019490-1-yukuai3@huawei.com>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If io accounting is disabled, there is no point to handle such device
in diskstats_show(), and it can be confused for users because all fields
in iostat are zero while the disk is handling io.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index c3b32c665aec..e5307f512185 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -937,6 +937,9 @@ ssize_t part_stat_show(struct device *dev,
 	struct disk_stats stat;
 	unsigned int inflight;
 
+	if (!blk_queue_io_stat(q))
+		return sprintf(buf, "io accounting is disabled\n");
+
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, bdev);
 	else
@@ -1207,6 +1210,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
+		if (!blk_queue_io_stat(gp->queue))
+			continue;
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
-- 
2.31.1


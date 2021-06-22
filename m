Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E07C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A760FE3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFVXXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:23:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20487 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFVXXr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404090; x=1655940090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkrG5OhOeau3/D7CoH4TV50m5QWgVZ9GZ/QlhOJfxyk=;
  b=qPnjPdL2E59DsMclh5K20KssNmDpDXbMkpdjXRZycFqIgwyf1u58dnyc
   Xd4OJKC8wVY0AjJBZ+WBlxgvmnhG2WCjuXX9iglGTGJJLnNtVZi2MhM0N
   LTdt4J8WXGsFxlEAWhB1VCbsHLGRNW2M3jgdR6a7b+BnBCX5gujWl4b8Y
   ltCU/HYp+VKCxCzu2/EVfIt7l318bI9fOjYVRpSyGYNjM6jA0h7z3FNy2
   OpLexY0/SJr9r/AvS3oZbg4/DRCggUGn8swlStq3lgNZf0qYfwF1psSuS
   zFfe0/qXCl/gyz6zlV7bTU4XqT6/Jv9FUJD2FzbU/8Hnx8cRZunaaQ++0
   Q==;
IronPort-SDR: oW+CNjulOyEjckEVCh8xyf0CHeFMoTnUHAwBf8/dZGUTpgGSsaGfYPYKscFxx1Yn+nbs7I5tfF
 p7A2DF4frQJZwAEP/xXBGAElrUDCbr4RnvXJOntYrgMHDYBqvKXlk4OKuMK2XHpjaVtkV25z+K
 jPJFV6jr/VyFk/yZJ/RMBCTs7VFKYU/kM7vScjHNHt8qO39kMdtKBwgTyYG35bA2s0gy1W2usU
 Bfc9jOduFa7Jl7hy0mIV88Sci+N+JM/DBBJ2ZKFbCO2+tWOPkG5RJj7F+4SllBj7agB/MZPZe8
 6/I=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="172632974"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:21:30 +0800
IronPort-SDR: 4WyhNfacwCujCWVkMsrtuvuJXJgyhVJ28Z7c0VlBuVJdUe10V5FKSFekReBP0vpkqT79OCut8H
 J/kdJs744oqWJ8YtYciepUhbnoBtuOPyasRakxMe4+NqyiUaHZvYsXqmQv5i2duUvrJ1Il0EtW
 IW+s583D4bEw1fNCwB4OWtKp1LAQWZtyciPWRqN+ALJsRVizdyyD2WmjSfX9pP1AwSXw8SQ+H5
 8zRZnm6MhBNXEsBHRePnzPNEqP4iZrpLwBe22aplDxc53ZUcqKNHV2/7XPzGsqzWgAbZ9Gkexw
 dmd6J0Z3+dpRDxunbHwbA9S0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:58:48 -0700
IronPort-SDR: bMsUB95T8TkEVE9HPJo9y0KqL89emsQIZnc/wBjTHMfCnlrHft/ez625sWgtG44N2m3D8nd6Ho
 utF2JWAPWhLfiy1exEKa9H2YPULsw/x29RT0mHa7RN+9aU1UIE5K6fdzXKMwF/CHJSCynUK/lt
 AJWB6LWtuOmgWV9keVXHSHPnqBFVbIinFslRJK1NYvQpcOd1YEqH7lxDD/3xpXtjS6SKX5M66n
 C+uBNZ4xyut6PN6b89RYm1fVhED0hJzKWXTDDauV9kVpoudtmsj866WzMSAW52keiEc4oR/f5v
 M7w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:21:31 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 9/9] loop: allow user to set the queue depth
Date:   Tue, 22 Jun 2021 16:19:51 -0700
Message-Id: <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6fc3cfa87598..c0d54ffd6ef3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1942,6 +1942,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -2094,7 +2097,7 @@ static int loop_add(struct loop_device **l, int i)
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
-- 
2.22.1


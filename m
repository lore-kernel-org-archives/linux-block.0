Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D6C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58164EDE
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBBFha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3359 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBFh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244249; x=1643780249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mElkmngegMi7x0cjwruW8ZgJ8rQ6y2vMMid76m7J9mI=;
  b=XsITsZ73pZpzLkalMTuaNay4k6K0v7bJuicasARjqGpbexMD/xsdoRAK
   MT4vFd9QckVBp906em+hr1QJ2RIfSG2IemKm6g9L0MZIh8crctkxTTHHw
   Ot0/lBSJI38h57LDMT2qDBIgC024rqGpYEcsqIFTJArKbmFwjimc8ZcmT
   blKUWHub+bnmJXoRd8IemxQW1BEpuk/Cccr3MO/lulzxZrVj18trO1Uij
   amKDdp7LjFGogBGyG+Z3ByFTSLqFNlHRMeEo3kF0fQ14Z4cn2Erw70j5V
   m5PhUxc0BcGOtpbAEvtdZI8fdv7YdS1ElrUoxgoE9MLsUEcJ7Ww0ZdPSo
   g==;
IronPort-SDR: 5WuDhogF/jhO8+/2FUfDNpoAp1gVTaq45p0rt19DRl6ERS6rwk29cN7PQOpwjo1DXcbU+YNIg1
 cdq1W0rV4D7AVBdojoFuXjdwa5q2aLDywfNZkvkzjloIHbL/192cv1aZKVZV4xwCgJQAg7NhRv
 HNc+eAxFkogsXdLXIy4e7CIK8u9Lr1ranrM8tCgE0rqzFYYOvRwJLaa9dKrCoHq+YzWM0D+Wat
 ZAZ3exE0oH9hKPc19BCSU4IsIOER19flfXqRWrsN41QqU7AxaMTR+h5lFI+rh5IBKTyMssim2y
 Qbg=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334289"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:24 +0800
IronPort-SDR: n29JRKr6uoakkEvjqv4Xh6HXLKjFw14BRYP2iZP2CTakumoRxJPyy1RwDchx2MpQNib4LxPcym
 LfQfN/Y/9OlDb1ivchs9gx8go78kDAgDs9jkB5oIItJeyQgUxQ0pv5SpLuzNJ4L2wHSy+JQb+J
 xBdwsKjch773gzJDvDUV4G1KEyeotGRnwAXDEFf7Po/NUeGg4ImdiFHZJliG3IFpsWcHkdAHyT
 vgxlyxgXLDcQouiGpQzlFralhiWggTMoNFSlSVKp7O8tkOTA7UgN+HU7Qmh+qcSzZwt5IF/jLz
 zHmIpOKE6Mjl4Fw6yZiAMcdZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:18:33 -0800
IronPort-SDR: 2ZHU+MYSo5eyKOSDcOIKc9KIQu2H0arolIj44ZQUsU+61WJ5Jdts1bIcDXwNt08ZiAQRYArdBU
 HVJwLLQ9uJKN0eHUQjDsin+Fd5/5+f6JtJmrPpMxOPs1mANqi/Tpe+zVhmO1i2APmTHTOF7MDF
 RyZODTy3eRqkt0hM1R9eblI1q8tluCprzcNeu2FsHZFwxVB8zuDHeb//aLC1jIYkdXVHhsvRUn
 l/NBQ4nDd7MbHQ3Jkaxbjpn3eG1C14XDnnK9o+rJW1B911/KfeGG7bhiUmUcGrpuELyeLKdwIP
 Mpo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:24 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 04/20] loop: allow user to set the queue depth
Date:   Mon,  1 Feb 2021 21:35:36 -0800
Message-Id: <20210202053552.4844-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
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
index 0a8cee66c622..cf2789f7e6ba 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1950,6 +1950,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -2105,7 +2108,7 @@ static int loop_add(struct loop_device **l, int i)
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


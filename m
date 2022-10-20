Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D603EC433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 03:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJTDxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 23:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJTDxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 23:53:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E018D44F
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 20:53:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtD9Y26w3z1P77b;
        Thu, 20 Oct 2022 11:49:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 11:53:49 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <paulmck@kernel.org>
Subject: [PATCH v2 0/2] improve nvme quiesce time for large amount of namespaces
Date:   Thu, 20 Oct 2022 11:53:46 +0800
Message-ID: <20221020035348.10163-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now nvme_stop_queues quiesce all queues one by one. Every queue must
wait a grace period(rcu or srcu). If the controller has a large amount
of namespaces, the total waiting time is very long.
Test result: the total waiting time is more than 20 seconds when the
controller has 256 namespace.

This set improves the quiesce time when using a large set of namespaces,
which also improves I/O failover time in a multipath environment.

We improve for both non-blocking tagset and blocking tagset introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme).

Changes from v2:
- replace call_srcu to start_poll_synchronize_srcu
- rename the flag name to make it accurate.
- move unquiescing queue outside from nvme_set_queue_dying
- add mutex to ensure that all queues are quiesced after set the NVME_CTRL_STOPPED.

Changes from v1:
- improvement is based on tagset rather than namesapces

Chao Leng (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 57 +++++++++++++++---------------------
 drivers/nvme/host/nvme.h |  3 +-
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  3 ++
 5 files changed, 106 insertions(+), 35 deletions(-)

-- 
2.16.4


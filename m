Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D43C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMJpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMJo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 05:44:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD251B9DB
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 02:44:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp4Hz5F3yzmV9Z;
        Thu, 13 Oct 2022 17:40:15 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 17:44:51 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <lengchao@huawei.com>, <ming.lei@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v2 0/2] improve nvme quiesce time for large amount of namespaces
Date:   Thu, 13 Oct 2022 17:44:48 +0800
Message-ID: <20221013094450.5947-1-lengchao@huawei.com>
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

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs and blocking hctxs introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme) for both tagset types (blocking
and non-blocking);

Changes from v1:
- improvement is based on tagset rather than namesapces

Chao Leng (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 42 +++++++++------------------
 drivers/nvme/host/nvme.h |  2 +-
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  2 ++
 5 files changed, 93 insertions(+), 30 deletions(-)

-- 
2.16.4


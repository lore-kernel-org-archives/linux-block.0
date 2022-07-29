Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97406C19F2A
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiG2Hjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiG2Hjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:39:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284AE81B04
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:39:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvK953qmDzlWKt;
        Fri, 29 Jul 2022 15:37:13 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:48 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
        <axboe@kernel.dk>, <lengchao@huawei.com>
Subject: [PATCH 0/3] improve nvme quiesce time for large amount of namespaces
Date:   Fri, 29 Jul 2022 15:39:45 +0800
Message-ID: <20220729073948.32696-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath
environment.

Chao Leng (3):
  blk-mq: delete unnecessary comments
  nvme: improve the quiesce time for non blocking transports
  nvme: improve the quiesce time for blocking transports

 block/blk-mq.c           |  4 ----
 drivers/nvme/host/core.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.16.4


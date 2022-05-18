Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F32C433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 12:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiERMMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiERMMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 08:12:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAA14AF73;
        Wed, 18 May 2022 05:12:37 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3Bch6M3gzQkBC;
        Wed, 18 May 2022 20:09:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 20:12:35 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 20:12:34 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 0/6] nbd: bugfix and cleanup patches
Date:   Wed, 18 May 2022 20:26:12 +0800
Message-ID: <20220518122618.1702997-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Changes in v2:
 - in patch 3, instead of clear and then reset the flag if rq is not
 completed, test first and clear if rq is going to complete.

path 1-2 fix races between nbd setup and module removal.
patch 3 fix io can't be completed in some error path.
patch 4 fix io hung when disconnecting failed.
patch 5 fix sysfs warning about duplicate creation.
patch 6 use pr_err to output error message.

Previous versions:
v1: https://patchwork.kernel.org/project/linux-block/cover/20220426130746.885140-1-yukuai3@huawei.com/

Yu Kuai (5):
  nbd: call genl_unregister_family() first in nbd_cleanup()
  nbd: fix race between nbd_alloc_config() and module removal
  nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
  nbd: fix io hung while disconnecting device
  nbd: use pr_err to output error message

Zhang Wensheng (1):
  nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

 drivers/block/nbd.c | 110 +++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 42 deletions(-)

-- 
2.31.1


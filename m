Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88469C433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 13:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiEJNGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbiEJNGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 09:06:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF3261944;
        Tue, 10 May 2022 06:02:37 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyJ8j2fkKzhYyV;
        Tue, 10 May 2022 21:01:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:02:35 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 21:02:34 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 0/2] block, bfq: make bfq_has_work() more accurate
Date:   Tue, 10 May 2022 21:16:27 +0800
Message-ID: <20220510131629.1964415-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset try to make bfq_has_work() more accurate, patch 1 is a
small problem found by code review.

BTW, I not sure why blk_mq_run_hw_queues() is called with 'bfqd->lock'
held, I think this is not necessary. And bfq_has_work() can be more
accurate by reading 'bfqd->queued' with 'bfqd->lock' held after patch 2.

Yu Kuai (2):
  block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
  block, bfq: make bfq_has_work() more accurate

 block/bfq-iosched.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.31.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8553EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiAQInz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:43:55 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31096 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiAQInz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:55 -0500
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jclhp40Mwz1FCjZ;
        Mon, 17 Jan 2022 16:40:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:43:53 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 16:43:52 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RESEND 0/3] blk-mq: allow hardware queue to get more tag while sharing a tag set
Date:   Mon, 17 Jan 2022 16:54:52 +0800
Message-ID: <20220117085455.2269760-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previous patch: https://lkml.org/lkml/2021/7/11/343

If there are multiple active queues while sharing a tag set, the available
tags is limit to fair share for each active queue. This patchset take
off such restriction if no one ever failed to get driver tag.

Yu Kuai (3):
  blk-mq: add new interfaces to track if hctx failed to get driver tag
  blk-mq: record how many hctx failed to get driver tag while sharing a
    tag set
  blk-mq: allow hardware queue to get more tag while sharing a tag set

 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 45 +++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.h     | 22 +++++++++++++++++++--
 block/blk-mq.c         | 13 +++++++++---
 block/blk-mq.h         |  4 ++++
 include/linux/blk-mq.h | 12 +++++++++++
 include/linux/blkdev.h |  2 ++
 7 files changed, 94 insertions(+), 6 deletions(-)

-- 
2.31.1


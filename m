Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A5C433E1
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 04:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB30420FC3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 04:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgFREUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:20:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgFREUd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 00:20:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C7DD7DA07EFD54E03E2;
        Thu, 18 Jun 2020 12:20:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 18 Jun 2020
 12:20:22 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <hch@infradead.org>, <axboe@kernel.dk>, <bvanassche@acm.org>,
        <jaegeuk@kernel.org>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH v3 0/2] loop: replace kill_bdev with invalidate_bdev
Date:   Thu, 18 Jun 2020 12:21:36 +0800
Message-ID: <20200618042138.2094266-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1->v2: modify comment, and make function 'kill_bdev' static
v2->v3: adapt code for commit 0c3796c24459
("loop: Factor out configuring loop from status")

Zheng Bin (2):
  loop: replace kill_bdev with invalidate_bdev
  block: make function 'kill_bdev' static

 drivers/block/loop.c | 8 ++++----
 fs/block_dev.c       | 5 ++---
 include/linux/fs.h   | 2 --
 3 files changed, 6 insertions(+), 9 deletions(-)

--
2.25.4


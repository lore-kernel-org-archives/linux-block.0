Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEDC04AB4
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2C21743
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfEUHxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 03:53:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfEUHxp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:53:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 567F5E5BDC1F0F88BF24;
        Tue, 21 May 2019 15:53:42 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 May 2019
 15:53:38 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <ming.lei@redhat.com>
Subject: [PATCH 0/2] fixes for block stats
Date:   Tue, 21 May 2019 15:59:02 +0800
Message-ID: <20190521075904.135060-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The first patch fixes the problem that there is no sample in
/sys/kernel/debug/block/nvmeXn1/poll_stat and hybrid poll may
don't work as expected. The second patch tries to ensure
the latency accounting for block stats will work normally
even when iostat is disabled.

Comments are wecome.

Regard,
Tao

Hou Tao (2):
  block: make rq sector size accessible for block stats
  block: also check RQF_STATS in blk_mq_need_time_stamp()

 block/blk-mq.c         | 17 ++++++++---------
 block/blk-throttle.c   |  3 ++-
 include/linux/blkdev.h | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.16.2.dirty


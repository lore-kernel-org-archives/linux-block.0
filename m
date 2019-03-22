Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FCC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94020883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfCVOoI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:44:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729413AbfCVOoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:44:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6145FF1B4CC5320D2DEB;
        Fri, 22 Mar 2019 22:44:06 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:44:01 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <dwindsor@gmail.com>, <peterz@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] blk-mq: convert atomic_t to refcount_t
Date:   Fri, 22 Mar 2019 22:48:16 +0800
Message-ID: <20190322144818.987-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset covert atomic variables (hctx.nr_active and blk_mq_tag.active_queues)
to newly provided refcount_t type and API, which can prevent accidental counter overflows
and underflows.


Yufen Yu (2):
  blk-mq: convert hctx.nr_active to refcount_t
  blk-mq: covert blk_mq_tag.active_queues to refcount_t

 block/blk-mq-debugfs.c | 4 ++--
 block/blk-mq-tag.c     | 8 ++++----
 block/blk-mq-tag.h     | 2 +-
 block/blk-mq.c         | 8 ++++----
 block/blk-mq.h         | 2 +-
 include/linux/blk-mq.h | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.16.2.dirty


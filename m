Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC5C432C3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 17:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D92D206DA
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 17:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfKMRap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfKMRap (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC7CA7D6366D8098886D;
        Thu, 14 Nov 2019 01:30:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 01:30:36 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] blk-mq/sbitmap: Delete some unused functions
Date:   Thu, 14 Nov 2019 01:27:20 +0800
Message-ID: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function blk_mq_can_queue() never seemed to ever have been referenced, so
delete it and any other now-unused callees.

John Garry (2):
  blk-mq: Delete blk_mq_has_free_tags() and blk_mq_can_queue()
  sbitmap: Delete sbitmap_any_bit_clear()

 block/blk-mq-tag.c      |  8 --------
 block/blk-mq-tag.h      |  1 -
 block/blk-mq.c          |  6 ------
 include/linux/blk-mq.h  |  1 -
 include/linux/sbitmap.h |  9 ---------
 lib/sbitmap.c           | 17 -----------------
 6 files changed, 42 deletions(-)

-- 
2.17.1


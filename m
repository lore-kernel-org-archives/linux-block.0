Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF8C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0F65015
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCEPTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:19:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12698 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhCEPTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 10:19:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsWYZ2X5XzlSk3;
        Fri,  5 Mar 2021 23:17:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 23:19:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <hare@suse.de>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v3 0/3] blk-mq: Avoid use-after-free for accessing old requests
Date:   Fri, 5 Mar 2021 23:14:51 +0800
Message-ID: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series aims to tackle the various UAF reports, like:
[0] https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
[1] https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
[2] https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/
[3] https://lore.kernel.org/linux-block/b859618aeac58bd9bb620d7ebdb24b90@codeaurora.org/

Details are in the commit messages.

The issue addressed in patch 1/3 is pretty easy to reproduce, 2+3/3 not so
much, and I had to add mdelays in the iters functions to recreate in
sane timeframes.

A regards patch 1/3, if 2+3/3 are adopted, then this can simplified to
simply clear the tagset requests pointers without using any atomic
operations. However, this patch on its own seems to solve the problem [3],
above. So the other 2x patches are really for extreme scenarios which may
never be seen in practice. As such, it could be considered to just accept
patch 1/3 now.

Differences to v2:
- Add patch 2+3/3
- Drop patch to lockout blk_mq_queue_tag_busy_iter() when exiting elevator

John Garry (3):
  blk-mq: Clean up references to old requests when freeing rqs
  blk-mq: Freeze and quiesce all queues for tagset in elevator_exit()
  blk-mq: Lockout tagset iterator when exiting elevator

 block/blk-mq-sched.c   |  2 +-
 block/blk-mq-tag.c     |  7 ++++++-
 block/blk-mq.c         | 21 +++++++++++++++++++--
 block/blk-mq.h         |  2 ++
 block/blk.h            | 23 +++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 6 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.26.2


Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C57C43331
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9252076A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCYMkT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:40:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbgCYMkS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BD5CF4A5822C0728FF8;
        Wed, 25 Mar 2020 20:40:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:05 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
Date:   Wed, 25 Mar 2020 20:38:37 +0800
Message-ID: <20200325123843.47452-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, all 

We have reported a use-after-free crash for bdi device in __blkg_prfill_rwstat().
The bug is caused by printing device kobj->name while the device and kobj->name
has been freed by bdi_unregister().

In fact, commit 68f23b8906 "memcg: fix a crash in wb_workfn when a device disappears"
has tried to address the issue, but the code is till somewhat racy after that commit.

In this patchset, we try to protect bdi->dev with spinlock and copy device name
into caller buffer, avoiding use-after-free. 

V4:
  * Fix coding error in bdi_get_dev_name()
  * Write one patch for each broken caller

V3:
  https://www.spinics.net/lists/linux-block/msg51111.html 
  Use spinlock to protect bdi->dev and copy device name into caller buffer

V2:
  https://www.spinics.net/lists/linux-fsdevel/msg163206.html
  Try to protect device lifetime with RCU.

V1:
  https://www.spinics.net/lists/linux-block/msg49693.html
  Add a new spinlock and copy kobj->name into caller buffer.
  Or using synchronize_rcu() to wait until reader complete.

Yufen Yu (6):
  bdi: use bdi_dev_name() to get device name
  bdi: protect bdi->dev with spinlock
  bfq: fix potential kernel crash when print error info
  memcg: fix crash in wb_workfn when bdi unregister
  blk-wbt: replace bdi_dev_name() with bdi_get_dev_name()
  blkcg: fix use-after-free for bdi->dev

 block/bfq-iosched.c              |  6 +++--
 block/blk-cgroup-rwstat.c        |  6 +++--
 block/blk-cgroup.c               | 19 +++++-----------
 block/blk-iocost.c               | 14 +++++++-----
 block/blk-iolatency.c            |  5 +++--
 block/blk-throttle.c             |  6 +++--
 fs/ceph/debugfs.c                |  2 +-
 fs/fs-writeback.c                |  4 +++-
 include/linux/backing-dev-defs.h |  1 +
 include/linux/backing-dev.h      | 26 ++++++++++++++++++++++
 include/linux/blk-cgroup.h       |  1 -
 include/trace/events/wbt.h       |  8 +++----
 include/trace/events/writeback.h | 38 ++++++++++++++------------------
 mm/backing-dev.c                 |  9 ++++++--
 14 files changed, 88 insertions(+), 57 deletions(-)

-- 
2.17.2


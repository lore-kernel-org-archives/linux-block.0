Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB1C4BA0B
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80CE24689
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBZLLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:11:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgBZLLp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:45 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 430A1CD88E354D1E20E7;
        Wed, 26 Feb 2020 19:11:40 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:39 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 0/7] bdi: fix use-after-free for bdi device
Date:   Wed, 26 Feb 2020 19:18:44 +0800
Message-ID: <20200226111851.55348-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, all 

We have reported a use-after-free crash for bdi device in
__blkg_prfill_rwstat() (see Patch #3). The bug is caused by printing
device kobj->name while the device and kobj->name has been freed by
bdi_unregister().

In fact, commit 68f23b8906 "memcg: fix a crash in wb_workfn when
a device disappears" has tried to address the issue, but the code
is till somewhat racy after that commit.

In this patchset, we try to protect device lifetime with RCU, avoiding
the device been freed when others used.

A way which maybe fix the problem is copy device name into special
memory (as discussed in [0]), but that is also need lock protect.

[0] https://lore.kernel.org/linux-block/20200219125505.GP16121@quack2.suse.cz/

V1:
  https://www.spinics.net/lists/linux-block/msg49693.html
  Add a new spinlock and copy kobj->name into caller buffer.
  Or using synchronize_rcu() to wait until reader complete.

Yufen Yu (7):
  blk-wbt: use bdi_dev_name() to get device name
  fs/ceph: use bdi_dev_name() to get device name
  bdi: protect device lifetime with RCU
  bdi: create a new function bdi_get_dev_name()
  bfq: fix potential kernel crash when print dev err info
  memcg: fix crash in wb_workfn when bdi unregister
  blk-wbt: replace bdi_dev_name() with bdi_get_dev_name()

 block/bfq-iosched.c              |  7 +++--
 block/blk-cgroup.c               |  8 ++++--
 block/genhd.c                    |  4 +--
 fs/ceph/debugfs.c                |  2 +-
 fs/ext4/super.c                  |  2 +-
 fs/fs-writeback.c                |  4 ++-
 include/linux/backing-dev-defs.h |  8 +++++-
 include/linux/backing-dev.h      | 31 +++++++++++++++++++--
 include/trace/events/wbt.h       |  8 +++---
 include/trace/events/writeback.h | 38 ++++++++++++--------------
 mm/backing-dev.c                 | 59 +++++++++++++++++++++++++++++++++-------
 11 files changed, 124 insertions(+), 47 deletions(-)

-- 
2.16.2.dirty


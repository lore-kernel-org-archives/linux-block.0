Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:1302 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdATLTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 06:19:07 -0500
From: Hou Tao <houtao1@huawei.com>
To: <dm-devel@redhat.com>, <linux-block@vger.kernel.org>
CC: <agk@redhat.com>, <snitzer@redhat.com>, <ejt@redhat.com>,
        <vgoyal@redhat.com>
Subject: [PATCH RFC 0/4] dm thin: support blk-throttle on data and metadata device
Date: Fri, 20 Jan 2017 19:15:48 +0800
Message-ID: <1484910952-29820-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

We need to throttle the O_DIRECT IO on data and metadata device
of a dm-thin pool and encounter some problems. If we set the
limitation on the root blkcg, the throttle works. If we set the
limitation on a child blkcg, the throttle doesn't work well.

The reason why the throttle doesn't work is that dm-thin defers
the process of bio when the physical block of bio has not been
allocated. The bio will be submitted by the pool worker, and the
blkcg of the bio will be the blkcg of the pool worker, namely,
the root blkcg instead of the blkcg of the original IO thread.
We only set a limitation on the blkcg of the original IO thread,
so the blk-throttle doesn't work well.

In order to handle the situation, we add a "keep_bio_blkcg" feature
to dm-thin. If the feature is enabled, the original blkcg of bio
will be saved at thin_map() and will be used during blk-throttle.

Tao

Hou Tao (4):
  dm thin: add a pool feature "keep_bio_blkcg"
  dm thin: parse "keep_bio_blkcg" from userspace tools
  dm thin: show the enabled status of keep_bio_blkcg feature
  dm thin: associate bio with current task if keep_bio_blkcg is enabled

 drivers/md/dm-thin.c | 26 ++++++++++++++++++++++++--
 drivers/md/dm-thin.h | 17 +++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 drivers/md/dm-thin.h

-- 
2.5.0


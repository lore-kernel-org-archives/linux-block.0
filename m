Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:9091 "EHLO
        BJEXCAS006.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751927AbdIAOQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Sep 2017 10:16:55 -0400
Date: Fri, 1 Sep 2017 22:16:45 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2 0/2] Add wrapper for blkcg policy operatins
Message-ID: <cover.1504275001.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The first patch is the V2 of [PATCH] blkcg: check pol->cpd_free_fn
before free cpd, it fixs a checking before free cpd.

The second patch add some wrappers for struct blkcg_policy->xxx_fn, because not
every block cgroup policy implement all operations.

weiping zhang (2):
  blkcg: check pol->cpd_free_fn before free cpd
  blkcg: add wrappers for struct blkcg_policy operations

 block/blk-cgroup.c         | 57 +++++++++++++++++-------------------
 include/linux/blk-cgroup.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 30 deletions(-)

-- 
2.9.4

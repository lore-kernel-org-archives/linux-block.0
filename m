Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E2C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 08:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiCRILT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 04:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiCRILS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 04:11:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056E25719A;
        Fri, 18 Mar 2022 01:10:00 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKc7v2jKBzCqk0;
        Fri, 18 Mar 2022 16:07:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 16:09:58 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 16:09:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <yukuai3@huawei.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC -next 0/3] improve fairness for sbitmap waitqueues
Date:   Fri, 18 Mar 2022 16:25:02 +0800
Message-ID: <20220318082505.3025427-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During some io test, I found that waitqueues can be extremly unbalanced,
especially when tags are little.

For example:
test cmd: nr_requests is set to 64, and queue_depth is set to 32
[global]
filename=/dev/sdh
ioengine=libaio
direct=1
allow_mounted_write=0
group_reporting

[test]
rw=randwrite
bs=4k
numjobs=512
iodepth=2

With patch 1 applied, I observe the following status:
ws_active=484
ws={
        {.wait_cnt=8, .waiters_cnt=117},
        {.wait_cnt=8, .waiters_cnt=59},
        {.wait_cnt=8, .waiters_cnt=76},
        {.wait_cnt=8, .waiters_cnt=0},
        {.wait_cnt=5, .waiters_cnt=24},
        {.wait_cnt=8, .waiters_cnt=12},
        {.wait_cnt=8, .waiters_cnt=21},
        {.wait_cnt=8, .waiters_cnt=175},
}

'waiters_cnt' means how many threads are waitng for tags in the 'ws',
and such extremely unbalanced status is very frequent. After reading the
sbitmap code, I found there are two situations that might cause the
problem:

1) blk_mq_get_tag() can call 'bt_wait_ptr()' while the threads might get
tag successfully before going to wait. - patch 2

2) After a 'ws' is woken up, following blk_mq_put_tag() might wake up
the same 'ws' again instead of the next one. - patch 3

I'm not sure if the unbalanced status is really a *problem* and need to
be fixed, this patchset is just to improve fairness and not a thorough
fix. Any comments and suggestions are welcome.

Yu Kuai (3):
  sbitmap: record the number of waiters for each waitqueue
  blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
  sbitmap: improve the fairness of waitqueues' wake up

 block/blk-mq-tag.c      |  6 ++---
 include/linux/sbitmap.h |  5 ++++
 lib/sbitmap.c           | 57 ++++++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.31.1


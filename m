Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B81C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD660F36
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKBLfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:35:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4048 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKBLfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 07:35:22 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hk7360By4z67jfs;
        Tue,  2 Nov 2021 19:29:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 12:32:44 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 11:32:42 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Date:   Tue, 2 Nov 2021 19:27:32 +0800
Message-ID: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In [0], Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
and callees for shared tags.

Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
shared tags, but it was not optimum previously.

So I would like this series tested, and also to know what is triggering
blk_mq_queue_tag_busy_iter() from userspace to cause such high CPU
loading.

As suggested by Ming, reading /proc/diskstats in a while true loop
can trigger blk_mq_queue_tag_busy_iter(); I do so in a test with 2x
separate consoles, and here are the results:

v5.15
blk_mq_queue_tag_busy_iter() 6.2%
part_stat_read_all() 6.7

pre-v5.16 (Linus' master branch @ commit bfc484fe6abb)
blk_mq_queue_tag_busy_iter() 4.5%
part_stat_read_all() 6.2

pre-v5.16+this series
blk_mq_queue_tag_busy_iter() not shown in top users
part_stat_read_all() 7.5%

These results are from perf top, on a system with 7x
disks, with hisi_sas which has 16x HW queues.

[0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

John Garry (3):
  blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
  blk-mq: Delete busy_iter_fn
  blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags

 block/blk-mq-tag.c     | 58 +++++++++++++++++++++++++++---------------
 block/blk-mq-tag.h     |  2 +-
 block/blk-mq.c         | 17 ++++++-------
 include/linux/blk-mq.h |  2 --
 4 files changed, 47 insertions(+), 32 deletions(-)

-- 
2.17.1


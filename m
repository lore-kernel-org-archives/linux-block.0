Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EECBC43216
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513F461212
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhHXODB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:03:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8764 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbhHXODA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:03:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gv9l34ts4zYt7y;
        Tue, 24 Aug 2021 22:01:35 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 22:02:07 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 22:02:07 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 0/5] fix request uaf in nbd_read_stat()
Date:   Tue, 24 Aug 2021 22:12:22 +0800
Message-ID: <20210824141227.808340-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in v3:
 - v2 can't fix the problem thoroughly, add patch 3-4 to this series.
 - modify descriptions.
 - patch 5 is just a cleanup
Changes in v2:
 - as Bart suggested, add a new helper function for drivers to get
 request by tag.


Our syzkaller report a uaf in nbd_read_stat():

Call trace:
 dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
 show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x144/0x1b4 lib/dump_stack.c:118
 print_address_description+0x68/0x2d0 mm/kasan/report.c:253
 kasan_report_error mm/kasan/report.c:351 [inline]
 kasan_report+0x134/0x2f0 mm/kasan/report.c:409
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
 __read_once_size include/linux/compiler.h:193 [inline]
 blk_mq_rq_state block/blk-mq.h:106 [inline]
 blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
 nbd_read_stat drivers/block/nbd.c:670 [inline]
 recv_work+0x1bc/0x890 drivers/block/nbd.c:749
 process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2147
 worker_thread+0x80/0x9d0 kernel/workqueue.c:2302
 kthread+0x1d8/0x1e0 kernel/kthread.c:255
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174

1) At first, a normal io is submitted and completed with scheduler:

internel_tag = blk_mq_get_tag -> get tag from sched_tags
 blk_mq_rq_ctx_init
  sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
...
blk_mq_get_driver_tag
 __blk_mq_get_driver_tag -> get tag from tags
 tags->rq[tag] = sched_tag->static_rq[internel_tag]

So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
to the request: sched_tags->static_rq[internal_tag]. Even if the
io is finished.

2) nbd server send a reply with random tag directly:

recv_work
 nbd_read_stat
  blk_mq_tag_to_rq(tags, tag)
   rq = tags->rq[tag]

3) if the sched_tags->static_rq is freed:

blk_mq_sched_free_requests
 blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
  blk_mq_clear_rq_mapping(set, tags, hctx_idx);

4) Then, nbd continue to use the freed request in nbd_read_stat()

This patchset try to fix the problem by following apporch:

 - add a new interface blk_mq_get_rq_by_tag() to replace blk_mq_tag_to_rq(),
 it will make sure the return request is started and won't be freed.
 - nbd client won't handle the reply if it didn't send the corresponding
 request message.
 - nbd won't complete a request multiple times

Yu Kuai (5):
  blk-mq: add a new interface to get request by tag
  nbd: convert to use blk_mq_get_rq_by_tag()
  nbd: don't handle response without a corresponding request message
  nbd: make sure request completion won't concurrent
  nbd: don't start request if nbd_queue_rq() failed

 block/blk-mq-tag.c     | 37 +++++++++++++++++++++++++++++++++++++
 block/blk-mq.c         |  1 +
 block/blk-mq.h         |  1 -
 drivers/block/nbd.c    | 39 +++++++++++++++++++++++++++++----------
 include/linux/blk-mq.h |  4 ++++
 5 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.31.1


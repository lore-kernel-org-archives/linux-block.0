Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6DEDEC70
	for <linux-block@archiver.kernel.org>; Wed, 13 Sep 2023 15:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbjIMPQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbjIMPQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:35 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055601B9
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 08:16:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694618188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z8jXCZPukC62KzuUdS/5ci4fhw4YoBdcpJ7VcWMR4Nw=;
        b=R6OB3Xsf2pprFdH7VzdzY8IkhbUPDPog74gB0aXDQyuHRt5dO8sJNIuWBcvxyL/jOL0Wcg
        JAJC4tat6BWfqPkW99yfZEBnhOWM3bxjHce+tXxgvyu/OAu/Q1daxg+ZZwcTgwSwfaS989
        MTV/iwizyG9Ylw9TS1LLaH3I/VrsCPU=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/5] blk-mq: optimize queue_rqs() support
Date:   Wed, 13 Sep 2023 15:16:11 +0000
Message-Id: <20230913151616.3164338-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v2:
  - Drop the patch that fixes a potential race in request timeout
    from this series.
  - Rebased on the newest block/for-next branch.

The current queue_rqs() support has limitation that it can't work on
shared tags queue, which is resolved by patch 1-3. We move the account
of active requests to where we really allocate the driver tag.

This is clearer and matched with the unaccount side which now happen
when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
was used to avoid double account problem of flush request.

Another problem is that the driver that support queue_rqs() has to
set inflight request table by itself, which is resolved in patch 4.

The last patch add queue_rqs() support for null_blk, which showed
3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
And we also use it for testing queue_rqs() on shared tags queue.

Thanks for review!

Chengming Zhou (5):
  blk-mq: account active requests when get driver tag
  blk-mq: remove RQF_MQ_INFLIGHT
  blk-mq: support batched queue_rqs() on shared tags queue
  blk-mq: update driver tags request table when start request
  block/null_blk: add queue_rqs() support

 block/blk-flush.c             | 11 ++-----
 block/blk-mq-debugfs.c        |  1 -
 block/blk-mq.c                | 45 +++++++++------------------
 block/blk-mq.h                | 57 ++++++++++++++++++++++++-----------
 drivers/block/null_blk/main.c | 20 ++++++++++++
 drivers/block/virtio_blk.c    |  2 --
 drivers/nvme/host/pci.c       |  1 -
 include/linux/blk-mq.h        |  2 --
 8 files changed, 76 insertions(+), 63 deletions(-)

-- 
2.40.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507EEB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjF0MJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjF0MJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 08:09:26 -0400
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [IPv6:2001:41d0:203:375::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23C199C
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 05:09:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687867762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AUY6SnNaHoXJwGaybydHxxeS/ugZelzciu5E2l4+EnE=;
        b=mIS1PRPuLpdlPbSy2ZIy3CeTs6m2b1Oi9utl3Dm/LwL3H2Cwm3Dvt+I/jfBB0a18vNnzLA
        MhqkpJ0z10FN2XvImNQsbDhRJt5jTudvxRrAvrqnOf7fU0yy1e0NXX1+WmbiNxCz8EVZYb
        jNaa3quBF63s70Iz5bP3HnsxVnDYTM8=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 0/4] blk-mq: optimize the size of struct request
Date:   Tue, 27 Jun 2023 20:08:50 +0800
Message-Id: <20230627120854.971475-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

After the commit be4c427809b0 ("blk-mq: use the I/O scheduler for
writes from the flush state machine"), rq->flush can't reuse rq->elv
anymore, since flush_data requests can go into io scheduler now.

That increased the size of struct request by 24 bytes, but this
patchset can decrease the size by 40 bytes, which is good I think.

patch 1 use percpu csd to do remote complete instead of per-rq csd,
decrease the size by 24 bytes.

patch 2-3 reuse rq->queuelist in flush state machine pending list,
and maintain a u64 counter of inflight flush_data requests, decrease
the size by 16 bytes.

patch 4 is just cleanup by the way.

Thanks for comments!

Chengming Zhou (4):
  blk-mq: use percpu csd to remote complete instead of per-rq csd
  blk-flush: count inflight flush_data requests
  blk-flush: reuse rq queuelist in flush state machine
  blk-mq: delete unused completion_data in struct request

 block/blk-flush.c      | 19 +++++++++----------
 block/blk-mq.c         | 12 ++++++++----
 block/blk.h            |  5 ++---
 include/linux/blk-mq.h | 10 ++--------
 4 files changed, 21 insertions(+), 25 deletions(-)

-- 
2.39.2


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F94EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjF2LHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2LHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 07:07:14 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90510CF
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 04:07:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688036830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oSLJao9f5JaszPoImqsUvDRSvTMFoJRzT3O/9NnVAD8=;
        b=qKEKzK9F9eMP5JoByRJSooGFJrjAc4+lsvHOceAaimvo6wrsFv6HRkkH/a86fKdP18B4Va
        VnHHuaU49jZZtFXJ4P0vWMFs93yY6lSjgcC9OmsFyu3aL1+BHdAWV/iyllaPgaWAvhrKbP
        1f1N5uVg8OoieHcBjidLRE7dCkiFgL8=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/4] blk-mq: optimize the size of struct request
Date:   Thu, 29 Jun 2023 19:03:55 +0800
Message-Id: <20230629110359.1111832-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

v2:
 - Change to use call_single_data_t, which use __aligned() to avoid
   to use 2 cache lines for 1 csd. Thanks Ming Lei.
 - [v1] https://lore.kernel.org/all/20230627120854.971475-1-chengming.zhou@linux.dev/

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


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A9EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2MNu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjF2MNt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 08:13:49 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F3BC
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 05:13:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 0/2] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Thu, 29 Jun 2023 20:13:00 +0800
Message-Id: <20230629121302.1124851-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This patchset fix start_time_ns and alloc_time_ns for pre-allocated rq.

patch 1 is preparation that we move data->rq_flags initialization code
outside blk_mq_rq_ctx_init() to its caller, since we will need it to
tell if we need to get start_time_ns.

patch 2 is the fix patch that we set alloc_time_ns and start_time_ns
to now when the pre-allocated rq is actually used and we skip setting
during pre-allocation.

v4:
 - Combine the last two patches into one patch for clearer review.
 - Use blk_mq_alloc_data to pass start_time_ns instead of passing down
   yet another parameter. Thanks Christoph Hellwig.
 - [v3] https://lore.kernel.org/all/20230628124546.1056698-1-chengming.zhou@linux.dev/

v3:
 - Skip setting the alloc_time_ns and start_time_ns during pre-allocation,
   which is clearer, as suggested by Tejun.
 - [v2] https://lore.kernel.org/all/20230626050405.781253-1-chengming.zhou@linux.dev/

v2:
 - Let blk_mq_rq_ctx_init() receive start_time_ns for batched time setting.
 - Set alloc_time_ns and start_time_ns when the pre-allocated rq is actually
   used, as suggested by Tejun.
 - [v1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/

Chengming Zhou (2):
  blk-mq: move data->rq_flags initialization code
  blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq

 block/blk-mq.c         | 87 ++++++++++++++++++++++++------------------
 block/blk-mq.h         |  1 +
 include/linux/blk-mq.h |  6 +--
 3 files changed, 53 insertions(+), 41 deletions(-)

-- 
2.39.2


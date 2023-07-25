Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EFC001DE
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 13:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGYNTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGYNTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:00 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6510F8
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 06:18:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o1A965Rmyit4V/K6hD1sBav9uLDra+3bpcOqxUt5eIs=;
        b=dPQBmSow5zQ4A2h2IYNoiNHUFfJmLfcnSv2nvtsExxlV4Q65g4JsN5MjLbRrK4f7Lt9qcI
        jwZUEhIvQq1paurJo4WxrU2RJFmxmdOjfv78KRNXDJliXJ5WmWjidD283EKIHlbKA9oJNm
        pUaFguEEtnzYC5DAAeoQIrxTrTbgfB4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 0/4] blk-flush: optimize non-postflush requests
Date:   Tue, 25 Jul 2023 21:00:58 +0800
Message-ID: <20230725130102.3030032-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This series optimize flush handling for non-postflush requests. Now we
unconditionally replace rq->end_io to make rq return twice back to the
flush state machine for post-flush.

Obviously, non-postflush requests don't need it, they don't need to
end request twice, so they don't need to replace rq->end_io callback.
And the same for requests with the FUA bit on hardware with FUA support.

The previous approach [1] we take is to move blk_rq_init_flush() to
REQ_FSEQ_DATA stage and only replace rq->end_io if it needs post-flush.

But this way add more magic to the already way too magic flush sequence.
Christoph suggested that we can kill the flush sequence entirely, and
just split the flush_queue into a preflush and a postflush queue.

So this series implement the suggested approach that use two queues:
preflush and postflush requests have separate pending list and running
list, so we know what to do for each request in flush_end_io(), and
we don't need the flush sequence entirely.

Thanks for comments!

[1] https://lore.kernel.org/lkml/20230710133308.GB23157@lst.de/

Chengming Zhou (4):
  blk-flush: flush_rq should inherit first_rq's cmd_flags
  blk-flush: split queues for preflush and postflush requests
  blk-flush: kill the flush state machine
  blk-flush: don't need to end rq twice for non postflush

 block/blk-flush.c      | 181 +++++++++++++++++++++--------------------
 block/blk.h            |   3 +-
 include/linux/blk-mq.h |   1 -
 3 files changed, 96 insertions(+), 89 deletions(-)

-- 
2.41.0


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1DDEE49A8
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 07:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjHUHll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjHUHlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:40 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA189B1
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 00:41:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692603697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e7RQqy7BBUhNj/8/XrD6FUXtKEsKzZzJXUAD1YqsjNk=;
        b=HwmtGZY4pQWX/BSwAcYXFNtHSt+aZhI2edVliI2Hvffqs8ZoM+CVIeCmzMfMAFv69fovMF
        v/umJa+wvhbbd5zbXimSknnRCkrT+1MZ4O2dgIb0qSaty4Du0oyp8DMwTL2DSfpzWGQIBm
        zfDmgNTKQEeFmPp15KPE/yj18LujX44=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 0/4] blk-mq-tag: remove bt_for_each()
Date:   Mon, 21 Aug 2023 15:35:24 +0800
Message-ID: <20230821073528.3469210-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

There are two almost identical mechanisms in blk-mq-tag to iterate over
requests of one tags: bt_for_each() and the newer bt_tags_for_each().

This series aim to add support of queue filter in bt_tags_for_each()
then remove bt_for_each(). Fix and update documentation as we're here.

Thanks for review!

Chengming Zhou (4):
  blk-mq-tag: support queue filter in bt_tags_iter()
  blk-mq-tag: remove bt_for_each()
  blk-mq: delete superfluous check in iterate callback
  blk-mq-tag: update or fix functions documentation

 block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
 block/blk-mq.c     |  12 ++--
 2 files changed, 49 insertions(+), 139 deletions(-)

-- 
2.41.0


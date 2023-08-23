Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58EEE49A3
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 15:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjHWPT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHWPT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 11:19:26 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE4172B
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 08:18:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692803912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xSAN+0tPDrrkFE4CvuUEFyVpn4pe7SLXZwukbKylT5g=;
        b=MoZET1dXp5vphky+IdK0AqOBP82deVB2GZ6fV5vCBtLGA/mPqtsELuV9nBPLcdd5KIUrCV
        Pt4sAcZlEVJVp18bAcOTxwOU9dDpzjyuKb6hlmf0DSoj78CS57wl58ga0VTL16yob/okrs
        kNnezQkircIRNnHleOtN9cTojYDtWEY=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 0/6] blk-mq-tag: remove bt_for_each()
Date:   Wed, 23 Aug 2023 23:17:57 +0800
Message-ID: <20230823151803.926382-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v3:
  - Document the argument 'q' in the patch which add it.
  - Add Fixes tag and Reviewed-by tags.

Changes in v2:
  - Split by one change per patch and add Fixes tag.
  - Improve commit messages, suggested by Bart Van Assche.

There are two almost identical mechanisms in blk-mq-tag to iterate over
requests of one tags: bt_for_each() and the newer bt_tags_for_each().

This series aim to add support of queue filter in bt_tags_for_each()
then remove bt_for_each(). Fix and update documentation as we're here.

Thanks for review!

Chengming Zhou (6):
  blk-mq-tag: support queue filter in bt_tags_iter()
  blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
  blk-mq-tag: remove bt_for_each()
  blk-mq: delete superfluous check in iterate callback
  blk-mq-tag: fix functions documentation
  blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation

 block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
 block/blk-mq.c     |  12 ++--
 2 files changed, 49 insertions(+), 139 deletions(-)

-- 
2.41.0


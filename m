Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2BEB64DC
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 05:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFZFGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 01:06:00 -0400
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [IPv6:2001:41d0:1004:224b::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17B121
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 22:05:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687755955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JXf0Q/S3gf4ovedHaky94f5Srw5Lfa2v9EFqdiD33dU=;
        b=Mbcyg0M/BOvzWY5DvqihhLj92CfaSJPrcEF6ovbhqH+GzwFzS9cGIaSIh8ruYrjCBz/WFm
        rvCiNgcBAJ2IvvylKyFwGEGKtVRh1it5h4ohkBR5i+FsuDrTFaaATUBahmbDSjd6MtBmVQ
        IrN7UDIdg4huRlP4MV3u5mjGuYXVavY=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 0/3] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Mon, 26 Jun 2023 13:04:02 +0800
Message-Id: <20230626050405.781253-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This patchset is the updated version of [1], which fix start_time_ns
and alloc_time_ns for pre-allocated rq.

patch 1 and 2 is preparation that we ktime_get_ns() only once for
batched requests start_time_ns setting.

patch 3 is the fix patch that we set alloc_time_ns and start_time_ns
to now when the pre-allocated rq is actually used.

[1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/

Chengming Zhou (3):
  blk-mq: always use __blk_mq_alloc_requests() to alloc and init rq
  blk-mq: ktime_get_ns() only once for batched requests init
  blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq

 block/blk-mq.c         | 89 ++++++++++++++++++++++++------------------
 include/linux/blk-mq.h |  6 +--
 2 files changed, 55 insertions(+), 40 deletions(-)

-- 
2.39.2


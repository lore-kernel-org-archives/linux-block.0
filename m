Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B4ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiH3Mjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiH3Mjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:42 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AD12F56D
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 05:39:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661863170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TG3EYDpmqfHfbILbrzsmrF54rUiEhBKCg+hbhZM7EX4=;
        b=s2bBFsZ2Z4Jn2su+mP/q1DDBqGIsX+U5BOUKwUHhxgSgHcGEi5k9q+kDB4U4KqQWBTRsaZ
        UtrLQYJ1Peck/lLkF1CVMrcokFSWsAqt5YdBgsj49N9A/f1q3KlKJBMgrpUTq+AA2+8/HY
        OR9zg9jrR2sJiDKBqryiI7XE9q5arr4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/3] Small changes for rnbd-srv
Date:   Tue, 30 Aug 2022 20:39:01 +0800
Message-Id: <20220830123904.26671-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Pls review the three patches.

Thanks,
Guoqing    

Guoqing Jiang (3):
  rnbd-srv: fix the return value of rnbd_srv_rdma_ev
  rnbd-srv: make process_msg_close returns void
  rnbd-srv: remove redundant setting of blk_open_flags

 drivers/block/rnbd/rnbd-srv-dev.c | 1 -
 drivers/block/rnbd/rnbd-srv.c     | 9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.34.1


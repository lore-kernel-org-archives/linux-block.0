Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6AC54EE9
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiIBKBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiIBKBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615584ED8
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 03:01:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662112861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Pr8jM55qb5ld6DpXyfbjKa/xMjtyBHJWaNZZNA6UCY=;
        b=fNSp2gFHBdxYbBn6c9SS81+eKe5XmTY431mrVYKc2YAdsMcnMziPuYF5iuO89dYNdaTtFT
        bZfG/sY4tK5gS2FufQ1kCRvOSilEmZ9azYpm0O3Nj5KgvNm2ar4CasLlrtpqBsQztukYwV
        d9jr+TDvsb6a89OWw6fuhfabwDZeCdw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 0/3] Small changes for rnbd-srv
Date:   Fri,  2 Sep 2022 18:00:52 +0800
Message-Id: <20220902100055.25724-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Pls review if the new added comment in the first patch is appropriate.

Thanks,
Guoqing

V2 changes:

1. modifiy the first one to add comment in rnbd_srv_rdma_ev

Guoqing Jiang (3):
  rnbd-srv: add comment in rnbd_srv_rdma_ev
  rnbd-srv: make process_msg_close returns void
  rnbd-srv: remove redundant setting of blk_open_flags

 drivers/block/rnbd/rnbd-srv-dev.c |  1 -
 drivers/block/rnbd/rnbd-srv.c     | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.31.1


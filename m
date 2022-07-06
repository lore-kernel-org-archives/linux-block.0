Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F9CCA473
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiGFNcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiGFNcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFF1D324
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:31:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ANOrVGr8lf9ADEyyXd+ZvwVSREKsvXne4U+gYfDIRA8=;
        b=GrG9lv2qjsi+V2x8sVSLWxM7N02N3h9pE8IEN8Y34AmsAWNjO6BzB82CS1KS3xnxrrHicL
        bvwf9EPdGvnufI2oj7gLxUFuXOEuDLao/uvMofuzIxaZA12VJr1Tal+Iv9P1I8AkXegsvp
        P3UqQWWKb6QklG90SmzZxpMzLIH8wSs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 0/8] reduce the size of rnbd_clt_dev
Date:   Wed,  6 Jul 2022 21:31:44 +0800
Message-Id: <20220706133152.12058-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Could you apply the series for rnbd?  Jinpu has acked all the patches. 

Thanks,
Guoqing

Changes since V1:
1. add more Acked-by tags from Jinpu, thanks!

Changes since RFC:

1. Fix one mistake in the last patch of RFC version, and split it to
   three patches.

2. Collect Acked-by tags from Jinpu.

Guoqing Jiang (8):
  rnbd-clt: open code send_msg_open in rnbd_clt_map_device
  rnbd-clt: don't free rsp in msg_open_conf for map scenario
  rnbd-clt: kill read_only from struct rnbd_clt_dev
  rnbd-clt: reduce the size of struct rnbd_clt_dev
  rnbd-clt: adjust the layout of struct rnbd_clt_dev
  rnbd-clt: check capacity inside rnbd_clt_change_capacity
  rnbd-clt: pass sector_t type for resize capacity
  rnbd-clt: make rnbd_clt_change_capacity return void

 drivers/block/rnbd/rnbd-clt-sysfs.c |   2 +-
 drivers/block/rnbd/rnbd-clt.c       | 201 ++++++++++++++++------------
 drivers/block/rnbd/rnbd-clt.h       |  18 +--
 3 files changed, 123 insertions(+), 98 deletions(-)

-- 
2.31.1


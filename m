Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B01AC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiFWGV7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFWGVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:21:54 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EF3F898
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:21:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UGUnJhBvAGm35QIca0RfxsknmoAC+REPB+gChlONCMs=;
        b=tYXJ+GFfs9rpmDjvzc9KO9w6ms0dz9LTOU+rFm69lkTuxkre9ZHf0HGQW38/fhr1qKpQI5
        IO/rarPM3fIstiNspVLgws7ySPdhKMPlgV2o80w6LrjihxWqACE2tgTUZHipm2XEwoI+yi
        uWZHjSlfWVX5GRYMc8oaq/Nfs9F63Nc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 0/8] reduce the size of rnbd_clt_dev
Date:   Thu, 23 Jun 2022 14:21:08 +0800
Message-Id: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@suse.com>

Changes since RFC:

1. Fix one mistake in the last patch of RFC version, and split it to
   three patches.

2. Collect Acked-by tags from Jinpu.

Hi,

The struct rnbd_clt_dev added some members (wc, fua and max_hw_sectors
etc) which are used to set up gendisk and request_queue, but seems only
map scenario need to setup them since rnbd_client_setup_device is not
called from remap path.

Previously, pahole reports.

	/* size: 272, cachelines: 5, members: 29 */
	/* sum members: 259, holes: 4, sum holes: 13 */
	/* last cacheline: 16 bytes */

After the series, it changes to

	/* size: 224, cachelines: 4, members: 17 */
	/* last cacheline: 32 bytes */

Please review.

Thanks,
Guoqing

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
2.34.1


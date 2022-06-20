Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E8C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiFTDuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiFTDt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:49:58 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA5BE2D
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:49:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655696993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wWF6j6Z7aKPoh5g45YVU/T0cwmMES6mgGrm9PLHghZQ=;
        b=kqpBoBQ+E6VLamj96CHh5XsfYt4QiZ8Hoe83jQXUpMg0SDTnRFTGYG8N1ssJLN5PD1GBQ3
        24x5r5Vi7TYmfmjcXJeczFSK5SrgJ52WDCn4qH2a5ac/o/lm9vX/FI6DYIo+o1fZW1O8Do
        47yxegkU8DGmVvlJody9aM93msknuek=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 0/6] reduce the size of rnbd_clt_dev
Date:   Mon, 20 Jun 2022 11:49:17 +0800
Message-Id: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

Guoqing Jiang (6):
  rnbd-clt: open code send_msg_open in rnbd_clt_map_device
  rnbd-clt: don't free rsp in msg_open_conf for map scenario
  rnbd-clt: kill read_only from struct rnbd_clt_dev
  rnbd-clt: reduce the size of struct rnbd_clt_dev
  rnbd-clt: adjust the layout of struct rnbd_clt_dev
  rnbd-clt: refactor rnbd_clt_change_capacity

 drivers/block/rnbd/rnbd-clt-sysfs.c |   2 +-
 drivers/block/rnbd/rnbd-clt.c       | 202 +++++++++++++++++-----------
 drivers/block/rnbd/rnbd-clt.h       |  18 +--
 3 files changed, 124 insertions(+), 98 deletions(-)

-- 
2.34.1


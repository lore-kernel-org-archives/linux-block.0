Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9CC73C66
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A54720645
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="blsfSutx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfGKRx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:53:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53237 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867712; x=1594403712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gWfetoeiKPzHdzvdliRZb0O5EwrxdvdVo+6ayJ+HVq4=;
  b=blsfSutxdaudBptF8+DOs7an4+yK4cZZBmjJFkWIZoAP4CtBXpUFdoDv
   I0oKq9BQ2oYBmMI2y2tkdXqyeJoGWkwei5lbPP4bp8qoHgmoYjrTu5axO
   iy0uJhPJCXIV1SQB5l4glEL/2EE78QzPilU9O8qjXOceg2n+CGw0wIvm6
   TUf7UZLVEe6bKisUulbyTJGU0YdkxozZKEHJQPdhNqs9ScS2RZ1ItKxab
   N0MZWdyUAkylVO1um0sC6hoszOgx74aUcnKm4I6FXwMFJMIYOT0vJDR9c
   4MVd4m6CRLASEam3C4mrDKV9/UkVqBKZGdjkzHS+ucaDbcHvh5APUS7bX
   Q==;
IronPort-SDR: 8xNu9M0XGHeOlUdHcJdlBKl8YOWZ4d0SddHGp5wzlNPaP+XZV67AGdgxwxzweRyPHPHYe8q5yS
 1P72mHdEzmrUT57+HIi6dF+IgJ7ppqko7RPu+cJmtml8VzqJ5Pdpk0Tfu1qfEv3VZppXu3YctD
 /RhFdeSyYKbggOLILFgXUUK8gP8ghhK7GCuSTZp4e0P4xnXl97xZl4LqBJuo7uD0zP84u9m/z0
 eEbqQ6D78aIeAzH/lQT/rY0vbSFuqHKx7B+UAcvViA8E1LO/Tkn5VTMsj64kYHeTA3uEJa+ben
 dXI=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="212743405"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:55:12 +0800
IronPort-SDR: agCcj3Wu1ZwEJHZiA/yD6KCrNvbx5L1LrJI7E4AXKT8l08Sv7eiTAXanSvCZvGi4UlMSBhfDlq
 OwtceuYzlTgCzBqmlIbSZyQ7irH9DWU3Pq+gjgbLDvJM1gO2o98TTWnvKd49FwgnDM2vx30PIK
 G57m9zswo6LwY8Kc223h3qajZ3AG1ztL8yXurMYB1XM2JVh6fK0wRtYsAao/iVr9HEx0fdK2Rm
 cUpMnI3t6dpyhcqwPJhwqsK2RnPHY5QhC6jd+ZkFGLpXFwHeECJhWvgTSCSL6iS3d9hH8u5Yb5
 yUtdstfdElwH5D9xqsYqLiNK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:52:32 -0700
IronPort-SDR: UPnRcSkmbyKysCRsHnaGx6AiVRdnEmpTunped8mvb7gl93NOXyj78HwCLfipHsX8rpuPIUvLIl
 18e4WOq4KALXdJkENtsyoaB3DBf4JVHAFheE9S2asSPUyDOnBYc2+JVaOrx9G+fwrzUdV2Id7i
 gI+cVXXn3xvSuXt/5JDX+vq/f59SICySnmnc6+bAyjlqo29KbXO0m7KdIo4ZLrwypwqdWeIUUU
 dIiVhlK/EHbzWX+ndcvKMUg4DjL9Od18k5SKDUDNHHhwGHmv3cKYBTnS+0y/PBnA3JrzZaG0wD
 mOA=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:53:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/8] null_blk: add REQ_OP_WRITE_ZEROES config property
Date:   Thu, 11 Jul 2019 10:53:22 -0700
Message-Id: <20190711175328.16430-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch for implementing the support for the
write-zeroes operations for null_blk. We introduce a new bool flag
write-zeroes for nullb_device structure so that user can either set
this value through configfs when null_blk is memory backed or use
module parameter. Following two patches are implementing respective
support for REQ_OP_WRITE_ZEROES.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..ecd1e45f6eb9 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -63,6 +63,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 };
 
-- 
2.17.0


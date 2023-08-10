Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43DCC001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 12:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHJMoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjHJMoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 08:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373AC5
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691671418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5nHhiDf04/2JvfQH3W9Tc4xrbKsa9jPPInUGHerePM=;
        b=JJ0yhgLescbQvhC+1ctQ7tMzjfrIaYRC3mBFnsiUJ5uUbv+UX4BUBn6qCIggnRKxn0G/Mx
        9PPx+StXBSl21GHZ/M5lSsqR+ONyk/ug3jDvU/7+SsV/HukGIEnb3oVyPSmNvrIeRX2a7Q
        rPVgufdcPAvSjvtYUg0rGMN2rn3UpWA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-e9lvRQQIOYy8cbBl25JCqg-1; Thu, 10 Aug 2023 08:43:33 -0400
X-MC-Unique: e9lvRQQIOYy8cbBl25JCqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A89C38210AC;
        Thu, 10 Aug 2023 12:43:33 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92AD2C15BAE;
        Thu, 10 Aug 2023 12:43:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Date:   Thu, 10 Aug 2023 20:43:26 +0800
Message-Id: <20230810124326.321472-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everything
is actually handled in userspace, not mention it is pretty easy to support
RESET_ALL.

So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.

Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
libublk-rs based ublk-zoned target prototype[2], follows command line
for creating ublk-zoned:

	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE

[1] https://github.com/westerndigitalcorporation/libzbc
[2] https://github.com/ming1/libublk-rs/tree/zoned.v2

Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- update comment as reported by Niklas

 drivers/block/ublk_drv.c      | 7 +++++--
 include/uapi/linux/ublk_cmd.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b60394fe7be6..3650ef209344 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -251,6 +251,7 @@ static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
 	const struct ublk_param_zoned *p = &ub->params.zoned;
 
 	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
 	blk_queue_required_elevator_features(ub->ub_disk->queue,
 					     ELEVATOR_F_ZBD_SEQ_WRITE);
 	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
@@ -393,6 +394,9 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	case REQ_OP_ZONE_APPEND:
 		ublk_op = UBLK_IO_OP_ZONE_APPEND;
 		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		ublk_op = UBLK_IO_OP_ZONE_RESET_ALL;
+		break;
 	case REQ_OP_DRV_IN:
 		ublk_op = pdu->operation;
 		switch (ublk_op) {
@@ -404,9 +408,8 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		default:
 			return BLK_STS_IOERR;
 		}
-	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_DRV_OUT:
-		/* We do not support reset_all and drv_out */
+		/* We do not support drv_out */
 		return BLK_STS_NOTSUPP;
 	default:
 		return BLK_STS_IOERR;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 2685e53e4752..b9cfc5c96268 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -245,6 +245,7 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_OP_ZONE_CLOSE		11
 #define		UBLK_IO_OP_ZONE_FINISH		12
 #define		UBLK_IO_OP_ZONE_APPEND		13
+#define		UBLK_IO_OP_ZONE_RESET_ALL	14
 #define		UBLK_IO_OP_ZONE_RESET		15
 /*
  * Construct a zone report. The report request is carried in `struct
-- 
2.40.1


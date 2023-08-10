Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CBC001DE
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 09:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHJJ3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHJJ3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 05:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3B358A
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691659270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lhNQLPUJ85QAf1tS1OrHD5VhTxTxA0Vl6FVyR0YDnXo=;
        b=LGoLVKeDPGV/rW++yyT3DQbxY/rfvmujwiBEvS1XbhEqXioALZ1ab2Pw9VtDQTviuuqPnC
        KhoFguD2DtUw70mEUg8woKJBE7UwB8t+NtfPemGDJefOjLx/RyP5e+Fs0M/1bKgRv+R2uJ
        Ob8yB3QtJUiJIvuhAZvtpV8/xOqMmKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-womHmhPePKapHsoUB7gt0w-1; Thu, 10 Aug 2023 05:21:09 -0400
X-MC-Unique: womHmhPePKapHsoUB7gt0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12CB580556B;
        Thu, 10 Aug 2023 09:21:09 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 395A45CBFF;
        Thu, 10 Aug 2023 09:21:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Date:   Thu, 10 Aug 2023 17:20:57 +0800
Message-Id: <20230810092057.288220-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 5 ++++-
 include/uapi/linux/ublk_cmd.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 109a5b17537d..939e4584485b 100644
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
@@ -404,7 +408,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		default:
 			return BLK_STS_IOERR;
 		}
-	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_DRV_OUT:
 		/* We do not support reset_all and drv_out */
 		return BLK_STS_NOTSUPP;
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


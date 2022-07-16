Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB533C43334
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiGPJyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jul 2022 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGPJyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 05:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BB76DFC2
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657965249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BYm7Wq06epmbPBfN/dzQBhuSy+vcO07Mx6d5oKR5bKw=;
        b=UHJ9DrgVVN+XKF4pYEPrJCZ5aumiXl8I4ph5ernT1lwFcB/v+FZ9fl/SHvr1EVgNe/vs3f
        hmvk5NrrcQkM94m2d7pR+ftCQcFTGVnfV4Tq4ZEFzY7BNFIubDkyMEMopVlj9c5bqQR5+x
        0PFZV8J4ROfQY9yZ3d+aGoOGkRbuj84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-nQCBGuGhPg24iBUfhAiBkw-1; Sat, 16 Jul 2022 05:53:55 -0400
X-MC-Unique: nQCBGuGhPg24iBUfhAiBkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DF76101A54E;
        Sat, 16 Jul 2022 09:53:55 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37DC0400DC12;
        Sat, 16 Jul 2022 09:53:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ublk_drv: fix build warning with -Wmaybe-uninitialized and one sparse warning
Date:   Sat, 16 Jul 2022 17:53:44 +0800
Message-Id: <20220716095344.222674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After applying -Wmaybe-uninitialized manually, two build warnings are
triggered:

drivers/block/ublk_drv.c:940:11: warning: ‘io’ may be used uninitialized [-Wmaybe-uninitialized]
  940 |         io->flags &= ~UBLK_IO_FLAG_ACTIVE;

drivers/block/ublk_drv.c: In function ‘ublk_ctrl_uring_cmd’:
drivers/block/ublk_drv.c:1531:9: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]

Fix the 1st one by removing 'io->flags &= ~UBLK_IO_FLAG_ACTIVE;' which
isn't needed since the function always return successfully after setting
this flag.

Fix the 2nd one by always initializing 'ret'.

Also fix another sparse warning of 'sparse: sparse: incorrect type in return
expression' by changing return type of ublk_setup_iod().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f10c4319dc1f..2c1b01d7f27d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -407,7 +407,7 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 	return flags;
 }
 
-static int ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
+static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
@@ -937,7 +937,6 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 
  out:
-	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
 	io_uring_cmd_done(cmd, ret, 0);
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
@@ -1299,13 +1298,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	struct ublk_device *ub;
 	unsigned long queue;
 	unsigned int retlen;
-	int ret;
+	int ret = -EINVAL;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
 		goto out;
 
-	ret = -EINVAL;
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
 		goto out;
-- 
2.36.1


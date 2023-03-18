Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB056C61DA4
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 14:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCRONl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRONl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 10:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C390172C
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679148772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OvggNSCr1Gn3k/pheeQJfbvBfPsIDrOFN3nwYV7717Y=;
        b=aEyUwQFK6/9la3bbf8TKi1TRWbA9zuOleKrev7oZaBPa6stZN2KkrH9ZKjPi/5jkJdopJ5
        NXMjfoqgCQhtyUayhzFCoiu8+BA/aQDeBIgRlMstcQP6ee4tt8kImhck3+l0n1MyxxPB0p
        M4t9ClMFylKoAy0srjpIGp0i1nK4M9s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-hheHsVY0Mt66BNIlaMCQMQ-1; Sat, 18 Mar 2023 10:12:48 -0400
X-MC-Unique: hheHsVY0Mt66BNIlaMCQMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 022D43C02526;
        Sat, 18 Mar 2023 14:12:48 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC84C15BA0;
        Sat, 18 Mar 2023 14:12:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH] block: ublk_drv: mark device as LIVE before adding disk
Date:   Sat, 18 Mar 2023 22:12:31 +0800
Message-Id: <20230318141231.55562-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

IO can be started before add_disk() returns, such as reading parititon table,
then the monitor work should work for making forward progress.

So mark device as LIVE before adding disk, meantime change to
DEAD if add_disk() fails.

Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1d1c8d606c8..fb5a557afde8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1602,17 +1602,18 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
 	get_device(&ub->cdev_dev);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	ret = add_disk(disk);
 	if (ret) {
 		/*
 		 * Has to drop the reference since ->free_disk won't be
 		 * called in case of add_disk failure.
 		 */
+		ub->dev_info.state = UBLK_S_DEV_DEAD;
 		ublk_put_device(ub);
 		goto out_put_disk;
 	}
 	set_bit(UB_STATE_USED, &ub->state);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
 out_put_disk:
 	if (ret)
 		put_disk(disk);
-- 
2.39.2


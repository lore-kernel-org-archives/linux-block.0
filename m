Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C37C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 09:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiG3J2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiG3J2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 05:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F4C422C5
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659173328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwXbW4VfHh0qbojsAedX37LpDSuN/fEwCHPk8uxhM8A=;
        b=ET6cxdZSXVAfRaF8pH8g3Rf7FqFBPPC+PiyfE+8e/SBG2j+fZDCm9L4l11sC4F1H+4PPaX
        LJzWae/xt0NAblTWPymbfjB0UIJZ1avk/1JzJqfu1q6Yig9jkUJI0moeCCvzsUWKKoDfgf
        fZZYvKDwwNHDr8SRCihhyI+hg7dbxtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-zLxXa5c5Mhq46Mi5F0_Fvg-1; Sat, 30 Jul 2022 05:28:41 -0400
X-MC-Unique: zLxXa5c5Mhq46Mi5F0_Fvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D953802D1C;
        Sat, 30 Jul 2022 09:28:41 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFA8E18EBB;
        Sat, 30 Jul 2022 09:28:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/4] ublk_drv: fix ublk device leak in case that add_disk fails
Date:   Sat, 30 Jul 2022 17:27:48 +0800
Message-Id: <20220730092750.1118167-3-ming.lei@redhat.com>
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->free_disk is only called after disk is added successfully, so
drop ublk device reference in case of add_disk() failure.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7ece4c2ef062..ae98e81b21ce 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1190,6 +1190,11 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
+		/*
+		 * Has to drop the reference since ->free_disk won't be
+		 * called in case of add_disk failure.
+		 */
+		ublk_put_device(ub);
 		put_disk(disk);
 		goto out_unlock;
 	}
-- 
2.31.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777EFCD13D2
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 04:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjIREN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjIREM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 00:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1184124
        for <linux-block@vger.kernel.org>; Sun, 17 Sep 2023 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695010301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ek6c8oKP7WrCCE1Di4TBl2jO8h2lwVhBOJLN+tp+jLk=;
        b=R5t+9UYMO89lSNnsoKdh7le15vuhaDolOvxruSytyOw1/Kec2QqZKoKHd2BhozTMoQ6B8X
        AFXyjFfydX+M8sDc+CnaeG7euQVe3VAeX+hI0XaIycLTFdvjyPFGlg2SkmTKY3W9Fp6B8y
        OYvLZXgoPIwLKqENA58aIKkAzn1Ilys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-0tFN9_eMNoWyqQusowO1og-1; Mon, 18 Sep 2023 00:11:36 -0400
X-MC-Unique: 0tFN9_eMNoWyqQusowO1og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FF38945922;
        Mon, 18 Sep 2023 04:11:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 963F02026D4B;
        Mon, 18 Sep 2023 04:11:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/10] ublk: don't get ublk device reference in ublk_abort_queue()
Date:   Mon, 18 Sep 2023 12:11:00 +0800
Message-Id: <20230918041106.2134250-5-ming.lei@redhat.com>
In-Reply-To: <20230918041106.2134250-1-ming.lei@redhat.com>
References: <20230918041106.2134250-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ublk_abort_queue() is called in ublk_daemon_monitor_work(), in which
it is guaranteed that ublk device is live, so no need to get the device
reference.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 630ddfe6657b..9b3c0b3dd36e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1419,9 +1419,6 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
-	if (!ublk_get_device(ub))
-		return;
-
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
@@ -1437,7 +1434,6 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 				__ublk_fail_req(ubq, io, rq);
 		}
 	}
-	ublk_put_device(ub);
 }
 
 static void ublk_daemon_monitor_work(struct work_struct *work)
-- 
2.40.1


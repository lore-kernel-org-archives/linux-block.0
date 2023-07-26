Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACAAC001DE
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGZOqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjGZOqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E60CE
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzPn9kjJ2sLrhg6DwcaiHx5NwaC6b4GYbmK1EY48ANQ=;
        b=bvlHV3eAAs8TgXq32nBblB57T7BEn0fT1aJqXiXqe/wev0BNmhQ1p7m8Lcn6aT3I79kDih
        sr01kCJ0tJTokGf3/+vdXtCOFLqx+c4ic8QHN3/9PZosx80bNL1S1hzOlOOvdsqCROUqFQ
        ACBF//AVYJO8hDPzcGaIqCVj24x/2a8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-UcG2JuzlN9CsMZB9bjwJnw-1; Wed, 26 Jul 2023 10:45:24 -0400
X-MC-Unique: UcG2JuzlN9CsMZB9bjwJnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A8191C05AAC;
        Wed, 26 Jul 2023 14:45:24 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46B00492C13;
        Wed, 26 Jul 2023 14:45:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        German Maglione <gmaglione@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV
Date:   Wed, 26 Jul 2023 22:45:02 +0800
Message-Id: <20230726144502.566785-4-ming.lei@redhat.com>
In-Reply-To: <20230726144502.566785-1-ming.lei@redhat.com>
References: <20230726144502.566785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If user interrupts wait_event_interruptible() in ublk_ctrl_del_dev(),
return -EINTR and let user know what happens.

Fixes: 0abe39dec065 ("block: ublk: improve handling device deletion")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9fcba3834e8d..21d2e71c5514 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2126,8 +2126,8 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 	 * - the device number is freed already, we will not find this
 	 *   device via ublk_get_device_from_id()
 	 */
-	wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx));
-
+	if (wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
+		return -EINTR;
 	return 0;
 }
 
-- 
2.40.1


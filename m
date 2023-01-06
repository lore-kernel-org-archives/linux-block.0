Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E23C4708D
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 04:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAFESS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFESP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 23:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713DDFB8
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 20:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672978648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E6HIdsieVku2uuhEs2eMqSIPEoD7XaXdS0GSeBB2dM=;
        b=VBXlOaIOntXxe+9PV1mH+7ejlkPdsRWeHlDLBY3GWSdQyQX8DTv5RUTtrtMaQKsz+mQZvX
        ef1Q2FJFdItkPLzNaEaZWJvCyMezxA0b8lBuWqXP/Kkw8R9Fecm46UrWBwgXfiUzCjxm6b
        MW/ZKCjZaIgdVB7r81aK8/mTjPBiQv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-k_SUwQQfPxSzfw_GTZ9pyQ-1; Thu, 05 Jan 2023 23:17:25 -0500
X-MC-Unique: k_SUwQQfPxSzfw_GTZ9pyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83FDB858F09;
        Fri,  6 Jan 2023 04:17:24 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C1AE2166B30;
        Fri,  6 Jan 2023 04:17:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/6] ublk_drv: remove nr_aborted_queues from ublk_device
Date:   Fri,  6 Jan 2023 12:17:06 +0800
Message-Id: <20230106041711.914434-2-ming.lei@redhat.com>
In-Reply-To: <20230106041711.914434-1-ming.lei@redhat.com>
References: <20230106041711.914434-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one uses 'nr_aborted_queues' any more, so remove it.

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 17b677b5d3b2..f1cad20442df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -159,7 +159,6 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
-	atomic_t		nr_aborted_queues;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
-- 
2.31.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B941EC3A59F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 03:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKXDGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKXDGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B4C2878
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669259111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdIPaZi/4OEvJCdwRDsHN3Selt5P6ocdnjCUOkOaLME=;
        b=V6IVcgQtihekkXNAkub1Pdi8t9uVBSJxxg9++p/zC+MFPCPXzetH60xeQ1pkP02jee5LWW
        3u+PGBgAktTOCod57zPnYbkKB3e7K7dNq70U7uY64ngfxAF+OFW2zY6qsbuj0rXL59DLzz
        5iuY3pf0oR/xcmDmVhbrDzeTPfGIGWs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-0I_cy7WAOMutM75G-PF5ew-1; Wed, 23 Nov 2022 22:05:08 -0500
X-MC-Unique: 0I_cy7WAOMutM75G-PF5ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABB85296A606;
        Thu, 24 Nov 2022 03:05:07 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637344EA60;
        Thu, 24 Nov 2022 03:05:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Dan Carpenter <error27@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/6] ublk_drv: remove nr_aborted_queues from ublk_device
Date:   Thu, 24 Nov 2022 11:04:49 +0800
Message-Id: <20221124030454.476152-2-ming.lei@redhat.com>
In-Reply-To: <20221124030454.476152-1-ming.lei@redhat.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
index e9de9d846b73..30db5e5edac4 100644
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


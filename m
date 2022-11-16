Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F78C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 06:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKPGJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiKPGJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 01:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B362673
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 22:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668578935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMFXTtH98yesLJHvhmBYMinkWKcBVUeqAcuzVDSnxdE=;
        b=brYDXZti+ErMpncoY+oNuelSkkQvDz11RmBf+GMVhh7r+t0IOYTCjNQxqowYhCpRdWXKEk
        XQWmXN20MpttdHLF34MfKGkBp55WRUebLYRxHjlVqHr3QFu6W8lzOUFaHx9KtDznsbfLRv
        aJepRNZperO7wBquR3rT/C4WOcxYOPI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-Zc2m6HSyMO2EVO-9Q8Ybhw-1; Wed, 16 Nov 2022 01:08:50 -0500
X-MC-Unique: Zc2m6HSyMO2EVO-9Q8Ybhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FCD729AB3FD;
        Wed, 16 Nov 2022 06:08:50 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5A317595;
        Wed, 16 Nov 2022 06:08:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/6] ublk_drv: remove nr_aborted_queues from ublk_device
Date:   Wed, 16 Nov 2022 14:08:30 +0800
Message-Id: <20221116060835.159945-2-ming.lei@redhat.com>
In-Reply-To: <20221116060835.159945-1-ming.lei@redhat.com>
References: <20221116060835.159945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one uses 'nr_aborted_queues' any more, so remove it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f96cb01e9604..fe997848c1ff 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -161,7 +161,6 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
-	atomic_t		nr_aborted_queues;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
-- 
2.31.1


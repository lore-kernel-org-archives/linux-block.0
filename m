Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50548C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 08:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiDMIuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiDMIue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 04:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D8F84D633
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649839693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TONeNBOzlLsHGQgbGOgTiLe6tBJABMu6in/bEcDq0d0=;
        b=RGX3kre/tMl416SrewFZ4hpPdCBQMc0FqnwX5wQ+clTYBdsL1GAgvkvNt+UKCst5L53/ym
        udC07b7nGYHbF8JZneORYGILhsKLC5wydl1ir6iQe81GGAZY2NVstHCtz5W1EGD/dkss/T
        +qdwjZ7vY2h+UlVrdAMx3QsBzzqRKYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-xAbrCXFaMuSmH2ncmZNP-w-1; Wed, 13 Apr 2022 04:48:12 -0400
X-MC-Unique: xAbrCXFaMuSmH2ncmZNP-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23ED4899ED0;
        Wed, 13 Apr 2022 08:48:12 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 585C454AC93;
        Wed, 13 Apr 2022 08:48:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] block: avoid io timeout in case of sync polled dio
Date:   Wed, 13 Apr 2022 16:48:05 +0800
Message-Id: <20220413084805.1571884-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the bio is marked as POLLED after submission, bio_poll() should be
called for reaping io since there isn't irq for completing the request,
so we can't call into blk_io_schedule() in case that bio_poll() returns
zero.

Also for calling bio_poll(), current->plug has to be flushed out,
otherwise bio may not be issued to driver, and ->bi_cookie won't
be set.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/fops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..17798aa31bf6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -101,11 +101,16 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		bio_set_polled(&bio, iocb);
 
 	submit_bio(&bio);
+	/* flush plug list to make sure that bio is issued */
+	if (bio.bi_opf & REQ_POLLED)
+		blk_flush_plug(current->plug, false);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, NULL, 0))
+		if (bio.bi_opf & REQ_POLLED)
+			bio_poll(&bio, NULL, 0);
+		else
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.31.1


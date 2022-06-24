Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1814CCA473
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiFXOOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiFXOOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 054CC54BCD
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZd8ZfGIAIXuwhNxPrneYy+Xgh0O+64Jd5F6mwGBHds=;
        b=g37zX9wj5T67HCvjjffh2MP2IQPvW4n4ow8y95roBLMKEJeik1XmcHAjDgr9RcVdm9mLbU
        RlwaYeYzvZdtpWGjmARtJXgaCaKgSmUsNiQ3dKZPHGfbAi/byMXo+C57NTITRxeI+kZ0bT
        AaWCTn1Cy/iFrGRyRXuV8G8l0Sih9W8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-zoEkpHRbPgKGcW-y30fSAw-1; Fri, 24 Jun 2022 10:14:40 -0400
X-MC-Unique: zoEkpHRbPgKGcW-y30fSAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A995D2A2AD64;
        Fri, 24 Jun 2022 14:14:39 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B250F10725;
        Fri, 24 Jun 2022 14:14:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5.20 2/4] dm: add new helper for handling dm_io requeue
Date:   Fri, 24 Jun 2022 22:12:53 +0800
Message-Id: <20220624141255.2461148-3-ming.lei@redhat.com>
In-Reply-To: <20220624141255.2461148-1-ming.lei@redhat.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of dm_handle_requeue() for handling dm_io requeue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2b75f1ef7386..a9e5e429c150 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -884,13 +884,11 @@ static int __noflush_suspending(struct mapped_device *md)
 	return test_bit(DMF_NOFLUSH_SUSPENDING, &md->flags);
 }
 
-static void dm_io_complete(struct dm_io *io)
+static void dm_handle_requeue(struct dm_io *io)
 {
-	blk_status_t io_error;
-	struct mapped_device *md = io->md;
-	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
-
 	if (io->status == BLK_STS_DM_REQUEUE) {
+		struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+		struct mapped_device *md = io->md;
 		unsigned long flags;
 		/*
 		 * Target requested pushing back the I/O.
@@ -909,6 +907,15 @@ static void dm_io_complete(struct dm_io *io)
 		}
 		spin_unlock_irqrestore(&md->deferred_lock, flags);
 	}
+}
+
+static void dm_io_complete(struct dm_io *io)
+{
+	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	struct mapped_device *md = io->md;
+	blk_status_t io_error;
+
+	dm_handle_requeue(io);
 
 	io_error = io->status;
 	if (dm_io_flagged(io, DM_IO_ACCOUNTED))
-- 
2.31.1


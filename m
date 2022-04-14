Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 08:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiDNIrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiDNIrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 04:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A99D763535
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649925893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f3UmWTwLzb0GS2SVV2SavmD1XZ3p7xpzqKW1TUrCWCA=;
        b=gV5vvekKaWQujeC1iHtqhxCz2M3L3akG3KIotaJyCLLaD8O+taPySazfNXqCNBsV3Q1O89
        7tnOAQkdpYtXGqTX4yh5qVGo5ZbHleresC0iD93SEYlbBzBqySLu31NN+Hmd+on1iC7nEX
        p/x1HuqNLg6aZp9CTD3Mw+XYaAm1i/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-ofDJOp9nPmSw-edY3pO7Zg-1; Thu, 14 Apr 2022 04:44:50 -0400
X-MC-Unique: ofDJOp9nPmSw-edY3pO7Zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 331891014A61;
        Thu, 14 Apr 2022 08:44:50 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2600942B935;
        Thu, 14 Apr 2022 08:44:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: fix offset/size check in bio_trim()
Date:   Thu, 14 Apr 2022 16:44:43 +0800
Message-Id: <20220414084443.1736850-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unit of bio->bi_iter.bi_size is bytes, but unit of offset/size
is sector.

Fix the above issue in checking offset/size in bio_trim().

Fixes: e83502ca5f1e ("block: fix argument type of bio_trim()")
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- use bio_sectors() as suggested by Christoph

 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index cdd7b2915c53..4259125e16ab 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1598,7 +1598,7 @@ EXPORT_SYMBOL(bio_split);
 void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
 	if (WARN_ON_ONCE(offset > BIO_MAX_SECTORS || size > BIO_MAX_SECTORS ||
-			 offset + size > bio->bi_iter.bi_size))
+			 offset + size > bio_sectors(bio)))
 		return;
 
 	size <<= 9;
-- 
2.31.1


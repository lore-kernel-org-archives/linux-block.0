Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A065BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 14:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356788AbiDLPAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356797AbiDLPAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 11:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D288853A66
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649775507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I1fu2bzLA/KYld3YSKqA6vTcus36PLBCTfXSMNFhqMQ=;
        b=UqP3fxohuNcYfcGf2AacJCMo4byJUxeJ/gRU9ynQeBUgJNBM8Rw0bvPYid4V3PaJJ1NQj8
        G3OzYay5Bao+X3RDdqnuQ9PCuBsSIx200XwNM1YZloAlob1BhlvSJ0lt89Oy8NUCB8kPhn
        5JKSMFgsOKSz8dPb9wKgc/0zGygSIs0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-Nktle_9qMemMFmGP_UsAHA-1; Tue, 12 Apr 2022 10:58:24 -0400
X-MC-Unique: Nktle_9qMemMFmGP_UsAHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4173A1C05B06;
        Tue, 12 Apr 2022 14:58:24 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F105401E2B;
        Tue, 12 Apr 2022 14:58:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: fix offset/size check in bio_trim()
Date:   Tue, 12 Apr 2022 22:58:14 +0800
Message-Id: <20220412145814.1436505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index cdd7b2915c53..7c5dcc352db6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1598,7 +1598,7 @@ EXPORT_SYMBOL(bio_split);
 void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
 	if (WARN_ON_ONCE(offset > BIO_MAX_SECTORS || size > BIO_MAX_SECTORS ||
-			 offset + size > bio->bi_iter.bi_size))
+			 offset + size > bio->bi_iter.bi_size >> 9))
 		return;
 
 	size <<= 9;
-- 
2.31.1


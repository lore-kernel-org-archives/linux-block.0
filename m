Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB9C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AF064E2B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhBBP5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235826AbhBBPzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 10:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612281262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RJALn1A3XyTcFbBye48gyn4DSSWq5WHJtrl3dXqiuvM=;
        b=YrOcnk8y+XG0sUE6OjQZyY7cS9Lf+wgpIygU7GA9AWxP8g0pb3IJ0SBrI+RFiPfgVkWnb7
        6V2lfvPS0PmtKizuN4CSnjAmO3c2mXwUkeR7b7FzCWa9QnsaXyAQqzrXbLvIXBOx+DKxnB
        PCol956h+P9LMdAqyVec1912P7+/UTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-UPJnfWkgOc2PF2IHlvJBtg-1; Tue, 02 Feb 2021 10:54:20 -0500
X-MC-Unique: UPJnfWkgOc2PF2IHlvJBtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240B08162B;
        Tue,  2 Feb 2021 15:54:19 +0000 (UTC)
Received: from localhost (ovpn-12-169.pek2.redhat.com [10.72.12.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6172A60C6B;
        Tue,  2 Feb 2021 15:54:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: fix memory leak of bvec
Date:   Tue,  2 Feb 2021 23:54:10 +0800
Message-Id: <20210202155410.875745-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_init() clears bio instance, so the bvec index has to be set after
bio_init(), otherwise bio->bi_io_vec may be leaked.

Fixes: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index d4375619348c..757fee46cefc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -482,8 +482,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 		if (unlikely(!bvl))
 			goto err_free;
 
-		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
 		bio_init(bio, bvl, bvec_nr_vecs(idx));
+		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
 	} else if (nr_iovecs) {
 		bio_init(bio, bio->bi_inline_vecs, BIO_INLINE_VECS);
 	} else {
-- 
2.29.2


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF44C433E6
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6D21D1B
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgL3AfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 19:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3AfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 19:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VP8a2VlxGGbQGWLGsxRM/Fcv0ugMBCdYda3ECfGy/j8=;
        b=Lkbz51yi8ddj/gJ+CLTjywZ7WSRVMNL8UJyb8KfX65NraydCmV7sQpMc/yGZEYimaSxByR
        Hx/8dgUUaU4YA5XEMAnkAa4IiNnpSr+k9+dRtW/tlOYzApwjDB8gO0p5XN2hlTJ0rYN//L
        jbaSH+fe1UEkjLtReSsgiPm+YBQi9kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-oHE_waVeNpW7LsuJ_Z4c_Q-1; Tue, 29 Dec 2020 19:33:32 -0500
X-MC-Unique: oHE_waVeNpW7LsuJ_Z4c_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846469CC03;
        Wed, 30 Dec 2020 00:33:31 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA72C5D9C2;
        Wed, 30 Dec 2020 00:33:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] block: move three bvec helpers declaration into private helper
Date:   Wed, 30 Dec 2020 08:32:54 +0800
Message-Id: <20201230003255.3450874-6-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_alloc(), bvec_free() and bvec_nr_vecs() are only used inside block
layer core functions, no need to declare them in public header.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h         | 4 ++++
 include/linux/bio.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..ac60f5024d6f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,6 +55,10 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
 
+extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
+extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
+extern unsigned int bvec_nr_vecs(unsigned short idx);
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f606eb1e556f..70914dd6a70d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -478,9 +478,6 @@ static inline void zero_fill_bio(struct bio *bio)
 	zero_fill_bio_iter(bio, bio->bi_iter);
 }
 
-extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
-extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
-extern unsigned int bvec_nr_vecs(unsigned short idx);
 extern const char *bio_devname(struct bio *bio, char *buffer);
 
 #define bio_set_dev(bio, bdev) 			\
-- 
2.28.0


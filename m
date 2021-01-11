Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F44C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B1224B8
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAKDIK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbhAKDII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 22:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610334402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOHxdfOHs06LTIDjtmlBiJmm7Y/Tz8Nenrxf6H6MFj4=;
        b=DQFhG85TT4Vk4q6gH703wuphkmJ8DKLYiT/2y7qQKkBvLi2AhQmH9ZsT7girHFT/tBeKfJ
        kliYvXVtfyWp8zcQdLMbxYOSNBXAaDNpYBYUUUW37f6j5BaIIrukw48c2FNuIdCcAxH5hf
        R1g7gxXXI0NF0gpFgaInERbV/IxQ+Ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-Pp4Iw1J8NdqabK740cXMRg-1; Sun, 10 Jan 2021 22:06:39 -0500
X-MC-Unique: Pp4Iw1J8NdqabK740cXMRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0771B801817;
        Mon, 11 Jan 2021 03:06:38 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9478E74440;
        Mon, 11 Jan 2021 03:06:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/6] block: move three bvec helpers declaration into private helper
Date:   Mon, 11 Jan 2021 11:05:56 +0800
Message-Id: <20210111030557.4154161-6-ming.lei@redhat.com>
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_alloc(), bvec_free() and bvec_nr_vecs() are only used inside block
layer core functions, no need to declare them in public header.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h         | 4 ++++
 include/linux/bio.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..a21a35c4a3e4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,6 +55,10 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
 
+struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
+void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
+unsigned int bvec_nr_vecs(unsigned short idx);
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


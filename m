Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202FBC4332B
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0612226A
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgL3Aew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 19:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3Aew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwl6RY+UMRO8wNHf36iDoh5MgKPeUmz1oSOI+tFW2+U=;
        b=IhcYrdoKSC1xUoMsjKtCB+ScUWyvGG5spUehsBVMsbjLfyLMc9inDX5biqS0VumKd1Lb3l
        B8T1nK1IQCg4bf6Gog0CTEsvOCz1fJH4K5KE+O/nN2tzhmxG7b5hEc+WIpGyakAsvh51Oh
        M+2K6La2a4ry4kvZJZZfMsrHN/tnNRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-kuTVC_PtOM6ZzdBL1TLghg-1; Tue, 29 Dec 2020 19:33:23 -0500
X-MC-Unique: kuTVC_PtOM6ZzdBL1TLghg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DFB1800D53;
        Wed, 30 Dec 2020 00:33:22 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3875D6DC;
        Wed, 30 Dec 2020 00:33:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/6] block: don't allocate inline bvecs if this bioset needn't bvecs
Date:   Wed, 30 Dec 2020 08:32:52 +0800
Message-Id: <20201230003255.3450874-4-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The inline bvecs won't be used if user needn't bvecs by not passing
BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 11 +++++++----
 include/linux/bio.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index aa657cdd7c8c..3991a5aab1bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -110,7 +110,7 @@ static void bio_put_slab(struct bio_set *bs)
 {
 	struct bio_slab *bslab = NULL;
 	unsigned int slab_size = bs->front_pad + sizeof(struct bio) +
-		BIO_INLINE_VECS * sizeof(struct bio_vec);
+		bs->back_pad;
 
 	mutex_lock(&bio_slab_lock);
 
@@ -1567,15 +1567,18 @@ int bioset_init(struct bio_set *bs,
 		unsigned int front_pad,
 		int flags)
 {
-	unsigned int back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
-
 	bs->front_pad = front_pad;
 
+	if (flags & BIOSET_NEED_BVECS)
+		bs->back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
+	else
+		bs->back_pad = 0;
+
 	spin_lock_init(&bs->rescue_lock);
 	bio_list_init(&bs->rescue_list);
 	INIT_WORK(&bs->rescue_work, bio_alloc_rescue);
 
-	bs->bio_slab = bio_find_or_create_slab(front_pad + back_pad);
+	bs->bio_slab = bio_find_or_create_slab(bs->front_pad + bs->back_pad);
 	if (!bs->bio_slab)
 		return -ENOMEM;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..f606eb1e556f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -703,6 +703,7 @@ struct bio_set {
 	mempool_t bvec_integrity_pool;
 #endif
 
+	unsigned int back_pad;
 	/*
 	 * Deadlock avoidance for stacking block drivers: see comments in
 	 * bio_alloc_bioset() for details
-- 
2.28.0


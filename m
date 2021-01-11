Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECD0C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8E224B8
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAKDH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAKDHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 22:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610334389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHOBHxHTT8odiwZMIFYYgPzaTLCILFsgpEbmQgSsyfA=;
        b=Y5a2UQssgu9S/nKM0Ky9FXX+obkVFo/o99rQGvmSTWov8S4pxSTabmelcmnt0JZ88Y5L/O
        cH4qpx5IRKmKZKliDP82o7K0xcjug2IV4PNpcpVnUyHZkWBryWl/A5dQRLo2UwSrt9hQrt
        xElqeOnI7ca+eiAL43nxoVntO/WieYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-2sJpQe6KOhm7NTIjDrF7rg-1; Sun, 10 Jan 2021 22:06:25 -0500
X-MC-Unique: 2sJpQe6KOhm7NTIjDrF7rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9879B801817;
        Mon, 11 Jan 2021 03:06:24 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE3751349A;
        Mon, 11 Jan 2021 03:06:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/6] block: don't allocate inline bvecs if this bioset needn't bvecs
Date:   Mon, 11 Jan 2021 11:05:54 +0800
Message-Id: <20210111030557.4154161-4-ming.lei@redhat.com>
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The inline bvecs won't be used if user needn't bvecs by not passing
BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 7 +++++--
 include/linux/bio.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index cfa0e9db30e0..496aa5938f79 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -89,8 +89,7 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 
 static inline unsigned int bs_bio_slab_size(struct bio_set *bs)
 {
-	return bs->front_pad + sizeof(struct bio) +
-		BIO_INLINE_VECS * sizeof(struct bio_vec);
+	return bs->front_pad + sizeof(struct bio) + bs->back_pad;
 }
 
 static struct kmem_cache *bio_find_or_create_slab(struct bio_set *bs)
@@ -1572,6 +1571,10 @@ int bioset_init(struct bio_set *bs,
 		int flags)
 {
 	bs->front_pad = front_pad;
+	if (flags & BIOSET_NEED_BVECS)
+		bs->back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
+	else
+		bs->back_pad = 0;
 
 	spin_lock_init(&bs->rescue_lock);
 	bio_list_init(&bs->rescue_list);
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


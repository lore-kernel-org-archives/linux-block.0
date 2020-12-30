Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A69C43381
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23F420867
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgL3Aem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 19:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgL3Aem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WjdLyAaAr0FpytVCWzRrC/2KcIqYt/yXGKQFnbsWsw=;
        b=NQffrie3fntvS2HrPSL2cGGji19l9bDTT2lHKTRzd29cYHjyj/a5yVSAlirvyXI3TRBtGQ
        l4fu0sv0reJs9zMQKouQMLZ5k8qcpedbdUCSVyaBKjHyS2XYnGEqvspAyh5TFxLcYhfk4C
        W5idJDtnjSvgVMel0msUjv3weE9Da3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-YyOK-boUOLyupfHakJt2iQ-1; Tue, 29 Dec 2020 19:33:13 -0500
X-MC-Unique: YyOK-boUOLyupfHakJt2iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6036E180A089;
        Wed, 30 Dec 2020 00:33:12 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 427E710013C1;
        Wed, 30 Dec 2020 00:33:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/6] block: manage bio slab cache by xarray
Date:   Wed, 30 Dec 2020 08:32:50 +0800
Message-Id: <20201230003255.3450874-2-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Managing bio slab cache via xarray by using slab cache size as xarray index, and
storing 'struct bio_slab' instance into xarray.

So code is simplified a lot, meantime is is more readable than before.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 104 +++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 62 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..aa657cdd7c8c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/xarray.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -58,61 +59,49 @@ struct bio_slab {
 	char name[8];
 };
 static DEFINE_MUTEX(bio_slab_lock);
-static struct bio_slab *bio_slabs;
-static unsigned int bio_slab_nr, bio_slab_max;
+static DEFINE_XARRAY(bio_slabs);
+
+static struct bio_slab *create_bio_slab(unsigned int size)
+{
+	struct bio_slab *bslab = kzalloc(sizeof(*bslab), GFP_KERNEL);
+	if (!bslab)
+		return NULL;
+
+	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
+	bslab->slab = kmem_cache_create(bslab->name, size,
+			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
+	if (bslab->slab) {
+		bslab->slab_ref = 1;
+		bslab->slab_size = size;
+	} else {
+		kfree(bslab);
+		bslab = NULL;
+	}
+	return bslab;
+}
 
 static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 {
 	unsigned int sz = sizeof(struct bio) + extra_size;
 	struct kmem_cache *slab = NULL;
-	struct bio_slab *bslab, *new_bio_slabs;
-	unsigned int new_bio_slab_max;
-	unsigned int i, entry = -1;
+	struct bio_slab *bslab;
 
 	mutex_lock(&bio_slab_lock);
-
-	i = 0;
-	while (i < bio_slab_nr) {
-		bslab = &bio_slabs[i];
-
-		if (!bslab->slab && entry == -1)
-			entry = i;
-		else if (bslab->slab_size == sz) {
+	bslab = xa_load(&bio_slabs, sz);
+	if (bslab) {
+		slab = bslab->slab;
+		bslab->slab_ref++;
+	} else {
+		bslab = create_bio_slab(sz);
+		if(bslab && !xa_err(xa_store(&bio_slabs, sz, bslab,
+						GFP_KERNEL)))
 			slab = bslab->slab;
-			bslab->slab_ref++;
-			break;
+		else {
+			if (bslab)
+				kmem_cache_destroy(bslab->slab);
+			kfree(bslab);
 		}
-		i++;
-	}
-
-	if (slab)
-		goto out_unlock;
-
-	if (bio_slab_nr == bio_slab_max && entry == -1) {
-		new_bio_slab_max = bio_slab_max << 1;
-		new_bio_slabs = krealloc(bio_slabs,
-					 new_bio_slab_max * sizeof(struct bio_slab),
-					 GFP_KERNEL);
-		if (!new_bio_slabs)
-			goto out_unlock;
-		bio_slab_max = new_bio_slab_max;
-		bio_slabs = new_bio_slabs;
 	}
-	if (entry == -1)
-		entry = bio_slab_nr++;
-
-	bslab = &bio_slabs[entry];
-
-	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", entry);
-	slab = kmem_cache_create(bslab->name, sz, ARCH_KMALLOC_MINALIGN,
-				 SLAB_HWCACHE_ALIGN, NULL);
-	if (!slab)
-		goto out_unlock;
-
-	bslab->slab = slab;
-	bslab->slab_ref = 1;
-	bslab->slab_size = sz;
-out_unlock:
 	mutex_unlock(&bio_slab_lock);
 	return slab;
 }
@@ -120,27 +109,26 @@ static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 static void bio_put_slab(struct bio_set *bs)
 {
 	struct bio_slab *bslab = NULL;
-	unsigned int i;
+	unsigned int slab_size = bs->front_pad + sizeof(struct bio) +
+		BIO_INLINE_VECS * sizeof(struct bio_vec);
 
 	mutex_lock(&bio_slab_lock);
 
-	for (i = 0; i < bio_slab_nr; i++) {
-		if (bs->bio_slab == bio_slabs[i].slab) {
-			bslab = &bio_slabs[i];
-			break;
-		}
-	}
-
+	bslab = xa_load(&bio_slabs, slab_size);
 	if (WARN(!bslab, KERN_ERR "bio: unable to find slab!\n"))
 		goto out;
 
+	WARN_ON_ONCE(bslab->slab != bs->bio_slab);
+
 	WARN_ON(!bslab->slab_ref);
 
 	if (--bslab->slab_ref)
 		goto out;
 
+	xa_erase(&bio_slabs, slab_size);
+
 	kmem_cache_destroy(bslab->slab);
-	bslab->slab = NULL;
+	kfree(bslab);
 
 out:
 	mutex_unlock(&bio_slab_lock);
@@ -1651,16 +1639,8 @@ static void __init biovec_init_slabs(void)
 
 static int __init init_bio(void)
 {
-	bio_slab_max = 2;
-	bio_slab_nr = 0;
-	bio_slabs = kcalloc(bio_slab_max, sizeof(struct bio_slab),
-			    GFP_KERNEL);
-
 	BUILD_BUG_ON(BIO_FLAG_LAST > BVEC_POOL_OFFSET);
 
-	if (!bio_slabs)
-		panic("bio: can't allocate bios\n");
-
 	bio_integrity_init();
 	biovec_init_slabs();
 
-- 
2.28.0


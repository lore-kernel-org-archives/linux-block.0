Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD05C433E6
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AA2229F0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbhAEMqU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729268AbhAEMqT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 07:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609850692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agO6BYZemNkLWVbGRmMmpwdINpe6sn2yq73em0ndDn4=;
        b=cmfnRzsu1QMopJRreZXyNjLA/cPUrGnT1YWxBmcuwROnpF4lDMvcBMYFi+lILRFIx+LevZ
        DfyHZMeZ3n1rHPBUCa++kC+s+ht6zgcEhMh+5fuAgWJFCt0c5hEfaBXE+sG7vx2PodDhCf
        pMFECw8BoFyxWG9brLunTFbHI0Y9Ouw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-dCV6KwIJN86S9bbnoN2ykA-1; Tue, 05 Jan 2021 07:42:22 -0500
X-MC-Unique: dCV6KwIJN86S9bbnoN2ykA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 353A4BBF07;
        Tue,  5 Jan 2021 12:42:21 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A639F5D6CF;
        Tue,  5 Jan 2021 12:42:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/6] block: manage bio slab cache by xarray
Date:   Tue,  5 Jan 2021 20:41:58 +0800
Message-Id: <20210105124203.3726599-2-ming.lei@redhat.com>
In-Reply-To: <20210105124203.3726599-1-ming.lei@redhat.com>
References: <20210105124203.3726599-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Managing bio slab cache via xarray by using slab cache size as xarray
index, and storing 'struct bio_slab' instance into xarray.

So code is simplified a lot, meantime it becomes more readable than before.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 114 ++++++++++++++++++++++------------------------------
 1 file changed, 48 insertions(+), 66 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..f72d4783f6c5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/xarray.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -58,89 +59,80 @@ struct bio_slab {
 	char name[8];
 };
 static DEFINE_MUTEX(bio_slab_lock);
-static struct bio_slab *bio_slabs;
-static unsigned int bio_slab_nr, bio_slab_max;
+static DEFINE_XARRAY(bio_slabs);
 
-static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
+static struct bio_slab *create_bio_slab(unsigned int size)
 {
-	unsigned int sz = sizeof(struct bio) + extra_size;
-	struct kmem_cache *slab = NULL;
-	struct bio_slab *bslab, *new_bio_slabs;
-	unsigned int new_bio_slab_max;
-	unsigned int i, entry = -1;
+	struct bio_slab *bslab = kzalloc(sizeof(*bslab), GFP_KERNEL);
 
-	mutex_lock(&bio_slab_lock);
-
-	i = 0;
-	while (i < bio_slab_nr) {
-		bslab = &bio_slabs[i];
+	if (!bslab)
+		return NULL;
 
-		if (!bslab->slab && entry == -1)
-			entry = i;
-		else if (bslab->slab_size == sz) {
-			slab = bslab->slab;
-			bslab->slab_ref++;
-			break;
-		}
-		i++;
+	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
+	bslab->slab = kmem_cache_create(bslab->name, size,
+			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
+	if (!bslab->slab) {
+		kfree(bslab);
+		return NULL;
 	}
 
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
+	bslab->slab_ref = 1;
+	bslab->slab_size = size;
+
+	if (xa_err(xa_store(&bio_slabs, size, bslab, GFP_KERNEL))) {
+		kmem_cache_destroy(bslab->slab);
+		kfree(bslab);
+		return NULL;
 	}
-	if (entry == -1)
-		entry = bio_slab_nr++;
+	return bslab;
+}
 
-	bslab = &bio_slabs[entry];
+static inline unsigned int bs_bio_slab_size(struct bio_set *bs)
+{
+	return bs->front_pad + sizeof(struct bio) +
+		BIO_INLINE_VECS * sizeof(struct bio_vec);
+}
 
-	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", entry);
-	slab = kmem_cache_create(bslab->name, sz, ARCH_KMALLOC_MINALIGN,
-				 SLAB_HWCACHE_ALIGN, NULL);
-	if (!slab)
-		goto out_unlock;
+static struct kmem_cache *bio_find_or_create_slab(struct bio_set *bs)
+{
+	unsigned int size = bs_bio_slab_size(bs);
+	struct bio_slab *bslab;
 
-	bslab->slab = slab;
-	bslab->slab_ref = 1;
-	bslab->slab_size = sz;
-out_unlock:
+	mutex_lock(&bio_slab_lock);
+	bslab = xa_load(&bio_slabs, size);
+	if (bslab)
+		bslab->slab_ref++;
+	else
+		bslab = create_bio_slab(size);
 	mutex_unlock(&bio_slab_lock);
-	return slab;
+
+	if (bslab)
+		return bslab->slab;
+	return NULL;
 }
 
 static void bio_put_slab(struct bio_set *bs)
 {
 	struct bio_slab *bslab = NULL;
-	unsigned int i;
+	unsigned int slab_size = bs_bio_slab_size(bs);
 
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
@@ -1579,15 +1571,13 @@ int bioset_init(struct bio_set *bs,
 		unsigned int front_pad,
 		int flags)
 {
-	unsigned int back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
-
 	bs->front_pad = front_pad;
 
 	spin_lock_init(&bs->rescue_lock);
 	bio_list_init(&bs->rescue_list);
 	INIT_WORK(&bs->rescue_work, bio_alloc_rescue);
 
-	bs->bio_slab = bio_find_or_create_slab(front_pad + back_pad);
+	bs->bio_slab = bio_find_or_create_slab(bs);
 	if (!bs->bio_slab)
 		return -ENOMEM;
 
@@ -1651,16 +1641,8 @@ static void __init biovec_init_slabs(void)
 
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


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FEC76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjC0UO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjC0UO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:26 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E32D44
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:38 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id h16so3008089qtn.7
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS/kygwvcLIIpB3MPZf9iFXCT5/ZQtXgTxSpDCvveGI=;
        b=Eby2HfXlEZwdm1i4OAzfhOSjeJt7Y0jx0gYckqKKZmG5/B3xVphRqxPGzhlUmrj4oG
         gZZLEm6gsK17W2sVUavdzXvebu6J2kauNB6x122vg+PwCljKNnxVayEiDQAL5AFF5HOn
         7sFDm8Rs8gYdchOuxTLTQELIJIODN6BNqYLVm9fzxWxaHxKjqwM06/BCdGXCFXe4rlyp
         Ax+c21clg9rSrxK543Cypf5t2+BFF/601AgiT42NjQXAf21ixlaLX2ftb+ytefTLhMUz
         KWxi6/2eT/OFo299gj7VrKhe0SVjJnD53Fo4qhf/eEmmAlLUsqFd6UwuO6acE2VX9oHa
         tBAg==
X-Gm-Message-State: AO0yUKUYpIrrHu+1Mwv/WlSQVdwZQmFv6tgCuH4VF89UY7BhIIm7oAfa
        88VjrsZkh5uZpk5tRon3GuWT
X-Google-Smtp-Source: AK7set9gY+NOfaP2EPxXeQTEmFaMokIIbBlTZWwiEUt/LmRMwCYwgGOWnXBndmFgQ57KlO5UkZnONg==
X-Received: by 2002:a05:622a:1d3:b0:3e3:87a2:e7f5 with SMTP id t19-20020a05622a01d300b003e387a2e7f5mr20519135qtw.11.1679948018387;
        Mon, 27 Mar 2023 13:13:38 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 207-20020a3703d8000000b007468ec2e5dcsm10816449qkd.87.2023.03.27.13.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:38 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 19/20] dm bio prison v1: prepare to intelligently size dm_bio_prison's prison_regions
Date:   Mon, 27 Mar 2023 16:11:42 -0400
Message-Id: <20230327201143.51026-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add num_locks member to dm_bio_prison struct and use it rather than
the NR_LOCKS magic value (64).

Next commit will size the dm_bio_prison's prison_regions according to
dm_num_sharded_locks().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bio-prison-v1.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index 78bb559b521c..a7930ad1878b 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -17,7 +17,6 @@
 /*----------------------------------------------------------------*/
 
 #define NR_LOCKS 64
-#define LOCK_MASK (NR_LOCKS - 1)
 #define MIN_CELLS 1024
 
 struct prison_region {
@@ -26,8 +25,9 @@ struct prison_region {
 } ____cacheline_aligned_in_smp;
 
 struct dm_bio_prison {
-	struct prison_region regions[NR_LOCKS];
 	mempool_t cell_pool;
+	unsigned int num_locks;
+	struct prison_region regions[NR_LOCKS];
 };
 
 static struct kmem_cache *_cell_cache;
@@ -46,8 +46,9 @@ struct dm_bio_prison *dm_bio_prison_create(void)
 
 	if (!prison)
 		return NULL;
+	prison->num_locks = NR_LOCKS;
 
-	for (i = 0; i < NR_LOCKS; i++) {
+	for (i = 0; i < prison->num_locks; i++) {
 		spin_lock_init(&prison->regions[i].lock);
 		prison->regions[i].cell = RB_ROOT;
 	}
@@ -115,9 +116,9 @@ static int cmp_keys(struct dm_cell_key *lhs,
 	return 0;
 }
 
-static unsigned lock_nr(struct dm_cell_key *key)
+static unsigned lock_nr(struct dm_cell_key *key, unsigned int num_locks)
 {
-	return (key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) & LOCK_MASK;
+	return (key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) & (num_locks - 1);
 }
 
 bool dm_cell_key_has_valid_range(struct dm_cell_key *key)
@@ -176,7 +177,7 @@ static int bio_detain(struct dm_bio_prison *prison,
 		      struct dm_bio_prison_cell **cell_result)
 {
 	int r;
-	unsigned l = lock_nr(key);
+	unsigned l = lock_nr(key, prison->num_locks);
 
 	spin_lock_irq(&prison->regions[l].lock);
 	r = __bio_detain(&prison->regions[l].cell, key, inmate, cell_prealloc, cell_result);
@@ -224,7 +225,7 @@ void dm_cell_release(struct dm_bio_prison *prison,
 		     struct dm_bio_prison_cell *cell,
 		     struct bio_list *bios)
 {
-	unsigned l = lock_nr(&cell->key);
+	unsigned l = lock_nr(&cell->key, prison->num_locks);
 
 	spin_lock_irq(&prison->regions[l].lock);
 	__cell_release(&prison->regions[l].cell, cell, bios);
@@ -247,7 +248,7 @@ void dm_cell_release_no_holder(struct dm_bio_prison *prison,
 			       struct dm_bio_prison_cell *cell,
 			       struct bio_list *inmates)
 {
-	unsigned l = lock_nr(&cell->key);
+	unsigned l = lock_nr(&cell->key, prison->num_locks);
 	unsigned long flags;
 
 	spin_lock_irqsave(&prison->regions[l].lock, flags);
@@ -277,7 +278,7 @@ void dm_cell_visit_release(struct dm_bio_prison *prison,
 			   void *context,
 			   struct dm_bio_prison_cell *cell)
 {
-	unsigned l = lock_nr(&cell->key);
+	unsigned l = lock_nr(&cell->key, prison->num_locks);
 	spin_lock_irq(&prison->regions[l].lock);
 	visit_fn(context, cell);
 	rb_erase(&cell->node, &prison->regions[l].cell);
@@ -301,7 +302,7 @@ int dm_cell_promote_or_release(struct dm_bio_prison *prison,
 			       struct dm_bio_prison_cell *cell)
 {
 	int r;
-	unsigned l = lock_nr(&cell->key);
+	unsigned l = lock_nr(&cell->key, prison->num_locks);
 
 	spin_lock_irq(&prison->regions[l].lock);
 	r = __promote_or_release(&prison->regions[l].cell, cell);
-- 
2.40.0


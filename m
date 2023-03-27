Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7DC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjC0UOc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjC0UOb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:31 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02892129
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:40 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id l7so7670042qvh.5
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQyYjWMmcas91qVtcY8jvp2wBSEYoGBjkcnNGzLUcAg=;
        b=ag7EmRvTXsRG5wNkya8nPzToIkGtjT92iacdQeW6vDZt/5arl450KClfiHZv/wJC82
         5oUYfn4ZZKZpD40nJA3wpK+FPEa83pMctFJvdi88QQa/LmdNqdgdEMOnDq1ZkrdW+Gyz
         BBpkIBvePeqbEDgVP+GrYeeORgVciegdfPvrmVpFI36WhW2SEDengnrcH8lW2VfPhxTX
         owip9xM8e/9+TRlMXz+Us8jYZvIhdhMs//7zP7oEKsyiBpi1OVg+peLgorTwebNUV1JG
         6Z5ne/N/YZJMd313UnBauqFyyoxylFFKLn1YRmMTLbaEOY3Kc4xbmn+mqCSJrPYx5osK
         9OOQ==
X-Gm-Message-State: AAQBX9f3gZcJR/m5skDXe1vGqwRkxyr9CkDV0WEv6FhxbsdPz1K9KjY8
        DKXt7RGPC67Ue95HiEoqcsb1
X-Google-Smtp-Source: AKy350aUOhS5a7pfiFoOC/vCDrOmXamVaEKNC4KXqyNQGje3o8Ci+KX+zebywjT0o5kNzZBKf3poOw==
X-Received: by 2002:a05:6214:2aa6:b0:56c:376:3191 with SMTP id js6-20020a0562142aa600b0056c03763191mr21114410qvb.44.1679948019857;
        Mon, 27 Mar 2023 13:13:39 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a8-20020a0ce908000000b005dd8b9345a3sm3224293qvo.59.2023.03.27.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:39 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 20/20] dm bio prison v1: intelligently size dm_bio_prison's prison_regions
Date:   Mon, 27 Mar 2023 16:11:43 -0400
Message-Id: <20230327201143.51026-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Size the dm_bio_prison's number of prison_region structs using
dm_num_sharded_locks().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bio-prison-v1.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index a7930ad1878b..1d560a83b144 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -16,7 +16,6 @@
 
 /*----------------------------------------------------------------*/
 
-#define NR_LOCKS 64
 #define MIN_CELLS 1024
 
 struct prison_region {
@@ -27,7 +26,7 @@ struct prison_region {
 struct dm_bio_prison {
 	mempool_t cell_pool;
 	unsigned int num_locks;
-	struct prison_region regions[NR_LOCKS];
+	struct prison_region regions[];
 };
 
 static struct kmem_cache *_cell_cache;
@@ -41,12 +40,14 @@ static struct kmem_cache *_cell_cache;
 struct dm_bio_prison *dm_bio_prison_create(void)
 {
 	int ret;
-	unsigned i;
-	struct dm_bio_prison *prison = kzalloc(sizeof(*prison), GFP_KERNEL);
+	unsigned int i, num_locks;
+	struct dm_bio_prison *prison;
 
+	num_locks = dm_num_sharded_locks();
+	prison = kzalloc(struct_size(prison, regions, num_locks), GFP_KERNEL);
 	if (!prison)
 		return NULL;
-	prison->num_locks = NR_LOCKS;
+	prison->num_locks = num_locks;
 
 	for (i = 0; i < prison->num_locks; i++) {
 		spin_lock_init(&prison->regions[i].lock);
-- 
2.40.0


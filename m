Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15372C4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiCWTrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbiCWTrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 665EF8B6FD
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648064734;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=AF9xOLertVL1zPER2DBlMssTlLLbZ7i6J9GUZUZZbT8=;
        b=YJ2SCuEcxGuuvo8BgH1lZ7ZtvyYkFqZk/SItAQRhtbyW3ZmvFC0O/axMkcRFIewbTdFNpf
        3EJH3BGuAP3TnnWYOBtKMWGiX3V19MMLAhhSV9+5wd62Q/jI+zBRW6QxCI8SVRR62t9nYG
        hJmD+litiC6oYuQGzl38HNgyXwQ3vyU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-tQohRMe3Mqy7DRxOxSMH1w-1; Wed, 23 Mar 2022 15:45:33 -0400
X-MC-Unique: tQohRMe3Mqy7DRxOxSMH1w-1
Received: by mail-qt1-f200.google.com with SMTP id y23-20020ac85257000000b002e06697f2ebso1992229qtn.16
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AF9xOLertVL1zPER2DBlMssTlLLbZ7i6J9GUZUZZbT8=;
        b=Q+3Dd8mM64goVuruyrcqLA4VxpJd5Vkj8EYjRxH+VjTDt2mT8AgRkI3kcZjzwrmV9S
         tfAoGFwOuNWVhKVic9fwqTpOXalKNs8sS0tGpS/gPmtpDnv2KtKql8NZnEdOcINpj3Vi
         GYF2rT4Ong2FMzXg+FweKtHnPEGqKoJMm1ovg9nN/SwtIEqt2L6fOrIEMeXOZUWzzibz
         u+Gu7+5pYfnbYVamovo65iYyHrX3p0b9czVybfonCrGbwZRBkBcMt9bVV/cUVmydZC3u
         2MCybWLUjIvolz4GkW0AV8qOR7AsXP3+OBAWodUbxEvGFyUFJiGDzRdQ7CT3WEaCmt6F
         l5BQ==
X-Gm-Message-State: AOAM530lt6vqiPgI6tUdsyefaEgGr6qwJiBGifN0pNauloYNgQjj7Sow
        51ItoETnXvaSciyXQuWP9NoJD5TPb0+RD9uMKZrMy4eczKAHoutqclekgUEAHX0aybLlWmovagy
        33BL0izVXM27jw7oGfK1uHg==
X-Received: by 2002:ad4:5c6f:0:b0:440:cd9b:db9a with SMTP id i15-20020ad45c6f000000b00440cd9bdb9amr1340810qvh.86.1648064732109;
        Wed, 23 Mar 2022 12:45:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGZdV6BdMXLbVGDokSS/YFyydCYRxSjfvid2Egnjd81a3tVo6BqGGKuI+kT/R4KaO8Ehs/6Q==
X-Received: by 2002:ad4:5c6f:0:b0:440:cd9b:db9a with SMTP id i15-20020ad45c6f000000b00440cd9bdb9amr1340794qvh.86.1648064731874;
        Wed, 23 Mar 2022 12:45:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b0067d43d76184sm445886qki.97.2022.03.23.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:31 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 4/4] dm: conditionally enable BIOSET_PERCPU_CACHE for bio-based dm_io bioset
Date:   Wed, 23 Mar 2022 15:45:24 -0400
Message-Id: <20220323194524.5900-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220323194524.5900-1-snitzer@kernel.org>
References: <20220323194524.5900-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bioset's percpu cache may have broader utility in the future but for
now constrain it to being tightly coupled to QUEUE_FLAG_POLL.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c | 11 ++++++++---
 drivers/md/dm.c       |  6 +++---
 drivers/md/dm.h       |  4 ++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index c0be4f60b427..7ebc70e3eb2f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1002,6 +1002,8 @@ bool dm_table_request_based(struct dm_table *t)
 	return __table_type_request_based(dm_table_get_type(t));
 }
 
+static int dm_table_supports_poll(struct dm_table *t);
+
 static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *md)
 {
 	enum dm_queue_mode type = dm_table_get_type(t);
@@ -1009,21 +1011,24 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 	unsigned min_pool_size = 0;
 	struct dm_target *ti;
 	unsigned i;
+	bool poll_supported = false;
 
 	if (unlikely(type == DM_TYPE_NONE)) {
 		DMWARN("no table type is set, can't allocate mempools");
 		return -EINVAL;
 	}
 
-	if (__table_type_bio_based(type))
+	if (__table_type_bio_based(type)) {
 		for (i = 0; i < t->num_targets; i++) {
 			ti = t->targets + i;
 			per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
 			min_pool_size = max(min_pool_size, ti->num_flush_bios);
 		}
+		poll_supported = !!dm_table_supports_poll(t);
+	}
 
-	t->mempools = dm_alloc_md_mempools(md, type, t->integrity_supported,
-					   per_io_data_size, min_pool_size);
+	t->mempools = dm_alloc_md_mempools(md, type, per_io_data_size, min_pool_size,
+					   t->integrity_supported, poll_supported);
 	if (!t->mempools)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b3cb2c1aea2a..ebd7919e555f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2999,8 +2999,8 @@ int dm_noflush_suspending(struct dm_target *ti)
 EXPORT_SYMBOL_GPL(dm_noflush_suspending);
 
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned integrity, unsigned per_io_data_size,
-					    unsigned min_pool_size)
+					    unsigned per_io_data_size, unsigned min_pool_size,
+					    bool integrity, bool poll)
 {
 	struct dm_md_mempools *pools = kzalloc_node(sizeof(*pools), GFP_KERNEL, md->numa_node_id);
 	unsigned int pool_size = 0;
@@ -3016,7 +3016,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_qu
 		pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
 		front_pad = roundup(per_io_data_size, __alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
 		io_front_pad = roundup(per_io_data_size,  __alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
-		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, BIOSET_PERCPU_CACHE);
+		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, poll ? BIOSET_PERCPU_CACHE : 0);
 		if (ret)
 			goto out;
 		if (integrity && bioset_integrity_create(&pools->io_bs, pool_size))
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 9013dc1a7b00..3f89664fea01 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -221,8 +221,8 @@ void dm_kcopyd_exit(void);
  * Mempool operations
  */
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned integrity, unsigned per_bio_data_size,
-					    unsigned min_pool_size);
+					    unsigned per_io_data_size, unsigned min_pool_size,
+					    bool integrity, bool poll);
 void dm_free_md_mempools(struct dm_md_mempools *pools);
 
 /*
-- 
2.15.0


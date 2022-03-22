Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 19:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiCVTvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCVTvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9602850B3D
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647978577;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=CUK36jS7t3ES+pLUUL+mUYA6t3/aGv0zfagQFWZKaXc=;
        b=VbYu36Op4MRg+gN6mblyonlisZID25cBGOLaDOSc4PqttroMWktliZiFOHX3M9i+OAcMUx
        kyATOr5uupCph87/ObiKHyGp2zIQEE8+qNc8s07+6b4lafO2/x/8YwiAkbEUfzB1FnA8hp
        SQTmGyOJHRZucpXVtU/AHYGwzwszeW8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-wtEUbN5LNIK7SQYa8VH-7w-1; Tue, 22 Mar 2022 15:49:34 -0400
X-MC-Unique: wtEUbN5LNIK7SQYa8VH-7w-1
Received: by mail-qk1-f200.google.com with SMTP id 195-20020a3707cc000000b0067b0c849285so12510431qkh.5
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CUK36jS7t3ES+pLUUL+mUYA6t3/aGv0zfagQFWZKaXc=;
        b=Y6WwQZeXAmd1QJTHtXkcFe+kxxGIHGk0YmFG3HmiMz04NvouB01xOgbyDB5sr6DwHb
         VaTTDa+XganJHyu0H3cLJSORa1LV2rrhUEt9qmKqf41+d2BSi4SmUJhVfS7/0LEOWBs1
         AJpfo+AheEYplsw9I4lyZDbrxlBxxrFG8Kf7q9ZCkT4/M7OAKvsuBzVWrTrpEyPFJfFU
         +YS+UNRQRsiVS2RRLoF7zbJOSbhWZBT+sgZGTT+kOOOmk3wurCNo45N5NYAmqNT8V8jY
         b4nxfDI/O9o2nEFa7FV/ueeHyhxQUnhw3IsAa4c1hJPLdk/QRfklIscFcZ2W9t9kFYBr
         fUZg==
X-Gm-Message-State: AOAM530J6Jpm5JtKAZgRiEgllv38jaVnEP6vlM3TJyOIapdcxRVvnUhx
        gz/AFdVfmrXKnhlpcvTE2nVHJv4VME2+mfhqU6U4O+9Rba2ynWlBuaaear444Dj8MpSr6PtnX8D
        3VszAHK7ZU2VXlxRcvyax9w==
X-Received: by 2002:a37:7cd:0:b0:67b:e91:6b01 with SMTP id 196-20020a3707cd000000b0067b0e916b01mr16641569qkh.652.1647978573393;
        Tue, 22 Mar 2022 12:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhGeJC8fKIOscwpW7RkXLopawiBL7yLMjD6LNS9u1yPv2DAClh1WWgit2m17Y/Funlddnw8A==
X-Received: by 2002:a37:7cd:0:b0:67b:e91:6b01 with SMTP id 196-20020a3707cd000000b0067b0e916b01mr16641560qkh.652.1647978573149;
        Tue, 22 Mar 2022 12:49:33 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m23-20020a05620a221700b00649555cd27bsm9635821qkh.79.2022.03.22.12.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:49:32 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] dm: conditionally enable BIOSET_PERCPU_CACHE for bio-based dm_io bioset
Date:   Tue, 22 Mar 2022 15:49:27 -0400
Message-Id: <20220322194927.42778-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220322194927.42778-1-snitzer@kernel.org>
References: <20220322194927.42778-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point establishing the bioset percpu cache if request_queue
won't have QUEUE_FLAG_POLL.

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
index 06f3720a190b..071e7615f153 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2997,8 +2997,8 @@ int dm_noflush_suspending(struct dm_target *ti)
 EXPORT_SYMBOL_GPL(dm_noflush_suspending);
 
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned integrity, unsigned per_io_data_size,
-					    unsigned min_pool_size)
+					    unsigned per_io_data_size, unsigned min_pool_size,
+					    bool integrity, bool poll)
 {
 	struct dm_md_mempools *pools = kzalloc_node(sizeof(*pools), GFP_KERNEL, md->numa_node_id);
 	unsigned int pool_size = 0;
@@ -3014,7 +3014,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_qu
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


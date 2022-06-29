Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E40CCCA481
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiF2Xcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiF2Xcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:41 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B6CD2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:40 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id a15so16458656pfv.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KYJFhK98dFFLsB47ZcrSlECJlGkXKcGkN5yd5zOXlo=;
        b=q1FX3w7NJdx1vS/ON54qZZePek0jPMw2yidQNNPBtvXAJxeVdxA3djMtEjVGePpv21
         iUAGp28uGqy05WvZGAgx8ZtoMWYD0gRCjCzUqcJJVGx51nkZaJoU0n6mNpphECVeTR8C
         2rMuOm2xmF/4nZi6Y3qnAO2i4GflZZzInCiXnSjWxla5ilGamm9rq7nTBOHpa6nWkUvx
         ZUp4bNtq94XEmv1WVleqiXotRPY74h+kTTHoDGjdd7ZQcM/XbpShenC3kj27jeATjWuB
         WdRgMd5ml+Cgp3xHThXLqPEnRu6URjjg2yOQZVm4ZJOYfn9KkQLEJqEASQkNFFDasLBq
         Cbhg==
X-Gm-Message-State: AJIora+IkmGxgqtCEkn/sI494s1NWz7OuYbV+rN1Yyr9hVUur0IYjkH7
        ctK/xQrVlh6vEAQzk+k3ZjY=
X-Google-Smtp-Source: AGRyM1sbX2P8F1YJH72mFyJ48kZN5MeLvnXtGfMd6FJXQ81LLj4yDb9laHGfYmFqgZCaN81vxtF8dw==
X-Received: by 2002:a63:9d41:0:b0:40c:67af:1fed with SMTP id i62-20020a639d41000000b0040c67af1fedmr4819009pgd.185.1656545559888;
        Wed, 29 Jun 2022 16:32:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 30/63] dm/dm-zoned: Use the enum req_op type
Date:   Wed, 29 Jun 2022 16:31:12 -0700
Message-Id: <20220629233145.2779494-31-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for arguments
that represent a request operation.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-zoned-metadata.c | 5 +++--
 drivers/md/dm-zoned.h          | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index d1ea66114d14..34db364c23a8 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -737,7 +737,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 /*
  * Read/write a metadata block.
  */
-static int dmz_rdwr_block(struct dmz_dev *dev, int op,
+static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
 			  sector_t block, struct page *page)
 {
 	struct bio *bio;
@@ -2045,7 +2045,8 @@ struct dm_zone *dmz_get_zone_for_reclaim(struct dmz_metadata *zmd,
  * allocated and used to map the chunk.
  * The zone returned will be set to the active state.
  */
-struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd, unsigned int chunk, int op)
+struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd,
+				      unsigned int chunk, enum req_op op)
 {
 	struct dmz_mblock *dmap_mblk = zmd->map_mblk[chunk >> DMZ_MAP_ENTRIES_SHIFT];
 	struct dmz_map *dmap = (struct dmz_map *) dmap_mblk->data;
diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h
index a02744a0846c..265494d3f711 100644
--- a/drivers/md/dm-zoned.h
+++ b/drivers/md/dm-zoned.h
@@ -248,7 +248,7 @@ struct dm_zone *dmz_get_zone_for_reclaim(struct dmz_metadata *zmd,
 					 unsigned int dev_idx, bool idle);
 
 struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd,
-				      unsigned int chunk, int op);
+				      unsigned int chunk, enum req_op op);
 void dmz_put_chunk_mapping(struct dmz_metadata *zmd, struct dm_zone *zone);
 struct dm_zone *dmz_get_chunk_buffer(struct dmz_metadata *zmd,
 				     struct dm_zone *dzone);

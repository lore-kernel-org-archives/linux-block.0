Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC08FCCA483
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiGNSI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiGNSIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:25 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0468735
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:24 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so3834171pjl.4
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWKjk2kJf4HvpQ4KYmJCDS1rOFwgEYP2tPpJB+Bk6Xo=;
        b=pAZLZFcZFETTgQzb3y/Zm5FWeEraUXcUmTtXOFtsx9cNP3UqhrZAzysukAdgqZH5y2
         aERN4qX+fWOKWnsekAs1pkE5RfIfreKJZoHkIm8ZcMY9gOz6w+yooCtNllexiPHLbyK9
         h/TWdaLlBiFu4qpELF3VrSWdvVapSegbRP6KgvCS/+7807jIlCJtBvVQM409dnKUcquB
         Aw+8CvCZjymvopVurtwmKbO0knwy8IUhuz1FPYTtlgbqacumtVh7QNLm+0cwxBW1UoVJ
         IBgOIvu5QzUSLNqbELqAKn+lffpp5NFsJC+6J80RwPs2BmOlpptK42laO1b4B7lPW5g2
         uTVA==
X-Gm-Message-State: AJIora+UjKMDtFGCcKUbxrPwvveDPBCzuRm7i+QnzuVz5XAe0idpmOuc
        ohPPRMPekYt+Z+DPZxAhyCE=
X-Google-Smtp-Source: AGRyM1smAGVSfGAUfg5hO+rKhrKr8FYLq8I4XNjTLNVdtHiwyXI4VBXwcHYmgb1igdoYLCJd4SmHuw==
X-Received: by 2002:a17:902:a9c9:b0:161:5b73:5ac9 with SMTP id b9-20020a170902a9c900b001615b735ac9mr9405897plr.14.1657822104262;
        Thu, 14 Jul 2022 11:08:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v3 30/63] dm/dm-zoned: Use the enum req_op type
Date:   Thu, 14 Jul 2022 11:06:56 -0700
Message-Id: <20220714180729.1065367-31-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for arguments
that represent a request operation.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
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

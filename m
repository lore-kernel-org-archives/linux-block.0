Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB49C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiF2Xdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiF2Xdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:33 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36F248DD
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:19 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso1041826pjj.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNFXBH95fGE9JKJQ0XLB+jaP3PJuY7zouhsUKGJs4f0=;
        b=0VouANVRPl3zNbdPgF6FgmKjLVYzwN9qyp0hEjnmXT93k4CdD9bIA2CYX6AOXNF9J7
         5buqD2dHZppE1ETPQBwzYG89ix4WPonwf5redDLQo43uH7famZeQM7nix9vvGz/fJMnE
         FqrlX0gQ4QOMn/BtWmf3L5jc37AwEIl2DjIdXHF2xZnkJC0HG2jlH4Gcm/JicfDGmwvb
         bejPHu6O51N5rbDMN921Vq+kQJ7idCKpYlUKQpjAnSwPZTwnnk/BlofuOf5cUm6os1M6
         Mgf4s2q6J4SHln2oXep+c/3hWJA7lClimDr9Qiy+BdYSYheDfDOUArvgKxWW87MiEAn0
         JzHw==
X-Gm-Message-State: AJIora8nLOP0LnFvWkUSDAKEsOUmOJMnnvZg+p5PyD8Gz4WUmLPasyFH
        gMpDmj38aYKku/rzDdi4u7Wtv19dIwQ0Ag==
X-Google-Smtp-Source: AGRyM1shaawN6PUdUGqFXnneSwKybuobn0GbYBKk0PQrvnC+vGMjupzQ2Bfrz6cVtCSrvzh6qMeFxg==
X-Received: by 2002:a17:90a:ba04:b0:1ee:e6b0:edff with SMTP id s4-20020a17090aba0400b001eee6b0edffmr6542679pjr.153.1656545595464;
        Wed, 29 Jun 2022 16:33:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 54/63] fs/hfsplus: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:36 -0700
Message-Id: <20220629233145.2779494-55-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the last two
hfsplus_submit_bio() arguments into a single argument.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/hfsplus/hfsplus_fs.h |  2 +-
 fs/hfsplus/part_tbl.c   |  5 ++---
 fs/hfsplus/super.c      |  4 ++--
 fs/hfsplus/wrapper.c    | 12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 396e73aa0961..a5db2e3b2980 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -525,7 +525,7 @@ int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
-		       void **data, int op, int op_flags);
+		       void **data, blk_opf_t opf);
 int hfsplus_read_wrapper(struct super_block *sb);
 
 /*
diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
index 63164ebc52fa..9ec21664eda6 100644
--- a/fs/hfsplus/part_tbl.c
+++ b/fs/hfsplus/part_tbl.c
@@ -112,8 +112,7 @@ static int hfs_parse_new_pmap(struct super_block *sb, void *buf,
 		if ((u8 *)pm - (u8 *)buf >= buf_size) {
 			res = hfsplus_submit_bio(sb,
 						 *part_start + HFS_PMAP_BLK + i,
-						 buf, (void **)&pm, REQ_OP_READ,
-						 0);
+						 buf, (void **)&pm, REQ_OP_READ);
 			if (res)
 				return res;
 		}
@@ -137,7 +136,7 @@ int hfs_part_find(struct super_block *sb,
 		return -ENOMEM;
 
 	res = hfsplus_submit_bio(sb, *part_start + HFS_PMAP_BLK,
-				 buf, &data, REQ_OP_READ, 0);
+				 buf, &data, REQ_OP_READ);
 	if (res)
 		goto out;
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 8479add998b5..122ed89ebf9f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -221,7 +221,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				   sbi->part_start + HFSPLUS_VOLHEAD_SECTOR,
-				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE,
+				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE |
 				   REQ_SYNC);
 	if (!error)
 		error = error2;
@@ -230,7 +230,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				  sbi->part_start + sbi->sect_count - 2,
-				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE,
+				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE |
 				  REQ_SYNC);
 	if (!error)
 		error2 = error;
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 0b8ad6586df5..0b791adf02e5 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -45,8 +45,9 @@ struct hfsplus_wd {
  * will work correctly.
  */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
-		       void *buf, void **data, int op, int op_flags)
+		       void *buf, void **data, blk_opf_t opf)
 {
+	const enum req_op op = opf & REQ_OP_MASK;
 	struct bio *bio;
 	int ret = 0;
 	u64 io_size;
@@ -63,10 +64,10 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	offset = start & (io_size - 1);
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
 
-	bio = bio_alloc(sb->s_bdev, 1, op | op_flags, GFP_NOIO);
+	bio = bio_alloc(sb->s_bdev, 1, opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = sector;
 
-	if (op != WRITE && data)
+	if (op != REQ_OP_WRITE && data)
 		*data = (u8 *)buf + offset;
 
 	while (io_size > 0) {
@@ -184,7 +185,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 reread:
 	error = hfsplus_submit_bio(sb, part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, (void **)&sbi->s_vhdr,
-				   REQ_OP_READ, 0);
+				   REQ_OP_READ);
 	if (error)
 		goto out_free_backup_vhdr;
 
@@ -216,8 +217,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 
 	error = hfsplus_submit_bio(sb, part_start + part_size - 2,
 				   sbi->s_backup_vhdr_buf,
-				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ,
-				   0);
+				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ);
 	if (error)
 		goto out_free_backup_vhdr;
 

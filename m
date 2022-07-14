Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283DACCA47C
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiGNSJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A6205DC
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:05 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso3865697pjh.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNFXBH95fGE9JKJQ0XLB+jaP3PJuY7zouhsUKGJs4f0=;
        b=LuMhQ1n925062oK/FFWAQvavXT0w226ZyP0MR2l8GrgeMfHXVaUkNUevDtMTev6F6k
         M+Wl/VYbKs5LrcBx/GJmsk3GupfVgb0taPQstiSoqj5xnEWU1EhPEq81EkQCEgjHMeQq
         QjKk6MpDovIQ2owixgBBJhFKsbgLdPXnR5Rt8R2kPh5oJBQ4ZDo4dqMPRt1CPyJCZD1l
         CSFiExUwndIKMJRhUxKAg9uw3LBs0LrlQ6FgOu1VYurJpf99eIkntpyV1zKmr9bEoydw
         58yJ4byfgEC1GYKdgiTxCGI/UwRJsGfy7tkwyVB6axmjKW91Vtg8gvcLA0QhO+BCt72p
         2VjA==
X-Gm-Message-State: AJIora+tQSNIsneGbuRQ9kPUSxNdJX8+e2l7Fi01H1ZRE2MeaCLlGPv/
        YwiZZOkk5+sDCHuka809tQrbNfxP0f4=
X-Google-Smtp-Source: AGRyM1vcXqBmyrfoKnjKdLwC2BMR9EQOYqqjLBWFrhBZ6LP4rxHykcFtQDODfDMxvbSiEoe/3pFoew==
X-Received: by 2002:a17:903:120c:b0:167:8847:21f2 with SMTP id l12-20020a170903120c00b00167884721f2mr9323120plh.11.1657822144906;
        Thu, 14 Jul 2022 11:09:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 54/63] fs/hfsplus: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:20 -0700
Message-Id: <20220714180729.1065367-55-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
 

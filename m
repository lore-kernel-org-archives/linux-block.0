Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E088C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiF2XeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiF2Xdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:43 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B1656A
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:27 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so1879833pju.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XH56dl7M34VcJLvlT7/jJn+XRwYnxiP7hAZYFPzpxZE=;
        b=lOiEAeLwsCyC63RgPtgAoQoOS6NSRizbx92PItLvw1re8n6i21mnV6wuCX/iUd5lcz
         Or1JQWHuZP6ecbaC6vDggrOHixwuLcE2IRFRlN3gGjK7jX4jWRelX8zLNa9RdHFo7+ut
         +DmSKs9oA+ehLmSu/yB6Yg10JlWDESLgFxXTlOKPJUVgsoCh146PJWkY1oTNs0dM7cU4
         /l7HdaO9HiB6waZrll6bZA+Wyfue2UqSA0tAcHT3dhrrR/zfJYrng0nFw+FioV27H8US
         vrcDoxJUITgIUKjDbUYBmAxrG7FiD/LTbg6Ja20gnV3Su/cIRtRbHJmghZ8utCNXSNaC
         8o5A==
X-Gm-Message-State: AJIora+RTgH6XqJvwOwvD+4r4k8Q72AaBT2zI/OOfkDuXuZGUlEUV/1r
        W9kgm2NgkiahcQgaPvQnwOk=
X-Google-Smtp-Source: AGRyM1swsHxKOs8hmLNDEtPDOvnymB881YQW4JbiqOA+q9851b6xmAsqQpoEXuNsWiX1icjd4a/3GA==
X-Received: by 2002:a17:902:c101:b0:16a:1272:270e with SMTP id 1-20020a170902c10100b0016a1272270emr12607566pli.163.1656545602858;
        Wed, 29 Jun 2022 16:33:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 59/63] fs/ntfs3: Use enum req_op where appropriate
Date:   Wed, 29 Jun 2022 16:31:41 -0700
Message-Id: <20220629233145.2779494-60-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using enum req_op instead of u32 for
block layer request operations.

Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/ntfs3/fsntfs.c  | 2 +-
 fs/ntfs3/ntfs_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3de5700a9b83..1835e35199c2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1448,7 +1448,7 @@ int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
  */
 int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
-		   u32 op)
+		   enum req_op op)
 {
 	int err = 0;
 	struct bio *new, *bio = NULL;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8de129a6419b..3a8abf13143e 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -617,7 +617,7 @@ int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
 		  struct ntfs_buffers *nb, int sync);
 int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
-		   u32 op);
+		   enum req_op op);
 int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run);
 int ntfs_vbo_to_lbo(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		    u64 vbo, u64 *lbo, u64 *bytes);

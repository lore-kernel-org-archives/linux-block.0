Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835AFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiFWTBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiFWTBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:42 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDA4F1F8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:49 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d5so18803537plo.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XH56dl7M34VcJLvlT7/jJn+XRwYnxiP7hAZYFPzpxZE=;
        b=7Oh3l7ZX0EEM/E3Wy/k3PHLVQ06UyXRbWkYh2X4jhbO4llFtn8wVgG15n4/QvONkZt
         wtm2joH5uLFgy7gMmjBzrBYiX42CRKB2PZVe78ybOfv/QiOkfRNRgVrMaF4Kjk1//bX5
         NoW+p9pzObDR4sadlaUvkjl0MmZH8+YXKAA74rXa0GKW90tgvEW+/E40G4ut+vji0qoN
         9k5+qdaZ0hc9O9Bhwpfn+OV/7RjE69HnJcoQZ/Uu0xTG42EeVOo4mpJ0sAjuc4olFR3k
         hWBsxoDbYkPGgYdoL25MLr7SRecCR7G4eevY0McbUSTrns/vqkRxDfFPC5gNHFJwouUU
         fVQw==
X-Gm-Message-State: AJIora+Gugj9rzvgqd4mIwENdQbnhybNhw/bU/F2cR9Elyo2IQyahZ3m
        vXIKVxthddWUuEHRO6EAv7I=
X-Google-Smtp-Source: AGRyM1tPYPVt8SdRyv/3RZ1ZIGXNkd38DSbr5xQ1sUiUDn/lA9Zz/0HPsqLYWg8btjXUtqXVy8bknQ==
X-Received: by 2002:a17:90a:aa96:b0:1ea:3780:c3dc with SMTP id l22-20020a17090aaa9600b001ea3780c3dcmr5227013pjq.241.1656007608907;
        Thu, 23 Jun 2022 11:06:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 47/51] fs/ntfs3: Use enum req_op where appropriate
Date:   Thu, 23 Jun 2022 11:05:24 -0700
Message-Id: <20220623180528.3595304-48-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D86CCA482
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiGNSJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7C65F5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:13 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id b2so1120304plx.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XH56dl7M34VcJLvlT7/jJn+XRwYnxiP7hAZYFPzpxZE=;
        b=uBgPutqTQP1YIpsq58P6yqb8U2big6capiePMB6piqzsg+KjL9BN6gcX097uLFuAxG
         sU/pf0ngn5SlOvtAmXlGgLnPG1F0tT++FnhO0OffAouRhjv8mNwEjBVLXkhS3FN40H2B
         Scodj1/y/O/G+Sut1xuyYy1YebueaTqwEddlRBMwBojVEapvp0H/Qk/AMzeEdxGhYExw
         gAIkW2wLaMvgX655fN7VNJoSFNI+Ct3z83pyvhC0XeSNVbErhxt90UbSPvWktSyaisWO
         hQt9m5lZnljE6ZB6pcCMdvCydKTnCSrYEOXsd3NshYUgHekS9m7GW9ORiO98NnwbSoLV
         fvqA==
X-Gm-Message-State: AJIora/U9K8RhmfXkLtUWK+Sgbs+1A2dHJzZ+sXfkrd96iVGxrlplqDH
        bYwo0ijdgEsX2cUUOYFZc5E=
X-Google-Smtp-Source: AGRyM1t6qe9wmSkefq/Wicu/vxXxj9RHgllrcWa4pEWneOOvQTcnS8Y9VITknww2i1VNoH55h+ZjMQ==
X-Received: by 2002:a17:902:f7c1:b0:16b:de8e:dca6 with SMTP id h1-20020a170902f7c100b0016bde8edca6mr9237265plw.99.1657822152715;
        Thu, 14 Jul 2022 11:09:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v3 59/63] fs/ntfs3: Use enum req_op where appropriate
Date:   Thu, 14 Jul 2022 11:07:25 -0700
Message-Id: <20220714180729.1065367-60-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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

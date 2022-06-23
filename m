Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABAC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiFWTBx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiFWTBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:39 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58AC60C77
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:47 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso3384614pjn.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiRFOz/pc58fJY7R3kmiJRoWVSH6zT3FtqNeu7uf5ZI=;
        b=BX8ZhWP9PZu3a37x8h17w+ihl5DjMpIqIQC43hzVAw0e8R9Y94MdXoG+mC12PArfRJ
         Cxx28p2IdP7JZZas8XZSSwRvOkgSaBMRFygIIwb19zO3HNo5xaxIEoc3Bx4jinxmrPrr
         FRUsbh8kzYnlAHVV4wFgV9sQd7JHfq5M1+SYmTXPPBBQwky7X4Kau3+WVWX0yK035jBK
         sgSF2RRf+1883LWn9E2jvENEMcvUMCPpbk9zXJJe0jIpA0UE+Lo4DgnP98qgH86TJDOT
         0xEKHT7hUHGAFHESaHUZFbW+W1UXzOVc37D5+sTSOSGZfzwLVFn0Ts1WBY93KZKQbLvQ
         5NyA==
X-Gm-Message-State: AJIora9mxy4aSuCCMCRXn/14LCN61GcFNkJHgphJqJC4OwZ1O95JvUv/
        PFblQxqGvYcVYuvn6Yh8KD6aDGUx3d3ajg==
X-Google-Smtp-Source: AGRyM1sf/vsM1zEmtW2mlHr7TUWgGoJgCkN5ZzJKOUa4uS7nbcLH8ZqR87CiH2m/iwvcbO9K5YHzHw==
X-Received: by 2002:a17:902:8d98:b0:168:a310:3ea6 with SMTP id v24-20020a1709028d9800b00168a3103ea6mr39803886plo.9.1656007607093;
        Thu, 23 Jun 2022 11:06:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH 46/51] fs/nilfs: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:23 -0700
Message-Id: <20220623180528.3595304-47-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/nilfs2/btnode.c            | 4 ++--
 fs/nilfs2/btnode.h            | 5 +++--
 fs/nilfs2/mdt.c               | 3 ++-
 include/trace/events/nilfs2.h | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index ca611ac09f7c..13784cf169ca 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -70,8 +70,8 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
-			      sector_t pblocknr, int mode, int mode_flags,
-			      struct buffer_head **pbh, sector_t *submit_ptr)
+		sector_t pblocknr, enum req_op mode, blk_opf_t mode_flags,
+		struct buffer_head **pbh, sector_t *submit_ptr)
 {
 	struct buffer_head *bh;
 	struct inode *inode = btnc->host;
diff --git a/fs/nilfs2/btnode.h b/fs/nilfs2/btnode.h
index bd5544e63a01..b7d2948dc74f 100644
--- a/fs/nilfs2/btnode.h
+++ b/fs/nilfs2/btnode.h
@@ -34,8 +34,9 @@ void nilfs_init_btnc_inode(struct inode *btnc_inode);
 void nilfs_btnode_cache_clear(struct address_space *);
 struct buffer_head *nilfs_btnode_create_block(struct address_space *btnc,
 					      __u64 blocknr);
-int nilfs_btnode_submit_block(struct address_space *, __u64, sector_t, int,
-			      int, struct buffer_head **, sector_t *);
+int nilfs_btnode_submit_block(struct address_space *, __u64, sector_t,
+			      enum req_op, blk_opf_t, struct buffer_head **,
+			      sector_t *);
 void nilfs_btnode_delete(struct buffer_head *);
 int nilfs_btnode_prepare_change_key(struct address_space *,
 				    struct nilfs_btnode_chkey_ctxt *);
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index d29a0f2b9c16..19d878f0e923 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -112,7 +112,8 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 
 static int
 nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
-		       int mode, int mode_flags, struct buffer_head **out_bh)
+		       enum req_op mode, blk_opf_t mode_flags,
+		       struct buffer_head **out_bh)
 {
 	struct buffer_head *bh;
 	__u64 blknum = 0;
diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs2.h
index 84ee31fc04cc..05668a783042 100644
--- a/include/trace/events/nilfs2.h
+++ b/include/trace/events/nilfs2.h
@@ -192,7 +192,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 	    TP_PROTO(struct inode *inode,
 		     unsigned long ino,
 		     unsigned long blkoff,
-		     int mode),
+		     enum req_op mode),
 
 	    TP_ARGS(inode, ino, blkoff, mode),
 
@@ -207,7 +207,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 		    __entry->inode = inode;
 		    __entry->ino = ino;
 		    __entry->blkoff = blkoff;
-		    __entry->mode = mode;
+		    __entry->mode = (__force int)mode;
 		    ),
 
 	    TP_printk("inode = %p ino = %lu blkoff = %lu mode = %x",

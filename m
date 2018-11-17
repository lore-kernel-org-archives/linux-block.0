Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD59BC04EBF
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD42082A
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jzN/n5sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFD42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKRKL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeKRKL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1685709pgk.10
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=072f8lD4g81Vn10CWUHoUo26U/oP6o1PKTyTkqSYZgw=;
        b=jzN/n5sQbWENmjWCVKK+0M+4vLgxo92h8gIZYUIvwe+BC/z/0iLW4R8ekVMlr8i3Eo
         Sl095n2NJmfiLfv168aITDBrRwpFK9XiCJ2+0DpxSpUKLWEF3HGs/EEHp2nD4aBezZbW
         ufGQ9+DTDOZUAe9Uo9jETeNgz3aogPhe0NS7RxopsPvOpFpWszQ14l8sTogUvtXR/deh
         KSKswezeW7fOHugfCxNUom8JfWi/Jv8Y4f1303SJwTJn9zOXyPuFjoKWyqOgtIPmq6pb
         FAuImv+1uJb+BKSgZ0DpoAapB4ZVgTRk5SDfo8iLXJjUfrtG55wSjwMlG1FjtYUtUQuX
         K7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=072f8lD4g81Vn10CWUHoUo26U/oP6o1PKTyTkqSYZgw=;
        b=CXj83i1Q5sOIpk9bxOxo3At7RsdfpyM043YZpIdB7Woq7DnixSQEHBxkXLc3TZDHv/
         4fuUu6fD+ItyRT60Tvp6qaYWSZA9sRCl5RYm9PpBlov+AWElIuCNVFIsz0MH3mGJ7tD7
         pKlfUC7ZlTX0TeaY7+w6+iWFkBddhSn2cUoumT8dLCAmAiEaxlCYPrznt566A37l+Ctm
         5UYlutvbQrtUcFreYJVcUIt0U+9qOcdtRhbffrbPZL/xgz0aTmeSy4+oJwokbGxg9os0
         pd6iToCL4oIIDxZcJBHzaNs9Q21tCXPje2aomhsWQoyeLezD5Yk3cPTixbay9+VGFrX8
         MshQ==
X-Gm-Message-State: AGRZ1gKlY6Jm6hAHEp0oUELTfT/w3iCMg5AL2mEPTalOo3/f3X+d9AtP
        ZA5cSi4Vykw/xWU+boH0y1P8P7LrCL8=
X-Google-Smtp-Source: AJdET5d6qpZ5T7P2C459Elr180i1oiRNwt+cs+PROPX8DU1HYzy0whkFBzgtUVZvprRkLHPcqQuqRg==
X-Received: by 2002:a63:d157:: with SMTP id c23mr14949553pgj.170.1542498812114;
        Sat, 17 Nov 2018 15:53:32 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] aio: add support for file based polled IO
Date:   Sat, 17 Nov 2018 16:53:17 -0700
Message-Id: <20181117235317.7366-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117235317.7366-1-axboe@kernel.dk>
References: <20181117235317.7366-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Needs further work, but this should work fine on normal setups
with a file system on a pollable block device.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c       | 2 ++
 fs/direct-io.c | 4 +++-
 fs/iomap.c     | 7 +++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 500da3ffc376..e02085fe10d7 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1310,6 +1310,8 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
 
 	if (S_ISBLK(inode->i_mode))
 		return I_BDEV(inode);
+	else if (inode->i_sb && inode->i_sb->s_bdev)
+		return inode->i_sb->s_bdev;
 
 	return NULL;
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index a5a4e5a1423e..34de494e9061 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -477,8 +477,10 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	if (sdio->submit_io) {
 		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
 		dio->bio_cookie = BLK_QC_T_NONE;
-	} else
+	} else {
 		dio->bio_cookie = submit_bio(bio);
+		WRITE_ONCE(dio->iocb->ki_blk_qc, dio->bio_cookie);
+	}
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
diff --git a/fs/iomap.c b/fs/iomap.c
index 74c1f37f0fd6..4cf412b6230a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1555,6 +1555,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
+	blk_qc_t qc;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
 	bio_set_dev(bio, iomap->bdev);
@@ -1570,7 +1571,9 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
 
 	atomic_inc(&dio->ref);
-	return submit_bio(bio);
+	qc = submit_bio(bio);
+	WRITE_ONCE(dio->iocb->ki_blk_qc, qc);
+	return qc;
 }
 
 static loff_t
@@ -1680,7 +1683,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		atomic_inc(&dio->ref);
 
 		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-		dio->submit.cookie = submit_bio(bio);
+		dio->iocb->ki_blk_qc = dio->submit.cookie = submit_bio(bio);
 	} while (nr_pages);
 
 	if (need_zeroout) {
-- 
2.17.1


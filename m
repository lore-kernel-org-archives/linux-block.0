Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0283C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiFWTBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiFWTA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:59 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD86A1E31
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:09 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso397230pjk.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jrCiQdokB8oLIJ21/NSzCXovkSx6x/n5GeFI5oMSnQ=;
        b=j5VScy3OoFpp/w9tj8aTfJfP4FnuJ2HYLNIdyA2kyJ1yTWxg1g+h2npml2/jRxhy8K
         ANyp5M7lx6082qzQRc5c/3tCU7ipVyujct7EvSUwLVgbd4AKewiCCko7sjhb1nICquLf
         ebcmKgKsF5+hekoqTx8/mNglleg8ZBpMZy9Eqs+aDrVeBtJg3ZxtErbzLTwMzakJVJHu
         G1k4BQIerSSsq1FlRn6sRP7gxyUZYGfQJrmJhGphgjUHaOQ2/dBmuwHB0pAkOG2eJ4sS
         x3ef921qO2qCbKApWBicoSlZFOzGIG6qv6aP6z8RH192/nT6C+wSbMrPFKD3FU0niICm
         DosQ==
X-Gm-Message-State: AJIora/U9s4hBanK04Bjz8p0jeIoeWRoyehzhgV4KWqHt9XeucoDAPdg
        AHFEHT7YaPAje7QHvuwYc5TPfdwxcLs=
X-Google-Smtp-Source: AGRyM1sOHAk6GTB2jospjBexLwXGDR6ofS8yO/ToQsG9vb4Bas2ZyOyFi+MYYT7ifvAOO0BIiR1GpQ==
X-Received: by 2002:a17:902:7c0e:b0:16a:6ec:69e9 with SMTP id x14-20020a1709027c0e00b0016a06ec69e9mr32577427pll.108.1656007569158;
        Thu, 23 Jun 2022 11:06:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH 22/51] md/core: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:04:59 -0700
Message-Id: <20220623180528.3595304-23-bvanassche@acm.org>
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

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/md.c | 3 ++-
 drivers/md/md.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index c7ecb0bffda0..d354faa95be7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -993,7 +993,8 @@ int md_super_wait(struct mddev *mddev)
 }
 
 int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
-		 struct page *page, int op, int op_flags, bool metadata_op)
+		 struct page *page, enum req_op op, blk_opf_t op_flags,
+		 bool metadata_op)
 {
 	struct bio bio;
 	struct bio_vec bvec;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index cf2cbb17acbd..f93bf7396d86 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -738,8 +738,8 @@ extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 			   sector_t sector, int size, struct page *page);
 extern int md_super_wait(struct mddev *mddev);
 extern int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
-			struct page *page, int op, int op_flags,
-			bool metadata_op);
+		struct page *page, enum req_op op, blk_opf_t op_flags,
+		bool metadata_op);
 extern void md_do_sync(struct md_thread *thread);
 extern void md_new_event(void);
 extern void md_allow_write(struct mddev *mddev);

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57967C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiFWTBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFWTA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:59 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2918858D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:11 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c4so2629850plc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuhgZ0rXAW6rh8dAncL1seag6twZCavNh0PD870KD0M=;
        b=4XgntJxprHflewnWDBiQL4ZcenN98lQmD+KvU408rmr0P4UOEVEPhaJaj/MmLtXLGz
         SxMIG7G57loWricyge02xlBNuYL7+6cXWnJsVfIX6tf2wxW91keqUdge253Lw/8Q83Zp
         UBuBnR1mXC/um9efoZWEi7Lq9Cp5sGtNtk12Jqk6A46a8rsnmQkymvibHbfvkFTPNCHj
         ZDkcBhQfcnnd2W5dFRLV6Za57P0rp7Za5MTZ1Q2ukvjY9D8psIBDxvEiw7PamPpTKSKB
         RRRCbMtq6TqV+p9OePzx2tsXcbGQxaZxtKvWyiNc+1Uv/iAKcrJrixCMdY4TANWWL0oG
         BYew==
X-Gm-Message-State: AJIora8PtJqQMztzajdKRWfXW8Ii0depvrC1VQbA+fQgmrddr3TPONFV
        YPBewnbeA+A8ZmqIykSGc4Q=
X-Google-Smtp-Source: AGRyM1ufxTH/Ba4Dj/dZ77xQ9zVCsN+f10xECxabpV2mts3V+gEzpcwT3RnfmdpjMqjw2nG5komxqg==
X-Received: by 2002:a17:902:f34a:b0:16a:e2d:3e9 with SMTP id q10-20020a170902f34a00b0016a0e2d03e9mr31043596ple.95.1656007570766;
        Thu, 23 Jun 2022 11:06:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 23/51] md/bcache: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:00 -0700
Message-Id: <20220623180528.3595304-24-bvanassche@acm.org>
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

Cc: Coly Li <colyli@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/bcache/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 3563d15dbaf2..93f18bae28cf 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -414,7 +414,7 @@ static void uuid_io_unlock(struct closure *cl)
 	up(&c->uuid_write_mutex);
 }
 
-static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
+static void uuid_io(struct cache_set *c, enum req_op op, blk_opf_t op_flags,
 		    struct bkey *k, struct closure *parent)
 {
 	struct closure *cl = &c->uuid_write;
@@ -588,7 +588,7 @@ static void prio_endio(struct bio *bio)
 }
 
 static void prio_io(struct cache *ca, uint64_t bucket, int op,
-		    unsigned long op_flags)
+		    blk_opf_t op_flags)
 {
 	struct closure *cl = &ca->prio;
 	struct bio *bio = bch_bbio_alloc(ca->set);

Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C5C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D207E214E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMIGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:06:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbfKMIGH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 03:06:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FF65B1EA;
        Wed, 13 Nov 2019 08:06:05 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 11/12] bcache: remove the extra cflags for request.o
Date:   Wed, 13 Nov 2019 16:03:25 +0800
Message-Id: <20191113080326.69989-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113080326.69989-1-colyli@suse.de>
References: <20191113080326.69989-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

There is no block directory this file needs includes from.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
index d26b35195825..fd714628da6a 100644
--- a/drivers/md/bcache/Makefile
+++ b/drivers/md/bcache/Makefile
@@ -5,5 +5,3 @@ obj-$(CONFIG_BCACHE)	+= bcache.o
 bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
 	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
 	util.o writeback.o
-
-CFLAGS_request.o	+= -Iblock
-- 
2.16.4


Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D2C43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E7B21920
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeLWLLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:11:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbeLWLLC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:11:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76AD8AF0B;
        Sun, 23 Dec 2018 11:11:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 10/11] bcache: fix input overflow to cache set io_error_limit
Date:   Sun, 23 Dec 2018 19:09:36 +0800
Message-Id: <20181223110937.11559-11-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c->error_limit is in type unsigned int, it is set via cache set sysfs
file io_error_limit. Inside the bcache code, input string is converted
by strtoul_or_return() and set the converted value to c->error_limit.

Because the converted value is unsigned long, and c->error_limit is
unsigned int, if the input is large enought, overflow will happen to
c->error_limit.

This patch uses sysfs_strtoul_clamp() to convert input string, and set
the range in [0, UINT_MAX] to avoid the potential overflow.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 032d108d3041..c9888c45cb03 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -789,8 +789,7 @@ STORE(__bch_cache_set)
 		c->on_error = v;
 	}
 
-	if (attr == &sysfs_io_error_limit)
-		c->error_limit = strtoul_or_return(buf);
+	sysfs_strtoul_clamp(io_error_limit, c->error_limit, 0, UINT_MAX);
 
 	/* See count_io_errors() for why 88 */
 	if (attr == &sysfs_io_error_halflife)
-- 
2.16.4


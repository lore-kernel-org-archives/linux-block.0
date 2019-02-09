Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFD1C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A1B20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBIEyS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:54:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:57958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfBIEyS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:54:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 431A8ABA1;
        Sat,  9 Feb 2019 04:54:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 18/19] bcache: fix input overflow to cache set sysfs file io_error_halflife
Date:   Sat,  9 Feb 2019 12:53:10 +0800
Message-Id: <20190209045311.15677-19-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cache set sysfs entry io_error_halflife is used to set c->error_decay.
c->error_decay is in type unsigned int, and it is converted by
strtoul_or_return(), therefore overflow to c->error_decay is possible
for a large input value.

This patch fixes the overflow by using strtoul_safe_clamp() to convert
input string to an unsigned long value in range [0, UINT_MAX], then
divides by 88 and set it to c->error_decay.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 467105614324..17bae9c14ca0 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -804,8 +804,17 @@ STORE(__bch_cache_set)
 	sysfs_strtoul_clamp(io_error_limit, c->error_limit, 0, UINT_MAX);
 
 	/* See count_io_errors() for why 88 */
-	if (attr == &sysfs_io_error_halflife)
-		c->error_decay = strtoul_or_return(buf) / 88;
+	if (attr == &sysfs_io_error_halflife) {
+		unsigned long v = 0;
+		ssize_t ret;
+
+		ret = strtoul_safe_clamp(buf, v, 0, UINT_MAX);
+		if (!ret) {
+			c->error_decay = v / 88;
+			return size;
+		}
+		return ret;
+	}
 
 	if (attr == &sysfs_io_disable) {
 		v = strtoul_or_return(buf);
-- 
2.16.4


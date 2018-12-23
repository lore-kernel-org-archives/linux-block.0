Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FBC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC42121903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeLWLLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:49684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLLG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:11:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DD07AF0B;
        Sun, 23 Dec 2018 11:11:05 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 11/11] bcache: fix input overflow to cache set sysfs file io_error_halflife
Date:   Sun, 23 Dec 2018 19:09:37 +0800
Message-Id: <20181223110937.11559-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
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
 drivers/md/bcache/sysfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index c9888c45cb03..c0e2dcc94668 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -792,8 +792,14 @@ STORE(__bch_cache_set)
 	sysfs_strtoul_clamp(io_error_limit, c->error_limit, 0, UINT_MAX);
 
 	/* See count_io_errors() for why 88 */
-	if (attr == &sysfs_io_error_halflife)
-		c->error_decay = strtoul_or_return(buf) / 88;
+	if (attr == &sysfs_io_error_halflife) {
+		long v;
+
+		v = strtoul_safe_clamp(buf, v, 0, UINT_MAX);
+		if (v < 0)
+			return v;
+		c->error_decay = v / 88;
+	}
 
 	if (attr == &sysfs_io_disable) {
 		v = strtoul_or_return(buf);
-- 
2.16.4


Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A55C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4DA20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBIExp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIExp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 954A8AF6F;
        Sat,  9 Feb 2019 04:53:44 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 08/19] bcache: fix input integer overflow of congested threshold
Date:   Sat,  9 Feb 2019 12:53:00 +0800
Message-Id: <20190209045311.15677-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cache set congested threshold values congested_read_threshold_us and
congested_write_threshold_us can be set via sysfs interface. These
two values are 'unsigned int' type, but sysfs interface uses strtoul
to convert input string. So if people input a large number like
9999999999, the value indeed set is 1410065407, which is not expected
behavior.

This patch replaces sysfs_strtoul() by sysfs_strtoul_clamp() when
convert input string to unsigned int value, and set value range in
[0, UINT_MAX], to avoid the above integer overflow errors.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 9be27b26d300..bedd3e68fd29 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -778,10 +778,12 @@ STORE(__bch_cache_set)
 		c->shrink.scan_objects(&c->shrink, &sc);
 	}
 
-	sysfs_strtoul(congested_read_threshold_us,
-		      c->congested_read_threshold_us);
-	sysfs_strtoul(congested_write_threshold_us,
-		      c->congested_write_threshold_us);
+	sysfs_strtoul_clamp(congested_read_threshold_us,
+			    c->congested_read_threshold_us,
+			    0, UINT_MAX);
+	sysfs_strtoul_clamp(congested_write_threshold_us,
+			    c->congested_write_threshold_us,
+			    0, UINT_MAX);
 
 	if (attr == &sysfs_errors) {
 		v = __sysfs_match_string(error_actions, -1, buf);
-- 
2.16.4


Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED88C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096F120643
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBIExw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:57830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIExw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FABDABA1;
        Sat,  9 Feb 2019 04:53:51 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 10/19] bcache: add sysfs_strtoul_bool() for setting bit-field variables
Date:   Sat,  9 Feb 2019 12:53:02 +0800
Message-Id: <20190209045311.15677-11-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When setting bool values via sysfs interface, e.g. writeback_metadata,
if writing 1 into writeback_metadata file, dc->writeback_metadata is
set to 1, but if writing 2 into the file, dc->writeback_metadata is
0. This is misleading, a better result should be 1 for all non-zero
input value.

It is because dc->writeback_metadata is a bit-field variable, and
current code simply use d_strtoul() to convert a string into integer
and takes the lowest bit value. To fix such error, we need a routine
to convert the input string into unsigned integer, and set target
variable to 1 if the converted integer is non-zero.

This patch introduces a new macro called sysfs_strtoul_bool(), it can
be used to convert input string into bool value, we can use it to set
bool value for bit-field vairables.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/md/bcache/sysfs.h b/drivers/md/bcache/sysfs.h
index 0ad2715a884e..215df32f567b 100644
--- a/drivers/md/bcache/sysfs.h
+++ b/drivers/md/bcache/sysfs.h
@@ -79,6 +79,16 @@ do {									\
 		return strtoul_safe(buf, var) ?: (ssize_t) size;	\
 } while (0)
 
+#define sysfs_strtoul_bool(file, var)					\
+do {									\
+	if (attr == &sysfs_ ## file) {					\
+		unsigned long v = strtoul_or_return(buf);		\
+									\
+		var = v ? 1 : 0;					\
+		return size;						\
+	}								\
+} while (0)
+
 #define sysfs_strtoul_clamp(file, var, min, max)			\
 do {									\
 	if (attr == &sysfs_ ## file) {					\
-- 
2.16.4


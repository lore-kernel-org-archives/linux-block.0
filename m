Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB59C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D993420857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBIExt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIExt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFD4EAF6F;
        Sat,  9 Feb 2019 04:53:47 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 09/19] bcache: fix input overflow to sequential_cutoff
Date:   Sat,  9 Feb 2019 12:53:01 +0800
Message-Id: <20190209045311.15677-10-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

People may set sequential_cutoff of a cached device via sysfs file,
but current code does not check input value overflow. E.g. if value
4294967295 (UINT_MAX) is written to file sequential_cutoff, its value
is 4GB, but if 4294967296 (UINT_MAX + 1) is written into, its value
will be 0. This is an unexpected behavior.

This patch replaces d_strtoi_h() by sysfs_strtoul_clamp() to convert
input string to unsigned integer value, and limit its range in
[0, UINT_MAX]. Then the input overflow can be fixed.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index bedd3e68fd29..96b64893f2cb 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -314,7 +314,9 @@ STORE(__cached_dev)
 		dc->io_disable = v ? 1 : 0;
 	}
 
-	d_strtoi_h(sequential_cutoff);
+	sysfs_strtoul_clamp(sequential_cutoff,
+			    dc->sequential_cutoff,
+			    0, UINT_MAX);
 	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
-- 
2.16.4


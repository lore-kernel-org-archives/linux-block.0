Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EAC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C0221903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeLWLKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:49598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1DDFAF0B;
        Sun, 23 Dec 2018 11:10:42 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 06/11] bcache: fix potential div-zero error of writeback_rate_i_term_inverse
Date:   Sun, 23 Dec 2018 19:09:32 +0800
Message-Id: <20181223110937.11559-7-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dc->writeback_rate_i_term_inverse can be set via sysfs interface. It is
in type unsigned int, and convert from input string by d_strtoul(). The
problem is d_strtoul() does not check valid range of the input, if
4294967296 is written into sysfs file writeback_rate_i_term_inverse,
an overflow of unsigned integer will happen and value 0 is set to
dc->writeback_rate_i_term_inverse.

In writeback.c:__update_writeback_rate(), there are following lines of
code,
      integral_scaled = div_s64(dc->writeback_rate_integral,
                      dc->writeback_rate_i_term_inverse);
If dc->writeback_rate_i_term_inverse is set to 0 via sysfs interface,
a div-zero error might be triggered in the above code.

Therefore we need to add a range limitation in the sysfs interface,
this is what this patch does, use sysfs_stroul_clamp() to replace
d_strtoul() and restrict the input range in [1, UINT_MAX].

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 16cd710f5f8b..d57ab24e9ccd 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -298,7 +298,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_update_seconds,
 			    dc->writeback_rate_update_seconds,
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
-	d_strtoul(writeback_rate_i_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
+			    dc->writeback_rate_i_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
-- 
2.16.4


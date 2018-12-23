Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DBC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C01121903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeLWLKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05B82AF0B;
        Sun, 23 Dec 2018 11:10:48 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 07/11] bcache: fix potential div-zero error of writeback_rate_p_term_inverse
Date:   Sun, 23 Dec 2018 19:09:33 +0800
Message-Id: <20181223110937.11559-8-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current code already uses d_strtoul_nonzero() to convert input string
to an unsigned integer, to make sure writeback_rate_p_term_inverse
won't be zero value. But overflow may happen when converting input
string to an unsigned integer value by d_strtoul_nonzero(), then
dc->writeback_rate_p_term_inverse can still be set to 0 even if the
sysfs file input value is not zero, e.g. 4294967296 (a.k.a UINT_MAX+1).

If dc->writeback_rate_p_term_inverse is set to 0, it might cause a
dev-zero error in following code from __update_writeback_rate(),
	int64_t proportional_scaled =
		div_s64(error, dc->writeback_rate_p_term_inverse);

This patch replaces d_strtoul_nonzero() by sysfs_strtoul_clamp() and
limit the value range in [1, UINT_MAX]. Then the unsigned integer
overflow and dev-zero error can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index d57ab24e9ccd..a5d292707698 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -301,7 +301,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
 			    dc->writeback_rate_i_term_inverse,
 			    1, UINT_MAX);
-	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
+			    dc->writeback_rate_p_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
-- 
2.16.4


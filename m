Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B4FC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECC521903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeLWLKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67A04AF0B;
        Sun, 23 Dec 2018 11:10:52 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 08/11] bcache: fix input overflow to writeback_rate_minimum
Date:   Sun, 23 Dec 2018 19:09:34 +0800
Message-Id: <20181223110937.11559-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dc->writeback_rate_minimum is type unsigned integer variable, it is set
via sysfs interface, and converte from input string to unsigned integer
by d_strtoul_nonzero(). When the converted input value is larger than
UINT_MAX, overflow to unsigned integer happens.

This patch fixes the overflow by using sysfs_strotoul_clamp() to
convert input string and limit the value in range [1, UINT_MAX], then
the overflow can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index a5d292707698..31e41cc3c162 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -304,7 +304,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
 			    dc->writeback_rate_p_term_inverse,
 			    1, UINT_MAX);
-	d_strtoul_nonzero(writeback_rate_minimum);
+	sysfs_strtoul_clamp(writeback_rate_minimum,
+			    dc->writeback_rate_minimum,
+			    1, UINT_MAX);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
-- 
2.16.4


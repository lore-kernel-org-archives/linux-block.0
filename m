Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B357C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBBC20818
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBIEyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:54:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIEyC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:54:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17EECABA1;
        Sat,  9 Feb 2019 04:54:01 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 13/19] bcache: fix potential div-zero error of writeback_rate_i_term_inverse
Date:   Sat,  9 Feb 2019 12:53:05 +0800
Message-Id: <20190209045311.15677-14-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
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
index e4519326594f..0fad46d3a8bd 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -302,7 +302,9 @@ STORE(__cached_dev)
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


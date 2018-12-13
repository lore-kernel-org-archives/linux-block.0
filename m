Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A0C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B0F20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B0F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeLMO4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:56:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728879AbeLMO4G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 882EBAD5C;
        Thu, 13 Dec 2018 14:56:04 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 11/12] bcache: set writeback_percent in a flexible range
Date:   Thu, 13 Dec 2018 22:53:56 +0800
Message-Id: <20181213145357.38528-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because CUTOFF_WRITEBACK is defined as 40, so before the changes of
dynamic cutoff writeback values, writeback_percent is limited to
[0, CUTOFF_WRITEBACK]. Any value larger than CUTOFF_WRITEBACK will
be fixed up to 40.

Now cutof writeback limit is a dynamic value bch_cutoff_writeback,
so the range of writeback_percent can be a more flexible range as
[0, bch_cutoff_writeback]. The flexibility is, it can be expended
to a larger or smaller range than [0, 40], depends on how value
bch_cutoff_writeback is specified.

The default value is still strongly recommended to most of users for
most of workloads. But for people who want to do research on bcache
writeback perforamnce tuning, they may have chance to specify more
flexible writeback_percent in range [0, 70].

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 482b128b3e9d..557a8a3270a1 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -267,7 +267,8 @@ STORE(__cached_dev)
 	d_strtoul(writeback_running);
 	d_strtoul(writeback_delay);
 
-	sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent, 0, 40);
+	sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent,
+			    0, bch_cutoff_writeback);
 
 	if (attr == &sysfs_writeback_rate) {
 		ssize_t ret;
-- 
2.16.4


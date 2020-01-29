Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB715C33CB7
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1CA206F0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgA2Pq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:46:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:37334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgA2Pq0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 10:46:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1500AD3C;
        Wed, 29 Jan 2020 15:46:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Elliott@suse.de, Robert <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/2] nmve/018: Reword misleading error message
Date:   Wed, 29 Jan 2020 16:46:19 +0100
Message-Id: <20200129154619.103332-3-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200129154619.103332-1-dwagner@suse.de>
References: <20200129154619.103332-1-dwagner@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'nvme read' is expected to fail, though the error message "ERROR:
Successfully..." is misleading. Reword the error text to clarify the
real intent of the test and what failed.

Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/018 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/018 b/tests/nvme/018
index d0f15db23538..67d89a6f0b24 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -3,7 +3,7 @@
 # Copyright (C) 2018 Sagi Grimberg
 #
 # Test NVMe out of range access on a file backend. Regression test for commit
-# 9c891c139894 ("nvmet: check fileio lba range access boundaries").
+# 9c891c139894 ("nvmet: check fileio LBA range access boundaries").
 
 . tests/nvme/rc
 
@@ -44,7 +44,7 @@ test() {
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
 
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
-		&& echo "ERROR: Successfully read out of device lba range"
+		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
 	nvme disconnect -n "${subsys_name}"
 
-- 
2.16.4


Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC8C33CB2
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 08:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7110E24681
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 08:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgA1Ios (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:44:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:36988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1Ior (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 03:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBC65AEC1;
        Tue, 28 Jan 2020 08:44:45 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/2] nmve/018: Reword misleading error message
Date:   Tue, 28 Jan 2020 09:44:34 +0100
Message-Id: <20200128084434.128750-3-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200128084434.128750-1-dwagner@suse.de>
References: <20200128084434.128750-1-dwagner@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'nvme read' is expected to fail, though the error message "ERROR:
Successfully..." is misleading. Reword the error text to clarify the
real indent of the test and what failed.

Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/018 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/018 b/tests/nvme/018
index d0f15db23538..aa9681b312f7 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -44,7 +44,7 @@ test() {
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
 
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
-		&& echo "ERROR: Successfully read out of device lba range"
+		&& echo "ERROR: nvme read was successful for out of range lba"
 
 	nvme disconnect -n "${subsys_name}"
 
-- 
2.16.4


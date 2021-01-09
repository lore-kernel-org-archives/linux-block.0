Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A01C433E9
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4148223A58
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbhAIKtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Jan 2021 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIKtO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Jan 2021 05:49:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8AC06179F;
        Sat,  9 Jan 2021 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mDWnaDevg6j/LIqbxuNXDRQmS3LZ4FlK87nsZVHjQJ8=; b=KWvb1OYXxrnn4YYTtLmVo+sUvh
        /iI0OvkVFhTqLsH8n1T/r3RrxIhV/gOys37miH7wINjKVf9TAraHciY9ocqwizsyzQ/j4ESDKuQAC
        SwP9SVrXmj/yVzAxE5vJCfRTVqD2SDUlzvWwzTdQ4YqBgwUgDoMgxquxUnd27AKZP5shJrqbATSHz
        CBFv3TyeQyfWkFKDuubInO3wX1DKHCU/+jtsfauFpqEJacD+JPtCVGKwJaviI2UJnYFN3ku4dPdDy
        /xD7zzRDTGjxaAIYZ1QV8XhjRd7EYCRFFw7Iey938axTcUB7AEbzTtGfVRSdSY9HvIljiEFiORcfd
        FzOH+8bA==;
Received: from [2001:4bb8:19b:e528:4197:a20:99de:e7b0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kyBmY-000TMB-Aq; Sat, 09 Jan 2021 10:47:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
Date:   Sat,  9 Jan 2021 11:42:54 +0100
Message-Id: <20210109104254.1077093-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109104254.1077093-1-hch@lst.de>
References: <20210109104254.1077093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unconditionally call set_disk_ro now that it only updates the hardware
state.  This allows to properly set up the Linux devices read-only when
the controller turns a previously writable namespace read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b6151944131..3a0557ccc9fc5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2114,9 +2114,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if ((id->nsattr & NVME_NS_ATTR_RO) ||
-	    test_bit(NVME_NS_FORCE_RO, &ns->flags))
-		set_disk_ro(disk, true);
+	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
+		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
-- 
2.29.2


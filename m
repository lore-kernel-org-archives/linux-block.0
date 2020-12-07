Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C66C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD4A23436
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLGNWm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgLGNWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 08:22:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A8C0613D2;
        Mon,  7 Dec 2020 05:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F7hUBug/BdYTiR2j7Anf/1DeuPCCgmZdqR6ur3MPmh4=; b=uGd5+FaP3T2QFHwzEtHtmAOjwh
        pJd5+n0tQP26yFPSJClKkFEM40EfvHY83q2RQUGx5i84Xd4dmMqzfxl8kncvFT2tmHbuR47gIqvau
        RRcMeklhytSqP2GXqtg4RMn0hhfKDOyw4MA60Anpxe1ZAWAbYfZ+yPrcmDhV+jbIdi7+BzC5qKm2Q
        I+EdSckTRaiyYhFr8Nsk9hdYYVwL4a0NhZAN6Xp5UoS/0aQiysoLa9k6zEIW6Evjd+N6Z1a/xUueZ
        yL4w58pV7s0LYpqBBErYV9EDKH1MkTYYQjsJ18Tqtt8g5yMpIKHuoXy9j87vFcj2cSJqf1OITPdIE
        l4XnSBEg==;
Received: from [2001:4bb8:188:f36:4fd9:254f:b3b5:5284] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmGSQ-0006Pe-By; Mon, 07 Dec 2020 13:21:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
Date:   Mon,  7 Dec 2020 14:19:18 +0100
Message-Id: <20201207131918.2252553-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207131918.2252553-1-hch@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
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
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24d7f64f14cb15..18cbf92fc4f957 100644
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


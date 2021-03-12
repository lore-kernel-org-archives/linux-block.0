Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAEBC433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7640864F83
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhCLT4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhCLT4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 14:56:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07FC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XJy8tniuny0qL1g4BdNJcH/8gXaSR+aiU4UZ2LShjng=; b=mOIWaZFxJNZ/do8X+r5w41Q4e6
        S9RwQ2+HsEHkuyR16OzsMVQtMJsxoWRlY5oOoZFzzDwhEFPYul5yD7UOUU7Xaubi2KBq+BbEfOJUw
        J+Cqp/Csg+MrEqTf6M8RQv3JOre7Zg3aoCAX96ooIyITbQwpgknVPqw+ezuvzBTW0W7FrBVrATs02
        5LNnPKVqDTmRrBA7wx1lddGLk0Si8rqNvPnFFicZoqb6n91HKrEkB4LcInZF3xwVoDVlszcz9lpUC
        YXNlpWLWSq36Bg/CckKIyTl0q4A+05l+vGvW2CBdx2UfNUgXh1GDGiMOMbdskIAcOPzgYHC5Y1JjW
        ixPNy5lA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKnsn-00BbI7-DI; Fri, 12 Mar 2021 19:55:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     kbusch@kernel.org, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns
Date:   Fri, 12 Mar 2021 20:55:36 +0100
Message-Id: <20210312195536.1432823-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ns can be NULL at this point, and my move of the check from
the original patch by Chaitanya broke this.

Fixes: 0ec84df4953b ("nvme-core: check ctrl css before setting up zns")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82ad5eef9d0c30..a5653892d77392 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4099,7 +4099,7 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (!nvme_multi_css(ctrl)) {
 			dev_warn(ctrl->device,
 				"command set not reported for nsid: %d\n",
-				ns->head->ns_id);
+				nsid);
 			break;
 		}
 		nvme_alloc_ns(ctrl, nsid, &ids);
-- 
2.30.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD45ECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJYOkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E26D76978
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NZfS/qSqw1UkqnhhYI59sDWIlSYgwxD86ecsi6U5cL8=; b=CvhTghZBZmIpMCAwZqxIFlrR/p
        dkgKGjxDwyA3gLhfN/zu9SMxQn0FpKy/8eB9LL83fs4Tq2SYinhXRkjBXMtvL0SJiEdPDLBpRdElH
        ArV3nA9vNQBwB/B69Vu9CK1oKuWRbBLFffRzz/ScDq8TCw827V36YKWBR2M/HFFVAJJXNqdehIaNz
        o0V+PohvgqJ5i5fIJ3W4Jo+9WURKbUeMGJMGgL3DvKAEufHyKUHvd+0tA3WNAVAo+28aMbyf5SkQx
        VlvVDNVgIwFBtGrsc33W/8+Kcv35FI8HhFeXH/QraBMmiu6VjdK2b7SdhC5czfzpZ9d+DHgyMuNjw
        uZqq4D8A==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6M-005pn0-N0; Tue, 25 Oct 2022 14:40:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 07/17] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
Date:   Tue, 25 Oct 2022 07:40:10 -0700
Message-Id: <20221025144020.260458-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never rescan namespaces after marking them dead, so this check is dead
now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2ec838e608509..99eabbe7fac98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4333,10 +4333,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags))
-		goto out;
-
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-- 
2.30.2


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F9C4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKAPIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKAPHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFD1E728
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+0iu+A0Po72NG6PsBiW6InjA/PL4RlYWhhZ8s6hwjKQ=; b=Y4v5OIc0tTDNx87TVR4V5J16uP
        m7Hys8t+VdOYhuqVUnB14wX/4vdYhUhsu1ixbsyb9/MNa13cB4Dh1+gO3pTXyVXoH3EZOksHo8O2F
        0n0kVkoyPxmAfiY9DLqbC5EsN+wJFbSncObpCP1nwdyHndGxoZ8mFF+/xIYMJIm98eJkEU6DNZhlc
        KrxtxD/oztyme6FhCI37+eOmHy9RwnVAVrcpW+IBWsIJZdJiGV9k1dXbx9eKme98OAq5KjKq4wv40
        Z3b1VPErwJH+lRrl9ybeVji6vegOaVIW3IeiPRgadC30GPE0chKzt6j1ZtcifuZRUrZl7rprBFw1N
        +pTKdpPQ==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslL-005gj1-0g; Tue, 01 Nov 2022 15:01:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/14] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
Date:   Tue,  1 Nov 2022 16:00:41 +0100
Message-Id: <20221101150050.3510-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At the point where namespaces are marked dead, the controller is in a
non-live state and we won't get pass the identify commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 390f2a2db3238..871a8ab7ec199 100644
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


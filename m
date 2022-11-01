Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A041C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKAPIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKAPHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F61E709
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VftSGhpevZu6/5y82Vykr3F9H9L8vKbEyML7+10xdA4=; b=sO/Ocqo4arwe7z6saGd3iA1SxP
        wJhVK1QAXSrMda9/aBLdRa7oCX8GB90Wtx9w0SvtXVPwzym/FhLbp5JYjER3ls3tv5JvnS+z7nbT5
        S2TYlIqe8tMDJWivUpqGVvPJa8fTOv/xGia6chhB34Tl1Vg5O9eSS2ofGeTThYJ3VhZKVzkl3TlR9
        17lfU6U+ncDcKrm+6AKKsv2LQGE9NwmAc6SxE8riTPTt1+CVOq+C4fyXZ/SKnwduaV2zjn4x4XDxd
        pt8LpfyWXpVeT3Skn5sktbU9xcw2AnsBM+QInAtWVmHBjfbhnP7dSNELroe2VXk9DekMQOsxt1bdC
        p5urW9xg==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslI-005giM-8a; Tue, 01 Nov 2022 15:01:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 04/14] nvme: remove the NVME_NS_DEAD check in nvme_remove_invalid_namespaces
Date:   Tue,  1 Nov 2022 16:00:40 +0100
Message-Id: <20221101150050.3510-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The NVME_NS_DEAD check only made sense when we revalidated namespaces
in nvme_passthrough_end for commands that affected the namespace inventory.
These days NVME_NS_DEAD is only set during reset or when tearing down
namespaces, and we always remove all namespaces right after that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 35386aa24f589..390f2a2db3238 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4407,7 +4407,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
+		if (ns->head->ns_id > nsid)
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
-- 
2.30.2


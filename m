Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16EC4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKAPIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKAPHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2177622501
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UWJJITfRoSb//57QGaQg0nyw7JGk+8FSnAd0y+59s9Q=; b=h6jEHoDFnd0GlzMsGzargZA2YN
        lJxkEkNTpbbDr3bb0dFR00femFT60FCbN1l6wiGG3XiiycpLhXktZI5jfRTEXg6GSva5AMBOy8gxs
        qI8f7up2Qmr/SiPCqEmnuBB4TbnRwsS5MQiu/G6TBYZU/PwRa683onOj+RIbUQH9DBwwqjhEZ4zw2
        zEV8uovyboyL9+gcq7hLQZPJqprahSJTZyE4TgEF19nN8t6d/dR0sthTR3qSOU7ypWVeXdZRdRZx8
        ni+pydZiBK+rioV9vJNeUXvlLabTTd2YYt7UozfUZc+x+JKKUZCwhJUJJSOvSoy/28jhh5oHu9HSs
        ZZRKCB+g==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslC-005gex-65; Tue, 01 Nov 2022 15:01:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 03/14] nvme: don't remove namespaces in nvme_passthru_end
Date:   Tue,  1 Nov 2022 16:00:39 +0100
Message-Id: <20221101150050.3510-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The call to nvme_remove_invalid_namespaces made sense when
nvme_passthru_end revalidated all namespaces and had to remove those that
didn't exist any more.  Since we don't revalidate from nvme_passthru_end
now, this call is entirely spurious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aea0f89acf409..35386aa24f589 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1118,7 +1118,6 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
 		mutex_unlock(&ctrl->subsys->lock);
-		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
-- 
2.30.2


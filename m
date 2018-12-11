Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF5C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89182084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NYXgIPF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89182084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKXhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLKXhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QDX1HDPRZDcH1UGedTfNRuSknUh2xNTsqrVUS3lY3bs=; b=NYXgIPF8Gipwgq5PYBDLQeOGc
        3lLkXe72BRMbzhmKjUh3tuDeaHbLze7SDceG7Bm2dESCvAmQ0u8LRBoTaHenDfP7g3K5sS/EQLuYg
        J7CdTG09yltoOMJ+grh7qyVb30Fm0ruokVT3j/XoAbQb2aE4TjDBwFFhS4sh1ssZwoBGp/N5XahvA
        F42iLMup+GE0j2cdq3wIYng8A1BhmQnURaR4AcGxPqmm1P9VJrQf0UytTA+V4+UyOjeWbOcImOiJy
        4h85qDJdeCG1rRrdiac+Jl3GrcD6ODr9DhjAIBgjB/MyoO5URm7ZToR2Ka4OVAhtlNpaTqttK4pVU
        oT8p2hWfQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraE-0003uQ-67; Tue, 11 Dec 2018 23:36:58 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying namespace request queue
Date:   Tue, 11 Dec 2018 15:36:51 -0800
Message-Id: <20181211233652.9705-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the multipath device does not support polling (yet) we cannot
pass requests to the polling queue map as those will not generate
interrupt so we cannot reap the completion.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f90576862736..511d399a6002 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		/* XXX: multipath device does not support polling for now... */
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
 	}
 #endif
 }
-- 
2.17.1


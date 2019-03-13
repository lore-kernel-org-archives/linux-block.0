Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682EC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6D92077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oo/4qioH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfCMRzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMRzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b1vlBEzkPKwpgX79j/BAmMc+eFKWOGuItojN2BSGn9w=; b=oo/4qioHAPq64UvxzNPnNN3rs2
        wempBSfEMRAATZV/KxPurTxI4i1hJpTS0dGoFvCJHnxNnM+W7n8xNdcSryRb8VopUapne6XY4YExW
        iywkO45hxIbpMoYMS7ZG4LDMAJoJiMouCLN0ve1BBHt987eFn2+/oAo36yD3NkVRDCmd0w6nD42Jj
        HlvL5B7wKv2QHbjS3WtXixw16McbD9P5dkyNcau04ByoPJCKfDamDVfxurFoZPMRWcCaBDPuuHk5m
        Z8o1aiO8W0M+GRn9bHM0kj71TDJWsANb7z4G180aiEli367JPMh0/WVCZdahmSGvrfwt0STsvyeQo
        7qltLHwg==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486H-0001GA-0p; Wed, 13 Mar 2019 17:55:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 03/17] nvme-trace: fix cdw10 buffer overrun
Date:   Wed, 13 Mar 2019 18:54:56 +0100
Message-Id: <20190313175510.20725-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

The field is defined to be a 24 byte array, we don't need to multiply
the sizeof() that field by the number of dwords it covers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 244d7c177e5a..97d3c77365b8 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -108,7 +108,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
-			6 * sizeof(__entry->cdw10));
+			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
-- 
2.20.1


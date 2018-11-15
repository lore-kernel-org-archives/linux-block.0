Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838DC04EBF
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9132087A
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i80L+qIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9132087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeKPDZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388798AbeKPDZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Qr3b/AsTNiTwjLfyZDegbne9wAM0t8Q5qaMzqUhEzw=; b=i80L+qItwXwbAC8HNCI3EiJMR
        4vkOUtEtF18scqHO3q9BXfTGPojXYAvlmbJ+wPpnzzS/+UT7kjp2AqW8N5b6hmPosAMGE0wdPiHyi
        TcAr8x52yGZT//hoawcFEeGT4HOzUFBN83snlKZgk2TpkK00qaeHt2TmbdBmbx6Vva3QCZMgg2ztb
        HTcd66hbAmcMhFn/1w/dKClsaTnj2lLN8bqyKMcV0IoV+xU4mr2YNdf31OEEu2eHPKqhLfo7MrhJR
        4WuU9wSp/+3SS8Vij0olWard1GkcEResc38pkdkcpzKtFFjX8oI9hpvf4pngPCegeaLbXTkmvIzN7
        gpqNdLWJg==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFt-0002LK-A4; Thu, 15 Nov 2018 17:16:37 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH nvme-cli 12/11] nvme: Add TCP transport
Date:   Thu, 15 Nov 2018 09:16:24 -0800
Message-Id: <20181115171626.9306-13-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c    | 5 ++++-
 linux/nvme.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index aee566d5f68d..6fd9dfaa5d79 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -96,6 +96,7 @@ static const char *arg_str(const char * const *strings,
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
@@ -699,11 +700,13 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
 			/* FALLTHRU */
-			len = sprintf(p, ",transport=rdma");
+			len = sprintf(p, ",transport=%s",
+				e->trtype == NVMF_TRTYPE_RDMA ? "rdma" : "tcp");
 			if (len < 0)
 				return -EINVAL;
 			p += len;
diff --git a/linux/nvme.h b/linux/nvme.h
index a6a44b066267..7a600c791877 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -52,6 +52,7 @@ enum {
 enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP		= 3,	/* TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.17.1


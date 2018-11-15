Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A97C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8FB223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bns7NkzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8FB223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbeKPDZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388798AbeKPDZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WPgDAppmWhRkF/LVotZdtI3NM7b33Jp6Gk4leWnIhO4=; b=Bns7NkzD1tLA/636kerVauVyo
        apGArrMNcjhEBExWukR0DfRFBXy4vMV72JQ5RnyWmVfRkvJy4HFiKQZMZ9FSe51ytr6ljNkf+0Y8S
        AIH2S2hLyKqfA7zgyTEtwKRwVkZoIbIIkXdbMxyRaHQlBoMuN2707cId1Q0mSD2P2YYaCMOOQwume
        IhZJN8nynwHfuPi2Ghoz6bPM4BnHFBKbd7OvUXzT8J1Ymph9ykytalhqrRk7SJn5yMvaOJrCTa/cf
        zyVShIQw/rgnCsV8fzNsTUCy7jAWjduAmt304SIV2MCbK9EztRrQSDr/NCxl7Y4GrADCNG+67Zk7E
        NjhBUZpjw==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFu-0002LK-0o; Thu, 15 Nov 2018 17:16:38 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH nvme-cli 13/11] fabrics: add tcp port tsas decoding
Date:   Thu, 15 Nov 2018 09:16:25 -0800
Message-Id: <20181115171626.9306-14-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tcp tsas include sectype indication for unsecured/tls ports.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c    | 14 ++++++++++++++
 linux/nvme.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 6fd9dfaa5d79..774ea94dc0db 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -141,6 +141,16 @@ static inline const char *treq_str(__u8 treq)
 	return arg_str(treqs, ARRAY_SIZE(treqs), treq);
 }
 
+static const char * const sectypes[] = {
+	[NVMF_TCP_SECTYPE_NONE]		= "none",
+	[NVMF_TCP_SECTYPE_TLS]		= "tls",
+};
+
+static inline const char *sectype_str(__u8 sectype)
+{
+	return arg_str(sectypes, ARRAY_SIZE(sectypes), sectype);
+}
+
 static const char * const prtypes[] = {
 	[NVMF_RDMA_PRTYPE_NOT_SPECIFIED]	= "not specified",
 	[NVMF_RDMA_PRTYPE_IB]			= "infiniband",
@@ -450,6 +460,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 			printf("rdma_pkey: 0x%04x\n",
 				e->tsas.rdma.pkey);
 			break;
+		case NVMF_TRTYPE_TCP:
+			printf("sectype: %s\n",
+				sectype_str(e->tsas.tcp.sectype));
+			break;
 		}
 	}
 }
diff --git a/linux/nvme.h b/linux/nvme.h
index 7a600c791877..68000eb8c1dc 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -91,6 +91,13 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
+/* TCP port security type for  Discovery Log Page entry TSAS
+ */
+enum {
+	NVMF_TCP_SECTYPE_NONE	= 0, /* No Security */
+	NVMF_TCP_SECTYPE_TLS	= 1, /* Transport Layer Security */
+};
+
 #define NVME_AQ_DEPTH		32
 #define NVME_NR_AEN_COMMANDS	1
 #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
@@ -1184,6 +1191,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
-- 
2.17.1


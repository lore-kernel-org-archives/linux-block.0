Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F8C04EBA
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6552080F
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBKfoyb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6552080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbeKVMdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404060AbeKVMd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rXWYBlCCjPXyzbQZOTDFMAObyJoxlnFcn6sfPQ5ARx0=; b=GBKfoyb4BLREzBSzokYnu1Phm
        8LpyzipgDUnYO6pwWFv/C+9NI0tjO6gxS29dJKLJXX5pYJZZplpmAhMLLaCcEkAXULMP3r4lVnHzZ
        ZSEUnA0EA4gXkx34Lbi7qOzll7i+yGyY7Dr49rmp1qCyvMRCTI+MqRjGLS/ANTdxmgxe7Rgfze59c
        sBfePhw+611gDLul1H4W/K1TlB7yzfY6PZ+4wooZfm0qZRRbkr+H/RwsmM9AwN555u1mr0TbH7GVt
        gjKNuIBpmt2hMMzaa2lyUe8bT+XGbY+EgAULOAq0g2V3gRu1CgB5SjZnGziiKF4usdYF6iF8+IZ73
        yqgm1NWRg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE9-0006v0-MX; Thu, 22 Nov 2018 01:56:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH nvme-cli v3 16/13] fabrics: add tcp port tsas decoding
Date:   Wed, 21 Nov 2018 17:56:14 -0800
Message-Id: <20181122015615.15763-17-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

tcp tsas include sectype indication for unsecured/tls ports.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c    | 14 ++++++++++++++
 linux/nvme.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 86f6f992b14f..f8e03de46632 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -140,6 +140,16 @@ static inline const char *treq_str(__u8 treq)
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
@@ -436,6 +446,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
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


Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7480DC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBCE2089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYSQ49tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBCE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeKTN1Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732762AbeKTN1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PDijDYto6DdWkqAK8TNNvd+AcX6lrhZncoX14Klin64=; b=XYSQ49tHjVn3VihkRiQmAhmUE
        D+lGJyfAlu/iIO+5axnNx1NpMBGLHi392YqARWwv/CD7jux64J0on1y60yeBtiw0NzsZHXn9YIPsE
        PXY6VnRbEw5vtn7YB2W0IRF6SaWffwZhJsRsi2nu7Cib6qZCQT9GBcHqTXiD6s772SoBGd4ditlEb
        121OCkXC5AKe2lwNvoAOfcDSQGa267Dh/SNuChvTYWtRV6OPjtxQsEGt88T75xRWklA1U5nJ4/+Jc
        gdbJ0xozK14yPtcUF7sBe2N2LTTDQOxjOL98mzeR+BXXiThL/iXU3dK4o69qlRngK86MwRcnuIGSs
        dOq19//kg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH8-0000FW-3r; Tue, 20 Nov 2018 03:00:30 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH nvme-cli v2 16/14] fabrics: add tcp port tsas decoding
Date:   Mon, 19 Nov 2018 19:00:18 -0800
Message-Id: <20181120030019.31738-18-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
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
index b4fac97253ba..3df273894632 100644
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


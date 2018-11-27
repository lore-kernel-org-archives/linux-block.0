Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B45C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D834920851
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccudu01v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D834920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK1KP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeK1KP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C/Vv7dY3jag/qT3NsL4IY2O8e7ebC1FbRmTR0jRGd9s=; b=ccudu01v3c2bcldRvMVJGK5BH
        iQPTeuivSBtDUJ83PkBAiuPqYcR4hvM+H2H2FcCpqe8yj0acPigophUD0NYQVzTnU52fhxtoQioJ4
        Fq6ngKvC1qNiRgMaJDpDeQGOUNtC/a2odSrftdDOXA/HndL06+9iNTOw6P9QoFnr2AZGHE89WjHWr
        A9J/e4sa6yKVtVAH2hE2EMoIldcUylW2sn19EA+n0C9KaNwZEayhjgQyWa4sYQdWWoz1UBKZcOhBG
        d9xCcYW2KoK6PMs3AxtxIgS+wP4yJJG5aEnAAikE5ZD6ebJEuYpetX9g0BTfI+04oJQ5dbOaXV9fW
        uQE92rfeA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRmad-0007cp-JF; Tue, 27 Nov 2018 23:16:23 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 10/13] nvme-tcp: Add protocol header
Date:   Tue, 27 Nov 2018 15:16:12 -0800
Message-Id: <20181127231615.9446-11-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/nvme-tcp.h | 189 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     |   1 +
 2 files changed, 190 insertions(+)
 create mode 100644 include/linux/nvme-tcp.h

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
new file mode 100644
index 000000000000..03d87c0550a9
--- /dev/null
+++ b/include/linux/nvme-tcp.h
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics TCP protocol header.
+ * Copyright (c) 2018 Lightbits Labs. All rights reserved.
+ */
+
+#ifndef _LINUX_NVME_TCP_H
+#define _LINUX_NVME_TCP_H
+
+#include <linux/nvme.h>
+
+#define NVME_TCP_DISC_PORT	8009
+#define NVME_TCP_ADMIN_CCSZ	SZ_8K
+#define NVME_TCP_DIGEST_LENGTH	4
+
+enum nvme_tcp_pfv {
+	NVME_TCP_PFV_1_0 = 0x0,
+};
+
+enum nvme_tcp_fatal_error_status {
+	NVME_TCP_FES_INVALID_PDU_HDR		= 0x01,
+	NVME_TCP_FES_PDU_SEQ_ERR		= 0x02,
+	NVME_TCP_FES_HDR_DIGEST_ERR		= 0x03,
+	NVME_TCP_FES_DATA_OUT_OF_RANGE		= 0x04,
+	NVME_TCP_FES_R2T_LIMIT_EXCEEDED		= 0x05,
+	NVME_TCP_FES_DATA_LIMIT_EXCEEDED	= 0x05,
+	NVME_TCP_FES_UNSUPPORTED_PARAM		= 0x06,
+};
+
+enum nvme_tcp_digest_option {
+	NVME_TCP_HDR_DIGEST_ENABLE	= (1 << 0),
+	NVME_TCP_DATA_DIGEST_ENABLE	= (1 << 1),
+};
+
+enum nvme_tcp_pdu_type {
+	nvme_tcp_icreq		= 0x0,
+	nvme_tcp_icresp		= 0x1,
+	nvme_tcp_h2c_term	= 0x2,
+	nvme_tcp_c2h_term	= 0x3,
+	nvme_tcp_cmd		= 0x4,
+	nvme_tcp_rsp		= 0x5,
+	nvme_tcp_h2c_data	= 0x6,
+	nvme_tcp_c2h_data	= 0x7,
+	nvme_tcp_r2t		= 0x9,
+};
+
+enum nvme_tcp_pdu_flags {
+	NVME_TCP_F_HDGST		= (1 << 0),
+	NVME_TCP_F_DDGST		= (1 << 1),
+	NVME_TCP_F_DATA_LAST		= (1 << 2),
+	NVME_TCP_F_DATA_SUCCESS		= (1 << 3),
+};
+
+/**
+ * struct nvme_tcp_hdr - nvme tcp pdu common header
+ *
+ * @type:          pdu type
+ * @flags:         pdu specific flags
+ * @hlen:          pdu header length
+ * @pdo:           pdu data offset
+ * @plen:          pdu wire byte length
+ */
+struct nvme_tcp_hdr {
+	__u8	type;
+	__u8	flags;
+	__u8	hlen;
+	__u8	pdo;
+	__le32	plen;
+};
+
+/**
+ * struct nvme_tcp_icreq_pdu - nvme tcp initialize connection request pdu
+ *
+ * @hdr:           pdu generic header
+ * @pfv:           pdu version format
+ * @hpda:          host pdu data alignment (dwords, 0's based)
+ * @digest:        digest types enabled
+ * @maxr2t:        maximum r2ts per request supported
+ */
+struct nvme_tcp_icreq_pdu {
+	struct nvme_tcp_hdr	hdr;
+	__le16			pfv;
+	__u8			hpda;
+	__u8			digest;
+	__le32			maxr2t;
+	__u8			rsvd2[112];
+};
+
+/**
+ * struct nvme_tcp_icresp_pdu - nvme tcp initialize connection response pdu
+ *
+ * @hdr:           pdu common header
+ * @pfv:           pdu version format
+ * @cpda:          controller pdu data alignment (dowrds, 0's based)
+ * @digest:        digest types enabled
+ * @maxdata:       maximum data capsules per r2t supported
+ */
+struct nvme_tcp_icresp_pdu {
+	struct nvme_tcp_hdr	hdr;
+	__le16			pfv;
+	__u8			cpda;
+	__u8			digest;
+	__le32			maxdata;
+	__u8			rsvd[112];
+};
+
+/**
+ * struct nvme_tcp_term_pdu - nvme tcp terminate connection pdu
+ *
+ * @hdr:           pdu common header
+ * @fes:           fatal error status
+ * @fei:           fatal error information
+ */
+struct nvme_tcp_term_pdu {
+	struct nvme_tcp_hdr	hdr;
+	__le16			fes;
+	__le32			fei;
+	__u8			rsvd[8];
+};
+
+/**
+ * struct nvme_tcp_cmd_pdu - nvme tcp command capsule pdu
+ *
+ * @hdr:           pdu common header
+ * @cmd:           nvme command
+ */
+struct nvme_tcp_cmd_pdu {
+	struct nvme_tcp_hdr	hdr;
+	struct nvme_command	cmd;
+};
+
+/**
+ * struct nvme_tcp_rsp_pdu - nvme tcp response capsule pdu
+ *
+ * @hdr:           pdu common header
+ * @hdr:           nvme-tcp generic header
+ * @cqe:           nvme completion queue entry
+ */
+struct nvme_tcp_rsp_pdu {
+	struct nvme_tcp_hdr	hdr;
+	struct nvme_completion	cqe;
+};
+
+/**
+ * struct nvme_tcp_r2t_pdu - nvme tcp ready-to-transfer pdu
+ *
+ * @hdr:           pdu common header
+ * @command_id:    nvme command identifier which this relates to
+ * @ttag:          transfer tag (controller generated)
+ * @r2t_offset:    offset from the start of the command data
+ * @r2t_length:    length the host is allowed to send
+ */
+struct nvme_tcp_r2t_pdu {
+	struct nvme_tcp_hdr	hdr;
+	__u16			command_id;
+	__u16			ttag;
+	__le32			r2t_offset;
+	__le32			r2t_length;
+	__u8			rsvd[4];
+};
+
+/**
+ * struct nvme_tcp_data_pdu - nvme tcp data pdu
+ *
+ * @hdr:           pdu common header
+ * @command_id:    nvme command identifier which this relates to
+ * @ttag:          transfer tag (controller generated)
+ * @data_offset:   offset from the start of the command data
+ * @data_length:   length of the data stream
+ */
+struct nvme_tcp_data_pdu {
+	struct nvme_tcp_hdr	hdr;
+	__u16			command_id;
+	__u16			ttag;
+	__le32			data_offset;
+	__le32			data_length;
+	__u8			rsvd[4];
+};
+
+union nvme_tcp_pdu {
+	struct nvme_tcp_icreq_pdu	icreq;
+	struct nvme_tcp_icresp_pdu	icresp;
+	struct nvme_tcp_cmd_pdu		cmd;
+	struct nvme_tcp_rsp_pdu		rsp;
+	struct nvme_tcp_r2t_pdu		r2t;
+	struct nvme_tcp_data_pdu	data;
+};
+
+#endif /* _LINUX_NVME_TCP_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c03973c215ad..4793dc06cda1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -52,6 +52,7 @@ enum {
 enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.17.1


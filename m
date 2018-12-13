Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327BC67873
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1DD2087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knWpOM5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1DD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLMGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4wci21UjYJSKYSW0n8T5hqXANAES1mjdD4Vql/GFcbM=; b=knWpOM5gzlL+lPq014FVDW2Vt
        tN3/nE3U8Lb8FsE5kyXqULlxg8Xabaw52Z8GQ/KFCv5+7BGvqVPqwc1mk9L4QFJYD61OSug1yODqJ
        KT39ojAKfjoit8PPwkIB2J9oDJsGV7o/GhBOXKbqa7Lufq1TSTN91smdJpzj0/h8G9GpbuKiLHF47
        bWCu7ScUXZdPy/oaPfgY0VDayyWl+teMTSI1eVj3yz44arswtDFAdTUUtJs5mLOKO0chFqbD3pfCZ
        GVBSCDTsaEwuF8MHy5VHfg0GLvoioXCZDD1Lah1SN/2EZWpigOAV/7+vUYpp1yQpYq0WlKlaojFg9
        i77wjTo6A==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKdZ-0006LR-Jb; Thu, 13 Dec 2018 06:38:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 4/6] nvme-fabrics: allow user to pass in nr_poll_queues
Date:   Wed, 12 Dec 2018 22:38:16 -0800
Message-Id: <20181213063819.13614-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument will specify how many polling I/O queues
to connect when creating the controller. These I/O queues
will host I/O that is set with REQ_HIPRI.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 13 +++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5ff14f46a8d9..b2ab213f43de 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -617,6 +617,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
 	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
+	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -850,6 +851,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->nr_write_queues = token;
 			break;
+		case NVMF_OPT_NR_POLL_QUEUES:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token <= 0) {
+				pr_err("Invalid nr_poll_queues %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->nr_poll_queues = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index cad70a9f976a..478343b73e38 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -62,6 +62,7 @@ enum {
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
 	NVMF_OPT_DATA_DIGEST	= 1 << 16,
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
+	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 };
 
 /**
@@ -93,6 +94,7 @@ enum {
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
  * @nr_write_queues: number of queues for write I/O
+ * @nr_poll_queues: number of queues for polling I/O
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -113,6 +115,7 @@ struct nvmf_ctrl_options {
 	bool			hdr_digest;
 	bool			data_digest;
 	unsigned int		nr_write_queues;
+	unsigned int		nr_poll_queues;
 };
 
 /*
-- 
2.17.1


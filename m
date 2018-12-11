Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D398EC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E892084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IIFkeF7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E892084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLKXhD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLKXhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yIB3JTVbUriwq3pCLTQwSP546N6Ac2IalBzLS97RbvI=; b=IIFkeF7J52G+4D3oTJzUQo6Yd
        qrtvTrqdgPyNhMUjKx5hQj+Q/zcDWuTFVWiTOou1Jp73Ef3jKwJu3l8melTfjJ84B3uFz/vEgX64q
        dqk/K3hZjVQ1RbYBUxZZgALQUC4p8nAKH2VrzUM/3ALAccDQrXtkhOpYN6FHuVFiBkKwpGfjgUaaA
        /ldok8w1JHMU3JHDrldgvmXxb6fhQE/SLqszKTzpTDM9SoZ1d4ZH+M8M+ie1slo/nOeUyi8C9/8l3
        /2pKeptPPTozmk+o3kKNbpTkCCgMjld5oqbNu4irK29VfNqqIxiVW6G7NUaLJGqDizndOvit6PaWQ
        MXWzQjCPg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraD-0003uQ-AD; Tue, 11 Dec 2018 23:36:57 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC 1/4] nvme-fabrics: allow user to pass in nr_poll_queues
Date:   Tue, 11 Dec 2018 15:36:48 -0800
Message-Id: <20181211233652.9705-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument will specify how many polling I/O queues
to connect when creating the controller. These I/O queues
will host I/O that is set with REQ_HIPRI.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 066c3a02e08b..f43bd1eada1c 100644
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
@@ -967,7 +980,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES)
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES | \
+				 NVMF_OPT_NR_POLL_QUEUES)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 81b8fd1c0c5d..36f5daf05f08 100644
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


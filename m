Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2642C67872
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8742420870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhseYV+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8742420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Me2EXf8Lf/FymXBeB/t93ECMFv73VIvVkZ9hziygPvU=; b=MhseYV+YxBlUTswzm6tmwtRD+
        8nj/yIYj4sUU8OoE0cA9z5SEvTzxwEFw8IutZQXrjO7asyOURJwnbNgJk5cPYXZb56wS9huZVuZiO
        QVkheM/8K7qQSivAD7gXVpLeJbaOrKEehCeTH9+uPpmctIs++Anvc98czzh/oh/mDsLN6HS6GcxnX
        jzCSlgXyEq+N9yAq8HLsb3/c0a6m9CzNpP+aZxzo2Itlk1fezkO/uKB2EbsQJ+kc2H5O4NJvci80s
        Pdklb3zk9EEHwPgo2S3XqftwqQr58jksIaRM2a9qO/OZldW0lR45nxBS5BCisiEBBbT/Eup5iVa/m
        nJtTBs+CQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYh-0002L4-HE; Tue, 11 Dec 2018 23:35:23 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 3/5] nvme-fabrics: allow user to set nr_write_queues for separate queue maps
Date:   Tue, 11 Dec 2018 15:35:16 -0800
Message-Id: <20181211233519.9350-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument will specify how many I/O queues will be connected
in create_ctrl in addition to nr_io_queues. With this configuration,
I/O that carries payload from the host to the target, will use
the default hctx queue map, and I/O that involves target to host
transfers will use the read hctx queue map.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 15 ++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9c62c6838b76..066c3a02e08b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -616,6 +616,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
 	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
+	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -837,6 +838,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DATA_DIGEST:
 			opts->data_digest = true;
 			break;
+		case NVMF_OPT_NR_WRITE_QUEUES:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token <= 0) {
+				pr_err("Invalid nr_write_queues %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->nr_write_queues = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -954,7 +967,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 28dc916ef26b..81b8fd1c0c5d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -61,6 +61,7 @@ enum {
 	NVMF_OPT_DISABLE_SQFLOW = 1 << 14,
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
 	NVMF_OPT_DATA_DIGEST	= 1 << 16,
+	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 };
 
 /**
@@ -91,6 +92,7 @@ enum {
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
+ * @nr_write_queues: number of queues for write I/O
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -110,6 +112,7 @@ struct nvmf_ctrl_options {
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
+	unsigned int		nr_write_queues;
 };
 
 /*
-- 
2.17.1


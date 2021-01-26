Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4FC41621
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51F72067C
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhAZV5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:57:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44616 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393501AbhAZRvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 12:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611683478; x=1643219478;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mv3WEn2pcMjWOdfGVl7WT3gSU4WDy6fGoCjl3MPHc1g=;
  b=UO/n+NAhmi0rbbo41D1n1BmMz2EOyJZz54LDrzRSHgQq3qEzPwVZNUHT
   kUtjQ0Y9juDQ+naUh/2tPevZ+KQXFFFHf7URdvceAa0D4KoIYvFZ3UpBJ
   l62xE+gDABEcLUO8mydkhKDyKzBcW8/M4gPAzw9qA2FocxzQnEbJi5cuv
   q6o+8IsZMuCl2+SXS3Nz5k1RGqXAE220cm5jW5IBToVPDyOjkBMU3Tvcp
   cpBknblaIh/xCxqNvXCpfmWFY9fChFQXYxm77IrJw8YlXH5uCvJveuU4Z
   kCPP0CmnGnV4U3L17JekieZWI09CZhWUlxAFqe+IfPs6CpdWkVQE6u1Ax
   g==;
IronPort-SDR: dviz7rgVrOf8owJc2EO9IDLVk5Et8SPOxw9CiOvjCJE/Tk7DURZLDFc1kVO8Icy5OcX9PKg9pI
 Z5yMylHEGTihykOfvDy5SzGWJHn1thF1WHehPnyXFx/mKGBYPc2e2UZdrz60HDMSUtcofMRFo7
 /JZrUtuTgfoOs3dpzri/WvAoneUfbZyMNKK25ebSRHHWW4f88iUiH9ZcEQPiF1upgU+y3sPd7I
 TSAPk2ScWE9JMylBKZuk/co1HzmpYACrIwdgZYtaU3w+E7sXn4jwBDB43fjmSkRVFiLis5olYT
 72w=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="162819787"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 01:50:11 +0800
IronPort-SDR: HFyIPqC7lddJM805O33FqPTpa9Oo+7uJInWiz4NsliOaD+ZyUE6Li+0qYp915EnMq/EsR+J9x5
 yTM2T3jBgRWP9ljvUvHu3MgWHx7Mz5zpQmSFPGKYWBZ4hiAHFFSVUy6PJxARHYVx3V3MJ02+o/
 AwiST7GieyxhIxg7NgihIkuw5NUMgm5myx0qvKOCCFEA3m14lV9TJ1hu6yH9pK0380AGhah4nL
 B9FAocEi9GVB75Gp7/CtaoOdxP8RX4cJU7ZThbPjAZ/7XORNCyAGPDgOSAgo8sB2LO95TYWtFV
 IviP6eUndpX8MW6YyPzMavQA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 09:32:35 -0800
IronPort-SDR: +OMEKigUfdY1CdtekM1oktsOyUYGzgoEqidNNzhZMZBCRtQoECS+lxNljOQE3cgTJw+cC+fOKz
 W9YNDhG7onP3UOEBnO56bKyKwUsrZ7JG/KIxxvcP7fX7ru9gDBzwBuPPzTpJjC1oO5KE+HcvoP
 1QN4S7ciI8iFCBSvknRsnl/7aRCKRRNJHLcdRJrjJaizl7gQyTxMZF94ilwzWMojNDQe5KPeJf
 T00GhCMC0TFYv9dRLYP9eDADHFYkIVI+1bbL4bt7PbPUV8GNHzUuehGyz8pfOyFIHDRQZgTDBa
 +1U=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2021 09:50:11 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] nvme: add tracing of zns commands
Date:   Wed, 27 Jan 2021 02:50:00 +0900
Message-Id: <46eeed2fcf2530d02fe5727a0a91a6e4675f6edd.1611683161.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When support for the NVMe ZNS commands was merged, tracing of these has
been omitted.

Add nvme_cmd_zone_mgmt_send, nvme_cmd_zone_mgmt_recv as well as
nvme_cmd_zone_append to the nvme driver's tracing facility.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/nvme/host/trace.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |  6 +++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5c3cb6928f3c..9f9b6108de7d 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -131,6 +131,35 @@ static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u8 zsa = cdw10[12];
+	u8 all = cdw10[13];
+
+	trace_seq_printf(p, "slba=%llu, zsa=%u, all=%u", slba, zsa, all);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u32 numd = get_unaligned_le32(cdw10 + 8);
+	u8 zra = cdw10[12];
+	u8 zrasf = cdw10[13];
+	u8 pr = cdw10[14];
+
+	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u, pr=%u",
+			 slba, numd, zra, zrasf, pr);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -171,9 +200,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 	case nvme_cmd_write_zeroes:
+	case nvme_cmd_zone_append:
 		return nvme_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvme_trace_dsm(p, cdw10);
+	case nvme_cmd_zone_mgmt_send:
+		return nvme_trace_zone_mgmt_send(p, cdw10);
+	case nvme_cmd_zone_mgmt_recv:
+		return nvme_trace_zone_mgmt_recv(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bfed36e342cc..325dcdd221de 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -697,7 +697,11 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
+		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
+		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
+		nvme_opcode_name(nvme_cmd_zone_append))
+
 
 
 /*
-- 
2.26.2


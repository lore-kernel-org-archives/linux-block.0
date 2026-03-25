Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2C262FD0;
	Wed, 25 Mar 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446598; cv=fail; b=PoaSMCJwT0NxwOiffKu5eGF4VBo3SaSftsgS3acOgWbPo5PdZFgXFjjW8Zhj4rAElk4SywhHMVxLTrP3klhoF8i6GvVOM3aKqCRA48e6SlkyIf9QMXeBbEUPf1hTbJN11zH5TXOeoLoQkzPKHuTC/c4Xz9O4v2u2NdKrZp5kPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446598; c=relaxed/simple;
	bh=g+DlgoNjFuulB8j9CF78AlOo6tRUpnp42OAiyzWEMVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t40/TA21u4PIopgPhdByswTsZPdRJkVT4JgtJ3fZGF64gjUtrQSr6QN9TC0YU+wAHzdvMqHfNdZKCIfMFacWiVPI5oVU1L5IHNhyWOhMvoCDbt5tINIH5dek0unvwPQPfRjZrFCvKs521ilibvD/4gpevJQeaI5p/2eg8PDW5M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Pi1sx+TW; arc=fail smtp.client-ip=52.101.57.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pi1sx+TW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utsfBqdGFv4/iGdapnJDgU3a9hIV5rrQXMFmT1nar++4JJLeLmzzCF3u5XXW6f71eUXGWNxGi3p+cfZZhn+QwapRY0m4MOoqyrcQsobJhzLN6PSAHQXbWj0X/j58nvzq/8lTUeBiIKLxadMPFqnYwPkp5QWdOjJRnGVOujvAFzl7iEbY78Vpa0BSbeRQqRK5stPubpdFqNkJ/NEMLWYs2G1qk8RVxS9iFos0WB2lOGewj2ufM+p/g+kSCDjU+j7TT8E949+s9NNgQaBJV7VL0LwPOBYKx86jjt8QVTLn8v1oafLaQy5uDFe+qrs1V524m08R5Y6XlfhqvaG6t9bKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRXQVjedF/C9uPWVioVU6E3C4+/hYBE5eUwFQ0tUw8g=;
 b=I5p/R1CUU5Nk8SuCIVY4CpFTW8EQWMQeTX5Z90CTGjBD4DMn1AgXOxOFU9PRgHrPvHxHq9xNbcfdy5OtV/gJUm1O+gSZk2RD0wCvxHUGNFtcQzl4Zfs4LgZVMe4LZkqZONsfeXk2OnEGtSaUrSDT2+AcnJY2E2X4l2YvglLXApTFeh5Zj3New/KnLSl+67fTq51M/LWVwvPYtRbhmnu6jpwIIIlUALVyu7mCRNP0JFOZ5QSsdixbaxg4ibCixkXqExQ5mD9lWxn6HQBOVd5s0lfl4Y6kdOX0E6zmNC3sx2lmWCA+iIF9jjRvU1FVBAJmG52zGQFSlxpTVS+YLpAkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRXQVjedF/C9uPWVioVU6E3C4+/hYBE5eUwFQ0tUw8g=;
 b=Pi1sx+TWcbeTh+/NnDQyZN1OQ4ued9z9IylepLsvAHuBJNROWWs+2WZxlRpzMMD6wFXbwrrhW4ba7QKzAbSroG+oRHj1Y9odkY7s7Pu9tiMiOKSnTLsIRuInyKldtabTUyb1c1P/rwlsNhOWELeHwtIkGfRMIncwKTWLBFvAsUI=
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by PH0PR10MB6958.namprd10.prod.outlook.com
 (2603:10b6:510:28c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 13:49:50 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::ad) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.7 via Frontend Transport; Wed,
 25 Mar 2026 13:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:49:48 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 08:49:47 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 08:49:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 08:49:47 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PDnlR8380660;
	Wed, 25 Mar 2026 08:49:47 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>, <shawn.lin@linux.dev>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH v3] mmc: block: use single block write in retry
Date: Wed, 25 Mar 2026 08:49:47 -0500
Message-ID: <20260325134947.2799552-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324143448.2631888-1-b-liu@ti.com>
References: <20260324143448.2631888-1-b-liu@ti.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb38ab3-2e68-40fe-caaa-08de8a7561b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M52qYImSO4iOgnV8fNf1+XVgIMD8T9N+JiLkWVDcoTi7fJSsaTQ30V+xdAMCSs5psT5DZbrEdkXONXWK9u0jQ1gvd6bZb58lW+S7lx6BJT40Ojj74KCJ7RPNdza64Mz6tC+3Dx00X1db06RW0774rDM6vkkSMdbNW2tttHwEKB+mNS8962NuLG93gCWtrSUPXJdSqZZv5Tk0nFX+yInoPOTxLtI4OS+UgXRrjuEQeAUarR1GMvQHs0KebH4L2Jx5MZV8J/YyWKCkfq5SnfFFxhOXExA2FtfqjqY8D/Weu5V5ZRkITvalCYTqKZQcISZZcw/2Yxq23cdC5zMqetiJ18QYdu63mOuOMNFatlqlS53y6cFm+bNv7UJ25OI+8WtX3kOLKEUGQwqaQ5a2mes7/1fHBvAJXG42p1cuJTVK+XOEZBfJGtL8d80+jKHLguOS0gY4xMPcb21un7a9JC9D/CSM9TtaOzv06MYTM/p5TWXz8HaqzcxWLasZCtPGFs5V1t+PUY4DwPQ1U8QuvLt2Yd/Wo0bo1bBpYiqGQHGSnADz7zjZidL2bMcKpDDdYMt2uKzgHATmBz7Wdi3qPC++5BWwNAebzMwLCmshfL87jvqlg8UorlB6jdMK8TzQbMqXOk3/kaj1lslsikTsPJDBbdSVPo2mTN/xOe+V1thO2JaW/r77jsS4CmyqHfZiAZFS2kB3FeJUZ4OO8dOraoWA3nlgSmXXO0T8dCt+sVsUF12OjWyTC1CGmCx6G4IQ+9lbW78RcTcUld37Lh+eJiDIYAi6YsiLleX48vwTE2bVm+Q=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FybSbZFwZSp6Tnq/qYPXYmXwGZItcOFhB/Cg9rHB45FZ7ch6YM9Z/zuFveAGYVNYahFXRVE4cle5BPW/Yp17cjP8iqyO87Nhu8Ps3E4q9oQeGHmFXvLeZs54oHsiTNH3OO/vLoG6ijm6D+HxGX1NSDi54aB9o7XfUzstNKtrh91ciBHEoIPjEPnV46X68S1p0wzivj19Lt/2Y0euuFeYA+vrhnbrzgj2HA53CMHIkSDkA1Gz9JfE/cwqrI044k9YmLMnXTE8Ml+n5EsPYvQl/pFeAAJfPCukWMMnLz84ly6splpw3w3xIIIBs4+PcSe3fTPoZ5xy30qM3ZPltB4UlLYvFt0RTz+3wD4Bux5yFSbkXVxnSlzY+wPM9gOdpiaZ3dBrtwcSPKMtkwegV/2k+Y7sNlAXiYaeTq8SspQxR4e7AZAfPRKmMJsOsIitDkfV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:49:48.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb38ab3-2e68-40fe-caaa-08de8a7561b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958

Due to errata i2493[0], multi-block write would still fail in retries.

With i2493, the MMC interface has the potential of write failures when
issuing multi-block writes operating in HS200 mode with excessive IO
supply noise.

While the errata provides guidance in hardware design and layout to
minimize the IO supply noise, in theory the write failure cannot be
resolved in hardware. The software solution to ensure the data integrity
is to add minimum 5us delay between block writes. Single-block write is
the practical way to introduce the delay.

This patch reuses recovery_mode flag, and switches to single-block
write in retry when multi-block write fails. It covers both CQE and
non-CQE cases.

[0] https://www.ti.com/lit/pdf/sprz582
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
---
v3: move the flag to struct mmc_queue_req to reduce the scope
    cc stable@

v2: add errata details in the commit message.

link to v2:
    https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#mb201075c9c466a78b58dbb0bf1f39139f0928591

link to v1:
    https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u

 drivers/mmc/core/block.c | 12 ++++++++++--
 drivers/mmc/core/queue.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05ee76cb0a08..db8c99c73a61 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		    rq_data_dir(req) == WRITE &&
 		    (md->flags & MMC_BLK_REL_WR);
 
+	if (mqrq->flags & MQRQ_XFER_SINGLE_BLOCK)
+		recovery_mode = 1;
+
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
 	mmc_crypto_prepare_req(mqrq);
@@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 		err = 0;
 
 	if (err) {
-		if (mqrq->retries++ < MMC_CQE_RETRIES)
+		if (mqrq->retries++ < MMC_CQE_RETRIES) {
+			if (rq_data_dir(req) == WRITE)
+				mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
 			blk_mq_requeue_request(req, true);
-		else
+		} else {
 			blk_mq_end_request(req, BLK_STS_IOERR);
+		}
 	} else if (mrq->data) {
 		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
 			blk_mq_requeue_request(req, true);
@@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	} else if (!blk_rq_bytes(req)) {
 		__blk_mq_end_request(req, BLK_STS_IOERR);
 	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
+		if (rq_data_dir(req) == WRITE)
+			mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
 		blk_mq_requeue_request(req, true);
 	} else {
 		if (mmc_card_removed(mq->card))
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 1498840a4ea0..c254e6580afd 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -61,6 +61,8 @@ enum mmc_drv_op {
 	MMC_DRV_OP_GET_EXT_CSD,
 };
 
+#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
+
 struct mmc_queue_req {
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
@@ -69,6 +71,7 @@ struct mmc_queue_req {
 	void			*drv_op_data;
 	unsigned int		ioc_count;
 	int			retries;
+	u32			flags;
 };
 
 struct mmc_queue {
-- 
2.34.1


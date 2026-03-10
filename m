Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D13A3819;
	Tue, 10 Mar 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158658; cv=fail; b=qHhriMQc9cMiqWwqXnMp9nnjyOqPKjAA2U7vZfWqvAjcmDT5GKRzJRbNNYfh+ZX4cLjrV9ZNSqnfdazZTleuxjlWFS5fy3yuxChpeyxBXV/ofbjd5QDaywpv39qkXVM+EGsgQAYsSDZ3uf1RRkpfHtxsmnzPBrRqrBklA55u0RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158658; c=relaxed/simple;
	bh=4Y+xI2e2pBVW7WG2BFxHeXOGTatLn4qdjOIahK89/L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVLfWfeFAQ9UyLV+nh1WRTd7OdGPsNu6O4U8ZRHbCIUI8Obw63JMqXAIs1ZaqqXmTAXFdkAm9sm1djJVIL/maJANdYE94P5CsqafrsL5el0bp5bQwEyUlY3gDjgLpgjCinmlGF/FKtdqSnEZv/ETtvHvVcovXRMLRQ+h3A5NHt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oaFAD3NF; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oaFAD3NF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIO567VMibAiktJ4j53o5EKnVGT1v+ujUYlitO5QAaQSykP+uxOX6imCfmLOj2F8fC0yZtxQuBSdT2aO98Oxnd4TTHn6fjII4PVvfhizrXZGO/drAs37poO/6q9ltBMPC/x9rITSX7fXlX4+WbAGKDfwNMf20QFy5LcSu2Ocm02KIdUZ0M0IHekcCR613MljShk8sqLQ+b6GIPzY+Soza2rQe5Ca7810tHfUSx4oWtLcrrUVkKy//NOY1zbf8Zzc7QqYk21zRkghWZMYG1J8d4WqGgcYuLyutbmHJFM6OHvxOwXQtPGAbPMI3smqUbBGN+RTm2eIZbhbkOJXGpJ0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzcZGkrD04l/y6pJLNWcE+7g5tYAVr7V4x4nQ0jGuoM=;
 b=Y/QhnrcMl0bl+mxaI6TqozwcfwUv0JmoqTVrtjjGLIUEY7KUnrRG/G1DRVlz/HfAjUBqK3dMIQlQ0P3jb96XIj6HlWXgDT/mfE0S1FICGABqr02n8IVjA4tZRj++XedLxT+aXYFND294m2TTqym+lCM9Bimn1StBlWPCWaJhj7fUSOD6jslmI6wye8UfMqidPYFx4Ym+qmxSGYTIjQelgL3hjbnaxQ9RAnxjkuvZNeX1RjGk4lQhgHVrTk2bbIy+iP2c8LhCDfJw/2624q/H551qzI2qv676X8K1AUgRfJMAlgnyPWehNoFj/ll9C2NYhcaE5m3viU37kPpQfkdSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.dk smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzcZGkrD04l/y6pJLNWcE+7g5tYAVr7V4x4nQ0jGuoM=;
 b=oaFAD3NFPJIBzVT+RHvDzEg88JvrvlLgdJYFXy1I829KKnP5g6hNuEpmDTaUHt9mZZNqOwcbGOCKb04VRnv6piVAE5JMb5Q5CXXmDchpheAd1TjqpQk2A/yMRxyqXI3NABL2o1p/ZQNS2aC+Y1TDUWK8VLx7EU3qigvbcfKojHk=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by CH4PR10MB8171.namprd10.prod.outlook.com (2603:10b6:610:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 16:04:14 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::53) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:04:11 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 11:04:08 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 11:04:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 11:04:08 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AG48bb3367205;
	Tue, 10 Mar 2026 11:04:08 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>
Subject: [PATCH] mmc: block: use single block write in retry
Date: Tue, 10 Mar 2026 11:04:08 -0500
Message-ID: <20260310160408.3976760-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH4PR10MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d97310a-b065-4259-aad1-08de7ebeab18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9q9Yba2bpYsH5oR6zUXjF90vvTuADpDqmHpr/LubkcrIIlIZyN2QMTEz5VFTgAJMSpL9rmyYReP4bZdScxyutmSZ3nrz/9SpD6vyxDMDjWGI95OHwlM03h5JWiihocNCwhjsIDH+I6VWsbC8kPec7Zdrznt9RlbjC2hvJLau40FXIAL/B7VweuW5CxX7K6gAuO0k+Wv4vWGb3uIlQ62kE5bkXVw8jNh+BqnM8yUoChipjXXy7/+0vEyM/5DbVPqsR31kJ2EVY158f7+bmwS16qQjYNYpth+dbEls+eBbNBcUUSUDi+Aite9YtOmYCcFDQ463fAbDExsBlgnDI2Q0uJvFu7OcIUaIBaERZ4aqY6i+giLyzjHp+QeYEGIDOYAhMcpySagyZEH5djWnsISmKH9TS3LvubixMaTBnaaFOAwi4UfqsFwfYXyLg9SNS0k5cHpjMiYSIhhO4k1u16vX5YLPOoXVfchHSHHIRxdnEzMRv75ym1in1yNhe8k37DSIZSYS9ZooIvjtyvpFHZvpOm1kkPLLcPiiLAV9COIWLi6ckJsNMyHB8+I94ECgJwQihpECjbP2gumEseW9+3Yk0bwAtcLXiIIeuT5zgVtBm/ZO8yVLnJFBjf3snQrjAtSN2nRH1nzDsGWe1+a0647VL0uV3pTFG6e0ysUea+0gF6QiKyt4P4EE0rRXaWitcJWOPYV6ORvU4f2fIBkroussjYrJG9YvwtOEQByWzCGKKkZ73nswVMzv5Op+FSxVimJlODcgi1GZ//P2vF53mg62Qw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D7rkx4R4Z2JkJfHC1ylWOW8Ch3WfTUcsj/kxPFUGbeWUeMyfU6s8Hu9uHLH4OMcx3AUDlF8kvd4X+uDkOV1GTqWGO3FOP6Mx1jAwE2A1fcPSIFGAVGLyAmKxxnVa8zyMYBoxir4A9xyIOZPVLvuuKI0/aU9HXYyaIx3Oriof3+J0zcOQ7IWv91W3je4a44fLwb6vpFeV36SxAVYOX2KqH0UMCBLJn0kH3Fx3PDgx7zK2qL4Vs4O/fUYte4+ozsdOpNtqe/8bXM1JTSkqZCK4Nk6wRWUjSZUfVEDT6H4B+EeLc0KAwG3cRC1BUbPAslJCWcGO14IlsBK0s3XEtyJzhd6rFHo5gw5jml08CfL+SBRykBDSX+hUVKepu1xe2Ks3dnrsTrfSa1suV6pxneic2+FIZltSWrcbFGnVzx3Ejaqa+Nfn8s8OQ415oZEOA20e
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:04:11.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97310a-b065-4259-aad1-08de7ebeab18
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8171

Due to errata i2493[0], multi-block write would still fail in retries.

This patch reuses recovery_mode flag, and switches to single-block
write in retry when multi-block write fails. It covers both CQE and
non-CQE cases.

[0] https://www.ti.com/lit/pdf/sprz582
Signed-off-by: Bin Liu <b-liu@ti.com>
---
 block/blk-mq-debugfs.c   |  1 +
 drivers/mmc/core/block.c | 12 ++++++++++--
 include/linux/blk-mq.h   |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 28167c9baa55..5f97d07fa3c8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(ZONE_WRITE_PLUGGING),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
+	RQF_NAME(XFER_SINGLE_BLK),
 };
 #undef RQF_NAME
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05ee76cb0a08..00016584d70d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		    rq_data_dir(req) == WRITE &&
 		    (md->flags & MMC_BLK_REL_WR);
 
+	if (req->rq_flags & RQF_XFER_SINGLE_BLK)
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
+				req->rq_flags |= RQF_XFER_SINGLE_BLK;
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
+			req->rq_flags |= RQF_XFER_SINGLE_BLK;
 		blk_mq_requeue_request(req, true);
 	} else {
 		if (mmc_card_removed(mq->card))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..06b6e1c4fca3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -64,6 +64,7 @@ enum rqf_flags {
 	/* ->timeout has been called, don't expire again */
 	__RQF_TIMED_OUT,
 	__RQF_RESV,
+	__RQF_XFER_SINGLE_BLK,
 	__RQF_BITS
 };
 
@@ -85,6 +86,8 @@ enum rqf_flags {
 			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
 #define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
+#define RQF_XFER_SINGLE_BLK	\
+			((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.34.1


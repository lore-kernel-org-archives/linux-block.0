Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777CC433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 11:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiI2L7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiI2L7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 07:59:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B1B53
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 04:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIT/7rrhOYthbEV50LTNxLCMV3UQFyudKIQWeC1+4bY89C2clB8pyHxG0tGUqFZFHa+lksxVaxG65pw5tFXbdPSkeD+1Y+0NUwdzJlrJWabgxdYNF4LQMRZkwY5JzUYiIDnmkt+ZHAEl3AU3Fy6kDUssflEtq8/W8sWYHAuNvRGVBF6us63Xk3v3Br1BUmDF7lyqjnE//JWCwJskojJKnoMmNS8WzLzNIDJQfWfcQmQXs8xFJUjOziRVYZu4S5nZA2K68WvCIm/c3Kg/ui4fcxQ3FAkxE9O2ymDIj8pnXpYbhPhVfCpnFwVnkMcHLSi/PLQIjc5tj12N9EGXMnwgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/Py4ZI8tSuhCX1r1EQEkYBE4HB8smss4N/kKua66+Q=;
 b=REx/h9I/QvbURfYlVw1yActw8I4f96ZXm07PfcOr7mePxujmi+TFXC/kTesyh9R2rCUM77BrzcyPEsjTxbil5/n34+oQLNEMaLM4h2pEQxxpyqcf5YAhKa7MyphVnG2793NAG1kfbK5swz+FoS4uaR5vmfyL6bNX7SaXPnXrB0Lqd8Lc0LUXIWdNVfRBVBMLO/BNNXc6Ljq5kkEEJyyL9P848oDms3ahnilkQ7D/D0lJ/zPIn2Nun5vAuY2zRMd7Ifku2rgZVWAs9aqpMCipEmek0zGgnxRIa5+SmgxIsqDgYfE2ivc7S/Htk2YG7e/XLg9HLELvMBQcpKmYJdJdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/Py4ZI8tSuhCX1r1EQEkYBE4HB8smss4N/kKua66+Q=;
 b=Shz3A/YwyI3qYDuRayyakMtS4/v9ZhDo2Bta8tmpmVGHKXTspMopbiSJRsHSgcoBl8MLV64U7etCrnuJ3jPHnuAoT61aOS9dQQi+BGvTunfk50mi7k82vgpCo7OZOopmBqd9ZxZfGku+l4qtjCps5Rf2XN5UBEPS8Kp/A7Jjgw5NeY5PvjVVmNjBiSCPW9AtVPzYbvq/S9rnfrBvvMJ6+4gfr/hXt9tax97ol/CI7roNaSzUZuHcs3k9Ao13uSZkLquI6Xw0wolI7PzchrzDBtmcOQK1bNfc1iNHLMJlltX24Jlmkaawt9H+NVQ5TdOgNxzByCkPkAZxca9dRpaRXQ==
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 11:59:28 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::a3) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 29 Sep 2022 11:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 11:59:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 04:59:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 04:59:22 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 29 Sep 2022 04:59:19 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <kbusch@kernel.org>
CC:     <oren@nvidia.com>, <chaitanyak@nvidia.com>,
        <linux-block@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme: use macro definitions for setting reservation values
Date:   Thu, 29 Sep 2022 14:59:19 +0300
Message-ID: <20220929115919.9906-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0632d2c8-3019-4e84-0736-08daa2120f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLJhJ3WAwiYpnPFtzjj2h3cMg/WxQPTt2zm64xPDHTb5A0nmF4P6iUiOOiP3Rt+QOsHyllatRhbmv5/FA2BH+8gQZZ5Hy5Co+YfVOrLEKTmr3ktmQj5/M666EOkWcfzdPvgLsQaplvsCn7PVQ1HsiDITb8LKFfxdsGtaNz7YhO9GAhgfvkZ2njl1SEhH3pCVoEUQ1AHhcjxkUewXCFfm+g6BS2riLeeAQF8Jf+5uUC8U8WFSeNqr/3e0foxY36qh79FwM85hu/JcHiBahw357b6ck7whwMcxbDwgPyOzU3iFkYWCTM455bFKlEh6NKQ2VR/ffb/N+YeNkLBBkyu/cSySv/4iKv8LuMszV7FoOKTKpixU+8U0FiRaLlLnHueUexXlpxyx+chx+JWujYkx3uKIjQmssVOMP26Yd7t7xnmFBNlv7N4bY7x5/5uPPIko/RM9gXrxx50+k+vz/zSbmQskCXNscpRazBYsaTI2uc1oS7AFGc1m4Du5spkcoylpLnmCGCwqvyIbqwO0n8YwUCHr1kcsa8rA4OXckWQbTWZD8wO/zawzVyMTpd6SEmQRh2ffVikODe1zOgCkG6AeWELOAEyjxUZpE1bRf8tyz1e/FrA68bFYYoMYyaf6/uOA8x2BM9pG8RMmCRvifGbWXmitfnW8U6R6ALnr4Mgy5i3hlvib3+7bZwx3UGr7ErQaR8oKZFpTomr2czFmGgFeTQWSvikr3wFqGQKgzGvRtifNsTDwn3LNhJyt1fnY8Z+uPJu3Y9j+5E+1rYLZfG2l6g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36860700001)(36756003)(7636003)(40480700001)(40460700003)(82740400003)(356005)(316002)(110136005)(4326008)(8676002)(54906003)(70586007)(5660300002)(2906002)(8936002)(70206006)(41300700001)(426003)(186003)(1076003)(83380400001)(82310400005)(336012)(47076005)(107886003)(478600001)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 11:59:27.6804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632d2c8-3019-4e84-0736-08daa2120f71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This makes the code more readable.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 12 ++++++------
 include/linux/nvme.h     | 12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3f1a7dc2a2a3..50668e1bd9f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2068,17 +2068,17 @@ static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
 	case PR_WRITE_EXCLUSIVE:
-		return 1;
+		return NVME_PR_WRITE_EXCLUSIVE;
 	case PR_EXCLUSIVE_ACCESS:
-		return 2;
+		return NVME_PR_EXCLUSIVE_ACCESS;
 	case PR_WRITE_EXCLUSIVE_REG_ONLY:
-		return 3;
+		return NVME_PR_WRITE_EXCLUSIVE_REG_ONLY;
 	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
-		return 4;
+		return NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY;
 	case PR_WRITE_EXCLUSIVE_ALL_REGS:
-		return 5;
+		return NVME_PR_WRITE_EXCLUSIVE_ALL_REGS;
 	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
-		return 6;
+		return NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS;
 	default:
 		return 0;
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ae53d74f3696..a925be0056f2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -238,6 +238,18 @@ enum {
 	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
 };
 
+/*
+ * Reservation Type Encoding
+ */
+enum {
+	NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
+	NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
+	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - Registrants Only Reservation */
+	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - Registrants Only Reservation */
+	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All Registrants Reservation */
+	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All Registrants Reservation */
+};
+
 struct nvme_id_power_state {
 	__le16			max_power;	/* centiwatts */
 	__u8			rsvd2;
-- 
2.18.1


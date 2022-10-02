Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D3C433F5
	for <linux-block@archiver.kernel.org>; Sun,  2 Oct 2022 08:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJBI3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Oct 2022 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJBI3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Oct 2022 04:29:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35215491F1
        for <linux-block@vger.kernel.org>; Sun,  2 Oct 2022 01:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msahqXEEEywzZZMMI9BF0Zx5TWchi1Q0VB4LHSK9as/U4FWM3RDBaTfGc1MpUNxBv+36vomIaMhHtBfN4Z+gJJckZ8LoWcI8N7Z7eRVYfpeVxvsWr7CMUaC6RhfJOThp8m3gMSuQLQGAAWUxYWXPUupIZB43TJnJ4ZTvqNU3V1jUTLJBQT3SaErTzTUzrt5AYeUt62ScOXZSV6hTx04zE3OV/6wTuQxJL6QAjxE4y1vi7BdLYFufumZkBxT+uJqIekAFMwgvgU9n99bkGGhCAgAj9WD2QWSieZScRHZ/AGZ2D4Cvo4DTq7+rR9DXZj58L8q4oZLS/VMMj1qzrmj5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5PzXpBtctzyjgCE0DLke8BH3vzlVe/nLmdUwaHML4E=;
 b=R8EkhWYySo/pVrsR4bQqe9P9XR8isVA3rgdP9OEYYGvB5rTN05NX7AoH10n7Z43DR4+OOi/S41f86cwc8bi9wIOrxuFlqLwiqyKxSPodssE04vQi2dkW1R7A/uOig+hRcQdvV3sw/rH5ySAPVS6HONjw3qLTIFElHtnJbuc+IUEKiowlQzIFDw5urEeA2Cdo9TaZOL7X6xWxc5ZnPfh5UhbF13Cbj56CPDTcKTAomIz84FzBVte+I0TPPKhm40g2JXqdYn2n2Y0q27Ny5W49GnfTy3SHkonHViURiROeevVsnPa5Q8+AXMFxMUJOFvdmmQemZnsi5NW5CWtBOAuvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5PzXpBtctzyjgCE0DLke8BH3vzlVe/nLmdUwaHML4E=;
 b=gw/D0fEupyM91zPRCWfDoK5hwnaaKhDYhdRTXeTOXN5kVVmVrwObDd+IkTnLtR3fosfnnruPU0mntuoGP5bFnVMUctzVncVpB6zhD/RaXT8goGufuP4KEyd7XDbWNRy7ycoaabXKXOZSzaV2XS+0tO0U4/lv6YtIHV1OFAGViY4OqkUGuWQQl3ufM9QhQkoWE2k+Hggf+hG4xRPeAXpU1bfI2RQ9nx43O1vLtqETORJ2yMgWhBXJoM1qrJOocCeg8dLH558HwIu2uUIoO5zgxFd89MThvnv6lr1FXQCYzP9+3/F8gDq/asahuYunBolMp9JwmuL9F9vm/ZStekqh9A==
Received: from BN9PR03CA0221.namprd03.prod.outlook.com (2603:10b6:408:f8::16)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sun, 2 Oct
 2022 08:29:08 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::8) by BN9PR03CA0221.outlook.office365.com
 (2603:10b6:408:f8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Sun, 2 Oct 2022 08:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sun, 2 Oct 2022 08:29:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 01:28:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 01:28:54 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 2 Oct 2022 01:28:52 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <kbusch@kernel.org>
CC:     <oren@nvidia.com>, <chaitanyak@nvidia.com>,
        <linux-block@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] nvme: use macro definitions for setting reservation values
Date:   Sun, 2 Oct 2022 11:28:51 +0300
Message-ID: <20221002082851.13222-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: e10240b9-05ee-4405-fab5-08daa4502ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0ckwXKc+B3ZzCWnAWZRR6BY8lNjbEx9wv65ULeswzfaXh69lGembUhY7nt4efZmD0C8x45YowcTVXpCw0lpN08EcwlUxVDwU5Q9a3P464GfLhUIRFd8Y6Q9tbFF1FKStaMxv6xdn8/2x8QipfAI/FvTK7MX9t4tRGiK8y26iEXGon7Q0TdhtRo4pwZyIhJe0G7xfm+JNF3uV7I3A4+y49KHwk3bdWP9Ka5qvw8q0wJ3uLcZkhOpBiEk9LKa+5N1h4BOQsH+tGb3dxARMD7GGWrNKkZC0v5T3eWx6vzW086YLhH0xvLdgSzvGiKCNEaqQNTO/TJcNA9t4qDo4hD+j+ESf2W8UuEUhv7s0+SRMwW0VVtxbMqUspVjK9wL8aBuy4AFVHzSi6YqYYoqmBnHRMSNJoYVjJCOpXEpZdvwXfnX6hByuoY+iW5XUfw+332i3ih0BzwdTq+NMWS7krlQ/3KfR5Oiq+uoZ6DQkpFq4/tXDrJMyE5k6czIifEVIm9EkLMF6iroKFLCBtf5+rm+rMdkm6fhTOVs/3Qa3Oi93oVRf78BlTQ8hW+wnNRL7X3U1TBjmPuYWPwRP11du8TOjIAmvSBo6/PbzlYkvzCpIBAqlUOqRaUaEUZKbwGymuRImvB6mkLnJj76vEamIQ39ieYipKmmwYJr/5ybwmSspvG8Rd00JWDclgEVpa28VCTV+iD07u7X3C7/mSdxSZ8w5jBMawyqGvWu1yRm+flAS/v2B+W7564xTelDZEDcCS52va/l8cBIwgGsPKqGSP0SLg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(70206006)(4326008)(86362001)(8676002)(8936002)(41300700001)(1076003)(426003)(70586007)(2616005)(336012)(186003)(47076005)(107886003)(478600001)(82740400003)(5660300002)(83380400001)(110136005)(7636003)(26005)(40480700001)(40460700003)(316002)(356005)(36756003)(54906003)(82310400005)(36860700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 08:29:08.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10240b9-05ee-4405-fab5-08daa4502ccc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This makes the code more readable.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
Changes from v1:
 - remove comments (Sagi/Keith)
 - use tabs for constants alignment, similar to 'enum pr_type' (Keith)
---
 drivers/nvme/host/core.c | 12 ++++++------
 include/linux/nvme.h     |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

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
index ae53d74f3696..4f777d8621a7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -238,6 +238,15 @@ enum {
 	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
 };
 
+enum {
+	NVME_PR_WRITE_EXCLUSIVE			= 1,
+	NVME_PR_EXCLUSIVE_ACCESS		= 2,
+	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY	= 3,
+	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY	= 4,
+	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS	= 5,
+	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS	= 6,
+};
+
 struct nvme_id_power_state {
 	__le16			max_power;	/* centiwatts */
 	__u8			rsvd2;
-- 
2.18.1


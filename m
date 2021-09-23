Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4B161211
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbhIWBvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:51:37 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:22624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238177AbhIWBvg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaE8P49E6yrCI7dZau9/90rxAI0m+h4qgkubTg+LZOjUo085eP2KUfA5T9bY/GpxN/qV8059oo6lJntmy6d5UJl7W+b2S5ZNpSKvqZ1iFKUF482At85N2Cj4P91N9zKjQ/g5NAG39o6P6s0ITw7uQfG2Vo8sR9qmUBY/4hq3HspvPWcLK1fNrDTqDggHwB2W31/9eWepUuPT5DxClWgjgXGb+edKHTs9iiHn50SVA9zAupB6Sevtnh3NTNgi+m6lkOBsRQ62ayVOSyAfJj0LZQhavzCNvtBq8EkNx4ML10+PKoXGW7F2mSWbq0L75N4Nk+SH/tqTsCPEUyAc5of74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EZvsYZj76XD/k58GqJhoqfQ8fv33Enqoo3Sfou57ofo=;
 b=ZLnkONmNqvWL9xTnNG5LwjueMiPpxI33+XYjrB4tB9ZfrSmzYp9gXviUd8mcDiIo8etxIYYGMDmMnAWaO2FHiu+x1qCBLPS4neukCVvMfM/iU7VOlmVS9Ic++qGKClq+sy9pHdP1EUSFfJhI7zfgkjK2vampJ5LbrgNRet/jKWwUH0KS9w2n76pXqGJusEIWT/FrUqpdysQa6kuZ4Q3BU7VcojyCjhsy/mu3uZpgypuQpNh3zO+H1YPam0SpXYilBc5s0flSv3r70VD2/UUjS8JeTiVRq5b9bmKGhTbWN5RQkg6EmAiRN4NohuFTc6f8VRpBwD77fy95ZFH0v7+bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZvsYZj76XD/k58GqJhoqfQ8fv33Enqoo3Sfou57ofo=;
 b=HBcE8olFpXcmZFdjEFcMkDp7x9GHnEBPbkVSNwtOrzuxGy4bStxHAtNEptmlJ/VCbciTOAKYdx0fM4a7QOUAo5VFkJrnzoklkG+ClNyybT9IxJJdyWuY8Ubg/vgxi4yarfAdqowHkcSQ/KnK5KcK92fxffJST7l+2WBhSC2uOyB+Gn3xUxkmy4ZnoEgnZ1fkQrfN7J4Vdlo6b+SQ6kV5m6K5RxGUX6IDX213J/OSMwVIFt6rdTEDLkVRsqlGDWKos933xSbyh/LgjhjZ8fr2i+5N8cU4CvHlFscT9zKYPeq/PqR3cJT5KqJVY+piDYozvCUANzFdkbXvKO+GE+Zq/Q==
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by BN6PR12MB1889.namprd12.prod.outlook.com (2603:10b6:404:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 01:50:03 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::3) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:03 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:02 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 1/8] loop: use sysfs_emit() in the sysfs offset show
Date:   Wed, 22 Sep 2021 18:49:38 -0700
Message-ID: <20210923014945.6229-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c986673d-0d53-45bc-a441-08d97e34761e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1889AA29341989CFD524F3EAA3A39@BN6PR12MB1889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KO5/8Lh2Vr7Jbt0wDKfxXi8tw7PUFLUq5rJOmNZ7IkKqucU0pln2swbuQtiQgmGqwChv2Rr/OEkLQXFwI43poto8IeGo+IiG247YyVi21rKi1d3bdJzrQV8hK2Ve96de9jes/sb70xVRIkbMSsxqWvmxYN/TmUlPD+AmFntaodZ7qVlDRg90bkJRHY54ASIrw274KeJSa/OU2Vcs2vOTpn/cgsuyYOXuvg4f8Uj1oP/1aaWUK7BFEAmXCA5pHY8ADC4kaZI62ZZKOVAWyDIbfL1jQ8M4UWr69oJNayIDzZ33P7/8aIdY5ShnsAM5hHI/1v5NZcuDxXDKdmJWNtpq8XV7EiDcgTHiL83mVtcls3kPRoB3ua76FVbL1UR08woemVHKSxDIDgt5KaWaSb1cl+GfIY3hrmvtv0Gmkyh3EIFhtFwwWGUoul8Lj4oMrXdIAyYkjA36LxsaIwrf3lGBbov3OwP9sqf1+OpDHSKHaAaDdfJW5ciIPi2uCsKdf5jnLf/wZTeQ1z8hlZVt96V+ySE5pNaxA/JCrs31cSWYmn6rrsZfiAbjgYm6FjFTUf3OovowUpwWTH7x9MclQ1zekJS7/SIJmjWXvOy/WmNZoZKXTZd1NQx87qqJmDfRV3FZRsyWrW2vLVt0v7ZQu4UMwiuX8wQtexQpw3s/prXx4QDPJGgy4lF2AUHUhp6kXWsA2UpHZYJYa9WlJLJqGHNm4A==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(16526019)(86362001)(508600001)(36860700001)(54906003)(83380400001)(7636003)(186003)(2906002)(356005)(8676002)(426003)(6666004)(70586007)(7696005)(47076005)(2616005)(1076003)(70206006)(82310400003)(4326008)(8936002)(336012)(5660300002)(36906005)(26005)(36756003)(6916009)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:03.3605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c986673d-0d53-45bc-a441-08d97e34761e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows the size of the
temporary buffer and ensures that no overrun is done for offset
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..e37444977ae6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -856,7 +856,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
-- 
2.29.0


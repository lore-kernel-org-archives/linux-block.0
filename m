Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D827C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8486113E
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbhIWBv6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:51:58 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:19557
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238851AbhIWBv5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dViBPYj0TYvDk+C/n0Euo6VCVbaT0S+nGEvb1QnF25uvBCp4dOOaTj3WGdbd/B3gdxjFI4umkt6KNFB5RF6uMRXzOI1aPH9HGpawb0a+1/RThh9fdqIew77dYc4aR3tlSmYMxylIpxGq7ZqcMo2AslKpYsKiM5oJXKkkkGOfQjUdwxXUdaPZLS13tIXc6HYzZu1fHIniwQmqjosZ+tIf7xQ4+mrD3L2YyTDToGcfLo25NmS1uafS4a5L29O4x2QWem+MpGMINynfAILnUSr0gRMQHTl7MnGf4EaspUBqxusuZ2XsCca8dO/TSsQA/9fJLaOkVMslQbM8JBK6Z4cyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VD+49fMWPMMGUfMIO3JompnVgf6yYeZ7iMuf2BRVqmg=;
 b=dlIQ0bspoxUpGP3DDfJBIsckNp8I7YvIsQgfMJAJmuxyQiN/wvNsLwytIS0RnqjVRl6JHwKrG16UusFJjygaAN23F3CnWLKcm1TO35W9Fq69UeZpTSs0j2V+lDImTm1bDQNK0ucxBAR42Ah8PxfyeIBFqUEyGMi32KmXwCl/rRVDQ8mDq7YIRGkuV4tHA6F/tuQ6EZevt5sJiqkUDHaonSaHA1pe7lm1AkbAEfhg9406ZikG7cR1UVZeKlgkLi6kmVcgVV8Unm2d2KQ0glY0bLsfeMSNV2yFuCH1g1sBo7diNWBnExl6rt9ibRCWFP0dBZ9InvY4ICXnRki3b3tQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD+49fMWPMMGUfMIO3JompnVgf6yYeZ7iMuf2BRVqmg=;
 b=ioUOvmYF0RVtakauxP9BV/aeAbwKb5jMfoITpHxe7Z3ory0NLFhH/A6UHPUjMnp6+VBVnBRMCEJdlgtGRqh2IBN6zkihOfJifEqg1bLpfFezV5zuyEEZCObT+NVxOuSoyd05GSAuSmSfbMllzzzPYGvjUGpBNOsgwWZXdxwOK0Uy4sDXzfuZsypdgQCuknDNE3e9urVHJy3xYXYFW4RB1T6Z1WmqwXnLy7ZpM0ADBQE2yXkgccc6ojR0Wqj3b5Ghi/8QtwY3vDQMjNm37P+aPMdAwnBhwl6G7gCX2EDRdERH0r/4ETaP7F42wwC5VsCLxzSLmjYttJT4zEVGOg+hqQ==
Received: from DM5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:3:c0::12) by
 BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 01:50:25 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::2a) by DM5PR16CA0002.outlook.office365.com
 (2603:10b6:3:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:24 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 18:50:24 -0700
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 3/8] loop: use sysfs_emit() in the sysfs autoclear show
Date:   Wed, 22 Sep 2021 18:49:40 -0700
Message-ID: <20210923014945.6229-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc079e16-afda-4c39-7f24-08d97e348302
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539F8C1E5A994841B736A50A3A39@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05pym39lUfASdpd0j5BVrpbP1G5asWR06szFS0w1NRpBzToZSktrzQTMbLU0QdMeESvosoa2tpx1EqbxJQPukaGZkPQQNZSYP6iYPDWxyNEbLzO/cvynZBOTUaN0jbArRvuUGLobmOlBSyElsf+tM3IRG8rL2MqH/n9UKVDXhKZAdWcWZQ3dHPZ2QFi8/V+k+AJ2WOoCmF94VgCf476z5nkMSrrjFFmpAblW/vdK0an8YLSZof1ytiQEVRGHhZ6v4x1gCleukDEQ4K55jfHVT7nNgXhSzxlzgx//64SrywSY3gk22F9Ev841RfelNZtaCVlFufKL/rElHKZy5LlM8zs5axne9o06Jbkx2RuUN2UumGlZisz1eoOmPTLaN4eYrreJgc/gT4ZDVtoY60q9l5VZwpSIFL6FRojdHQiuntiihScEDqBoqnbo9bwHjdIUGz2+zo5WyAGIYAGCeg6LsOPti+rpCPvhJ5NZ+Z/xFky38fUp296AMaEBRfoqmTXuSS+qjpwj/uJQ5mfdjAHTjXikqiAUQgBFtS65A9An8IZdA5dZNxjLRtIVKfpYcju3i/oZQk4ZNl3+j0Rcw4oOvFUk32DdDFlt660y3PPbc/Q+RgcqZ/fTBHi9pqdXimuOaxpLWtnCUMzqXyINNOQ+cMIJdF24vHEmXPnDB1xOYTItAdOessdhFe6HYCKfDN8vqgFwqltslHBg6XCA5f4ToQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(316002)(8676002)(7696005)(82310400003)(2616005)(54906003)(508600001)(186003)(16526019)(86362001)(8936002)(426003)(336012)(5660300002)(36860700001)(36756003)(70206006)(7636003)(83380400001)(4326008)(6916009)(6666004)(47076005)(2906002)(1076003)(26005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:24.9904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc079e16-afda-4c39-7f24-08d97e348302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
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
index ec1329afc154..fd935b788c53 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -868,7 +868,7 @@ static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
-- 
2.29.0


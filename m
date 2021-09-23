Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C9C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D06115A
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhIWBvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:51:46 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:30497
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238851AbhIWBvq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfMHo00Js8ZgKuA6O7VCZB64FOzXPSPtuUDMHFGU/hEtDJpDFXk/eg/VLF+YhCEwXAXJ4u8IaOSpt67uyc4HhxEb7CBA94wyA+OZPzOKlL/X2pA6twDN6pgV7QtI+JxSdj9g3C8HBVMtPtaQh+/aqAzlcMRaNTLwRLSHTg5xuSCG7RHq4hFWLReXD3a/rlP+nJGQp5L0ghDoXbFolavebn9JjomSSNk45rMmKkkuBGB7v+TkugiL2ILNTM/6s8dXMrTQJskkRUoXZmSPYYaoKN29axC2uMhDuRq+JEAkqlDNnKMg+E7s5Ko7XrHk5oQHLTcHLlR+dYv9/pKYJ3349w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hXlsd5hXtNwb7rcbGKFJkeUZfNXck1TIOQ41amocCGU=;
 b=OXiP3uW+HE9OyVlHDzTdj2j9urpZiCliQCxGgIK+upGloHkOXw1YM8UmV4+9Qy8URue9sxRNWXhGjCwWkQs9ez8KTxqMgFMtTCFLP1M293pNyMN/Dx5ng/HI44eczbcZP0YMHefk4gJ4kvCzovwCjUeuxYJ8a6T+iIkbJd/fRCp9+Qwm4r8teSbRoQ82iDJbcfEm/NfQSUb0pIlHZYM3eNM7ejPnKlzFmYerm+pn221y2qPCM/15Hhx+Zyy+exM4VFvZkuMHdJuCUxOIKuaHiSssd73p+ce4gWT4DbhMF+S7qcRoAyBpfnI35HxIMF3UgJXRP68YIwpkrBUUEAk+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXlsd5hXtNwb7rcbGKFJkeUZfNXck1TIOQ41amocCGU=;
 b=mE8iWzHpdrvFgPvEGL8kccgYVYuCkpBUojNmUpmNuqXO9RakC/u4RjjSP5wyZW5bnsiH+2s5BSXS5oQW3n6MV6l0vLBe8BOGBl3GDQPXjMbtElU85ia+h3ONmdS3kA2K008fhPp3OIqGbEFpMy/9QurZzpMYWGv4ucdNUZ5nJSiigi/JObtu83ZADqWH7ujDqYgu0VrbAGudch+4IWHcY/DfFLAd27njFRCTXX82Y6WRFYbEctAhbgRoYDJvVxCD7s3do2JSjbDha6bnv7EqOlMEZEE2dLs7oF2LKZMwY75bbAjXDVpkUUM5DlYmEA7q/oK++mGUoXlIT1na63Hvfw==
Received: from DM5PR1401CA0007.namprd14.prod.outlook.com (2603:10b6:4:4a::17)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 01:50:14 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::66) by DM5PR1401CA0007.outlook.office365.com
 (2603:10b6:4:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:14 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:13 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 2/8] loop: use sysfs_emit() in the sysfs sizelimit show
Date:   Wed, 22 Sep 2021 18:49:39 -0700
Message-ID: <20210923014945.6229-3-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8938f14d-4ce7-41f3-72d6-08d97e347ccf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43532146A3511D6B7CBCE049A3A39@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHvl/JM02/ho0N7n/HfcLOtoI/Ixx16wAHeOK0OJsTq25coPNS4ppTchltRUbRvoq4DdpFbz8N3j8TjphXUtwCFgs+gxPs9AGhLLMyEgA7s+yZ/zl6rbBi78PzYNzvwcrCJTxmkIBpBTEmlGmHwuOcAFfEcHiiGEFijBOmdYhhDCubG/cySihDraS1+6jbdzMJPIY3PA/yyRjDsG+wZX4Ll5eO7Z9mi6ZqiHO/TNc2M5xmN8eQ4VJroSRXMbphK3XMiUsn43yqFtU0jHStCBdhUtUhp9dVCFOTTX6ZlTGTIvzbpyO/TQN14T/5aechvsesf5OZXWryrFR6KbR1aMTTgHjZfXY4PM0usyna+Z0j1QTRYYP7lM9BxdYYkwg37aQ9ywQPFPBFc5XNcm8xrAZ7s7dN7GgWy+hXpae7+Xgpy577LxDVmOilKGrY5O/Lqq6Xauw78R+TqhqH8YS9uzlXmnc/s5m3/93m7KwJxNDSZkBjWRrN9ip5IoXK9nQaFrlzuGATcihRNARzs17fbj9+tkrKXmfm83JWO/pcV8gdRCSevxy2ZuxkIs7dp/70nDCB36ClfT0KDNk6/OXtiHhBX9J1st4RTt+p5cK01r0kcAQLrikajheez5uNjQBwIyKMkZHtlbzRpjpcJprfS6cWwZwtRkN1Ei0jVIpGhWhuvOYKbwwFI8ZOomAzSHjLeegtxe0iuo1VVhrw1RWXIGrg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(7636003)(336012)(47076005)(6666004)(86362001)(70206006)(36860700001)(54906003)(83380400001)(426003)(16526019)(1076003)(316002)(26005)(2616005)(356005)(2906002)(36906005)(186003)(4326008)(7696005)(5660300002)(36756003)(8676002)(508600001)(6916009)(8936002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:14.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8938f14d-4ce7-41f3-72d6-08d97e347ccf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
index e37444977ae6..ec1329afc154 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -861,7 +861,7 @@ static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
-- 
2.29.0


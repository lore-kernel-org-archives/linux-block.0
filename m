Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57DEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiBOVd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:33:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiBOVdz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:33:55 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7187F5438
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:33:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjnT73r0Wdo6G81yc/QQ1EsXUUW8Wff+RS6h6Hj64uzfOfESc9JIbJhzjpdDIQy/tRCgqdEF/5wj2/HRoo6+oF0V3c8hMDHzr1u3IQJx+iQ6Aa7y7naoKApo1omi7sXruTx1OU1nPekvsUG0zhD3bH9Fq8FjXPQEN7LX0JxxFyuh0kTyDnl1Ey9mbbzg80AnHeWOqZKv3hMPTZ0/on24LddHxWYBHz4xVUboxELjTr1djq4tz8kz0DtTm9tUPVTciL9Ff3BSbzk076r2Y/Z2N/mFA/LOIF1fPSPr6cK1VFgtMVB6Knh66wcHzCtcfXYrK58QruaFLGy9TvrOzw4SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcz2fh/9i6/EbRPkqP+gdhL0pMYnnOhoKwwO+bvKdUU=;
 b=RLIOdOis+j7RAh/JxDXshYwR2L5TGXK4qpWD73qZ6aqKvHSt1x1BX4TVIAaoPbToRj4ovaFMmjSJSQk5yS/cPrLxv0DqmOEqU9wxzgB33nn7oB85fD61mVYttEzVodQk+Jm/AT0FUUAeisMpeQMW78BxJSiGLWQg8M8QM+/3zcLjHWxqCx6+nSOjukiJMRJL7Ypvjft9woCVq5J8ExRS6GoEoMX+SNIKrydftYMFGPAI1AE7b75ptdGMtuckEEIaVHooHyRRVGRxcL8LfN11oCxL0I6ftDSd51DR4rZAAmgP68C1dcX66mnXDHstgzBQFdySwRh1E0YSsRibZSpu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcz2fh/9i6/EbRPkqP+gdhL0pMYnnOhoKwwO+bvKdUU=;
 b=gB4mOhCjvvurZ39ap/WIk1iCS0mQEpNc5l9EVJ4vBs/z0GvIMpn8v670GEqEyP23T5pbze/IJ9kIqFO0zu85JzAnwHsWcpBGG9w6RXT7UQ7MmuloguGpVHtv4VEYO81rYKm/c2RfmJs4BRBQVlvJo+7Q/zfBwk2j3bOi0mmMjnC5gYuVlAwkNYR3ZQan+rXoJQA0twM3DFcEL6EsMDtXw7zU24+J1ooMCj4gjzwNbIsS/OvgiYMDHTMdrbZTIA2XfeoeLhclwodPCpeuQwfJ/tN9s6j7JE8ADvi8iz6107BMjpjPrd7bgndXkMoer/yVo2wVKdba5zz8Y4Yj/XzQCA==
Received: from DM5PR04CA0059.namprd04.prod.outlook.com (2603:10b6:3:ef::21) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 21:33:42 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::ba) by DM5PR04CA0059.outlook.office365.com
 (2603:10b6:3:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:33:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 21:33:28 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 13:33:27 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V3 1/4] loop: use sysfs_emit() in the sysfs xxx show()
Date:   Tue, 15 Feb 2022 13:33:07 -0800
Message-ID: <20220215213310.7264-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215213310.7264-1-kch@nvidia.com>
References: <20220215213310.7264-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b4ea3ed-9d00-4342-46e3-08d9f0cad665
X-MS-TrafficTypeDiagnostic: MN2PR12MB4455:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44559A36A667966F36E8FC36A3349@MN2PR12MB4455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFp9S/ROItYwVILh7aeWpc2JCbKiVzaznrI0Yxd8D6NuxBk6imbsHq+EFb+FEqAbjCgAIazcC8CZm3A2kunz49qBXgbDbS7VqfvdOevoOa76NioHC8SgItRnyatxdP/aAKKpkvSVqPZ6qRbcj1cBFZmXDOo8nChTpR5CNqcOH7JqeGo+7UyqW8LlV/v0w3hD8Aa8sFVG1q2NZfC4gX2iLh4GNgeeZO/NbfOtpnoKm2bdVZpQpP5DLDibrycwZGsf6f7/++ORloFlNT2oaV1i8KXyWUnf2P2D4Zb9n9qdE5/8rxBMznDJuNLQ4NsPOj8hiLzcctk3ckdClYq4yhMVOkrJwjI6t4QPTywMD8I5ujkxPdEnJ7yVgxZyOUcbQ7hLNAO1p2Iir7flmy7U6SFcdJA3cKuwJY54dZG7/8gAROi0KhcopriDurey8J30OHf5efcMxJIxKu/W50nu7ucVoEn3T1SFgAhya7aHajJxAy+U25GeP42nV+foT2gG4cwIIK1RGNkxYjF6hFoQcg4RyE+1n1fyU0chspa+I0XsoG3Gk2ZwTeQEGpJw1THid0Oq7FXNbSshpYavF28ByEHz2x1k0NliX6dWM2m3fP1y6xTS1S1nETEQ6hKWiL9H7qbUKWJbR2DnH7aAgFRtBckEamUsl4IYwM4Gf28rw4kTThqQN8QQVeOjm3V+Rs2bsJpERL2I3vP5ji5dirughnGXJyXI1N2XkN96AAFf6u11Gag=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(36756003)(8676002)(40460700003)(8936002)(5660300002)(2906002)(70206006)(70586007)(316002)(508600001)(6916009)(54906003)(16526019)(2616005)(26005)(356005)(6666004)(36860700001)(186003)(82310400004)(426003)(336012)(83380400001)(1076003)(81166007)(7696005)(47076005)(13513002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:33:41.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4ea3ed-9d00-4342-46e3-08d9f0cad665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows the size of the
temporary buffer and ensures that no overrun is done for offset
attribute in
loop_attr_[offset|sizelimit|autoclear|partscan|dio]_show() callbacks.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bdea448d2419..a55e5eda1d17 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -680,33 +680,33 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.29.0


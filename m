Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD57EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbiBNKhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348801AbiBNKf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:35:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86211FA57
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAufxb6vrz5KHbbMAxoczN5vhEtWHJ2RYYiWezw2DsjalvCfVeOvCwccByP5CoWQRc2px7W4Tc2GgsNSJrInPnvtuxXdtJVnjGpIWfMprksJ1bkJxsso0omzbIaMIGhctIHE1kKBxH3TMQ7dvGq49sHlr4VVBZsrakTA0Oc8vByhFqNU45XQ/MOaRNDaONEfxmjk85FU01WsKFmWMPPmvH8ixHQTByGCg5oy2YeUj5AxjtMYhOtCIjt0KDOVOOZL3x56KVrsYl/cJWnkUSXRC1xbqI+nxM0ehtHT6LF/9GrdyqQc5lttp8Z8paYIGTPXtWNRbxQ2YebUVhcaSchdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnTIuNZ7uKToQ3ls8U/Yvg2/KNzwQTZJifEkJhWnr/Y=;
 b=i1DCiX/S+g7P7NR/wof97DM32waY5J9kxBCjZiwFchoevWmdwKBbyXWcH5USlSO+8H80xSauhYUu7OUvrExLJET6CNcC1U2cgFPZ/j1WZ0f29Df4CxMJ4jLWBUrKC/7LdT1M9LZlSXmsspLSHUybAioha3hZHeV9TCSvSPFiIGXGT9mXU0IHtSyegRoZRz1gFslwt9h1NZfrLFwtwwMvx6S3cO5e+LpEjyM9ucE9vFnOBY4m9hX/rdnBYG0NqA1rvgcDrRUMTV0g9bu0l35z3OrMmjQce16UTZYUm/KbbbnxojB+i15GOlPnFRuay+dvBmXIiAEPJ2x7a1RkV/V3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnTIuNZ7uKToQ3ls8U/Yvg2/KNzwQTZJifEkJhWnr/Y=;
 b=CwIyA0cdmuZyZAlGIuTRtxHRkXFxG2K/k6BDrgUmY7tSpZmkkfXwQ5wjm4JLGLsSHWj6w06S9x9pn65YoqBTGovvblF7n6c65XU7UdJF3x9B07/ubAhRrB7fM59wHJuZVg+V/SN4pJEfh8Y1KsZLFP0glv5fbBdqf58TFFI28KXyjMDrK33tWvZ7csS6Jb6m41fqQnvkM7pYjueZ0f0jSO+6DfVXldXq9+2+BxKUy6kEUQPIlWaJtBoUa9o7eAwsOjcfggX2mm/odybrq0ziYDQSE6LPaY3XUg+R8e+5aPJjxCdxdIfRZCQNtJICqCyjMwqLlj6jr2skCSiXNHE8/w==
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 10:02:18 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::88) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:02:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:02:16 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:02:16 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 4/8] loop: use sysfs_emit() in the sysfs partscan show
Date:   Mon, 14 Feb 2022 02:01:15 -0800
Message-ID: <20220214100119.6795-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214100119.6795-1-kch@nvidia.com>
References: <20220214100119.6795-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf0155e-c18e-4aa5-db0d-08d9efa11592
X-MS-TrafficTypeDiagnostic: CH2PR12MB4038:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4038DC1F97F3CA3AB8186B19A3339@CH2PR12MB4038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiYCkVWOXsEAAJdrkIs9ilUpJ0KvauKCXYrHrx32hNl9VjDDAQlNt46wa0U/4NrPlhu7VtpVRL23K+oJiIgv+sptrV1iiOBA1N/fEpGjkYPK1fZpovTa+5IZ+F8zxURgSlXkJ5pINcmFWfjsH0xPN2BsnkE1DKcXsIj8IXWv1pw905CJewlo01Q5SLRO9ZGxKZiNeds1KfBYHgf0aYAXxeBAFPZ+nB5nHH2fHOItn3eVXcHh0peCE83dYF/U3Yt7Uh3+ZlETLKtS1F3di6N5PE2jB10CnSobZp7CgW58j6wk+Kvo66Pgu4fj4ZurKVFbGrwfqKy8K3iDqW0D9ZY4Stwhj0fvwKKtPKbClqEInnqWihZORyI6eHJNGmsFm8HQHgDI6t6AN2SLH+7a5AJKnkSuJqZPfRu+32U2vrUGnjtbSy83gXa5ysvHSEQK3vW0XYxvWr5Ke9EGr7kBvuZRDHSZrh+o3jDCRVUgQjzD0P50XNgZOBqNcJ/Bj3OIP9UaxQZCfy6W9KDIZiz2nTSjO4TXlCxJWI/27Fiizm32Qem8nddlxT280esoGvCiPqFRvwQAHuPXxMkLU/b+Qfa5OPel/o6saYgdGayskFnQewpHr1iVNrV0nGkP1hnqi2z1VASlxzQeepeHfPU0vQm/5SimW+f1nIUMm5M8IqoBbQbn0m1W22OqNB3haUNkaA53PKZdvwrHhGFsLJ0h0I70Mw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(4744005)(5660300002)(7696005)(356005)(54906003)(6916009)(316002)(36860700001)(36756003)(47076005)(1076003)(70206006)(16526019)(336012)(2616005)(8936002)(508600001)(40460700003)(4326008)(70586007)(82310400004)(8676002)(186003)(426003)(26005)(83380400001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:02:17.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0155e-c18e-4aa5-db0d-08d9efa11592
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
index c049c1967ec3..7fa6f68d7e41 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -699,7 +699,7 @@ static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
-- 
2.29.0


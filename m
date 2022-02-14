Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B767EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiBNKhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348690AbiBNKfy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:35:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F819C35
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG0+UAbitJ5WeFQciOAYJ8tmNpKk3EJdFCrMCfgotnvgxGWj7c25CXad7veONTz/OTi4hByhLuieDgfJcUXkVA5Mun1s5TVtKsRHTNYsXdS6QJN2Nf6f9GO48s13FQrUl1THxRAziCDwuYqDLF4/iRMtFMRdL30Lim0M9I0S148Gm+c7d5UYcwKO3kojOz+IHBDdKSSEh+jaX/gwGkgBQ/gRxBvMga5zShQZbSXQmHG+GILTrZf0VhGNySldlfvEr4b3LB9WHETY3XPWW0q7Cb2bP52PkVRgAmhXZoyKvc0sz5jLh46dp8qbI2/bSIM3FeCcA4zAzkT1WnlGfMNXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgWn+VitCNfGe5veJuB56Si8cZ8UtH9O2y3j2aFb9BU=;
 b=g9YAS/c0KgFKP9Y0dOgpy5Zzjzviqp8fKUj9unNcfS3Pd5FwkzGzTY7R1SDl6Ik0SvQVzA8sg/H0OJLnrthABxpw808jY0Y9kAfrFeP7sUlswAichKQOaulJzHRKE78ARtunWhnHPiej6schf2wHHjiVcsDIjFX+Y0od3NPb2F+GQ3E1Ccbu8oWzXbfwsgfzXiywrAmchLnrCDSPFS9mch81Nl+fDtXl6Jtna3/6RZdVJajPzVg+KJ/gongarzlUqbi48OZS2+tAlx5tLq3i2KZQzlFMvQyiax2DavLn+GeQUZLLKUWmpCR2hqO1M39FJW5rA0iN0eSHawx0J3N0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgWn+VitCNfGe5veJuB56Si8cZ8UtH9O2y3j2aFb9BU=;
 b=MTpLGBLfVJKKXI0zwITeuXtzOJrBS5KW6XaBCeDtIcxBKXGEcQK5q0CY4Mtmz4ELpG4CHG4nrTR9be5lgJUw5I0N+A71mtYxQRlWndhdr1qrHvyrUlfi2miz9Xznk1lYib6KjLGftrnbAQ2xyzxH8UdAdmRsjms3j9omqjU4euPQ80LFiOsxqtYpBJ8KXWhdL+pS+hXOZS5C4AVcWqpY7UdfGP6oQSJkK8QJgEhc2RcSXbM2DODzsXNnUHLsqPCZ5dzK1cTP1KT3z/G92karT0msLe1FgAaDc95FirBpLGJ85WYd+uGmtVtpJvRIKseDmXlqrJYlQYuHgpPgXUe6nw==
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:02:12 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::2b) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Mon, 14 Feb 2022 10:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:02:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:02:05 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:02:04 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 3/8] loop: use sysfs_emit() in the sysfs autoclear show
Date:   Mon, 14 Feb 2022 02:01:14 -0800
Message-ID: <20220214100119.6795-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8690f46-2ecb-489c-7c67-08d9efa111e6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5496:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54968678744BA69632DCFE11A3339@DM8PR12MB5496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCrsmNxQB20TLts6heAOKKFeVrA3t9cooRnt1lLMVKj+cvtT1tI5z/YtMCSAC+pI1t99a8+kEz+RXOPewsWlY4DP1Dg6857jrZRbHZhMd0jYbxjPVnQeVrMXWGjSbrAFa/VSZ+qV2d/TBfwOcdEl6SzZY8QXvaql4y8Cs+DiOtILp58XCIDecWhHHlZU5YKVkhcJlFB8Jfrb5W7NFrIfB8zVi0kCHz1NGJnVnREr4zlpBfR4/cVoqL71SqmKXLn9p4kChJPrrI8tXQFMYtdDgQlPzzn5Boj3pOq1wqCo5hhj39wrmGQVwV65lZp+eXwi0TuRCNDxGMRSq03dPjPna69fpZwIaCGSQ68G16F4nL1izyVlcvKOBJaPqIGPqwQ/9vw1XxvdnUOboRVTE9G2yPYHBNCA24K2HgIvAuik4PLFnVksN9o2AZtOmaol4YStzrrxe3hKBt9zmjsbioNH3E2tZ8augcgTcB4vckq2hJF6e7YsPu+Uk72pcNhl3WcB0A4VXMcephQYsIuqqi1h/ivn/2FyZIgS/W7P+/uc/H9NW8LYzoxCH4gGBROiMdzekNXH1982XWm5T2Q1XeS6UJplO0KrsvYgnGdoH4Q1OpIWXPRdDh5ky8y119UERVbXOnQ26s8rE8GofTNeCU8521ndqrj3qX6394OPeTK51HrKaxnN/m8AEix7/22urCSPHAm79vuYq+M89xmCBZjDXQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(2906002)(82310400004)(40460700003)(81166007)(356005)(4744005)(5660300002)(508600001)(6916009)(70206006)(4326008)(8676002)(70586007)(8936002)(6666004)(426003)(336012)(316002)(83380400001)(36756003)(7696005)(54906003)(1076003)(2616005)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:02:11.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8690f46-2ecb-489c-7c67-08d9efa111e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
index c7fc790a6390..c049c1967ec3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -692,7 +692,7 @@ static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
-- 
2.29.0


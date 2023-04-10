Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0133C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDJUUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDJUUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 16:20:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652631FF3
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 13:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb4HmWqRrrWRxmx69HJrpLgWTXb/i+dUJaVzP7CeHk3UU/woJquxW4wEKHSyNgfydRgFqFtJvn+WIHa9PDXufp2wSOfxNw/tHj0VyR6vpThm7uoXtbTgjGxB7O/fqPegkfSYqYNZ3sS5pYUUvbFBZefxvm92XiifZQAViVRQ9vpL/DkJ0qiHa38o6JES3zdEpIxzHpisoYx8zCZzPjOVGx0heYqwKPtUdqwe9q7sKCtn8AACZT3/ZHLMXsdfyZGLyt7gNXrAU2Eczz3ccWR+5jmTnViYEWnvtNO8kLgKYnCr8Cte44fynfe79Ynmn82MuUMnu1i3cebos9OHsLCNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkjbMHrAnoS1LUOyAciamDb6/yZ7245CwxAcTnFSdJ4=;
 b=LJj4CwAPknIOSSo4T/qTn6CO5UoK2GRp9dzaMvZoHh96eQ+nWnkieSTJ+GpURmnGSTe+40zVFLwfZzfcGRzCcvIQHgYJcbni2wgBUmj9PodwEL6nAUq7HvTt7DVX32eb5UmNlw7HPubzM9yQKBAEB/AXCxbtw9wRWFhK02+EtIRV5aYCWSry311TRozpFd/ADSNAaD1hhrl4Y18wrVM8wI6HYazCu8EKwgT3VKridJu0DDq5peIuiEblZ8sCzliC0IsL1jJyVm9xn/2bpT/SjzSOJkYUW50XcFKQXGRSzb/zTNPlO1uOf8IMwL1wqqlF1XZCeDTaK0Oph0nFLrTq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkjbMHrAnoS1LUOyAciamDb6/yZ7245CwxAcTnFSdJ4=;
 b=iJoSrKwhwLJ4Fd5u4Mhzb5mYpzudrbJKo2gZr6eF2RYhTxWqG1GXkxo4Wv1h4SRIdPyOk3QYmAcR2mgXTLwd2qFN7mlA9p900pGph83CStIwVjCaN1Hs/BSw85/w2WG+YpoL4vEFVOQ5la57jmgurS5o4LPNZspSCQ+5ADdp6AVWKb9sdkZX/NElwu7hFXrpyqVrX/WPqLt+qfd5yLveBuNMxbIU5zG37lH+wI49QQM5PaDnXhG/goDroaLrSB5QbPr+P07bblZWhGT6lAf883IPBR2tkTqDEOOUdwNmqYSRIjxhqD5rIkfxPlLec9l5soym+PwM4QEv9VM62f50Bw==
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 10 Apr
 2023 20:20:09 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1e) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 20:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 20:20:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 13:20:01 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 13:20:01 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/1] brd: use memcpy_to|from_page() in copy_to|from_brd()
Date:   Mon, 10 Apr 2023 13:19:38 -0700
Message-ID: <20230410201938.59122-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230410201938.59122-1-kch@nvidia.com>
References: <20230410201938.59122-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: d7615391-3092-4896-9b6a-08db3a00fb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueRCZx89jYF7wdpf9SfXRQhNTqIvs7R/dQXcGV8Sv+HiIGBE0rSbku6PZzhnRv/HnD+xy7RdrAAxWwkC/ULa4ng8K0d6UN4+A66LcDHDdXClFG8HZS4NiUDahMyFTFdaEvOd2Jbzp1KdtVzvW5ferRoFpyCwIlZxSCFqJkaqxhGIN5Pd+f2l/lDJ/jjmp0vN7NPKZpQHkm0K9TGegtcALDZw0GGqBoJVy36yLohNGy6/0kExvEleTDlY74/wU3lD2WNRoWIZdFZx21EKmoOlFy0Xcl1nejoGtqi44/JpTpqN16JfjhN9SUrJOs5TyxEBKjyWz7mi62jxLulHRilUFrIAWN3HSyJBBci66AZ83WsDw8LpnKRjfnFvT6tIOLbxmdgiIVPJ+EErNW8xI9SWexu+P+JBGZm5BPrapsWrUvlUXqcnLEpZ0wQFfIzKRYQxtl2ezGcxpj9jStSuvYbUcV/zSA7V8kzdjLK3W6qLozmt8RD28clKbImg/HjlDVwxurhAs02vYUl4dkFJmAA6HCAmycGP/tX3GblM7PZtIBfKX+8KEoh0Cf53vD+Z+om8gF16UgZiLs8h7smhrBp9NBuooSZWpa890GtZiBkHMk2Z+/UBhNYxnbx78VbD8k/78lg7sBdafJmKJDQ35srr8P8s+rlNL1sD17FHtzuvjmYEiTM1Iz3NohwXW2EQkazgE4zLOOIPklgDu79CMg+ymLr9T4H54NrWLvsE8rdATq1/HF0UriNfY6+ewaZwUQ1B
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(26005)(1076003)(107886003)(40480700001)(6666004)(40460700003)(426003)(36756003)(8676002)(7696005)(82310400005)(36860700001)(54906003)(478600001)(70206006)(316002)(82740400003)(4326008)(83380400001)(6916009)(356005)(70586007)(41300700001)(47076005)(7636003)(2906002)(336012)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:20:08.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7615391-3092-4896-9b6a-08db3a00fb17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() helper does the same job of mapping and copying
except it uses non deprecated kmap_local_page() and kunmap_local()
in copy_from_brd().

Use memcpy_to_page() helper does the same job of mapping and copying
except it uses non deprecated kmap_local_page() and kunmap_local()
in copy_to_brd().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 34177f1bd97d..c1251159bd13 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -189,7 +189,6 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -197,9 +196,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 	page = brd_lookup_page(brd, sector);
 	BUG_ON(!page);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	memcpy_to_page(page, offset, src, copy);
 
 	if (copy < n) {
 		src += copy;
@@ -208,9 +205,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 		page = brd_lookup_page(brd, sector);
 		BUG_ON(!page);
 
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		memcpy_to_page(page, 0, src, copy);
 	}
 }
 
@@ -221,17 +216,14 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
-	} else
+	if (page)
+		memcpy_from_page(dst, page, offset, copy);
+	else
 		memset(dst, 0, copy);
 
 	if (copy < n) {
@@ -239,11 +231,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
 		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
-			memcpy(dst, src, copy);
-			kunmap_atomic(src);
-		} else
+		if (page)
+			memcpy_from_page(dst, page, 0, copy);
+		else
 			memset(dst, 0, copy);
 	}
 }
-- 
2.29.0


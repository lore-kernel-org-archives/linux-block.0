Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD960C04A94
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 02:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHACaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjHACaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 22:30:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAEE1BF6
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 19:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9ZXW81JOYsnXb0iDNcbjmXvETvwq8Zc07araG20tUR3xWScd6jfWOnkWqsjZotcpHGkLkqV8bqeVmZI8LorCSsXKlfPvWoWQzn3t8ADB1r/T2OgB/ynpNRHoSuL0Ca81pc3w/cBB4K4Z8CnRKAG7MqWiHQKPMbqVGRxYYsg3Ul4HUG5fOeyiyJCRcqUuu/p16OyeL4YDCb8yHljvmbhyeg4j/jMd/Zug1BerBLTWiznGdigthgWXxN10jmZCARa+UcBn6DSxEW010E5pBJClvvLbFc/MxlcMo/S0/QXyvUEpH5F3C25iP6FGDoYBfAENOfmQ2xmUIHN44p3Ozy33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY7WpvPwaBRCYT9DSewWo2FNIzrT9dZqjKNwdn7NXgc=;
 b=LiWsn8QFXZ5cOzNIStsYONF8OKrUUWHhTuNltW7giQWx9sqOHDdHFtz5J57ImiSDgC3DkjQgoJSyXTS+CJFsIKxj3ud6rorf6I6jzpVCB48NyGyyu0chod3RuvZiLc4oSJnfrT/wwKUhrgM0g8Ddlwngb90auSkb6FTX7ZuFQlMpEh4Fg0QNves1VsL1GktxEPi7pVNLp9DuYqkDZZ/RSvqdnZtNbhPhSreTD7NonGwAt5ZVChYx5cNvigiUAGWx+JqomajGSIaLN7rAQIhsV3iItyltIYrHs54K+LwaEz88g3M52qbJaobh5qr00orCYVXCcKsfdlLodE1P59MAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY7WpvPwaBRCYT9DSewWo2FNIzrT9dZqjKNwdn7NXgc=;
 b=CsBooy2Nj1wrr229rWhpYOaHmUuh+4LGyqp3t3jjrFVKYVpOaXKaRBtIk3nInnPgRIYNQdJeWHoR9oLHLzbwPNBr+h+Ls5zom5UBJB16oOcz937xIB2WC+WB6+guqTlN7nBFirbqliMKddv4FX36IQZZWnIySsJCeI6pJE9+vvTT6e56VQWcQrzGUKuJdI/Netbcxl31ySP7SIomPABBmYj+1u2GZfagDBTjjuQslabDoEHRbQyyyAddFqjLOKTnyaQtgR66qQckbAAoQJX4VH2Zols6Cz1A24MHp6K5fqc3ln4GVPfy8SFtT/DWNUTsBrVyjVxlkQ9SUiCW+xRBAQ==
Received: from SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::22)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 02:30:03 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::8f) by SN7P222CA0005.outlook.office365.com
 (2603:10b6:806:124::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 02:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 02:30:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 19:29:47 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 19:29:47 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] brd: use memcpy_to|from_page() in copy_to|from_brd()
Date:   Mon, 31 Jul 2023 19:29:28 -0700
Message-ID: <20230801022929.8972-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230801022929.8972-1-kch@nvidia.com>
References: <20230801022929.8972-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f648b2-c2a5-4a90-665c-08db92373605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsqoaNi5YlXoETspeGYJicn+Wn8tCN5jHR6UGv5OFrOmEhtlao7IoB9VCwg0CTwOczT8p5EiN94fmV0gxWEvkHOZ/QOQ0QV5C2kfHfEQkXecTI9laeGIaR3XvvkAUCMevHV2oeZE7vNWcYR2q1/CW4QIMD3jfVxue/uiSb7LtCY6wvwCSr0JSzK7iEuiql1FotpFFfURpql7pG23llu12fAu5qZCLgT0gdxwTK2ecYGxJgKBGl8lSzTBBd/H4fzxsrIHDV+hfuHHmsZhz8vDqjklGYWVvNCPZr3YnvEOchM/xqCsJL20YY9H+qgOVocMIv/JXnE6R6XJZYC550NzjeeepejVJQDSJCZWfqCz0b+EJ9w5+M8cA1BptitdpE4tmd8xIl24SDb2r0RgQvmz2AwagzBvw0ljEvpaL7ZfQLftQSzYV0GbaFmT9vMN5Nlu6L48iLLX35XCFrQ1oPNXhl9ha178LaWyzGqU6YEhkWjmrpvc5sKqaBlwDN6WZG0m4aCsaWW2zeX4tqMUie6OIU7g0paHh5cEkMJSyKHH/nBya2OmVHYb09Hfvfzogwp72Zh2gh3RN52e5VMz5webqiKJPPwcyVUbMe7YXV09/V+ctuxqeeM6eRU0BU+3V6ZdrOlcaotn1+PyipqKN9BE1PBcZJZyeWMzZzsTCWSjKDTqwcXkbpeyz+kzoGm1bbedD0rBYmEYstLyrzqL8V24aGFhc8hh6+3V3rY48WUQ1CRtlCcvwXnmrM4a1Igd1CfA
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(8676002)(8936002)(316002)(4326008)(6916009)(54906003)(356005)(7636003)(70586007)(70206006)(5660300002)(82740400003)(41300700001)(478600001)(2906002)(6666004)(36756003)(47076005)(36860700001)(7696005)(107886003)(1076003)(26005)(83380400001)(426003)(336012)(186003)(16526019)(40460700003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:30:02.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f648b2-c2a5-4a90-665c-08db92373605
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
index 970bd6ff38c4..d878a7dc616b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -145,7 +145,6 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -153,9 +152,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 	page = brd_lookup_page(brd, sector);
 	BUG_ON(!page);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	memcpy_to_page(page, offset, src, copy);
 
 	if (copy < n) {
 		src += copy;
@@ -164,9 +161,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 		page = brd_lookup_page(brd, sector);
 		BUG_ON(!page);
 
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		memcpy_to_page(page, 0, src, copy);
 	}
 }
 
@@ -177,17 +172,14 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
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
@@ -195,11 +187,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
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
2.40.0


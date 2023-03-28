Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC63C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC1T55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC1T5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:57:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67B40CA
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ1AZfEmrG6T8BCTb5SwcOqFx04P7YzUOremTlRJdf8h1F9XzcsUzV+hHMvJg9A+VEcBcREzWpeFtKvRvdloeh5fPvH4XC9i+7ZJPJ1ykDXTlRa/Mtk35heYJ2t300X2szH8Z0nJo/jZrXfQpJR9tIHnZ2979qAAD8dzhxvErNCEwvXerKNJB9hsnM2Ue4GxPK8r/Q+GbDwEbzMlO/plHOGuebfnE27TKeT1wtggoVw13l+5mKo2/lDYZkMfVhcU1r114hi3YoSC3i6xfLzfdTYpkEaXDeGVnvA+vJPNo/yn22csOZ2BV9xZ0YOsPvLvnTSVICwSFsyDZHhITTAOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12VKJpsoPU01xKPmmdcS5C8DYAGTflWUSkKNjZpqFnQ=;
 b=HGtZMhrB6inP1tReRURn2JjdqdIiRRAaAE6u0Ups/WmdHASvuAJ5luEzQlOjBQ8Qf4juMV2ln46tffX5c8BRKjXoosy6/ABD5PtXuxXg0dSOoHOGDgNYmsh+aS71GTp1vytK9zhkGBbQ8YOP4lq6WyfxbormQB6aVan5S7W3blB8OyxsyUxg0QUo4AC0vCPZI9UDD8fyF4387FpCw/aDyW/QcNgwcI5W6LhItGkERTQMENPr3PpONtTNebrNoRvpX8bdV5Ab2FnUvVN8gfFuulJLnIZdaVcdf6I0aQpnyhq+dDBdUdz23hra9GbgfuW6XT2ibK1QodNYb3vypZWllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12VKJpsoPU01xKPmmdcS5C8DYAGTflWUSkKNjZpqFnQ=;
 b=WzdRryFz0EV+PcCi7hW+atpIEfdIdiPlo8roXeqAwO+AV8iA7tEoHufj6RejfWlNbPITJtPOmFeGXe24hYIZWha5cbdPKAdjXOiILQo/fa/0OfeKlX2VOa85qr7QE+RwFuEiwv7As32lfOGcCElr+X4NXk66iCbtlEepZsvV6bAn/sGu0IT1JvLOAzcr8LWAp7wrPW1ulSwaBHaTE7fOVp74oXnqmJrxw4gtBPf9FYlsD3vZB9ewAc8ja5PrgwvkV4iLq3wyMNHHdW6dpjWuOJoeQQhHn145P0PsvbK50gBWqh/dEH+hBJ7G2OdN1eAva5i+FsAmswLgWE+Bty1ieA==
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 19:57:27 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::69) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 19:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.32 via Frontend Transport; Tue, 28 Mar 2023 19:57:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 12:57:17 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 12:57:17 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/4] brd: use memcpy_from_page() in copy_from_brd()
Date:   Tue, 28 Mar 2023 12:56:26 -0700
Message-ID: <20230328195626.12075-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230328195626.12075-1-kch@nvidia.com>
References: <20230328195626.12075-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 46204c99-ee46-4ca4-a057-08db2fc6a828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEvOZ1e3pq+GNwqXibvoEGMFT5XEbbPKNbfGY2RSB5oHYO6L0tW+V3gnQpyDTS0hfLM499G+vpAY9Z8n+yp++3P8CJmC/uwHsd/1mWjavI9f0h5aL9Zcd4wtMjMzvlkbkRejyTBQq53w3jePpKRTpQXChjDWNlhPaswC4ss8zVrmTUKINcRQCYu1Lgq9aled1EIp3oR2tw/cTGtPL5ZIgZ8tA8SEeRzzJiYvKZsrwZ5sjoseQfWD3mYZctIJipbhtmuLykdr3pjk2cY9ApXzTkml4nbfKWWjrM1pGbomTopqP/+QHaXySvojQTkRr/KstIIzPgGLmaHJoH4fHzyOFEr7PeBFIrgZDyxVxc7HsndLs6lf17GlL90lnzoIKI7AFFI7obWmWQEOaelZJM7wGmW1SShoDZ9uXIdu9G9X/awoNCoHNWcTmuIldqhmuweiUqThwzHJzxE5+rNBx3UJRDZbM9glx7BZXmsZAjN2raWBp4lXb0iIXPTt+axxLEA+gVaY5sIHQPz9oigiGobHOZNAhAy1zXRXIN9hw7KXqd+0jhBntHzE3oWM8P5B+RlokCxe9+g6DwApsvZaBm5/gbNajpjs9FsS2GcuiPX5NNmEDVfXyl3km6H9mogUXrKUV1OjmDVgWP+gj1AVESrhFAEEVk6wUkpogO/fDfde9z2c6g8sHyTmGvkp7LHHdCI3i4oKV+8YSvhhKt246abqwxGSQdHpiLccZHGLXTYV22twAtL92VOsXYobmlxJDGw2Z6Z3DUMpzXhlntyNCvwJu3PDnztmDb8ZGAt3Sa2ZjwI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36756003)(70206006)(82310400005)(8676002)(70586007)(6916009)(4326008)(186003)(16526019)(5660300002)(83380400001)(426003)(336012)(8936002)(2616005)(41300700001)(6666004)(107886003)(478600001)(7696005)(54906003)(316002)(26005)(34020700004)(36860700001)(7636003)(82740400003)(1076003)(356005)(2906002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:57:27.3228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46204c99-ee46-4ca4-a057-08db2fc6a828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In copy_from_brd() it uses kmap_atomic() call on the page in question to
create source page mapping on buffer (src), then it uses memcpy() call
to copy the data from mapped buffer (src) with added offset and size
equals to number of bytes stored in copy variable.
Then it uses the kunmap_atomic(), also from :include/linux/highmem.h:

From :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() helper does the same job of mapping and copying
except it uses non deprecated kmap_local_page() and kunmap_local().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3df4b45eded3..c1251159bd13 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -216,7 +216,6 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -232,11 +231,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
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


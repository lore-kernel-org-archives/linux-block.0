Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE10C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 18:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjC3SuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjC3SuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 14:50:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2221.outbound.protection.outlook.com [52.100.157.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438BECDF9
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 11:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjI3OA8fsspI4QhrNwfi/YTBkpbTz3AmtCUxDZO4RvIgOlJ60xWRSoD/ZkOeP2D92E7ULl9wlKZByR4kIBd1jNonCBQMbjqrzDkCX85XoUMuVAhZ0ftXKMDCy995fdNtXDlMv9J0KF56p1UfypwhHBpAHwCj5+dVF0rw6aR7pNxjTdXZ104tIJtX3rZcz8LqAdpXofK3zZRCBoADpHeh4Q+Vm4+l5ZwNE/QXmkO52HO60P7LNvN98s5aS19RC9lW8aLYnUlYxPinvb4Ai6/S1gB7xpt6ch7iAHkMe4gesqPzt7lFG07JgY7z94ap5L0WeFkvQwZKLZrYTGM5W85/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1TySKm4E/JXk0y78pCER21hGF/4ZOE4cAjOaM6faVE=;
 b=dUgmid7+p/amr16AeyQ8ZLEmnfVcob+ze4yiayBtTaVve/4vwiN+z/bD6kuXc90tRsJURD8c3nZ3enUz/qCRhviL6crVmzQIzrp4QqkmgspYDpZxWQWb7a1phA3yC+6jeGlXDrH25oyvnItF/xs6I0g6ta03hkMkCYRmYXR7q3kVLaUgVCjia+AbbkCJN9fVc4HSLgjprSjx1qU2qJgfBCCn/Go2vDuy1Qm9l31epeHxkXDHABwK80MCJ6VzWvACmepap/6DTTK7zlwmsPIuAm4JuKkGALhPitwfbyZvaPnFQheo5Ko1YJNF6dQsO+vXyqIfDemCoScKiZ3NdqZaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1TySKm4E/JXk0y78pCER21hGF/4ZOE4cAjOaM6faVE=;
 b=AzSw80rE41k55Qm6Wjh2I2Und/e1vcoLh8PNQBdWvEYGxdaJpyglM5M48kIsB86uUtTuIAAV3X7Uu0f/gazqgqLRrB8u3Y2UiEsx1OhwZAo7Ot7Svu2ixjf3cyBT9g1oM7K/BTEyoiyO/E9LbSGNqhv33x8Gg/MHzUFyoEEI7zN16JsKw+8oR3v5gI45sAP4zIIoyGg/hUD/cp/EKUmApHIrzXCYCaZNImyx6oTNgR4luNdjDIN2bq1799jQYhwc33lh5ip5zWPb+AKNc+dyObS4t0VfCD0bL/2lcWNFAa6AB0VrUXhR+ws/vQGjX6fMdCWJQ+sQP45K82quCtdbVw==
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 18:50:02 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::8f) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 18:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 18:50:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 11:49:51 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 11:49:50 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/2] null_blk: use non-deprecated lib functions
Date:   Thu, 30 Mar 2023 11:49:25 -0700
Message-ID: <20230330184926.64209-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330184926.64209-1-kch@nvidia.com>
References: <20230330184926.64209-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: f6625be1-5900-4109-cb8e-08db314f9211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9LVzYsLwhL+nKoSfNEkVPLjbZH0E2BNrgAQGIfcOjT+1tRVrnVWXKkG0jC+Y1IGrMCBFlzVWfE5Dz3EdkdKbirG8xxo1YXmHuPVtgd3V1Y7wVrg6EQOd41RpopNxRkvpTGbLPH3fXIKO5XFyE81vNc9TfBhZJ7+CUFIcHnfGOTBuuvz97CA6nVhlc0TzMVkdo9fldru6n+M257TfBjfCqCzX2unq3pok8gw2XFgx6ccZHcWsFCspeq+xECgTuUCo9TO+AP3AxqMEZf43MIGl9WHuyZAsD42ymdq+ck2ag3IMyLwRoqliyUOVFo1mRKpGHVGYcojzhtd6H9436hGgvy/4ZiwHRxn/znfDf3Cdh0kAHDDjUcv7XHKqyqchOCYFSsw2JHrgozH9Kpln3OJL2u4om55IplBUqEtNWUQ5UlxHgu/j9XUwUWl05Cp7inJPm5lc2aafwzTbaFzo1TI4ot7dd5RonKNMI/H3ptwr1CFPnICcMWp+1FgyD/rvCI05D05GV4ZoGf7iOys2E5jEoaMUtbF3FJZbeclFhiSWCGv7gY5OY1lA7YoyVuDTKPCYgKPfV5rXGl2DI5Llrao9yO52fujLcjWK+cAU5S4T7G4ph/eIyBppOKiSeJwBNnhw6dhkaDQ8zA1rSii0Kp2pU4RdO5WwY7F1iKhLT/tgfb+n8z+5etP157LgjgYL/YASB/xoD8lxWQTkmbH+UzyHq+yQPuMx59fWIkUvDd2yTNsTFY/WqJbued3D5abyzHxrTHnXy5dL5/1kyZFOI3GY6RYxsxLUQPENVP459xqvZAZD2GFFwh5KxNLS4BlNQq3
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(34020700004)(36860700001)(54906003)(16526019)(186003)(478600001)(7696005)(47076005)(336012)(426003)(70586007)(70206006)(4326008)(83380400001)(316002)(2616005)(6666004)(107886003)(1076003)(26005)(8676002)(6916009)(7636003)(356005)(82740400003)(41300700001)(5660300002)(2906002)(40460700003)(8936002)(40480700001)(82310400005)(36756003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:50:02.3999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6625be1-5900-4109-cb8e-08db314f9211
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use library helper memcpy_page() to copy source page into destination
instead of having duplicate code in copy_to_nullb() & copy_from_nullb().
In copy_from_nullb() also replace the memset call with zero_user().

Use library helper memset_page() to set the buffer to 0xFF instead of
having duplicate code.

This also removes deprecated API kmap_atomic() from copy_to_nullb()
copy_from_nullb() and nullb_fill_pattern(),
from :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e6b032c8ecc..41da75a7f75e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1112,7 +1112,6 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1126,11 +1125,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		if (!t_page)
 			return -ENOSPC;
 
-		src = kmap_atomic(source);
-		dst = kmap_atomic(t_page->page);
-		memcpy(dst + offset, src + off + count, temp);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		memcpy_page(t_page->page, offset, source, off + count, temp);
 
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
 
@@ -1149,7 +1144,6 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1158,16 +1152,11 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-		dst = kmap_atomic(dest);
-		if (!t_page) {
-			memset(dst + off + count, 0, temp);
-			goto next;
-		}
-		src = kmap_atomic(t_page->page);
-		memcpy(dst + off + count, src + offset, temp);
-		kunmap_atomic(src);
-next:
-		kunmap_atomic(dst);
+		if (t_page)
+			memcpy_page(dest, off + count, t_page->page, offset,
+				    temp);
+		else
+			zero_user(dest, off + count, temp);
 
 		count += temp;
 		sector += temp >> SECTOR_SHIFT;
@@ -1178,11 +1167,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 			       unsigned int len, unsigned int off)
 {
-	void *dst;
-
-	dst = kmap_atomic(page);
-	memset(dst + off, 0xFF, len);
-	kunmap_atomic(dst);
+	memset_page(page, off, 0xff, len);
 }
 
 blk_status_t null_handle_discard(struct nullb_device *dev,
-- 
2.29.0


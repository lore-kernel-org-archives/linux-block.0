Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A381C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiBNKfe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:35:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbiBNKet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:34:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972566460
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVpI+fzB1CSyoO7YRy6IRzHx+Mtjh1JU6GsR4Ne5fDRfKoNI70w1cnU8ArgKDvLOJGThdIKhN+2meYr/AAxw4F3UvvJtnMUYXCC2MNT219+Gls+ASjvQt1hagc99LbkZlOu+KoqlJBs5zbex3tNqckZS0/LnzOTq/7Y2lyVfvGjEeEhV67QbZ/mWSUB7jpYI//ZrKt4jkCBf16JsiLpcq31EBcSMmW9/8A0TzskGTNQneiQSJ4k6aua9yX832Caa1XENnKZEa8Fe6SWD1tR1VYshwpLlFw+GHa2961/HJkg+5J39aGV3CauPcW8EwqrULnfOIeHaV+Qh06BTK6DozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFvFoH1Nz/pvHArQHYwz3e1Yj5iD5MOCGgiONhtkfYk=;
 b=ZhJHzaLIF5Rk3fFFb9UnAfTJf4i+jSjgNEnKErfDzeS7zflY+r//vDMb1KkuZqs7QV9xtqHyN9TIlWp1Hql//qnEOXgJGFbrYWP7g/jKxHs6MdnSoVZv+nC37QnyHHwfbmBuWoNf1gixca2APtQ+x0iDCYoNBOgFpo51ZoMHZh5748R3vF4bbOG84+u0D4PbmS2AzrhY+h4nEnPhNSS7cBg/3ae1XfrtmsHas5OSe3cEzBM6YPc4tD865SHYw7VJszFLPWdHeyandsM38yRpRbQSjfZksp7218hKLdOX9ZzcEsRceAQ4EicwUdsyzSwVdLJw5i8fEiKy9kgc7Re/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFvFoH1Nz/pvHArQHYwz3e1Yj5iD5MOCGgiONhtkfYk=;
 b=MWFGzaRAttLgOrZb6DmuTXWkRFnEGnKSlGTKII2s7kOhvOyttTjUOXSyEuPwAlBjP8F6nfSvUrAIU3gLTeHgx5s2RBZXIS6p3EhejOTSllV0a8avDh0c5izbE3OpEXb8UlwJ0zq/7ugcI9ILYk7+99daWoUFf5BKeDEqq9cDBcHCfg4xmqLCzTKM9thlljDeCiQ5qqx6BxSXz00T5kEJ2I3Ow0to8pY/uKA9peLVVdsQE7JcYTgbsSEqRdy0Co81MWXF/qIGcax9/Q5B6+IPxNiQsNOGcwMVDg+5y47Qr+JWhFI2C4DcXseXn5+XsSEuoObahTVHnubM64Bwtj6Jww==
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CY4PR12MB1400.namprd12.prod.outlook.com (2603:10b6:903:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 10:01:56 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::a8) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:01:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:01:54 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:01:53 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 2/8] loop: use sysfs_emit() in the sysfs sizelimit show
Date:   Mon, 14 Feb 2022 02:01:13 -0800
Message-ID: <20220214100119.6795-3-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: db042976-69a3-498b-7c33-08d9efa10869
X-MS-TrafficTypeDiagnostic: CY4PR12MB1400:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14007E4E0481A9818F5F7D6DA3339@CY4PR12MB1400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1WsjyHQLRgjoYht3pFxH5OsbZRlAcfEH2QcLX1q+WQIJem7JZxOruoZYFAt6fFIaZn2uYpkHx6hgWG3B+03U2RQ60PzEgiNXzvXNSYci4PsgQ6MsqpEyOXvRtO9DZkqJC4fEgRLCq0ccl0elXyDxjii08DQQKd5pttkviv5mDdgEmvsL7m5Lt1Lg6c+1wt2s7hedgVHvjTV7tA6uAt+0z14kM9qnktbDobFf7WLS77TEgeIZCApgJYdsGhiQYwF2CDETESbQISdnNK6P1jTbU2xVx0SC+G7kNxceDb6nbZ5nLCPfm9Ps3CUYZLdqoWT5wnQbz7PBayg3L5GJXPCie8d4BwqY1zK+Ov9nBbZOGNa/nMakuHHEssSVAO+ARQxGf90hsTSUHBbYR+wcFpqtSKQsuq/JCQS2HhqdyHNnyWVeB3Xg9dQkOHMGz9CfB7ycwOrZZrXqgHjrXgXJ60X2300V96MATsX/DaQGqiiVtpNrjosf4R068Znhu7OvcGyhdNAo69Zh+rcc4zqRYMIz1JHqAhc0EemGAxbOtxKd09Df3fa1vCDfYkQUw5AUPZQAw1g0xnIeLjgSAxESlramXvqDWkeqTRy4/lEjuTfHZ4GPhrUK2nh7yEG/UBKQ0vCN97Y+iIehuv1abIcagKy0T8HmUvP7kQsPaZ9kYHYV0blG2Mhu4d69y9W9ByfEQckW2v5swhupnSX3QVtBFzumA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(508600001)(4326008)(426003)(16526019)(186003)(5660300002)(336012)(36756003)(70206006)(8676002)(6916009)(54906003)(316002)(2906002)(26005)(1076003)(2616005)(83380400001)(40460700003)(36860700001)(81166007)(356005)(47076005)(6666004)(8936002)(7696005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:01:55.7665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db042976-69a3-498b-7c33-08d9efa10869
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1400
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
index f6ed265d34e7..c7fc790a6390 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -685,7 +685,7 @@ static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
-- 
2.29.0


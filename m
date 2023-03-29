Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE74C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC2Url (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjC2Urk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7AF1985
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 13:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu0WegAVAexOxcLTl58No04mchTSmjHE6UwIIR2ju/lFsZEoq3xssAomqFStln/7+WqchfUpOhkjlRKpl5QpcsIBbA4j4yyNko95Ndckg9i8mdwNKCe7myy8NoWCrCxuq9n+a3UZnNT8ygM2l1Sqjxv3q62JDuiTaum6hFQON+VaQpKkcnl2UP1x8HpCTi9wn/WUkYF5qAp2Igm6zTvAoTlcHmA8wEyMC1d02kPmjptZ6oDa1V/jT+bn9MX6U/CMW5JISzV+FVBcB/B3jZMMsflt/xEpRFvkWsS4qfi3UU3Q3omICnDgmrMzdglNIMvnS2j1UrwuYlEbcxbnwR0zNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN3wDdbRiCYavdh8k2KrooPvWnt5IGsH5ll+fqkjac8=;
 b=GvjyFwvZBWAfFn1k/cdCJ7tsQYqtHTzrjfdGGBKOzsgJEZa9iuxzTxxfyIpIdGWPDFCuAlZ9PXyueKLGUevFvifRR9A9rQ8fhe/34vbv42HRH1QSRYoFiDgYH+wejDZ2UtLlG/9yWXAnY7YaPCu222cmEI8i2bdNEwgfckitD1blWrShq+8mZ2VFRreiHYCfce5vS87eMHIhnqOoG/nTRBx54LedWD03UnmmrFUCEXHr9GN+LDF+70jcQN4dMUCYptdk2diTLY5R/F4C9dSyzqbwPHG9ERqfAr45RWV1MxQmTMqn4x4cEsLWhZCGe9oM6C0b7O3Ty483vWnnMi401g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN3wDdbRiCYavdh8k2KrooPvWnt5IGsH5ll+fqkjac8=;
 b=IBqZsGilFj9lOy3ZhO/edUJdW28ziPv0nzDTAWQqyLDp8fjSR1tHfJ8ci8lJYcI8MvS7KI7UpLjVnrQgL6F7kizZ4Gp8CSQvaaEJ+SMZsj57WYIHcIrz0ziZG2bamIW+cg1UsyZa/WKtZ1MowlZWy7rHQKkLLpfOl+jpVrw/5npTPT2Pxja5dg6qhzCaASWAxIz57ofzQczQzH22XKdXgLrmHhoRLP7De6P1MTo4J4SSJeUVh8qu+rISqnFjpoUCAmUgikLF+M4nVzPqFpMMxz2VSkbefmKyYOFnDed4i+EKtz6FRFvExbWHImx6GVZLHGfCySqK3lhWBjbXGTHeLg==
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 20:47:22 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::49) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:47:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 13:47:11 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 13:47:10 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] null_blk: use memcpy_page() in copy_to_nullb()
Date:   Wed, 29 Mar 2023 13:46:49 -0700
Message-ID: <20230329204652.52785-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230329204652.52785-1-kch@nvidia.com>
References: <20230329204652.52785-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f231c8-d279-4a28-5294-08db3096cb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RH2uUgXB8wmDLyF2M1mMTv4udosfqsS+MJBDu/ElgsjEbn4qiHvLL0Bdv9f+k3oDZwVrIFQn3xw3eYtktPTlydovAVXVSXAm/I6012Vae5dZjc+Zep8aYa3StNTW2h5LqhbOVRKb8DhPzuI2lqk+62K7AadBNF7NhZ/nYmI16QuyizAveNi3JH4rySOwag6NbtyP9yXMdp2C7CG88MCXjwb1DcYpGwC1eVA7WkXHzWvozWSjYljDTYZU7LIKvqI24nJvWXiH/8ou+vK/MkXSJq++xPb2H97kV3f4RtBegidSzWRO5+6lta+t2ADHWKZmFRZWWdZbHHQnU0eqzQ0GESOwF7bkJ1MqoTf6RbkWW2xYD6dTg+NykENcvOeaHLHPVpqDaXcgTm2itL6oc/SH7vK3i3OhwQeJuQjM2qEOybAAZgWxOq/11a9ik7axwST+lwyb+SZwxadHvFgXayTf8xNt4gnxoJd05zdD4tQMWb+kJnefpiuRYZkDBfQo4oc2kJ0kHjDmhCB/soaVEJyhSU5zep4iAzmvCoDy9wF1HlCmZA4fiCt58+s95+eYSdmkmGvz4GTNgduVtBaFyi40gO0KloV0MKKeiq5kDH8lj3p1mA1mSKpqN4O3Wp7hPRx9v4b+WrmNxsRfp/IEkOL3+FKEIiXXIc68YGdKcFF/qSuCnE916lSIISOpCfACR4vWrTVgmNMeiKXzGcTvrQBBcC+aGJfNAd5MmkroPvvrCm1A7VLnOQQXsyA87Krf5/Nt
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(336012)(47076005)(426003)(70206006)(316002)(83380400001)(36860700001)(70586007)(7696005)(6666004)(107886003)(2616005)(26005)(54906003)(1076003)(186003)(478600001)(5660300002)(16526019)(2906002)(40480700001)(82310400005)(82740400003)(36756003)(40460700003)(7636003)(8676002)(41300700001)(6916009)(356005)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:47:21.6834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f231c8-d279-4a28-5294-08db3096cb5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use library helper memcpy_page() to copy source page into destination
instead of having duplicate code. This also removes deprecated API
kmap_atomic() from :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e6b032c8ecc..947bba174e1e 100644
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
 
-- 
2.29.0


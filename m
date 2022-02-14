Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiBNKrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349025AbiBNKro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:47:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8F6C923
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:10:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jahVHxQTKzfHMXAkU4imCgTDpuFyUTabr7TXf0Mj9+IU3AorJtGDDnpAKNfJptKfpLD/c2303lIlsuhCHSlEfsNdH8sVzsUAC11HzJVN0E+OMyULLz6mb/iPymfX1xUolDRhFJYus0wUvl2OGxZz0SArYo1qmpEvKIMMNAXL8BkgtXPavgmEEPtICSs8JcgSDm9MMhWG87SyRrPeitIPymQM/lfIDdFWKCkQWkdnxuUBOuSEf+A0mTGtnEfytPeqyloX3bynYOJcqHoDG3cMUE0Uoa9n6JXgbfwfBcNLbHMWDTime0xG8rVfzsNrez+WEgmE1oFTqRxOPNqFkJ7ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPlwqDd7TvC/4+kCUQSSNsPLDEhAKPVwk/1QK1jcZyA=;
 b=MXoLTL6JGeFx+VL3ZSsiPo22SD9lsI678RjjhLHhTE0rhoXepJH6s0tssr65oV3xhJf6ZEhah8mNfyzjryMf8Y/b8E3wp/EccaTgP5rfHgupUHeIfWruNyAmkrBueoUeSx1Ka1AqUK7/WpK5J5tK+eJolZweYzBgW50/oDglwuTyosZygsRk+5i2uuBJeaiG+Cm/IaXr43u57n4CHMCn0/DYpiYPsdJgsg3tBzJQfNPg9GHap/kftxfBEWvt6FH4DjWbp3XCmD6DIDgF/AQ/RcSfsrR0+q5TJoROgkjv6WxIFhuNATsaB6Xzyz2OZ4NFx5QlGCRh9S8OrfHd/dnsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPlwqDd7TvC/4+kCUQSSNsPLDEhAKPVwk/1QK1jcZyA=;
 b=e9CQyGvZ1qGNyNMqhu5PpIdyOqlDNqsDlPogDuIKlpxE2C5eKJY5DhveaboOdqwSP5iWu4yZB/H5RmZuQoDHH5j3NZDVPkFszNT0SEC/iaV43zSusD/wcjK7LTQw2oJfYuV3D4kQ3rMdn060Wy0JRPcg1+6NW64TEtkEch8xs0+n6WoENcDLAj8qGShihdfAKjU/TnEdBofjgK01H8cVKwivTlZ3h+UZcdUI4EZn1N8I1vUq7T056muPjsbMOgKPY087cZWim8tNzRGBfdbWqGP9lfsn/rPvEbbeG0zxLCE8KORTu0YCoQQkoVXbgxOjKaqHpUMFnmg0IvAz4A63YQ==
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Mon, 14 Feb
 2022 10:10:02 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c0) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:10:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:10:01 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:10:00 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/4] blk-lib: don't check bdev_get_queue() NULL check
Date:   Mon, 14 Feb 2022 02:08:59 -0800
Message-ID: <20220214100859.9400-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214100859.9400-1-kch@nvidia.com>
References: <20220214100859.9400-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e34cbf3-9047-47aa-a024-08d9efa22a20
X-MS-TrafficTypeDiagnostic: LV2PR12MB6014:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB60143088D7EB2237C10F1B47A3339@LV2PR12MB6014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBMYV+hSmXeDeaifGgWC3QRgPEenZhc5HLVI+bZnXgmDl97es3nIzRSVMfmQS51mNpc6OoJprz0BOsZDgJvmXeHpyBFtR18oCRQjUIkvZTpHoxDMLGbUY9qxFckMPO/4T9WEYnHIRodki5MmHbWEBUEk6vfQqcZPWxNVdg0sjTHFbLfhSGQlROdXo6vbBrJ67cCaRSI5abDZN7gH6X0yGFfuUn68D6Z13HRUhZzoWPLpjKpA5zqU0Dyr4BI2yGAKbNdpC5etq7WFPLT9/yIhAtpPd61erN6ku3kb+FlgAgjJumuWYvEq6HMh9bp+A9AmRwxYxbhfHCLzdu50uCC7iKBHIXOeHAUeUxv78XUfJEvrnxPdFk1Ja5rcUivJrjyBuVdYxz6B5Xx7U1jnXJFdK52qKlfr/d0xFbfbDsiDflGFrZr/Cg09PXr9sM6OkCocLsFwgCtetQI8aLCA2IZ1QTiQh6fempY1PnMIGUHJ/SOg6EupqPJxrVZAES90V2rcis6f8tcLysaGTzwD25OIj+N3cxpGbHBgJWxs9R25CvlI+C38mWIWONYdbAi1l47IjBX7FT3Ozoba71wYYND0dXkPNyHt4vX+jCwHwB9Hvb4ENAtoGFLsaLLmziRBkKvxZb0SuIcuiEsa8jpGpez6TYZqSJCpz8svchFxDYKY6VoDHFcbtv7q9dGOain3yZa0BZZmUtOwGFbb/WY2qPLK0Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(36756003)(316002)(6916009)(7696005)(40460700003)(508600001)(82310400004)(107886003)(16526019)(70206006)(4326008)(36860700001)(186003)(26005)(81166007)(83380400001)(356005)(2906002)(2616005)(5660300002)(70586007)(47076005)(8676002)(336012)(1076003)(8936002)(426003)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:10:01.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e34cbf3-9047-47aa-a024-08d9efa22a20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The queue variable is only used to check if it is NULL or not in
__blkdev_issue_zero_pages(). The return value of the bdev_get_queue()
will not be NULL based on the comment in the bdev_get_queue().

Remove the variable and respective NULL check.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e7a9ed8cc5df..e6e854936ef6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -294,14 +294,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	int bi_size = 0;
 	unsigned int sz;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-- 
2.29.0


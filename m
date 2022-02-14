Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5884C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiBNKq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:46:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiBNKqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:46:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966466C95F
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFBr69ykm7HOiXoVaMvdSs/vkOT6ivmgYbkxA7ha4HODwrMfNfbIe+yKbDlFJhgH1Zw3mKRyygwe7uW6f4VgE2y9ATsWiOGWWUVmEbHI/u7B6gvMpxzHTOyNN/BN4H+ipaJuufx5ggzU5CO8d982ZUSyz2pq0WxNvo/2rlLb3NDZWho8IfHbaJbCAaNFjhTmXn/pR/whMYPI421nUqsPI0iCQ369JKFTtR0581ZgooNhrbJljqoEGlX6Jym0gzX5tsDIm/UL/h4e2wFk7DVXdAbjdowo+/xkddIPbFursrmyx37HVfRNGfR4b4qBSYoX81MNAMccI5822c1X7e2ZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACXMigh5fr8YxK3B3wPOVKoNPwLQ+izbXVJ4mLhVj58=;
 b=gj7nV44okxyTJn94bbEmfOaSf+FmzS4MUEBiM5Cgmy9d4iky3975kIEMxihPJHVBKfbE4hDWrkx6VdOMJFLnJKubWMl8qpKh9Pq4aj0L2BnWA4xFu/tfOzpgj+yGCe9jYfB+AN4NMDgCEhDfVXRkp4fjyFxmDh38Pb29oiGDO0oDfZ5i4afq2ATM6C7Sjpb4MS5KDNJaOiPcCOt8k2hs5RLN6WIu9Rv3qjOTYvG5umKN3mGU4VRml6SpKusgY5IQOEQwnOGbdA3+auzsWHDamG8RglkeQrTdoFFDpRLZtJKHAzHX1x+mYLEv1f7CZqSczRHR41OIZIEuezx3FydDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACXMigh5fr8YxK3B3wPOVKoNPwLQ+izbXVJ4mLhVj58=;
 b=Z2kxfID6RmYQvziXPLvOTfNLXYYa67NnPp5JD4ZXtDwY5H/Odr5Zfk4zSzarBHERAyCC1GzD+8BCcuFonRrS3h6vK76S0GS9/qAH9cQVmGYa+qCjGQfLKZW5ZVmUC3WXfVLsSleIfctwrfyUfPjBA5qinjMuo/6fH/ghSWKcDea6QIPMKG02QglpYOmiyNkZauNpEMoiZuH2oEwnHRExLrMowb6ayuG3wGT8k7aSjWVK6Q8HaL9n37Zm4WwWfHaamxwJWlhKROatYUxpD+eGvhK0ToRd1oDpIqm0d1xdTGXKgD4vpwotSeGYi3Et4MX56fFzQYWok88eTPGRnsjYTA==
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 10:09:28 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::be) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:09:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:09:27 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:09:27 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] blk-lib: don't check bdev_get_queue() NULL check
Date:   Mon, 14 Feb 2022 02:08:56 -0800
Message-ID: <20220214100859.9400-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b4cd299-7391-4150-4ee8-08d9efa2163e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2942:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2942949261E91D79B51E7C76A3339@MN2PR12MB2942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p75v9FqzW2mRoR8K2a1OujCJFKLlIZU+21ZIghT1eb1Xry2UpCAxXgrdmLshOXI6fEHzdflyfH+oB0BG1Hd79NSFPyxmZx6vBFBQg/baSWnkXn2BbjPWQqZAO9s/+wv7uApKzefH0r5vXDA8GSRGx+tltL8FT5k797lBfLzuyBilnaWKYNOBapZ4AVeFre39pa9Kpf29QbtdSunsgVpDvxFBkHqvAPil5g7yexuWRkGhbuC5IcQZAPqK8g5s3Pewx0QrvmB/Y8csweAVap3FccUaUbGYElVsYjrc2ZeS8rKAubal+4+tdBKvW4FEwS8bx47thXNGuobcIoklCCYoDbcgG7AnAWeTV/3sUR7wf7FxaZTlx4E9JO2PGuiTuCit3GZYG/0g5x7Lo3eRiqxixIaWN2XMTnlJ3QwyfvfI3LdBMoqV7uHc/KWJw+JTH/6twVQdN7UggwLEy6YQDIVW79qNXbLCHuVMnwSIx/PNHhKJ6y9nyXZUk1ECZXQ/ymfD/QAf+KMhfCR4B7s39jS16rrPUMAXO1FkAZhnj+1q0YG/EJsx1+YJqgOEr9aHYpSZgxZlUBGLdktcOwqlE9dL9f5WXl2VQOFsBiV+3xZQbP7HZxKz0m03dDjIk+1i0pewXgr58fGM0o/8LLB/8f3r9QViP8XXXABIkdCpLjqufcv1x86hK72isHVfkuATCEsYtcumbKA1xbbH/nqRFrHEfA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(4326008)(6666004)(107886003)(7696005)(5660300002)(70586007)(70206006)(82310400004)(8936002)(8676002)(4744005)(316002)(6916009)(54906003)(40460700003)(36860700001)(83380400001)(81166007)(336012)(16526019)(426003)(356005)(2616005)(1076003)(2906002)(26005)(36756003)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:09:28.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4cd299-7391-4150-4ee8-08d9efa2163e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2942
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the comment present in the bdev_get_queue()
bdev->bd_disk->queue can never be NULL. Remove the NULL check for the
local variable q that is set from bdev_get_queue() in the function
__blkdev_issue_discard().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-lib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f09beadcbe3..08ac56eb3a70 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -32,9 +32,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	unsigned int op;
 	sector_t bs_mask, part_offset = 0;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-- 
2.29.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB03DC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiBNKsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:48:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348850AbiBNKru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:47:50 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D0BA777
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiBvggMrhRlP0hfi2kAa3fcldu9xBTdcaKdEtyjHEimcLEMukAVgbWDm+QKJRuvgor17Z1JNTXgfDhfBqnsfG/VJXZYMySb/i9vd4IHJRLdKtV6+o6MEW0fAykt4KKq+yBwenBkXuB4mnMvkNxo4WoGKmR0Waxrc6HKFI/hGUYsRKkeHUfaSIp3htTkUVWmyGYpMTAHXDhzRRp9utAbscKXTfI8AnQBk/TI2qmVOHMHaQdX/gISF8eJdeBXwo0BU0rUuzns3WqWjggjR4gxzFkGVnWMe242r0sVGEwEClntg2Js91wBS97RSb28lV243u93WBOLIDLrw3f1Gus9QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWLP4rNw/sOjkmLxPQlHtMQx3nNNOSaIOPDSq4VPtIU=;
 b=BNzs0YjXJ2Rut8V+beopMmDrnh2KMOorsp+TQNDX+Jk/2HOMdgi2KSJFuENWpb03hMd1YPF3ghPb+LHH4n5dNFDCBYtSuaTtqkC7w2nfkBJZp9qeqXrAClMU7Qb5pe1IddK3nYFig/1Uc3vii/2RpsNFmUAWP4TXESc7nUbGvTmnsA6MyGmhgjocC6FUj8yZNSBfGErnuexkS9lfmN1vu0hIHMFSJBT4uSLcHss7UU/8zg17dnsQ99gzDr3eNoD0cd/5VTrLVn00JnsHzVp/RqepKJ6YG/wWjb5YfN2kVAkJuIxzgpDY+m94ikUyocuOUa6UPPcJIM4zuzQ5er+BmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWLP4rNw/sOjkmLxPQlHtMQx3nNNOSaIOPDSq4VPtIU=;
 b=RoxIrEgWEAvAouahP/AwM5/1ZZjNwK5z1htYCjxB4Tm+kcKbZiqbdt/AApFuH7kU7f9FeeMyBkG7+6z6dCLp/405rLABdzL1zOZLQGFnO2WQnlWCU5K2IUHmqeV8hfgLdCsqu1+Xp7XXCp09Au3wwC4mXErTNcjuLnsHPxCgplzummClGvjG/WruC9ksBhIg242sYzKhgWgX7Cc93F67ykUz2E6TWPJ8KMnt2zNbIFMJCavCsy3E5sFtlo9nNYtfdELacUeasXMQ+hOQKb9gQk1hhb/sekTE67da1eXvLehEpiG8CHPCoK9Bvlja2KWqQpNFTZEvxqjeFWxsP2334A==
Received: from CO2PR04CA0204.namprd04.prod.outlook.com (2603:10b6:104:5::34)
 by BYAPR12MB2741.namprd12.prod.outlook.com (2603:10b6:a03:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 14 Feb
 2022 10:10:15 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::f7) by CO2PR04CA0204.outlook.office365.com
 (2603:10b6:104:5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:10:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:09:50 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:09:49 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] blk-lib: don't check bdev_get_queue() NULL check
Date:   Mon, 14 Feb 2022 02:08:58 -0800
Message-ID: <20220214100859.9400-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 713afcf6-840f-4ce1-37b3-08d9efa2320b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2741:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27418BCBFB0262E5B6AB5798A3339@BYAPR12MB2741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAqpCU9cx6U90wLZOUZ4kzYWPzoLW8o30jIJoQOg0tjtDooC+qF04UT8q2M46JWy6U8yDQAmztJoxB239id/XcjqNNttPkAEsmzIABpg5Zp6uTRC8P/Alqtw91ggp9/j3Ukc1oppyMGOZWTrdDKa9lqmpSjcfwxHSS8//yTE2Mtw3sPDHHSTKI+UhX28oLg/xoRJBN5y+tpw4BfEL3tA/CNl5H+0YRK1DDPh3pTL4AWtRCeWk+vIXq1g6a/UfXzyNOCVUa8mpZ3+s3PUj38v6VNrQtQBNQgtGO3XTrEMW6rIgyUmcGepI9raEQ1LKGFg9O5dPTiyUF9oN8JTCN4Jg/IATwVLCTnDISCxUIxnnyHIrBs8N9xZbbb4BjE6fPlkKirY/83N0q/mLLdgsfoz1UGdFanK2TVl+VyPWE67a9yZ5q4u1VEWCAvS6kBmlfFpNla+K5jFhW3EGGLf6yIs0GqcT6gxCzHl2qztfoxbeFDyAVoe3LYPa2Wry/j10M+pu33viTwt/oIzB8ffl1dG6kUtXhuGqZ3Vyg0Oiwu+tPCL53pjCXtRAW4ArrlXpT9sT/NmaXZK5EjVQTOPj8D3E6fMNrMpxfPKLcO+rT9oHrCgeKeOYaFbrqym1fpNMlJDPiGlw9aAZQvkJ6UyhXMu+iLVZO/5Nj0z6JceOaSCc7f1r+m1Xn0EkoVmjzNQbm/U8zFqCqclmV7sIkndZrNQ1g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(70206006)(316002)(4326008)(7696005)(70586007)(8676002)(47076005)(36860700001)(54906003)(5660300002)(6666004)(508600001)(6916009)(81166007)(26005)(2616005)(1076003)(426003)(356005)(82310400004)(16526019)(2906002)(83380400001)(36756003)(186003)(4744005)(40460700003)(107886003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:10:15.1722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713afcf6-840f-4ce1-37b3-08d9efa2320b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2741
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the comment present in the bdev_get_queue()
bdev->bd_disk->queue can never be NULL. Remove the NULL check for the
local variabel q that is set from bdev_get_queue() in the function
__blkdev_issue_write_zeroes() and the respective NULL check.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 473888d667a1..e7a9ed8cc5df 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -244,10 +244,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 {
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!q)
-		return -ENXIO;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
-- 
2.29.0


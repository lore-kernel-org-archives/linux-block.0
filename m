Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E1C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 20:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjC2UsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2UsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 16:48:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2228.outbound.protection.outlook.com [52.100.155.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2444B8
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 13:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzLzElLyutkR/aO5cXm0PYaxAi0b5ae3HHINgbGRdNNqn20uXZ14JnXVWDi/jpZyWiENByaQszZZciWAu1N4nmdPWP4SrZVCW4iy4WQ9mU6LHDwp/KxwE2XaOj4o9eSyH+R5R4vrv2tEgmiYiMK530YFUSP/QP8UlPaJVdT8WMKfCSJ9ANzPWQ5vF+8njGfLYb4FvNyftyHB/E4SrCbNP0Oko4coehBwRlWzAoCMTnpLe0JLVzftblA8V3/9qufvMWg/tzFCatIkHYrRJeKbX/qxM7/vlFzsYa7+3VrxGoEC4yVOuI3qbcq4PoLUM1emQhnNNYhaMCiOJoKwfzZIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe/xv6g1oimWIxOkSZBCMqmkdMvjYyoJ01N1ZMeibGw=;
 b=Qfd5aVFXnDyx33V2l/0C4VNIngRK49fXiHiSsnBtmoA4JXRdmmFdnYAiEn2u9Uz3GRmacTtEYTAz5TDHRLEO13LbLuzgidI9VsAA67+8wyG6+a66AIHWS12FSwFy6r7arjtiP0tXXSbkTyxKNfyQj3sT7IAQ/xfW8GjyoBAFva7AONuZ5djriwahSk/585R1ACAtcpZi0/amEsPrZdvINHXb37yLWlushbNfCix1eJKC8QVmxOcCrQT7b/FXQSeutVJuBVlX/73mW/K/bsxE2sSF44OlRHN5V//PkI425jUWpdhgCJI+VFVOz2VFaHLE9WCn4OY6QVaOf1676jcitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/xv6g1oimWIxOkSZBCMqmkdMvjYyoJ01N1ZMeibGw=;
 b=LWj5EmQ2N1hTXWSWy+9LDQl49L3pCrI8xUDujoZwLJmwibbQUAcBg1pFySU6JLxW4OKc3xJSt+eGBwkYQ/P2JUKc/c09mNumxqLxBrCZS8YpfoV05ZxYWPAmKNmr0Nodo9aNlpSPMt7auvw3/jCFTzsT2P09URrynQgek5REK7l4WMilO3k/y/ZRZqv2gjqSjo4wdr3sCf0tWosV4Hi3QVE19xEhkqGtvyrwUCTBUlQ7Q1ZCTdvpnydTpAIx3nnx0kDAaOR5/ycBFdTsCkYtiIF+ETViD84cRWGDw59rkxv7sABR0L80lPXVi43agB5QEWAreZCcN7q+503LvwQMcg==
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:48:00 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::b2) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 29 Mar 2023 20:48:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 13:47:45 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 13:47:44 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/4] null_blk: use kmap_local_page() and kunmap_local()
Date:   Wed, 29 Mar 2023 13:46:52 -0700
Message-ID: <20230329204652.52785-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230329204652.52785-1-kch@nvidia.com>
References: <20230329204652.52785-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: bb857d1c-d33a-4a7c-24a1-08db3096e25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCMPG51RUAaQHyNJ5q5czgsbluugwlpq6oX+JET1HQubshXMCcXSdtbh5JYkC1pWkMXua3OCQfSFUfEUSTXRCEWq14T+DgjpVdWO9RVvZb+4udQmTr3/Hyi+B8SgbHRry+Adtq9tKhE08XNtHF6G4gctUZd3c8/RiEbUx2dfyY69Qw5kO7RR1TsiGu0YgrMH3YokbJjrQxc4BmBE5XhQ86DR2ERhEiJbwM8tRb0YqwlA8yxKAReAoRp3ODojMJHVWHulc/gzh7IFzFd6ra9uOqppGwZIdqq9wg5+qAeW6w3qsULqK/hcoca9hWMbypr70Bv+Su5Sui0VWrnbW2e9NRtG8HDvsBVq5vgEBOenTwmyHfNVvBVpseNCMopwXq0IgduQuDeuDZja9yHeM2UxtMB8lH8QRqICc22fncHmVPHdLa21RAOC2BlN4rMbl13615lmnbIK76vTy4WxRzPKxN49wjlUcih/813g2NcWljmw32Nil/ImZ4CE9vjdV3tRqHm332D4JjGb5uyy/RhrITWlmYKKuSkTTu21pwmgn6komQr1I3fYkeBcO71reggAkDXGQXVQsMgnDtVLn1m1A5OVqJeErYw8O24TvgWYnUx8E9P5WdvoTddehS1xSJC+qGneEMymP3tV2QMArxQSQ+3z3CYalLT/AMfnhiQB1M7ZQriBVm93KVkfu5wsvMCqSIiSM7+VfLULIv+1pCmGsBvZeAyUEX4E90TW2kt3Xe3h7bXU/XXAKc2dvjr3Agj7SXJiQE6XklFScdrLFMTfm0GrgYWd2CdNI8cpINlAY6I=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(5400799015)(36840700001)(46966006)(478600001)(83380400001)(2906002)(36860700001)(7696005)(426003)(336012)(1076003)(356005)(2616005)(8936002)(82310400005)(5660300002)(54906003)(7636003)(107886003)(6666004)(316002)(82740400003)(186003)(34020700004)(26005)(40480700001)(16526019)(6916009)(41300700001)(47076005)(8676002)(70206006)(4326008)(70586007)(36756003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:48:00.2608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb857d1c-d33a-4a7c-24a1-08db3096e25f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the deprecated API kmap_atomic() and kunmap_atomic() with
kmap_local_page() and kunmap_local() in null_flush_cache_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 41da75a7f75e..bc2c58724df3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1030,8 +1030,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	if (!t_page)
 		return -ENOMEM;
 
-	src = kmap_atomic(c_page->page);
-	dst = kmap_atomic(t_page->page);
+	src = kmap_local_page(c_page->page);
+	dst = kmap_local_page(t_page->page);
 
 	for (i = 0; i < PAGE_SECTORS;
 			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
@@ -1043,8 +1043,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 		}
 	}
 
-	kunmap_atomic(dst);
-	kunmap_atomic(src);
+	kunmap_local(dst);
+	kunmap_local(src);
 
 	ret = radix_tree_delete_item(&nullb->dev->cache, idx, c_page);
 	null_free_page(ret);
-- 
2.29.0


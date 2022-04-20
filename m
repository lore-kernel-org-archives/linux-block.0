Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiDTEOe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:14:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA583167E8
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du0Juvs2/8ZZh3vjdJILGfrpofvas/g7Cz4+ldC4bXuJ+Gb6mvsWltrXUiPWekns7evvmVxxI0l+rfvoRfMPxUuycqrv125SIV86lCZ3ilz3i8BqsNAcIM/NLZbrST8yhMvYehhFcFGm069PuXqXt8HPr6E28bZ/iGKwNbxcc5LEr5HDGKQ96fEExksM6sof6LJdA8TwW76zOqozD1A0Dq5jV0xjwIsJPs522Sh6towGwfpnvOajy2Cepx1pikfkyVsEvK8DONbxJn4cZODKyLbEwgTMR5bRHQI8cngNL6n2nYPEq4MTkGYlkw9EqjR6hN//pjQ8+UV0SpYLvgXEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NFXay19HcQli6BmmwJwW7oPLncJnPjFRcAVf/HxwHE=;
 b=kwOt+i7h9RRCDfBK+s4KA0UB2zoE9SrjWctK6L+ij9XJ3vtBT77fNNoS0z2J/TWBiRukJKJPXqOUGD2IXQog0HWljwVeK/EynHMAeK8SKzLV3gylQXt3hy56EO3iG7WmwsqERj5jt9FH7Rfg+r4lBXSgPiOIIfsc5FjC860xn3wRrBk6WMSH5sTt+mURdYe54Aj8sFqMWYDUbTPBpKwYJMImx+UyZbtObS1a2Aw25CcJ624mKr2ivh9oStdQm8Y8Zu0Pr92t1VE3oPdpEYhSDzeQ9jxIA0qNsOA7D1ZL2xFSKPoNIjgIXuW2KBR5vJyiUsxA6PuSJj8lDEgrUteCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFXay19HcQli6BmmwJwW7oPLncJnPjFRcAVf/HxwHE=;
 b=EQ647FAhTgGpfwgEWHa0eoieFl5NFOBgctUUvq3L5h8AkeSOUhAwbhxwDRRf1ZxIiNDbNE4KY0/b6qnUjoKi/yzW1gLqu+0PMxFQGA7NmikrBO0XweHv+618RMaDw3jgly6VG0HoAVuyoRw0WbPJ1qD2XlIgaet/wkY3Qb3gFJWPSQDIBvVMdjwcqR/SYnvAe+iYZep2N0lyfxo4kzvmD8f4FERSFZ31X+lSF26CBDSmYZ6N0Ra5O886E6eUjZgg21IQZnteKz0dVoDUcRZ96V6XLzOk6W3TU2I4q0xkfwBCNHt5HsBA9kWNVRkarWUWmojB5l5hZG8RA+EXjMWbCQ==
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by MN2PR12MB3181.namprd12.prod.outlook.com (2603:10b6:208:ae::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:11:47 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::51) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 04:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 04:11:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 04:11:46 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 21:11:45 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Date:   Tue, 19 Apr 2022 21:10:53 -0700
Message-ID: <20220420041053.7927-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220420041053.7927-1-kch@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be68a78a-a169-4ab3-78da-08da2283e2d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3181:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31818F9BDF00569A4D477147A3F59@MN2PR12MB3181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66E4u127PoDRbKPLnn9isfBHRgPq6nB8YQYllgdz4lCWjJUTqgARbzCHetUt5NJokPtSjAxI3rWhc+g8wK7jwemxdrl5KETz03euydDoqcl1an4F9rp0TP1OcvskuZV5WIsW9G8cFlD+u4rFmsE4brnCXH01ALAaNeGtuFRR37ClZsg+Pf1+tlTsJL06jogbFicM2fD4cB1c3TKHnxDgZ/1SEjiKSQgBpC6gwYzwy1TDLIAZ4feLnOgFeehC6wqALbspXU+D5w7ILQnqj7ExJYo9UZPBaZv0iZSmYT1YPxyoX4Y0nQg+do2Rlv4/nlUVCCzuMn7L8M93wwKSDlKuUuE0zJrcys8B4rquN3QcO0if/TbssxbJBBZsmo3t072RHb4kuTxxdsQfbxql28FhLt9ymC6homBNCDFHqO7+lmVJFhkDAzdi6+ySwDVTevDFsZx4h6zYomgDSgPR7DIGIEEeusrf1OdUPDs+yizj/3L8aCgmdxVSL9GcGqLBrBiMCfYO5G/X9Ku0XISRO0GgHVxZLftk70Lm2y5MeV53u0HFNpG9Ajt7EK6o6T9z2A7xpi5S0dzSvfF1nPPMZQJ/0XOpi/wcldJY9MLhfkdP2pUXsfrtE0EZW+m/RrC7w3XFR7DMhOcQ3vm9buJ0u6WKSSq7njmVhTP0mxGwA7dAJLtdOmK4BOUBabDtiRQk/DuoqpSMX6tTy/E1q92TadPPEw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(110136005)(81166007)(54906003)(356005)(8936002)(316002)(82310400005)(70586007)(70206006)(4326008)(8676002)(36860700001)(16526019)(186003)(40460700003)(1076003)(5660300002)(107886003)(26005)(426003)(336012)(2616005)(83380400001)(47076005)(6666004)(7696005)(508600001)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:11:46.6903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be68a78a-a169-4ab3-78da-08da2283e2d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3181
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace deprecated ida_simple_get() and ida_simple_remove() with
ida_alloc_max() and ida_free().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 74c3a48cd1e5..e05748337dd1 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -411,7 +411,7 @@ static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
-	ida_simple_remove(&vd_index_ida, vblk->index);
+	ida_free(&vd_index_ida, vblk->index);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -720,8 +720,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
-			     GFP_KERNEL);
+	err = ida_alloc_max(&vd_index_ida, minor_to_index(1 << MINORBITS),
+			    GFP_KERNEL);
 	if (err < 0)
 		goto out;
 	index = err;
@@ -911,7 +911,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-	ida_simple_remove(&vd_index_ida, index);
+	ida_free(&vd_index_ida, index);
 out:
 	return err;
 }
-- 
2.29.0


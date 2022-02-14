Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B5C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiBNKhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350015AbiBNKgt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BD3700A
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:03:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc9Iqq4MHkrdt8s5+S6XgxtxuH2n8jaKmfw7jv0Qhbdac9LtwxCFJ4p68h7VdGnV8ja2/dCzH04FNa9/J5vcetP3QeP6jfjtbjbLZVdvP06Ly56fLmIuz0wXU9URQSwroV9TUNWaECPXlLpX578yXDM/rLCS0m2pfk+J8ICIraSD+ZjhSc9usoYZt12MMrcx32r6fsrcgjnzYphjxBU8AKtOdk68IWHRND+unoBAAuw55AOYGV1e5fdCZwR761p0ZD2c9BbA3v/tgHcnX94pGhsFXl0sS8D4XBixijwAgX8LG5ceKBuRHj3SUyC/GeCubmhm/IKfwd7tClY28B27JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=JkJph3GINc3IB7/xyq+7iR4A5RjqkcnwxyDHuQNY208P33h+Za5xoynHCQcChHloRe54FB027lW5Pf48OjbLI8dHh2t5Kf8HSlx1kAMpyOwhEv7BXck3Kzv4sQZucniGGWK+RSkBhnGRZHC01+kUs7M8u4AT32NvjGtT9zf+C9o7evkohEJpUCk/MUNbwxPtQXA4zNpABF6JW8d4kzQNs5Fz6wxqsYM+0rmTBt2wHL35xyVFLIInO1v7V7Hje86CWMHcEl1MsQf6nYoxKurpaMrUOzJBY8VLWIu/TfNhelPbWONtAm53GycSm7mx6LELQX8EahuO3j/rN040w9u/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=Qo9oMgTHT5TbEHtfko/1WoIOC2Jvfv2+tk1n0KChUcuSRNPXUiFuW6NCsZHjVRfwEN4gm1L3lcIsiWs9zBeFMhum/MLlo69vZiAfEC6n/432Dc1WZNCdRaK3p03OyUYZEZcs3rcLODQD5oT0Dy9BHaVdoDWaI0j6SV83C/hWxQdUiAw2W1iVjubteWKynzPIvCiip3pr9IZ8ehYm9psmgKln7ToiqvVPl32bnYb9gnx/yuTWwHGMn5S6Yez7QnnpQsOzoH7sXs4jMXHbcT7j9YZLylV6kGPZIk3fD18AQLne05pTfqxwkrLAJCW01JxaSP1IOGSTB3XhU5fjaewHew==
Received: from MWHPR14CA0030.namprd14.prod.outlook.com (2603:10b6:300:12b::16)
 by BYAPR12MB3272.namprd12.prod.outlook.com (2603:10b6:a03:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:02:52 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::c5) by MWHPR14CA0030.outlook.office365.com
 (2603:10b6:300:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Mon, 14 Feb 2022 10:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:02:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:02:50 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:02:50 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 7/8] loop: remove extra variable in lo_req_flush
Date:   Mon, 14 Feb 2022 02:01:18 -0800
Message-ID: <20220214100119.6795-8-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1ec8714-7979-4bbd-5de5-08d9efa129c2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3272:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32721EA5F9BCC25B5C5C59C0A3339@BYAPR12MB3272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QiKzfdYSoj0aCm6BkHl0VbfE+1AUAR6L46s6MpGnI/jQ1fwfHrkTD14Li8Ov7D1wY/qy+ChD/KCArKZBIWxLwu0g7RreLlmiQ56zhLx+0GuIV8HMhCXVXyytnlPj1Y9hwlogUkbWyLlUsJ4WU4b9myadR01I5hS77k8wWUh19GRrYeR3bbwGOvgzhj2uPOV2slrT5iob1vlbTMOlcYgpDI7CiV2GltyHmrTV9auR0/uYukb3b5QW1kLhy/p4nYcPzjx0RP2HupZnD9VSmfzcaYDccYJrR5ShvCcfU5uOZDU3y6NIfgavvJ/aJhTm3JfuVn/c+ntyqAGqcv2Y+3GhdcytmdMH2l4zS+dGzf26MNQaTw0OM04SHcfkmCl9HSuT309O0GkQ6c8Px1Ym+jjTzBjL5Vsz9nRCjgLbQTR5OMypse3EtG9RaC64yrecOSwUknLfssgg+EZG6wq8e4hkF9/S5o+aOF/q1IumZ52HKPcwmkQ/AmqwhaNoHIZZKMRX9OO/CWxgKDSZtE9mjQm00wOoC+GKJdRHMcf/TfuYwbJHpUElliCLDgOnwcGv5BphIJORXuqYOtAMVPxHaq8HnYyOGG1pKP8PhWYHhgoTfrNNGgbQKwVyXDJzZNveCrPUpztQFXECGQ2kVIByXl4wcOMsrqK6/AoAMSWYHSvBTia4/lLiou4N9FbmYeqNmhaHosB2Em78m9ezJKZzJ4nAw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(4744005)(36860700001)(83380400001)(26005)(186003)(16526019)(336012)(426003)(47076005)(82310400004)(1076003)(2616005)(8676002)(4326008)(70206006)(316002)(81166007)(70586007)(54906003)(6916009)(40460700003)(508600001)(8936002)(36756003)(6666004)(5660300002)(7696005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:02:51.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ec8714-7979-4bbd-5de5-08d9efa129c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3272
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 77c61eaaa6e4..18b30a56bfc4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -326,8 +326,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	struct file *file = lo->lo_backing_file;
-	int ret = vfs_fsync(file, 0);
+	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
 
-- 
2.29.0


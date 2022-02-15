Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A7EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiBOLwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiBOLwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:52:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFB985B6
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWLdtkimiNfpHDUSTha2SXLdm8XGiQtCkWsOGcoqipJtDuQ69WXAS9WV8jE/OiTI1MPWCgA5xpKJLBpHZ8nMiu4vyGqqnCW7CdbPJMwuN4HAklvsMolrugj0PqT5NtBpGS3fCu487Mob1rH+bHqhwtEtn2FvwA9U9H/xxnnthCW6nVd6ni69d3e2bMSlmgQmXFbcMFdmOaiBTk1odn8CpG7HFNldFCzf/bX0j+qcaqVYnt8HwF00x9aIAvTf6gYwqpSFDYf8oLpBM/8jjKhb5n0qlB1pvuTbHwHTjtxHvtDnyOHVZW62GCSB9UgyH1kM6qeXWV1F4mP193ASC/GTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=gT3u+JMf1/6OnwOFQZ+AxMtPilRhC1lKLs5A797DNUfc93uSXaiz6JN9VMqIkaGiB+dpZNj7VyfL7G3Z7CjwBmhnhLN9TkNywciZII5jgYwLxfy/LshvVKfQD4vwDEbLa99XyODn4LwhqY0oNYViIS3r4s7TIurT+q99dsR7djoQo4Y6vmvG34je3MIFWn5iN7vChjcjOXm5SkilR7BcIwDoTX4++iQB2cAj7vM5PlQ6O20Qv0v3tSqXivAUn4kdWiukzkKGg5UZ/uR5nCHL29KDEAfeHPwntVxgjE7L5D1X0I86tCI9VIWTIgc19ySm0DRWyw3e2sZmWFz3f/PDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=YIve1Sz0PXefZxfvRVXH44FnOB37k8Bi7tbKhJUkKsTHhduCm0THHPHlDvXTvQQcrUMqXkSGnsZ4DAWkSDkLsqDwSM/QGX5/L0bXmYYLK+I3P+j/1WnimF3LDWga6cNn4fpnofKca9SBAGYIUx5g05wyjPWouVFJYDDNX0+CYQUrYGiIHc1HeTCcDnyz15VvgrsZ6j6NqvaOewofODfjhTncluYugMchlbN9RnP4KTIs8+SBXHKc0WWdH0bEv4CE+TDFEHcpOUDsZyOxyrOXQeBYgG/f2iF7nA3a6+8oyXsOpr3ehWStIArMZuX+hykv61cnyVsbaCp+p+xdGFjIEg==
Received: from DM6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:100::38)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 11:52:09 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::38) by DM6PR03CA0061.outlook.office365.com
 (2603:10b6:5:100::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Tue, 15 Feb 2022 11:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:52:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:51:48 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:51:47 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 3/4] loop: remove extra variable in lo_req_flush
Date:   Tue, 15 Feb 2022 03:51:03 -0800
Message-ID: <20220215115104.11429-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215115104.11429-1-kch@nvidia.com>
References: <20220215115104.11429-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57945a5a-44d0-4bb8-7c4d-08d9f07998b1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2869E9FE82CF1E2CBECCBEDDA3349@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zAhTCoEIelmfuv8FPQWE8aNzfiE0WLREPkvhdynqENGCMU1TNeJYiRaA2QkobOSZrFpMFa18WaYpHi87/zrHDLTJQn9hwauJDK+3lleNABsp1Tbk2epz5NUFQvJYmKkPhWnniZnTIrzRli5gweT1QxreRgWM6bHX8EA3BsvoYElgsOwV/sWb0IhDOMugUrXoQR3L9cPapvUXAAMC+PH0RufNkt5Q2c/gc64SAIruXl2O6jlDWtRjjjuhE9nQUU9xNLnaLFhr/GplbVrPRvj/Pj3YpsaSHzCwOrjRrf1MMYMa8ywmVIndveil/YUyHVib4m2cg2B/8oK6ihmfqdWFLTiqoljQOxpTE38tre5IrQxd6aQTlOVFQRezpTls2DJv+nVkvRS10+Ij0zpYNGM5rS1AAqHV9h7/2FLUHAav7wmmmQ0K45rcoU8zIUxSWX54Xw/LJFmPcLJ0cnYAX2TqForef2zFYADWeKEC6F1LA+mOiWKzF5aPv92LyIKIipn90GTiFdHEN5e2Mz6OgvQ8+TOy8tQb2eoU1LS2KDYp1nIMvOLPk5ZSoBPH5QvyDJ8qYB6qB/YYVd0nflFQQHB26vJ/jJU49b2V1gW7HDHuB/O8wUePN5APndqjaBl6GGF0zBY91dt+tAX+NkOfSzf4Re7p1PYKtPGK0F5mSZ8hmtA3/Je1csfU3saRFB5SQOpoRgX16zPQ4wWwUKYp96CRA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(508600001)(6666004)(7696005)(1076003)(2616005)(426003)(186003)(26005)(336012)(356005)(70206006)(70586007)(81166007)(5660300002)(82310400004)(54906003)(4744005)(6916009)(40460700003)(36860700001)(36756003)(316002)(47076005)(2906002)(4326008)(8676002)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:52:09.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57945a5a-44d0-4bb8-7c4d-08d9f07998b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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


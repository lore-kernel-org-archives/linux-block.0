Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD5C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbiBNKfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:35:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiBNKes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:34:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77E9116E
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:01:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwW+s7E/zDASnv/soDeWRzvFvzTu4JSAHfSF+WrFU1IeWXxTbRQZ4NzGUqWXJc10KeAhW+izouofMmhSs2ZUfZk1f14uBrm2K+V0hF91X9Gb1hBS4a0vRjHb+EXW8M1ael/ZY+GiQv9C2QT1/+sQxwZNawFEG7QFVPyJl9yHDByXdk1u5OCaJuOVF9XH9q14sgHH41/eqyvnWIrsJ/BKfIwID7oEbGsYks1jA7GvXugwZ936Y2bYvLpZGMHh2lF96aeBDWeXIczru/XELG5wZMXO2eTDPy0KA+XGMTu6ES1MxyxC1HaUQao4hJb4gHwXW/s8zs2W5T7I+Zj7EN0pNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSDYIEgyQJfK79hZlpKeG4Ezx3j3xkc9Upq9C+n+SQE=;
 b=WsI7YsqG5tEJW6iI1L3MtRFvxUXBc9kCuIwPcX72TB5ZSzI/s9I8df9hNg/rsGZPDjKJEE8v02cHUC4CZczhCXy7ZqetFzjW73bL0tZpApLlILsFKVjQd6WWy01T00/1s0nM8BV48iSn/GQApyuKEkrnbkwdJVsHfBQ62bmEsOyokvxoIPO0w213oOdVMOX3nXhXIH4o2MvUn5evKwiMr4wJLXjpx9IwuYYrxrQ71jfmNkyo0b4BZH2O/PH51LBogaDLn2Uhtqbb1OutflEC+mdL2aEk2KHZxTon1EH3m389rd68uyA2ngTX5vY3QgOC2Arf+U5LKP66Ng2HmiyfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDYIEgyQJfK79hZlpKeG4Ezx3j3xkc9Upq9C+n+SQE=;
 b=QJgf8NmBSR5MZBismXo44gFIAJnbE/8edROXB/+M1h/h9YBi0HO5MkHrv+Ipr7jIzmTZVvTiCbBn0C91fhcODKFrwNlWD3Sweu5qnuWujynKqwMYYFt1fukgI76+KzZe9dHN3sFLTYt5flbOHTe2Bqe1gFI8eJdB+hNS261IGkbi4A7N0gM4+fgTllWXXaBJFfW/Odiy7fXD7FeJTwxi+uurWkEDwo+XWhMpoglff/wEiqadbmpeQHp/vx1NqqTqyZ5aZujsmvVn020Z725nQHN1KQuuUerVchYZKFew0KvgNq4sufzFh8WVWw0nQKWmh+tYUXJjyriLoYa06d0uLQ==
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.19; Mon, 14 Feb 2022 10:01:46 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::d1) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:01:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:01:43 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:01:42 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 1/8] loop: use sysfs_emit() in the sysfs offset show
Date:   Mon, 14 Feb 2022 02:01:12 -0800
Message-ID: <20220214100119.6795-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f21de33f-ab39-4002-bc0d-08d9efa10254
X-MS-TrafficTypeDiagnostic: PH7PR12MB5950:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5950121628312076389FEE23A3339@PH7PR12MB5950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMBgAALKpNA0A4gpUZUkU73Q40nRrDgw462jcB4z3Q21Fp9Nq4mMWoJ+cXA3Rp9MKHvMz3kZUxSWMueCCjLNkDFWXjaw4zdwCmFtwP9kz48ZoE/L3e0T7NNLablufPXDaWpMROov363vRBrsSDqQnOGSGt5BqKobyp/heSMfQiZrs3Zy+8tVndZzVSnnhgR8Cwd/NdDhkHWZcUzgGioJ+76BpvtoV//YtjiFCmyQaC4OaBnn5cLPuYlaOm/cbHFHXodivTyDyoIba7e+Nq+cINn3Qb6o+3oEQlFHGuHjOsf8vt3AEGh+Pz2SS6fVoAHC50pyXauDF5HDS3GzOEakcK/5Cj2BDWJFtDDVXPHJj9+n7tKX2z/LAjQgKFw9RcadMqO8GZe2zgRb41ArmDzEfjeZpNALaCTJht03mdrfhgHfigeVxrm5WzmtsUjHrcLgom2nRBMYRGuJxBXOQwInxNkbKLjGwVKyzI8OIkhR3E+EjeCwhm9+Zn1TE4UA2cccGcerhKzm8eBvh6kqitTJg8bFTxvh/Q5Z0CLtMiL45MMdpdGdjaB4xcuDlBNXhOxBFWb1vFuVFZ1J45DbiV1oNh6utzbla7s4mqb0tWB9T6BfEO3qqSJLElaRHOw4s8SJ5mQ+tyoZyXNnuCksIf9r/ak4K30x4VAsfNRUUC19mdWO+wZ6sbfTWJaOXuKXxlccufPEI8phUDFpZChuefAYEw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(2906002)(186003)(47076005)(316002)(8676002)(6666004)(26005)(426003)(81166007)(336012)(83380400001)(6916009)(508600001)(5660300002)(70206006)(36756003)(70586007)(2616005)(82310400004)(40460700003)(36860700001)(16526019)(1076003)(7696005)(4326008)(8936002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:01:45.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21de33f-ab39-4002-bc0d-08d9efa10254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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
index bdea448d2419..f6ed265d34e7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -680,7 +680,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
-- 
2.29.0


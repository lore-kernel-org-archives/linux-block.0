Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A075C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3344F61050
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhIUJYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:24:05 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:38948
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhIUJYE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKe/r9tghrZg165hF+6n7LnvCVIkyV1mAKhBEOgkI2UNx6lDeMlQDteUjgrcz7LBaTWgd+OiG6OJ1dwg+MuTb9G1ir2qH6FxaOIuK9XS87wplmu4Ff9S/7Fa6p/2Otl2WhvAVpqNnm8HfE+JdkiuGwC4UOypP5LHrmp2QKhVDNhCYfaLaiX4qeV9EqOzEFA+WWzc1ZyFMwXEVE/4PUc1ERI1NSVteqfXV36vj14817fltaqf4HgGH+O43xbk+x1UV7mWQWukSi87d5sbd90y4El/IYWcc/HwIIbZOtlPJ+7fdiOhckzMtzKVyYzlJ4MuVvdHG1DAQkKgy2Bb1K8HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BQY+HIBs/59R7t04DIoa7bAAaNzADbzDGFqDs1wkm64=;
 b=TE/7aeDkri8HZM21djZqVoujHgvIclxuNZtQaqhlLTHwlZnY06jWsY5AA3s6ykxpKx97F95R8Z6u50GBPX79fOqzjCwS5JFi0zwlht3GkBrf6bwqpr6k8k2+VRPTGgFVrwcu/qfa7NctB+b3ljlPieAQVnkNBWKi/zJbZqmBmnIcVhhE+o7KktU8ONB+tK6h23dddQBGLhRpCTNaZaxYAusSF7qcJSIbT+bEhPC52Y4lyR88WpoGb+b3WL8yN3z1Yz3rmxohuIiEFekHwzdqnBhHzB7VXQHD2lifU8Db/pk76Sbgd3k45xCncGiCQeZ06Wx4inPgiXhPf/GPdAeBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQY+HIBs/59R7t04DIoa7bAAaNzADbzDGFqDs1wkm64=;
 b=XrjSPni7Gti66klpXlXaENymf6oo0iJOTbkPBkOHDQ3Vud9h7R0dv42zPo1xSQ7v8FQqFEowW+CRmaethr8Xn58WGo8hJq1OGmQK7uwLumQQD7jebwCDOsNJmrEfS7GpsvxgtOXCu0iCvNBCctUU/CmHFXobiYW1coX0QG/sjC5Y43nKh0UCNKaFeCYcg6iuY5Ayo1HHOhqqvhHXNCFfj/A4NUSASpiG16dm4aQ9IW5uT0x5on3cIBQDMyJbbmTpzPftGuRiwbJTmhzZHqXSMtjLj1hxOEuEF9w9f5ZM/56i5iUV+r5RoAo7PsHoj2UAL8A6NJbINQlNH+qCXhn/Mg==
Received: from BN6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:404:13f::34)
 by DM5PR1201MB2520.namprd12.prod.outlook.com (2603:10b6:3:e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:22:35 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::fa) by BN6PR14CA0048.outlook.office365.com
 (2603:10b6:404:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 02:22:34 -0700
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 6/8] loop: remove extra variable in lo_fallocate()
Date:   Tue, 21 Sep 2021 02:21:21 -0700
Message-ID: <20210921092123.13632-7-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210921092123.13632-1-chaitanyak@nvidia.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa8c4ce-1bb8-4bb7-3ea5-08d97ce1591c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2520:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2520D66B8B4C0551840A9E28A3A19@DM5PR1201MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbqLObnyte5Hs1NVRBHhuftTGUEVf7aqS6Ngyn2v9PAO1PE9+5nq7MivuhQQ5s1O9QUHov2wur7mrYXnhFAA5oh10Ar9+MBLvAJvS+M/bU9fpr4aPZP8AZgLg5wNKVmkBfo+BSR+++a5ubcI4DhiM5nk0CwE1OqhqRCkADE2o8CINVJ54tNSR+r0Swr77/4zM5Nc4ZL33ZZCroKe0aoj6RSkHOZqsGp+2Xbv45v9Rn5nTRLnM7k0rNpLfnhmONnv/zk9Sqf2tYCa5DRr8a+5MHQLxmB4iffV4aDBqgj5Bh+QMikdO8050JQLAeeqkwRzSqNUfuS72yRs8RiK9DFQoQDdpJcSD4VuRm525yhXFeTzJOu2pONDN7eVNg6ObdJtdiNtFWgwq9RAWCB84mYspF0vCaXrbfconTpkUELfHq8v4GJHi6yHhpx08hK58XZekBTy4lsLL5RsRQ68PLOS2GdVyHbakwbC5v41GAXu8M5JkLZ9jjTkr1y6EPNva3WVNnIoTAihHZJDmgPS1+gB4OqPMn528xBrX8r+K7jrPr135DB4NMZxWRl8wFUK4kg1YHRFiaYhxIYnzx/scWXfPhqqBCZ/83g0OBBA47WazSibJectCq0R9IEGL2UcciQjYC0MoAQx5yz1lCHLoe2M2i1pVI9btOnPtrpi+OXpnN89K9reoqr19r2C5VszitjHMvIO6q6Dp3I8Vbk6W9lQLg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(36860700001)(2906002)(4744005)(86362001)(508600001)(16526019)(7636003)(356005)(47076005)(36756003)(6916009)(5660300002)(186003)(82310400003)(70206006)(2616005)(8936002)(7696005)(4326008)(107886003)(6666004)(1076003)(83380400001)(316002)(70586007)(336012)(426003)(54906003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:35.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8c4ce-1bb8-4bb7-3ea5-08d97ce1591c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2520
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fedb8d63b4c6..51c42788731a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -480,12 +480,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.29.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F4BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiBOLvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiBOLvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:51:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323EDEED
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:51:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G39ZOQi8ZAmMI/o+0KdCBMcWGXGi0k12pEV6r+pCvjZVaKuxwFnN5aNx7JRF73qaKkCvME+aC265IQjEOEAuXc+VUF7GLCLoGAvaa3nmicdUZgLXqQSLbxFk+saq+V4R+2NIqMZ0Ff6sRxGdjAabMPJTIsd9d+yj36aEfC8yjQ2ZxKpr6XCRIaHTloyUl0AFy8CMA0Sh2MpFG5HxIa958Od9SABuribuCBRGqx7v1qShF2d7W1+1vdKgH6Z+12F//bZCM6w7m9nGabLV/qbR/oH28mr9aCZAz7Vbl7u2nfS+/1k6+MbCIsk+0oGR40WXzgN74rECxMDORwIuTkJOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcz2fh/9i6/EbRPkqP+gdhL0pMYnnOhoKwwO+bvKdUU=;
 b=GnhQiQIK8s+fU91hhjiTkFzEURVfBQ57aBCEc4d7X/lox6rnlRSkqOhO8RuOSS3yf+xE+mjFNyliWsIcX327djWPAOOC0vRCmfSIPSerdq0FCKOom6S9riK1uCWpI+a06sT1OQn94I+GPwL9/S+q8tzeXA0JN9cZmnrBRqIGkcBsoArJ9WIRj2LfAGrkY6XZjwlWq4KX8qIOsS/saFSgzUq6faXy3T4wO1Q/aMzwO8E4fAwHCl6maZTtLwU4yIyc2RmKTiKOPmg5Uy6DBplFoTpwZMltnH8os6sPBM5+oh2HMTHLxiMMCL9EMILxURWMq3QLZp8fI6JB2OK7bMFIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcz2fh/9i6/EbRPkqP+gdhL0pMYnnOhoKwwO+bvKdUU=;
 b=t3l7IY4eCMgMriRhaFST2K8dhILPDYGfda/SERyzvP1Rg0o/IJIJjH2KCD0B+uBlmbYYdwDrKIl/DoGCz03b0GMtPDIPPliUpbptSulpmDySda5qOM7Fu6b1YMv58BsmpAz9ll9IYThG0HLtGCdVhktVWedsm1nF3idfFLW8tbdg5cON0BFqF/BifnLVFQp/bLzFl00BQ165f2l1PBM7fMty+zea0QWBV3PHq0Wrf2GP9IBM4MnLM+XVRCsoDg7cdQU7FsR6dhTWx7Tjhs2fl3eNjG+vQaAqU1Pc3ip2QBlsFWhVYN8E2cVZPd0OsOOQZXygVXZhob+el+eM1kn4cg==
Received: from DM5PR18CA0074.namprd18.prod.outlook.com (2603:10b6:3:3::12) by
 BN6PR12MB1123.namprd12.prod.outlook.com (2603:10b6:404:1b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Tue, 15 Feb 2022 11:51:26 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::7) by DM5PR18CA0074.outlook.office365.com
 (2603:10b6:3:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Tue, 15 Feb 2022 11:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:51:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:51:25 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:51:24 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 1/4] loop: use sysfs_emit() in the sysfs xxx show()
Date:   Tue, 15 Feb 2022 03:51:01 -0800
Message-ID: <20220215115104.11429-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc0386d1-9a99-4b65-170b-08d9f0797f08
X-MS-TrafficTypeDiagnostic: BN6PR12MB1123:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1123B9378AA57B61282D1B72A3349@BN6PR12MB1123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvC8g3MlVIGesk+Dgju8tnL9gfCxA2Gifp4XO8OsRcBKM7VMZnDiykdO9Mi6nSvfh4PlP2mzRLcOSw5mIMr5kO6fkTMphe/vKDh3pG7zVk4Cf1aaUZwOMeDrUih1rYmUkk62kQ5Rydy6QuF1C4jgfMNY/gkixDF/CwDIOiJno4OJMVWYIAbTJ3C/1cpfTfaWc79yiy2WWvV+F/hmfoyGcEtyCzM9ZbQ/JBgbzViyKwMkZn5EGql6FTOVdQfEdvHL1NP8u32VlAh0sh1z0NHZbCEsbTnmDIOL7NqfCnj6Q4QAtyyyFrETZm2QFtA5ElMJgJttvzYyrjVq8JQDeOhJdUJO2Zm+tIR7AYCeQ8m/ARonf8VFApMu04hN93OWAhczq2ZI1E27OhnLLJP2LBCk9EZTgI3QF46nBdgQK3MqIxNKvB+EafRokYUzUKyF+LU+fo9WZWAxoaQve+QpBhiM401OPYs8QtobQLesUyO2rCwUJ4XM17ATDA+vRQno2npJlxECUr6SqH9SR7JOD/5uOtHutguEuxROvrxghPuE4diXF6PzbEUCaiIlARiRh027/s3bfD6/zkZ09r7T61CjWvkzF+rv+1Xfg7CvF8YpBqxxTmTIa1hxqQHkVXZjspJafBq6tlGBTdexpJkb9I+Nam5B97q3F33vo9Yfc/RqHSFtVSs2hvxbnkck67IpTCwT0VInp2yFtfL9CFgmlVya3enGtt3RLLFp6XupFHJMuK4=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(186003)(6666004)(1076003)(336012)(36756003)(40460700003)(16526019)(54906003)(36860700001)(508600001)(6916009)(7696005)(426003)(2616005)(82310400004)(83380400001)(356005)(5660300002)(316002)(81166007)(2906002)(8676002)(70206006)(47076005)(4326008)(8936002)(70586007)(13513002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:51:26.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0386d1-9a99-4b65-170b-08d9f0797f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1123
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows the size of the
temporary buffer and ensures that no overrun is done for offset
attribute in
loop_attr_[offset|sizelimit|autoclear|partscan|dio]_show() callbacks.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bdea448d2419..a55e5eda1d17 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -680,33 +680,33 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.29.0


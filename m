Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348391AbiBNKhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbiBNKgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BEAAE67
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtiAx92ZmqmnYx8wzWv1adnoXuUSWuFK1qqDqCZ2j8kfL+EAwoLbFxmTa99vNnvvQ82+WhskpmRJqBE+q61aXSpLxv/UcPA2dmXd3b6LXgE/UcQBY2nj2zhcpquFCQswTk8rEZs3uUDoR9ySmYCv/Ppp+WZliOoBqBtY4KDBb4cDdoqPgy3xZUYSLpStZ8tylGHiXug5Asy14me+TC1lLgdWa3Gbz3FzcMQExuG4SqqguiO+ALVgoCS/jnJl6mj8JprviyQTEIVD3Y5dats27Ik1ZpO2U9+alFaR5Ox26LrwAgwv96A0lQ1QawQyIqAlzZZcOtdQk/KPOb+l8d2+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=YwtbC+ZVqBXLE0guDZ2zowfuPzY1UVuwuI46vXLEl+3BHEmnt85MH7LmSoXcrwaWVM1Xxygsxh5rBNJ76PlfNYiyqtoZNflv4+opB2J2T6Jik4bPBmmtUcRzzvNkZkATKkV49edGRR7kc8jGNChd7V9pYNRU3lA67vO7qpM84skv9atDiwIdYHfk2AO9Rh9Re8wt/DIKpdbmg8+AwAJcQrXXEt6wxC9xFSLHzlrrbstnMdXb6Mv5D9u6GAzpEg0lvScYwgP5f05fSZGJx+68rWMeEklTshqzxozpNqEf3J99PddhuPa7KaULHqVRbzR5mRygMYTIGdxttLMbfO4VQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=o1Yr98j1ZkZjHMSDso/YMaC4l8q1pcA52Hab7tIV5DuRRLOexD1aTNCFHwlaMWxOkrCx6WN3fX7j78YMuBfOolCV7ayKKLRAKTDOCKb96OXlCX8uDQKr13B0HCFzsN9JLo7AVHe/tOjPp4Q9V4pfMxrREg0oVw9MSXOH5SN9U6/LCTuMqiWAOSmkhx9ONepP6k8FqrhR6xLH17wWcv+mDauW4jcbcGJhXeQc/+/eVXuFbAQAIblSJVrJZaJUrwzJmAxo/5nKGxwxI6AxseRJZqvIt1iwypwH/PIk9MqmRAh1hvMFWfYQW7qKmVleVHOTBfa0xBBR94dzxeq2Uw+IJw==
Received: from DM5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:3:151::34)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 14 Feb
 2022 10:02:41 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::4b) by DM5PR19CA0024.outlook.office365.com
 (2603:10b6:3:151::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Mon, 14 Feb 2022 10:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:02:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:02:39 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:02:39 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 6/8] loop: remove extra variable in lo_fallocate()
Date:   Mon, 14 Feb 2022 02:01:17 -0800
Message-ID: <20220214100119.6795-7-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12043c90-258d-40dd-92b7-08d9efa12319
X-MS-TrafficTypeDiagnostic: PH7PR12MB5807:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB580773C03682DCD16A3E5898A3339@PH7PR12MB5807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92RMICFzsW/Xj133BYqycR3id7VvhEOFj+y8SFTfx+Z8bgVTl6ov8EzFffOF7QeXcsWejhPkk9sxz2OxZR5aOg2sGBhYssu3zcH8fYKhY8XM2HLCWiNtBn/Yq7a+vtNQ89f8hf93hl5EQ7HzSXh44qVl+VYT/zWWZZkqaT6BPyxLSHcd9VEKW9vJbdpAQ2QsMbO0sLVwF9c8HSHPEDzDGmnTvJ8LVK03ucRmPZta0a4r/QmsUbzYVQQON33a7eKdkxlNce8GvyxKgLZH/XmvdHLRTmztPuKPH0IgTGq4IFoXg80L2yMR2pb2hjyUOXyC5Ax55k2saFF+5+3iygW+Ie/bt89zT6ypzNhOj77Fxm0hERwXUxNC5RJOunyh3rN7Ng9kQiBotK7a4tAX6pDUhcxQkpqzj7j7ufcdRcjO9zxwoSIBlLOw49A9yNIXpDfRCBogJmm19KUch10p8TvzcJnKBnBQvpDSqKtETyEIcdkB3uc2jOQhbLj1jhWk/sx1U3NR3ASwwDFqlKGwwjd2xdFOr+hpUEptkITFupNco9Ru8CDeA4KgtTAw6BmgfnSlUX6aZ6gmtdxyn4vwm8FPqkhfeKvJ/RXh5PshdyD7ml/OPALNwFlqDgCkHVn4Escqy1uTf/P//VswwlI4SoLLR8g5DT+NCdqeJFXigmqqvCxZp0Uz+ru1q6Upkyv1GD6kSNkiE+kzLcOgYX1h6Tvn0w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(1076003)(81166007)(47076005)(26005)(356005)(2906002)(36756003)(40460700003)(54906003)(508600001)(426003)(8936002)(83380400001)(8676002)(36860700001)(6916009)(4744005)(5660300002)(82310400004)(7696005)(70586007)(6666004)(316002)(336012)(4326008)(70206006)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:02:40.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12043c90-258d-40dd-92b7-08d9efa12319
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a55e5eda1d17..77c61eaaa6e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -308,12 +308,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * a.k.a. discard/zerorange.
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


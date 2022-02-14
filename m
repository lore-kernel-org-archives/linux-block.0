Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C7C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348410AbiBNKhO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350223AbiBNKhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:37:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9CA66EC
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:03:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjqlT7MWXq23/W2BR/kZM4EI8k7sxARFe+s6lNvssZ2C4yJKMEe2YbhpcKVdWYyaySVqlPdt+8H6H1WV7rzEXtkmBeUgb0k6/7aXtw/kwkIg+e4OAesNqyCcHMOt7NsGnpIbaKxXWaLHvAznAg5bdgokGOxK0qbLZhPluRjdkdAeyZTylmD7C33XVYZBbdNSzjvC4I4V0E+5kyVdypuTqbatq3RikzcUMAfxJ+pBmmM7M4ybQA5/E06R6hFwZ8nlmxLXP4jlbNgmdtHZMvIpHZF+XetpcBAhH+pfhiKFxrEVaLlfoAxx8CmWcdrSJtaJrEr5RExX4TTA7dLU1r/CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZirCYQgO91Xa3Ta75VHvK+haR/Ieo9cvEFnC1t/Ya0k=;
 b=XUSpVo0GRLlgjxm/k1FyWl1mgAZM8Tz1JdElIn2jE8giYOFhRtOZUcNf1QdljlEGIooMiMMNc8lpk+wmEAE9vjK6NhXLc1QrAujCONbBzKFlbRodgWoJ/BsRG+QX7drenY8GFf+cyLzMSeFTEGHt4YX6pTZoE05R3uoK8jRISlr1C4H6qejruvBWEircYnLL392++/YR1OkzAiwX5Um94Ej4hPkX/ILYdxcBCAPZ6/9bihA61cNxf9VxT5pEosLiyL7Jc1QxydzI3sLGJfoNRO5uYNbc6dHZP+Z4vL2sOlxDpcwRB4V3yiD5m0SH7d641nruidQb0H4zZvw1t23Blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZirCYQgO91Xa3Ta75VHvK+haR/Ieo9cvEFnC1t/Ya0k=;
 b=DpeiTkdC0AS6gc3HGTJa1gm3B+OKxOwqgEjalUUEndBfM6mq5roCYHgrQ34TCbm69x6z1BBw7TvLrO2vGoJajjPjs6JZdD+mdQZNM6wJ/4FhL+q3LC2dvy4PyGqaFfrUKzHp6iTUnbmK/iqJ4G5y35Itx2KuVaXgPWfprIEsQqRVdTg5yYQlqbFo/HJ9DWDsCtOUqgUN/y/o19dcvhRwJd9XPlYZqTa11bAxa0NaZnQtWgTHxQcTgRtOn9P5UVSaMEnFyaa0rz1nqOl46AUBB7KXjVMCqzY4WRBRI8lfX609bi0YJxCW9pmo5P6iYJquWsHQleQ6JxrjW1Gxdt/AEA==
Received: from DM6PR07CA0122.namprd07.prod.outlook.com (2603:10b6:5:330::18)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 10:03:02 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::74) by DM6PR07CA0122.outlook.office365.com
 (2603:10b6:5:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:03:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:03:02 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:03:01 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 8/8] loop: allow user to set the queue depth
Date:   Mon, 14 Feb 2022 02:01:19 -0800
Message-ID: <20220214100119.6795-9-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c38349d-2a97-4192-3619-08d9efa13043
X-MS-TrafficTypeDiagnostic: DS7PR12MB5934:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB593440342B824A087B87B57EA3339@DS7PR12MB5934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcE3GV19IDTX/eY7hUZnwKHtJZMml8pTx55UBergFGaN+C0FzevYJbIgonrCKYq+nQ7Az5hVH1kbehKXdYeucFCpiGFtdlyGmzdh1eecUKFwvjBq8hBnZPpEeDVfowdvJ9vsQB7lVM8gKrYQmv1q1fNf7zYf8jbGMy6DeTm2UuLtZJG1Um6gKkUQq9dxHogH2aZLXJJbiCuUjl1rVTNwGdYf5EPJCF2uju/2DlNf4Ltl8wzLfrBoD47Ph0ulvYgxjgobj2W7pUNHeFoG4w5HA1mASA9gA8zXFLTvXGwXNdiBznYfsorptzMjaiUz0RohSo1ulhlnBp7MMGCcf7UbAbtH4h1PUKysRUzOGLXfILpET3lSlxJUj8RPp0tC/M+TkWNqV5xT9VBPtiVjVvy61UKg/4Ssmg/2OFRTjNSQTA10nNTSF7Vgo05RSPOyvpuTlJVQJnPwHWAOZP4eao8GB1ZWEq93UkfkSsxebzkC96U95dCwQpR1IbsCbMVuoEQ7deO1p8OpvARJ7fDQ5dJwlGzJ60sULzSEHzy0vZTryTBolgDJsoVErCk7u7CgWn5jE5DQWVGc4qP8yDG+4pzwW7ZE/r2fwAMYImYkfzi6vlSqvBOs2w3EY7KB1LUCap2fWqx+S18AawWLkf9/ZMJvxX9/ZvjdCHdigIBHLt4/SaHpe2L2/LtwE+l66gyp7kgmlc6IiOv92dBKTt7gg0/bfQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(508600001)(356005)(36860700001)(36756003)(2906002)(81166007)(426003)(54906003)(83380400001)(7696005)(6666004)(1076003)(16526019)(2616005)(47076005)(70206006)(26005)(70586007)(186003)(82310400004)(4326008)(336012)(8676002)(8936002)(6916009)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:03:02.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c38349d-2a97-4192-3619-08d9efa13043
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 18b30a56bfc4..fd2184d63c11 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1785,6 +1785,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -1979,7 +1982,7 @@ static int loop_add(int i)
 
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-- 
2.29.0


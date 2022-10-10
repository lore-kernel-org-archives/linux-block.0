Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B95C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJJRCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJJRB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:01:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B53A15A
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKEgUR/u8dvTF4Tg4uO/TbwQRtoYNVfnEleHNeKYReWuE2XYjrMPnvIiSgqPvXwXNmjj2raeWrEHoFdeCsu7boBRGh+xRWdh217gwnWsd3jEi0pZe5EaWVjQhyW8LuyfAEuajRx4LC9KS+I5SNkMiMoEyVP+U6JelwqKVJXFZ/MjBR/09DJ3qBrgo/bg+jgWNS+MvnEdyyxg9POaA3eDrdO1rUuMDI0gLBzhFMx94ro35vebIR2MDeiJVbS634GCCK/8hCOy6VOYQ0e2VyclMQcjm3NwnYjcC5S6dazej4L2MkNkFgEpL69ZM+8W1/1xcW5qLwwGxTxQil0cjxUODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2JTODkI+74irzK0zcIIIoWdG2MUh2aj+Wde6aFLSqc=;
 b=Ij0R0lYBJpmzKzq62AO1YpvrRwttigYOjFl6OhLehWkhpuAmkzCbnAnv9ekyYfH3Fs1BaYBCfA0+KDfddG3sRvBO1Rvyk+1F8+1ddXTOx2FBioo7BGnt0mQMZvmkzQk9uwSraoYg53Huv0GCiXByCvmkHIE5T1YfU4fZyiRvnUja/tWRhxw0BIepjqG/ZWPf3R2ojXLNVrpVerKuOvUg9SWFEJpHhPLX9gEvuuYIF/Buhyf42D8mDo5Q2uZgJ06QVG6lh9870LIaZAQBL2YcGwM8Y5GWQVx1JKfnk99fpn5N8x9kVEgboMNeda+WDFhPpKITREt/L3RbSbB0QvlDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2JTODkI+74irzK0zcIIIoWdG2MUh2aj+Wde6aFLSqc=;
 b=JmLPw0EvOmBL2eXXbQc3WO0xj+yqeElWdWbn6HJ3DYsUkKazYjzh2mPGR623sXGhNspG3QppClDFNKvNlM24OczHKg1ozEc3ksHP/B72KgIuHvqTi1mfTb//7N+fYxIb5gJgZjBT3jcOOUAqTprO6NWxkU+NkpSw8Y6xZYp5fvjsTyKDvvM0uQBlc3iCHINVZQwbC3hzdNGd9P8b5V8HP41GMDXaeMHZbhWyr0Y6aNhiehEZQGaTWZteg+TlqYDMvoPdz5zF85iMx0ddyNGDPfZ5VP7WNEfr5pcAk/pApo8W60OFWsHoEjPJSWzQKKLKrHdIIHLl+elFT0IDQdH7mw==
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 17:01:54 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4e) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 10 Oct 2022 17:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 17:01:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:01:40 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:01:39 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 5/6] nvme-core: use init alloc tagset helper
Date:   Mon, 10 Oct 2022 10:00:25 -0700
Message-ID: <20221010170026.49808-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
References: <20221010170026.49808-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a44df2e-46ab-45ef-2483-08daaae121e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULGkBzOxFpVRkcc811xOQd663uca9G02oOZpsMZrtqIsCKyVoM97cEuFVKfnQEElaDGI3eIbSLPVYnZjIB0qn45zDCKb/saEPZmbCoR1E6DnJoqdSGXkus1UGbARhBAFSaaEWDzbSPa0f1k69CuSaRzpvt4qobXqWE3WYIpqHlC7wxobEsGcZXjrd+nrUPG6gRXLUhhMdciUwLdOdcYnUbqu4LN4Duy3BCwWLm+eMv6PmBqywl/aNiOLDzn30icnSec0CbQxl+pZ3Eo8HTFdvFZser7VujTBSFJzIxqMSq6PCCUxjd/zoFNCItPiwQTmACFpZW0NSQbx+Vvnsu82AnsgnVHfM95OtVxfccYFQSqfr51uRYK5hHk6LzGWIE59+HrspOL/b8LT++gsNkPaRNjZH4CB0QXApyOq0SKpXTbqFDIV8WMzlS4gpDJeNt3gMWaPgr90qhOt7q1vrg8Kp76IFk6gnP6syNziIgyK8LSW6pujOXeJUzm07FNhZfOdYgURVzn3ahQmuSbxya26hSU1YsH82dX/I0TAwHGY8Fy1ZiiyR+PK9waHnbscd1FuRKBSS8sPNHA1VznJ08zr83PXe6jnRT1qjS0bnH6/6uhnUXMYjImcKYkV4JH+cb3Cx98HSi4QVfs3ak1AglZpGWkP3WZDApw3L/PvIY5oh6Tb0uCdlK3KY9Wv29vmx8llsRy9qSPLB4rMR3Hbw+SQC3E/dO7xRGui1bUw56aytIUgwjZ1PwAj8REnIp0mwbG5naRR3z+2NRgGevOqClfcHg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(7696005)(26005)(82740400003)(40480700001)(316002)(8676002)(70206006)(4326008)(70586007)(36860700001)(356005)(7636003)(40460700003)(36756003)(83380400001)(186003)(16526019)(1076003)(6666004)(82310400005)(478600001)(2616005)(47076005)(2906002)(6916009)(54906003)(336012)(426003)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:01:53.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a44df2e-46ab-45ef-2483-08daaae121e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 965a4c3e9d44..bb6868f895c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4814,17 +4814,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = flags;
 	set->cmd_size = cmd_size;
-	set->driver_data = ctrl;
-	set->nr_hw_queues = 1;
 	set->timeout = NVME_ADMIN_TIMEOUT;
-	ret = blk_mq_alloc_tag_set(set);
+	ret = blk_mq_init_alloc_tag_set(set, ops, 1, NVME_AQ_MQ_TAG_DEPTH, ctrl);
 	if (ret)
 		return ret;
 
@@ -4869,18 +4865,15 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
 	set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = flags;
 	set->cmd_size = cmd_size,
-	set->driver_data = ctrl;
-	set->nr_hw_queues = ctrl->queue_count - 1;
 	set->timeout = NVME_IO_TIMEOUT;
 	if (ops->map_queues)
 		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
-	ret = blk_mq_alloc_tag_set(set);
+	ret = blk_mq_init_alloc_tag_set(set, ops, ctrl->queue_count - 1,
+			ctrl->sqsize + 1, ctrl);
 	if (ret)
 		return ret;
 
-- 
2.29.0


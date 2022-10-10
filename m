Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFBC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJJRBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJRBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:01:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B242BE2B
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP7d/8tOSaSrWzHJ7wc7y9r/03tXzN2fH2abYpgFqtaj9RvJATgh9mgvjMZ/R22LC6tAQe1uyc/HI2jZrQaA5S+uD0B4lbJorfH6Ai7t2EiVj4x+D2784kvnmsf3Bz6jTkVzz/zO3TEjd/MLPHQ5Il+Qcko766cqIziuSRBACua8kty/vkjO8xPoHXFoao1YA5M0p73Tph9VZ4LbbWOnS25JGHU/v43zc+KpWrZcAc3DNofPIoRXPdxGpvi6KAvt09WAdOfN/kCkR7wAepwIJdNGxssKzXaAWXkSEpYvU7GjvYHqMGX+QJuoiw4VRTG2hw7Ix8xboNKN89g6ZNZt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKmS5ZfE29c/Q777j+URajCZkuCuhg44wmnKvh6Z1mI=;
 b=Wv5dh2pFLwnB4pQIfapcXgsbnp2efoRmUBbxgVreV/eTDToYtcEQi6BPdN6wwchOOYuyrSKAz2igzVPvh6Patz4MrEMruaR3l514HhtzZnj95hJz1KDU+pqM3g4loviE8qEWJ92SF6CaTNSgQvGJdV9L/i+dBJsCr/yLOIyiUmkGAwuRdyo2O+3f7IHQoTv3LxciKm24E4qDCOYUv9Z0svZQPqAoUuThhZcih4OoGwwpYY83JbVxg7s4GCoCLDD0WOexAViBDGURux41F2ULxRrq/42kphVuOOOl0J+L8KhaGCr+Ax8wamx9F7rLOn9UFr4Wg6tK5hFyeRo6dG1SEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKmS5ZfE29c/Q777j+URajCZkuCuhg44wmnKvh6Z1mI=;
 b=UDdax9ufHc6JFiMeznngH5AE6wo+UbpqWnz5nZN4MYsHlZ4sfEVxIY2JLwVADdQANIlsNzFFwyf0n197rytaiUs+zXP9B18UPUYohiqMloRRh7gPHgZwSEqrs6OtpfRvwgKdd+HeaveUp//dOAt5Ebg6fCca0T8ILGH8wu5HMmNMhlqpVcf6eCZn/B8r7LvxblQN/jrCfLEREZYFU/wZrBGmb/XKqUIrrxcYnmg4X5lAQFOSuwfY27RlqplwAnGg5Fr13yMWWniXZZtHTtAC5thYh05dPv/KSm2im1fKddIffx+x0mRQrd+wydzDlwMcxK2t6529dPCzGmnrIluCpw==
Received: from CY5P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::13) by
 PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 17:01:33 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::ae) by CY5P221CA0078.outlook.office365.com
 (2603:10b6:930:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 17:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 10 Oct 2022 17:01:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:01:18 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:01:17 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 3/6] virtio-blk: use init alloc tagset helper
Date:   Mon, 10 Oct 2022 10:00:23 -0700
Message-ID: <20221010170026.49808-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5a0e06-f177-42d1-3bf0-08daaae1158b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WNaCRV3zdvXFF71cxQH3xwW7+PNil42gRE9KU57wHK+b/yddm3IwNwVR1cMVL4vo/LeG4+HX8fXX7jy4PHeL0pVdzuUfzRGgUhF+t/bLkqLUMXPxRX190BzRSYWr8gFET7KPZXH3OG/cVbGfse/Qu6gx/eiUOyaMuYeETKZsZ8yJJATW2szp+9xx7o8gsbjlUvwX+j+xXGWADYb0y3/XiZDOWw8WibT4XFh3CXS3YGGfO93iWv3CUaQ8Na4wkSqW1tsJMrGQy9XKj9t0rdNB18UGqXfl7D0c+fesCKkuprMdFPwbcf68nJCE9om7K2hTU2E9UT4I/To7x4W4TD0gvUJLrMPUwAh7BcE4nvzJ6Jek/shaqkxFoSqDGe/QAX+Aw5OHGgSRkPvXmoPZKBHvgsugls6nMGb7/x0NNlD4A69ymjmjSBhtSQDLyc3jYKzL/u/Udv98W1glCHjOgkwdH1froPp3ioRFSm5sob3WDn0JJw5aSyedLs/HKc7yWA0g3mARPwx5FVGegyf1ORk/JO+3dbAkT0eaayP7VryNg6GStDB9rST8gUHJG8lnpWtbIo2CJwT47Fg7S1BxlE1qsBEV0aWaPWCk+jx8RQi8/IgEaby+bWM2rNylm14oj9D4x+60kW6kUIPC6lU6nkivz5MfHmX+l8LCOEWaz4tYZfEG2BIqEDJRhf8kId+xPLGW5DXLLmK2USg2N9ryFQwhyPH3FpBsMEBHVMrqnbH8E5vhR0JK8liZO/yq1cdm5cAAYOK/ANVTbobJnJAJ9x8pQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(70206006)(7696005)(41300700001)(36756003)(54906003)(40460700003)(478600001)(8936002)(83380400001)(40480700001)(47076005)(26005)(6916009)(4326008)(426003)(316002)(82740400003)(82310400005)(36860700001)(7636003)(356005)(6666004)(8676002)(5660300002)(70586007)(186003)(1076003)(336012)(2616005)(16526019)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:01:33.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a0e06-f177-42d1-3bf0-08daaae1158b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 23c5a1239520..57333cc90557 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -942,20 +942,17 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 
 	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
-	vblk->tag_set.ops = &virtio_mq_ops;
-	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
 	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-	vblk->tag_set.driver_data = vblk;
-	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
 	vblk->tag_set.nr_maps = 1;
 	if (vblk->io_queues[HCTX_TYPE_POLL])
 		vblk->tag_set.nr_maps = 3;
 
-	err = blk_mq_alloc_tag_set(&vblk->tag_set);
+	err = blk_mq_init_alloc_tag_set(&vblk->tag_set, &virtio_mq_ops,
+					vblk->num_vqs, queue_depth, vblk);
 	if (err)
 		goto out_free_vq;
 
-- 
2.29.0


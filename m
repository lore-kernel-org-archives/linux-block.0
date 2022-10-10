Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B271C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJJRA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJRA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:00:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884D2BD3
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDy2e6xSVmF6nS/0tSnGs+EaQ7UBJRNFjF3hVYnMMpJD2ewxysG5Kdt+wWxh3SUrmLTxY4TPqA7eEch8z0W1oY84y7HAvCef5K35/Zz+hw2wEbc87PTman+roKQArDc80F8N/zwov6GiF6NOkMF1B/8t1ZyqvhOU+wV3ijpP4kYIaz7UaPGm98HGF0YB63etQakWlVhitPMaXEro/E8HWbuW47wu7k0xvQtWcrxgL3njUmClXaiSQvW5R0JfW29kVvjeJqJIolvhhsDRdtdK/vT5DgCO91XaImexb2GMxPtKtmVIq4xUM2m0hPKl/kc85J6GaNZIXXHQJgl4DPAmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4pRb4KwsAhb/cghn4r1gOqEK/R7s4LMJgREDXRF6eM=;
 b=n7qLFu9SvSh6fe9M/kuojXTt5boaYPZJcuTZudXvv2gNBpxo+0asQwlc4q3sdvp0ExlxJMFlf4sKpkMYtioy5oNH9yreQUPuMg07xgCgbkwu7zQItNmxMJp3D61M4t+keI0VwzS47vVMceyyHQfBaO8K/sPbAZw8dwyaxfzPBGSkfuSFgdpf9JvXTTpuIEnTO8yPlpmofZmFaUwzu/KlHJzn85EIJPOccsep4CBt2DoqHLBbDidq0lUgTACEdgudagJPGhEdTm6Gjn3TyFKZo6D+XWKcai8+ugE7GRkcwH7eUYUl0dT36FXYUHsfe+pDfRzJWlofdE201FdbKUVRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4pRb4KwsAhb/cghn4r1gOqEK/R7s4LMJgREDXRF6eM=;
 b=TOWw8TZUMdMkEgRmOZAf/8N4I2fVXosHw5zqkcCP5/s/Dp6QUS7zY9HBXeQFYKgQkn23Bb8i73+DOiKXWPSgrV9kfgHPLpG0dcmRXyqGbqRSj2PcRxQY7obLh1N0zW8BcMXUx7Xg2468KM4OOdhzNjM3azMAlNdtLmH7f0632WIYcypKyH+1c36wIbCvnbkP6dXSbcLWKR93tMHWmFMsDJb8kUT3465Gn+mPri+Gbt0fw5uxHOutqFIz0EYd94R8or7WcgNKmsBC7MZgl6FQoSX4IyQzLVPzvfJVlN2jJniY6/hk/F6r2zQzHFlAgEZg5qVffWAuFIuFsdG88zFVZQ==
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 17:00:55 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::5) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 17:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.13 via Frontend Transport; Mon, 10 Oct 2022 17:00:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:00:38 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:00:38 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 0/6] block: add and use tagset init helper
Date:   Mon, 10 Oct 2022 10:00:20 -0700
Message-ID: <20221010170026.49808-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bfc87a-b901-4f90-fc2f-08daaae0fe37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9Ow9NKD2ai/9yExmr84HcBJzL30GnXdnOo9iVNW9TTt6YbatoHI+ODa1K9ppVk/wZDtLfsCdsudj1pxHkWwW+aqzH7ntWD06gRCHZH3DYvDRxjWBWixIy0Y6PvgOkbHW3lMjI4hUzU/y9qohqqUx5mB2uVWdK0PxgUG/S0s7lhiKxH1Ht50T2PbwZpySDgptJ+kqpJZr6bshl8yHa2Dm7d76f1gRBE4TcaX85UwEuhXsg067eorOlS6IoWV6vshVsSO5XYUdFGkQEHtnoFqnV+Ka/gEdKL/eeyFrIHTuc/fR8mQKZ+NJl/Aodobx2JUsRSbQHIzn21RpgETuBxipzApM4JVpyYcXhFNZcFNHm/05TJ0c/8xK0x3c2rXm6Kk4zJtzuo7TV7CMy8KJLNkJ6+b87wHDOZon++yinLv9/ylJunaUL85fV18yqMhbir/HbWrkCE8Z6fxAi/bjOJSB9/nH5UMcJ2nsrW4ZngiVYXXhQb4nAwvcNhxko+p7ViqUGQgehqWbTRzB0spDVO4ZsSmbVLq5njZTtbga4CZEURh8GBa9nxpL9evm30J+7+cRe0sBygeHn7jjRX1qg7OZtAhstKub8tJ7QtdYncK7qgNbm2aoFOpuwpABg2ZZNNn2fnZjhqxsh5KeOf0DKYBwJbLHi2ybTrfj3C6m8C8uulXfMGZLa3UiMDSM88VusHWv92PTULCaHbeoGJ7yr97PbeQo6ulNXFTt8B7qr+xWJsBCmLIiei5XgbED1hvDzai9pzYntc5OfyNNz80JERbPw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(1076003)(16526019)(2616005)(82310400005)(356005)(186003)(7696005)(2906002)(36756003)(316002)(6666004)(26005)(70586007)(4326008)(8676002)(478600001)(41300700001)(40460700003)(6916009)(5660300002)(54906003)(70206006)(40480700001)(8936002)(336012)(426003)(7636003)(83380400001)(82740400003)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:00:53.8949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bfc87a-b901-4f90-fc2f-08daaae0fe37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The newly added helper blk_mq_init_alloc_tag_set() replaces existing
call to blk_mq_alloc_tag_set() and takes following arguments to
initialize tag_set before calling blk_mq_alloc_tag_set() :-

* blk_mq_ops
* number of h/w queues
* queue depth
* driver data

This approach is taken similar to what we have in the code where helper
function is added to alloc and initialize the common code that was
repeted in the callers :-

* 8c16567d867ed 5 args-init and alloc helper bio_alloc_bioset()
* 0a3140ea0fae3 5 args-init and alloc helper blk_next_bio()
* cdb14e0f7775e 4 args-init and alloc helper blk_mq_alloc_sq_tag_set()

With 5 arguments it shuold be easy to review and we don't have to extend
the API even if tag_set gets a new member, I'll gradually change the
drivers slowly to avoid one big treewide change.

This avoids code repetation of inialization code of tag set in current
block drivers and any future ones.

-ck                    

Chaitanya Kulkarni (6):
  block: add and use tagset init helper
  nbd: use init alloc tagset helper
  virtio-blk: use init alloc tagset helper
  nvme-apple: use init alloc tagset helper
  nvme-core: use init alloc tagset helper
  nvme-pci: use init alloc tagset helper

 block/blk-mq.c                | 12 ++++++++++++
 drivers/block/nbd.c           |  7 ++-----
 drivers/block/null_blk/main.c |  7 ++-----
 drivers/block/virtio_blk.c    |  7 ++-----
 drivers/nvme/host/apple.c     | 14 ++++----------
 drivers/nvme/host/core.c      | 13 +++----------
 drivers/nvme/host/pci.c       |  5 ++++-
 include/linux/blk-mq.h        |  4 +++-
 8 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.29.0


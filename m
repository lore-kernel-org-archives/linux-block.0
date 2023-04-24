Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E2C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjDXWzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjDXWzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 18:55:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D37AA3
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 15:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0zS13bgM0QyAqQSoh5LJaLUyM1z8ic7JUWYlo/gsuEfzNW6aHtF1tHdtMVD49TWbOVkNZk1NF0tS936xxVpFA5ztB5bQ2okT2/V0xd6HNnSbH5YbIwBrV/08HWbn5vLVctH/BikLySFcA+VaTYQHk4TP5k7MF0oBu7BBNfD8QJO3hj6S5Z4u4w1eUhdi5OkXujlBfHIA79jGJfYrzPdEraG32noqSF0Ed0RgYvaA+++WxsUi3U55dKlbtQ0xFgjCZao7vk6T6kBPIMyBYN65Al4hbaQDHwiJjkOHT3VxO9MXz6f1aHUd86OW0ARjCJs+MmLYKGpE6ORnBzlQl1+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qxG6O9LbZPyhRhdY6t3iVFeavXH9ZXkPutwqVGfwyA=;
 b=iNJV7S3btIredCbqsT3EjvOrZV4PSlu6PETQwFdQjGztM2ckBrO4wrd2Nrf3ty2n6ZgVabqTDOpTUgieDYlP2XVZMPF/0H9ROP31Cd19gRI9fiSFY+iOuJ/7bywjNsQfrNAKHnIR7no47AS7HKC4hPxC8yPezQ9fzDyMdcnrkDOGre3yN/MWJ5PpDokTy0HlHwviAN7969drbZlIDW2rpUKmICWFJFCQWnYkLLrlaaEpKdDlxqxXgLSEs+0wDUL6O9uAt5s74I+uUGGL4ME5jt9vNB/E0LbPrFJd7eEsg6Y+vrCboHZJCe55r+X541+D4VVo11glFotISvsQTPNp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qxG6O9LbZPyhRhdY6t3iVFeavXH9ZXkPutwqVGfwyA=;
 b=YuDax7Xr0Unne1A3AZntpUFMO079XSc1P/mGTjrX4lJx0lstHd75oJC4DosHCWjSGPy65HO+1IlcdRcBaKTUwuk20xgcxg8c/7Ci+Z1TzpfZ4chCEplE42zXUHZPXpnAPGhou2Yxv7+zwYLPuTUnTO+n2rsMF7LGrzqnkcI2xagUK43I5VSZoEAj+P/CgfASNBt7z0xlUaQfVXI45mP6yWOMj9NpGv3c+8EDntcz2S0wrzkFE6sQKJTrF/soJPeeC4/tTp0BndfwqHUr+nsyMwsRGPuWhwN9eCj1zmNe8YnUC8y8SP5iVVOCGf4cHO3GcJD/7jSKgqvo6p3qx+eckw==
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Mon, 24 Apr
 2023 22:54:58 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::20) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 22:54:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 15:54:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Apr 2023 15:54:46 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 15:54:43 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <hare@suse.de>, <kbusch@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <oren@nvidia.com>,
        <oevron@nvidia.com>, <israelr@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/2] Fix failover to non integrity NVMe path
Date:   Tue, 25 Apr 2023 01:54:40 +0300
Message-ID: <20230424225442.18916-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9fb817-84ef-49d5-42f5-08db4516ed7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDOKHSC2mrIfFIeJ7ifL8g6YEGFiPekkeNe6VKzVMqz4DNtwquBMxmRaqKXBYdP8nJYnPA+/5ww8K2jmaV+vj9IgRIxZXrcUZX8v5otpZ55GDCcC0jNgiBQpwxdNsj9X4lCIGdfLbcG3sGDABX+hLHCYdA4FRscxbG/9Xek4qp2BFTwvKHnJbKQG76/a1M+XZ+Ze3qd2RHZ07ZtFYACBj4vR3XeBTcZ1A9yrrcIoICfWpqtKI/OOfO0WEzr5C+b9Vhdtt6n1zMXpVa/rL+rZoS9+ajCw/7B5YfOJrByIf6TyqyuKWlDMscTbtpW8Q3LCVLXSLpQ5sONF6R2tnEIpv3fB+v1uup1SDGFAj6xs7Z44abw6/X4cIIcHCvuM3mFdCdpvLycfzMRsctV4V9chMJ2jTCSn8lV+QLBJfiNQN7BQj9eUwSoATvzu1xYl15vWud3dsGsEYJ4Xmq/FgPnXDTYWap7njFrDfIKjiuhVuytmEzBMQctxVSvE9q8EUn7ieokK3zOmNT+Tx2ceZRdufq06/sqoqw3SpAaxOvoWf42f2esuMfgDUfp3uIdNu5C68FLneWpLFmGeh6oWYCiVdSvlRIqa7Z5kAz+NySFzxRVCOjk12wL/jqMaRhuFzBnq3X+kJRJN40yhV+KL7JNyzvzD7nvcujj3x5Y9NfHOPRarawcnmKgaL+yvg6/uz68MKQN5MDa09mcQS0LipeykEd0XrvlzfPhazDQ8zJ8FF94=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(70206006)(4326008)(36860700001)(70586007)(336012)(47076005)(426003)(478600001)(83380400001)(186003)(107886003)(26005)(1076003)(40480700001)(86362001)(2616005)(36756003)(110136005)(40460700003)(54906003)(8936002)(356005)(5660300002)(34020700004)(41300700001)(7636003)(2906002)(82310400005)(82740400003)(316002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:54:57.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9fb817-84ef-49d5-42f5-08db4516ed7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph/Sagi/Martin,

We're encountered a crash while testing failover between NVMeF/RDMA
paths to a target that expose a namespace with metadata. The scenario is
the following:
Configure one initiator/host path on PI offload capable port (e.g ConnectX-5
device) and configure second initiator/host path on non PI offload capable
port (e.g ConnectX-3).

In case of failover, the original rq/bio is protected with integrity
context but the failover port is not integrity capable and it didn't allocate
the metadata resources for request. Thus we get NULL deref in case
blk_integrity_rq(rq) return true while req->metadata_sgl is NULL.

Bellow snip on the trace:

[Tue Feb 14 18:48:25 2023] mlx5_core 0000:02:00.0 ens2f0np0: Link down
[Tue Feb 14 18:48:32 2023] nvme nvme0: starting error recovery
[Tue Feb 14 18:48:32 2023] BUG: kernel NULL pointer dereference, address: 0000000000000010
[Tue Feb 14 18:48:32 2023] #PF: supervisor read access in kernel mode
[Tue Feb 14 18:48:32 2023] #PF: error_code(0x0000) - not-present page
[Tue Feb 14 18:48:32 2023] PGD 0 P4D 0 
[Tue Feb 14 18:48:32 2023] Oops: 0000 [#1] PREEMPT SMP PTI
[Tue Feb 14 18:48:32 2023] CPU: 17 PID: 518 Comm: kworker/17:1H Tainted: G S          E      6.2.0-rc4+ #224
[Tue Feb 14 18:48:32 2023] Hardware name: Supermicro SYS-6018R-WTR/X10DRW-i, BIOS 2.0 12/17/2015
[Tue Feb 14 18:48:32 2023] Workqueue: kblockd nvme_requeue_work [nvme_core]
...
...

[Tue Feb 14 18:48:32 2023] Call Trace:
[Tue Feb 14 18:48:32 2023]  <TASK>
[Tue Feb 14 18:48:32 2023]  nvme_rdma_queue_rq+0x194/0xa20 [nvme_rdma]
[Tue Feb 14 18:48:32 2023]  ? __blk_mq_try_issue_directly+0x13f/0x1a0
[Tue Feb 14 18:48:32 2023]  __blk_mq_try_issue_directly+0x13f/0x1a0
[Tue Feb 14 18:48:32 2023]  blk_mq_try_issue_directly+0x15/0x50
[Tue Feb 14 18:48:32 2023]  blk_mq_submit_bio+0x539/0x580
[Tue Feb 14 18:48:32 2023]  __submit_bio+0xfa/0x170
[Tue Feb 14 18:48:32 2023]  submit_bio_noacct_nocheck+0xe1/0x2a0
[Tue Feb 14 18:48:32 2023]  nvme_requeue_work+0x4e/0x60 [nvme_core]

To solve that we'll expose API to release the integrity context from a
bio and call it in case of failover for each bio.
Another way to solve this is to free the context during
bio_integrity_prep.

I choose the first option because I thought it is better to avoid this
check in the fast path but the price is exporting new API from the block
layer.

In V1 there were some doubts regarding the setup configuration but I
believe that we can and should support it.
There are no provisions in the specification that prohibit it. Combining
binding and coupling multipathing with integrity/metadata appears to be
a matter of implementation specifics rather than a requirement.

If the host path lacks the ability to add protection information, it is
acceptable to request that the controller take action by setting the
PRACT bit to 1 when the namespace is formatted with protection
information.

Changes:
V2:
 - update cover letter with more motivation
 - Fix build issue reported by kernel test robot
 - Didn't add Reviewed-by signature from Sagi for patch 2/2 since I
   think he is still not sure about the series.

Max Gurtovoy (2):
  block: bio-integrity: export bio_integrity_free func
  nvme-multipath: fix path failover for integrity ns

 block/bio-integrity.c         | 1 +
 block/blk.h                   | 4 ----
 drivers/nvme/host/multipath.c | 9 +++++++++
 include/linux/bio.h           | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.18.1


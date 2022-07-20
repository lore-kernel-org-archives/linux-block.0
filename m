Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 11:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiGTL0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTL0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 07:26:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455F25C5C
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 04:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEBXklA86D2WavpZU4FpNimJLMhHiqTgd/oJp2dl56CQAOZvQwKnFcEi7tC0RPq6hJRDsZS2bEH6F92speHloEEjfXQW3eJUv2ftTrApa3O+HTWmSvgG06ZlVylE2IIODOkzEysKXIfU5yYN9ucKhp+XpGlg25E1dKwMyzxImQ6LT3Aj/cjTdNABxJy2Bb5pn2OFQfYf4D5DuvjIJMvr6DY8A357Pd9DccsFwTdlo4hzz++H/5szH0AMg6quwLGBJRxbeQhnZzUWJlS6Zpk7RuiEcvzi/ONOnl74ADXcfciRybdP0UcBZPFu5gvh5IqQ7gxHcgN2BOlGB92281pxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLHBZBplc3Rlmn1uN5sjpIOLpdtm4ObCgNN9x2ogo3w=;
 b=jzO3htxuN70u+ziW0MjUCocwkhFqU/bDKQI0t4vLXF1+aPI7oz7+soe2okfPBA7xgrM5NOQC5VXyzPMhJGNCEHOQqI2G22UiwFisOKegTNaTAWN1ntMXQ7G9VG3puI1NRyos0UwikXs4BX8rrPExG6QwXhFhQPoKmoFe8R+AofnfscxJRGYxPV52tEWlpnhHYPLV7eOrmDz0o8zNd07ycBvvB4rgViCO4dgdNHCIhY22jYhAG87OoY5w0I67FX+x34gWRExRbbfpwzy5oNSuJJ+Y/OyNvdDx3YB0NoiJDjJWDNSitoa63daFLKWPQ37W57t07ImA8huoSWlqSx61AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLHBZBplc3Rlmn1uN5sjpIOLpdtm4ObCgNN9x2ogo3w=;
 b=qsC2MG7lR4fkUiHsCmHgrSN1bYGgY7dE+7uQFFge58QUQaW2OtXIW1lyDt6PSATSuohFKckNYAW7EBV19KJxUFeqhPT6gK8To6/zM4ccq/D+Rz4labLw3laaxQgAg4ixW2AvlgQIamLepiwqKeoGFMU2m44bAu/9h05uG/dT1n7S7RswHCWClus8t41TPD2JkTk9GsnB2gazkpp7BlL2IS8Hkyxb1gJZkDO4Yf9Fb3qthGCxZ7VuYCny5sWuPgfM1psffcWMl/BchnXN5ZbhTzUF7orKgKmVvgdtcZmW/yctSAtvRd995Ocq9LkWxfgdjGkD7WFZtBwoGH0aRUggAw==
Received: from BN9PR03CA0553.namprd03.prod.outlook.com (2603:10b6:408:138::18)
 by DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 11:26:48 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::ec) by BN9PR03CA0553.outlook.office365.com
 (2603:10b6:408:138::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Wed, 20 Jul 2022 11:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 11:26:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 11:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 04:26:46 -0700
Received: from rsws50.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 04:26:44 -0700
From:   Israel Rukshin <israelr@nvidia.com>
To:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Israel Rukshin <israelr@nvidia.com>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/1 RFC] block: Add ioctl for setting default inline crypto key
Date:   Wed, 20 Jul 2022 14:26:30 +0300
Message-ID: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0103da17-9206-415f-fa48-08da6a42bc1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFdGLe3fEDFmcLkTD9MZQdmZAcqFKdCzXqFMoa+WpMdcDq3IblrISSm+g3PyBhEI/Km+mWvX5m0FyEY0493LxkPohZqaDaVg0uTfRkJPHb8HHN/lpoEaOtSey+O8L79HIOysVy71PelwenxF3MMN/FreQkl3FpaiQTqtZ15hh5DE+pUUQBTIouYtsbxdRoDeMRpNqW2aVOtPWN7K4DVs7LfEkJdLybarpheefRNYJ6TGTIEQ5RzpMiFTji45o09K5i7UygqZASviXmZrk6kAzmA2WVzqJ57uaUQf0IUt9HgsNaWk2ZY2JU6uEiKg3BeJIRsbGhFPO7PydXcfrJ8bux5fR8BAORNvEkExZz32ZiAHAd1X8x1vC/19b+jOxcdMq9K1fi+kN7RRfwXwlKvgEGXfZln4BTqr2nbun837meUdXpBUEnysel1mTEae/f1baskcZoX1SL4cizoIrOgdE9UfIv3VTa1eApv3u6jo40wfNoyQpa+jwEv+urlAApVfm8cMbrrOnHg+L6RWCEeKsG2swDWE727fyoe0KlYz5p13YCipeZPqUdW+Byk1S68QALddDlVo88TRtWMijqRVdD1U1bdX/m0FapS50OpzF+UbOl4nKKO0frjg+ZPj9Ein8sOr4NxwfEsZi1eQUu88NCZMocdE8b5l972HgfPinwPk4xXTSPjjUSakUkuikouuBQTUitSfeDlXwM4nM2sarNjTEC7ohKHTtdIFab+NWZ3G3HnswdZFktAKvflrxvtsRmRiUVtJMEQkYVRXY5Qdc1IRS7fXS6GBkJFdWUCBQAlTDBuA2k3bAKs0T4+2cYNI1tbNXg13KR0cZvFieJZwUA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(107886003)(2616005)(186003)(83380400001)(40480700001)(47076005)(426003)(336012)(54906003)(70586007)(70206006)(4326008)(8676002)(110136005)(316002)(36756003)(40460700003)(6666004)(2906002)(41300700001)(5660300002)(8936002)(26005)(478600001)(81166007)(356005)(82740400003)(82310400005)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 11:26:48.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0103da17-9206-415f-fa48-08da6a42bc1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens/Christoph/Eric

I am working to add support for inline encryption/decryption
at storage protocols like nvmf over RDMA. Right now, the only
way to use the inline crypto feature is via fs-crypt. This patch
allows to use this feature also directly on a block device.
This patch comes after my former dm-crypt patch for inline encryption
was rejected ("[PATCH 1/1] dm crypt: Add inline encryption support")
by the maintainers. This alternative solution of a new block ioctl
was suggested by Christoph Hellwig and Eric Biggers.

I tested this patch with modified nvme-rdma as the block device.
I would like to collect some comments on this approach and I'll send the
entire patch set including NVMe/RDMA changes for inline encryption/decryption.

Israel Rukshin (1):
  block: Add support for setting inline encryption key per block device

 block/blk-core.c                |   4 +
 block/blk-crypto-internal.h     |  19 +++-
 block/blk-crypto-profile.c      |   1 +
 block/blk-crypto.c              | 156 ++++++++++++++++++++++++++++++++
 block/blk-sysfs.c               |   7 ++
 block/ioctl.c                   |   3 +
 include/linux/blk-crypto.h      |  11 +--
 include/linux/blkdev.h          |   2 +
 include/uapi/linux/blk-crypto.h |  14 +++
 include/uapi/linux/fs.h         |   9 ++
 10 files changed, 217 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/linux/blk-crypto.h

-- 
2.18.2


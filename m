Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694BFC77B60
	for <linux-block@archiver.kernel.org>; Sun, 23 Apr 2023 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDWOTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Apr 2023 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDWOTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2023 10:19:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C935A5
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 07:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5RlQtnYgRcFt7O4gn3XZfbWdxOomJNnxbvixEY+CQpJfT+lkW9Oyi6RzyscZCEAeWrsOfMmfV9BkSKCTzrwnyF5pX396gt32qhhe5VaP3Hg7/ZfUB+/Q6nP863A5Whlf2oH8fZGtT7ZGK7Fu7l4S/lqBwp7b0Q23Kvowx3MmgADmS7jFS7M04TyU2wI5v2hvffypp5n+r9YK3dxJRIPsZIp4zkn0MoLgCqX2pqByq1dmMVgHXp2STbGwSljjkc2ITSMIUIA/mUvBuBfp9FUOZTMWm5+1eqIKdVLWNDzPiRvc+GI2OlRvFg1ApGH0JvXMKEmDhGDwQdFZkhKL6bbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai+7Yu3uxYLaB5SDtA+bGCFkVnJ6FRdeMh3h4LADoM8=;
 b=X3GKd4pcKLkhtHgY+kkm0DPyqvFqL+h6iBozAMTceC4kzCinsmrLNfW3MdXjnG9hhJdhNthUbsXyNNgxK6moIyvjH1DKOjpW3ZD6zlvXU3p+LnR9GeJ25C++Fer7PcQGoJf713TrzhYLpFs29zwnKE8KQTVflWMNxH14G/faHiPANwbcYeNeyT+MR6Jfv4/j237+3rDIc3ytX/J0pNtQ6wZ1QK41+En2PwMYc5bejXwuId3B4J/c80s3p52fhln4lkvf5bJ61C3tQvOnDUO4gNg/cOmw9uMrIJZ24oV20q6AJjlH04ZTsz0lNNl6rJbykyNcu//IyaIWnA8qJuHf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai+7Yu3uxYLaB5SDtA+bGCFkVnJ6FRdeMh3h4LADoM8=;
 b=oKu5CAsJPwXvBlXQtyO9v8xO5LOTdosS6XNqTCiuzVVN/EO7dt0ac+3p9RAcqkfFNdeQyvLyGBwuXeRH/G0y12wcoCczsc3OmOBh8CbkPUeyCpv1D2RpwIhsknZpfG3ECkmBQZjrBI1yQtynYK6ORaRNeJi+MavqK7B3v/V4s2P+xTDhHiW02HJu2R/Rgcj6PTH2cM6Daey6YAA5RWrl23gu7jhCzMfx6ABuC1JDZmHxOBuBzgRQpwOnSjXzltwz/6n32rWIDfRRc11oOzNH5+L0+Hn7f9pO6+JrA74fvjHS5T4ZKyh1AHrgfeG+Alblt2g7f5QOw1yROVJpP+L9AQ==
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.32; Sun, 23 Apr 2023 14:13:36 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::5f) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19 via Frontend
 Transport; Sun, 23 Apr 2023 14:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Sun, 23 Apr 2023 14:13:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 07:13:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 07:13:33 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 07:13:31 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <oren@nvidia.com>,
        <oevron@nvidia.com>, <israelr@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Date:   Sun, 23 Apr 2023 17:13:28 +0300
Message-ID: <20230423141330.40437-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 53349159-f04c-45b8-e994-08db4404ed87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7AKG2d9obZMswSXvl57Id6wz2b0OmwQ9XMuzfgNBMcnyBy1yoPoGsUhwKdRuSdzamMPdE3K8RpZqI7/tguMK8npn+vC2nQTjym2KacDkgK7JMem0frkeKV8y7ZF129QI/TNTz53NuKfa0q7U23iZqIQn5vuMPjaIy3k+R38t7tSdXce8Be79jbUTN39WDrn2ffoqHPtqQGXRiIsLj+q9EnsgCyNo/2ls+Mpt21t+Cn5BBg/fGbz7bxVLOohlwGvbYAhM1jOk6tdQ5ccSFVIXnE9JVKO6CzXG5EOMJo616Imao134mOwIfYtWe6cY7uYAJMdq2l1/HlTh0Q2DtqkIRJyQ9nMmHw3PTrj53QUU0HE2faB69DqvgdsrbjfF7Fy4CNBQy9Q7QbjTj4FbsXazu05MuFGm1mIWSjlbiuk9kKJNBEmcXXlWx58RjRCiFasmRgPiFvIjsetmSZoxxh5RO0LcRcdi3DQLYjWMZPaY0dfl8hcWaFbd919khHP/26weXWCijTvOgoay+r2CdfhDyjovTpNOBM8I4VHUbuV91xeRvxZy/9xad2PjnSFEe8/0AV7w9ifky41lbRZB72zYn1Ea95QoEuONR7KAwhZvpFMATIepK7r3sP0VZFFnt6ddPOuTlROAn2B2YjXgKTXTb/In7QaA/oQlU52lRsIdM3Sfb3t/zGJXC6P7+/H2v8PczE6MEenM6Mt6SbagmfJlYGWhyMon+KcmZw+ssxi+3Y=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(107886003)(1076003)(26005)(40480700001)(336012)(426003)(2616005)(34020700004)(36756003)(83380400001)(36860700001)(47076005)(186003)(40460700003)(7636003)(356005)(82740400003)(70206006)(70586007)(478600001)(86362001)(8936002)(8676002)(54906003)(110136005)(5660300002)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 14:13:35.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53349159-f04c-45b8-e994-08db4404ed87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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

Max Gurtovoy (2):
  block: bio-integrity: export bio_integrity_free func
  nvme-multipath: fix path failover for integrity ns

 block/bio-integrity.c         | 1 +
 drivers/nvme/host/multipath.c | 9 +++++++++
 include/linux/bio.h           | 5 +++++
 3 files changed, 15 insertions(+)

-- 
2.18.1


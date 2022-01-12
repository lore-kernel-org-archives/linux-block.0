Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F8C433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 06:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiALGG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:06:27 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:9440
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230391AbiALGG1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 01:06:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwiitK7sBPY2VMKPOVjw89T/+DNwaBxRQzmm61eWwZI9cuHuo9otTPd1KSyZUjDtiWfXVnRgY4d335WHPyBcnToTO4r/yogz1EdSpxCJIh1dwNqA2TON5CUvefYEI8Nwgt+jJJREk4rnjXPAmI/BNStIQvgNVvu9QuIetcM+QHYcn/b2QFok19gF2wkMmYJz8jmaBuF680A9MDFhJv6OMegLXDi5N7Wh/YbCxwz/ljAXISoCsuFkh25eCfGdfNNlWDqgtgDw1rgMVSMnSAoGduuxNMT0JVevQBu1235/RIpkdTcn6e1VIux1KNFoSedMYB+r33TeiM8ztYqElr54xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TwgVIHZUfczaE1pDVh3RWANsf7sXOvtLtOZ+i3bWr4=;
 b=lQvhev/qdTjGJvhYbHQz2SPTf3jCxW09MYjfZziZwyt2tOLvnbUPQg7SRHntBzDCTCshIfp5uvphTb98kgQ1JbYA3rghVAIr2Ae3KrtJWg+Esjl90tXUs4JLW1kpZR6GD2ovjkPpBQ3oQFyah0i3T2OV8dPWZfcZqiZqj7JVdKT4E29kLxmcb37rjI1wqV3i+p+emYhHfu75yT9UOJzBnDbNh7rTxIY8uErvFjccyagb8w2R1nV0mYtD4oLUKMCODvSmcncKNbX98TkOhtHSp8xEkaqVali/j8TN5bpwaoRUb37UOcb5Hkb/oFAuZkFUXkijzYU28xwf1RVX3Pz2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=fb.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TwgVIHZUfczaE1pDVh3RWANsf7sXOvtLtOZ+i3bWr4=;
 b=GwAIVQvsNPbTs2zjxTTbcygPq3e6zyKgJI7K6jbXNrV3HjY5blYtdeRo5LRi7WWXd3Gt/RbI4l/8E+7LrEB9h48h2uQ5YfLBsh1B3R1BcaPWE9FLeVfSJCUgxggX8BdYKpOyhbFds6v9bFGRSdJb/rDMM6J3NMNhgbYZUawVGZLr6VuUDV3MAQAj5ACYEj1r9E0H0lNeL2Ksj9OeyGk/fYsq4q8DcqjzlVPT8Mcxf6Sd+467G+W23BSt/vfxVFQ2ky243ElurjUfamsoBQVpJ0AVSv1vrFlAnaJZFztTKrRQ/WJgo3R4FWERklUBCLKqZAWjsoi94uw8DEdOabzV1w==
Received: from BN6PR13CA0052.namprd13.prod.outlook.com (2603:10b6:404:11::14)
 by MWHPR1201MB0189.namprd12.prod.outlook.com (2603:10b6:301:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Wed, 12 Jan
 2022 06:06:24 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::5) by BN6PR13CA0052.outlook.office365.com
 (2603:10b6:404:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 06:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Wed, 12 Jan 2022 06:06:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 06:06:23 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:06:22 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <osandov@fb.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
Date:   Tue, 11 Jan 2022 22:06:11 -0800
Message-ID: <20220112060614.73015-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5533540-a81a-46f2-d7d6-08d9d591a9a6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB018907584DB81D6E44652B61A3529@MWHPR1201MB0189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPXgG+aiZq3Hafl/nO9djyo+P/L5Q0/IXKICnjGwgE53vj9ACN67+k+UPZLpSdFM3pKK3aBpMVRg+dZuMwCfVsUr2y/ZED6Tb32N5o0juuzpZ3tSisejHYH69BFtppT5D1SmBB39TwI7cPnP5EVvzferSH4YHmt9wKiIuqfTdNcqqyErMASyor+SmiIuUMsE/1a/er+vClTytrkrzJUEaVqbQwzNkKynes5m9W+llXLr4n95TEWvN8cknkNu/0vx0e30YDs5Z+mcEoMrVLUMGHuGo2xSdm/VZ0on/azIuxI9zYn2VS4vDz6urgZaf87EF8HoYOJnFKLBomF+ycu8KNUzkqX3GSRfmr9TymhIDkL2zs4B/98bvBFs4j9+aQA2/Uen3kf3ygWN6iclboHLIv8PJcgNvTxglMgjtOIekE3X5QyqC8lHL0jmKgroCEEjEZVSk7jP0BSUmuRNYmPQzY8zT+cku/mRhAqb4i3yg4Cu2tp3q/q+fU5yYXlYL+wC0QwXy12r7QVbwFXX9XE9S/eA0S0MKjMljknBqVHsvVoGgxy05dCLatIG77XR3KBcM/ybhoZwvGGGuo6MMBttZ3tIaluXMdV0B0iqoDgQjCB7Y90Mu7ThRYx8XeWwCXlzAZceuy+m/T/VJNo3CXS7BKJMufjT1IDkDbbuOZPKa4jU6Fy3irmZE/WdShqIKuFrzzK0Y63QwLVkEuRKGipx0tCaoNe2xFCbM0RIHEsjBu7Qsx7vd9stCUMELaMR1Scxd5uJzOEbhzN3cIrUzv5PlKKWkBxc4A0IBlhifIhq1cpX8YikvtvPpqT1X+4uGsCp
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(82310400004)(6666004)(107886003)(4326008)(7696005)(40460700001)(426003)(8676002)(8936002)(81166007)(356005)(47076005)(336012)(2616005)(110136005)(36756003)(86362001)(508600001)(2906002)(70586007)(36860700001)(26005)(70206006)(5660300002)(1076003)(16526019)(83380400001)(186003)(54906003)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:06:24.0550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5533540-a81a-46f2-d7d6-08d9d591a9a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0189
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

This fixes the latest disc log changes. Without this patch-series
some of the listed testcases fail as they don't expect discovery log
entry to be counted. See testlog below.

-ck                   

Chaitanya Kulkarni (3):
  tests/nvme/002: adjust to new nvme disc page output
  tests/nvme/016: adjust to new nvme disc page output
  tests/nvme/017: adjust to new nvme disc page output

 tests/nvme/002.out | 2003 ++++++++++++++++++++++----------------------
 tests/nvme/016.out |    5 +-
 tests/nvme/017.out |    5 +-
 3 files changed, 1011 insertions(+), 1002 deletions(-)

without this series :-

root@dev blktests (master) # ./check nvme 
nvme/002 (create many subsystems and test discovery)         [failed]
    runtime  18.515s  ...  21.319s
    --- tests/nvme/002.out	2021-08-29 01:09:20.287901783 -0700
    +++ /mnt/data/blktests/results/nodev/nvme/002.out.bad	2022-01-11 12:11:44.468430121 -0800
    @@ -1,3003 +1,3006 @@
     Running nvme/002
    -Discovery Log Number of Records 1000, Generation counter X
    +Discovery Log Number of Records 1001, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    -subnqn:  blktests-subsystem-0
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    ...
    (Run 'diff -u tests/nvme/002.out /mnt/data/blktests/results/nodev/nvme/002.out.bad' to see the entire diff)
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.109s  ...  10.096s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.466s  ...  1.523s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.812s  ...  1.850s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.097s  ...  0.086s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.067s  ...  0.045s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.508s  ...  1.510s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.442s  ...  1.482s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.246s  ...  8.942s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  83.621s  ...  157.842s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  11.876s  ...  12.792s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  104.024s  ...  121.600s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  13.036s  ...  13.019s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  12.681s  ...  12.752s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [failed]
    runtime  11.160s  ...  11.319s
    --- tests/nvme/016.out	2021-08-29 01:09:20.287901783 -0700
    +++ /mnt/data/blktests/results/nodev/nvme/016.out.bad	2022-01-11 12:17:47.002551134 -0800
    @@ -1,6 +1,9 @@
     Running nvme/016
    -Discovery Log Number of Records 1, Generation counter X
    +Discovery Log Number of Records 2, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    +=====Discovery Log Entry 1======
    ...
    (Run 'diff -u tests/nvme/016.out /mnt/data/blktests/results/nodev/nvme/016.out.bad' to see the entire diff)
nvme/017 (create/delete many file-ns and test discovery)     [failed]
    runtime  11.642s  ...  11.397s
    --- tests/nvme/017.out	2021-08-29 01:09:20.287901783 -0700
    +++ /mnt/data/blktests/results/nodev/nvme/017.out.bad	2022-01-11 12:17:58.486775735 -0800
    @@ -1,6 +1,9 @@
     Running nvme/017
    -Discovery Log Number of Records 1, Generation counter X
    +Discovery Log Number of Records 2, Generation counter X
     =====Discovery Log Entry 0======
     trtype:  loop
    +subnqn:  nqn.2014-08.org.nvmexpress.discovery
    +=====Discovery Log Entry 1======
    ...
    (Run 'diff -u tests/nvme/017.out /mnt/data/blktests/results/nodev/nvme/017.out.bad' to see the entire diff)
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.432s  ...  1.421s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.504s  ...  1.437s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.428s  ...  1.395s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.431s  ...  1.401s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.785s  ...  1.744s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.494s  ...  1.440s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.435s  ...  1.426s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.441s  ...  1.400s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.462s  ...  1.412s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.471s  ...  1.412s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.444s  ...  1.411s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.669s  ...  1.581s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.213s  ...  0.179s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.916s  ...  3.892s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.055s  ...  0.039s

with this series :-

root@dev blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  18.830s  ...  18.593s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.096s  ...  10.142s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.523s  ...  1.452s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.850s  ...  1.849s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.086s  ...  0.071s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.045s  ...  0.044s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.510s  ...  1.474s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.482s  ...  1.444s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.942s  ...  8.029s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  157.842s  ...  79.725s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  12.792s  ...  12.910s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  121.600s  ...  98.668s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  13.019s  ...  12.974s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  12.752s  ...  13.075s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.466s  ...  10.869s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  11.689s  ...  11.611s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.421s  ...  1.425s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.437s  ...  1.455s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.395s  ...  1.439s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.401s  ...  1.423s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.744s  ...  1.773s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.440s  ...  1.453s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.426s  ...  1.414s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.400s  ...  1.409s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.412s  ...  1.421s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.412s  ...  1.419s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.411s  ...  1.411s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.581s  ...  1.612s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.179s  ...  0.182s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.892s  ...  3.914s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.039s  ...  0.026s



-- 
2.29.0


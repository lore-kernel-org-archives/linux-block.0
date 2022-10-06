Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE0C433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 05:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJFFFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 01:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFFFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 01:05:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2653643E
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 22:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In09jDThJk5p80HyO/Aqb2CNJ9/nbjWQWu+2YrTwa0igNrAq/MGDURHQC8XgNaSGEHiXNZ9wadIBGWt7h/ncdEAenP7wePuIsoDL/VmvSv2MeJeDz/CdLKNX/rx/XdMjuJzl4NsxsEIrgugNfR8mltczDtW5Weto0TfpvEST6u5jKN1ySQGjnp3x4cbsYMpsa026h4OxMLmTy0jzz+wOw3cr8F6yCkmSlnvw2i4xWPEwZC0xtlcDI0d4u6sD9MuiPsEZlgt42wEkPyZKc14H0LlWE2/NALXi1uQzGuwnnYzPPc20HAveOzooXo3IA1g+TPWxfXERVd7ZyeNu2YeUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azX3I/HCNSZog0fc6YVerGxJ+mT/72iWleXtNNbP32w=;
 b=MivEQiK9qalg9uxtFg55DJLfaw80ayhZ+cbB9S8aKKJMG6axRIFhFAG9ie1Sm8YO/F/uflRvfXlwCfuNkJdKJRrd/egQuzxiALUs6u6C0AzrNpIphuuDG0MPSFDKO289C9qtl3WSojKggAV2f50cGpN7Z2LBlztrk0oa36SGbydq0xxvIzgnuuwNifY41F0a2mrf8tT6LY6zeOaLhZ7S1fHN5eb48tFsvaQD+EnAR0dFegP4/60QQo3Fpcmj7zo7C5RAb/CUqE70IWoOHheFufO0k8weqkFQZiKqc9s9OM0THhRD+9bSvjCoYny+EY/EgE3YXFx1166Q8W7+y/RQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azX3I/HCNSZog0fc6YVerGxJ+mT/72iWleXtNNbP32w=;
 b=iqF0HENrTSJBq0iKwvWifYxu6sPeOx0vBlw2r2xGFap8Nrvo6uZD2YeP5Gx8kw6YG3N9Z4dBfCcITighvfrpZI24a0xvmzUp/61WBy3dU9CaiZyeaRyAa25FtzI5W3TsIcPZrIb3vUw3e2jeoYdRy2DAwZdKsN30ulwAGcw6qujJq9emaB+z1AKsg67E7b2ZMupCicrFR81hd15up1F/cdCidOu1DlDAoZYM0oLpGxVRh05Yb8FGfMi96XXQ2Y8IPw/wPSifG2hT/wi6UB288k2YwidygPiT+J+TxqKO98PwZSCQnxQOyrXs+/McMDdADGR9goP1cjIdjiUBEThF1A==
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.31; Thu, 6 Oct 2022 05:05:33 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::f3) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 05:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 05:05:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 22:05:22 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 22:05:21 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Date:   Wed, 5 Oct 2022 22:05:13 -0700
Message-ID: <20221006050514.5564-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bba52d-c311-40c6-91dd-08daa7586623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oz4EHSfAh4jO3D8ntnJWfUY8r1Gn2KW71BLDjbwXdQkTO7ks30tMpEL3Ax9fZ5feuYtDDtxMUIg3C2iAsgp/gUKc+VxH8rNR9Ymv+xwWL9Km/jO+UxdL1WZR9zEbVuN6MFa/zO5K/UsRFFd45ZosVUgId5n25oOkpWfTdz3rW4H24RBLIBunVL2012nloGSZ8PP/A3ASmFLfqY8wzDevUKaEqEAtjBB1I6QO5YT6wo4FTRWVGE2FV/Yn5MGrB9ViL1ZGSZ98H66UDbspdP/Dw3Aq/13IIkvIcfiChVDKKHkW+bso34q1KN1dyg19NqVvkFEDBchzoyuBcw2iF2/5Fz9CezJgFw+4Ok7tDU3ETetv/L/apb5g/rgykO354P7qq3IW3wWW/JI7gE8lAxZrAhY2Gpz6y3whUrPFZUS1h5+oYHQfheWPVfrFUvj770S1onWKtiSsDT0KJRlxgPzGpaAT9ArwWgWuueRyjlmktyilp+6iHe5xhkVsQ8cbrx9DMAB5bLKNhQZuboL0BjcY7OdRQvitMdrbsNPyRUZADyecxzrUoagQBYS1q9qKY6aVvE9WZ0R1+Jtdlz1Uv2WrT6qp2YC2V4+SPVKjbvSfpxTol3cujK7DsyCgh6zM1wkOeUTzWVGSS7EcBdF4t9lPMNNKDb12lYW7puTApGdyRS9ygwzSrGvr99VPLs8TkxLtI2NOMIh/iBiBhZyKPBkQmnnclSMDXioPzZM4qLvyT6lT8/S6vB4ybCQFy6QCkIlnLP3nL5GDZLyDPeQkEZk0NQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(316002)(7696005)(1076003)(2616005)(2906002)(16526019)(82310400005)(356005)(186003)(36756003)(107886003)(70206006)(70586007)(54906003)(6666004)(40460700003)(41300700001)(4326008)(6916009)(478600001)(8676002)(336012)(5660300002)(26005)(47076005)(36860700001)(82740400003)(426003)(40480700001)(7636003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 05:05:33.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bba52d-c311-40c6-91dd-08daa7586623
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a Zoned Block Device zone reset all is emulated if underlaying
device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
Zoned mode there is no way to test zone reset all emulation present in
the block layer since we enable it by default :-

blkdev_zone_mgmt()
 blkdev_zone_reset_all_emulation() <---
 blkdev_zone_reset_all()

Add a module parameter zone_reset_all to enable or disable
REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
behaviour.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
# git log -1 
commit 8ca0bd53a9c9e2f58c4fc9e38e3f5f82d26d3851 (HEAD -> for-next)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Wed Oct 5 21:57:00 2022 -0700

    null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
    
    For a Zoned Block Device zone reset all is emulated if underlaying
    device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
    Zoned mode there is no way to test zone reset all emulation present in
    the block layer since we enable it by default :-
    
    blkdev_zone_mgmt()
     blkdev_zone_reset_all_emulation() <---
     blkdev_zone_reset_all()
    
    Add a module parameter zone_reset_all to enable or disable
    REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
    behaviour.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
# ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Oct  5 21:57 /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
# modprobe null_blk gb=1 zoned=1 zone_size=128 <---
# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk 
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom  
nullb0  250:0    0    1G  0 disk 
zram0   251:0    0    8G  0 disk [SWAP]
vda     252:0    0  512M  0 disk 
nvme0n1 259:0    0    1G  0 disk 
# blkzone reset /dev/nullb0
# dmesg  -c
[  397.079221] null_blk: disk nullb0 created
[  397.079226] null_blk: module loaded
[  406.626500] blkdev_zone_reset_all 237 <---
# modprobe -r null_blk
# 
# 
# 
# modprobe null_blk gb=1 zoned=1 zone_size=128 zone_reset_all=0 <---
# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk 
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom  
nullb0  250:0    0    1G  0 disk 
zram0   251:0    0    8G  0 disk [SWAP]
vda     252:0    0  512M  0 disk 
nvme0n1 259:0    0    1G  0 disk 
# blkzone reset /dev/nullb0
# dmesg  -c
[  425.456187] null_blk: disk nullb0 created
[  425.456192] null_blk: module loaded
[  438.419529] blkdev_zone_reset_all_emulated 197 <---
# modprobe -r null_blk
# 
---
 drivers/block/null_blk/main.c     | 5 +++++
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8b7f42024f14..a0572e6c28ce 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
 module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
 MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
 
+static bool g_zone_reset_all = true;
+module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
+MODULE_PARM_DESC(zone_reset_all, "Allow REQ_OP_ZONE_RESET_ALL. Default: true");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -715,6 +719,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
 	dev->zone_max_active = g_zone_max_active;
+	dev->zone_reset_all = g_zone_reset_all;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index e692c2a7369e..e7efe8de4ebf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -115,6 +115,7 @@ struct nullb_device {
 	bool discard; /* if support discard */
 	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
+	bool zone_reset_all; /* if support REQ_OP_ZONE_RESET_ALL */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..7310d1c3f9ec 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -160,7 +160,8 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	if (dev->zone_reset_all)
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
 	if (queue_is_mq(q)) {
-- 
2.29.0


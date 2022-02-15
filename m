Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC94C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 12:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiBOMAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:00:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiBOMAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 07:00:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5BD04B4
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 04:00:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfsqHTjs427/wlfDjKzIgreQ8AbUO+qAHcWpeb582EDHKI71lFbCT7u+XrUtpkBZFUaVumMivj+kg+AU5sirkEpHPqMeWKfRpcnIDHKZkiHZs1/I3UeAXAHuWppOILRPG+L2ZShw4cRSnvGaBuSNX50260jC7mJzPVq+uRl2bRa4CdrpNAOUxIdXoKmEyQeuxEyIi04sM0S0l1qnxtPWWhJNoZMr+jzdYzelQfOovBoQ43uQViAnWbRomkrYukchkcSK4jGtqGfWDeRP2UTeV7ZizHDeb7qhp5Ws2fE12Pcq/sPU3syE91cGLA62xEPK8qjW/mOMS87dmKhGcmvALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgV7EaL/xqT/iuhwQQqwwvCr6ZZLSwmLKNnJAJcJhwo=;
 b=VFr1EQb+NlYxWTV05eOKgSoY6UKG0k+iFSbHoj6MCqiX4Ymu5dF/6kft6kLAuTixo1drv0Geww88pSjO36tjN/1sxQuS2OpyAVYPzIshuVQHgS162ycnAd0+cumI/pt3uexBGj0TtkAQMNMMGrzmc6e8pZsb4UUwSnE6pfW6Z8l+XcXjouNWgOcscBfOLQWWoa0XZMTJepIzvvCHVzGUc+MvVF7S2X6X7Dqh89EJPV5MvbMW6aOZoyc5f3rBAUy44bOZXPE8iKTw+RfAvgm1oz0GqEuhQKRM57FszGrjm9NH8+VwO2Pl9UFlmn1vYI5e5PYes/empvLWSWaziB+I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgV7EaL/xqT/iuhwQQqwwvCr6ZZLSwmLKNnJAJcJhwo=;
 b=R5SnbbWD9gRBoKWbO4Guh3MboypR9PVwZpfL54JNS9eLeW2aXd7VjEwSrpAou0eREVBzKMoBcuEwzyHdPGj4FaRQTuY/KX9BRozM9/iZnkxL8+A0emZzNh1RREqx2n/HRCum4rb5t9hrzpngKjDMfhtxDak2t1bEQQFJs05Xo3ri4o3MaBGppDuiVTTy8fbPOD0jPRGnm1B6y3ByOsfMMSp6ruhugLfVwUmvOE2RLZkSJq1TvxfuWOdk6xdZCdJ3zA+FSHDrOyIs2L9xixHohqb6WPcqd8UkIYel6iLJhJBjJuXJ5LJsCLZAplFILXjTmN4HINyUtPd+kxI7LWVU+g==
Received: from DM5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:3:101::25)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 12:00:02 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::28) by DM5PR22CA0015.outlook.office365.com
 (2603:10b6:3:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Tue, 15 Feb 2022 12:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 12:00:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 12:00:00 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:59:59 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        <colin.king@intel.com>, <mgurtovoy@nvidia.com>,
        <jiangguoqing@kylinos.cn>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] null_blk: fix return value from null_add_dev()
Date:   Tue, 15 Feb 2022 03:59:51 -0800
Message-ID: <20220215115951.15945-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b49867b-25bc-4b5c-149d-08d9f07ab280
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338B46586CB3131C0A989C4A3349@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFY5WkEW57BM3cpbdBPPfjREem5zd5PxpB5zqA5C5j30PL8Qh7YaR9MkA66ate9JmhKMvzEZI3iHc4jB9DJRLOL8yioZqbTHxC8OujW+TEwTfxj6Y2+8ANSNp1Usg5P8mPhXDcJEDGp+vHp8lV1OU+ZDkZbTFTmEMSZ09QnDHJEYH+hb0gEHe2qrkUbCvZbn+2nQnDUbW+JMDPmeFgPC6uP2AP2iJC8bN7mM+5u3DJp1tWAhF7x9q8NszAhahPs/EaGiiEAr4YjFvj6P1GRYbz1P6Z2SILdN/uh5d4L0FLQaLHpdEPjuca7LrJIljKPPFqWAvPb4ZjSfbi3WUDSTK8U3fKHJ7+398BGdp9ViivSWFfWoOKM51Q1WtX1K3pLn7IcB0aWcXcg8T50IOwb53Q89nP1/XSNzjhIi3xyMFBcQNN49DXX5PesRj0N4usV/hDfhoNL2OB/NesjQh3B9icy1CitSwrC0rR8tt1xtTorqPcZODuyzk5x4kNEQv5tcn64X5rfPsA7F442ojhhMfsdkm8l8R1/L6/38DKz8u+ZKK0C7cCWH8e5TDvTgBfP27E4URBqjv6cVU5+TjLQruzpQf3WwZriSTuYtyGI4TE/ZiimQ2AGvI4ZFnMIfGlt3aL9S4LFAp3W9ShaELzL2cwwlZD1TzKzi9zvXm9m/gWF7Qa6e6a0WG6kqxI+Imi5VbBrP582MIK3ZujsXrNT5ww==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(316002)(70586007)(8676002)(70206006)(4326008)(82310400004)(7696005)(47076005)(508600001)(83380400001)(6916009)(54906003)(2906002)(426003)(107886003)(36756003)(5660300002)(2616005)(36860700001)(186003)(26005)(16526019)(1076003)(40460700003)(8936002)(356005)(81166007)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 12:00:01.9644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b49867b-25bc-4b5c-149d-08d9f07ab280
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function nullb_device_power_store() returns -ENOMEM when
null_add_dev() fails. null_add_dev() can fail with return value
other than -ENOMEM such as -EINVAL when Zoned Block Device option
is used, see :

nullb_device_power_store()
 null_add_dev()
  null_init_zoned_dev()
	return -EINVAL;

When trying to load the module having -ENOMEM value returned on the
command line creates confusion when pleanty of memory is free on the
machine.

Instead of hardcoding -ENOMEM return the value of null_add_dev()
function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
* without this patch nr_zones set to 23 :-

loading devices
++ seq 0 1
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ echo 1
+ echo 23
+ echo 0
+ echo 1
+ echo 512
+ echo 2048
+ echo 1
./nullbtests.sh: line 23: echo: write error: Cannot allocate memory

* with this patch nr_zones set to 23 :-
+ for i in `seq 0 $NN`
+ NULLB_DIR=config/nullb/nullb1
+ mkdir config/nullb/nullb1
+ echo 1
+ echo 23
+ echo 1
+ echo 512
+ echo 2048
+ echo 1
./nullbtests.sh: line 23: echo: write error: Invalid argument

---
 drivers/block/null_blk/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 323af5c9c802..1666bd9c4ad7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -431,9 +431,10 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
 			return count;
-		if (null_add_dev(dev)) {
+		ret = null_add_dev(dev);
+		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return -ENOMEM;
+			return ret;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
-- 
2.29.0


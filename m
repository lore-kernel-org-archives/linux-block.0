Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAD2DBF78
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225059; cv=fail; b=IfEQY2xRbddma8Pq77Wa8U4+vSoN5EJTci1xeIEi+EGps9rKnFnZeu2771M7rLifM1L4fM2ivl7JE/CuSQa3jZOV6zR78iekMSeI5x7QBvCOxxgXuszUYiViYweXifxOJ3TyOXPzTW94lcwuF2Asmu89/ybC7AZRht5GTAI12So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225059; c=relaxed/simple;
	bh=jW1mq5yAczPGy8n90K4RgVMpL4gMDi+PZoHyAHx70Fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PInmdRzvw83aeQk0UhwIiV86L9rIJkSjyr5TYo/QzsiOTaCvz/2IIfcKf+ZTCCC9b/lZBUXYpc7k7h7M2vuaj5ifrYWxAhyYKJSDYAmiGMze6mtI49j86wJSCa42iNxTgBXPWuGUAvvAHOBJoeDCkyDlsoTd2m+Px6Alkykl78U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GLH0DOWd; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GLH0DOWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbcFnmScw5fqJblKXp3g9k3oz+oL+E3zlyCWIbM6ebSINQSs43TFlt3LQlVmY1/GE4eVb4DOAe2ZXprTJs844vsOxoFTqNR4x89hZFoEix9gIfz7kazk6rDd9hYqqQbSc4UPdItMJLQt0fkVFr4zEYBoz7u3i7xm0EqLoroVTv+2choeHreynr6x1TwSAycl10LAYXnjPXcHK2NGRP9V8osaPU3WRSIBZOXq1f2kM3IStZlQGyUl8dTggG24o5QyPUw4/l69UD8AF3WEDkn5M6gcbAGtsapwVv6FvIXYS5vk7rfjoqRZRrwoHse26M9ZpWdh9Tmwl18FOwlX4SS3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdvsjsVUXzHgJiYCpt90f+ZXSkoubHSzh7aTZKLoAXA=;
 b=mqxuzjFuJo7NuxNcmcV7TWovE+kL/02EQENpkImrIKXwV4Iyl9ZTsFH3aGQHG6T3Y/YE0ae8RwoHuFJO68K+zLVekLwdatNDrEIlqZU7373jMElS5DWCF6B43/GwCsBqC4DHMEf/AqVBEzdg5vsCkZIqANXxM/YHSpg2S03c83z8ZdMdRPIGRutWQ/OaU1S+QMqjdcwK5d+XvfzjHaG5bZV3aI/FonuYXKST+rVwIIBN15T0BqRGH4jotb/80jR6/iaiIWMVeKA5jvE8Kg/CN9oBEQrleXOWlHADTazdXgeabF4AD+E4BoQ/06/Xm/H7f7bJx3myaK4kPqFWJmsa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdvsjsVUXzHgJiYCpt90f+ZXSkoubHSzh7aTZKLoAXA=;
 b=GLH0DOWdVc5+vIelXoJ2q6USbDTGzdizUZjauBINggbGVXH5Rp3tuX6uq/q5rHqPq+iAYAVVTmNsEd+xZku1P1MZSJP+ftD19bxJLH8vFxHDDV9EY8hBkfrlix6A8UxAKmD+eV8tZ3Wzv8PPv84HsyIyatNj24Ikw83X3T5eH6uBw1UlbtoWhXenen4M/8WYMmWSkEg1CxQE5Q6EmQYjezIdf0CYU57rf/DWEolpzCvFk3cnWNonWI+eNSgBQaLnON/AnnPbaOkgRHD07n63lqxYl+C2RO1NhdOyo2kCG4ZM7K4ij84TR7tNcXifPjHoqsb5kgQFTkjLmB1URzL7OQ==
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 13:37:33 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::12) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 13:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:37:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:14 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:11 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v6 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Mon, 12 Jan 2026 15:36:46 +0200
Message-ID: <20260112133648.51722-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112133648.51722-1-yoav@nvidia.com>
References: <20260112133648.51722-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: f4baa314-6d66-4399-cabd-08de51dfbcd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7CuIMQUiqsoBEX95QktlYQjq9LbnZe3swREtMcm37/Mc8GAY1IGNI140flD?=
 =?us-ascii?Q?0tKdUcfLv884Fw5NC5CGr4/9If/9gS4gKirk+GFKuldruDlGrBzglEoY43m8?=
 =?us-ascii?Q?MPS+SNlzPlbe5YK3jNThKGST2cT4CSzdR/mBKnuHdaeAG041vcK37eR2zTJk?=
 =?us-ascii?Q?oSZn2VJkMeBxiwDGTzaygenLe80wTo22ao2SVzRhgvMHuD090q+pbZFS/Mcf?=
 =?us-ascii?Q?jtT95ca4vYVofk7Bqgc65r/gukIhzdQCybMixN1S/+4Gy7H59G2oW7uHJNjO?=
 =?us-ascii?Q?M33hqkR+TWpiUO0MZ1IjfY7e0sMw8r7mSB2LE9AG6Z/4Hb/22c1N10qQcent?=
 =?us-ascii?Q?rQI5YLYmZxj8+4Ah2atJRFCp3So12IYfJUzqcBfHfh1L87LF1F3uCxJMtk+J?=
 =?us-ascii?Q?wcKaAobcteBHf6AOPsUE/Bp6iZ7jKn3g2Q1hxGwvobDvIuSPoIZ5A98+nv9R?=
 =?us-ascii?Q?YFBMKN7jhe7Nj55wn8RVbj3bNvG/wHFZlY8G7W3G37NojamIjYsJk9Kf2BKs?=
 =?us-ascii?Q?Q3XEJcb5YxOUEB3upYazpYv6BCJnSlXTxJfkGFcBYsfZrp/qNGlW10LzT8AO?=
 =?us-ascii?Q?9IVMePvvV+tgeusEauFhkhUzgolpgzGHZNa5jdebzBhkxa5DQ18sowGrCHMO?=
 =?us-ascii?Q?dKRqm7Hy+DbHw7TsUwtGXTJaepxU83tVPm7nBEwXgEsvnnTPmB+3igRQmy7e?=
 =?us-ascii?Q?x7oV+0YeZUMr53Sg0AWbIwX5t41AdboAAOIUKty8djdORLtJp3t26mvqI6+H?=
 =?us-ascii?Q?ciVQz+u4ayU/RWmUfOCvEoYiaOcKdmgfCvoIFx8wnfNoWYfwL4N8UeewHOpE?=
 =?us-ascii?Q?mmuy8VnE89mQ3fUBTgNC7VpZExYihr0qIMWqJ0697d5ZaDWC0c+OLZwJq+rB?=
 =?us-ascii?Q?G4QKRy/r1vbnFSwma2AHLZdHg9kHmh3IOrkYnZvM3nFBY9TS1QjKbyMrwkGp?=
 =?us-ascii?Q?Zfig9DoIeJnzUYmcckwPFcCw3xL1x98jTVppkOObFhWYQZlEhRSpmfisNaGm?=
 =?us-ascii?Q?dolfxGAk1tNCYUGRRalucOwqMn1N4hOLlA9Y1J8xBW3o35wbLjNeLF9pHOPF?=
 =?us-ascii?Q?BdixBtDf5ZRIkDIlc+XIAGNPPbOo2eeeFWdjWDotyR1VZZ1Zz8EMNa96F7Gi?=
 =?us-ascii?Q?1L4FSi1ApdLuoP0v/pNz72DhKlnqTl/MCIKv0c1ddWLJeSDApvM+7Mbq/Knd?=
 =?us-ascii?Q?suaQI4WfOEFTUZ6ACD4g0wYWcftmkqaHXXs5IWgdHpsue7GlUS2mO5+Dh1Lq?=
 =?us-ascii?Q?2SvsJg0Ooe+peqg0h8T4IX67CqTJ7JqfuF3IEOEFfPtwNpMGTpBfMmvk82oE?=
 =?us-ascii?Q?BU57eOVUMKwvbA5NNY/rltJ6kJXhQacwnha7LuXm5j4ZNKzaUh8sfBNvGzfP?=
 =?us-ascii?Q?SHasezfl/XKz09SpiOztCQG/r3VNfvJfWYq0BJ4CTcQ6CC/9hXsMvp5HhHjh?=
 =?us-ascii?Q?Gyq1YnFp4L0smdbKgAiXvPIbX0hMxg6FB5dyO81qbSxE1zJj7xT6Jc7j/lhn?=
 =?us-ascii?Q?5q6QY1s1IMPYvuWO+I310ZY1za2zvnZWjGt/WQgFQJkxMtcbY4vtloKua9hq?=
 =?us-ascii?Q?+d8Ua4yr8Zofk4yax6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:37:31.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4baa314-6d66-4399-cabd-08de51dfbcd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

Add a best-effort stop command, UBLK_CMD_TRY_STOP_DEV, which only stops a
ublk device when it has no active openers.

Unlike UBLK_CMD_STOP_DEV, this command does not disrupt existing users.
New opens are blocked only after disk_openers has reached zero; if the
device is busy, the command returns -EBUSY and leaves it running.

The ub->block_open flag is used only to close a race with an in-progress
open and does not otherwise change open behavior.

Advertise support via the UBLK_F_SAFE_STOP_DEV feature flag.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 44 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  9 ++++++-
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2d5602ef05cc..f91e70aa402e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -54,6 +54,7 @@
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
 #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
+#define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -73,7 +74,8 @@
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| UBLK_F_SAFE_STOP_DEV)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -239,6 +241,8 @@ struct ublk_device {
 	struct delayed_work	exit_work;
 	struct work_struct	partition_scan_work;
 
+	bool			block_open; /* protected by open_mutex */
+
 	struct ublk_queue       *queues[];
 };
 
@@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
 			return -EPERM;
 	}
 
+	if (ub->block_open)
+		return -ENXIO;
+
 	return 0;
 }
 
@@ -3188,7 +3195,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK |
 		UBLK_F_PER_IO_DAEMON |
-		UBLK_F_BUF_REG_OFF_DAEMON;
+		UBLK_F_BUF_REG_OFF_DAEMON |
+		UBLK_F_SAFE_STOP_DEV;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
@@ -3309,6 +3317,34 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 	ublk_stop_dev(ub);
 }
 
+static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+	int ret = 0;
+
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		return -ENODEV;
+
+	mutex_lock(&disk->open_mutex);
+	if (disk_openers(disk) > 0) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	ub->block_open = true;
+	/* release open_mutex as del_gendisk() will reacquire it */
+	mutex_unlock(&disk->open_mutex);
+
+	ublk_ctrl_stop_dev(ub);
+	goto out;
+
+unlock:
+	mutex_unlock(&disk->open_mutex);
+out:
+	ublk_put_disk(disk);
+	return ret;
+}
+
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -3704,6 +3740,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_END_USER_RECOVERY:
 	case UBLK_CMD_UPDATE_SIZE:
 	case UBLK_CMD_QUIESCE_DEV:
+	case UBLK_CMD_TRY_STOP_DEV:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3817,6 +3854,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, header);
 		break;
+	case UBLK_CMD_TRY_STOP_DEV:
+		ret = ublk_ctrl_try_stop_dev(ub);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..9daa8ab372f0 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -55,7 +55,8 @@
 	_IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_QUIESCE_DEV		\
 	_IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
-
+#define UBLK_U_CMD_TRY_STOP_DEV		\
+	_IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
 /*
  * 64bits are enough now, and it should be easy to extend in case of
  * running out of feature flags
@@ -311,6 +312,12 @@
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
+ * allows stopping the device only if there are no openers.
+ */
+#define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.39.5 (Apple Git-154)


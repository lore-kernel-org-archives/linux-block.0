Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4A238C3A
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124746; cv=fail; b=BlakcupY4AaNV3P500nI0Y1ZcLxfVpOCJDQbIXMgvrkCY7ViNXVZNOVk2zG9DVYJoLABv8PzoCgTmPB3JSvmAjm963LzmryrzM756li926aMzYdmV74CXEKaOAhYC2Uy8grohvRhtTaozxpUTeyGMNQH2m6UFgBP2SXyblt5IQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124746; c=relaxed/simple;
	bh=dg4Jn6psUlF8Ymw5zEeuoHgSwRzU1l6j+13gWkwbNYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW807+hfoGuQbSPIDDacxcTSezc6fLW3HD13o6+pOI8xoVa+xm/YjTXXe1JZxuGJLd3vnwT1xETbKdoJSN0d+r9H+jZEMQvbVwOTXgdu0SES7nR01Zcr7HMqbN1xukCWNQYt2KSc1/0jtSHDBJDvNKdjokInbJU3N0PKsRURi5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ectw8jTa; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ectw8jTa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsCSpJIvP4GvXQUJJqIJ7efERVT7Vrl9fo6upTe0VkQeX+HuTqA/9CMOu6PeV0CZ9NA9P14q5OEjq+6nzt9ek0gGfz5zbTqmdFGC+WH1bH6QlPP//b75A4h29HFiSAZrrRnATMJcPIQHWs9QMzxIkVqB7J9cVOMulMlo/6AO6bKGQc29YojDOcS5IhFA05DewwFIosDF5GneAkRUhugrsCnOE5gptlDrzEYReA6W4BEc9d4eyXGhqDt0MOaiflMjhSkceQQVGorZmqhnWMlU8SGHP5ApV9fbH3pJ1OT743XHaNLaIUJNAaO8W67tQrVp7g8rJBWMLbRJxIg5ac8rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54vNPNvdCKW4iVPjoqOpUgPyjnN9xVRQluUlxZ8HI7I=;
 b=VbZRJKCc+1bikZ9yos2mli6d96bicdR0zxXL0Pr35gSzd1H/NyKBvkQqDJAT+lTmTMHrEuS++qKw0VMKlGTJEeiFW4OaT1tJN+5QaCwlOraWuiO9joxpOIOc/tWxNXN8RrHw6u225mzJW26dl7JAqZwVgkNmcXgFuL64ekxVVAxiOQ/1rbHLy9IduVYV7m/5MUv4SbfRt/RxOuVOD+hY+jJY3+ae7hJAQakhSrWgFAkcu8LazIo1nV1ZqdVamzep+NgP/U23Yu6KZtWLzqRz4OCqDgdqqZg2EgVafWB6aV8mBAyQ0kaevZ60El1RZ337mna5n5VXvb++BCPGsjECVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54vNPNvdCKW4iVPjoqOpUgPyjnN9xVRQluUlxZ8HI7I=;
 b=ectw8jTahZY0aPSTj3OYL5qOa+eO5Jlobab2RfMhsSAKswAK147PNZHqfDC3q8oo52NC1FkzYpB67i+PbBAXhCXf1kRFWlpVfJlxdSsRyOTeT1T5Ru77aZHhIEO56v20ONYPaXByL54hmFs6vA5CA+rWwVhbaqV9vW308KGgx2cXgVV48r7DdgBLuHFCr7Nh4el9mt3T3hqZ7T6+ysz87c1U2EGt6n8C0lWS4Ch+2Rm4xjQVO+L6iFZ9FZy4TNOVma0Vey0PN86ErPG5QREDtZLha9S0zTGHWHplF+cZaCpuR7FPbKK7eASaB7Cm8MaNmNGj8vZNCxUoJPbyWsrdTQ==
Received: from DM6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:5:1b3::33)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:45:40 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::c6) by DM6PR17CA0020.outlook.office365.com
 (2603:10b6:5:1b3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 09:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 09:45:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:24 -0800
Received: from yoav-mlt.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:22 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v5 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Sun, 11 Jan 2026 11:45:03 +0200
Message-ID: <20260111094504.24701-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111094504.24701-1-yoav@nvidia.com>
References: <20260111094504.24701-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7450e6-db12-4a08-7763-08de50f62e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vjHmtKTXB7ATIrEBpQo0GGL33FQwCjRzJ9HiOq7OllFz3wM1063nSssDhyNv?=
 =?us-ascii?Q?FhcfYcVuVlzjGZxf6egLVFssiFKHmwkjAD8VjwL82RW/+SKXAwFufApcMYKr?=
 =?us-ascii?Q?PJisq9GAEtGYEgiP2YGhHNr3DkG3/OAACzvj8Vxz+AAOB3Slr3ehSQJMXx6Q?=
 =?us-ascii?Q?ub+6qUiNqA39qOzkOXHA/mdb5usVkdfI1MIfZun+5bePX3vXFaCdIBFJocG0?=
 =?us-ascii?Q?r7chxQx0LB61p/WshBEd2iaXLs+xuaIQOvu/LZm/ScBAHzLguRDMtlnhU2X/?=
 =?us-ascii?Q?6pcDZb+d262rspL8/V6IVgW/ov5GltxGPCH8TbqgzbtKyJMQkyhVpPi1Ukgh?=
 =?us-ascii?Q?qx2iiMXyysJ4oF3p8JPZnOHSt/KZP2Ol2ol8f08IwTdoF/nQ39ADAkx+BDAF?=
 =?us-ascii?Q?dh3/f1P6sd08aRvDuu7ikLmQU32OVlIdaZZveOArVzhCpJvoB1uwtf4OgE45?=
 =?us-ascii?Q?Hd4lNLPVf1Cvl1EdUT0idLT1VoZ0nnNdc0zShTWn3bRA+LhAUJflIAh7DECi?=
 =?us-ascii?Q?AUwa5UBYsa952v4tbu5wC9SDdiUIw0o0N0XXy2PDDuGoxQQMOWUrAeZDjy7L?=
 =?us-ascii?Q?A2+Bk9ZdySGENhlhTdHSt7nNn4r5tjnCb7fdjV21mnIHa1wFKnyw9v/SmlkW?=
 =?us-ascii?Q?d2DftuHV9rgHTJ7iLMuBHRKWm0PnlZyIHW41V/qTIndeFyxKGWCAatNZQCKZ?=
 =?us-ascii?Q?KH+uPlCdbQ+j1mBoLzCq0+/4Taf9nqXj0Y7apLpif1vsBvfclkHOjpQOxbW1?=
 =?us-ascii?Q?nnuYUvL7E76lgX+jvtzgM4sN4TERohsY+H50Z5LCze6RLUpM6QpGKgfl8iJA?=
 =?us-ascii?Q?3JYVYnv7GMlIG6ARSVBj/mmmVeFArQ53Y5E0cjUvJY473iNs4vCOv1riSdK/?=
 =?us-ascii?Q?3eV5cYurONY/exgItePTCWiVcsipp6ciwNayZHZAKS9UT09CiOAMn9JAV2dM?=
 =?us-ascii?Q?3HMtw4tOOOj4LloBSms8xUD97hqTAzA3GuuIqA3KzmRHFFuagqEbqS9DGyaf?=
 =?us-ascii?Q?TK53sVyXhmkiB7C9xVYCE3HRgxzpm9uAPdCWPEj1B7LyjaWEsN/PsqOn9K2f?=
 =?us-ascii?Q?7kDp0x7Xkpxxld9LTdbsyqdoaqD3+ONFKbnqVKWPObBLxeqen2WLjRuMq4l9?=
 =?us-ascii?Q?5nRwdrA/+QHh7A5MKcu+bthOGOVE8yk5+vzB1JmeOJSf1SULL3PGfr3cf3RU?=
 =?us-ascii?Q?jkZAgfn1HatXq8CMXosJfX6xH4yq8xDtU06mCTkDP+eAtpddQ4WyPcXi/Mz2?=
 =?us-ascii?Q?NYvVGQoiw0FVyPZvHNebunRGwY9mL07EBqDRr/DsxegzI3UtpVWBHaaEiADj?=
 =?us-ascii?Q?ICXbFF6qEHecg5NQb7a7Qv4FU0hfvz7f0KBFdmOeDsr5nRYFZU9mmgOJnKqV?=
 =?us-ascii?Q?4WqvJnE+68rePG0xfbALphpMJ4Pyzz91GeElfCKNEtWM2t9g/LU40BwZiamT?=
 =?us-ascii?Q?k3uEf4kNtV9rfYaNWmvIqsnJIzfljtsC54GIuOvlpT3zW1YOF7Z5KqatOZOY?=
 =?us-ascii?Q?guRQ3Sc28i1rA4zpYEa7ygSKVLi1UY0AaQuYW53YTlTEoFrRwiyfg+cD1EkR?=
 =?us-ascii?Q?YI6E8v9dDoL3igwF6so=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:45:39.7293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7450e6-db12-4a08-7763-08de50f62e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
device if there are no active openers for the ublk block device.
If the device is busy, the command returns -EBUSY instead of
disrupting active clients. This allows safe, non-destructive stopping.

Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV
feature flag.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 44 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  9 ++++++-
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2d5602ef05cc..fc8b87902f8f 100644
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
+		return -EBUSY;
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


Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B54308F28
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255562; cv=fail; b=bosy26Dt1rZ9hKTM2v9nbbCs/4JD+dUs3l3X4ZwlttDsqNmrqky1PHlFTtKG4l0rIBHNZXM3L+F2dYZbeJWp1ABeMOeQEdHpEWHZ8IMqIhe96QKrKnGl84K3OX+BPr2SkkArDgRjT1r+FfjTqFQkGIk020HpWuDq7frYiwE9U/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255562; c=relaxed/simple;
	bh=8PRp15LTqPPdzvJncCx9jgM541ztF1bl7nuV1x2ZzLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrINnEh3pz/nEfVN456TDTlVYcJzuyJ6pMYvwbaxxhLfYZKAn3U4+afPRS0IzxNy4wq4FINMNIOjBQhdi341jp9n35pC3NJeagBJbwyManFG7SvrtLH6+D8sk7s66oM372u7pO5SvlfvuTavSSaDxGX62+/uLXK+J1l4mnUQZw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9ym5Avd; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9ym5Avd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN8YV6z0Hkq3mDnTxvtz5aXht2a/tkDxqKy5Yp1ljlOMTwJYFX7fekyCgmngGCm3Yw4nLv0ik4Xolx/HnU8yG8QxwGBx3M/Y4+SLZkleZ15Z6mD56WtmEmpcB96ye5/fNgPisx6DuX0mgRvOBk1Pp3SyxHojAMdJWqrAwQS+lJzVqE56AVURJCg6j3kCmahlyVaaamsMUtZYiGEmmu45Mdy5c1CrZGsk3uk8Hlld5zmiSnp3SdkXR7JZt4ONE2HidLeo7yToOZPfIOyRTcrLqF82zIyL7dgVWrLSQ6GHiX791ePyflYnX5u6qs2wX47yKfsI50F8xD4J0m6Oqg70CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDx3hG5glCtE71YSYLoyt27YpR8EW2KEshJe16QpV7o=;
 b=T4d7nxnjXTjKWRNwAnGvv1WD7FPnBg6Xi1zbsrTz0J4iP0A+T5/YfOAYkRw7Sj1T03xpq9PebMTae0fNK+WrzClIVu9xfp8PoCEi+Bo2WIL9Z3gz681AsZAo3+qtG3gFU1Fy71xqsJYuWMynwXOg0UzIbbCeR3MyXtRLXPSIvhf/9glgrEu5T1PKMb4JLT7UqgpMNqtV0Bor0/I1gvexiLsQcTAcQ3CodqBcc8j1/2qr4cNnvkeNj8lOG8rPYnQTIJ9mqB9AMdiKHax5aJQ4Qh7t/MGIzJFe2iZrjtu+XmO5HHzhp8rPe9BK+XWuIuXZG/BETemFAaUqc5wcbTkOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDx3hG5glCtE71YSYLoyt27YpR8EW2KEshJe16QpV7o=;
 b=k9ym5Avd4p14nY5jM+Esf1a0BdtEqXH0RRD9eaASKewCpFCkLkl2YWcQjrb7PFJCk9tQNM6wulPxMsUx+PS37InzGd3B72yYVbwzmAiYJOi8XhEsGWHGFrDeiIifbgDTtIvvdMXiJVLpjFErKkoDQ5wNPd4QWCEy/FTycCQZcarsP2E/rldguQZ9w+zAq/uZD1q/2vl01SuUTjQ/c3dyRJSiugkLnJJhXntqA9UpxrnA0wN9hfkcRMOdmQmZWyGNYK0Gy/sNnNrzz6AI21u1Gc5YVSwBE4SwaMAdF6gmiRc42nLlaxeqmXV0K/wApZIMmKwCBc3Uqfo0aO8PfWucgg==
Received: from SA1PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:2ce::10)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:05:54 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::2f) by SA1PR04CA0002.outlook.office365.com
 (2603:10b6:806:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 22:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 22:05:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:32 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:28 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v7 2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Tue, 13 Jan 2026 00:05:01 +0200
Message-ID: <20260112220502.9141-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112220502.9141-1-yoav@nvidia.com>
References: <20260112220502.9141-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 775f3718-7091-448c-ce43-08de5226c1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOGF2ZurHjJ0g7zcobrO71qhuxaDqp4fAtd2RqStr2kGDG+3af2C2pI67EFB?=
 =?us-ascii?Q?VBXMEKbC/buCzCMxzSNnSwk4yi4Rw6Q6WqlOaIyQVn3uahWuZ5vjcCkSlxlB?=
 =?us-ascii?Q?mJyYtl+0AcOx0kzQIBBne4OjM2vPNC9+IyG4b3dt5IYpzeOInrPpcqBKVcHs?=
 =?us-ascii?Q?qwTZ03gZ2rFFzXHGzCC7w3nibEEuGqwghlqIhykk4rqv6JUibP9+Cpp+gPp5?=
 =?us-ascii?Q?iPZ37/QEe7QPznJG5nBEQoI97PFTl/cFmRurHQxYFsES3LV7hInIY63Nl/n6?=
 =?us-ascii?Q?nRE8fiCGv9JuYVfEHEBUJpsfhqy54OEu1oYZtfobjd6Ajvcys7vzm0mP8KVP?=
 =?us-ascii?Q?2Ms5ue3io+ja7G4aDORwcdnYRq5JjUaU/dlBPaDWLKxu3waZva3iO/zrrE/A?=
 =?us-ascii?Q?Ere9g1FM1gf9+b7HZ18jRjqvF2lMYjaJ0nsKENKUlSSIM4k+1WnAnfeSAQdm?=
 =?us-ascii?Q?k+4ikPpYq/V2Ap2xVSl/dDZOXhMQpQ608aFVPSNJns8S7AUXajyb0UmN3Rg0?=
 =?us-ascii?Q?qeCC2eqaQFpz7tKcGzhS3Sjyb0scEmZ8RkEZT61C/cRP47DGLtb3qbBdxlDR?=
 =?us-ascii?Q?YrKdXvIXdQ6D5HKHQhuUN0Nf4mqlApcuZ4/vTmzu78Yrph15Rdq2dybRDLS/?=
 =?us-ascii?Q?YB+pxbYSLR8eLBSOxOWF9bX97PtMeSghl5lhuSob31vZv1g3y89m22AgzvdR?=
 =?us-ascii?Q?x9VU1nXU2bjfXS6tBPr5C04LVCGpQP4uD0/UAXxFFWhWwevmh4wkVzhZK46s?=
 =?us-ascii?Q?MEtOEbLXCmWxfgcRwDBXME9M1+R2Ci6TXGMQ4NXVJgNG8YckNSodmfXu/BU4?=
 =?us-ascii?Q?q8EfF9UbU93OHTTWV2VoubKARulhCcOin3RRJW3ZmFlfVm6IiCWW/wExL4bv?=
 =?us-ascii?Q?QJesp4ocFU6Lg3VFn2p6Lv6gfujUxcGaYbWioSMFPhOnDO3Xa6SARl7qLuxC?=
 =?us-ascii?Q?Lr57r4fgjg3qxS926XYw/JXdQqewS0Lsx02W6l5dJ14PuO3/cHE7DbNrmCfB?=
 =?us-ascii?Q?aB2WTuWjMLyhumi8uaNQeUxurpeednG5FNZWcBePYljRrDiI1rRz5mUInXS4?=
 =?us-ascii?Q?wIrKVMvgqcUQqF3DfeLMsfsLShNW05MTQGOJpKZJeO4JF6qcnWBSQQLQeQAE?=
 =?us-ascii?Q?xqJQLhyglMf7vgSZxaUrLSMJmm5T2lJAs5nH3dnWPzCpfWPlFUYmcrUywbv+?=
 =?us-ascii?Q?DZCXJuBf3ciy0WACG4i6Vwz+xLnB5bJybe3C5lCgEbPT8VJbs1Cp6DH1WKpV?=
 =?us-ascii?Q?jdncfoj09ZHqmWqjM0uJknpS8zoS+KRoHVwXtoSYxh0zg4yKwiyzWXMaHYKm?=
 =?us-ascii?Q?4E01HIflOELKuQqmF71+sHJ+Q7VYcQazP4Trt3qjygrX7i2L8ikjZiDSAAor?=
 =?us-ascii?Q?niHlgTJO8NYmPO7I9mMnoSgMN3OtW/SJSuowf+tZ+qfuTXF3zL07M/Cikflj?=
 =?us-ascii?Q?uOJMsu0ZUVFSxzmL/h0r4V/HTvFMkhm/naHHVXITEom7EozspYs0tvWKTnqQ?=
 =?us-ascii?Q?p/dJ3oMg4ociSn/rrfxSQ/Nnwx7bG1qT7HrfrZm86ox8yatCzSDqk4T0KwcH?=
 =?us-ascii?Q?V4pzuoEQ6uNjHFihYjg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:05:54.4025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775f3718-7091-448c-ce43-08de5226c1b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

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
index 73490890242b..aaf94d2fb789 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -56,6 +56,7 @@
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
 #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
+#define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -76,7 +77,8 @@
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
 		| UBLK_F_BUF_REG_OFF_DAEMON \
-		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))
+		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
+		| UBLK_F_SAFE_STOP_DEV)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -243,6 +245,8 @@ struct ublk_device {
 	struct delayed_work	exit_work;
 	struct work_struct	partition_scan_work;
 
+	bool			block_open; /* protected by open_mutex */
+
 	struct ublk_queue       *queues[];
 };
 
@@ -984,6 +988,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
 			return -EPERM;
 	}
 
+	if (ub->block_open)
+		return -ENXIO;
+
 	return 0;
 }
 
@@ -3343,7 +3350,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK |
 		UBLK_F_PER_IO_DAEMON |
-		UBLK_F_BUF_REG_OFF_DAEMON;
+		UBLK_F_BUF_REG_OFF_DAEMON |
+		UBLK_F_SAFE_STOP_DEV;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
@@ -3464,6 +3472,34 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
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
@@ -3859,6 +3895,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_END_USER_RECOVERY:
 	case UBLK_CMD_UPDATE_SIZE:
 	case UBLK_CMD_QUIESCE_DEV:
+	case UBLK_CMD_TRY_STOP_DEV:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3972,6 +4009,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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
index 61ac5d8e1078..90f47da4f435 100644
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
@@ -321,6 +322,12 @@
  */
 #define UBLK_F_INTEGRITY (1ULL << 16)
 
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


Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C126ACC
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725976; cv=fail; b=s58KJxoU/jsPP72OisWFoMlOJnbZZKzZ1Qu/+8NrBR5UB6cRRGQRXQIXLNs6uGLqwECvTPJ3pFuI2/abpiQZj0RYicMgWNN9aYPObeTYvwD46NccakE+ErslQKDs74BT2jSIPazAi/BLqJgF8+9V0fz0q0r0nBL0SQYelR8GdJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725976; c=relaxed/simple;
	bh=t/4+JbHzI4cy87VH45jktcWTMXYHMVVU/7TuFlbLfHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw4O37O7B8h/Kl0L/IBjs8KQpjuDEUOwPGXJsL9CoTw2xA84hFIEbvNTLLk32Nfc+shFJmKtNEoMbmyPMBgQzTiu1ftsAim1r793PhQLUDs6DLyFxPN0+xNNgctuPlYmaVEE712/ayHB+6UQrx/5OICiPWA8YxCtCdMypEg/8bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlobTUOh; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlobTUOh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRKtqzTAjNLvImP84uL37gIMEZ+U+vaOCTilRpMP5rbaiWcOR6Iwam4wtVTszQf9LLN/Vpgta9Q4bGDYb8Cg4Ny2+HjUfnsykEU4+RXaVLHoNfVCUDGktUZTdw1Q3luLkLgcTkdxOzh6CpAeSSqIG3omJfdMPXjZ/PsodUgh/emeGl2wCJBXRwrTdM/xuxfX1o/rrVs/Ka+9PJXx2wq/qAlWEQKO0UounJ7TWMvP4urjArxXEHGeJYB7xF8JasBkmMVjmSty0wSzGSQirH0vZDfoqvLURyGbLUDBP6H9MWQaBV6YfkiPNRhO/4WYxm3S8eBf7QPf/xx014L56kPRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7AvqU9Ew6rc3Yn9s9OT8HgltwTskElFfOnN3TPl/XM=;
 b=X5eci2MJ2hhwM4Tp3cC3lgTnJdHgciRLXNQVtuG+NkjWNJk+7lfeMkqXGYP+031o5Oz/VFSa3kR21JB0RiBnOGTk7zgov1r2BQzV2dzgsKfk5tGgDXS9GF3lgv+ojyBazTUheTCdduvc/gUq9Q3KHsVWM3/Pa7xyn27XMhFAWU/WeFk/ZxqJJhc6watRoPSW9xJqGnxisIjsZeX+Zn6u7FzHscpTl6x1dXUNStgI4OGyJZ4WPfoBbNJ65q5HOO6w2n7rou15yIb5sQ7lzHCLRknlXgs81jLagPQWKW6n9cG4s2kqQ6R4jnSIwxrCxHPBgDVR8fwLllL2aBlKROpaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7AvqU9Ew6rc3Yn9s9OT8HgltwTskElFfOnN3TPl/XM=;
 b=hlobTUOhtJOGXJ1HNf1gfew0b0aBd/8g0Z95jbiuAWQ6YDr9q/qIqFP0+0+MPY0mih2fvUVtrDazPyNHPc16oU7PgURC0FFbuz7k1xRaynO6b+93qZBwW+rUqDi4F5XiD8XKy4TFAAKEGp6ikrslEc4XL3TwbshtHJp62s64eW/i82XJT1OT2sG/Oi+qdi8BaV/1T5fGXtAmiXNg3ay02otQpoiGeZFrDHK1EapRGlj1OvuTNPNHASPGo2h4OMbURwW9ojj/WPC4Wj+l4onQf+kpDr7ain663bfsoIq4I3PkDvL/LDZfCbqbfYkZkUhh+E9xpMaNVMD3eyXs3+KgYw==
Received: from CH0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:610:b2::24)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 18:59:31 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::2b) by CH0PR13CA0049.outlook.office365.com
 (2603:10b6:610:b2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 18:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 6 Jan 2026 18:59:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:59:14 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:59:11 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v3 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Tue, 6 Jan 2026 20:58:31 +0200
Message-ID: <20260106185831.18711-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260106185831.18711-1-yoav@nvidia.com>
References: <20260106185831.18711-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: c79a97b5-ce0c-44f1-49cb-08de4d55b964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mLbPAOJjBJHo/cwo8avaQYJtqstLItoYFKaS0RP5V1TKZrv15NWaQbZMer65?=
 =?us-ascii?Q?7cImsW8TQCf+mlsMHEzjVWWxjJO5eNH1k9CCY5JwdOylaPgms+LjYXNH6DVN?=
 =?us-ascii?Q?zan8k73C8ZNsbsdbcGVALwMhRfGh3xrnuKECQjYmom8kzTgkSQefCPdXEOOx?=
 =?us-ascii?Q?MEtzUC7HfLLMuC1vRdPyWe1gMjWG3+FC84OuOBmTHZBzTZ9O0F8nVTt8VVn2?=
 =?us-ascii?Q?wDYBiA6eC+pF3LqLPDRqSttKQ/j8EK/6/roTDsZugkQTjBkGUCNZXIiKScIr?=
 =?us-ascii?Q?Fx8qzA/jzqq5mhrjS82JHCuvJS5qbD1/lHq3QkacXuOU0VEwMZOTx4bCLklB?=
 =?us-ascii?Q?8LkMkNXu83uB/onXPZ9Licep4y/BxUyROJSmIXg8BiE+iYjEyR4AF5KoKT4Z?=
 =?us-ascii?Q?mIAdEEp9E93npxntZTaXFR/Zv5rd6U/1np/tBuaidzMDAfmJV/iicp1Cw2vu?=
 =?us-ascii?Q?/4kGo78kQuNqG4n1Kqr/RjSV7GTwdDWz8rl4p3cXWtePlNVWqtEFToXZFh1/?=
 =?us-ascii?Q?eajTVrMyWuWJCIhBSS5WMIHKJtaOMvOZPh7E2GMG4maunL/m1rHm4lLQowoV?=
 =?us-ascii?Q?KL7WA6owVMoKGbTRNMprnQk+v/Lzesagq1jKS4mPh6f/s2NVIKJWYKxDmPbs?=
 =?us-ascii?Q?7K5YvHcLikoAnOPgr7XekaLP8Y8mv0pnSakOKrvuc4P9K4/BpTeW+TLIOaZr?=
 =?us-ascii?Q?jLjTNEDWMPec90lDBcKD8UHDwcOtTVcfRcUwn3fS3B82B/YFaFxnxLjUIOHb?=
 =?us-ascii?Q?z8ZwXADhXyKjX5m0mmD8RpwZ+899KOvRKmSb2ksHkq6kEDMFVLPbGJAjL5XC?=
 =?us-ascii?Q?rPT1cKqdRssLF+4XslXEvOHtnK+t5WjI0gqDtTCiddAQDod0e2ReEwRPzHMS?=
 =?us-ascii?Q?jbKjmB3H3Y6IWRjWHGHv0DQ5G89qVtWtEZEeYHGTtveOaJRJjLZ26KCqYlg4?=
 =?us-ascii?Q?NMXnrMUfKZKNUJpOy1V2/zvxWztW/+9nlBdD0QdC3g7isYnKkyJIA/7H7lzQ?=
 =?us-ascii?Q?tgLhU6PcXRQeJXtfLBT+60RIvwEuApvhLgcjrvEElWLiv1R39y07FZvzXR56?=
 =?us-ascii?Q?e1ar//3LgSU1zTXraZ+9jSrIEjbfqule1dCZjRIauo0um3gJe+xtOsOMPFf0?=
 =?us-ascii?Q?e0oL6qPldIU8+PKfsPVU17w7IktpR5kYZKuMtqnnYQlyu3Mc+71vf5AVx+EO?=
 =?us-ascii?Q?OeRPs6vtLmcW5beqsG3VZ+b20C3lYqif4jL/gAoYsNk+UhMSdA0IreJMx7ym?=
 =?us-ascii?Q?x++geHZjrMgMRiIxS3VMAtg6WmmQPgTTRC6pzx7+skZp+pxUvvCLabOJzEhf?=
 =?us-ascii?Q?P0nQ7mTYk0Sog73jDdEVAzoWAVdpeac9Gn0JKvHeqlbM2tnI/WMC305NNYZd?=
 =?us-ascii?Q?1280av5A2HJBfXHIbMngWbKJHbiEHVU7tuVFQSAWraHTfGQigNn6I8IYCpmQ?=
 =?us-ascii?Q?RQ/U5yaqgAN+gmO6Bt1UKpJiDI2ZYGYgpA2myc80dLanU5ilZKBmLdaV2eVw?=
 =?us-ascii?Q?Gx4zolj3/XhtNVQZ6RCk00QEDJh/y+bcT6t4wYWyKORYhA5AwBwUGn8rzuDY?=
 =?us-ascii?Q?6X6Xn/UcQNicH0gR20o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:59:30.9499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79a97b5-ce0c-44f1-49cb-08de4d55b964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
device if there are no active openers for the ublk block device.
If the device is busy, the command returns -EBUSY instead of
disrupting active clients. This allows safe, non-destructive stopping.

Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV feature flag.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 42 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  9 +++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2d5602ef05cc..9291eab4c31f 100644
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
 
@@ -3309,6 +3316,35 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 	ublk_stop_dev(ub);
 }
 
+static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+	int ret = 0;
+
+	disk = ublk_get_disk(ub);
+	if (!disk) {
+		return -ENODEV;
+	}
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
index ec77dabba45b..2b48c172542d 100644
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
@@ -241,6 +242,12 @@
  */
 #define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
 
+/*
+ * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
+ * allows stopping the device only if there are no openers.
+ */
+#define UBLK_F_SAFE_STOP_DEV	(1ULL << 11)
+
 /*
  * request buffer is registered automatically to uring_cmd's io_uring
  * context before delivering this io command to ublk server, meantime
-- 
2.39.5 (Apple Git-154)


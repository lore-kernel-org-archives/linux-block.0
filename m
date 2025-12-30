Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E42D531
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099148; cv=fail; b=YcCNLv8Oxy84dine1rIM4yk4Bd0muj5UmT8Pi7Dy/0OIGUUEMAL6hfxnzffZznaAzslpDbWK755pVX7F0sEE7qBjiZXGmSIEWhfhsml+Z1x5jPUi8c2zTM4l2KfPG0oLvF5ad4k0VmJlFaHV+XOk37UQNm8JG5yPcFZpu+2IOWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099148; c=relaxed/simple;
	bh=n2UU1NGEYgxVDPEFRnwY+HR+5XjnDs8UkL1z7kaprhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGltgr8/epbcpneSz6+f2mCGiRU6uUDlJqmOcZvkuoXc3VIwRHavbVrR7uOmbjInJEnvr/EyNU9G4CohjhHiuM2g9WOX2wxIYX3M9YQlQteRCZUtnhimuqQGr/hD5QDvxlbFtyDrUoHjRxy9ZTPO/hNkfsSN3l9jb2DDspihtfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHhZU+P2; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHhZU+P2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Il7LrGhgGmHyn3wifwwtYTESjYfWqiPxVdteJKorUqS0QHJRQeLMQjZS8vPIyeNMeq1HCd30WovPD2CA3SqlHtngFT3dtrfW6WuY5O4CswrsXOY5RjVzTH+NJFSrLS3Ly+pV7z/qbuImLIBKjnKaMRdjgliNdnr0kKKUNme+qsxo+kmXqIbOMjz4nVl238LkUxTEXTeKRjuoZlWg89JA0RMjGV796c2tKX99s+3/NXyW9nqQqV89IgtxW6RCewGkoDjQuDTUqERVuzou1+xn8TCdgmE3dB/rI3+uNZvQeKfBTyZs+Uq/bsbUGIqu+AVGDwWvPrLpdzyEkH9oME6jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZETbmJUWm6/G0lS/OL8yU1J9NVs9wtsJexCmlUuu8=;
 b=v6iTwoUQKDbgXcCF9BQ6rbeJK/OBkhjw7pwQohSoAHp6SGm6JzJ1LIfqJPU68TSAmLZU2l2A/7NLXEJlGLHDdhB/rvrchNu068on2bqwQgD/oarEl05dQQsaTpNKiF9TWQP2PY2vMsQopJynkv4wmD5uY+NA7ocOVZ9QEtW9XyQ89JtsltxcMBL8vBA0g9vUaG4VmknAIAsTsz4OlSmv8r8dkLNCMWQWenAIylg7I1RSSvo62cpVPQCVI7eQv40zS5grh81vTV1Gh6LqFweyxabXa9Q052g8OOJ6fp/wAQLx5dX9rGMRNAh6VY6rzeoOwEuz5w2E/YH6skCrbEnONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEZETbmJUWm6/G0lS/OL8yU1J9NVs9wtsJexCmlUuu8=;
 b=BHhZU+P2EHb1UM9LCNIX5SiQ9DyEPDPkl1zpcihNj+viVtjKlZ11oX8nevYvS/1gkn/GXbXAggjbqUey0c1tIxAIkiLMkTS1jP44yvwlxWN1USyHgGPx9BvKrP8mZmNe3WVShlDOyJHpMjq3MGklmgH9whZf9m5fxy46srynwLchYGsNZJhrETFfUBwVtSkL8aFE6s0dYgS5duL4DR/1G7+mMlmmyDRDHsA7us8jqR/w4Bw60Z6lmEWIxgDpevTVbWGA+DogczZFr1ZgbgsqyeA5XZ+UB+0QMjlwPvDTnumIpLwV4p59HvrhSL6jMh2St/pkC5fsuobgCwF4kU80Lg==
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 12:52:23 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::f1) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 12:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 12:52:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:10 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:08 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Tue, 30 Dec 2025 14:51:40 +0200
Message-ID: <20251230125140.43760-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251230125140.43760-1-yoav@nvidia.com>
References: <20251230125140.43760-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 27931ed5-481d-4b01-5f28-08de47a2469e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPEX2/Ti+53qFZUDBCS3hzYGkgv1CLtzm1HvrAJLd0J6cekj2Gf1K5i7ECgJ?=
 =?us-ascii?Q?708xGb6Hvb6eGUBu347JzwNgVvYi02cNPkVZ8NL5mH+JeLKIv+1XxYlAp7g5?=
 =?us-ascii?Q?GepDWxD2uHC04TaDzzc0Khxng/N/YOGnGHDnD3AqrrY5IiNbPCzfgGMlyyLt?=
 =?us-ascii?Q?LuDdgydy1Tpmp7eqKV3oVvXIMmkIzz14HcdXoQNhuTKHUtTsNFGJVBZpV5X7?=
 =?us-ascii?Q?68SKQOaoVd1cmnY7U4+2VgJM8V9EFRZhwTdOCDttP28t5UDGsf6z6Qfos7FX?=
 =?us-ascii?Q?19STK0zBXviTYKMuFQPvZkZjn/4RMwO7nUQNf5VQ92KG1pZZwLZ2VmbNcSaM?=
 =?us-ascii?Q?3bk3tLqhR058YoOwm8B6Dg3Tsd+L1/y5CN1axhTN77UZ/e8HDpGgwznAJdKw?=
 =?us-ascii?Q?zLr08XeKCzqjwoBw5eQq9nMNWHE2LIEE+jmSVBXhUpfWdalQISMJFXPLf8pP?=
 =?us-ascii?Q?yfgfSk2xk0lVRGh9nOrAb/IfbGpeW0DOeNYn2aQk+O51HRO03FYAulIQ/wGb?=
 =?us-ascii?Q?rCgfmrxwM5Atcst/spraZL6UUfFA9d2ou53OJnNVIILiRajDy4gOdMJnkz0d?=
 =?us-ascii?Q?1qkAc2rKJHYOzPOiAyp4GCXSDKsVFR0e9gjsCL5KHhVmKCmnZX0l2DyLUwvu?=
 =?us-ascii?Q?WWgyVWF78SbYFnL7JfcvA0yQT12eh/5Ehyeyfl61J6A2Z6lfx9jvRMFqx6DX?=
 =?us-ascii?Q?HmScTaJwU/E7Xhpo4nEG2XP4UVDtp3I6bF5LXpQPi9eT9TzyyemMBzBU9fE7?=
 =?us-ascii?Q?46DF3hWNEVyuKTqH8AsLxBshkPyLlZ8DpTN389sC3qB5fDpTiDdKovnP5XoG?=
 =?us-ascii?Q?tU0EVyEsaJKxQjmpJlKlcwQrNFxQDkMj8Nj3OQ/heCb0HhEqEUQ2kX5La1UY?=
 =?us-ascii?Q?EmqR0Nsu+DrHqSYRXxapC8KxAtNyBTFIuNhVDVN9Bd/q37VevnJ1yYNOO2t8?=
 =?us-ascii?Q?j7dZXdb4DSeAsum9J3aT0BqtA0oV4WekOxsDIXwTJgiAaWdz/MFEsnhZRish?=
 =?us-ascii?Q?R0F/uK5UvptUoWHJ/uXOd5aXwKtDCuMnMcqs3aIQ9LNHu82WufJaJrgZ7Aw9?=
 =?us-ascii?Q?dJ7rOpVz55+iD4ywLnTR/wU1iw9ebPLnb+Gm23u3PSjDUlJR1FmPKRHxNu2g?=
 =?us-ascii?Q?zrA9tXxkcPoZ8LzJjO/orHrGy3TP7EpW0Qy6oYCe6y1iPZd8pmgZa8pnZJa6?=
 =?us-ascii?Q?GYmi6RIWsd5jvXOd3GKFnpOC+vJANgUSv7gnW3vZvQDrBfZJyOMxUo45r4af?=
 =?us-ascii?Q?SpO4ZHJ3y067QcsA16B19rHgob1lrV+ytne9c2V88imGaOZqsHWJx8O6gJWl?=
 =?us-ascii?Q?I8JnAx6yeeSM6Pmu3XWvCaMYfv1YJZM49KqQGoJwSPTYvtUMymb99dfiVvQH?=
 =?us-ascii?Q?DRW7l2AdB2hcTU+zZ6142p+vSB0qTY6KOPdtnGAp+YyrLE2bUgjW8man8F9Q?=
 =?us-ascii?Q?X+W3KJBoX8AUPckkJZmbUvYxh98ALnqDCBvvp5Wo0+O1XDdpdTtIn9opyYDB?=
 =?us-ascii?Q?cQ1csZ2REE/tkQuzTVEZO55AlL+0WDUDQyAyD0Fy+ZZ8BXQlt+FFYX97BHxv?=
 =?us-ascii?Q?IXlwGo4kMIRX+6aywYA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 12:52:22.7386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27931ed5-481d-4b01-5f28-08de47a2469e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553

This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
device if there are no active openers for the ublk block device.
If the device is busy, the command returns -EBUSY instead of
disrupting active clients. This allows safe, non-destructive stopping.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 39 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2d5602ef05cc..7c4c920c35f7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -54,6 +54,7 @@
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
 #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
+#define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
 
 #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -239,6 +240,8 @@ struct ublk_device {
 	struct delayed_work	exit_work;
 	struct work_struct	partition_scan_work;
 
+	bool			block_open; /* protected by open_mutex */
+
 	struct ublk_queue       *queues[];
 };
 
@@ -3309,6 +3312,38 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 	ublk_stop_dev(ub);
 }
 
+static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+	int ret = -EINVAL;
+
+	disk = ublk_get_disk(ub);
+	if (!disk) {
+		ret = -ENODEV;
+		goto out;
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
+	ret = 0;
+	goto put_disk;
+
+unlock:
+	mutex_unlock(&disk->open_mutex);
+put_disk:
+	ublk_put_disk(disk);
+out:
+	return ret;
+}
+
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -3704,6 +3739,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_END_USER_RECOVERY:
 	case UBLK_CMD_UPDATE_SIZE:
 	case UBLK_CMD_QUIESCE_DEV:
+	case UBLK_CMD_TRY_STOP_DEV:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3817,6 +3853,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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
index ec77dabba45b..bb191d0afff7 100644
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
-- 
2.39.5 (Apple Git-154)


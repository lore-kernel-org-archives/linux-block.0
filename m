Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE7278161
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516559; cv=fail; b=t6R5ja4lCrwkDtkTR5Y4yE6yb6QsFBWvmY8YkbZe7A81vry4gL1ar7fRVHP/rX9lzv/Vh5SYbcthlin9AXsyaZ9+f1/c5US6gkwwop1+hV4yY9yahOo1t0hTBId54nIFkarHoKpZ1i5XOzSGX085uIhs0CNlw/2EBzDpz7P5qlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516559; c=relaxed/simple;
	bh=4q8ptcWeoE8J0NNba6oO+epVpH5gQWVczAeompUeN6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avlAwmfvLEjyi+MJg+77hUKNJnWbVDc3tNj2aHIkajbh6BLIbDOX2JahIUS3+ei20IXMESpAF5ul4Dc54/EhnCQzJTSP3oDZv6cfF3oUi0bbZrY2sc94At7FI4ZBGCR7GTvYHfg4ZA0yxqRfeteVc3pg2Tk8vJKzOazOssfk7rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W2/rzMiv; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W2/rzMiv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CptCe7rxd4puazytDeSdGhauyxHi20nofuLzjrC16YPC0JhwSzRkhgM0woul6vnMj5eYLV0OZcCscwg91SURb+UKV/jrq9FOluowRWV7xcYfON10xBnDytArky9XnT0ai9Ptz+hNtrIRYWfnbVLoNBAKIHs8FfRKkT7BoyvT9o+OYpwQkNmrEFXdifKJ3rl8U3KUcnJ/mV0YPd7QEND5+pj0wDXzigKWEJEJ9/0P4257TKMmDxc27EyqSQ0jB5tnzZW4YesyAh6bPz3WNUFNZqlNecpbYJqID8fi/1FDXNk0aklTMycDuP0FGFFW7PTpxMqq1O5E+Khe6ciJ7CmDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGaLPpzxdMMYyI3jnQ2etM6HrrvPGar2At71PG2EXJQ=;
 b=iK9UvwV9Gqfirkc0R++1zMEsgxzkf9XD5ogjvoaPK2JSjLp8rClY4pIhhS4tqq2sFr04cdepJ5yMWgWidqXErlg+eadskHXrtdGaqTWOxt1MdiY9w+tut3TtdJthmpUErpioCUrVqIuBlA/YZmIgPnpLwOawUkBhFkJm63i0mxeZGEs68eP+yIrywZqBW1oF9ZtBVo9FuiC0kJAXmLGou163aCPPNYkkLm+IqTSFYOoenxggarOPDXOtoGZsD7Q97JcyiomjcYffHFZHDt+Kt9RnyuWOW1SYdjE+Nr+7rxwp1athuMvnRaiavyHGrDSKC41nfuUuDmJuIE86CVfttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGaLPpzxdMMYyI3jnQ2etM6HrrvPGar2At71PG2EXJQ=;
 b=W2/rzMivlbIR4Z8pIrTgZn5rhgKFNEEanfPRsuC19Htyv1gMlsBANWSWUNha6DviPSf4hSV8eXwFiMTXTebHFoEyWKPonf4HynDTWwGKKJMoCabU099wnmBXPEJVym48QUqAL5HDVk8xtV5eHCnKDFFK4YWK36oY5/tTxwk52ZADCYLzEOKXyE+jfj+km4/6eioGIO6QCBip1CW+lkO99Sp21/1a29SOoaj7D2Y8OkN+WphStIul/tSUHS0DSbiSpoO0cHiJJXMV0AiQRx/7Z8dziWk2opiep0MZTAZtpoYyrvzB+I2Y3UqkS4LopffoeBc/xwz3QKJChyPT9EUZAQ==
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 08:49:13 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::db) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 08:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 08:49:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:59 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:57 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <linux-block@vger.kernel.org>, <csander@purestorage.com>,
	<ming.lei@redhat.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Sun, 4 Jan 2026 10:48:39 +0200
Message-ID: <20260104084839.30065-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260104084839.30065-1-yoav@nvidia.com>
References: <20260104084839.30065-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f5602f-3110-41a8-9f7c-08de4b6e229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LvAybqo5h08wTqW8kgDyDCJM6jzwqGpOW+ab+92foWZrmVjeHEX9otwzQFm+?=
 =?us-ascii?Q?fKYk1uAzx5xuvWKH8Qjxk96sqIeA6c0a529+eWbq1yhjS78GQhQ0ZNtKcFY+?=
 =?us-ascii?Q?usuOVGMnBDhy30u8wW/f64QeIl82pBI/NvW5/Ng0ZBWOUlANNK+gUQJ2R70R?=
 =?us-ascii?Q?swuvipuIwx/6R4CgCkXzI878iPWWxDR59MUoX3m3fl7QKgEe76M0pdPeJ+ea?=
 =?us-ascii?Q?qWhMeNdGfBpqMyzSRpdlwBgp7dTs8wre6lgBT6yWSSYL3L+bvaWerRHVkM1E?=
 =?us-ascii?Q?j1HqreMOm38uJM6HDQLVeXtT6x53I7E0RptKYpjDrS3X2u3p642Qoa1jU0HX?=
 =?us-ascii?Q?1g81//P8l5bHiKrB/s+Ynqs3F8BJkoQHdtY+q0E7ss/cxwPhhHG7JSHihK7j?=
 =?us-ascii?Q?m88OIE8QkAyJifM6c5ZRchE5Yfrl1gxDgVqDMPwANC2E8a6uSwb3xUMYOrWw?=
 =?us-ascii?Q?8k7uyVIO3CEfRxFU8RMHFnDpYPTl4uGEa7ZYTUGciWkCY4BHGo7elsPSb/Lq?=
 =?us-ascii?Q?R4jzLlmukHSKtyUWkuBQB/EANvPyGbaZpJJIfU4KV/ycPbQHlbHprGFrBVJl?=
 =?us-ascii?Q?LgN5ZaUAeNAnZ/tLYzjK777I/k4c6tcA62eIqF6J+fOgFufUZKjsfowGzHyI?=
 =?us-ascii?Q?PEwrBFX9K8hZlCEW44Ho+R7DPT8TRfDLsMeaEQJt8+zBBTis2+Bc0Z5EhB6c?=
 =?us-ascii?Q?lUsC/6MTuDGO1vUuQ/UHaj0MnZWwdEjhYWB4q429kJ80qen6unP3A4ZrKmp4?=
 =?us-ascii?Q?FUnYtuLByQovIENxW7kAisHUFp5ZPzhmVvpmAoryhz4QT+s60fmuC6Q3K64T?=
 =?us-ascii?Q?fl9DlxaNjEPLmt4czWAvwWGxMOxWTuur0R7kXajrhY5EF4Kd0m1r2xYBHIxZ?=
 =?us-ascii?Q?f3UrxLQmqiZ78boClwb8WgFRJFifzv4Obm2rX7QT3vVPZWvdke9NTNIqABE+?=
 =?us-ascii?Q?XMnuTDHNcTSzqk8f2hk2KpZ3rZVFyOoRAQlvLPRMOLzPR4kxilFpsUY1Tn4p?=
 =?us-ascii?Q?5DtrNfNNoR+0rVfb3mDGZrFcEelwBOWrGHny6e64jS8r7EYyEr6fPEaNuAzP?=
 =?us-ascii?Q?63DNkfIj8bfTNaS2zbaXUQL4eyWUXmMCSTgY2Y6xdIONG8XgaGzrQwoqtCO3?=
 =?us-ascii?Q?GNdRHJKAHPCKNV6x3wxz78RLBD4dwNkzz1doVTE+XSn7jcKfqJndPkCKCZMb?=
 =?us-ascii?Q?VGCuOG7BVgetBIEXSChjpYxktwrWMfWJ/83PqLb6+SHwv/MDC7m69QauU0nQ?=
 =?us-ascii?Q?IQEJjAeE2PvneYnoFkvrGeni8CcM4TMM75c3iNuQqUdtI+Fg6ajjVuhxyhqa?=
 =?us-ascii?Q?m4ct6eAb1VxVNEzEtzk1ZaxpYhjc8pPTAgCbLVe/ViY4n2JF/Yf2IWNJ8rLI?=
 =?us-ascii?Q?BWGJSS13g/lv70Ua0kZiBffabuPUdSZchG/8APE7NYPjTK4FJnHA5bjHaOKC?=
 =?us-ascii?Q?qAUyw5Y4IJTMvOwNXo2yYPGlft7M2i4j/qvVpSvQvUn8SIEWQZTpYFDhIX5G?=
 =?us-ascii?Q?GkUlFKC3SiDmRVfl5fl9iPMgOhk61orNEIRvuQxegDiivlBFtvDf2FBu5vGE?=
 =?us-ascii?Q?Rk3z5LMn3MbFU2ych/g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 08:49:13.0652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5602f-3110-41a8-9f7c-08de4b6e229f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
device if there are no active openers for the ublk block device.
If the device is busy, the command returns -EBUSY instead of
disrupting active clients. This allows safe, non-destructive stopping.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 42 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2d5602ef05cc..55a5ab11c1cd 100644
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
 
@@ -919,6 +922,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
 			return -EPERM;
 	}
 
+	if (ub->block_open)
+		return -EBUSY;
+
 	return 0;
 }
 
@@ -3309,6 +3315,38 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
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
@@ -3704,6 +3742,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_END_USER_RECOVERY:
 	case UBLK_CMD_UPDATE_SIZE:
 	case UBLK_CMD_QUIESCE_DEV:
+	case UBLK_CMD_TRY_STOP_DEV:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -3817,6 +3856,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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


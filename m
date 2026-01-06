Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415133B6C3
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731661; cv=fail; b=TXJzF3LHsD1mkH0oNlp+8J3oeHf8luVEsPQtnwGoxhjJQlMu1SNCpZiEK9EB5wbZVGFE67/uXh00feN6G+vs2UAjO+Wy10JbKNh0jzt7oXGvyp8cW0mwV0DzpPJX3zP4Bw/jjzhWmjx+Zun+D0CVSxJo5IiuOBPItK5GzM1g3iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731661; c=relaxed/simple;
	bh=HAGGWcTqJxIXnILIfuaU9WefqDvPGUqDNG17DVA9LUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwKRElQVyJfXDXuOL6yK6GAZY6yoqjTJwbOGKZz7y5nz/pGxQOXXsW4gL2vnobPLtOzUmB8pQvrH4a2FvrOMjCx1MbV6SLdgIvTOARca4RtlwiXfL+BSdxH+jizNZkunkxUo9WYQTNw6gRdk3K4HRMMUfjyl/h3Ovs3aItVH6ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sM8yllqQ; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sM8yllqQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZorzJkqHqlxiewqlS3AcNKrZdTxgsqCmQs6pmU84q160p+m95Sz+sRQhxwzyMnlfk/lvilWzoFoCw/ANbVM0sCVOsEOMZ7Lf1uUQLiApT7aH+xMai+iqNpaHZFT+ZB1rA3sOelajLIFNpY/LBOkjTHrxqCsZV3sHicna9ga1tjdWT/N6KbtllXKNGUwxqtpalJhi1rfNss9+Z5R2LA9+7uaIMWYFDc3XOMdzrXHkl8dGvj/cAGpNUZf8DrUJuoZIkyVAlPDcGlpJAX5F3cvVVM026dgtmriuUSxEVU95Lmx8tnOIS9MKXOQI5sTRhwI7ktnAK6u6qannEFY/a4UN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUN5kffEZ04g8xW/w9ry5LRpwwrfGayubGL52++5DCY=;
 b=rY5kU2cB/s01PqEHaTlS87VycSGJQvW+3X1OK/M7hihuA5QU8VqrAqsy/CMpRjgA89cOprov4YPXiHwWZC+bunmhB8D8UNQw+pEehSmd7ngTYc7ayzbMwhOhkdZNMhxeuG77jaAJQZgtKFrkx+jfMZzajQiAfwE+lf/czPmzz0UM2VoR1rITUkmk9k6ygDG2zTtnul2BTnrL5y33pBTMpAxUo17KmDX42lz5I4QULBgoMR6+CMsfHuo4arI6J/tvf52nZ7z3vBcKf/TFw7XygpiJwl4nuCm+tFCh7jSDEjdrE2BMlO5ELexK5iGbntXesbvRrcP7e4aMPtduKBLgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUN5kffEZ04g8xW/w9ry5LRpwwrfGayubGL52++5DCY=;
 b=sM8yllqQcRv2rQgLGtcjoaWDB/uO/3RygfWBrRl6Ha+MlRElltf17JKaUDORdSJs8BzE6Y4zBBwoAH6EqloIElopnr+jYpVn9CYDv230+guSAETqm+SrIyNY2OyNEkPONyHypVj2AXMdYrEUmVyZPrfdyIHW88yf/rPD6o2bvTwWZnd2fT5PYsVcyi8dVSBCcmSkVCfPIz7HjmBKG1lmpZYkZfm0M/SR5QL8nKBqPo1NwIT1ZCuL3mUBtfjXSa+bKT7XXL6l1vRKCItzJeIFyXZoFW3BDb2ivfsmgEPPXFsU4o5tNk3MffG+A0hJeqwuul0wAou4Zfu8tv7rhNSDtg==
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:34:15 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::12) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 20:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 20:34:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:59 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:55 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v4 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Date: Tue, 6 Jan 2026 22:33:33 +0200
Message-ID: <20260106203333.30589-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260106203333.30589-1-yoav@nvidia.com>
References: <20260106203333.30589-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 917aa482-bd6f-4584-81ff-08de4d62f565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wp1VCj//w09pQ5bJT+TcHhDGJo0fx4MyZ+/FX0j39EC4aKqreqyM+MHenH73?=
 =?us-ascii?Q?PutWRqQOL4Q8c+2Bhv/yUYyx/z7Vg+HERnYd+ToANrBNEt8+ya/19svzNJFP?=
 =?us-ascii?Q?e4He+APKxNEvG48IkhitpzpcJowHKl1GAR1xaKafvzr+kRp3XilSSSiUIQpP?=
 =?us-ascii?Q?+7RScvAUk5lHewZO2xBoSc/YjB3A4tfvE8U/VxYldOQo4iV3HnzFiJXvmTTP?=
 =?us-ascii?Q?RuewM5Pc5qF4v77c9VYNnct9YMBl4QTdSE1ny3JFYjLntqNlFQGVwlD519NU?=
 =?us-ascii?Q?lQzxfFZKKwekpHBJQRM6BKTc9gZt+s8jkCFJPcwYjF95wPx+36wqCXcJVhBT?=
 =?us-ascii?Q?4eFt3l2dG7pINdMicU2IKxOtN8nXVPKLpDTdn87+Y5nC1rnkEZN9Z0LoWeIc?=
 =?us-ascii?Q?jGHdBsTKDHxoRGcYy3XRTr+yOB8b5rxmO/+a5q8/iFm2fNG8Arx6IRa4j9HH?=
 =?us-ascii?Q?+wTw6O9SmDyph2vA/4Oj4O93dPpyjJ1PBSelCMGi6BbLtWDIfpfj1nKsUiUA?=
 =?us-ascii?Q?xHdA6QMR1Tfp2Ew1go5c5gbh/O5/iaIgfF+Rx2YPjEMU9n3s3tzEuINQJ/7t?=
 =?us-ascii?Q?hLOdx9TO9T15YuPAw5Edca229rr/1UYt+FLEiXm3cabI2yEaBRg+o3m+W+Xo?=
 =?us-ascii?Q?39+9uMMUmxjrWm/VIo8X9diNmXjGd/uArIZo7PSY7Tu9qrkyi/YKMp6yYO1Q?=
 =?us-ascii?Q?hxs+ApByn3d5EX5zwfO8xKXCbr6DL8Cde9VgPzHRy2J+yQDLY2qPtmxeET8I?=
 =?us-ascii?Q?dyMCXlCVwd4bhpjE1PmkK6o0QUqEeHoZaIz+R94a6U56xXes3DA+tCLrb3Xj?=
 =?us-ascii?Q?cq4j4EBnPh36jsXABsopZs2e8wMBCdkptS+hWmxjfmWj82U6+UJE/2FXWB/V?=
 =?us-ascii?Q?Rfr4tkX2hiInvEoLZNGNgywdwbZ9Bmp6akXGlPeY9Wj38khl/HXk2jL/SHcF?=
 =?us-ascii?Q?ID78sVLPCP1GWTawgHAh+LCu7E94AOFEGMBg800NgfrP75xx9Ijb63LMyaSA?=
 =?us-ascii?Q?Ek7Jbx1r6A+O/HVNN7s0E37ukPjEM2Nc8arT3I5Ho27Ff07whGFLF8T6CYxE?=
 =?us-ascii?Q?IczFpW6JnBTciNUyco5ih02LV7Pb8ywYCc0q89nbLNATR6xO8JIj6d1CA2Er?=
 =?us-ascii?Q?jXO8uDaeR1y8K3X3gnwSQ9VclKHjdjO63fg6FEq+wGvIokRVsjUGw/E6dQmQ?=
 =?us-ascii?Q?SGsBOI0XC8FjaUtfZuJfItzTz1wK2YpD2BBP2dZ9A9mAsdp//DbLxIXDdQP6?=
 =?us-ascii?Q?i/YfTxXJlRsENiCJCwlMpbw97k3Mx4BZAtfV2bUUKzNH+ve2NrnU2SR+hvh0?=
 =?us-ascii?Q?24EtUPWbdnXwL6eTDYuwYGLrXyV/rcyCIAVkFMTDTqjYbFrFlP6q9QguXrch?=
 =?us-ascii?Q?0t1QXRtuSfy7Dh3O9mo23w+/0fUMtCecl3Kz1MX4yi821PFpiXUGcgI2WCrP?=
 =?us-ascii?Q?jI777+nmWQ6wnQ6lw679p4vFsHx8OJenrDeRXogm7L+b4JDfZeCPQuMVC/mN?=
 =?us-ascii?Q?cIjHynB3Fle3NNSWLuk9fyy4m1iAUZdq7mr5YYKOi66uJFt8AlB12V8ZKpGm?=
 =?us-ascii?Q?BA3e6LynISwhuPeg2yU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 20:34:15.1102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917aa482-bd6f-4584-81ff-08de4d62f565
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994

This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
device if there are no active openers for the ublk block device.
If the device is busy, the command returns -EBUSY instead of
disrupting active clients. This allows safe, non-destructive stopping.

Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV
feature flag.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c             | 44 ++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h        |  9 +++++-
 tools/testing/selftests/ublk/kublk.c |  1 +
 3 files changed, 51 insertions(+), 3 deletions(-)

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
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..6739e28c4059 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1454,6 +1454,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
-- 
2.39.5 (Apple Git-154)


Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CEC1C860B
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516552; cv=fail; b=TWMBA3ivKUPs/ufwQ6ELuxRT+uDDAyGY5pMdtHjGCgj8yb3X0KsfhDMyX2ZahJD3m2ORrLOEg9n9dNk7/dBrAJZFH9rbLaIDpv8LiscOfs2lMTrKpZou7OiNscZVtxbEABqUOFW5onu+MkbtsL7K4F9c8kl8c5OB7vEq57X1zPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516552; c=relaxed/simple;
	bh=1dDBWlnWG0B36ecFktVFGDiCl5JPCFyHAGmmiip8ICE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smuE1K5OoYHJLzoCC7ol/azmGReNNMbiVKHX0L6tqkpDU3lpsRnANb9umMertMaSIM44gzlH/sLWffgfYO+mDZWigS9RqbnOg2NY3XzzTolABc2vJ3oVTu1JpC/ST5XTNpTv3bRp9DyEsHGWmosHZt9i4N6Vq2eTz6NDR+y6yHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c382luoO; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c382luoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN85E5PUDmi1aFngglx87/v/m0qPTV0+DHvxE213RXCi0gUzAg0QJmMVzpzy4ZsGhVUSgBf1EAKkTd2FZOlNVa3Czsqs5ydNImYdpgxxu3DBleaRz4fGRRw+87NZWwmsUu45Z24FZWHoY9ocZTlTIuYTwXlrrA+DGBHQBYobgVlUF4EtEOgSGhlo0B8kcp3w42dHv48qIa/1g1+oNnpk7xcDkr+6Vn0dB7/y/c2dW6noFyQkgX2PPm7BO31FGXQC+62fqZ5r7H9OkmzDUyrTFvv4YhKfc9v9k75B+Fk1dg9sn+EqUsN9BNLde1Ps2G9q7HH0YqE5jv1MhBB9tsTuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBa1tm5ixGw8n+UiJ8OB0FGls2TgF3xKL0vqYAMO1XM=;
 b=HQCUy4f3jAqSmL7LarSzmh1JUuHv66Ymq7l9bt6wLFs0J5vx3pqPpIfF/4zLHPqUj9TpMUUo/GZkjVAjtNdt6LxWiFNUcJ5f3cgYpjegMVcETMvb6RjRvui1zp7aIU8QeICsk2/4LqkxZAtsn8PhNEVW7Syf7hQH706KgDZyAohNxfH1/fl9QFTe/rqsIqCBbOqREunTdEHh1ZmflMZB/JIzaOx0sWE/AF0BJ6kC5MevkmcKnGYjnvmuKDQfd6T43AygWGQDQia51cGlTwDm7qRx3TOyQM9532JWQXUD3Yp+wUCh6WvowTHM0oZ0p3lp0FaineuX+Kc/MrtbW/hUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBa1tm5ixGw8n+UiJ8OB0FGls2TgF3xKL0vqYAMO1XM=;
 b=c382luoOX51wyzsniBefGPj4mxbWEZT5TY/5IZ7kyHvTJm3a/Dqir0DETKM3sj6jgNSuNO/NDRjzW85GRmJDKEFFWeDqQc2CLUa+x2rqFr5BmwHypl+je/QjItq357CGCRs4Egl8rqRag8RLMMGC6lYNF32fI0XBSbTO+ftCb5SwJZSlxHmAPNnjgKAcvA2tL11jRRciEJ1YcFJS16GI9zwdxs6tyAgXhaQLhswb1rMhNRLL0m/Uje5WsFm3QNAR38JjvTaKlt7WYWobnUpcT5tHoRznj61tWRXLZ0VGFpxNPw9FkchOJFBs5aHnag94lII/Lx8laxDaME9tTnPqTw==
Received: from BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 08:49:03 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::e3) by BL1PR13CA0420.outlook.office365.com
 (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Sun, 4
 Jan 2026 08:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 08:49:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:52 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:49 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <linux-block@vger.kernel.org>, <csander@purestorage.com>,
	<ming.lei@redhat.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 0/2] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Sun, 4 Jan 2026 10:48:37 +0200
Message-ID: <20260104084839.30065-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bfd99c-74bb-4789-cbb1-08de4b6e1c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZI8TodBCBnYDdBZ69k3JTzB8s4532R9M+anpTcMxJpp7AXvQNLTI2Bpk4He?=
 =?us-ascii?Q?fwwrkulxSsRByoklGRQiJtK0rKOk8ZJo/m0CVdwZWNm9alZ064eOkmqArSVy?=
 =?us-ascii?Q?W92FP4EiI/+X+kUBL9G6PB0ChQSX9hd/X8Zad66KscmYQrzzHeCObaR08BQi?=
 =?us-ascii?Q?gESMAHyQOR28XZxK4YvcKFGNvxGjJW4zthjNFcjuLE2sdX6CRdEjbpynCYcx?=
 =?us-ascii?Q?XnvDDCBJrZeOp70FaXT4OvcHRsfky8trO68j8xnQLFDLNcvwokVjXj/PTsl6?=
 =?us-ascii?Q?+kcd9MdLm9Zor6fvhKXmXjpsnAPs6SP/Y3gLddYjl/vjvdrHRVmxipSY11RN?=
 =?us-ascii?Q?LikCfgwfUp8dmIm5SzV55k8oRS0eOvJxuoomKE5HNcAdaABxbQKUM2SLyDkK?=
 =?us-ascii?Q?TLd+fSxt3yYKotitGm3Tg66VcnD5OOKpGs0xPdYcXCkSKjMCo2p069kmbRxL?=
 =?us-ascii?Q?hAg3JY2yhGwqcMlNTQqPufn/KqQpeEgmAr40CflTzYw4juqqrC3zQn57w771?=
 =?us-ascii?Q?oQbBSUSPD3tIJcPSWiFWu88+yRq/CGHfkRwfu/e/zb1aukFHZkmnqeGu7kSs?=
 =?us-ascii?Q?SFxW/bFW2ihY5vXYXo2eJ8Vt5bsIQZNo2RcBAxCX5nDIqlCUcHd1Oau2zAyh?=
 =?us-ascii?Q?SKHj7D/glzaL2eoFR3NVUQVSdkbMz2oMxlKhQoT+LxmWjwkBkghI2ObD0tAk?=
 =?us-ascii?Q?MoZN6omECk21547Uwq/HRixMJc0X3TH0GIm+93pB9Xht+k6e83Cde/3jWorT?=
 =?us-ascii?Q?WUEiYNeBQwskxCjlFswrquJzZASq7p1cuPSvmxDUtgjJZHReXp346+g1v/SU?=
 =?us-ascii?Q?GwG8K8HB7BFm+nXoodYUg8avGfYu+zoFWXtefGvJhXtgIvG+y6rhnJvgwAFp?=
 =?us-ascii?Q?6pIkOCG9MbG+pm4qrZGP+dT6HHu/cRZu2tqSMGmUFFCZa6WWuymfQY49YpJC?=
 =?us-ascii?Q?ncwA1fMrY/JRBTDartcjM0nGi//sF4kI+GcHfNgujAAwccNzup3aoqd1hfiT?=
 =?us-ascii?Q?yUdf5Y3+977uHlatDpgyPneNzKgoYIYApKtpu4hiao2iEaKbOuH3aGgHmP29?=
 =?us-ascii?Q?QIW7OMxL5TWMh0k5q2AOSH19uw7+W7LKgJ2O9aMmJyEJlNNfnyX6w7eL3PRK?=
 =?us-ascii?Q?N6VTXue9TxSakWQ69qAw239pTvgEKW6J1D+5oBv1bknLiDOLfDO/jqRK9JiT?=
 =?us-ascii?Q?VsVsVXb9svVnDdgwwYFmnG+s8gCWYHVgZguT/GnykzizGXvpznOeWkFLSkdh?=
 =?us-ascii?Q?XlADVueCOAN9EsAedVKtX3Y2u87mnUssMKrxXHiZ3crQpk+/cUoMjK6VEi8t?=
 =?us-ascii?Q?QclQatXAY93ivZiLC1jwY5vsunyq/Z9RU5KiKXtwnXujce3aYclzEpFdWgBz?=
 =?us-ascii?Q?jhJ4sq3+/a54dyJPC3aUD+MwJQMeixmkYbwsJQKhY/b2iKJMA+1ROx8nwdFr?=
 =?us-ascii?Q?W3y/YwNsX3wm0Maw/m+DkyxQCBAnB8DvkCsM8UROW8CeC/lKp8kAfWvtC27Z?=
 =?us-ascii?Q?pFE8SY8GgDUKaDhExsQkEU7ZIBzxzFLInGMggsv7u/xd98EtwQW7NHW45MP1?=
 =?us-ascii?Q?nvJRESc8zSG+s12gnr4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 08:49:02.7300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bfd99c-74bb-4789-cbb1-08de4b6e1c75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

Hello,

This patch series introduces a new command for ublk device management.

The first patch changes `ublk_ctrl_stop_dev()` to return void, since it
always returned 0. This simplifies the API.

The second patch introduces `UBLK_CMD_TRY_STOP_DEV`, which stops the
device only if there are no active openers. Unlike the existing stop
command (`UBLK_CMD_STOP_DEV`), this command avoids disrupting active
users by returning -EBUSY if the device is busy.

These patches only introduce the new command and API simplification
without altering existing behavior for active users.

Yoav Cohen (2):
  ublk: make ublk_ctrl_stop_dev return void
  ublk: add UBLK_CMD_TRY_STOP_DEV command

 drivers/block/ublk_drv.c      | 48 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)


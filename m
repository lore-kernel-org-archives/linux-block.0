Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB232C21F1
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725951; cv=fail; b=r3ArOnk1cumf9lrzYS84ZbxBXm0OrAPCtulcF4aVxjmT5QKEBjkHlkFLjU0kB9hnqkjyiB92NSYkxD6rA7azEGUI5UDNiaRsafMkbHExzlVesYSux/3AOuGmsYbFbsNN59A9EMPp2kyPHCF/A6qMUiEb7wb5mmHbIlGD1+Tx7XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725951; c=relaxed/simple;
	bh=oqvrpd1O2OYQ37VlnWE5miTKrQjE2+sorPLZLRsl6tU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+Ksu8e6fWalPnkiSt8nUv4B48OG+YlJWqFvLlWNog1Oq5PxcSySISwstY9HzORsMmHuXRqotFic1XWSCTbIZCOQi6SUC6GwheyEqEvY7BKZJJdgsiR3ceyVUYy1KsH5g48UE9Nvtgx1vdkDC6La8lb95UJLjotVHsqdBLT9V5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyaQ7svi; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyaQ7svi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zudx9zJOSXNPxWJi2R0gjHrNF2a9M+zOW8MPty0GX8q5l3dXz7VQejc40nVzYnpFWHO7gkynmm9wzlWkFh7JbrMPC2nFJPu/eBtJ70x88LtXCBeWUKh+CH0CUe3feQXheUCYgS3RmTN9MO6bb7Wxl5+G4c0j32q45C+sfc9tDTwf/vXoDT1bJA3rfHiEDpE+kZuBrssWpMGiMzn7XC2eUHED/ebpMHUTEfuQD1tkEs81tpy7KZHDzAXlxujMmXfQ40aPwKlgb8oDgDDeUM/V0udVg9IUY+4RjbXmj1/gWfpGXNx7LrNQTq/92HrkWdWlGo9ltjtykoqBIicqhSDv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPkxFhj9Buh1yE9xH11RUNEROZGYe2drCjNeNk/FZ3o=;
 b=p0Zoa5DtYjsD3DDIpp9Ozth8ScyuQgM78iS39Cpqy0SMl5jAKAEBq4TDAi/PF0NuZ0unMdYfS/xaqly7reuqg/B6vOUiaZXtAjGkzOAooFUui0bSUUWxHCa/8bwoTCI//oDjzy9OplieKHePDihQ7v6JmwJXf14CtcdECAA66lB963HirJXIpr+vKxYixmqY9CJ35hRyX4ycKfUKmvhEssi7qVFqM+tQxRLWpc2vR8IIwxcOY92sFG+VD+HE/Vnhi/5U+PqmOhKk6V93U3u7NUDqRvecV9RKd0bygegL0QokmL8mUWT9miGmwganuaBPSdWlrJjBpUVFUXY86Jf4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPkxFhj9Buh1yE9xH11RUNEROZGYe2drCjNeNk/FZ3o=;
 b=lyaQ7sviGn0umHhS6T1fLabUkqdu2up12iFxiwkHlyE8IxPb6XbNzrXWr0LU2lQDIEJLOAprMkMMAJAqEJkAO8+NG4IwRtdnb9ArLf/H23O2fQzi4oWBaywpMKnfmYukiudl9nLPZE9ia4pGe57NC3Z7fhN7vLuyLN5jpnOYeruubA1cqIRFjEmpf9jrY736ZsD0CXJkEzOg5M28Mb3C4dITBat3n4XEem0RF2quPc7V04XCEOsMDEw0OZKtJa2BCJwBfZPapur/So0aSdXu4I5JVbyvvxF+AecZZB881I8cwX29Rtcfwiv53xDEozU+52d8+RosgimqhoesiUUpOA==
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 18:59:03 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::f6) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 18:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 18:59:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:58:46 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:58:43 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v3 0/2] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Tue, 6 Jan 2026 20:58:29 +0200
Message-ID: <20260106185831.18711-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f3210f-5836-45c7-fc49-08de4d55a911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkExY0k4MkJkUGlWNzdIUm1jbGRWY09nalg0dVZqVE5JcWc0bU0zTG5hb0w5?=
 =?utf-8?B?OThEUjIyaG8xRVQySkdiY3F0VkVwZnQ3YlVWQmtEdUJpbDl4YUtaOWhja1Fz?=
 =?utf-8?B?U3FEQ3RTa1d5Vmdsc29Bb0FneWRaNmFKMnRIMDFFcjZjUzl3bExPZ0RSNWVF?=
 =?utf-8?B?Q2xjNCsrOVNHbmlmS1Y0ajNqekp6Q2Y4bkpKUXRZQXdIMldPTHlWckFzdHhh?=
 =?utf-8?B?d1M5dEVuRlZ5SjN2cVB6SC9NVkVrYm85U2F2Szc3ckpsb2RRRU0yZndWVjRT?=
 =?utf-8?B?NU1vYjQyTzFiUktFUlRzZElJcW9pcDVYc29OcklETHN2UElxdFd6Tk92OUJM?=
 =?utf-8?B?YkxrRk9XV1lwaXM1SXhZekJVdURCVkExRFFvQSs5NFNDVmNCcGh0aVdWM20w?=
 =?utf-8?B?NHN4L1RlL2FucFJLMy9iTERIV0dxbFQzU0xLU2xkV1FnSlNiN3F6WFBaQjZ0?=
 =?utf-8?B?ejZqcmxNRmpZRnhueUo1c0ZWWEZBZUNOVWx5bnoyckRBcnVRbnhnWWJMTGw2?=
 =?utf-8?B?L2k5TUJJS1I2R2c0WWFLaml6M2pLYzVQUVJPeGVBOWttL1dhbHdLdllRUEh3?=
 =?utf-8?B?a1lEN0swWFpvUnp6QUlRdEgwVUxybThPbnl0T1Z1b2hRQ1dqYURSZXlkbUxD?=
 =?utf-8?B?RmRSRzF0eUViSldSSURpUDJTQmdxdC92MUFlWDlKeUFEZ0FVbmtxVHQwMVlJ?=
 =?utf-8?B?Y3V4K29LQUFOeTVtMTd4cXYvbGcrbzl6Z01DSkNlOXNLeXk0SFBBcEtBaFNy?=
 =?utf-8?B?MlR4Z01BdlJXRmZjNUUzRlcxbXJwWGYrSVJ6TnpJalhIczdkY3dWZ1BUU3V5?=
 =?utf-8?B?MHBkTmVmOHJJVjY5dnd3NDhYQjFpMVZaY3FCcUtDOGtVMGIxUWFWYUNNczlo?=
 =?utf-8?B?ZGptaTRsdU10VGRWcUsrdlQ2T1hNdGFzTzcyWklFYXBzWGgrZVA1S2J0UzVV?=
 =?utf-8?B?dHZ4NzhXckUzOWtGdi9JVXhYQVJUSW9LR3oyN2NueGtwd3BFNFpuNkJObUtX?=
 =?utf-8?B?RDMwaWZHRDg0WHlFZzg3VlRSU1Q5SGhUc0R1NmlmN1NuQi85ajY0Q3lNUnVt?=
 =?utf-8?B?MXh4aWpNYW5ucHJLWUx5QXpBN0pZc3pGZnlUUHhJZDdmblE1TGM3KzBUUURy?=
 =?utf-8?B?a2RuK05yVDNuTXdEM0FsYTVPR2JnTHFteFVpSWZQWXl2dEZ6ZTV3dnZCUGQ3?=
 =?utf-8?B?V1ovcjVaRjdrZUk1elV1blorZjN0azRIbzVYZ3Q3NlpWWjlsREsxazI3c3Ji?=
 =?utf-8?B?aGpBK2tUWm1QY3NxVGd1Y204azRqZ1FuMVVJZFhIN2hJS1A0Z2kzRTBFNitO?=
 =?utf-8?B?a0srdWxCajVYR3haMnpZc29MVTdwckU0cHNMenF2SVZQdEsvZlJYdUdiaXVx?=
 =?utf-8?B?VGM0VVVIenJVVG1ZeFNERW9jYzZvclhid0pMeHZNZmkwSldVbjdyNDZFM0Vo?=
 =?utf-8?B?S09rRFo1K1ZEaE5Qbk9IM3pDNEUweEtGMGpwYXhRVFNZZFJxUjh4QUZRcVM0?=
 =?utf-8?B?eVN5SkQxZVorL2FUUW9nS3BQakxMdHAxMlBpZk85R1NzSmdZb0xVMkx3c1FV?=
 =?utf-8?B?c0p0TUJvc1V0RzZuMFNzemtsYWpVbVdieW1jNFN3OE8wMlBQQ2laaStxWndo?=
 =?utf-8?B?TEJPVDFXclhwOU82R1N6Y0J6STZxRDFhVXBXdnZUb0I5czlpV3hFZFhyWEhK?=
 =?utf-8?B?VXdsTkJJRmw2NGtwaWdTa2dlczhmenh2THJJOW8xcjlvSDBuSTc5RVBJaDBQ?=
 =?utf-8?B?Qml1bzN4UndLZXBkSGhLVmZpR09ZdnllNU11ZERTRGxqYXN0TDYyN0dqRG5L?=
 =?utf-8?B?TTNzN04wQ3pwSW1BaWJWVnJEdE92NFBVdlROTlZ6amN2ek0yTFViNitzSFJ6?=
 =?utf-8?B?aUhQUGpLSGZFektWVVIxNnNwcG13S3hMZGVuR2poc04waC94dnQ0azMwM3VH?=
 =?utf-8?B?Ui9Gckx1Z0h3QjFJeFlPZVU0M0FTMUtpNUVBWlp6RTVVZ2NrNjc3V3kxdXhC?=
 =?utf-8?B?UEVzVkpDckIzaVppeSs2VXFsUDE0ZUdTcFR1ZGhNQkZrOFJqZG1nZlNmbngx?=
 =?utf-8?B?UndoT1RiNHJOeThZMjB3Zm9mN3lXK0MwcU1hOFhBaUJyZXI3UnVUTXMwUUNW?=
 =?utf-8?Q?1BG8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:59:03.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f3210f-5836-45c7-fc49-08de4d55a911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

Hello,

This patch series introduces a new command for ublk device management.

The first patch changes `ublk_ctrl_stop_dev()` to return void, since it
always returned 0. This simplifies the API.

The second patch introduces `UBLK_CMD_TRY_STOP_DEV`, which stops the
device only if there are no active openers. Unlike the existing stop
command (`UBLK_CMD_STOP_DEV`), this command avoids disrupting active
users by returning -EBUSY if the device is busy.

These patches only introduce the new command and API simplification
without altering existing behavior for active users

Changes since v1:
 - Address Ming Lei’s comments in patch 2:
   - Add a feature flag and some minor comments.
 - Patch 1 unchanged, keeps Reviewed-by

Yoav Cohen (2):
  ublk: make ublk_ctrl_stop_dev return void
  ublk: add UBLK_CMD_TRY_STOP_DEV command

 drivers/block/ublk_drv.c      | 48 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |  9 ++++++-
 2 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.39.5 (Apple Git-154)


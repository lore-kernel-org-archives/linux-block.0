Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A133A6E1
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731654; cv=fail; b=ZtHvHEg8x03dJnbE8kHlW4U3GOzyUuc0gDFMxEty0h8xBsFnGs4pFAseHaxDWTPY9d5hTQ/v+MRXe0vsBVxbQ6XBZBaydCyACrcC3IMJPBAPG8hu+X2OVI2CXdHmdyFSP+J8IKmm2tz6rpMLtT113NI/6jTNpgPeHdzyR1EeCD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731654; c=relaxed/simple;
	bh=hX3kjjmLDFrnJCJZxBZwCIB+PXMg4A5jNwRUPCd9994=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XPf5OEeyucpuMXcyTx8bCdRAXD+xWOF70OPcbD2jcRbUsag7qJprMQFd8C6u0hzMRnAywlQRgfzErSyRBuc0SZFYpvBl5mgcOoxDsyYbo+6gUyE49/WLHlcWxPb7sih7Cw0jLhaxmZ54Ly+RFR+8M2uIIV1q1r7XkmwvCjvQEA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUL0b37t; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUL0b37t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seJfjl9OUn2WXz//1+DwXtLYgze02H8AjVbknn/LT/hnrJZUfMOjtBUAybSyx1izhe9l2Wy8lBIPryYFDivfIlq+RQBCJYyrlyhrXwCbqXBhZ+aosPbP32e+0Aw82FEYmnHbacAu72pWY3QNZaXkH1pAQJlAE6FiqOl9Z77swWaJzC7rWJe4hctdA608zV8i/husgWprDsjUNfMJb7aF0D9QZluQcQJyjh050XmjQV98V6BgxGWgMG7G06tKmWKsL4EYSlu4RIgimOISjXXNdGi1faSJfthr6MmbqSkWZOjs0DvC5cI9BuH0R7DqywMYaPx/vmhQYWhXOSaPjKOTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVVXV6oz+hWkNpku2peaT0/Nq7mCAlDcw0O+5XKHYiE=;
 b=ZrYsnG3hmOuwEGIfa7tbAuWWNEYcHxNusNjlxOvwWUavr+hndCVL1E1a3OS31hdR21NhuLzWqPJawsdsDFzdIxtWQ6x4jhdqFDG5+MIWkbnuRpUQsyXTJO2IpyTnnGInL3Hao3cfmf9BDBy+l/sXv/NI0kWc2iCt/lYyI0RqBMFEKXoGb0r8T/BedYirByaBR5rNuH2Elt8YIO6iiPKddH4m5d4y0JPiF9Ww//QI4tmNTo4NCyUxxSsJQRJOdjPkTuxKmKvV+YQPiSLDAUQ6UUAOUzdKsmeIx38o8CABVIi1oPK0+t1PNxK8ARAFVi/WYDPO4CmaIdZ8BLqqE7z76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVVXV6oz+hWkNpku2peaT0/Nq7mCAlDcw0O+5XKHYiE=;
 b=oUL0b37t/hWw+noVBVJRK+c4hnwBdWb8VPCebdoIKe3rAfoNTcIlrM6ibyP34wB0PghRn/PJ6o4dfF3zrtuaGUi4m8z0OOW6I1vvHco4veuJofZeSb+Q4eD5CeKujYY6DSUdZAYZ5dYgQi1XZBtoSXGlDiwy5icw/DYiWib9nMR5o8GRg3d8SM2PyE2MBfrgcOkGfTsGFTYzTgEMdHH/zxqcJlFv0gx/4bCdgfj8IaR2LQRL5yrsSDY3MrJivc47um7lNWLHf2BHizB2mst2KJE7Feh+/tA9Z3ANB2hS1qYrdgeY8/g+KnYitczTwmAf1e61MoGeB5mLKoD7qO+AIw==
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:34:06 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::c1) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 20:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 20:34:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:48 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:45 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v4 0/2] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Tue, 6 Jan 2026 22:33:31 +0200
Message-ID: <20260106203333.30589-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd6eec4-b9d5-4528-4d14-08de4d62f06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0VXcVZCajlSOW53VE9DY0JuNjlvdHpjU2Jpd2JKcHNiTXdma0tmdEtWbjRW?=
 =?utf-8?B?OFVnbHRkQUVMQmxkTU9SOU1pdlR0ekFpS3FGVmhvQmZmREp5aW5hZDN5OFlI?=
 =?utf-8?B?dDNZdHRGc2JaQXRWOTc0N3hSVXp1SU5QZEQvWHV0MjdBelAwL1hDblBXdUpo?=
 =?utf-8?B?V05oV1RUaVFVRzBoZDQwZFM1eWlVU0JTZlVadDBFb1dlWXFCSnoxKzZHeXF3?=
 =?utf-8?B?SU5udnFIS1ZTTVlRMm9pelRYZnVBUEEraWF4dU5UQWMwMThRVkhKbEFvelZL?=
 =?utf-8?B?Yk5iWW1zOWFLRHQ3WmljeDRsd0xvMUJwSHljWEdRMlNNL1BNam9ycmhqbm5H?=
 =?utf-8?B?N1BmVk9IQ1NNa3ZUWHFNemtLMHFuZ2hudFU5RXlJNkRLaXJnK0ZIdmJlVFB2?=
 =?utf-8?B?NEpHS2VvczMvb3AzNnpJeDJJRHQ2VFFzem1KbWZvZkhPRktJTXM1dm14Mkwr?=
 =?utf-8?B?Slg3Zm9Ba1ZUZnE3TW5iaXFxM1dnMzQrOG1kb0hIZUFPVThFOG01NFVRL01o?=
 =?utf-8?B?aksrcFl6MjEweGRSeGtBNFdtR2ROanN4TG90MTNDdG5LVWEzMHVHQ2h1REpq?=
 =?utf-8?B?a3VpUW9CS21hODNZYkhIbUhYSi83cDFXWUpCcGFiWDdWQ3l1S3pTdUREU21Y?=
 =?utf-8?B?Zi9YL2p2T01Ydnl6U1pDRitxdGZxRlk0eXk5Z2o4TDRmd1RJRHBuUmhnRG1w?=
 =?utf-8?B?dUxyNnpWczY5aXZmemc5andPYjlreFYrNE1ES1k0dEh0SjJIREVsSXFuYlVO?=
 =?utf-8?B?QkRSUGpDcW5LMFhyZGJPUUNtUGVpMWRJMklEbHRHdWYvTTJqK2wvMWw5a2lJ?=
 =?utf-8?B?bTZUeTRVMVl0SHNRU3FZem8wcnJGS2IyYTN1TGV3eEJqTDlkZHhCZ040bVRy?=
 =?utf-8?B?QWxPTHNaUmZLZGs0Sm52ZTQ2TEtDbjZWVm1GZGVKSXU4MWJ6TE5hTTc4NnMw?=
 =?utf-8?B?RElzUmwyTFhuY04zcThwbTBBa2JLSVQxOXFtdXYwanNHdmJjK05nRi95Qy9q?=
 =?utf-8?B?ZStBMnhFb0ZzcjByYlNVdFVoYkYvclZGVkQ1dWcrelp6alE5NVR4azg5dlBU?=
 =?utf-8?B?RTlhMG02YmpCbHhqeGJtMHJPNUU1MU5lZjJCd21iOHZzSXNPZjdyY1FKRXM5?=
 =?utf-8?B?WFIzQTFDcVFzU2FvTER1MDNlYkl0SitzbUFJTzVqcW4vdE9IVnlNRHFLQUl3?=
 =?utf-8?B?ZGNmMk1VZ0NEQkhDL0l2akVncEZRRjRJMDNTSHJ4OUhjSXRMalUzK2VIQTVw?=
 =?utf-8?B?QlM5VXNxMDZaZFQ1NnBieTd4RWxmaW9OMnpCSjMweDlvRVYxOHNtL2Nsckwx?=
 =?utf-8?B?QjBjWGJMYjIvQjVRbzJ4ZFd5TDU0SFpyZmw4VkV2dExCZUgxV1VUeVRyZ1FU?=
 =?utf-8?B?R0RqUTljYXM4a2ErUTVqRWFkQXBRZHVSSW0xNVFkbWVuMGhlUFdvZDhVT1hl?=
 =?utf-8?B?MDNlaWtWZldCdHFlRFc1cFhjbmhLZmdwQkEyYWJBQWRxWEIrYm5uNTJMV1FC?=
 =?utf-8?B?WmpLVHJrWGhkOENhRFQ4Y2VSWmhHNkY5RmVRL1hEdUJoVE1ONTM1dzVXSXNy?=
 =?utf-8?B?NEl2REV1NDF2WkQ0UUtjejA3RTM5bmNhb1ZhQkJuazE5NnNvK042ckpTNnVq?=
 =?utf-8?B?QVR5SVRyZTczQVo2VEZKNENGZmcxYnJHY2g4QUx0QVd6V2RnaFB5dHNoL2ps?=
 =?utf-8?B?SmpISnRzb2gvdjdIMnNjM1dRTHRER0tFRnlpcFprcThTa2RIejN0WDJtK3lZ?=
 =?utf-8?B?TGJ6Y1NJZ3A2WXNySVNSenVwY3hUZVVzV3R4RXVOSlF3SnZXTktwMi83RTNz?=
 =?utf-8?B?VDhDc1QzNmRxU1FudXZHR3ZiaUFtYTNRMkxVaFkxbTl2MlY2MERROXAxY09s?=
 =?utf-8?B?VlM5Tmw4b3BFa2JtTjF1eUl0bDE1LzJyK2RjOUh1RUxCOGZHMzVOeitWenZ2?=
 =?utf-8?B?dHQ2bmREbTZSUk0xZWFpb1AxU01SV2l6WDVlY2hZMFNqSWJUMzZaVGdKRlNa?=
 =?utf-8?B?THhOcm00SlJJZzF1NEd2bnYxS0pYd0dGT0N0WmlzSXBLZkw0ejcvbzVxaW0v?=
 =?utf-8?B?YndNRk1MTTJaejJiWGRaZXJlbC9QVGNidjlUUkNzSkRHajlIK0h0enJ0aWdU?=
 =?utf-8?Q?w5bo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 20:34:06.7504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd6eec4-b9d5-4528-4d14-08de4d62f06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

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

Changes since v2:
 - Address Ming Lei’s comments in patch 2:
   - Add a feature flag and some minor comments.
 - Patch 1 unchanged, keeps Reviewed-by

Changes since v3:
 - Address Caleb's comments in patch 2
   - add to kublk.c
   - add to auto features
   - set feature flag to 17

Yoav Cohen (2):
  ublk: make ublk_ctrl_stop_dev return void
  ublk: add UBLK_CMD_TRY_STOP_DEV command

 drivers/block/ublk_drv.c             | 50 +++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h        |  9 ++++-
 tools/testing/selftests/ublk/kublk.c |  1 +
 3 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)


Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728B238C3A
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124733; cv=fail; b=ZSOzd3DOMEs6757UzZYMrrVXrVEWotAABz1o8AIryvNB0ETxwDbHmMDb7Jk6LesYj2lVUqO4o2OzASq5/QMFBu4sHBLDU02qYAL/D+ylAjM7PGbeGUF1XfB8F39v8EkMLgQYLq1LXDFMRGYWT2QXPHIYPAk03C3RCrzuvwFbXj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124733; c=relaxed/simple;
	bh=CjGi6oYJM+py/Uw3uzkcEkL2RizPvu8RXQenun7Mf70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GiZ66iCfVGTUkQjlU8W3vip0go03Aqc+buCUZ7fXdRTrKOwXdCnhDbT0iCpDu+rShSc6pCOX+uubatm6nzBR8Ukisdm0G9Qnvc8b4d/wPmcbwHSPc0X/lZFK7zMFiXg4KMGFCwN+E/rYw9Uu9WzfJe/lcPsvIRYcR3U8NJsWbZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m2QpDz2n; arc=fail smtp.client-ip=52.101.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m2QpDz2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMv4vgFXYSbtJL/SYyARDtEIZG/sdlG53ApcY8NTElKKmKkacwHAEjVK4NUKtvMlbUIBceIjiKEa+/KhbfvsoCsvY522YT8242tPGr0mXlO/82HBOYnQJmzYec6Xh5QB3gsu3HOUI637KJgGGffOHvXztnMn/vdhqiPxBMUqh2RJSh8LYpxb3yBip2lrCWZ9FZxkqyWw2R46nqv656Ka9ypauvlBYb/zruM0aKVZDP351PrNibcZ98TFTCRCi7zGpr/nZOrY5AO7ZaFUiPfcVyQA82NF7rciLCoO551lnoLJk672QqO0ZrH4YOjCeIA/C1mu/0H3Ey2Zq7pF7ZDVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSwMK4AgNyV7LKYC893FExaAv/yHy8Xp0nccn+VdMz8=;
 b=WEBMun1a+8vw5sooeFC7aOjm0vFKscTGb32vXPYGVts6h1OX5WYgFiB8ga2obtvtIkp/L69hr9WvAarX1vgxWREPDsvGvsFhTSyLKEl0Xb/M4+YWzNloDP9o46w68vwPojgNu0QDpxl+SDOYzsRCUCz4JhuGBWEt7aBL+DfYK7c//rs6XeYyMK6WDJAnI/zCKGQL0T6742V9VrUBxMfYXfNFEC9p06W2aCgcRKAhFp806+vTFf8WGYZ8wtQsyGvm2FxVmau9wPO1yq6UTkOKc4TsINEZKPDqpFQBsrasdbVoXFU06UtNxKr88oFdT12TxFaUBy7920zu0W4yVDQk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSwMK4AgNyV7LKYC893FExaAv/yHy8Xp0nccn+VdMz8=;
 b=m2QpDz2nUmXAECphltmm2bz7fRlBN8SoQEDhv/m+90tQ0DwRP8gQv4n0MeGvaesR0+OeSb2EbSVg3kMJTbbeaDP89WEagXj0cUcZ+M5BNoP1TFnCmAdivlpKLZ9QD0aTALhVaJGEnMyQwpTtG5YnflymGgaq4oSR0f6xKYmSnsplN3r/dUe0s6mdAofOVjTmDZpW8AXyloIUPcnn8xwkBP+myuIeOMBPYLXsTo9yIBDURL1hpbTGdBTmz//a3hnnF5J7CA/Mu983QFWDcaXoXHcMx+bS/BZ1zt1Jh6+gF2cC2pl+pN57XfsUDaQNEXO6E3CqV0j0I8xm4HzbbPKkRA==
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:45:28 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::18) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 09:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 09:45:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:16 -0800
Received: from yoav-mlt.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:13 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v5 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Sun, 11 Jan 2026 11:45:01 +0200
Message-ID: <20260111094504.24701-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b077eb-0a7b-4eeb-5f76-08de50f62737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVp3ZHRDYUZHUVZDdW9ydExXUTFzS3R6amVxYjhnTVdSZzJ3eDdTNzNMT1NX?=
 =?utf-8?B?NnZMVnhqM2lOenV2WC9obHBydXE3QnBZejZwaHI0T0NsLzgyZW1Qb2tsS2dE?=
 =?utf-8?B?NDFLdUZGUVZkc2pUZk1vbXN5RC9pRis1Q0Vvc01NNC9EalZTNmtwMXd1UW5Q?=
 =?utf-8?B?K3B2TEhXV0wzWFNubXAzdDhhV0VTdWpzZFRQQkZBOEVvMGQxa3g0Z0phUXBT?=
 =?utf-8?B?UGJVNEd0NHM3dDhnVmd4bkZkUm9KU0NmSEROcjh6VUFLUTlNVCtzcnZPZ3Vl?=
 =?utf-8?B?QXNJWEZKT1VZeVlCVkJBLzVGekhRZGdtS0lkY1FFQTJXZG1kaEloaGdGSUU2?=
 =?utf-8?B?a2k3LzZ3UVZjQ3pzRVVNNWMzRmdRY2lzZ1VGZ1dYSWRReWpFcllpSjl6Mmg0?=
 =?utf-8?B?dmNKMHRLOWMrb0JoejBWUlE4cVNCbEdKNUFnTURvTFBWU1MzU1JFNEtERzVX?=
 =?utf-8?B?T2VsYVFlSzR6WGg3NHVjak9KK3M1eENQYmR0aEd0amxUZytXaGxhSFlOMVVK?=
 =?utf-8?B?emtUeTZ4OVBoSlZBQmxMNXc5akEvSk45eEozZzZEb3FXdW9sZHYxeVBZa2ow?=
 =?utf-8?B?SEliVVY1YVJScERqUFRlRDNySzBCL2NIU3BJTnN1S2hSZ3NBZFA2WHlhRDd0?=
 =?utf-8?B?d2Foem9JajZhamgvUWQvekhibFVmWWl1djVQcFN0NVdDU0o5T3BDQzh5V3Fm?=
 =?utf-8?B?eWJqZVVaakNqVlMyMGhwVDRIVEpsVFExb2UyN1dLallUV0hJMFVTVmJNWjNl?=
 =?utf-8?B?Nm13MWhNeDRGdmNRbmR2SkRTbEhZL1QwZ1RjRGZqeldMdm5kRmFhejYyNlk1?=
 =?utf-8?B?RFlkSW1qN29vVW1yZG1jYmlZZjZsRlBZVW9QTkdpZjY4OVZZWDVjS2VEOFFz?=
 =?utf-8?B?KytHdnJnTi9PMktnM3NYSmdZOEZiQllZNitwVjRaeEFRLzFwY3liQWZvSGNl?=
 =?utf-8?B?T05uUFp1SzdMd3d2YjkzQWpva3Zsb2JlWlcrTWt1dkJHbE1UZEtWb2VGcE15?=
 =?utf-8?B?ay96dy9TRUY0YU9NcEZ2ODEwWis5ek0xamM0cDZqdmNIN1g0SXhWQ3RISUE5?=
 =?utf-8?B?NlJ5K1ZqRW1LOVhiZjBUMXY0TlVrd1l5MkI1Nnc3aW5pV0xTTlFzT1cwemJt?=
 =?utf-8?B?aHlDMXM1akh5bjZGcGxHbG5wQmUrMHI0d0RrenN1RkxIZ1RLWnNxMURWVDJU?=
 =?utf-8?B?MmlBajg0dHRyU08xeGs1cDNrWGxWWWF1bElHdHZBbVFWR1FzYXM2OHo0bFo1?=
 =?utf-8?B?UVNLV2MySzVMc1FJTk12bUxzUzVUbkg1YnFsLzNqV0xZVk8wY1pFbWU4RmFL?=
 =?utf-8?B?VXVJYVRYQ3BwWU8xcnpoNlRVcXRWYVQvWS9ZMS9PWWRGSWlnVSs0NWlPcW5S?=
 =?utf-8?B?WGJlWEx0RjBjMVpDMHY4OUVUQm05WC8wVzQ3ZHBBQUdZTU9jM0hzbE1BMFFw?=
 =?utf-8?B?MXcySFFpandpZUM4VHdJeDRLTEpveXh3b1g2UlB0Z3JwY09PYU1CZENaekJU?=
 =?utf-8?B?V1lza3Z6MlVEd0h5MURwbU9sSG1kcHVGdk44T1p6cERCK2NHZlVRWUUxZUx5?=
 =?utf-8?B?ak9hdEFVdkpqeDFZNXhzUm1SVjlSSEsyNXRDZ09EaTN3dUVhTTZ3K3FEWlBG?=
 =?utf-8?B?c3ZMaWwrb0svSnByay9IU3k0dE01OGM0SFdqckNjVDg5anRkQ0RXUFBkZ1pN?=
 =?utf-8?B?YmM4VnRrTStEcHJPWjZFUlo4V0tQLy9DemRseGJhTXZMU3M4R2hFcXFsNzAx?=
 =?utf-8?B?NFR4Ynk5cWlNd2RzOXMyTDJKd0lsZGlRVUVPNW9rTjlod1FQVHp1bUpLbmww?=
 =?utf-8?B?OEJaZEtjMGtQcDZxcENIV2l2VWVOMHRxMnRpZWpCYUJnWW96NDJvbkM0VFht?=
 =?utf-8?B?SXVZa3lQcjJtWU9mY3BFbUpkQ2RFQzYxdUZyRysyMUEyWWhiNnc0MU9LaHVq?=
 =?utf-8?B?TDE0QWlneDlDeTB0OGIrdDJxTWF5cjlHWU5paWd3Vmo0NEVhY29UdGVUd3hl?=
 =?utf-8?B?blJpaTVJajFxMHhhQ1FWKzFNQi9jNGpLdGlLS25NcXJ0TlYzK2JZTG9FY3NM?=
 =?utf-8?B?YzJkYXIrMUtiYW1xRE04T3hFcitoVllYdHZSaVpxVnlWSFRqL2t3Y2taK0h3?=
 =?utf-8?Q?2Q+4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:45:28.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b077eb-0a7b-4eeb-5f76-08de50f62737
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686

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

Change since v4:
 - Selftest added by Ming
 - Move kublk.c change to new selftest commit

Ming Lei (1):
  selftests: ublk: add stop command with --safe option

Yoav Cohen (2):
  ublk: make ublk_ctrl_stop_dev return void
  ublk: add UBLK_CMD_TRY_STOP_DEV command

 drivers/block/ublk_drv.c                      | 50 ++++++++++++++--
 include/uapi/linux/ublk_cmd.h                 |  9 ++-
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 53 +++++++++++++++++
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_16.sh | 57 +++++++++++++++++++
 6 files changed, 165 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh

-- 
2.39.5 (Apple Git-154)


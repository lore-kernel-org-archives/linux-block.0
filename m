Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF9308F28
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255545; cv=fail; b=LjDtUWWJCuKBuQhN5zerU6zmrbB/KANbQa7++VPL69ev3Y7Qb7zTjYgNSPmB78WTF4WW7hZ9kw+J/N8ZZnc1+XkYrEFZjA/hEynDvuXnBMrVBo39dq1SxGAC0jXcGWjG//ez6fVDyehLDr1QaFudmcYP9TT4AhYzo4DArUVDnkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255545; c=relaxed/simple;
	bh=Rz9F8YT1EqSFeXUOo907EVbDCpk/hwyaHeWT95bHIck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbezbmIYwQH4qJgpVAiqzpzBLcqTOo7vYGJ2QVooO/p7dXhUWn1kVXYPQyO555bYlzo8tqnSErv3dSoKETrdAa9UQv67jLGiVxACSVusC5jonYUJAwOChH8E7Br1zzhiDL/MA397phSdchHoRlLyWA+Jx4VDuoOHDDp0mctNUZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYa7dbqL; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYa7dbqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zwgg/Bo51VJNqUdQox6RQih20IWVVOZ6wP6qppLVMU/NCaFPHRmkraXBj7fC1Og5jA6e0cnqvGaDVr+dzwrxokEKKcMuipheGpEdAtGPSgCBBNQim2zg24qxa8JdnQUGEq+IWIDXj6ptdOwS7mmaI9oXrX/AfHbtZ7X5141dr0Hey3ZuVZ83d0ylc6LcKy3rf9reOHQUArcvMfo9GaAbWx5jamr6wx9nl3xxT/G8Q7R8RuURd6zXN0teqiWOvilek/5VjkTH3izjeyYVoUe9eeBNNAfsKciWi8AaGJ0wz+nWca+yCenhAlUcqEpfMQywPmMyHzwVGBom2KOouFqoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VehUhpuVFCjqCsciA+YD5VBMBAZ2i3CwAwGOYiFMFZQ=;
 b=wiwpX07oJdcLBNyNUOGpCP1J4lToxnRRstdf2vAOBoivHyKRioSNEVlO0qhJ6oLfum5MiVWXbXH2dNpIWGQZNbFJdm2CqNhRJaBIx7RtKdEZr3TUkPe07HzSWge9tyA8OKGXrCSyvvqfXZR/NG00xbVHDs1LaYoOc0y3NKyZ0Sze65FZgm19+f8YBtIHmaVhXrL6gKeBsm8lqhBeWpteZdKmjibf0dRH8PwCZM729ip/e9UW6e4qKVPMSUUAnSx6jHhyK5El0e+iqG/DTAw5WBon6wTCTVZFBHfszkiN7S+4fR8OyjRz9JBSTfpMZjcQ0Ek5whz7fQ0WWD6TD2yBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VehUhpuVFCjqCsciA+YD5VBMBAZ2i3CwAwGOYiFMFZQ=;
 b=sYa7dbqLBvOpaK3xxjpnBQzcK3r2bt2fV4USy7C7kU1rS2dXi2hyVWDa7iTkzWY+8mcebjQK0jigfE0rHZKnsDS1Y+IK/PtKRjzdb4J9+dVuu0U64xkYhJk76nPbXl3XL8enpv9pEllw/hUJLJCMXGG33vB37Q7xXJRoCATasS9vSolJF30K+fFhmpN47ZgHvWi51+er4JZEzTlZujgnmpqMBe1tAHPukoAchZNxGIBPEHeUwFLE96HTEpoyjve9pCcx+q4hsOuKLe/Smg09HAI5dd/TOqStxzWeVOHRe7ftZZGT88agWBYQhclcO9pfzMwshCD4tIUxdM2mYR9dmg==
Received: from SA1PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:2ce::25)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:05:39 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::73) by SA1PR04CA0009.outlook.office365.com
 (2603:10b6:806:2ce::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 22:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 22:05:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:20 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:14 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v7 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Tue, 13 Jan 2026 00:04:59 +0200
Message-ID: <20260112220502.9141-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 99add20b-bd0e-4443-fb36-08de5226b8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFDMnh5STg3YTVtQU4vTExxWm1xK0U3NXNPcDlDM2h5UmdCMzl2VjhYQW11?=
 =?utf-8?B?endUNjJtVE5hUTJQQVFlckdocC9LZEsyQkpVSmxadjRKUVZMc2w2bmx0Ujcw?=
 =?utf-8?B?djZjVlhpU3ZpVFhrY2xzeGVQOGJ3ZlZsRVBvb2RYNGszT0R0M0E5R3VLc2l5?=
 =?utf-8?B?MkVaMXg4RkUyT0tzVjhidjJrSmFKNlAxTHVkVUlqVmZBSDBoL0Z1RGxLL2VI?=
 =?utf-8?B?NUwwUVpBUm53VG5wSXZKamJTSUJvOENtR1BUQWh2cU0rYTRtd1dqa3p6bm9I?=
 =?utf-8?B?cWtFclh0R0hHRHF3cGh3dThaWFpaa2YxS1RpQm8wcWVOa0ZWN3V5Skk3WE5n?=
 =?utf-8?B?OFhSbTFYeDlmK0JuQWtnVGdsVVIrMlE5N2liaGdMZnhDalNia1MvUVVDTWZY?=
 =?utf-8?B?dUg4U3lvVEs4cnZ6UzMxSCtwUjVBN1QyZkZOc2F2clZFZm5XMGRNR3BNcVFN?=
 =?utf-8?B?ZzFGbk8yL1FJakJLcWdhMTkyeUo5YkRPTWI1Zk95YTVaVEgyNmpJNkhDNjVv?=
 =?utf-8?B?YSt1aGQ3SGUvQ09aY0lqbkZzTk5GU0NpQ29abldncHpycFdjdENtZGhiekNU?=
 =?utf-8?B?VW5vakJEbDQvZ1pBQ3lVZjBHM3VvSlpWZzcyUzRkL01jb2g1Ykg4TXpmSitl?=
 =?utf-8?B?TkdYVk9xRUtDa3lVbmI1NVRsaWpIZ0p0VWVnMlM2VlBNTitoTGIvMEZ1a2Vh?=
 =?utf-8?B?eUtOaGx5dTlCVi90bHJGZlROSDkvcXptZ1liR1lVVE5WZDhRVGxrSzZsVllT?=
 =?utf-8?B?a1Vodk9hL2ZyUm1peEJYZEdVMGpoZ0JQUnBJVTUxY1BpdXF5R1JRaGx6Zi81?=
 =?utf-8?B?ZjJxQk5yYUpKYlNYS0pIZEFBckJTUG5PTExBZy96dXd3ZFJseWNOaFdoME9P?=
 =?utf-8?B?N1hEcmhmdFdRSk5VYXBXei9UV1k3YWpZMnZRenlNR0Z1S1BiWmRMVmFSNVBQ?=
 =?utf-8?B?ZUJrcXVnR2xUZGVxUmxVd0FVMXZ5cWFrUGVWajhRU2o3Skx6ZUdaSFZZS2VU?=
 =?utf-8?B?Ujc3K0dnTzFWRzIvVTZsNnlFM3BBNDBiZFcwbldwR2hOdGFHNThCbTl4L2FP?=
 =?utf-8?B?RUpjMWx2eEVpeHFKR0ptTUFlR1E0VjEvRk0rdFJuUWNpSjZBdTVyeitVS2tG?=
 =?utf-8?B?SnBiZWxMZUM4SzVIYklVY1pCYjY5ZlNEUkFSNDkrRXFsb29QZDhqQ0xHY0lH?=
 =?utf-8?B?eks0Q0tRN01QKytDRnJDTitDc1JOVEIzRnBWTEMzMG1aZzl6anlOdmZRK2Fa?=
 =?utf-8?B?dGF2blE4S1A1aW9vTFlzMForRnNubnZaTmxCU0ZTTUo0Q2tZcUM2STFaVUJa?=
 =?utf-8?B?MUxkSXpOTlYrbVZPdGVLUXl5RGo2Z2U4d0dKVjlkTGdTQU5nckozNDdVTmlC?=
 =?utf-8?B?Y2I5YkI4cE51UWxleDlhaVRQOEVWcUNpMmdoYndlMDE1TmlLNG83cEEyaWUv?=
 =?utf-8?B?SnJOWERrQWhzdTAzWlFteWY2UUlmMzY4U1BwaWVGS2YwcVB2SEsyRDRUcTQ4?=
 =?utf-8?B?S3RBVlRPeWgwamhZanRQY2RWU2VUVnZhZWlWdVFrY0xPNkxMMC9md3FqWDZO?=
 =?utf-8?B?UVdVVjZhWGdzdnJUZS85Slo3MFFqbXY5cHhRb0xzYWdIZVFndW1WcGJiWTFk?=
 =?utf-8?B?c1FMZlpqRE80T2Z4djRRMWl4RFVjWXkrcG5EYXB1LzZVU0ZMZWJUbC94RXY0?=
 =?utf-8?B?ZXdUL3ducjh4alE5UiswcHFOdG5PNFFhWXVsZlVpaG15b0dNKzQxR1NRTlhF?=
 =?utf-8?B?SGErR3JWRHNjYytJdC8yS1JlWEZoRG9ySms5RncvSVBmeENTMFZKc3g0aUlF?=
 =?utf-8?B?cjdCY3k2T1NFU2FyY0syRE9VUHBscFI0aVU1bjNLOVRRejhaTkoxNGJlSG1L?=
 =?utf-8?B?WGV6RVBtSTVXcFVGRC9NRDRCb0ZKeURpUm1LWDdrK2R2YXVpbkRiNitHbERM?=
 =?utf-8?B?TkxWdmo5RDRXMGtkOVR1ekxpclRqQVJyUlJ0STV3U29Tb0loeXhrajVRMHAx?=
 =?utf-8?B?ajBmZnNMR0FhWWxGZ3kzWlhOd1pxMDFGcjZCc01qcVEvcGloN1NObDRLcnR5?=
 =?utf-8?B?ODh1MDFsanZPNG5RWmFML1pSSkUydzEwVXY4b0YzSnlJK05tUW0zK3IxMlB3?=
 =?utf-8?Q?Sg3g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:05:39.1922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99add20b-bd0e-4443-fb36-08de5226b8a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

Changes since v2:
 - Address Ming Lei’s comments in patch 2:
   - Add a feature flag and some minor comments.
 - Patch 1 unchanged, keeps Reviewed-by

Changes since v3:
 - Address Caleb's comments in patch 2
   - add to kublk.c
   - add to auto features
   - set feature flag to 17

Changes since v4:
 - Selftest added by Ming
 - Move kublk.c change to new selftest commit

Changes since v5:
 - Return -ENXIO when device is going down instead of -EBUSY
 - Update the patch 2 commit msg

Changes since v6:
 - Rebased on top of for-7.0

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


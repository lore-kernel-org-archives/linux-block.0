Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB5359709
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225050; cv=fail; b=qoufN+kkog6aKCeubCe0BAqRdbTSeGjpIekCuM8niSZeON6Q9DQ/sLPf9VKB+s3OwkeuHQwQghAFe6gQq6W+Woe3TcX2OBdwcWcjGXk/ATQhjkXDR61qyCYCg4U+8nxlRS9uCZPWrGRpqBukc6R0DnpRNgqlho2qeYUPvQnqLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225050; c=relaxed/simple;
	bh=krdbeypoR+nySqKhksDGNN+I3ZdjyhSxvf/KOoiFotM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPYnjBGpGm1vGzWkcCPEMzlwIoWH7+HL0hbQIvDDPU1ZKY2M23MWtBkkhzl1N6zZpnjqIcfX7w2Aitj3gNBWLOIuBC9rnwPFiqr7gyhwa+83TF/EihaK6xvq6kQI6bf8s/gavegEO0wYSVH+8WTBjXNz+EPEayHUiv/I3XsVMA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOgi5i8R; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOgi5i8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX0OgnB4Sy/IQzvO5uDSjRYBvaAJ3JPalZG6ZLJ8UzaFmK3IdBy7l/KNy4NtmiUThYDnWCxo3Ue0qfhoIyap4mQUP951ILaL03V112yniPgE5FfMps1Am3EfcDg7ITsdvRvyIlU7fSLVVI4QrPPiJJ6Z31jDEQ1KEzg0V9x3fEhm77MHq4tdi5RYGnLPO/N/Uz4McXHb10n0TBqfqGMg+TpQJLCY9PDowHrDFqSIYcjOjOLYVE8OzGH6QdSzRUg5d3us1eVYxNAuhuM31h6KQklhe5gqpUAskVb0anxM5sU7adY8BMdSy0FaMtrFURTjwfUctZRxMvPZFqDHvXFLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK1QcmT1ymDSWAXk6c87SXZjLRM/2dfJwpzZNpbNmQ8=;
 b=JHLhbQZTnX+HUDTt/QpszcRMYREHipCRXy5+l+Xe0OFJRLPl75eXC51cp1Qg5yne2GOVHzJEVAzwMBJExG98o1D2BtJfpB0QubkoWlWJ1V9shwsbuOBYHMSU4LAiI3SsN9BgUoDoZTO73OA7efcPxbgefVJCiok8M8u2rYlS5lMkOIcNRc8b4zGmt/V/ISus2zXTPHTZTNNtv7N0027dWcJZASiVMwaGxn0UEUgpHq0GjWejRgazYaIAFuqSkgeTRD90w8uduWG06ko/iTX1gOEwFcrUs4YJR7RGSX5T7DhTI8B4POH2u+8cb83vhrAga6xt2N9bIbbD6yMAeItWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK1QcmT1ymDSWAXk6c87SXZjLRM/2dfJwpzZNpbNmQ8=;
 b=kOgi5i8Ryn/N6RgMglMNUz59GzO7E4/5yuexQDvf3ZdlcH2OjDoryvP/Y18q83kPna1TU0UNlZASwMlLRS5m844zNto+LXoIPq/LlniSSY8N4KzJ5J6x6rD/bZ6zNB4hNOp6NduJC3f1vM4tAJ9GrlWAxmpQC8n4pJFv+BBk5h+bNfwC1+as6SVForV4dRr6mde9QvAo/733ItbEH4MnywYcd3pmO2ccnPFByGkyI47IcBtUP2Q2ZfUsMuL7t/DUb/04dnN3njoPits7Ib941mBEaT9D/nA3CqA8B5Ps6LuRgVuFp03YN3HJ8TwAVXFBNHCEVmP640HyL39/EP/PSQ==
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:37:19 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::9a) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 13:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:37:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:03 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:00 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v6 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Mon, 12 Jan 2026 15:36:44 +0200
Message-ID: <20260112133648.51722-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8cac66-43fe-41c0-9e63-08de51dfb51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEExSVVIQ2pnUE55VVgrQ1ZjSHNVUUVKa1pac1QyQ0E2a1JmbEZCU0FvdFBh?=
 =?utf-8?B?cWphL1JnUTc1TmFzajJFN0gvWjNTQ055UFQvV24vcDVZNmk5WXlNNHBFVTNE?=
 =?utf-8?B?R1lMUlg4ekhjQUVyZ2ExdnMzLzQ4WG5KOFpKQzBsREI5OVpOSzdxVGdTUjVq?=
 =?utf-8?B?c09hWmh5Rk9TUGJyQ1VKVyt6VUpHV0tvQmU2SXJvV0RLSUtHRVJJM294Sk1K?=
 =?utf-8?B?ektwRENYbEFLQndhL0xPeCtMRWNsaHN2NUI4TVlCNjBxR24rcFlqZ2hhOTFq?=
 =?utf-8?B?eWlUM0JoZ1cxM3lTMTdnNDk3OTk4NHdxdS9WVFZndDAwQ2hPSUdUQTB6M3ox?=
 =?utf-8?B?MDZsV1BmV05hUndMRGpPaU12eDZvZ1JKbC9JT2NKMytLeUg2TEo4Y0t4RWZL?=
 =?utf-8?B?OHh6WGd6Wmhwc1grZEZxdmVqWkllWnZ2bHpnOHJuS0dkRmZsc0lNVE5adFIv?=
 =?utf-8?B?bVNMenl3NkRxeE5kcDFnTk5tLzMzQ0VKZm96MXhtSldsQldGWDErbWxiS0pn?=
 =?utf-8?B?Wlo3dWJpbkpXWFFtbFdwMEhPTFp6cWs0UG9VWElVR1JRY3dsZkViNzJ2Mm1a?=
 =?utf-8?B?WmZ2bHF1YnVNZVRWajZjam5ZNHlRRXhtS2doTlhNUEV1TW1LL3NrenpKOGY1?=
 =?utf-8?B?UEVNWUJyanRmeDJ4clFmUm9VVm1tL0YyMmp4dS9zNTdSRExYWmdwMyt0MkVT?=
 =?utf-8?B?K3ViSEN6V0NiUW14bjlYTmRCMUtVU3pSNUwvVEg0NnZEVEU3Y0xSTEp0L1FM?=
 =?utf-8?B?aWdwTkFsVU1nTVhpbGhjUU1kWG9VSzZJOTVJWEtnUUREeDdXVkhoUWhZVzJP?=
 =?utf-8?B?TjVQcHl6RjVEL29RRzNTdjdjWVV4U2dTWU1LaDN6UksyMWVhaTdxYzk4L0hu?=
 =?utf-8?B?UTNWWWxOajhJR1grUnh1cHAvRkg3V2lRVXlPdE1XSk1ZbFRvVXQwMkFPcVVR?=
 =?utf-8?B?bGg4RkYvVzdaLzdvazdkSlVaenVGTDFHVC8zc3ZuaVZabFFsR2tCV3lyT25y?=
 =?utf-8?B?NkNLRlFuUGZvZWhsdUc4M2UzLzNnU0JzeDVhajRlOXRKQ215S0U5YnEzdGd3?=
 =?utf-8?B?SVNhZFlUSVVHRzZicFR0RnJ2MUt2U1RZSGJjRnhpK0xOQWRTVEVtNjN0NTY3?=
 =?utf-8?B?MWg4UjdDcm5ObUhlR0RtRWxwb3c1MFlMQytWQ2RUd1pQam5hUkthb1k2WkJZ?=
 =?utf-8?B?a0hyZG5sZEFPV3NiOFl1NmtpcDBvWkNPa0hwN0Y3OXp2WHZGenRTVUtzNWhz?=
 =?utf-8?B?OUxyMkphSkE0R3RyM3ZDc0RLaittajdQTEp5Ty9oZjJudUlZZVZ6elY0WUpi?=
 =?utf-8?B?RldIQmtWR1RqYmJ3TUFGNlNlWFcyVDFWZjJ6ZjAyalB6Mk05MGR1V3BtYlpk?=
 =?utf-8?B?Nmk4MXIwM3duU0hOdllqV0hxM0pzUDhzb2ZBcVk0aU5kdEMrc01PaVpHT3JX?=
 =?utf-8?B?bktlY3RrbklOVi93QXRqUmxidXdsNzF1NFFBbkcxYkF1RUpVN0xnYTF2MVlo?=
 =?utf-8?B?T0NKVlZEMWZ0RndvL1RpWU90dkpJcndrYUFFSzdaT1ZCN0ZsVnk5b1NqTjZ0?=
 =?utf-8?B?V3gwTmJFZDZYa1hzQWFtRUFGTjZqa3dZY1JLaThGK0h4RWpRaHN0cDZPZnVX?=
 =?utf-8?B?VTJBQkl2bUFkODJYMENmUHYwa09qeVVuc1UzSnhRbnhTbkFVaGJsZ0FaZ2tv?=
 =?utf-8?B?a2QzMHJCTlNDdzRSamg4MEJVSisvWnpRTm9zTEJHanFOR29zcUFxV3NMYjkz?=
 =?utf-8?B?ZUVGOGx5NXErUnp0NVJaWEpheXNFZmNzbFZvVzk2aWVVeHpDQ2JXdDFlK0ZV?=
 =?utf-8?B?b0RmWEh4VVdyY1lzeGZ3WDBlQ1BvSGd5MnZXcythUS9iWmgvbzg4bS9yMS9L?=
 =?utf-8?B?Qjh6cWFrc1V3NEdvdzIxK3RQSXJrMlNjYWRPZG4rYzVsdGdaOG55Rzl1bk1V?=
 =?utf-8?B?QUswNUlmTEtlejVkNHAwc3VKQkNWNzRzbmxnaUdjUDFnTXFwOUJiSVNGU3Ra?=
 =?utf-8?B?bDJ4eUd4NEJQTHVML3ByWUgyWVhxVTY2RHMrTWxSaVFlLy9tc2R6R3c5UENl?=
 =?utf-8?B?QWR1dUJUamR4cVRLMXJDWGFORjFQTTIxVDJSWDZHRE1KTCtEd1BVZGk5LzMr?=
 =?utf-8?Q?SWV4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:37:19.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8cac66-43fe-41c0-9e63-08de51dfb51f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787

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


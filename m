Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794367372;
	b=oSx/sT3E2nOY8+t2GFsTFhaGgCnchJ+nD+cWIJsEiW3n4FA3d9lp7UsFDZ8xHqV32r0r
	 yw2ilkMRWQ/WarAc7bh7jmp2RxHlJydDAPRcAJ9C1I+bXgybw7gLbookqhpyHLTUtzLIs
	 ir9SqfCNuRuM4WTKEI5bAg8v6WoEAjQeGT3kujw7/R9EQlWffGOsK0OBy1sQF5t0JSD4r
	 K0K3HHJ7XdO2LeO4SHrW5YvSk7rXsqkLenEB6+0ejOvZbQZATGYv43D4Kh4BfteWJoFwl
	 rzWD3HsjwhIWI4mp9aQ/EqMBVlXIQpuQCjpeaWT14M1d7MqqcpaJ7PuRJ40/t5ubMMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367372;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YfL+TYPhLGrR+zOoWgCyJ5ZZCvnBQOZjtYcXmp742zo=;
	b=tkiz4nk4b4XsLWA6aU1XqZfgU8VoEPvqjxc5hEgl3Um4f7EzQxVO7j9NGNFHEAGNNKwY
	 p9Sqi6xx7xGMyymRgqrrptttiRbYfUdhTcgY9V51Tc9T524cAeOsUpyamhYkv5QkXQN3v
	 6A2VKzTk3tz/9iGPpeTJRSHv+cZmoec2P375WM+4CUGQuDXRvASBrqTFrAte01EluzSn4
	 l6syedb3P8ihNp1RcXj2HK+tj8S3pWVk7IPpm5CCgJqM6HZrrLLcGStXruQD75Yx+UQrj
	 6hXDKiPb/+PVTTXH04275lkDZSdCDz97FtTC+Sx4qMy+nSgjmX6g0MebXkb5CdybizQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YAe79NkS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.6
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC916606A320;
	Wed, 11 Nov 2026 03:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC916606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YAe79NkS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFcVEmLEROLljHgkaXTWbjM1Iwf4XdArSa3yo7PpE5AZh6xodQe4VAsW/nZEwoK26XcK9ZFGApzppvEXI4zK9BjpWZlZkeRPxVGoH+MacMX/hDeTuX7r9xDSj0EocM2xbH5qFKYG/e6HzSsu182Fnq6xK5wRFNbxw9JzMkDm4nYxSJTbZw3Jfunm95SMpwKb4leM0ucEcM9APRmp9na2P0W0r0MoeY6OQfvRco0XlqJ4qRtT/PMLgoN5V5C3ypFxH3B/KyMyJjNxRfllm6CHTQGzqAR76mHinVZViXNfR1ACMzuRutUljfUJtEbOITsrC5AzDa439esIZgoBV2wjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfL+TYPhLGrR+zOoWgCyJ5ZZCvnBQOZjtYcXmp742zo=;
 b=rXQuZPPF7xqUGtBBBV5RS7SJ9ULN+tlXFgPiHHEhZLiogXeDxcSx9nB24nBEiiWfuQjit9DA1r4YfWtk6c8AehLPPl6ASK34e8VqZsEBZmP5jt80P4TVsJo3IbWlzEv7N7Cnv6udwLD4Ne3CaY4O1xD/S2EL8cTOB1n4ffv5/Kenmmup694ocmJz5QIXOiQ00o2x5Tp1iP3O4TTsrOjNXvgyCsaOJqE70y7thMCtC5+Lr0KiySKvoVDW8Q+robPx/RmYLP0hDzWkq/xF70Gk7jGEQBPb0bf/fYuRoiRbcBhRRjypDCQQ2LtdpWUOxTEa8yauGZNOWBvwIa+ZvLJHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfL+TYPhLGrR+zOoWgCyJ5ZZCvnBQOZjtYcXmp742zo=;
 b=YAe79NkS4UuSUAkv5t2/QQ9M9XNJEx+BUw3xgdfjBBPVf14F+p8lfK6Lp0+ymCws0b+FKMy9+SFtF0O3GhesDai5Sj8DGfsDBFPhwWv4YxD0mus4E0nurKvMboNJf/FnY0E0CaOMm0uupCj69Meeu3nwdTHUBcShjENbBji5aCuBR2CFjTwmp+80DYt1DOMbyUdo8OVYbo0Soj3RYqnvaZeZjocPHh728LZexbeDPwognA5dP1jGmAdJADz5/j4A2widIqYpntkojVrBvK4UwziXx5IW0l8az1+HT1If6p6bBQQKISHC/OvYHNQi4scFzr6JQUAyA68ynTSH4JDB3g==
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:22:45 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::26) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 03:22:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 03:22:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 19:22:31 -0800
Received: from robelin-Precision-3660.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 19:22:30 -0800
From: Robert Lin <robelin@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Robert Lin
	<robelin@nvidia.com>
Subject: [PATCH] blk-mq: Always rebuild the queue map in blk_mq_update_nr_hw_queues()
Date: Wed, 11 Nov 2026 11:21:54 +0800
Message-ID: <20261111032154.49207-1-robelin@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0b7627-2f5f-4563-3a18-08df3fa30df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261009223027099003|10067099003|13003099007|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8rD4EyXvKNKtCk7EkCNHH6aOg08FDN+M57eJe51LudyaG9YfHV8Gsch1pizTakSUOsc5vgogsxCJOXLr9JRzHeMqQGAmmO+EzT//7uZ6HrrtBnqMV6F4bGlpMuGjstjPcINWup0SAslmaW19xaMcfeVXHezFgb9/3Fki2WlmEP8rNc/1riWXmY7G/ZZ/kvg4mUyh7RE2pKbVwn/C7zBrRH/xr7ca+eu2WgNlPsiLxYFlZDHFHk4Mr3hKcaB35+RDRlsDvJXHyJZnePc/J9ggs5eNg77TLhdnpej42cryKGqMG5eaQ60Lhgu7rtNlgrCtEOiFAuDYCUBg8nvI5ScclwwwAtJaAaumXZ+EZH/jy1A4CHmb1O4RtngyFiF0KnPxrIDYZ9CmZxBZ5V7jxWrtkwLMAngId58flES/rXeW57GPy9RR+vhfG3b3cUnQOhmkRwfzNDxw7dROkdSCz75x6J0TzcwqFph45ikguqE5e49Ko7exRwtWbFxF46qp6/kPuBjIpVYE1mQTXK2hOtvcYMVuQv+ZwDrlxasVFUk+WMeFOcPuiYdJB45+NU9MknVLBDYVYyUrb7hzAHW0ECWhHTb2YY+w8I83z7YuF4XiliOvJRolDzzgnmlHADwSeKraaKlVh1xy3AJtKxdILOvP05jyJcFm6c+uxSES4zKzufTvbayrXRH1pF4YnuM8SY8xphJkX5FDCcZtMwNM9/xLaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261009223027099003)(10067099003)(13003099007)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sA3bhZH/5YqRFY/wQuqkDh+JrSFtrdDhSWlavX/EEfNPdNU6Pv1dZOjntSa6xeUmqfxp0nWyAcndKh67ayNGrjPUGJvK0+pvwiFEHscpDToteD5v8zXHbvZ6TtkwiC5PedHZYoKhtafh3p0kLbyJQ6b57G3Zei2AQKfEbRrDbkhxmP6deUKnP9bdKiQOjzBRAyMXfeSTnDg1yZpgXacycirTIncWkY2ejKhlDWadwv7c7nXE7kBCP2QvztKRLPfo++BirJYUvOc+0X/IzvnsOptQQVzXB8Inh/lid0GfYt5XGXks3pEZcdbHzCKiRPrAaeFv6edF3dmZ4PWUX0BI4CoKjJ/rBW23Rz3nMJhciENSAz49ZqVScY3ATpS5k+vIaenkUbbEjFoXZhQ7IBaZ7nP9J6Bnogffl8ZoQ7EYwY/hi9G2/cyOajfbYLvAfyBq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:22:45.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0b7627-2f5f-4563-3a18-08df3fa30df8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

__blk_mq_update_nr_hw_queues() returns early for a single-map tag set
when the number of hardware queues is unchanged, on the assumption that
the map can then not have changed either. That does not hold for
drivers whose ->map_queues() follows managed IRQ affinity.

NVMe re-allocates its MSI-X vectors on every controller reset, including
suspend/resume, and the affinity masks are recomputed from the CPU
topology at that time. If CPUs went offline after the vectors were first
allocated, the pairing of vectors and CPUs can change while the number
of queues stays the same: the topology masks of offline CPUs collapse to
a single CPU, which changes how group_cpus_evenly() orders the groups.

That ordering depends on the CPU topology since commit 89802ca36c96
("lib/group_cpus: make group CPU cluster aware"), merged in v7.0-rc1,
which groups CPUs by cluster.

The stale CPU -> hctx map then sends I/O from a CPU to a queue whose
interrupt is affine only to offline CPUs. That managed interrupt is shut
down, the completion interrupt is never delivered, and the request only
completes through the I/O timeout ("completion polled").

Observed on Jetson Orin (6 present CPUs, 6 NVMe I/O queues) after
offlining CPU4 and CPU5 shortly after boot. After a controller reset the
vectors for queues 1 and 2 are affine to CPU4 and CPU5 while blk-mq still
maps CPU0 and CPU1 to them, so direct reads submitted from CPU0 and CPU1
take 23-30 seconds. The same state can be reached without suspend by
offlining CPU4 and CPU5 and writing 1 to reset_controller.

The queue count alone cannot tell whether the mapping changed, so drop
the early return and always go through the full update, which freezes
the queues and rebuilds the map. Tag sets with more than one map
already take this path unconditionally. The extra cost is a queue freeze
and hctx re-allocation when the queue count is unchanged, which only
happens on controller reset/reconnect and similar slow paths.

Link: https://lore.kernel.org/lkml/20260113022958.3379650-1-wangyang.guo@intel.com/
Signed-off-by: Robert Lin <robelin@nvidia.com>
---
 block/blk-mq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061c8ef4484a..cbedd8f8ed61 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5132,8 +5132,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		nr_hw_queues = nr_cpu_ids;
 	if (nr_hw_queues < 1)
 		return;
-	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
-		return;
 
 	memflags = memalloc_noio_save();
 
-- 
2.34.1


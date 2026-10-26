Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793016412;
	b=MpaRBGu5mXxiO3V1v6QkOlexziwMmJEbI7VSgkPKYABl00ZL6bH//VX1h/0EKVFIY6dc
	 8+C2gv+b4MHvzgJPFRyTiwCLNMV0CrM0raTj6SMftIZqLeYi0yNguYAuivhUxhPNRf7lG
	 QKB4VIAzSq+y1TpbqsjkMSS+EE3atixifzGZlFap/PnQIlsYLOirCI62NxgHQGlpa8dZ+
	 VulqHuYeLjR8349l8nySKBP5BD/lht9oLdemeOwR1slhAYndYzvx3e/quMQP+rFYFCtjL
	 V4L7/4+vKR29UgaWBJbsOJxybQhY4OAGyeUTxNFQ7X8y5UKQ0kFWfOxNzR161v5MoBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016412;
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
	bh=FY26LSXZtz6sHw/G0KFfP7gu2lwBXq5gsRcnPmHFq8s=;
	b=MeS/QBH06lvj0ZWGt4exW6qK1LzuXeuJiuH5j61f7xFwphyfo2fMGsr9OY9/ZK0/2G8L
	 RXvJiYHErrRB+Hmel1W8C/djL6G8A5yacEuEyJRlGTrMCHOBRwW8J6xOdVcUaT4UNJcwB
	 goCOUa2rE03j/3zr0gpyWvtt1mDNr+y8sbu31uyHH6KlzTN4dlnNyTc6sIQmVxTVOsmKn
	 FgSqoIWiD6obR8WbTACOiJEqXp36UJXN3khimicCgdghC81bdLwb3O/LES5T52+q2DMiB
	 Sri3ly++GcvW/6kF+a3f4OLuA/8OVE97HK0K6Awvlf0D6b7JxEGrIEPC6EVP2+X5egQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nSHxka6W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09739606A32C
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09739606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nSHxka6W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNjKyKFA2obzxBk+ym9ACyIodH00l1uscl1evS1cgmDgeUKGkXC+zwPImUKIChPG+KSTG4fBj0RJhR5eX8DsV92mF+kHhUnS9tzNZLDmMYbYIVoyB9ZRBnoQX6VBvOPekP4K4E8R4bIrw6KGzpLnAKv1bd2b4GJBuzP9XFR+SuyYYJ2/zzgbbItdXrj0R8Iodfs1ykvj5BHCVyZl90FQP8sAlkSbsKN5oGITIfBT3yvbXzAkUvprBPnyTaQWlwTniVzM+xf1UVByx4Ki69P4znzZBjNKpSPWR3VLYQa2r5qCf5oV9NiXIv1VZpvM6s+wkq6enb0soUznmLmH8ev7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY26LSXZtz6sHw/G0KFfP7gu2lwBXq5gsRcnPmHFq8s=;
 b=xVtvR7vM/kavatli9wGprdd5QnS6vSHN0TUpEZob0GPX7fncVhv7rwF9TMqa5QQu9kNIYVDtY5qJzpRkdYb0ZyiFQrgmZTexy2CYyFABN34y3ZJFRSxKZu5cmAiXAKEaITd77PzxzhVji61w+pIM4MT0KS1X5UONH2o88hqLH1CxFmGdbfBMbxpmeLUa6wIRF8uv0CrON746zEHRuohWSc7n3ZqtwFeZzDTFz46+pwsIoZGl7LqlRUkpCCrpmIjlT01ZyXvvSnkl3cuFkD0w4ml1PbbIrKu/BTraAJwOJAAI/iMwqGRWhqiiO8eR9dUeokhTzBvLx57RjPeNAWIMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY26LSXZtz6sHw/G0KFfP7gu2lwBXq5gsRcnPmHFq8s=;
 b=nSHxka6WMM/K/AK+vAhJmCQ/m5kKAWXNfWafNxvq27MurgV6qKn4BK3vB9ZheskNe/aMelgZcyqk+6VSsOwga+Eh+YI3DTjb44MVFfyq3hi75OckD9YDvEttvel+Crx/uMRFHKOmsZdBl3vRE3g8YHOwFGeEuf6orxJloDLYFfrnttnXh1pE68pqLXOVGMm9ixHPwcSHGdqSViA+LaPRH4cGaJ/7T6rOEAKdDzJtLFTL6ye2zdW/9A7qpT6309Ay3+yA4BqMcvMRR+eGsn+Rj9G6R8pfSsU2HEIUFZw0bwKFEBK8n6v1LXGAuOGtH9qqjC8hT9hahNgKTI9TkUh86Q==
Received: from PH7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::29)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 26 Oct
 2026 12:06:47 +0000
Received: from PH4PEPF0000B60B.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::3) by PH7P220CA0010.outlook.office365.com
 (2603:10b6:510:326::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Mon,
 26 Oct 2026 12:06:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60B.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 26 Oct 2026 12:06:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:31 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:29 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v3 0/2] ublk: honor rq_affinity on request completion
Date: Mon, 26 Oct 2026 14:06:17 +0200
Message-ID: <20261026120619.47629-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60B:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc016f0-0546-494c-3f28-08df33599c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bVC6WQncLOJ3oosCyEJxcpnDN2TUIrwEVaoBEsQ1SPKinSQ+Casi9yLVxGa+qkuMU8zRYMv91ymcVXWihj2DxMs92nswYAksHGahB7WCQwzNrlP+JWQ1EtvB4RmKEZ8ptSeUmqhRaXSWN69PXSY2nv6B4cCVtsJ19pzO9kh5JTtjZLqUtXN0361K5w1qXzRb3AALW2swKYPzdtT2xr2A+w4/8VF6WEiw9cu/CSN8GiF61g4S5tCRfboJbQlzWKqP9WVy1roFE64Z+ebhzQrzoKWbQZ1q6pzVWjxQEqTH3zue9YIaSJWbCcEb840uPHxGMIKGr7Len3u1InAFSm/FTSx9i9ODxaBV6/MCbFRo4K9+6bmzS0cK6Le91aX8h/mmeLTHp2bFHjSYmAwnM+KwqrBH50qNOOXlqOjUe7lVBZGtF+QMAGD7+NB4Ad867b9BfDOa3WMwsITYljMumynX/bG1rPBURBUPcazauXNYI2j2HZZwMo69tspY61kxHzGe4Sr7wtKSjW9AkoYFGKpXUa8Q4XBdQzRRNjk/PmULwmDk2y/AsdD2U+/QozGk3A5m98teK2b2jynG3DCw1m5huIhWlPK810TEBKjV+8HDkEKUFhG/rsBFDKCyRscH/QjyEVIAqYAPKBtQ965FKN48aptSnsfYeWh8fkcNWP3xFKazJqoTUlvHUxjhs1ERYkFJIbJmkS6wPRVIAZBeylzx3A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dYO0khyPusQfnhfCasA6PFyr72p33yh2G+HkoU16Qf/NcyqZoGM1buiMnRdjzwSgNm/glbBllidtNkZ2XaUWut7LYHdTREoA6IC21v39Bi8Kdl+478MOP+shVQhLqQraGMM1zvoUyHXR84eD7UkMaDoIGrhR/psrK1bk8To9rIeSQwsBtzQ6HZGz28amJ0JdjeW5+UbVPYlwSQaMwcsSyHL4FsRpCGJg8i3msZwBiKpoPUZnoUcahxp3+ATy5rscYksMwhLOsYBow5GOWV4TgPkk32SW1wxaekZoG1TnKFBQ81X/WEx/jizf20o/pjG+tcs53GXXo4ffee0jzfMueL1tVuAQfH1DVixs3kz2JP8AORlK6JRwogWjrD7oDDnmb3WpLt93kVnIvV45g/h4YAiYm15WEl/se4TNeRWpzWnaike4NdufL35T/JCsk9XR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:06:47.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc016f0-0546-494c-3f28-08df33599c11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

ublk ends successfully completed requests inline on the server thread,
so rq_affinity never redirects completion work back to the submitting
CPU the way it does for NVMe, SCSI, virtio-blk, loop, nbd and rnbd.
Patch 1 fixes that and adds a feature flag so servers can detect
support. Patch 2 adds a selftest for it.

With an SPDK-style polling user-space block server at queue depth 96,
rq_affinity=2 gives 7-8% higher IOPS than today's always-inline
completion by offloading a saturated server CPU; rq_affinity=0 keeps
the old behavior for anyone who wants to opt out.

v3, addressing Caleb Sander Mateos's and Ming Lei's review of v2:
- Pass whether the device opted in to __ublk_complete_rq() from the
  ublk_device its callers already have, instead of reading it through
  req->mq_hctx->driver_data and ubq->flags, which are likely cache
  misses on a server thread servicing many queues.
- ublk_end_rq() may run on a remote CPU, so it no longer touches ublk_io
  or ublk_queue; it only ends the request. Only a request that completed
  in full (io->res == blk_rq_bytes()) is redirected. Short completion,
  errors and copy-back failures stay in __ublk_complete_rq() as before.
- Drop the re-derivation of the completion path in ublk_end_rq(), and
  with it ublk_rq_need_unmap() and ublk_update_and_requeue().

v2, addressing Ming Lei's review of v1:
- v1 only redirected the classic-copy-mode successful-read completion;
  every write, flush/discard, error, and zero-copy/user-copy/
  auto-buf-reg/shmem-zc I/O still completed inline as before, so
  rq_affinity had no effect for most traffic. v2 redirects every
  completion outcome.
- v1 ran the new completion path unconditionally on any patched
  kernel. v2 adds UBLK_F_SUPPORT_RQ_AFFINITY, which a server must
  request at ADD_DEV time; without it, behavior is unchanged.

Yoav Cohen (2):
  ublk: honor rq_affinity on request completion
  selftests: ublk: add rq_affinity test

 drivers/block/ublk_drv.c                      | 68 +++++++++++++++----
 include/uapi/linux/ublk_cmd.h                 |  8 +++
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          |  6 +-
 .../testing/selftests/ublk/test_generic_18.sh | 42 ++++++++++++
 5 files changed, 112 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh

-- 
2.50.1 (Apple Git-155)


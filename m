Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193552;
	b=hnw1j0zKN9WPHX3dmcUUFLv2pN87grFmTXrh5DrqSBU10VPWipWDJZ7/w5+EVu9cU52z
	 eqF0SevfLS4iNREOA5cP0PRyj0nTXAhqtgiw1l0ygqacfFpcQE6Hyq4D7M7okDqfPIY4z
	 nCHqK09KXAB72/WvRWCDyR3zN1J0B/Rsyk+9VLozzf1OKZEK5NBjV95Yre9B+8vr5DhCf
	 P3+f60sn6HSVzFyWpWKKQiqTMCYAGgupfEfm0Z4J+5PDpzv5QMpebczIBzvGesfoMl3rH
	 kIDVXeaHY1iNYMlYEsVX+N0uePpPlurfFXBU8tDCWMRWKGWxwVjqChXHaYtSXWbSjng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193552;
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
	bh=nrM426IK/FawFkO23M3f+nYz4tUFW78sEIhZFDyCJIE=;
	b=stKiPNK1yE35l7l3OzXXg2nifXRDkgCRH7ZTZiK9DbPuR/Uh+yT5mSjhqA2UwqoVbLk4
	 UMkGjyT7z1yCzNSqKsgnMfDdItdIiZEFUhtouNTDO1ltITL5qhWRdypw3sOXtASVyqPLw
	 /ClM9yjdGvaGZWvdhMsDuOKoaj1xGtE2FD0LPqhNtuMWstlu5h+3any/JovS4ZuDX1bTV
	 8dncGfKOAY0qCjC6pawelBehE6mG9HBWUApTsYdeZW0TQVJYC+Gz6SEFe1uY2Fyk+GSlp
	 djy4k0CfI29tQUa/855pgobMrrjarPiqF90r2vZOcetoIZpqgrQgxm9Mu4YAYyTWmaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f1uRYHPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.40
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5F606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 13:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f1uRYHPX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLvEb/Pl1bNIyTsL7PN0hygCzx5cmAqCIXL4YhWKJmBDfquqAvexVJaK7WORvpl5gZvVBuxjoMBNkdv3Tfch2Op3f65kKlUP+wVFLFX10km5rH66obH39ViS8AJDmkI03ATbq4ULvbfhCkd7ezlurUhFVr31E542vd/8Qmbn3jRiM1XzLtxjm1BHbsnFJcEOLAKDFi//ZKeVSKOVjp7kJPi4u1sx6F//c7oJm/JB+8+6AuaLMiPeXqOSEs4oHAP0x+eNuJBlwhpofzL+94WPA4hoAr/hPd0t977byBdDobf2D8PChISG9IdqYZUDzvy3xh8gEwTyvJXw5WsEV+oOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrM426IK/FawFkO23M3f+nYz4tUFW78sEIhZFDyCJIE=;
 b=ISvZ9tJJP9C31Z39l2KH5qos5nKXJtM5Ge+T8rVMO/JgCBamY6d++y5EB60WOtVpfUFiuNHi4KrlcGVKQ5AZhx2WTwVaPD9JgJeORCfJKqj9LMHXxLU442SRPrm0ATEPNCH0XmBuvuoIPz2mtQR82HBEr1Z9D4GzNnlLf+diwQwJ9y3Q21cceAUegGMOp313vuZli8Pd7EFdlaTC1x+QoJq7SPl0ZuX7k/5Q74pT5h8dPtTCnN4CgHKE7VvteRMypfhBAG7bKskKzxzUr8RkGm8kwtOCcaSVCDVXXdBmzAuUVs+f7JfJNpDHwqijXz3vZGdPUWLHv5+Z08QchlPVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrM426IK/FawFkO23M3f+nYz4tUFW78sEIhZFDyCJIE=;
 b=f1uRYHPXQTMkZXQbhspMnfIl4lS14eABHD1jvYPmG1IfjPUAnWDZG0//Cj0lXiPKZP/gU+MI5oHWTf7pRC9kIkWeyfIRdyavTRaA4G9kj2h123+far9dQMBQTG1BArIEUJKrm9gRLUiW7n2+1MdUaMD3AXkO942BAesZPzwmAFJeWSObbUGI5tQ+CLnmB36uVwLfCwCCUcrsaCgLRH9RF/ikvpPJ4RDI5uT/QVQ/iWd7Bh636N/WEkuVqWywfcZwUlsXc1Uakn2TrjaH2SYvJZGkfSAHsYmsMaXoahIFtaqjmJ14CClBdPWOGcfYsLX4E7SLp91vfOTx8z2U1PTDTA==
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Wed, 28 Oct
 2026 13:19:06 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::48) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 13:19:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 13:19:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:41 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:39 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v4 0/2] ublk: honor rq_affinity on request completion
Date: Wed, 28 Oct 2026 15:18:27 +0200
Message-ID: <20261028131829.45803-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf54240-6d28-4389-619d-08df34f60a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|261026140227099003|56012099006|11063799006|5023799004|261009223027099003|261021121427099003|10067099003|261021123027099003|18002099003|261026121527099003|6133799003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	+8YtimCuDYRSa0OVFaEg1TMl0C88gpK4o6it3yZBgZ0X5ybaxQJGQRafAKRqmdASuwuglJa/pYAzRUAY9hF0ImzDWMiSSV7vrWhCGSwgchUJVE8cH1SPIu4FczPIEFn2HHB3PTmLl4kG+7/jK7JeDYJPEd4/JnXMQF1eU8wxmeX2fEKKQi7S+oMaRp5wSkCMAhGkyouZYY3ecGvdg9CMgn28Utr8grjl8m+jLXcMdMOX0Au16izQg5sP6UkwLJ1VzT4+1b+ZrNP6Zp+yYI+rpvp2fe87wq4jLNISvFrtpOpnFn9QERbD8vqx67khNE50ORRGbHCRUXker1M0pn4/SXSJNRrDgupR5PmuKazKZVJSVEGvRfpRgXoJUlgx3Ly3RZePY/Bw7sW1hhJNzig6NMlFHEUPWwmOpn4IBtXEi7Py27azmT05OZ/LArRuftL/I58emlbn22q5B8HF4mAnqQp5AWNOqOqx2Cd7gjsi+Sd68T3BLXRIlQApu9fsCL/TpUlpM76HVcld1PnzwizhuiDrQMe2+N+Es3Fg7RTWsEcHft2ljqRPyfBqsg4gfd5OAXoxeeh/C4Rx6+KL45uDgXXNo4WYtm9VvEXFDr88bFy9UEl80CWA7WRLWDe1yeCi+pJkUtLF2v8gSSfkg1jDZOghAczB5g9saZUTgHwRIK08R+qyasblOWD6h96ZenPqdZRdgLZUIsvEvkCiSdTasA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(261026140227099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(10067099003)(261021123027099003)(18002099003)(261026121527099003)(6133799003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sunzKoahlVL1XRMIs79+co4mHmur+J611bjKB8cKTO7cvfOSiXiRsQMR/Gt1xfIeHi+S+e7H/6V1dTlEEcltpek3L1TdZqesBv96T29pdVLpqQUW62JvScCOOc3o/C8Y2C98e7tXccELclSpJfcB1lwHs24oJ3aJuG42gfGRgOoMaXNuL3gj/LNayrtJ/vJXyGz53BIH3l+PzoblRo8EMKRAL9AciflW/OrFIiny75Ils3y266c6gOeOm1KXr8+0uhTlSi+KfTXw5duBatxhhc9AxDGtP8VN0QuhMRnlX8NlBJcawiAPNdHtfxU1Kkd6vzwr+qzFwPOgJiCpimkPF4eA8nLSt0irpEH7iTdm6wHPda0oTesGtEvpTD7z+HlmxVhRdpSi3OOQBF1agADV7O2mFM1JbNSnTIxL8OabiZm3zUAtzzHdcEkuPldtQ+qe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:19:05.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf54240-6d28-4389-619d-08df34f60a78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

ublk ends successfully completed requests inline on the server thread,
so rq_affinity never redirects completion work back to the submitting
CPU the way it does for NVMe, SCSI, virtio-blk, loop, nbd and rnbd.
Patch 1 fixes that and adds a feature flag so servers can detect
support. Patch 2 adds a selftest for it.

With an SPDK-style polling user-space block server at queue depth 96,
rq_affinity=2 gives 7-8% higher IOPS than today's always-inline
completion by offloading a saturated server CPU; rq_affinity=0 keeps
the old behavior for anyone who wants to opt out.

v4, addressing Ming Lei's review of v3:
- The selftest didn't reach the remote completion path, as kublk pins the
  queue 0 thread to the first CPU of its hctx mask, which is where I/O was
  submitted. Use a single queue and submit from the last CPU in the
  hctx's cpu_list, so rq_affinity=2 always takes the remote path.
- No change to the driver patch.

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
 .../testing/selftests/ublk/test_generic_19.sh | 51 ++++++++++++++
 5 files changed, 121 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_19.sh

-- 
2.50.1 (Apple Git-155)


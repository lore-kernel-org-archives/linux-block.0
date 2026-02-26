Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC5285419
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075587; cv=fail; b=DUwl1SM1kNM1YqQCUmeXratKlLWwwmipImq5clGbjbkOo5L/RInTl2pu9NAyr8FNW02RC/J0x+gQTVt3Y+w/f4aB1P3X1SBDqwDVp5JNmc+ZVotggeuyj12Hwz+QpSbalMBXRCAZ4hedyq9q+bbXM6TNuPTp9Z9wNw8TD+qZ0pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075587; c=relaxed/simple;
	bh=AoEMQ7kQd2Ii9rjbIAMggRMsf8jF4hB6BLcXrHhuPeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qB2hJhBL5cP+H+O35KRvfBr6tgUyTOpQiddR0onpbYVztyNpCbsLKUI/kq3aGf9sQON0fgh5866L3MLYHcBjrtplMvgV9cgsp/KhMG6CaR2idtom6K4ggE0js7SxxrHM9v7K7newUDzKIaLL9P+tbPpgjI5wPGtC5iQaw9Ehplg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td8bdrib; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td8bdrib"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKziYbv/djlnzRVjEv3yHPvASyAhJOh5Gd+z1jTlW7I+j3VUbIYleNfIDmc3V0e2En0urc1oS2DuTR/wfoDcoSvAEvMUPioWTTqHMMYwWdoeuItlUbyvWIBcFJz8+fDhq+Qv+GOQSBoHacyqNRxiKd/wbhjY8ZkJZndeVGa/5yi7JfEv6ERxE9ILOx9nGUrode7/xptBHW1+sG0sPRpqYl1qu+86nRoFTXPgXW0QukkFWgVhzBVdzIJc4Wmo4N9Q57eP/GouhobxfQp2OC9U2s0UtjwthMZqMiFG/bcycUS1MZd98QAGXaU6Twi/v5Ea0wnv5B21uFKmBlCvUO0oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUWW/DzSbCEg9HKwNxgCposxrAKo5hZxqGV0cdDbel4=;
 b=glCvCyZbGBN2LeC+whugQgSUxGha9bpmgFXU9UFB+ZSjTJHSviQ/HR09H0vkIMInPmECAwtUklT70rrFBz66IY0CmpHCYlEpziKgzwBXWN9yauHEyeY1VTRBWjdTVt4X1W9FTM8Ge99paZga0Yk/LThGjFeEJLidnjNyXwtw5aytsgdP3hND40k9txvqSXyhMUd8ksfFbG8t6ty/l4th5RGeAiUUZm84l32YXDAqZN4JBJ17YCFbA/XeLNL+ztmJhFDZH/2/RZul2sRdeKPjsXElYLOeav+Fin0M199eWt2R1X7WoqmV0M+C+izfZwYyXxWZo3ig1JR0iFDPjQLsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUWW/DzSbCEg9HKwNxgCposxrAKo5hZxqGV0cdDbel4=;
 b=Td8bdrib4i/YlJfnd0BStcr5PX6Kc8fu4YmmeyIY7THm733mOszsQsPbXa406dWcCfsTBPTKM1RptBSS+oe+ERUijm2rDOxNg4NlLkrQ1hj27/cKRHvBGqusZIOff1XCRlMjlqsUV1zbXCxrzhoW3r5TCnYgBhEaAdb0j0xvnH+o9Z1tnRDjyADVOZqdxYvV3PDcWwCcnCSD2iUBhFuAIORcFaUQrn38ibG4v7xRIHanvMvZhhJzR2PpnDdOE91WRMAPyRLFbhUMwh2TSJZK/1F1nkpFjuMHJy+Q1FqSraC5y15pIVlUNqSwbRJIor7LnAZGce8+zaXsioz9X5pfpw==
Received: from LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::8)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 03:13:02 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::51) by LV3P220CA0029.outlook.office365.com
 (2603:10b6:408:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 03:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 03:13:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:12:50 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:12:50 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <wagi@monom.org>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	"Chaitanya Kulkarni" <kch@nvidia.com>
Subject: [PATCH v2 0/2] blk/nvme: fix NULL deref in rq_qos_done_bio() on multipath failover
Date: Wed, 25 Feb 2026 19:12:41 -0800
Message-ID: <20260226031243.87200-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8625217c-c37c-4021-738a-08de74e4f3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	RQLDr9EO2iR/KYnh2kHcQINbMO63TovCCDaP6xRxgoFSoEX/lc2rPqHc3uxBBsHDdMREVViWJpD7AR9s31c3YmtjVhcbeDZDalbp62CD29XgeHYgVO/Uu3FMlzA0uPiOUfmRLYDOIrh3DZZlhQKhHSKPvudIn+PELyFkViX0bQX6bSa99ODmYaj9mzRrRBpVpmWXiScRobNEiaPz0955RZr5dFYk4WCxxd5MToDhamO6H139oMLQcuhFJu8tUr12LBtuHbQwwyDWp6/48N6keN9jxwvFVZgB0mwOg72AvNTI3fUAFJ8IUv7hLtwiGsoHnLDzdFlDLCjh7cMqRVrj+CnJEdTQPHxe2+MTgp9Qiyyulq8rBEMw8x9iqrM12rBR4hub4N2kOjyWu7qYjVadMypaPoJJ+gR17XqNA7yV5JkRiuZeMOAfLDfbbq/fXJQp3I3GN088oD7C2u2zeHGZltKRKoRYhbpunMR0F1Fq7mcRmAEjvbdKoPCr1RlkOZARTcI4kYZFHAcrHWYFsDXX0eYghWa0ivnab3eTJrASycojI7dOgcsNrDIUQCAj3soj604bG4f9Ip1WdoL8n6IU5W/Q9/qJ6q7gP6oZIBThmwEufZ7EYfjkqp+r5ErDou+y3yTiho1UyTzorjk+dgLrOIrRrzn7g1OWoPTmpbkI1vHT26OYhlmw6pEgio+wE+JmFFlBSvNuIl5dOHLzt/GykecGb+/iuHmBFfiOfowut9JNs5yO8PWSjbHVR9Ca0Js4ry/wAU2PQTk1O/biiepwD1GwN7aSvRymHA8GSOm3VljDbn+3pNtsuoqdYeagmdYMu6LFBAU1B3jHCKvjs9C3qA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HuMUMg1i5jxHOpO096plxM2vErEQV4qkEh9/YqY0COpEzGY0s3/r7hVkggiH/chPlb0qQBcoPFTy1WiB81PVBkIAAi2UrUHeZqxHFefKA8ClBpqs10ym3c1xgobbZG6PPd55tiRyqiI4BB8zsK4P09P674zQyWHS/UUOjJuPRMXdT/TQpK5VBBquHXYQ5cvM+HRoiQKrOGTwq962NV+PN1RUuFNmuc8sY4R9HISRTLPiJP1GDRJ/V/sgfZZdH0MdWkrssr5w2+oArU/aBRX/wMSsAarnDKIlnelMscFGZeCq8c/aTt8hfXTqTXj56bjeGlLb22zGruxqFo/tJiXJJ5vELCf9HPKalLNlKQ9ZAM1PHFce06D36/WqrgJED2qeYDUWhCkmKtlmxAZ3MlN0M2CLsjV4wWYLbHFFsBuUKz0LsaGCuK67EUOD1JlXIcWa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:13:02.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8625217c-c37c-4021-738a-08de74e4f3b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

Hi,

When a bio is processed on a path's request queue with rq_qos enabled,
it gets BIO_QOS_THROTTLED or BIO_QOS_MERGED flags set.  During NVMe
multipath failover, nvme_failover_req() redirects the bio's bi_bdev to
the multipath head's disk via bio_set_dev(), but the BIO_QOS flags are
left intact.

This series moves bio queue transition code into blk_steal_bios()
and adds a patch to clears BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
in blk_steal_bios().

-ck

v1->v2 https://lore.kernel.org/all/20251124070142.GA17632@lst.de/:

*  Add a new patch to move the bio flag fixup loop from nvme_failover_req()
   into blk_steal_bios() rather than adding it only in the NVMe multipath
   path. (Christoph)

Chaitanya Kulkarni (2):
  block: move bio queue-transition flag fixups into blk_steal_bios()
  block: clear BIO_QOS flags in blk_steal_bios()

 block/blk-mq.c                | 19 +++++++++++++++++++
 drivers/nvme/host/multipath.c | 15 +--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.39.5


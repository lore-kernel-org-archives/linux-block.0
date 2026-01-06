Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93A304BDA
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725954; cv=fail; b=dRr3+YfurcJFsNNMoJ6c0ldqchVHqEIWaCxwq8JvYef5Uj+Hlm5DSbnXoFjlxJMnU8p1PLj+l1NaYpDkZdFuHHv60Ho7AU8G2DG18oBh5rEv1gixOt2RQrbNXcQ7VyO2O+QJB27WAqa5yL0m1JkvIoXk+b6D6ZyZwJurkMLl7QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725954; c=relaxed/simple;
	bh=nZdvFp2oJcMHjbI+PLasZh18GqMiBbq21xQeuSNWuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJt4IUaWXesaYBDVkudb4h8L2m8hA5bXTPrj2AmnZMRhq/96qzlTGhE/ezh20DIuOtjdhLcYmwYCeg+X5F2r2gaM5O2OkZHtEufrQK8MStFLDWBwyoD8AMk0M/W0rRBpj0iNqHv4wMez6FZF4FWBcMeUrrb+s7K55HL8lKSj7/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhOcDUvN; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhOcDUvN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMlwBpUAGRiG0Xfa0LyVFC68LFDPMKCZ/XfY5BhboB57/F48v35NR59V8Y1xJ+ZAYvxD9hBI93MhBdsS+v0PAlwKEQCbslyde3JX1afgt+WvtoOZ6ryPEmuIKKezCQ8a+xrY1rN9JB7Q2VUfsPlCsXk3H6K5VF8DwvZEeJXoqfATufBEGj3tVK3GH+9v+FuyBca0lo64OdUgMEthoEdwD8NCp5w0KkqPLnpr1qJ3I3/dErOy/OMwlV3o3mSFt8ktdPE7nLprlyeIjAGhpDIv98ZlmCqYfzpGGd2+fOshk5K0tkdF2hsVxyD4u+pvyYlGSNco+GcvEQZvZBjfu7HMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=u/bktviiEgTn2LYgpkN2Cdi5J6sQ6yYtdiv+apMaC+alBKga0WHQtiD252AauFfXNxRgLMBnEo+LEQkrOdjqKazhuzD8Q+3Of0btaTt9t4uRd3EmaKWsJmHEPb7CZ8vXKvjPwWPO6Nza/sNOK37jeA9CgdDRZhrJi9dDWx1CwEwuFJLJWFvP28ioK5WPgbu11SmGhpumWRNRmmxSENjWF+MpETg0mtJZw236VZPlBbml1yqD49tcY7mk2OkvYPUO1athPtqDCa34sWfQIbJF/j/jbsiwOPbcmrEBNv6ezZQO3C6TDfJqi9dN6MmAqBjwsreotzIJVLnKU2TRg2DS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=uhOcDUvN7quQEbCNTsMWUdwYjdCmosfsPdKyWLOONzB2hlxtuQT+dihsDCxcvQiQo+OQfvsV6RRbgAYKeS9ngjjatwfxLbMp0W+2+vuqU9qSHPfXtYJc4au0uAQVM4y/UvHMjn5RiYY4cZ2t/yfuOeedm4RRAdLPSkyNWnZosOkcY+LKxsiCTbnBKwhrQK621Ydaf5Fv3QT3kySGKFTZ3amYvd8WDTiJCjjOqRRQNZ8t1TmMFk57eBbwtK5tyZf2LkabKjUem2xxPLZy8poaxKT6fxiiWCvv91nu3cThtUp7ofio/5gEM1mGeT4hsaYB6jEJSbKIVGyhp0ASX0FnyA==
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 18:59:06 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::96) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 18:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 18:59:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:58:53 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 10:58:50 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v3 1/2] ublk: make ublk_ctrl_stop_dev return void
Date: Tue, 6 Jan 2026 20:58:30 +0200
Message-ID: <20260106185831.18711-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260106185831.18711-1-yoav@nvidia.com>
References: <20260106185831.18711-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4b7a5c-7537-4163-6947-08de4d55aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5JlaGvy//2T52l1Qm9WO914UY2aeNw2724VlfUYsIpWSBySH65KnlltXaG4?=
 =?us-ascii?Q?/gE/6mUKH6edESyhNgJdIGeG0L1iN1lviDo57qoj4IgCcC5QniuWPogMYJN+?=
 =?us-ascii?Q?nkheIDqTAht9XZFb7wojDbDwZEXITWEf4xFsj3MAf7AhBYigWzbkmwm0EYPY?=
 =?us-ascii?Q?NzfUYTlNLZpeDyX68QchqbZBdKcINFVPlujzlI8i3qv4XUtfvRWiswugeCbE?=
 =?us-ascii?Q?2C3/wD7osENbaJG3L8CupuBpTDVtiZfTXKAk5E+xJWBKPXQ7yBuOF4vCubg3?=
 =?us-ascii?Q?NxXwM3F3fiBTHF7hfpiD/bYM8O4r7HT2f5qYbtvUXvZVneNM96407l9pUvPg?=
 =?us-ascii?Q?C0dK6Lk6lgZdlAyP8XNAtJtQU/G1ChjWrjxjWoDjY/z5ql+i4frTjPUNzVsG?=
 =?us-ascii?Q?4Hg5HEHvttOieZ0hwemwIbfuJgStcuzvjk4c/rrksUQNzhsVULA4afTzG2MZ?=
 =?us-ascii?Q?dH0dzBD9dq0T2DEfS65K0is0x1crZZDSEpd/sV1lX32y9uAADi7rWcBHqIJq?=
 =?us-ascii?Q?nR4eTxQgomcq7KbJ3HjEV8eE3VX5e5Y2jPiiB1/aZu0zsbj4/UNbpDwkuFwo?=
 =?us-ascii?Q?j3AgUyFmlF+tmk9mA8+AFVrCEaz8zlGdFKAdNXR9OekndguDcCMjsMCoyXKC?=
 =?us-ascii?Q?NxZFx9zKFY75eyve/YidfT80wOQlWvIAIgYMRL4DD+VN6RJM3WmE0TMu2aC0?=
 =?us-ascii?Q?4eVADZ0pgE8KkdgLcN/rL96Wyk5o7LtCcOnRxhGH5TXGtXsxFKTx2ETwkNBy?=
 =?us-ascii?Q?OxxG0zx/2e7obGCM8e3re0iBT+1mIspZHmJAT8QwiVhRJWdHCGTpyz75XBxh?=
 =?us-ascii?Q?F0e4dXBEGgJm86iAd11xxsxYuGJ1SfkcKK2fKpzHUZNtHcE+edghaqeb/gx+?=
 =?us-ascii?Q?7olMyxLsH2rmg2xyV1dviwZrpp12BsrVwe3Y3RByQ0KxKzGEqkW/ylTBPjtj?=
 =?us-ascii?Q?hYMwPNoHy19woLDTofEPFvGyz5ZhbcdNSRUHXf7BLJD1SUfpau0Rs/53tTOl?=
 =?us-ascii?Q?fGR4FkqnrusI17NQ4iPUv9/zQ7YFRkPW2IKbWnPyvY8mewqYhkoyTjobrrT2?=
 =?us-ascii?Q?U+mZk6//Alb1jG172hyYhbH6IyQTSeQ4H9+0m1OTroAP/YOFIEAfOuh7umyb?=
 =?us-ascii?Q?GwPyKFjCPsTlYP1HwboWhCb0PAJ4+zDNgTKhBBdRHsfggKpALaXT+7y677Tl?=
 =?us-ascii?Q?655pTqHcQ+/8Mr8sfLB4mD+ZouMKSiUu2iYWgc6Oqyab8+5eVY/TvOaOnn37?=
 =?us-ascii?Q?fsHQQEXUt5u2e43SgyOvtmtUQ5lnuWxHApQFaF0GvbB5PQPD8gARhBPGxNj0?=
 =?us-ascii?Q?q9PwE/XznTGrWu4K32XljLZQnWuvg0Tynv77p8Q/SJON9us9GbwumckEXdw5?=
 =?us-ascii?Q?lSdf6zLo+/5PeZMtSvyjIJqme/vErPWGRsYwKDdm/zqqnIJ+buUx3wCSUYrR?=
 =?us-ascii?Q?qdQrpoYNgqoZXa4DVh9I4FpojUzrLQH0AgVcZYEInqVEEj1E7xrvMz57AdSP?=
 =?us-ascii?Q?pT8LtJZcsn+7RIr/dXRuL+sFdVsByKVQDlFO8cDWEFL393G8WFKtAMeOoDED?=
 =?us-ascii?Q?hnkluKbmOSBthmY24bU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:59:06.1845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4b7a5c-7537-4163-6947-08de4d55aa9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

This function always returns 0, so there is no need to return a value.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 837fedb02e0d..2d5602ef05cc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3304,10 +3304,9 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_stop_dev(struct ublk_device *ub)
+static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	return 0;
 }
 
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
@@ -3780,7 +3779,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_start_dev(ub, header);
 		break;
 	case UBLK_CMD_STOP_DEV:
-		ret = ublk_ctrl_stop_dev(ub);
+		ublk_ctrl_stop_dev(ub);
+		ret = 0;
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
-- 
2.39.5 (Apple Git-154)


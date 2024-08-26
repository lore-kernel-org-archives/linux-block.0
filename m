Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010037.outbound.protection.outlook.com [52.101.128.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44ED82D70;
	Mon, 26 Aug 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653662; cv=fail; b=Hs/hq/A/r8Ul0GtjwXEMK+mSnAOy2oLN9Jw8nASKmiC9Qjthcv36/a/Oxx+cl9lBOt7NCFS06Xroa7Yw+d+IG75vG57GViDIAPB4LyG/gwDqBIoc1EiCPSqQ/ihDDxknlgtslbBYQN0AnYMrmjuj4QdJYkSGCUpQngFnTMpv2+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653662; c=relaxed/simple;
	bh=6Z5vVK4XS0zsPz9Wf08TU3lJylX08xLib1Nr52D2T7E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=goW5Ka7+hb0tUOnWGsyxpxa1kQMybaFd4GH4rDHerZlmjuqOlMbwnr691UwTcFR2mp0UtrcGXOnf3iEk6GPmYSKFT467DFcW9vKv/OhtyoA8B5Ts42V+byBzUIxKK3ub0kJkdhmWvLlDQlTfEREp1/0sC+/X8Q5kbHxOUqC72U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UCBweEuw; arc=fail smtp.client-ip=52.101.128.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UCBweEuw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB1IqPQNEh4XtcGX41AgSGpb7dM9xfM9+O+QNL3Nq60p89z8HWBIqNK4fd5InexExK6c777ztbaf00j3r1uHMh3EUUP+VqLuD0hHaEAX36u6Zt0Od7+Bt1h7vIGMQmXVIORCU9AhxeDNTZnGEgyqTeZqhkbec7xn3Tf47FKjOv459gRQ7uaMhSjuBEdHxRsmcoxtEcUe90AipiMwm/hcUel2nZ5ZJ+/PELPKAfzQZY8WKzZlF6k0mjvtU4+S5q6y4O1XSQIlpCdcXq9z6OjSpcnxfEHI5MZKeJjNhuscQUBJf6uL5Y541gUcAQ8jnGzSTiaDkDPsM4AYxwldjTRdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mad4233ZgwXWjQckIKbJvi48X62od7FaeQM3lhhK1M=;
 b=irm1PnN/hHNKT384zHDjJwcEJzlaxIgjIrD9UtpBwxwSMlR8HfxJHZYPH5u8MvRAHF2RA/vBfcGTNe0plQAWmN5syRJAsPHSkO17N7CNoWGFvzLmC/0XIwomM/1N0ETjkW6fIZKblJZ1V1Qt0KmX0avPdyMNVDZuyN4j0krcCCql5YHVQX1MgClDEeRzGHb7njjaYIVQTieYan3vh4ytLbnet5RmAd43+SbnKt1WNKAUPyWGNpmO4YqH/cyY9YApgezxQd9KOzOojXbDKWAS7YCuT2gIv/ulWTuFNPeIWhoH1XivnUz5HgAFlk0Sq2DNq91Sql9MDb+hHdOaVOGpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mad4233ZgwXWjQckIKbJvi48X62od7FaeQM3lhhK1M=;
 b=UCBweEuwymmweBoVd3aFmsyh76OQORmDvDslYIYKZ50t64AlMLzKdzA4dnxCJEABgL6t7FjOetcvR9mvHNAxwNK6nc20Bxl/G5MCyfQOqgJklF/z0Zq+QgSJZZjyVdVQyrdbWHPCvcbrZs1Kx/vTA4QT9v55APaeuhSfBGVYfP+JZS2z/1DFnXZRC5rfapabz082XWspn8anCPW++o/swQP16gS4TbWFDiqN7dUqmrrQuJyOxxVcGFJr41vkUggttLfoXzU+A+rbaUkX3s+upLdQHmUt+uZ2ptHwwZSrA+ZIWSboHErMnV2m6fHc8Fi6utJT+mZr+CdyRjQ+tCbAQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com (2603:1096:101:c5::14)
 by SEYPR06MB5014.apcprd06.prod.outlook.com (2603:1096:101:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:27:35 +0000
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b]) by SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:27:34 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v6] pktcdvd: Remove unnecessary debugfs_create_dir() error check in pkt_debugfs_dev_new()
Date: Mon, 26 Aug 2024 14:26:53 +0800
Message-Id: <20240826062653.2137887-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To SEYPR06MB6252.apcprd06.prod.outlook.com
 (2603:1096:101:c5::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6252:EE_|SEYPR06MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 70768039-e3fe-455a-6ac3-08dcc5982c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VO1b+SrRyL2Vlj4fycRxDqrDOKBkZyadJYZYrlq2uz+neGjg5smeA2sJQwYF?=
 =?us-ascii?Q?Cg3OiQNLzXnpkYdZ1E8u+/dC07fThbPuXKOPt8L0RT14S4tcDSLGRGgdVAyh?=
 =?us-ascii?Q?6HpH9lZD5jzoSKqDM4UoJAsSQgI5mktiWWJB7hkqlx0peneuKtoCMoC6p1TN?=
 =?us-ascii?Q?uEwRVCSKgwT3H8Yup5N6kiMmOtAXnxqZLWmwIMVvHVuGRYb3ZSUCH1Js9ecW?=
 =?us-ascii?Q?yAUnAoJyZRgIRtYaWzR/oRl2mXXUC9Orr168JeeYzV45cri0R9gduAj6lDd7?=
 =?us-ascii?Q?qZk0N/xBVadcNOT5oCnPn6jJlG2KMLXq5BRxZFMTQQToK7Tt8iUQzCbxBx3k?=
 =?us-ascii?Q?xQTDpsBjVS58CCplJto8H8xU46wPN1DeBrej/r5O+91s51WPQsVrFZSP8LKG?=
 =?us-ascii?Q?4tjs/rCrWX/AjOW5ee7zjwK8YfOdgRnBE6QM6o+bPQzkBAI5KfC29YoDVtLc?=
 =?us-ascii?Q?xsfXJq6eghZzKy9BQqvZ8kvekLjr08XqFTcPkIZOFmI610YnC5sixpn5YN7J?=
 =?us-ascii?Q?YJPRwhzzpauVKh36fEF+0aPor67sGTbpsVdku5rzNE5yK4pVkf40M0skO+4z?=
 =?us-ascii?Q?QO7TsS4GbDYP3TYScR5t5Nw1i/ptC1NGNMV3x4H/NPL/ig4H+W5dKII/gXV0?=
 =?us-ascii?Q?w/ZN3ro9zY3fWMmWmcHzZI40TIQNs4ANsTLqC4PIR2hYgkfV+N/nl121EsTp?=
 =?us-ascii?Q?yOQ096ECw/iwotGoszH/T3WyLPDI5dTYDmmjAyguGO9iqWJ3IJXc6zmcycSR?=
 =?us-ascii?Q?0GkRqqdQKQmlwibfrotDSdoUYsRjdEiYrGnXPz+5wMX1yvsqqul3J3rpXQWE?=
 =?us-ascii?Q?di0hKuQYfHHZDTM34zeCyTJMAQ9uOJW8grSeWr04Wx/xsz4G4H990ckHhSrh?=
 =?us-ascii?Q?svdVoVPTsrSM3LA5LVnsiEY+xAI65cS4QBTv/2yy3e8QH9kTh7qeaXZyZpSA?=
 =?us-ascii?Q?qxjbITvHiqc2AJtD4jOeuckzZEFHUzZZZwmXn5Ij00gm9wF6j/DvbRKKU/iL?=
 =?us-ascii?Q?SLByS46CZjT8Cs12lFosUbVPhoiD5is0V43iJ/szf08V8NKCFS1FKbrCDjWO?=
 =?us-ascii?Q?X/ofWn4v5P+IJktOdJELZ/ig7kpbMcjg+S1fIbU7HfR9V0SxQZznOoIuPP+a?=
 =?us-ascii?Q?atPt5GorFy8LCfjEKy5Vnj3rRqTns6QhcqI5P9P0SapqolxS2YvPldXVo8+L?=
 =?us-ascii?Q?YG2/lQtNX2deaQkGrOKiQ+ZumyVNzBYBtvoXVLFA7qWUSM6p1Af3DwlWjnxj?=
 =?us-ascii?Q?ei/X5vboe2niE2uFP22whV178zOn/jXczOhE4YysVf7TqAtf1WDUOlhp6zzr?=
 =?us-ascii?Q?QgK38BTDNJb8GY6TqdLP4Wxzfa6Q0gFDlZr84DsqFyETCqkcNmOv4EdHe/3S?=
 =?us-ascii?Q?fnDkIJ7j4f89fA6fCM4+ElfbT4SRTEn0SIUWiWh//UI6GbaKPXk6Bvo+0icI?=
 =?us-ascii?Q?G+V/tlxKguE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SO8U20dtPws81440ZQZ/aHmQnYB6ye2fSpSPBTqLjKGH0r1TY5GfGRkv9XbZ?=
 =?us-ascii?Q?kfJL0g7HMemQdHXoRkNrCMoDeWc6n3flyQNyucTR7v17tnpjqOAwJLu24rZa?=
 =?us-ascii?Q?kb2i40PK8W3q3y0SbJBfX2UynrQ0JNRY56e8TXcddAYnksjPL65YVu65NnSQ?=
 =?us-ascii?Q?XDBJtgO5BMBug8qmwatVu/PpZkiaBX8UBqS9E6c47zxTzmz+drBdBC1igRij?=
 =?us-ascii?Q?i9M02yimNYO4M2JuUhj9CPBESqs250Cg8RHbGL84DwizigkSIxu2TnL9FZYo?=
 =?us-ascii?Q?mY2U859eCY/qMQJNddaKr7Mbb4Y3EEPgQICc9MbezVxUAk1Dqp0K7NoBkJ5c?=
 =?us-ascii?Q?vZyEPjiRQmhRNxC7E0a1ojx2VZk84QTTQ2yjzg//LBvY2P+JpJOnkzt8Y2CZ?=
 =?us-ascii?Q?OfyJcclsbHawkIXZhU57W/69GTYU086LXSfiIAv5nfmq8mTO1BFAj+tJIfB5?=
 =?us-ascii?Q?u6UvoOLIilIzHsXplgiUDsE3jYoEf41+w+/m0oWAwwIOg8ER3tENEdrvgLoY?=
 =?us-ascii?Q?mDTmpEmhknG03K/MI00SWAJl/Gf+nqdzMt6EcbAFUnxtK6OAjDMihZ6wh4We?=
 =?us-ascii?Q?X8FG/bVnKb95Y1S2548tAd+6zMifbnDFWa9DzMk5z/10ovvVw8+iP8G6WcwR?=
 =?us-ascii?Q?aCKUODjHKPllBGXYQ/F7rImaOSA9v2N62UcmbcdJFwjEuG1LLBYZW+9PVAfw?=
 =?us-ascii?Q?2xNs8FeAwpESw61NeCQZJdEFAJKUczg1RTWPrPgMtypwP8F1rAzQFEtUhKCl?=
 =?us-ascii?Q?wFI6L+2XhKYGpykXCwOoMQszsc4MBlND7pmbcZ2ZEDPRxbIL2WDlZeTDgkJL?=
 =?us-ascii?Q?8S5ZbZsmmqedSfJ7X5ze4GcGlKPVMy5zYGlrYJe3qXXKfkSkUgq1f5QiVhOB?=
 =?us-ascii?Q?OG3yq+7HL2/cYcG77r5AXdzJU50ldgGqHX1HfVC0HfPH1TbC+jJUm8Z4HGRM?=
 =?us-ascii?Q?9x/uPQ8bme6QoKDnKDDv/w4+1DsSpAopq5EJtPnxMLkYqNSRd91p+UCk5x17?=
 =?us-ascii?Q?JuREU4gq5yPjInd+s9LwMdEIwFgkNR9DrVYomxDsWbGsDxBZ2wnWsqh7ez6m?=
 =?us-ascii?Q?kQCcbAWtVDwRpRBsmnuKlrVS2/i0z+YFiP7ekY2Rf+MNVyDadcafFMxST9HC?=
 =?us-ascii?Q?wXg8/+yYu5RIiQESUDTDyKFYHpJt0bHBKtfRvmYvLe/D0EUyDWwEOEgwud0W?=
 =?us-ascii?Q?K1pRmYFjMYsdwil9Xsy5CrUehfhYeQ4ZlttI2xfIWuMHpecTxQpm+DUs/Nbq?=
 =?us-ascii?Q?czvlQCwtW2hmXeQWlRbeXdGPSvNMyWCDJEqJQTNvLSpMmpz0EtodQK0pzSCw?=
 =?us-ascii?Q?AzTzPk0SFld0wdttxXFxlVGQrqYBDbrEJUztWUxGqEiXWZBg49xHwYQ321Gc?=
 =?us-ascii?Q?+TltE/YTdAOgtVKFgxMfsukiclNMeRG4f3ZJRUhG0ZBYOH//1WzsQb+5C32S?=
 =?us-ascii?Q?vFMmlt4RbtMeAGS+thZjxZGuEQr/0NQFQhFCY7wPUlWALBOTeYAQr8tketkV?=
 =?us-ascii?Q?2+6P8eWak0hUpXDTONBRLHmxWZzqnVex85UFdD9Ccqqx/iy+4DoD2CL02a3F?=
 =?us-ascii?Q?MFELH9rbEsIKUJ2xksZqTiOGlG3BP1dBofrebDhu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70768039-e3fe-455a-6ac3-08dcc5982c08
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:27:34.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRUE5UMj8VCOsE1VSTyIDDOHTgzeNx30PmFGyNuxdwJGjKHggmY/cZtW85n/fyeHTOQ7ENpm19udxa2zFw/IyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5014

Remove the debugfs_create_dir() error check.
It's safe to pass in errors that it gives you.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v6:
-Add the Missing sapce
-Simplified commit message explanation
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..3edb37a41312 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -498,8 +498,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
 					     pd, &pkt_seq_fops);
-- 
2.34.1


Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010035.outbound.protection.outlook.com [52.101.128.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962D29D1C;
	Mon, 26 Aug 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646533; cv=fail; b=UzTsQGGQgpn7ha2ej6GHKXH0150q02e7MEG0Imu5P8Ngpxe0BZ0yzSzT+lqcOJq504kX3Ncf5O5piHSrxGs5tMlpF8qKEsimbK853A7FrTIByDe+40mE6W/svm7UUJIg+crw+0lFI+nPdWpJotBjzoHU6T1kRHc05/rYmfEQMb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646533; c=relaxed/simple;
	bh=yR4oy7AqMoz1VnirkfN/316dU7OBvh5BDmyzb7TP0XE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YL8+Yw1RM/6AnnxTHt59VAGOgcmHXezzMhyd5NMPX5SFAhuH5JjCMoRPKx3eyT+9h91MxumfE/LNp596NyKt+vpM1wrjmwHSiEk3s+wTNwJJ8RJt8MlkHUrXaoap98kt6V987qrlGV+uZhl6C9ny8q5hE/SSxLJWxysUuvHXMaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TpstdwUP; arc=fail smtp.client-ip=52.101.128.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TpstdwUP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no40VtrLcuMb/CTJX19XMFDdIPm2gV4NxFoxgahgeLsGn34XIoFS1GXS4C1+0xoF39xAA/3ChQhlP1UcTRsOa53YA675+xGrfojHj6Sqc2ledyirUPwC/Ud2ffCNhb1va2QD5PeSoGVzVWF1bWUokMDfy4UPNxRiqxP/UIdvz8K+S1PT5IU2hHEn3ldRJHhHLiu04jyWH2XAK0nVLg325ec3BOWNQ6ECxyXUmkjRKZQqKsAzclBGhra6G6en8RSZCU28KGj2a4NmbfsBRhjRUx0LNOJbNkvXJdYblV+1nvKuehRecQVemXLpmZIY0Vz+s16tG5inBsNAsHiN0bg5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsw86pXniOA/BLtX9dtG7QRWJoWASxqKS4aelJRofFU=;
 b=SGO1A2T4UEa/fqawgUrZHde0yrHJqQVAxAHQiCGqUpGkrS6UcZIcnkh6inoo6U+SbeOZtXvxuYBh1f8zvLQ+vC5BFvSkW/3/6ge4hweuJG0aTmwWSgwJN1Xy1hrAv4XuU81IoA234MiKee7OQ4Bs10bRqhX2fywR0I7p5Z/eQiiGcBLT8czW/o1GfCBMMQEefeKhzGC+baaHeGj46GLUN8E4o6QV7awPhUt/LC6+AWX42/Y1fiJ08O8LIr77p+1T1pk7IJwRg/bd+JRk7gdmjFqUx4i3BmHu4CAhUtt65U2vC1oeyWmJBxEU8JzSf/gNNd8Z/k4iIfsm/bgW/eaPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsw86pXniOA/BLtX9dtG7QRWJoWASxqKS4aelJRofFU=;
 b=TpstdwUPd/boMmUmmvenczSp6VtxdwJfTk8ttu3Yhei9S0LJRoRotURrZCmo6PegsQ5FPL1xX2GTfUiclUvxlEg7Ok6mz984tClRXuqXKZNQXZ8mw43OF5CDB2lghI0OnwQRN62M78WljyHavOVPSDepPD8ChQaMdZseWqYbGTnaYLc0B0ZaNUMDMX/pWo7/fXKdBg/B35MvNr9wpaCP9pS6r37CYBwfO4B/W6Cwn0lJ0fzTOyxLGywmikqqHhWVpt3SkuSqd6H6moBTLzgQvQcBmcLrffhmXuJqh1NoKMwzyod6RNbnjVDSNmy6qJx6R+O/rrAc8EWlK0W5ljpAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com (2603:1096:101:c5::14)
 by SI2PR06MB5242.apcprd06.prod.outlook.com (2603:1096:4:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 04:28:46 +0000
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b]) by SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 04:28:46 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v5] pktcdvd:Remove unnecessary debugfs_create_dir() error check in pkt_debugfs_dev_new()
Date: Mon, 26 Aug 2024 12:28:35 +0800
Message-Id: <20240826042835.1911916-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0054.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::19) To SEYPR06MB6252.apcprd06.prod.outlook.com
 (2603:1096:101:c5::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6252:EE_|SI2PR06MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ceafa0-0b8c-4193-a88b-08dcc5879340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUgN7B+lliMG/g1qEu+YUqneKSZXroOmbLQUtlKZDZoe36agOPy+QxpqB5Bb?=
 =?us-ascii?Q?AgXLAsd8DY1KPXfgjAPIdyA+sJfZq5ev0mx/Zo0LYKLcS2gxagKVmqetlLby?=
 =?us-ascii?Q?7QkRxvtv5Gaz6zbEG34+/30Fi0a1Wkh6hEliOsIKd8abhhRphYIVsxb/RwoX?=
 =?us-ascii?Q?7UL8Gdux6byEcYluLi6SMCWjrCOztvZGFqEyrqYkv6l/4WjUDfU6WLUBGIZq?=
 =?us-ascii?Q?JmdrSYejlQwVdw/nNGdawmkmiR+IBFGkvDfjUtY4+5zHTj7p1dTXSAat8D+K?=
 =?us-ascii?Q?aFrekG046y1uDJ1pLafSPKC33WZ9HlXE1sJy5vPZlBpm0vahEyqjskubSkEh?=
 =?us-ascii?Q?EWUwYQ/8JSR4uqThO97ie/8I+uslXshWI8P/RRYdcs0ayuiBH/o3x3fIArdW?=
 =?us-ascii?Q?VOo8W7kuLf06De3qF13H4+RS+U4U+28vlK+fLA5yxJ58ii37f7ksWgrZtR0v?=
 =?us-ascii?Q?xJr0zPuiJlES5oWJ6Z4eY/PhZMVJdzB4uYW8EhmGoFCefNw2i0eE/4hyHevc?=
 =?us-ascii?Q?lMcrpsHzEWnZ2n823Y1QTKUNPvv02TaJKsrWU934yNkX3CG4QZ8U7Tl4zbYe?=
 =?us-ascii?Q?vBY4DVj/emF4juw2/6AYzte9tebA2OUyAWRChaHlnXz02bJQNU7Kc5HM2SOq?=
 =?us-ascii?Q?55TUk2oguTsmxhfBHpJ+SzvJW+9d227vpYwEq0fzmsfxGFsk3zZQUsDUMtl8?=
 =?us-ascii?Q?vJo410/nDJpwyjdkdGNbbcWd6xlefN2zRxBoIOsKn5mXDQdocnhtv8JHOe6c?=
 =?us-ascii?Q?ByyOMefAXoEdlJYXzKHO6QxwGpVxn4rYnko4txutnAXuvrlSmCw7Up2UVeNJ?=
 =?us-ascii?Q?TwnkHOKLwBOSNzEPiJ1C+l8V9oeiUozBEaqzamOzJNWB73EdFHB+3irVwImf?=
 =?us-ascii?Q?hKGSBjgKKWQr1GOq1Z38jsSZ6YVMpb4hwBKPlXConZ8nPm3QwDyrHtRWpeKB?=
 =?us-ascii?Q?X2qHyRWzggxfSl/GyrmhiyOMtd8788bJ/TxdTPc4Tv43J43bpfvdZSzcGZB2?=
 =?us-ascii?Q?Zw9tc+sG4qHmY1Q/2bbewimeECH1Xo/wd+CCk1OdaN8EY00r+x1yTWha4tNG?=
 =?us-ascii?Q?isJHWCVZbZ2KDlHsnQWd951x9EFhu5koRY00eyQ2JBX8oZQVbe8src20sQuw?=
 =?us-ascii?Q?KVlZv7UETiks8oveE4EY6RLILiwopbXCXzjmwpM3JBakoE4dhTkDySXobsY9?=
 =?us-ascii?Q?P/oAzW9PKe13P+LYVBeEEjDaw+o9qb7mLdSHzCl41f+92tzNF9QeFSEcYByA?=
 =?us-ascii?Q?FJeMFqM+NkpdhXrAjgz/NrkqyscpVjXIRQ4F0A7BqdiViRAty+sfyyPP1kyJ?=
 =?us-ascii?Q?BQdLxUvu/yBRpUAEJVe02KOVQRSJujrt+Et4MEFwXGgeAduMcrkMkUv9ivG/?=
 =?us-ascii?Q?5DH/XJ5WfXjCnimgcy8Ts/tvru3/g5wN6zWHeiETWGYc3UfW7DaSOXks33i1?=
 =?us-ascii?Q?Tf1cbBStYYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5NYnAfVXSEDOltzoXN5owxP2n7hHFFchJnH9LBZ7IyNdxKpghSwuC2ec+qe?=
 =?us-ascii?Q?fqztDATkIw1qbzXlVDi77SUJV/DU7M4aydWjVVk/EijyxJhfZe5+by+wEdM+?=
 =?us-ascii?Q?6eOoY6fARzaUb4cZgyZocZNilwEbMyXAEdESwnaX754pzQDcOAi50btOXKzj?=
 =?us-ascii?Q?ZgqIc2BbErHQuOe9hUrDIDmI3uWL79q/2zoUyFzmgfpd+/P3xoCfbzZfqHE3?=
 =?us-ascii?Q?Db1Pxa6aB/XUuRn+olxskNHnUH5ro8ewNTb+HBcKCMfaFm5JLg5V1ZfYat4o?=
 =?us-ascii?Q?soj/I0MYBe4o8Pcj0MmooAboCX4y2QMO4SFH5rqfQjj3Cr6o5ortVRDLzdmf?=
 =?us-ascii?Q?CddowHjxKylmE0YDhndfbuMh586STA0qefMQq3aprIjBZT4LwF1Tx5tMDhVV?=
 =?us-ascii?Q?9SwUVfJ9jrDtBBKOemMp/jgYVzzoqe6v7ba6FHaCgoF+dho460hcQGqcp2aa?=
 =?us-ascii?Q?BwyrUQfa3uzCIHi++j3umSLjUJmj0tTkGcai4Ua75RDAOPXLgtYYweRgbaAi?=
 =?us-ascii?Q?8R5Sl1VqldmAmdk5W1KqEdZ+9V73Qht6C/HSlhHvNUJWcUBAPl3GwSVa/zQG?=
 =?us-ascii?Q?kYbGOdgwY0Y7mVEmrm0ePP8N4tdFmqkIc6T5eW67d28VgUKw2BZD2LoaaGj8?=
 =?us-ascii?Q?AOo4ta/KdQUnXSdM6L0SZ1ywPmdFmlhlesfHUP+RiJhU3RRftXjF7wCGNwa5?=
 =?us-ascii?Q?tBbskVBWx7t60PqW3+x/ghfpW7asff4JQuqM3liPYTnbc3jEUNkzsYxcHZ3o?=
 =?us-ascii?Q?I/zh+eh31/o23f01kad/WvV6Dx5YcMaU76NQqmhdHDHGNNXCZazIL301SCpd?=
 =?us-ascii?Q?AHZ549S3SrDNKAJjog+ZZ5IUjrPW1pr79zj+5D8+UilX43FYqFEP6f2OE+Eg?=
 =?us-ascii?Q?jrGzcp1jUjJc+0Hly7+Sd1FLqjdwWy8cOV2aPpUtMrbYY1G8ySNuZJwqAZvL?=
 =?us-ascii?Q?CH5CFRe24INk5FXDzbTM1JlxrnMK7Iop2a2dOetkxv+jIDEQNcGg+1DMZW1J?=
 =?us-ascii?Q?GOl9rH9qXOcACyyorQIyf5jqlxKJXBkg1Wl3oJnsgkOT77wuADGfIeQ/mvUK?=
 =?us-ascii?Q?WT0oe4f6tSXUvaGylmGrwoifuxC8tzTvHZzYA519a0AXCLRj+QLrF7ZOS991?=
 =?us-ascii?Q?GcYGG1L+OLk1XHcNcGUstnSJ646hzelXcf7SQdeQVpw2tfzQsbktvxlgksZc?=
 =?us-ascii?Q?wZD8SZ6BYy1iFIDVchbI2D+kQ4fnY71UkKkB6jr+8AO/l8JXhMWWyRDOZ8c/?=
 =?us-ascii?Q?Q5Uxx0RYz9ixEYsl5RdVPRCMwRcp/lFQw0OgnsB1CO/F+DyLyaGlPYEkF1F5?=
 =?us-ascii?Q?tW6Sy4sb56WHczR6EUfUvQgQmhIuyQFFXjCHFPvzdsKH/1H9nTgOYDis2Bwr?=
 =?us-ascii?Q?7hm64suk1KhHxBs5ua1M5sfy+3XB6d+bINjxCOrSqavf1ENzSg+Q++zdiOAZ?=
 =?us-ascii?Q?DwW2cqj+jHDDrq3KAJD5CdaPTnFqujFoHllMS82p/gLoCp1GN/VZqgD3Qrog?=
 =?us-ascii?Q?grU5r4wew02SSh6a82gKKIF5OHnmXk3bMNyFzcIJdsy+T25eQ5lk4NdV2iO6?=
 =?us-ascii?Q?QwLyzSfbeI8PQS7wEfPBsBOUDxlAnwg9YTc64kh2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ceafa0-0b8c-4193-a88b-08dcc5879340
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 04:28:46.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNwtBjpy/7PcRg8I/KXO78J60pQOIBHfz7GgDuzE1NmEhV31HHac82aOcm3jFe0ShTOlYo+HX+1I3W3ocuuXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5242

This patch removes the debugfs_create_dir() error checking in
pkt_debugfs_dev_new(). Because the debugfs_create_dir() is developed
in a way that the caller can safely handle the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v5:
-Changed the subject line
-Fixes information has been deleted
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


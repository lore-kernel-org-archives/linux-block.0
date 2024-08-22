Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEB1C9DDA;
	Thu, 22 Aug 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330490; cv=fail; b=ngsAwYHF+HRYcPiVdfv9mWGZcUxGlgQDXzjHNR1NSn4UrInzUgdENRN7gFYhDmKpQ8lnGUstC0RMwDSkoEZA2MrcIo+uOPRrdByt8rC4aRMaiYy3g0U5ULFBlAZgjzJeKdMxPnCHvUKLDxbCkix9k5cnXvdysXxDuegN6/EZJp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330490; c=relaxed/simple;
	bh=WIt0z/bc9gFwhJfuhW5wgIGc7M4P/d7O4rPkg2vfVy4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HFftMPpDntXlICsQY+08uuvvNABYZW8E0duaeBjLtOuaLz/8QOqUcwbcvhyweAV7zJPLMSSMPtApMGFRv4PLaMaXaC1TfZ4rUaMAzlSgjA5jPXw0rquwMVghgYSOdT8BeXIcpTB51ZuBdxBnOuC99D6JqBHVahlasyAAPmseu9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JWNOYtks; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JWNOYtks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCIZhfsEMMQUzmJ5deWiQPQzjjDce5v8Ma1+Oz+b4xYNUv5d4/5DUYMgeo7NSYX/wb4gFI0ojfKFRn62TYUjEh4qNUX8SOfNGsfzP760AyLD1D7Zw9fTRFY0kArj02ynVI50baBQTC3P2nYApp5qlGaW3yIF9FNy/+2bsArh8PPgFV1l+kfeDzoiFrH8D/Xmc/750ww68FuXx0sz7tjiW24iFN5qITsY2gLC3dv/bYIlf9Z/SCYxSbKOLx412VEGJevGqhmQFrfFzw2+phj+SunsxDSMHSDHfgRjRYD3h5m9eULnbpxTcfpSr6NhxWORtVZA40svKzojGZeVsYGCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtPDZwyW3MJIy27bGPusSYZoacn8pxx2u7hO4cpYNRM=;
 b=DeT+NX1vZQ+FQ8Ye+sSWfLW4Q+ohqXOpNnaPPoR/RifrPfhF8Mc2qs7kEwFvSd6EMgIrCdmMj/TSpdiq/Cqvw2H8dg55x5wyKNWUTWlxyjqw9wB11iR9biTFPD4+uRWcBXOs2Uh9btixD4cYIWGOlx43aMSytyf7vNmRIHAbdOfOgKUdICCz9oYUJ2+q/KazyCwXgDKKHVffalWKimXxRdSxnc9DAQWwhl5tg8JezNnftjDOHX7UklgL8rznxggA4XSIwIUTwNvpm0WkCA16q23Jcfb84X7ntQ5fIoaSzhss8VMKVkASOntmstpqSOw5U2EDEDiJRYxntZ5muFW7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtPDZwyW3MJIy27bGPusSYZoacn8pxx2u7hO4cpYNRM=;
 b=JWNOYtksYrBFMKfHLPglF5fKYsBsItUjnicijgCnTuh02+19gmCJqUY9pec1XGLCeZPg1L4N/0c1EWtWyXCEmFN3Ykaa8sLveeXe4FRId+e2O4pCqEfohKlmWCUbzEBtj9+Ao2Wy96zGmIiJ3n+doCQfsfIJ/Z+TWnGqLAmLFqkoNzK9lP5ZtnLOzjXSmzZembeZNdl+86WcCfzV4AMnIw/t4+s2S75Dc/w71cwkV9UCjHEbh7F1z+i8Ue1Pk9/k4I6X45p93MnAsrASL7YXSq+B6PeqWmOn44z3JAJFvjlsGRERqfRa+GvjoREwciV16ak+ImfMRksIKmQHfugi3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB5997.apcprd06.prod.outlook.com (2603:1096:400:335::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Thu, 22 Aug
 2024 12:41:24 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:41:24 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v2] drivers:block:Use IS_ERR() to check debugfs_create_dir() return value
Date: Thu, 22 Aug 2024 20:41:06 +0800
Message-Id: <20240822124109.2259697-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d804d2-6ad7-4b0f-7c98-08dcc2a7bbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Oeiis3+rDhKzkfGQeXZ6ulVAoRA6vY9AhXZgY/7/RwypbhB0oDjLX3HGYp2?=
 =?us-ascii?Q?4GRz3Zj15mE85uYzmBJquvUhDsE4+FBuOJlXNFRx+vYOEk6s+H7JMSACuTZv?=
 =?us-ascii?Q?XOBVFfwr93F/qEBKYt6+ALGO5UmbzrqMX+eHiwbXE6kBpFPOWvGQVi7Q2gRv?=
 =?us-ascii?Q?OdqhzLXKoAqD71u7+d4CWq3CaWUy3WtavQIFE1MIMvwTHufmqVGKJBH2cwZ0?=
 =?us-ascii?Q?VdwP9S5ToRxp97gAxmdSQXn927GKMhFTB8Ja7uxRdAeWMP1a5x/3jWDkpzR5?=
 =?us-ascii?Q?wWOvyrMVRreedHuCKF8U8CnQ96iDhVNN20x4BezR1198bLDBBtpnUmy8dtnj?=
 =?us-ascii?Q?P2T/iN4GEZWTO9yt/n0W1J20mGmgQMmo9QOZ1oFWi1c0u1V1x7ajBWOpQ0uM?=
 =?us-ascii?Q?nbws9PENWP7n2Qx7XKD12bMhYuAfCw8tIhdoSFvrw4qlhPI/NKzWhPWvhpkd?=
 =?us-ascii?Q?32yla/UlL6/y7ieo45OPFr37BAKxvsr8aCVWg+wGLZUeu+zj0Ednxt8Noavp?=
 =?us-ascii?Q?pY0shlA9XKmTIoqiCd6bkVfoJCOhi9Dq+CI+lj24kfXgqk8QSDvkG8/33FZ6?=
 =?us-ascii?Q?cm3VD7/ApjrUAhWmxRF0sn0ENaT4lppTf1pXa/MZEF7DBfzvumRs+dS/fM+W?=
 =?us-ascii?Q?NHy/cJW4bWlBr2op5N5qLdXBLii/2LHMcScdn+t0zIgjHnru0XrAsDp4PJ76?=
 =?us-ascii?Q?EkPIJxD1cgnAUps2kkM6tT4VZTLfBiQivEmjo9lAwvIuHi9li7hXDM54rMWd?=
 =?us-ascii?Q?FlONn5iD53ZP0aRkr5G2gb9U0kUQ0wd7x4uMfl0fOYyCBbd/9bwQM1AVLUyF?=
 =?us-ascii?Q?2mVpKOejOxG+oIr9y3axp1td6yCRfJ7KEgkxI6hegtUziikeQZ0nhM0Ej8XJ?=
 =?us-ascii?Q?IwmE/H5gQticErWxnha8LEKgoV5gXR5J/Qj09M45cKY3qjhZL9Zs1IL5Pwtp?=
 =?us-ascii?Q?Ck8fAgo809Gxs7exhD1fmFXjmAdLg5chkNgqC8udBS/Feuw9t648W7sbS5uq?=
 =?us-ascii?Q?covj056ucRh1Z1YO2jbYaENuUwvy4JgTXwQII7Fp+k088bjjHbrAGhWyAUKe?=
 =?us-ascii?Q?GcAc9HLWOhRbcmfYvklWeMKZQn3hyPnsBJYr6mI8dnu4gbNRTvONMCOO0SPT?=
 =?us-ascii?Q?NsGwJT/6xcDBO/zSA6X0JKX3AdBx3GxM0H1HXjw9WFSV25E72y0EsFB+5wXl?=
 =?us-ascii?Q?WpybjG7Ohhy//0IgsDqxi6aqowwvTX2+vrc+6YDRi4nnK4aeu/4H51JId9v+?=
 =?us-ascii?Q?gJ8EghoYI69alyQt3/2v0wru4aqprvhEhL1Ie9RLvbHxNGOBRb67HLN4mt+B?=
 =?us-ascii?Q?1TsGVAi0wpUs98VaCZngQgJAgShykT2oOeo36YndFkjK5oVXJ4r1UnjOnKIt?=
 =?us-ascii?Q?3AZI4/kJ28jG4E6QywJ36WCk4qjcI92OrcYEDv+3Jhl7np2ixk3shvf7Lwcx?=
 =?us-ascii?Q?d0bHzbbWW7g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bfLW2mbjjcCj9Cot3HKS3uxKBp5ApurK7S3S5BZS47ZOiDwrvtiJ1BiZA0fw?=
 =?us-ascii?Q?qHBCMMxu+gQvZF2/8ZNwKwJgRFLH/Jfh2wEyd2WXr/3AF7WeKvEiijvn0Cbf?=
 =?us-ascii?Q?ItTWscpTBFRrnFJIQNdyH9L11V1mg7kvdiNKJsLx6SvEBiANpF9DnxWZIUCX?=
 =?us-ascii?Q?hNDF9/tNVTDEAwOM1fAWzwOiV49FdteyuVUdd4vRKsZ7OrWcs0+qFemtqc2c?=
 =?us-ascii?Q?pSn83HOVwmnurI+OGT6zCHvGvdYijsQAS2fq2mo5gYS0hgRioaPZPffCzazZ?=
 =?us-ascii?Q?IKMbb5B1CfvjNy85djiHarlzSdUE/742OJH+Mhqq+MoCPLNANw6Bcr4Q2x14?=
 =?us-ascii?Q?XhEDI/1XzRxZxNEtz8e7Q+gOT4LqQBOxRjlyHKZFIPg+PSuO3Hta32EXtf3f?=
 =?us-ascii?Q?gRP7RuBVaqnTV5h7k0tFd7TvUzpvzUy+CTs1dxV8jIMttQbRdgaXQV0q4lMd?=
 =?us-ascii?Q?1Ut1c7Q504n3hBDTSGDbhQiqacZiux+gChCPQlcpiPueEcBQW1Wfuay3a/3g?=
 =?us-ascii?Q?uBasmB93rblT0XK0zkcrPjVwk44VpVEtwbXhg6t9q/fvqpub0fYChoAXbqm1?=
 =?us-ascii?Q?f4Z+Jazof7c1ELZAuiUP/ko4UicxNOZrPvyqiExyfbGaY7H7VdZAit36UwIZ?=
 =?us-ascii?Q?CG8xgJMngwsxGQ+VKLt3olBePTSWyMAcM42LvCmUfAP7r0fBdRMQhLi0UTYu?=
 =?us-ascii?Q?NX+/KdR2uhT/+Jiz08ZgVlYwy3lEs6+d5SD8gmUKGf8VNXioLGKU3fy7Y9WU?=
 =?us-ascii?Q?aZU2nstWLy6FAUclyMoknQjjzPAk/R8e8qnIBm/zu8Q2MaAmwW6YJNOuPNOk?=
 =?us-ascii?Q?57xZPs2dktPs7n+5eOBzAgtJWNpwiAN8PnpQKjAR6XBs0Nok+QQ/XZe+lCEX?=
 =?us-ascii?Q?6Xag+kiCqqws5j628sofi3ZV36WDKTB8am6Co9/JCiz5I8G2Y+4G5mUVzQK6?=
 =?us-ascii?Q?QEhlhmr+oaeSKdW8n5asLuBXa2PwYX2Ry1pCclvc/c3z8C7iNH8UWJgGqwTl?=
 =?us-ascii?Q?AyDMgznfkazNKFTjaYhJYlu3TFCkbV+NFaH9HvD9fQ4Pej0AoUYuFNB8GdA+?=
 =?us-ascii?Q?ZwAEjQ4Jb0erPG8gt1MN59Zuy89VvFq6DZAI0oP2z9f8GfXHeo8prk2kh0S7?=
 =?us-ascii?Q?F6ALfqBx+1I3rMGLt5DJzrlyeaTNn0DsI+iM2keAwA03dq1ZhBVHr5nBLLZu?=
 =?us-ascii?Q?ETXe4QMiXZOdTBUQy8pstb437Ss/cR+0loq/NUr/YwTS7zk0kMoiVYyrs2P6?=
 =?us-ascii?Q?TQlWFUCOEVOYAhE5vwZTJhG86hXWJpxypRozQm5Tv6TIrpcdiFAsHuWA1bVb?=
 =?us-ascii?Q?S55UKrmwAIKQHBUS4XTcOKj3hAkTY7mrjJo7aoWLF+gelpqVqcyPE6l8vqyy?=
 =?us-ascii?Q?HBqB2OS16erv7bYJqGqOeoXIxu0j2Wyd1c7Gb0RO+zt1xAcL06OgGBEJUSpM?=
 =?us-ascii?Q?9W8Ndn6cpJV4Wv5odo5q27Nz8H+o8qp4nJq9/tZIHDk+wavJhee++7iLhhIa?=
 =?us-ascii?Q?diYQ4Werybg7odcQBWC0Ls50Z/LZZOs8adxNh3WoClFiDHPVAIkn6YTeLnJh?=
 =?us-ascii?Q?BT9FUH5ijDzlJxcReUCNcaQ8/t52DZtUvcT5Xj/P?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d804d2-6ad7-4b0f-7c98-08dcc2a7bbb6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:41:24.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+VV6P8YnkGe4sftQVFdnKXuHgFnFoLZ/ESLedW+ztDJIgMv6lYXafjuxUPCAxCGepaqX4WzFmk0aIW8ijMeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5997

The debugfs_create_dir() function returns error pointers.It
never returns NULL. So use IS_ERR() to check its return value.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..030b7a063a0b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -498,7 +498,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
+	if (IS_ERR(pd->dfs_d_root))
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
-- 
2.34.1


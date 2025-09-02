Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012026.outbound.protection.outlook.com [52.101.126.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D812E54D1;
	Tue,  2 Sep 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797167; cv=fail; b=NQUrx8xTa+xNubbsLFq3VJCElMEaDB6tPHIRjEgJaJ8WP1swd9nJG7N8yLACgn6PnQPXCbId5KDyoMEx/B1gtRoPGp3TDUfPAwuAoxt+SO1pYPNboZ3WQ+J7M6h1rdB4xFcTHqrS+oM5SOA2BwUTlpOECvbW6S4pt7aEcnK532s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797167; c=relaxed/simple;
	bh=7BFP6LVtdluVn0FDn3bRFfNmwznO3t6LmdTuo4R1+mc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e6WBEOA8n3Ka7kJecTqAlOZtSk59kGJaMX8FRAhgghW9imQbmdslsHUxQ9iZVNkAAdVk2l/MCVv2s5I46BdekSPp/a2RUdDeriDJ9WuAFdmxmig0vPMvJCnWZvZ5jaOoN2ELSvZOUni6pd29aU0kiTyBewolWjf5SMEr6q51KMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ut0Uw6O3; arc=fail smtp.client-ip=52.101.126.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ut0Uw6O3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puiyT2Xw0OHeYwvUqmi3K3aHBG2mWIx7UyfBKETu1zaUGp4sPotV1TUHWRSkyF3Q7t7/lM8ihtv5MzHjtICZLvdM3aQrZBw4hcCkb+ln16ryjXNKqa8zXtd6dp2/288JYIi7vcMjoqASNi4epkWspHvcfiTZfsfs3IDPpxBZS6woA3HZU/haTLlmUF2gH3XR8ZRVEH0de/AlLnNN8GYM7pNyZks/4VjaayZwWPLzXJRGJRsRrSo1C3hHeA6spCZj1icHPQt8voeWi30iLBGPUvmizC3+FBR0I7mOPQ4jMaHhGvnQxEa6RwDAcPJFpkZXqnPmW7dNvKtg38uRcHM8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2huBgw1HAogPUcpdtJXycZ+3uPxEpgTuFzTKLQhQ34=;
 b=QCZEZ04ILC3A2/wDZe9SpG3V3xpYN289Ylg12cXyFcIM/2Di7yPxCbBy3nKjZ52/qleTaqkOXXJoOkaxYDPF0++soaBh5ORE+Yoc9SozixE02qD5O1VZgIdBxf1dW30vCICMegO51Qi9oUgAR2el9+jjfiJPLylHslqhv2T7kZCmXI9uBsD0rWogvCc2bEDNL2eKhrsVgWhY3kR+ASaSqjgEs62Z18NbBPwmPvmbUkWscZ8g98sZUdM8+FVK4d88hkNKpjoqNbo49Uo2kiAlW6JEgvEtyJqSml2YFV83CNftdCPqjlTL/nnKajUu1knUiJVLv09H3ulUe1hPKa1qVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2huBgw1HAogPUcpdtJXycZ+3uPxEpgTuFzTKLQhQ34=;
 b=Ut0Uw6O37ZItzTFG+ElCoVCe3lBm3fX3uTwh/zkkcC+sGTHKrexNde3kPPR1KKzSpF8Bcv4N2/YoeqioqduoFxmX6rx6tLsG094UjXIqpmHzeis2hMhejQsrp2Ubd6/Xg07xujm8EYeov2BZHFmEsCi1Tqpe5klq9JnB653DrQ3tZFdDfmEG9nfQeZ5HBbovrmbMABmbd0/0KDy9kOVfeRVdtz3dcAF5NXzCoD5vHhfgd5UXTV3i7kZ79hUCSDQIA62mrpoJQjhSIY9gSDODXBc43Z0+xnFH7uO3f/wYfeTPlh6dUZYDnOx0NbD2J7kec6LFfJ4CsrREyg0LHM00dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
 by KU2PPFBB5DAAE7B.apcprd06.prod.outlook.com (2603:1096:d18::4ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:12:41 +0000
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3]) by TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 07:12:41 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] drbd: fix "seperate"->"separate"
Date: Tue,  2 Sep 2025 15:12:29 +0800
Message-Id: <20250902071229.87738-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To TYZPR06MB7335.apcprd06.prod.outlook.com
 (2603:1096:405:a2::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7335:EE_|KU2PPFBB5DAAE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: cc228a27-36df-46ca-ae3e-08dde9f01b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXHhwiDuDHfsk7hqO8IMTLUL49TfgPdBTNkCOQrxOuFndwqIVCVcwpUV4mHp?=
 =?us-ascii?Q?PpjcoeObUmGAgGUeAjDcqYHGZaUlOZm19ruPFAfc5JgWbpjeXBcgn0mqxPwM?=
 =?us-ascii?Q?5muyjnHwh/qb6dvljhOE6NpRJCw8vC+NFYIakxqailE2xxmj7uLzYKn/1Tq8?=
 =?us-ascii?Q?CX6hX4wLvDj7yCI/h1Xq95xVqg2Fxn0DRpfHjNhyvv+KsAFUuNvov4zD6xAh?=
 =?us-ascii?Q?RN+rVAZesVA/admQzaTEpDPimYISUhArXR1G9YwZY3Kt8YnnlTIoDTCdFQNw?=
 =?us-ascii?Q?YA87k81W25W6tc4J2HNcNeqsHnbnfkFUOmjQxZbwGSzitXKQ7att6OPlxL51?=
 =?us-ascii?Q?3jkj3eSlJD4yMUGaheNwpsAe4OfjXCclX8vMp9vBxCJJWSFG1WOkyK6/G59D?=
 =?us-ascii?Q?jviL6SI/9OSaOE1pf2h5iMjTKbrszh6E02Tjg+mXw2tUgPOJ/rEq5SUhCuVN?=
 =?us-ascii?Q?EiOFxFjCQgFyXFU91NWoo1nQjK+kUuKCdS1lQUGtg5QwRtMhf183ucrotLj9?=
 =?us-ascii?Q?FCq1UpJsvdZDq6e/VRkpuJDzdPYkNnETsPCgV/wW6vQdLnaZOlfpgqaK+ulN?=
 =?us-ascii?Q?fdWwWHXClCaD6N/ZvQ7gnnwdcz6PMpTano0mbwM8X/JgYEz4UlqDryqD4pCF?=
 =?us-ascii?Q?Wn0F8oUZsVup8wNPaBeCas7ZkWjJeIwHC90rtIJX6Wm4J1G0bsmEo3fzxveO?=
 =?us-ascii?Q?xkxqzeeTiQz33XKD5gMYLRxvwy3kTyfbDffm2YYKjA2nr0nvuKqiWHV6OwPu?=
 =?us-ascii?Q?MNgq4xziPTu5TUTRa+4tXH1p+RtljY0b/kYLpsjbGhixHWd543acXaO0Rmvu?=
 =?us-ascii?Q?1he/jDXDxJZdw3Xr1NolEaJhlcjGWw9op7wNy+m1dHDqzhPck3k5k3bpUMLq?=
 =?us-ascii?Q?hMVtnnNaSqUeZRnALrTiKwUCv6LmMX4iwIddO8jAFYizYl/a1IxRkBypWv7k?=
 =?us-ascii?Q?rv/wZsiPyQVajj2J+CJyEy1ZGUwkO0keGlK8SjnIH3eQ8AIA96GkJDYi1rEb?=
 =?us-ascii?Q?Y2Npjw188dvKVYaSyiISnRl6EU1oVVZN+aO/2Qn4CXl6Pv11DLW49ObYVxN0?=
 =?us-ascii?Q?k6gktPAq+biO1ZdOKzmmKWByxgAvoadGuOr3OKfrVaV+TPxGFdcLf87KrkBs?=
 =?us-ascii?Q?/EKEGCfY/p4HjsLKDtePYuI0fZjOqDWLU8CL3nZKIbIIn27gv5A1K5VPVMkE?=
 =?us-ascii?Q?kJWq63cQ9PrsO1Qn4/TJE5EHUoGZKL732WZHs32w0G48mRfyhny3a5FL4EWc?=
 =?us-ascii?Q?fY1Il1PZkrI7R1x4WxgBVeSkk2pxzT+rROMZ0a5mWwTqcCdfBf7gHBf/iWFz?=
 =?us-ascii?Q?VyI8g3sD4v8rg2VSnlm7mtxSNjbDSf4/iCAClHQhND4T0Lmw+RfZ3df3r6OH?=
 =?us-ascii?Q?pFyixY4Nr9E3mRgLhp8t/sqGMI64YAtrtIQMOiKx0vICRYq6lzE7alCu0yIh?=
 =?us-ascii?Q?6wEFt/mwJIXwfVD/8s2jgmYGWhYQ8D19J0YMUVc1R0IDQVCDB5ghWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7335.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TPwiKXXuQ7usj4H0zNey5rTJ5q4QUjanad4X1sUA15Kk5cqu/9ljIykI8+Nf?=
 =?us-ascii?Q?JbOcCz6o44CdJTOXFAYpIPHDszUIWeFrgNjxV0I/h8z+hYnzfpyRopA42Bce?=
 =?us-ascii?Q?YIYNk0/syrz9wQ+cOmXoknRCLGLx9gB5Kt0qyaWp6J5+cVCYfsxsSxJzvfHL?=
 =?us-ascii?Q?Zcg6c+f4HCGish58b+4NPxI4ndYTOC68Xaie99SoUsacIndEYc4i7YnRKpuA?=
 =?us-ascii?Q?kXt+oSqbvzrr+RPX5C8jUWu6WaWEbOI0LtcNzBDQ6dVzI+YHoOIa5Ev7n9fC?=
 =?us-ascii?Q?TGb51DSQD9Uzg6mlx3oHyZhlXLPGbUmSwsLnS+ASzEGwQVcW+0EVnAAzEOZW?=
 =?us-ascii?Q?J+2GqjNnNmEOkRZoWcZ6oVSDYwJSrsiHo4tL8iCSc1dfarb/ZVrP6i3I4p5P?=
 =?us-ascii?Q?N/EFwjnZoJa+TQwOv6vGjTl1gnAZF5xgMgYdSFtVTN/3/R3X0RCK8eQRHDUi?=
 =?us-ascii?Q?W89E3K5PSGPW0VPxiI2KpicQv5F7lymqlCh/39kysiKpZQ7TIp6YLxNTdgFz?=
 =?us-ascii?Q?e1KS7RnXry2z9S26dVbqADmo5xOfQIICoEXFZQYsB3J7OWnrnjs0lk51XY3/?=
 =?us-ascii?Q?8P8+z8atSVdeQHMWp/qiVDrbBEzolfSjuq+HAzy+NGSGHnpZreZa2fWarEgq?=
 =?us-ascii?Q?kGy/+vnv/A5G9yWIZDbZeF7TIL3rv7y9ps4Her7Hy9zY74v+xKjE2DpHXWoG?=
 =?us-ascii?Q?Xsbz5Mw2hOqv1c+EZE7bsacXFq6dazLiAyGa2MwhL48rz4r9Z3tJTnhfMPYS?=
 =?us-ascii?Q?VFuZG21ItyV0jemzbKgRPcucz+c1FYvalGOC11kIG8503IA5/dTVa2pIDpH2?=
 =?us-ascii?Q?qlJFukGrB71uqFA0WeH9Gb1sEko1Nvt4mQNCbddMK5hmN38iIcfGN1sajaSI?=
 =?us-ascii?Q?cj7l4/xPjjo5RHXAeLiDW3PjGkDq73xxnKOFFSF8Zv2RWcfDibzC9VkWlWRO?=
 =?us-ascii?Q?eSPEkMeE6WpZLF1f3bBakyMEvCTBonrVlvR84PxaX1TKbOWidLnd4As0ERkT?=
 =?us-ascii?Q?5ieWJA/I1gg/XZTreS71k7VDowhbqesZiOYuDx7PDjwi6CK9gfRSkpbZVQTO?=
 =?us-ascii?Q?085eetq/FI0TMkaSQ9IO1XiaYPLg1gg8cXqaj2TD+iOVYnwBJjETapgCotJS?=
 =?us-ascii?Q?yygItbnjjtRa+5yNW6I2hdE4WSFLYk4Y9VpRDKeKk/dOoC2+dPy/5MFLxs6j?=
 =?us-ascii?Q?/vxoubngRY3JUeAOljRw/fBxhM5Q5mGL/pVVTHvBVhaY2hnwjLR7m0/AbuUl?=
 =?us-ascii?Q?Fp4V2hMG4vAj1z4oo0IQzg5UlknftCecpjgX/dVH27T2Rz7hYURwYuen7eh7?=
 =?us-ascii?Q?+gQBGDfLScJQyWfuPZubwWACcEHaxxrmaOqJalFXcEeeV+cdcgB3O2nfrSW0?=
 =?us-ascii?Q?Vadyga+yEocwcOiAZot+Do+U67aFV7pbMkf3fz2wMPgF21KgTwKF1o9z3Xk3?=
 =?us-ascii?Q?Htbb6XvFDEMEXrvrT+AcsrWU95HpUnS/Vp+vWNuj0hrAlHZsNKRDyod+ktM7?=
 =?us-ascii?Q?ukfdOyxWf5vhU0MPnh23zTWc45nqmcIRcHwVOOkVaVQceZjqZgAqKNFZgLiE?=
 =?us-ascii?Q?jfQfKikdMucrlPrE6NwPgETuf0zxTelEDarITxYo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc228a27-36df-46ca-ae3e-08dde9f01b1e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7335.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:12:41.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3EgIYhzR089VIsfI4pvtF9rSruV8Uvmk8lHAn91orFoU124M4O8XOexovXSc4zQea2cueOSLSgfD3aKv9bJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFBB5DAAE7B

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c2b6c4d9729d..3a90c42fe791 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1339,7 +1339,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 	remember_new_state(state_change);
 
-	/* put replicated vs not-replicated requests in seperate epochs */
+	/* put replicated vs not-replicated requests in separate epochs */
 	if (drbd_should_do_remote((union drbd_dev_state)os.i) !=
 	    drbd_should_do_remote((union drbd_dev_state)ns.i))
 		start_new_tl_epoch(connection);
-- 
2.34.1


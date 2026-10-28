Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793190154;
	b=skY55CUPUlMQi90o5Q9i5LF3RuudB+NGaOhD1mRXZ3Vps3mnKwBM1b9LzNiiUq2lSdvT
	 cXpQ8rcTkyNmKaO4yVoo9Aolr00rc7k+UGPXzHpjnbs9UYD2gkgM6yypHz1gGyRDxWVRU
	 P+AyckrwrNfPZ2tWQiUR21W3uDN/nQXLVycYT4j/q6Y4svuQgndjAWQQDZf4NVEBWcrB9
	 82RPQ4W/zDYkpKNPrfv4oOu8tSz8DcAwhpUerC3XuKONWefim7/L09yt227q0ESD65/fv
	 e8lB9zF19AtoD43GF03iXpUjR07VRFJYMmFmih/c6hEqxT1VxYQpxVtQUus4E3zJcWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190154;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2WfzwRULsed08KY3wrUpInddlwmm73ku+Wd6snMr6v0=;
	b=QETbHHfE7+OZtKRyAb3617gEl/2WZgtPkuxq/25oTcmuPHxHwgqFQ+Bf/hQcVzjHftIp
	 96ztqtSe4m9YForOa2AWVpU4OqqqwfiQk3psuJ3wz+PmRiAZ3IQ7zTDBTwZdW36eCS0UC
	 M398KbjH9bAH1WdpOtxNfau4G/Ctz4vxtAXAwVGw7UO66/A4bCXYxlddW9BceMkzpJCW7
	 azgpdl+aTL9DVNpZJwkF9I0hrM1n8fYx3Wtlv5xSQPwZLhpEtxbDd5tjCSGXGQzac+4dh
	 NiyB0Unw1uPMHh1U/fcuqTL3vEEk5T4+ZjjxYaBZRTUUaEY6PcttS8h6K5fKCG1SYHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=T3JR+1Gz;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=gqb3ISbb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79028606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 12:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79028606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=T3JR+1Gz;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=gqb3ISbb
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793190153; x=1824726153;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H4bmN1N+kekDkhzGYdrsvlrAqVbRg9r4brExEDy/Ynw=;
  b=T3JR+1Gz8Fmj6vwzrueAx/W6pJPq0WJNzu0FTBIEEhxJKe94n+aYoBHH
   nQjM8cJ39p87eiLonuTz0UqJ6gYYtoGL/pXkBFgvPRkkTsTjkJzUvnhoX
   J/yOvRxTtMNp1MgEz6M7UQ6PiinYm7V/TpsQ34pRlPSxl5hGMgn0E0xs+
   UfZZ2WkRm4ob8+Y0SOJc1hCWjHO6ZmoVhn8XPKbqAnvocO7HPHYWCZJkR
   XPe6okJlBnSLPPIeOHpY7Dy7KySiP7yR/dW5kUr+Gzv+PixsUn41qj0qr
   fHIWKMq6t23kDbCSlrwi0Y0optCD/W2x1RP9t5zklukGmkybJrfl/vNtv
   A==;
X-CSE-ConnectionGUID: /F/m3kZMRxCzLtQ6/MKb5w==
X-CSE-MsgGUID: kwUzc4B+TOGTxicO+COTgQ==
X-IronPort-AV: E=Sophos;i="6.27,182,1786982400"; 
   d="scan'208";a="157596937"
Received: from mail-westcentralusazon11013011.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2026 20:22:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/vh0o+WLx7csKJWdoUNAkyxniy5l+Jik5+GuTGqNm0P9CTKcSRF/8lgtca1PCDGoRn+3rKSRJnDQvcDFWFp4dJnB+jzMJmpt7hJiuFTkEEhRWuMDDtrmSC5WDuWJKVKqmvepx6WVI+a9hALg7bOcDHQyEGOGrZ26CoCj4wadr7SE/qP3R3qHFlpCYWDddsCkm8IV75LpXN9SzUW5c4YPihuXMxq4UNYkw/kz4mepXaOljCqNBeRy7+pJHH9AF8lHaSJ7PauvJYwt1hHG6rRue5QOeuC5AzRX/5mCEAMBYGYIkwre0w+R0WF/iKng7wxv/jQZJO6WAppccIsSdFKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WfzwRULsed08KY3wrUpInddlwmm73ku+Wd6snMr6v0=;
 b=pPrPFfFSTUX+XPTI00+Pn8bgKAtDG41C1D4SU4LWmBEjbdhvliv9XW60HtRHIE/2IVnvlDqYLUeOIznoOIBkvieJyGJQADrGMMdrF9gXu4K3GzWqbfq3CSyzUn8t8JfmQw1lx1XHi3nv1itO4ulAmx5bPyGk7yTT5dPtA4yHoOdZHHQGgQTncOh+4CWdhORuO7YACv7I/KYR5ev9THqFDf1anwHTke888MijPmzixdb4iN7UG5udbOrn+23wAJFBBwtn0ADJC+8U4tqRRdfuGCaAyPmL8pqAnUzuznsvbxuIdXnt4llE6y3wY6p8YW0EuKE0bQraCoUOivUOWhWMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WfzwRULsed08KY3wrUpInddlwmm73ku+Wd6snMr6v0=;
 b=gqb3ISbbHyadZZiOIEYENPLVecyO5Nn9lYyu7pDVRkZjcCZri/duQvxDxcEvfwNK1Me38rdRsOaZmcHXOMDmNCMAexylQmGO4p6AEescPsIeh5xAqJ9NT80RDQMQY7HQuwhm92elaNVhQWmvGQHqOroDMebpfHPe1sb1g77knM4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6437.namprd04.prod.outlook.com
 (2603:10b6:a03:1e4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:22:23 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 12:22:23 +0000
Date: Wed, 28 Oct 2026 21:22:17 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH blktests] loop: remove loop/006 which tests swapping loop
 fds
Message-ID: <auHo555CJqqjbFlH@shinmob>
References: <20261020054135.2766271-1-shinichiro.kawasaki@opensource.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020054135.2766271-1-shinichiro.kawasaki@opensource.wdc.com>
X-ClientProxiedBy: TY6P286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::17) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: c8728841-66e4-42e8-2065-08df34ee1e94
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|261009223027099003|261022105027099003|261021135927099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	U899nZm8v786cyw2kfNp1aRv9ovEsea8DBZaLbOoJu1sh3sh3Ws/LVY7lB2jTHivRrAMZccWidDWZRgG9dVp5CXFgSWRObW4L2KqG1Tg/+EVTsRpvWSScbMgttSOQzBw5Q+jbiYbTB3ZMUYBTWTgWeFQc1Qp8y9qEndQUDyULm9FR8QJ1GkI1Gf9eacRdMMT0UDeyz5gVwGl+5SgiD4nQIJZB27x2N+LsZbKpfU8/ppiTLfRxvygqFMnoesollvNOkOHC78dBy0V3/WWUOCI3oxctczcw4qDQcXSN+x7XP8+6KcB0zyVEkxIXE8Fx5PkfLIEEBWB/+8d596kpCH8NrVluA3GHV521owNigWrE/eNd2oj79LpNHPzNRN8LO75Cuc5nACHU5PDGnXF+TnIy0JYpS9GuBxGEc75RQ++1TTNKpce1BdyH4uum1TRa/3dYnsmopkRWzo8j0UalFu2wDCLrjczwP9oyDzZAYKC5yr6haKIAbUOp1OL1PKEFqByc3D6r+MHAMxW6gHp53ZIV71ALWdJCAHj0lEup2Oj5yG0Yp3MwNxtg5x7feqxnNZbDub7Kg8hAgKsZpi0Pl79Udkk7Wv9h34S2tyTOJ7BBbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(261009223027099003)(261022105027099003)(261021135927099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NJqyl8GeBznYWTsfey7Nm5DB3VWMaRM3zKarbaIHq3hopZbjamcXpULOMiO?=
 =?us-ascii?Q?p2XZWuA2r3SOcLJPMQ9XkXyEoi1bzimK5qTXv3hJIPsoU4SZ3yWiMcBo5JQS?=
 =?us-ascii?Q?s741atwcwAKFg7+qEZkTZy3jD+DCF5shurF6dLw/q6mIOE8p8LuhCQsZmErY?=
 =?us-ascii?Q?W4u85JJ4Cn8NVe1ROIh54e6e4zlXEwI5KVqm5jf3k0qsu+iBOKsv7kQM9/3J?=
 =?us-ascii?Q?swqbd7NMIgUP3h7PznCHaYsTOvVXbX/3n48+SMzKQD13SGx1lqaIpcIELgHc?=
 =?us-ascii?Q?n5mJXr4XQmNhgcpCXbPMmwg0gOTiWHfyZZiW6E0vj+ptWE1oKnxvhlXu4ogO?=
 =?us-ascii?Q?DCFjSUGRlwfzpsrT5gPUBnWOqBPfbfvuwa7U9W+cikVeHsuQb53xRO5uPVdE?=
 =?us-ascii?Q?9Lx9XhWB/SKsdmHR4mDAPBOmUJcf8XKUwR2dC7OpNlLKgn+97K0JafJYLL9z?=
 =?us-ascii?Q?z77MVlS0wlrEdTaoMGj7wA3efuiCRo3bA+EWDbTmcUud3aLEPhr3WWHvlZay?=
 =?us-ascii?Q?hBe6EvRWQcC0CeyLZELHIS5jAgVozEiG0mzf5z0tcTcPr7v2LxTudEXht6Fg?=
 =?us-ascii?Q?OgR/oPtbJyDisuCwEkD0c96iAZkBrE5rdzFE8HjstBfzz563n9M2ydtAtQUL?=
 =?us-ascii?Q?w8mfsCLe6taiBcjb4Ys3rH9j+2mAlS0Jn/BlCM5UQZEPAw8MnZ3nrUft7W4R?=
 =?us-ascii?Q?DeSbfJ7pj2JbOiJITjd51qAKCtWxRYHAG0UsyZhYH8VdMti44nBIHK+asWNF?=
 =?us-ascii?Q?o8ZQwxi0WoNd2C4A++W2b85RSXSm0Nk+CBHco38i/ND3isYbwhZaYusykvhi?=
 =?us-ascii?Q?5h8gmrm0saHWGZ/Vx1XG24O3LVzwTiqNoMLT+LlWkaNfYuJhT7HTtqlT/59z?=
 =?us-ascii?Q?jAWH/VjLMvMMQwveQ6AeQg+ZoIBQLuZEqH9i1mhVqqgr96n652wL0oeO6YEL?=
 =?us-ascii?Q?y68HrUoAdHNZtQLBXLWV/qhs2vpXd96mK2Do2awmjy70PG+yUCj1UAo5fDUz?=
 =?us-ascii?Q?kIwRZDVXs864uF6dAw6Z7Je/ZO38+B04OW5R/AhyWgIuM7iEvTQ/DF9vmg4J?=
 =?us-ascii?Q?9BoaL3LbLzXCUpZD9AHfNLK/b/849vc0M4Ki0lQkNVotJNBzOvtxh0kV3b6G?=
 =?us-ascii?Q?JqWxX3yw44JWzEIG7sqaHyulFM5Vv8REcoUFl1KfgGVrzt86riSODcIL/kwF?=
 =?us-ascii?Q?7PP5vUOSnX2NEd20z7Scs7nyTLsmGu+jWhK1bs5LOKNHHaiMCatG4LWkAx39?=
 =?us-ascii?Q?24NaVCNryf8HXQJsDXhemHaZkHOH1KGZAy7Q/J84fZiVFyG0sS3mv8ue5hvg?=
 =?us-ascii?Q?tUCPIrgHpWO3DBktm/EQpRaQx35E9GYkv4ZBVrcxFm3tZnNgZf2TNeIrfJx3?=
 =?us-ascii?Q?aYzzq8IdM9aQBavC8VDyhlDzc3PFVIuF0lwu/y2cptdBUoo0jamlewPNfRbT?=
 =?us-ascii?Q?fWrNbmww2mAvwqvgGi0YiBE0KKLPQ3T/Ng68OdjF8kn5OwOsk1A8uIpJXtUK?=
 =?us-ascii?Q?cg90ZlAmlmje5c5UBQ/Q44xRgARelpPElh/qswl1fESid7ObR9Wy7y9Np/Mi?=
 =?us-ascii?Q?MR10wRFNd9WTuVqLNw3r3lylGUkAW4GdUijqIaKvhGSZMpcXBQyYpBuln/Kq?=
 =?us-ascii?Q?jSLk1zACn1t9bSuSFhUQePiIxTVvL19s9MV4bNr0BJ6oNvFgjVILK0KS76OD?=
 =?us-ascii?Q?ffwTbQWlBY35gGP09Nrz0//JO1F+JplzTbS5IXKtFSI0Z1BpBw2BoECVvANk?=
 =?us-ascii?Q?F+duAZ1xdAA7+xFsRulsvoIRNM5qRgM=3D?=
X-Exchange-RoutingPolicyChecked:
	DBIzSfWUfBciDg/UK+nh5R8rWrojSjVRrX636LUhYSDs7DdwGEyxx0TNampj3vBdjLU4RdhgF3+UYcm0DTAjZSEDpNAiVzdU54HO18HIpryhstonIUsH3i5WoE4wDXyok1t7f8zaqGSLphan/f1q0az9TgVk5OYOHqnWcbgf/uPRPgZUpZRFwUuGYNNvNcRXLlgoKph+yKWAWR8h/VK324CPAnorTq/TyfTjDHR25AFX7h7KMdUsWwyXqUTIR2qvJaiCf67IXZeobK/gvy9vRy7PFb1Icm9fOIGhL9sV00U+2BbDUjuLbzdckvPauiySgKiODXSBSmLrjvqguCgSsw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IQxcmpG3/gfG2M/6aXVQhifqHyhQ2oHKotLdeeOVqwbn2ucp8UGfezIE9zSmPJXiS6kjl3VP4IqBCfMqBQmhX50+HlG8Pwc+JSk2cS0TxXKIq+2Xn/CheBAa7kTyUjmEZRGitWzj3Q2XTZjjIes9DEBRe1yj7geb+DDwoFN4oa5cNYGt5PdN+O1s3j0R6zzx43lBPXj8qUJF1XZ7rvtSq9tVrTPTLkRn+xuQIzmXEoHRja8QY42l0Uctm/r/V0+z0W77j/bRCr6kAXaAuPWm5TwZ69nXfZo38HiNX/Y02ARStIbVb7N8fSoazkwWp0xzgX7XZGo91xNmLwvx4+KGtrfo7ZIp6HWQJCJ6mrIkiJktiu0ovbysNLyiH5/30ghNEamCX4YK3/uEOAwN7saT+QpGb5l5LMBfl7xafDVP105zGQejo6slxGCbfRKgRnCrhJmfP3FvWSU3yBnvPBP1rwwEYT4hm/01lulZzHGwEYkFbjsIiSGJjywVVxbk0/HhHn9DOd8p1B6OA+EBnNZ5oTlKCr1FkEtx7UbX9WNR5p44foRmTAxlZIYCP9DWIMyc9/alxtX1QU8O8V61eiFt8eicJy8PLl1EJqQ/sYzwAdyf0E2rxJPWnKbDDX9A3ubY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8728841-66e4-42e8-2065-08df34ee1e94
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:22:23.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFHxmEz4Uh/03EHnYuefqafjZ3kkDim0GDyj6oCy9e1Kz48LRsXZ7MxefWJTaC/iQftYJPVaxp9MSF+WhQ4RwkzVhWPnuXjQ6sQqnUTefvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6437

On Oct 20, 2026 / 14:41, Shin'ichiro Kawasaki wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> The loop driver is going to drop the support of swapping loop fds. The
> commit titled "loop: remove support for swapping loop fds" is going to
> be applied to kernel version v7.4-rc1, and LOOP_CHANGE_FD ioctl is going
> to be removed.
> 
> The test case loop/006 checks the behavior of the swapping loop fds.
> Failure of the test case is expected after the kernel commit. The test
> case no longer has value. Hence remove it.
> 
> Link: https://lore.kernel.org/linux-block/as8-8rDJmUb1FxbP@shinmob/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied the patch.

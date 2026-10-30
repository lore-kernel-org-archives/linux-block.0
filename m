Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348753;
	b=ysXKe559Vp90F7qgX4jqxj5prrw79S/vM2gCL0SZVCP9ePEGyWPPsKERx5eJSjnZPMKz
	 ViNJ3NYUDssspjTMtD5rgrVWHCkERB2bjvnPZ+ego0jCwdkwkt+P7PVNWrNmwxxfsufFL
	 WBLbrDRgmfe1059tzawfQCLKpQ+rtkaBuGQrkTlwcTqBBfjtmMxRa8Y+IRfp2+oUqFaT5
	 mcqep37wuNkf+lbszRWUr0BdYWUS7ynyvEVCE/e7y5/XpdrLLTf96Qfe4U46Rhfcak4T2
	 WFk/cWloezvVSccLoJfVf24mVVCDP4JHXW80QbdNlIOaTSjTgn4UoiKmBHH9Rom5/Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348753;
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
	bh=jYKJdCj1KWTSOKyya6gDQKUIDn2FK4hrdlyS4E2LRrU=;
	b=pcI5dzzIoL5bm1Tk22Wynu38UX+TUBl/raomLkjUTlQCehPLb20kLBODgLDpZXq1E4kt
	 FA3PUc4WAdhnHUSM7QBn18okyKDL8BVodxfTf7qTSo/ky+JWJ8g4bIsYEHFV3YYqqLbnf
	 nydcJvNZP/GpAHn6jkwsFzV2tOBvlbk6x8cRE4nAviXrtvQhjSTm+yCAxcsX/gqXsThN6
	 Kj4xVr/YN9UoAfyKvQ33RnwfNrkuOx5whKVRskyAxhD47DDC22+q2mBp6QOf9z01t13vy
	 SN2GFbAuePDWR5wcyXkjdYRnIrS057ck9Nqz7EpfjjnBccvRTn7+MJPSIVHF+/dBniQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b="rYm+/see";
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=oXu16pnO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5F606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 08:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=rYm+/see;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=oXu16pnO
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793348753; x=1824884753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vw0ZBRwzcQV07+Z1WdIEF1ckjpmW2ArTxDdC1QlxO9A=;
  b=rYm+/seeuUuEOiIcq4ycFSZF27+Y1fIoia6BgKfObnPyICDCdSb25lgZ
   OSST0qq4zPBFsFVdOXqiD1jt4DjjB1+vKwXAwcPgDc3gK/YFVg79tMTmr
   adXU7A87hW7ELFPXpvTIsQKxNkkFGejvDFWMcfcGYdUjYqhkaNs10v71/
   dKjkJ8wxDfXJAvd/NmzPorIWkhi0Yg8ftdEeRsyqQ/7kzFRnYLguCDW7N
   ZTGIblQIj1snVpy+FpXTb6MwG2/ct3fk28IUBG67C3u4uv3nK+Uk3qmAU
   qSLqAc63pDevw0L0Rlr56ZNG5TSSKtwBqEg/qsZOuwJ5pUqRIYq18GmlD
   Q==;
X-CSE-ConnectionGUID: hmLugBmVTS+rR2O4LFu3IA==
X-CSE-MsgGUID: Pyv/wT15QEiv7wK/IWQBRg==
X-IronPort-AV: E=Sophos;i="6.27,186,1786982400"; 
   d="scan'208";a="160363473"
Received: from mail-westusazon11012056.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2026 16:25:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCRkcUerZmnGHeSX/KbDXxa9paxf494GqnneRLMx2QdI89tILKj/C4oUAyH/WZ1LG2oGbqvmZS0e0YZhmqTaJAGKMCZeIDFqjnN6rNYl+Dnuqfsr0ZQGd27xNwxpZ6eYW/V2iI0/TE5TXMkiHvtzEqCcy/MpSn+JjdQKA2LR7r4qDFphCNa49KN5p0NwxrnnlqyF9v3m/Cvr4nDULx2u7DSMu4U2vwr+ey+NwpTs0EdIRFYGwL3PYcolOszK5838ykVXeRJqKgq4XWFGC51SR1IjJcCO2KRJut67ub2gZzwUxNCKsBq7qwS6Q8CdYqZSwcuRLEgPsAXn6+I6LHWk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYKJdCj1KWTSOKyya6gDQKUIDn2FK4hrdlyS4E2LRrU=;
 b=lf0IoWOQYimYxNMczU/ixX34wXppPxhMWCBeXDb3qlNq41W78h3FHbn3KEUMBuXscyoQKFiskJ99Y0lIyNwiGKf+5jbWcAEG3R+OxrUCyo7xPDpSKD5AVPquRcPXKEEuS0aQHLY+R5QZqEOwS4Jj7nQ4IpqO3ro8pN8RxA+Kok7Zj4dqOSvBPcCtJnh03xPo68dGUWAU8QsWrqOxQ8E0kQ0bM1vXAzWBCAOzOQnxOulg6nLtHtMgBK8cL+58QyLOfXFuhP89xmlgIqilFn8xKs2O2EIp5oFy3JxPjOTfBzEbwUufcobm9TEfKAFBqQJXo9h7pawK5vL/Axf7jpL5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYKJdCj1KWTSOKyya6gDQKUIDn2FK4hrdlyS4E2LRrU=;
 b=oXu16pnOp5GeO7Pd9JKVu5VyNLbOZz0VzRH1Qz/Ebi5IYiwisg3UbScN7cPqzkOsZG5E4DaNzIrBNOmpI/kwZeOF1H8/eo1JRETyKiLfxmf/KpfnNv/uAPEo5MnQB5jveEJYRECSQIkUbZA/TiytPdGoK28QIiP8xOkBDpWbavc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CY5PR04MB994139.namprd04.prod.outlook.com
 (2603:10b6:930:128::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 08:25:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:25:50 +0000
Date: Fri, 30 Oct 2026 17:25:44 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: dwagner@suse.de, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2] nvme/071: add multipath command effects log
 lifetime test
Message-ID: <auRUMTdjhUgR1Pfk@shinmob>
References: <20260923013536.411702-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923013536.411702-1-sangyao@kylinos.cn>
X-ClientProxiedBy: TYCP301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::17) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CY5PR04MB994139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbbaeb3-d40e-4fd5-bddf-08df365f6795
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ehh9anx+8oFueKBJhXCw2ugD06k0CUIIs9m86kD3yFDKZrqVS+HVnTV3oWXH227g9O8BbCT/YWQq3uT4pPqt/ATEBtJTs61uAZp5ccayceZEjV+2CBAzuG0XROrWn7co+5ArdQuF1oe/cPbQ1JBle0Fq2XT74ailOu3ILmDZzmGVt/RSF3OH/lmHV/079ICzJTcwp+SdAmuUfFPU6rLVnRW0SPctzffvbZv5HwuDs+kPPexZzE0hdY3TC1NKA03e0Er9li/bOA56DeYT5OKsbTTw/9nobdQtJWvoeaWLa8js9RUmu2xQaRSokXMbpjnAFYeTtP5SPp/Fv9gVkxiJoDsEvsb/XE4v0NdKO8sbN/R3phpha3Iu8zBgYWymDzMaYhY8iYVURnDl6GwVsEIePJ/7vlhrpDW0fR6CT8y7YUg3LOkNxrQd1jEl7q0y4msTLxMAQKEPphE1hHrrvulc900SBkuGmhjOQLblZaAsiciYrqvAjcg1Wa8Aiqz4xjEsbPgsPdkGdpjwVbS+eNIVo+YWugFZO7oYOuCQ5huj7RvxV/DolrcWOgmR6AwEoXpjZTQj/ANSQB/cBd1ulfk1f7hlhICBJJw5M6Nmsbu7pN3n260hjKZMel4q1mETvPHalOQIE9qGKstayWyucC4KwzhD9nmUV7g8rqswYc3hgRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQSK9pjHN8JDkswK9IhJvLK0hgcJi4HZEE+enGdvU1zOTUb4WhIjM/Md8++3?=
 =?us-ascii?Q?QEhUREAE5WtSWVR/j9crFUwsxAqkbhQBIC+2R81uwBcUirutG8ndoMP4ZRe2?=
 =?us-ascii?Q?WdWYG2J3f6MYWwm5V7O37lupDVjgWrz42+CsszHi/HZQpMC3WXyoLXugeCSV?=
 =?us-ascii?Q?EBKZu7yiRtFoXQM+jRzXf/wtxzL1Va8IovTljUzG30y8Tnd989OBquflSWXq?=
 =?us-ascii?Q?6dyQAPrq/wIb7erluiRZbeZaHIneNuAcZFimM6wp/IxrC4LN1u8xS5UX/Mzs?=
 =?us-ascii?Q?GLiTGhRwUxj2ede2GnBpOrxG1BNwkDIrkbqg8e50BJpXpC+LHps4OkcGNy90?=
 =?us-ascii?Q?5bO39Y0xMlgVOeOknk8MXykD2smbrb7O2pzc7zY3l0POiZ4UBVDzcqLcNiBS?=
 =?us-ascii?Q?00Ix1TWd7FCKjB2t1b9tySYrvP/7e87FsBs1oqPg0QS0kTwrVeYfIfaVHrxK?=
 =?us-ascii?Q?bn3DaZQnB58SEJOiWqKOQ2qG1OKuJZ4oeup+fjmAG44jeWiKMZ9cvBOXIfsy?=
 =?us-ascii?Q?ML+va+IsIuq2t/qMkzPj44ZfmLOJ5n1Ruro8C/+OV1OSwTYMeveAQu5TF5Ur?=
 =?us-ascii?Q?1ivzyZqCoE8rwJZ+PUYWn/CmyGn1emtCL1ZBb/vaPY1j9UXOfDZwwfinsLbm?=
 =?us-ascii?Q?jGSoQ+tMy8TAEUBrdeCwkjJ7XLWgJvh9jl3DqQoCG2xtUhkSxQr0xt0ksbvu?=
 =?us-ascii?Q?aSbIWKBM3CSOxmK6TUcojv0LvZXrPtWIFQ6AMBR3syRvEliOxqN2xkOlcNZ5?=
 =?us-ascii?Q?9ZTBigyO12yRWmnzZLwDe+uxdEGbA1cW9Oe2B8v8b2rgRx1GmtlauzeONLBI?=
 =?us-ascii?Q?tcyfkpm+94UbUhrbHzx7TKGVdXrC2agRGbMUMLyKj6roFHg50ba6FIlxTzMR?=
 =?us-ascii?Q?Q2KV0lNbfjgWJIyyvaRlK/11OSd+zUtOQjA1mehnpRDE6ec46WdtfS4zm9xD?=
 =?us-ascii?Q?nPOzcULuVes36cDYgtwtsoWC7lQ4vWMMn/9Y+7XY7rITow/40VuUa95umgJl?=
 =?us-ascii?Q?Ygv4tC/objXeZUGhnQK5NS0yU6izGwjebYRopN+PtkHXK502/ifZ/EIisQUP?=
 =?us-ascii?Q?nRHT/MzAnW7r7OgK4qQdmsMpbhlG/7IHSaC4FIxdUzAQcfM9pnPlDz1nmIl+?=
 =?us-ascii?Q?kvM1Jaq5KlG8X2TUO3ke2kYJ12HKHflXbxEpNkcyy9Mirn6o3o+wWdZhHN9I?=
 =?us-ascii?Q?du8UqmYqCBeQm9/IwvJPOsxKrEUrGU/wWrbXWoKNd7hILDXnhMi+K/a29msO?=
 =?us-ascii?Q?roNJ3F5B44/ba0JRSIcTxF67mmd0LM+tRhJ7ezACg5m/CKzvrRYGAzZ8/WVV?=
 =?us-ascii?Q?DyCrGiJ41JMU0kJkUG9d9uQHHekE4+TUKfwLXZoecVcWYc8QaBQ6p4x49maU?=
 =?us-ascii?Q?IPyNyhpYrTcoRONw3l16HGdLeWJXKNkeixzO5HNY6bfUznsBouemEVc/cjSW?=
 =?us-ascii?Q?1HvsDGjmV9NutPiQ0McysCS060aSeuRvFNwDAynX0pJQCZtg+mbnIaWarU5W?=
 =?us-ascii?Q?CKG2SdwdowulQi6U3MqTLF2chz7ZgMyyAx1Ng2MeTihjiP5g3MTO18Y8NT2q?=
 =?us-ascii?Q?YwZOZTOFw/W7NJiPlK6SPYCu3hs7x2HJI0keCKUVyyPaK3yAmLGnKDbteW4U?=
 =?us-ascii?Q?IKX2/t5WUPGMu0JpOHRFYzDFtnMbEt2QkZhdM+Xizs5hZeDPZ1CrfDzK+S0n?=
 =?us-ascii?Q?8DSPnhLFP0TyzbjxNh0jnGxnJP2i/gGhmm9LTJqKwquo3yt28hR6ukAEsv5a?=
 =?us-ascii?Q?u+K4AJQzHiYANjy3N1LA9OQKUyxckKA=3D?=
X-Exchange-RoutingPolicyChecked:
	FA2ieIkyJIqCk97+IKHj4MpJQmzpwzPjbNfROOg1BjLgxi5U/AAyhl69gLnWD4hLAl14xRgBy9ZSn3K6efYNO+4m8P9FKkERHBD3DoCw72t8HnAo7b7GOjDes9mV5hcfX+flzJtXRGSJoJdDY55ZImWBKL8h9x5PHNIPg5NQ3CfvSEFdLAwjiT1J129JO1YXLUpDzjl9fz4wMD/Tt9FTaBmo0ZTjkzKK1uZUFxakyltiQ2B54icpQUCkBZqospD1RKGoINW8IAprKU78AjM0tJzdGWi/z03H/gVEzcqPT0AV5IxezK5pDSIvXCHX5V+nFpiJpfem8/B0JNDkBLM5fg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4nEYilwXdJKfe+46rPJxs3lDh8B+gJQbqeqrXWkW7wrZPe/3zjZZREp7JGiVnHJ9KSdxZldlvBa38OaigBmttVs0bOlXKrsJVd7mJGI3qOEjsZ8OXUA8AzNqV3hm6xchY42N/Sf9aTZP1MkYLHCNaN4ereEk8+1mzX5I9qNcpQlBfq9sVGJpMiMIMBBbscBWZpaAPmHDypwzkz0jpmi03j5j2gwWtN62PffysWageK5zSm+oJ9REXQN8kjC4F0MZaur/9oF963yhaLXYQfBC7AZx0dxNFxL0o2JDSoEEnaSvmh3Xyub+tkBOB1WifFJDYaup2OpuZLDh12wql9BFjixxdUH8Zrl632FlwtLm00UBe3WZejpaef/LKDGWldVAAN0gb7n7fj0d5ZL5gzPu3ChaTY365EDxQWfIEC4voevvQpsut2pR4cE6ynmrzuiRfYHDqln5XK/hmk1lka0dQlHrZti/nxwRFXaZbrTBC2co48sBwoQ6O7yHo2fFLcSrrfkzkwWuIL0A8th4sB2y4iL7UEzk/rVt9JXi7rZWvULCr29eWQ4GJBm/Y9b6DDt9OuRzekDE+tV0lv3e8TBqzIKkfyaoxr6zn8nJ+rd5M4BGJYYd09Aojdk/C42XH5WZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbbaeb3-d40e-4fd5-bddf-08df365f6795
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:25:49.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpem+x4gcrIcpssBagmB4YPo2bQ6jM68pkgbJ5wicwV28q/k1HlJVA7UwpARGUICvYMJeb89CaNyDFm3VDrKT7LP9oBUzOy95UupDV7vgtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR04MB994139

On Sep 23, 2026 / 09:35, Yao Sang wrote:
> Add a regression test for kernel commit b2461c48db87 ("nvme: fix command
> effects log lifetime for multipath heads").
> 
> Create a subsystem with two controller paths, remove the first controller,
> and issue an I/O passthrough command through the namespace-head character
> device. On affected kernels, the head still references the removed
> controller's command effects log, and KASAN reports a use-after-free.
> 
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>

Thanks for the v2 patch, and sorry for my slow response. I applied it. Please
note that I renumbered the test case to nvme/075, and fixed the relevant kernel
commit's git hash.

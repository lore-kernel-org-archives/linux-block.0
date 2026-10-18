Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0ED4C33F9
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330343; cv=fail; b=pwl3nPj7KcIQLjf2ryQqVNWJfruyOHSDXB/fN81vweE5cZSTBSzpyeGVCPYjUF4ZM6sAg5WNy9+1KGjMm1FwR52Z2pZutzP0PMf+TCh5L+2fNFDjrcw5DTUPWayP29r6c+gunO+X8L0dbyxhspCi3Hsdv3qaaNrqEwyVPRu84sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330343; c=relaxed/simple;
	bh=6hry03unZz8tgviOoRlygKU488qD11swBpKrLzu/5cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a+ZiYO50ybz5fBQOJljH/Orp9iYaTBHc4xDAct3zokN/TgPrD9BN/M5YHOGjaV6b6aCAfUIx4R87AH3ofz0PaZLeobcxhGmmeDfDZw/tCqb1Zg2Vm1jZwcYUv5han/IsD7Vrqq3Z3UhdnAB1Xeso6vinrowPG5Fze80OeQOwHtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U2NEK7Lf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jOCSZFOF; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U2NEK7Lf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jOCSZFOF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792330342; x=1823866342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6hry03unZz8tgviOoRlygKU488qD11swBpKrLzu/5cI=;
  b=U2NEK7LfqV6kxUW4/UT06kDa2GXmMxOkcgfHb2Uf1kE8G92/Bq84MZqK
   wIxMSE4Dd/pvFR2lYWxdFFtHWgixm0A9VREbasIJA6/3ts8PFXQA7TYuq
   QJ1gyvn7UeqNN2foOjqPRX/R3O+9+/5uDRclgRjZDkytGaMFhrQsJJNPP
   J/CEIz2gX9FUxn4ClbqyRGCWptACEEDS/o7xoRFTZwaKF9K+QIpppVd/U
   4igw5LukIAOQxVI2vtygAl2nZcupxqUHPAoDqX8jPOHI8UglEQf5F+tjD
   B1N/kpEgjrY3zk+h4CGv9GT+GXZqRX0tkeEd9NpzUxPgZ3qePCD8VRsYq
   g==;
X-CSE-ConnectionGUID: BCQSWhWRSLi7TeQriJOheg==
X-CSE-MsgGUID: n3bTRmHmQPyfONJGWO/y1A==
X-IronPort-AV: E=Sophos;i="6.27,165,1786982400"; 
   d="scan'208";a="159334623"
Received: from mail-northcentralusazon11012060.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2026 21:32:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snnnxtdGtqx5S9w09k56SzhCOqim7OhjK01CtjP3aLBOzFnMiyZDDIGOlEpBCzHZOYHtMwAeS9kffKv3FBQvX3vV9eQ608XW3xtszyaM8/K79AwlESmiGqJshjpaautlMo3M9Xlk4IRvb9Bq14S7ygPWIrhmHUGzeBDhdIiycasX0mlR2Erl6ozW7q/qp+qkFJFZhCnKImJNwkD4II4P7EFpPpD8Nm2zB81u/+OGrHYmkMrGSooLO/y1uiuY5qx8U/bNpc2vM25bUFHTEGTH37X2/+5COmHy8Tc5+g3Cy3bAyZlTaU68Nnj5+IEW4BWXoVsBD+3Sf/b0OZpkAwNxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znky+z9Ta9nCj7DMMYjHpuVPuhshmOeHErT45HHTvqc=;
 b=K+6eq1GaS0YZ7Jv5JpMjkECEVbV/QvAI7jCjF91dABqqvkk6WlX8SZ7IWvKqw42aVsZX0rDb7CKYJzpIk+tb0/Nly4bCKKjWe0BdK0w9pYzjOsfwyMtLyzaJCIpjCRz/W+BNHNLFNdfJ1laFehCN4eBrZXw+LYB8RBNON7N9eJFsiWz6frUHYGobkqNtqwX34meX8KacUz7x9re1uNAqTWjv/y61/LBHvPGYqJFELhESFngwHjDFIwtCQ00PYJpSet51pynhLByFqILV6gGfmKYafvs4iw2BrTwPN/HYskn82VXEPJRzlmQjMFf4KL9xfoEAv42e9oOpjJXLBXVVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znky+z9Ta9nCj7DMMYjHpuVPuhshmOeHErT45HHTvqc=;
 b=jOCSZFOFWLMXgOv8eJ1j5NBree5tpUNwQ42LMh2vXOcJJ1aMpZil7vx5Y9xzuyKpCWYmZbPBAkWWYiqMoOZUMZx5QKaj7IaXpkCP2o6iG77evWn+WW5E9cEAp1r0OMrqxiQfirCX65Jy9NX1aKRJv+MggbGFJWYBxpyqZHQ1BSA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV8PR04MB8982.namprd04.prod.outlook.com
 (2603:10b6:408:184::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 13:32:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 13:32:16 +0000
Date: Sun, 18 Oct 2026 22:32:11 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [RFC 0/4] fs: support dma-buf backed direct I/O
Message-ID: <atTJy6MLgDXV80Bq@shinmob>
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <25bc51e2bde7437dc692cd60dad9acb68a6522e6796b9e79d9b73c89eb1607b4@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25bc51e2bde7437dc692cd60dad9acb68a6522e6796b9e79d9b73c89eb1607b4@mailrelay.wdc.com>
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV8PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6a4ce2-1ba0-4f82-5841-08df2d1c39f8
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ccf8GBpNariRjbNuQcN/cknCAp4TsX6DRqrPn5yb7clz1b7L8mkoMsmVgzxKGro8QsktjOHU+K+amgpsXpd/WAqLq4fu3j0pOCkUQqI5jnCJYtK35H012891fyhFi5EsHi6x5G0CrooherwFsIDnNdNiqz9LXWoV046HHGSuMUPbAclJfUQPVvZb7nEDDDMMHmMBldMjKh9YVZumoCE0vGNXaly7CsTsNA94rmfsn4yzfxRE3gJpdJIqHKgCO/zCQp8e6QCZgo3BuFPPE2ALNhqeU+aSuffccw9nmDMB7LDWn0pt6t+xh+iS5b2jSH/azc3yHkNLeMWT2l+6YcLSQeXmOH+GD5c9TOovQi9xrqatQTksvib5RQwJPCL75LygM3DbWh9ZCZ2yHhPyWtZaaOCaLADmLxMsCvlLAaBqo9ZsZBTHMFd4RYdkkppZtGz7p4YkgBwTOZ60XMY+ryq0EU/LXzpHcqv/PqUIC3E8gpERtHFs8Koy4V9kqSVsYaCCG+tzdyYcAi8yLp35nH0SyLu+9ZHuYB0xUf+vuVTAZnBTSOwTp3+dKvNLRbVEfQa8aPYne0/vxJyXVS5Ma6VL8trlMSfzdGogrM4O1P+hJYrXmBy6o2uUG43/t9T8K1xN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpx3sb7rrgBZ3wGGXtdR/rf4CsaMPo3YUL9kuOSyV/413z0/eQ+mC0FTvbow?=
 =?us-ascii?Q?OA4waoVTFKvAgtPX11zvajkf1Lg9F4n6FC8CD2YTcZ5cjPqV4OyjJE2q5XOt?=
 =?us-ascii?Q?yyqwrCMqtepfQuJqNoxP2r5Kj4hWAInwRukFgx6kkHOIC9FW88HeJbMAne+f?=
 =?us-ascii?Q?bWzGlRxubY7xHSN6SgbG8BfkQ9CQDC9finFas1ihbngXCaiuW5mD5ELxYWpb?=
 =?us-ascii?Q?fQWS2AE9Yby2Xy0kzhxK6Qouv3xn0GEjaG4Hgzj/76EKgXY/x5sH1sxMG1J4?=
 =?us-ascii?Q?LVC2/XmsIMSZlGIGleKPHPUbrfwJ+G6SugRJO6xihbz/ezP+sCLJ9jBHj5FB?=
 =?us-ascii?Q?WQus9MSIAUZax21pAEIoJCSj/TFW7NL4sixE6TwExbLM7ySfVnwChp5TtSBR?=
 =?us-ascii?Q?Uliye9ir0Lq4QywZov3pKqhQlTbNDRomgkkeUQLatCOFldDQ6D2I3OJMrKIh?=
 =?us-ascii?Q?w2g37R8UL0wTwLHZ28opyGKPe+UABC71S/ni8sKKT+tly1/cK10Ml61E3kk9?=
 =?us-ascii?Q?qAFBaWB6Uwz7VE8enQlOIBGZcq2iS0pipmznoCouOLnIWIB/85DxvpxkegTg?=
 =?us-ascii?Q?WwesYGcatDBCcBGaAiYhrxV/bEWADMPDn+6uGFMxatSkG5iTBwV5ICb51jKf?=
 =?us-ascii?Q?D2y26nV6OrtiQ7YI8GTL2UEI+QDsJEdpcshDon0QJPnoH4flIVxQyL+xGeUX?=
 =?us-ascii?Q?e3ke+Z00KrUkE0sxQBc1i4J/bwBVQlU8ry1otUYRbriXy3G5xSiaR1pN147z?=
 =?us-ascii?Q?v+PzTDiwQ0SghuPUnxt1lowH+alVMMh8UoyfcoosV4J2fjxXF//ghhQ4257H?=
 =?us-ascii?Q?sA/BfjSYs+omq8LGlNCIJQbfnhQ28K3AtPYGVOqg6pX31ZxOe7zLbFeZPEy7?=
 =?us-ascii?Q?Yo4OzncpxNdmUggsjD3bF4KuKDckRtodO8rqEcWa3P6wMHRHBrwkYJloPkqU?=
 =?us-ascii?Q?z7Lx7WGqa5292pRSCvc4juczMeWEfo84uQBS/mZVNHTeUiQ/Db+JbKJtnLMy?=
 =?us-ascii?Q?Gg2HPojFI7FjzV1yV+z1ydY49sDoaIJIld5A4mwvPaVjhF6HwVT5IBV53H53?=
 =?us-ascii?Q?NXokn0QhGJX7BWXL3QaMfL5aeiz1/NXc17zwMdC/yrdFs3IJEoaqdluzEc/o?=
 =?us-ascii?Q?jHY2t6nYbnGmqGO2wjeaC2rVkbz7fP5AErLPJJbyE8lZfPsYauS/LMIN6uTD?=
 =?us-ascii?Q?WIxlURTtGIzMa+8NnDaaUVOlCh2lDl0yr2hB+MY+074pKOL/47XHYs6yPxwu?=
 =?us-ascii?Q?7hB9iLG/tKxccBr1Lva5XAtXmkvMkU7TNMo/6ktXrCYmlxcHpNHzvSshlqG1?=
 =?us-ascii?Q?tiecYcw5JoS0gJoqc6EZGqXHEjeImRbKih1hIfJRLY42W75jMe8+D2gD9vde?=
 =?us-ascii?Q?mUyVS45DFbYfgbTf16GD+Y4slVvzWWYuDc3XwTD5E/spt318SWJAEcIJMjPD?=
 =?us-ascii?Q?nTf4p4U58iz1+auyiSGHyhy2lO49WdjW1CvHNFvexj0A1LFjUiJaRxlYLloP?=
 =?us-ascii?Q?ZId+PA2Qln5FSJRqun7pTjkAV6vxIia2oPnxKmJbTNYPt1MlSwgIFMmWMloR?=
 =?us-ascii?Q?31frryGoizZQYFFt+N6LbkfEPYv1Gz7iJChQNqmM/+OUXA27aUy8ds0oHNNC?=
 =?us-ascii?Q?z2a2bgVnX/2Kjbr0gEahzpJXWWhkQgJVLNtUewb7mADwXcoEsSgCc83gNRaF?=
 =?us-ascii?Q?H2iJ7xu1wDEUMZZ9IV9TtJyErEcINrWGE7K/kqNXZlgO8PSSclCUy1fvAVwB?=
 =?us-ascii?Q?FqeUMYvXlWe4L8DLCmEvUr3eey+h4xI=3D?=
X-Exchange-RoutingPolicyChecked:
	ws7kC1wFAR4AhZfJscfjjmKSPsp67z0qzUiqGrZTYHRdzL/g8X9b00ohZMaenRCSEPxhCwxWDT3rs6YIY+an2dfddtFaDV6yGoSqGtALjFP/7i/yqtm1DLePhrKQM9Ooo5joWjiAnNtUvKFR1mB3B1pAQypd/lvSQXZdnkqV7DwXGzW9CsDNxls2ujKh0S38WruPbeua6aRDCaXIYNC43KlSQKaMmnagio0vqxS9eYX+pr9LppIXjkHHNmrZ7+Csheuvg9P+DRhW5KzmSWpWCUproHS5ROhz/X9stbdfCoDrpRFJB9Ty6DKI314ZGd0ICvC4C9tCs8wLHvo3E0Ou9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U2+9Xzxxl0/NDkHfwp4oHETZPl/F6AYZBD4jCBmuDnYvvWhcNfp+UOqx86yJpnAy16lp8eanECUOmDH9Ho/f7cUM4/N0epjptdsQWgYVUIrRyDuWyOj6eVHKXtFphlNVYjCmzxeUxLh8f1slJR8iqxYaxsaw8tvhrz6iqcOIy1b+yt/FnAkEqcKHxj0vWKlzE7bdeQx7Tz6saGCsLSH6rTtVkKMAjUPH1opp+oOLb7/eic4eGQVBDlFNx/jN1JHLijP5aUSlVkvxs8UEkmznInAFpkJLpuAInkAbmP2bSvbNg+SdG5s/03POdoBwzt5bflxCE9EMRdGX8YawfaNPV0lqgRMUYPfTFvG2OqVgtkSPMtHH+iPMBN+Gb36QObbS2HTQGd4XQSMwPxazhXGV9NxyyFYRmJYK0jUmKxqz5kW1FRjSP16fuBVGsIYTBHUmcxjh0bB/MHyVJdW3jEhwpfxFbYT0rEwGJ0NuKDKDB/+k5rm0fYBxjyp2hAcdA1Fb2jrazNAOi2TrTkZq3k9MnqkAmAiqU4n6EUxuJk0dM/6pgBEQWICTF6wB9GS4c37FZURmX3J3y+xWIeL6/Ul1y3ycX+vQ2mFmP2CCDOXfyPBq6PDKgL1wHTQzAjWmNwo9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6a4ce2-1ba0-4f82-5841-08df2d1c39f8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 13:32:16.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN4Pg+iiU+Wv67B89uRno6fcBKrE/VeC5R0NXQIX3b5hX9kz8qDagNm8yNY29CB9dZzfl0s79LGMm+hUSCpzsNGxDELpPcnzRLeotq5lVNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8982

On Oct 17, 2026 / 15:54, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       [RFC,0/4] fs: support dma-buf backed direct I/O
> Patchwork:  https://patchwork.kernel.org/series/1187147/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/38999893251
> 
> 
> Failed test cases: md/001

Please ignore this failure report. I believe the failure cause of the md/001
failure is in a different patch for nvme-tcp driver [*].

[*] https://lore.kernel.org/linux-nvme/atSzF3URmcpP2_i2@shinmob/

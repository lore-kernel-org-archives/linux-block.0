Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1D1C5499
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780296; cv=fail; b=Wf+j16PBjXw26wisFTByQe0yRl1d92B5tzzWptsAJ+iV8nWILrTO1+kkwu2j32A4XLAu8LwKk83lOdWVcAel5bWMylKWuhDLEbenqZ9b033os/uefHp1Fq5sYty1uUxEsxlXlXtSDCnSm7ePVCi6X7alwtmvvDdrQ5bWPmtBLTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780296; c=relaxed/simple;
	bh=QllpNIKsHH5Fke303N6s+UFu5QQXx6B8oNaSZrUasOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YEk5+o7hd9Ykm6TH+RGB0OMLWPU3n+dLTGy38oqhoglwNEPeSGIM1bVQSbThKhzHMxs2POSxUcM0gzCtOXluTQqUy8mJY+CFt+ZeMhF+9/QFZgyXQ3qin/ruIH47XGA9LxARSEc6qON5cz2b/nWvI2HrzrOSbrWnP0p50QHiYQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Skuq7mPQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W9eDU8Xy; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Skuq7mPQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W9eDU8Xy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782780297; x=1814316297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QllpNIKsHH5Fke303N6s+UFu5QQXx6B8oNaSZrUasOI=;
  b=Skuq7mPQ5VJureLnvteoyy9CDGyUn7r9cCL3uzxQtLdhWGIZRswavXq6
   uwxTeaS5ohMx5tdOzD/zfeiLmFMy1NwlQV0Fekg+zC02lZdrndHoaXkYN
   wDXYgzeouZWpt0LoCuFKutZqQTqxZ/9447CIKvL0hSoI15gUlJ5kNACHi
   oExkJXX1GZpVDl+HSEUjoigQuCC9XDH0mZU4NKG3A+w7taC5BtEuxnYTJ
   zvggcinwl4M9pB+YUNXs8aOen9H+BzkCGj86SX6sSRpvIIzpedeZSxDBa
   /7jAW2D3vAihkrRxShRyv8KzFUEVd9Zap6RJ7GxOLA2KV68zHCMVQG5EO
   w==;
X-CSE-ConnectionGUID: ABH3lXk4TWCLTs9ygfA6lA==
X-CSE-MsgGUID: D9DvXVflRRe1HJYO/LtoNg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774281600"; 
   d="scan'208";a="150074912"
Received: from mail-westusazon11012054.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 08:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZY1MmISuEeD6laToD1a6LXlCaQByKYvRb6TzFRFdMkdDGV9Y3KD8vBOK5esdPq50M1nRD3obD8YPZ9zskrZETURkoOKn3Sfj33/yC8npUqfkmsxRRQFP5AX/jK5gNfGjQwwqMVxjX1XExFDAAFRUtEeexe9xz9mK0UtX8y3M5WawGzxPBsFb4PQh/i/7owQL9ct3HdsPbgV5dZRP3yr30SgEIUTqyowZbR2VDOLM0qMNcVFhoK1v/qa3y8bSlNIqwb898Lgt00KB3gCkJPrcKPm8ICwT/HtMlvLsIcbCW2oJFmtYtWIKL/R+rNEexnfg9mS7MuEFptb9v9bKaGMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QllpNIKsHH5Fke303N6s+UFu5QQXx6B8oNaSZrUasOI=;
 b=OlY6mbS8Fz7BJsxLVKXPN1KdsqIEKVX7tIEXTLO/ANw7l2Mnavkd4cydwrinuT/I/CAjM274TEBf9RvzhGI3lFKzTmiLsZqT5ZEOzqqpdCThrEhxfaXnDM5l4gOIB0NYkbSTs52/lJFcVQJKjNVW0BskdGa88kNIEG2KB7J7MDAJJejfIt+rfAuUBUGf4dbAYvCD7I56q1PX26JWA3/nAsdmPlryl6jYU61y8AZvJMkl6gOAiL3gR/ogf80cximAx3A241Q6C00j6GcKF1fJKxn9hVCSj1LWZC3Ziw3xbqKWD3YKw/1q6mC/PFBeqhY3joZHOggg4khA4DnYQYPcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QllpNIKsHH5Fke303N6s+UFu5QQXx6B8oNaSZrUasOI=;
 b=W9eDU8XyxwquW1pkRbyrpoEgkz4JmFBhtTFjwACDKRhfak/vWecXnXoqY2z0YRCXe3PmWGQicXuPVdJV/rCviNr0K/GNimEXrvhsxEgl6XWrELlLTZQYLJznfYUmKn/i9Y4RS7S3YLKb7aElLlbR9TAP/bCG2aaxDYWyWAho8jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB9415.namprd04.prod.outlook.com
 (2603:10b6:8:1f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 00:44:46 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 00:44:46 +0000
Date: Tue, 30 Jun 2026 09:44:40 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH blktests] src/Makefile: escape '#' in HAVE_C_DEF
Message-ID: <akMRWpB5RnWIvbvj@shinmob>
References: <20260628125908.31524-1-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628125908.31524-1-sebastian.chlad@suse.com>
X-ClientProxiedBy: TY4P286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::17) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 767c1957-b003-43e6-e3ee-08ded640c852
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wtIzcZ4ceZXQ9AvI0q/1GQt8w35BFlfAy0WyZmtrAyzRR/bGLjDstafTyQYttX5bY84sb58BmVtD/FjawjHjEL74iwHZvr7OUCtfBXzwlOPv+lsUooYdBDRSEtBaNO5GLW/MTCzBhzvoDjLF2NL4CCCgZ0jYcb3xmjkbP7Aky53bevwJcPbBToKoHrhwjYXy3c2YURniBJMbX0mdCAkvcBRLFQDQOZQ0d0+lUoP+nHYAQknSolSMcqoiO8wXsMumIafhltcnAJO56gdlzfe4CEJzNgbwRQkupKXZhopCQSLnUc9xGuEOtSZvT1On4VlP5BqSxrds0iC3csQQ+W6LrYRhn6nQuu5l/qOiWZ2IWl7g2jqinHi5zmEwsBbfTqdIHRHfNgICpyZ5m+sNeLX8eF8RS3xwapBiwaGAB1uVgZwKCFkLW24Lr7cdczBJkY0LaifVuamSU3QSry/ZTLRmp4CLuMRuA32nNnPLGAurhKnYiDPF76rkDdfAoJW/VU8kGgb5SZoAYSlW2CxH5HwyUy82YB0AY8V/BXq0YzOSdK0VhJqPTSt5y5MBSGhRUMiIxs6BJ8O9QbhO/bvqogu7knnwokFk57hyNQnd6dLHVGbWJdisAN1Kp+c90S3SrZPHQ1hF1qK0bSovi3boti2q5cX9NL+CpQV8D0fnNs9uv5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvGH22RKxI3PQj1aYnrtFn5cAO44QjssB+5zFxlwJ02L1UMXr6vjC5Bxxopv?=
 =?us-ascii?Q?ILY9S8m7qrEdQ/PO+yVZazlmYbsN+mp4KyhF7F4YBCQsZCt8rMqc8kXcRg0r?=
 =?us-ascii?Q?skg26oJDwINfKxprY3oYknamczgWrSic/Ok0hSJTm4Y9YZq5+LmkSJW83mdj?=
 =?us-ascii?Q?+tiCk2T9XB5mzb4sAvskmjm4CyAMMLt4dgLNPLOaGFWFxiHJWB74koS+8J5S?=
 =?us-ascii?Q?TgboBe5sNIiVzNIyLt9zuEW71FOWtvuZe2a90ecudS5+LTTlczvrJEyBjhBc?=
 =?us-ascii?Q?1UkLfDUoWnfNjetT6YC9FpneIYw1XyIptNGXbSdm0el9I6L18Qk6J77tdJDn?=
 =?us-ascii?Q?9OfqYW/8iWr2SftNajGdduwRGYDiisnJN6FAPjZwgJln0xSMGMUNYHt2h585?=
 =?us-ascii?Q?NjmWNXaEIj7tW5pqm1rE5pddwOeRQsTHtDdA74XlsQqLcwITeqXri2mCNgzQ?=
 =?us-ascii?Q?V++FB6uY1WZ2gmdvNQmadbCe12BeEQ9RMs9cLyyVmY23KR1aplfcue7czHKb?=
 =?us-ascii?Q?bz75Nl7ZeljGe8TVw2aXfCZ7+RQsMpnVrzfBrwAsPyX8MEl3ZXMtYKujWdRv?=
 =?us-ascii?Q?8hd0titeia+5M94jn3kXd+eDrYoexwUJZKdSjTmFtxLHXMkMJ7PiV/ISpwR9?=
 =?us-ascii?Q?7FOsyc95BzSi7Bo3veFLbGqDAeBG/b7b3WdMMWnbbuRYr0/D2Y4zKptPUjKr?=
 =?us-ascii?Q?p8UFFxAGaN2I0v0eouFUDT0ftROR9eVzTKVfPcx7VVTKOyhCwDy6tfppXkBr?=
 =?us-ascii?Q?pBghI971eVSBA6Wq5BQfox/CeUM+3+pyIff2NuDiPWuDxUZnG7N5pv3QGSai?=
 =?us-ascii?Q?NvVQgMTX9Owwo5c/SjXL8VDwzgC0NYIi2W9sLNQxZytxcwTUwzEiajObVBQB?=
 =?us-ascii?Q?feGrHlmm/2ba+mwTHQG1lxhUlFj6LCweooP6gqvu4EzkudOPdOfkrIRcLcVV?=
 =?us-ascii?Q?CFvXFP+0o4sfj//qDl+4MP0fWcqDoB8zRErZ+H+mt5SrVzBNcGa3XUx4rq2U?=
 =?us-ascii?Q?NaD7ND5QAQ2avG7P8KrJ6Jc88oqXrVaCgadz6fjxjUb176uirps5cMvusINm?=
 =?us-ascii?Q?JApZ+Mjuy5pIs8ZqMpDLF73v20zffIyLwxGjgJe8q9bWh8yqEZoImq+5BRV5?=
 =?us-ascii?Q?WWmIl9jLHEfAJfkfmwh/mGn0qfHyXJqt6UcvBGY9s+c3IOdzmj81xiJ2mpXW?=
 =?us-ascii?Q?Glv/5f4fsQqy9TqIIPYspswe8RGmtPANq0px6AiAdOi7elGobcIpEL1KYdHS?=
 =?us-ascii?Q?YnGEkGdgCIcL29+J/g7uN3SsGME1g/xd6h6R39lHPFKS8+RMv6aKOdH38o1/?=
 =?us-ascii?Q?01JJewgJTnjog2lO6XtZntfMAhczm7qUyavu0neescNAdQa/lRTRi8YO2yaD?=
 =?us-ascii?Q?ekZ91nvh4KPB0NvTkIBv6xhKU0vivQR8SnIdow5ni/PwVGVKJNhCk9hpwM+S?=
 =?us-ascii?Q?IzMCqQLpQxYiwWiMDeq0wAITtLdxgm8x7xkUOIiwAFUVqg12bPaWzIhU1T/c?=
 =?us-ascii?Q?WtP5NTJq/IUf9Gq8LT61czEWyqRZpXzFfdlOZfXnvfwUvjSFwgi9DOG+qTIr?=
 =?us-ascii?Q?pg9NAQxtOtYb4WBvscVWsTu7XbZkmEcBs6Gs8uF57d0WHEvjYINMtPaUm3tb?=
 =?us-ascii?Q?bqzcvwO+kPYy8CIEiPRH7/wsYGNvuzh5kYQ+SsEO2YrLSlMIJuN61I3pS5WJ?=
 =?us-ascii?Q?Ml2wsvI/2qAzO3hBwQa4Gif29z6vT09PwpxTi4/SkZ1EMoMyqiIkspHzsMpr?=
 =?us-ascii?Q?kNEiGU6ML3juhk+FSp0412Ohhgv49qw=3D?=
X-Exchange-RoutingPolicyChecked:
	rTQEoagDwAibUxikMioNtwrmRM/M3eXy7RRfJH5+5Y9NfcpT7VgpDHmJ3mQsZbifLZ4GUfo/ZhDd0VQm6fGqE2fz8uzDTgyC4YlDtr28ukPLAlWSxoNiJCadBBQaHN5JDtGWAJmQK9tee213EY8UmmI7hGgnZ3zBb2cWBmbKb01jqhhtBY36aS0EmSj5bR4eMwHAKuKp5CCGR+hVRH9GELqCO9qlVAeXsTsScFRdM56/8zM551nudKJKlRXG3NrxJIuTQrMByFb607gSvGHfF+Tga906S3xijRdDbRfqSMtsr2pX9zi+eLrnxf3AXe1YmNMKFJG7XnCLqBssqL/qng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1FgZCTdrheGhOvhc66ZV/UZBoVlCcw3YxeV0CpVNYzrTN6N2UDCo8iuNXuE3vHtjxlNVPVF9HgYJNn0w9WASKs35K7l59LKwPuCzhQBNkp5SbWIEG7vlxML7+oCYGtDGWCalp61t/zpwyaqd9Pucnm8wPbzHS2SkrItDw8mFBL06hWep9Ok878++hMWSwmZIFqpvMTMoP/rkSVSe/8RuFwmfdJMTGHsgPOz+YAM3Dz9jZ1bKuxyTIEjPpbJ/UR+YXbhP7sTCySrgmHO7lwtYrPj2Uu/lx0SkWTEKPJPZVLyr/EVCNbQ1s0Fb4ecn8WAwsbLGIs8f5C25x34RD9b4LxATH7GDmKJdrdSXBQVR+xtQAeplOz1w1ZdGAS+NbaFdui104eXCgY9GlcQ6HLiY5xfsA3E673MTz1yce7nMFixYGJZTbGirXKJwogffb1Q/yOKvAOW9CpfdrXA31D5Y8LvCY0feaFahlmFwNOj9QKVB21Js8xetsjDdS7SeChTx8SxiibBurrzu+Y6PSoxtUd3gz9ElaufzsuKwe1aYvO93HlJHvzAiuLEHY8vbraxqJl5TU7TV2qq5oZCpZIos6wx8Zit2LIUwOLpSj9pi+IJANNG1plsbearF8mcX9rBU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767c1957-b003-43e6-e3ee-08ded640c852
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 00:44:46.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mHd1byi77kjRlIeRhgnXjcVzQv8nLeTr7BvxkiPQdPRKnoczb3x6DoxbAhvZTwtAn1a7AiK9tw3MxVH2sGRCuP2bFDx87Ko6rmxZxAZU8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9415

On Jun 28, 2026 / 14:59, Sebastian Chlad wrote:
> Older make versions treat '#' as a comment, leaving the shell call
> unterminated. Use $(H) instead.

Thanks for the catch. I have applied this patch.

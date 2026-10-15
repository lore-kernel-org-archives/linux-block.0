Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC544E02A
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065907; cv=fail; b=jYIeduK9AA0kIcttrn5kC2KSMzJ572SqxQsD69FAMhw7hH7YQ8GbYZBDwM1jgMof/xIZCGYV8Z+WdqZzR3iZ69qdsJR33blb9CDIInB9BRrC5YbpueS92GrehV+N9Cfpbyd0m9DuxY/TtpfrRZ4odiyPCPRmfp2AU2YUNFPI4cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065907; c=relaxed/simple;
	bh=Hi00gFMLQ814YvYkbd1+RVCTbi8xqynx/N4J1ZabcWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TVrF9kDkE75mP5qSHfIAlwdl1QL+UNtjk8QEo9Hae9Mm735Dl4Jew2d6nv7TdXLMp8DBXVUh94x29/v6FqZNJ+Th9DAILrTWXIjkktoTraBYfWIpW//NbpOpK845nMIuD8v/bYTReRvJOXskaGAVcbH7PTemGJElQ3mZuLUNiMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fKLKQVCO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oH6r7Qlu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fKLKQVCO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oH6r7Qlu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792065905; x=1823601905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hi00gFMLQ814YvYkbd1+RVCTbi8xqynx/N4J1ZabcWw=;
  b=fKLKQVCOVUooqfcZxPozY+ScdejlGBf6zK+tpRVxAsK7qJ3CSPPZGGqh
   B+YiSBmZmyUrRvnlpdWaxTFPPQKgJXLXlzoxxlZ7kjEDca4KKO3LqcDx7
   heJP5pe/8Mx7yhgAVSRjqg95d2qE8RcEf8oV7LoSXkBfEhvzb1zk+4h11
   pu45EtahCfGmaduU/6o8hWEUjOiItXEN/sQmr6gjtPocRNA1S+AqUodN9
   nTEEb4xmCyh0uaQAgL8acHwojE1HLwJOuAoLmg0+2e9o9D3WUZA3Fgsfr
   hl1317XRH8AgOo9BzxezQD2rd9ykYk84kbeSu5nJcW4Nwo92G61931o9Y
   g==;
X-CSE-ConnectionGUID: Nz9qbV1XTIS3MDU5eYL4mQ==
X-CSE-MsgGUID: 8+D3SJDwTxmIjP2FPwtXOQ==
X-IronPort-AV: E=Sophos;i="6.27,159,1786982400"; 
   d="scan'208";a="157210695"
Received: from mail-westus3azon11010017.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 20:05:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQr2Y9NKjHP0FecCqEb1wxxiYzDPfm+bjLOStMJChqAXFSP3gu2CgH6KB3SZedj6++BH5y81Ztjleya6uxroxwhVlcpDrqL9ZQjRUp+LtreyDa2sLst372EpDWJxrE2Udp9JePU3qH9ZH46aYZKDC7GWTSrJvSNyaJVpGi/Tl4kFjhk0Zala3YiZx/Z6ucZHnkoreif++nUgx5F4dXtoP2rwF5HWSLcFQ8WOwbas6EuLWjhEqlKF+guK5cQ6ofLEJf1aolygTmcq0nHa8491qd+m6dViVJKSaxt6y1R0hq4mNODwFcGpAopCCYHgmipgzFofWFE7dda+YkdadLzzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi00gFMLQ814YvYkbd1+RVCTbi8xqynx/N4J1ZabcWw=;
 b=LgvUdrqUtAxHirfHRCO7MeHumfrX+JA3CV1z+cMnexmbzjIPV+BJx4ga+gvlVqsm1+WLSgxcwS0n5XlIZ5Ffo1cUm+rXSTXh25zdMtJWjz7/FAZU8kjuVyWnwVG+gTlrr5HaU8lvSyJAXu+amHrlXXSW5kO7dFO8EHA4C9YAT4CLRZfrdgdPiiUw/lCEID7ryu7r5GDGKzL8Xiq7upHxWIXGnNzD216oEil19IJvgCE6w3c5V4ftk4PQ6tC/zyde3Xk4CPzgjjPoJOfpPom/LgTGo1Rj1651jjliWVFLE9xpogd/XGjkd4dOyIXYVLMVZSdl3rTEnko51/hq3HAiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi00gFMLQ814YvYkbd1+RVCTbi8xqynx/N4J1ZabcWw=;
 b=oH6r7Qlu+PSrlEsvUah/7LM+MnGpCpQZp/51T+ADPvK+/KPxKtQ5X9N18cxp6cHzkT/3O9vTvsYXZ0ruybut+hc+2Ca1798Tcj01+ZftZJpmvLhSmerSqx00bfItA0a51pSJOnKdLrHLciFeycNbYAcAyNCmWHix8bdCF1hGnsM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BL4PR04MB993833.namprd04.prod.outlook.com
 (2603:10b6:207:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:05:02 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:05:01 +0000
Date: Thu, 15 Oct 2026 21:04:56 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2] block/049: test polled dio with user PI
 metadata
Message-ID: <atDBPOU0nu9yY8UV@shinmob>
References: <20261008031714.529202-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008031714.529202-1-yangxiuwei@kylinos.cn>
X-ClientProxiedBy: TY6PR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BL4PR04MB993833:EE_
X-MS-Office365-Filtering-Correlation-Id: f2535c6f-7271-412d-ee02-08df2ab48a9e
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gduasasPurCGh8tCRVXm61eCQgtqZHSWOfGkFUd++ibrs7XkwvCXvyuO0goshLhFeT75hfUYnKZUsVvMvVV1uiUnVfyn4zkWA4d4nZtYyY5r7AJc7ANfOP9z5xdTUAIfOMkCpIiwxBvT7TDetQOKFTNeZhX5sjbp4q0GL7o0TuCB546IqSpA23ZMg/uWvbf5QHUaIMH3oOPaNpsW1ncF3wbFGRpO5JPIiuQXTUrJfOtP5HVvDc0y2utAwarJ5RM/xKw87gKaKUMr16KnICPKEDXTnLQNsukbVEN51yu8ZNpHsk+NOVg3eDvaO1lQuOJfP0A4gXEYQ8zFbpsdTwSL1bLlbm9Ut7PMNzhRXzrNznQkDfQZB4Qb9xhSCiA7mvS4queFhsJmL29OFnnoP2NdNzNaRPWXmBRuPVhG1Iy+mILcIWWwrf3wbAo+j2xfXyC4z05alNyBq/Lzeu83FeXkk0enCZVdvn81XN2ypDrRqIcaDb39sA8VJ7RIbCIjThK02xNR1dQ3obKcpha6yyZOQOvspsnCdo2BF5lGYAjKAkE5dBXB2F25lNxTyFrzWr2cCEyb8/XmZDfoXwoo5/i+JF9K7yxATQRkQMQJIHXOqOqhmCxSSa60bFrQme1gQT05TYKwyhO+uwJ2Xozsm6/BT+NDwHKNkuk4l0f9l/Ierfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0IhLyAF7FqlQIYAW5okLPQoXcenIxYMpsKyxdroxaj8uucCtztsMuBjStDIW?=
 =?us-ascii?Q?3A42Ua9g4oCMUm/uq7HgaZgP0MIRhtpB/Ocl0m232evJH/4oiUPAyGW0pz5c?=
 =?us-ascii?Q?IkpJKtdnJ54TU0TisomR3pnjjKQrO1WVA6m09bMUgzajSLgt6F0Hjc9zwGa1?=
 =?us-ascii?Q?MVf8/cZasIzwHnrHrlbl7IvkGDd3gh5yEaOeY0/Da9LVaHPTxI3EOfHwNfxd?=
 =?us-ascii?Q?VW8j75mePEXl4/N1aogt7kxryJFq+6cFP61UvkuvVyjqxl8BkqYUXEtDoWyH?=
 =?us-ascii?Q?SVgTx7fsOw0QgG/bD0rMbUdmZYV4l3w7SEAoLRyVeeqEqmIgSbzgFg4Xc8wx?=
 =?us-ascii?Q?3Bq4K8uUwFvg6c74+LMfDTti88l1dyGoWDh/7Qll9Ppiojrg0Yu7jJP+G3aK?=
 =?us-ascii?Q?LR0I+b4s1MlXmGjk6nsFRb/O4FYJMK1hlLGYnNDTXXrxRb8hboBWOhV2ruge?=
 =?us-ascii?Q?SL6131oAYE4t9WAcvctMpakXKCy00omXO0DtjgRKhiv7NRahVa2dRf+uarPz?=
 =?us-ascii?Q?nixlpdRp/nWJCJIN4UtAGsx6uC7gHlHsKRypqirgpUy05INJQ1HUAlc3Q2jd?=
 =?us-ascii?Q?C9q1ibbMHVwJ4+6gTDTHVp+h9hIOVqOamnkPvbaAgmP/KZlS6ew0vCSwbzwH?=
 =?us-ascii?Q?4cEsfZFuZaHqp5lfOptDyRUD0ijrzj5nUObjy2yAWoKBgmRRO2EmL76NEcWy?=
 =?us-ascii?Q?pYdcf26WNc46jssevmnD3YuEOvh628JUh/viMmoO5VGiBoMLrPP2geOqTJEZ?=
 =?us-ascii?Q?LRuAlTlPuiQMi+jp2YmZw0OSPgUPvOYP7CtD1oG1hpDQ1CX0kRN8Ng00WWyw?=
 =?us-ascii?Q?j3fY0dv+4Z3NK19xyPn0YRW3Uj4mcfADSbn2Q+GTyHcpIwMFIJNu4AqXhm1O?=
 =?us-ascii?Q?UkneibJtWja0whYiD+yUAKLGeGUpGV6J50ndq62XMPfrTMGhrz4fhtRKBT8T?=
 =?us-ascii?Q?KQGv6RCUZDn0ISfzQf5WRA/cmD6VtM3M+uMuKwJyauCm7vgcMvGFNhsu5lUv?=
 =?us-ascii?Q?MuVtgg3L994A2DbYIze/o5f7G6lZxcwqlXZdNVhKhAETu0LFUWM5bz7iCHNx?=
 =?us-ascii?Q?8aZMNmdOcM9sTdxzRRbUIfx4TdcS89UFvG+h2HJEea3OvA51xJfdkGiXKtYA?=
 =?us-ascii?Q?sZ5qoC2jpTSTGFilIJbaAnuDFm5g7HT19N+Weg9FqR3y6WTyyvmcs4mkpfp+?=
 =?us-ascii?Q?k3tQalabhNwDsOUGAQzBt3GN3SU8NEIzIYWzlmnAxO4S0ZMdHVH1SxXHlByS?=
 =?us-ascii?Q?c9a2Dy/Dq/x+5Y1zNVlSpNr1zAXIOJ9kCIoMKG+6RWuG79RF8eXI0rrxbmST?=
 =?us-ascii?Q?Xz5inL5UxwOEwyYzNh8ByvHwsLgoOeNh3ATXd05Tnl2OKgs6bzau8LBxe0BJ?=
 =?us-ascii?Q?3Tuzg8kQg+H8UDjY1pFl+GjHhUb6I/nrhJAnpWg/PB+dNFhDSJhHqfGl37/5?=
 =?us-ascii?Q?u0A81D+s2rP671zcRFzm600qgOvwFOXDnFew7jFOhhqDICeCR86wAfgh6I65?=
 =?us-ascii?Q?8PaMdMQ4v8BYnXLLSobCf6w0fyDaAlejkAiYPY6PUIvnUvjXxQUrxs5XDFl0?=
 =?us-ascii?Q?I8Y1JHctG9bEq5f2Qgjf+NizK/2Thr58v226B1rLM4dBdec0iB++uv2MXtMA?=
 =?us-ascii?Q?UKELkgqSfDoH0H0Be1cD4YkiyjiFmLErPwsA1odfj8O9RC3iySjx1fSYRv/G?=
 =?us-ascii?Q?u4SckBHCEYO7x7o9o5PK8XNZeN1yl0SfvL0DQVJQqNKhp6R5XSPE93zu9nE7?=
 =?us-ascii?Q?4wusk/5N4by0mSFuNJV6W5dsa2bJ7bw=3D?=
X-Exchange-RoutingPolicyChecked:
	2JaW75fP+l8VVkioCs7xmYIBabd+EDF7HLDNASzZaSbTmyEzoazyCJxY8eEAxSeE7ZAm6MwPRoTfWmLzjFxUKs8o9QYHfPQU/1C03vhPeduzxIbKEOed+3flWFoFZ3R3Tt35hTwrLrB6jEOgFbGRBb10UmOWCeFomQTnSqkkoIIE/Bzk76lTy7kNWzFQLAQJC1zkV1E1+dR2fNehreek1w5IJB5svlYLayeWEv5Un4l6hj4WT0vWfw6NLDlyF7rE/f/IP4meCz762R/63qY0c2bk5yf1iGpBlhGMaWv8o15z+3pan99uVhMsA72fdGK5amYXfy3TlTQ4v+ItQClD1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mJD59CMsfOE3Sa9tW+O1qgZPaTe/DN+ZwLPq5XQg2EcxE6Fr6s58oZNi3AzlcSoNKmZ1Q4pGeCt1DBRsfhSpQgJmJbIJpPa1Y3o37hz8gHbVH3UuHS3/HCnSvod0hJFAHOD5r98voxlM4l3ySCaO/s0VHd9Yr4p8G7Qay8iDfP/aDGYzWA02C5jBNgHC35LrjZb8oRm6L/fmUiTTzpRv8+31J0PqVezoydeR6Eb072K3VS8TpTj5IEkofwiZLcmbDW48DNMKybvrFU1IM7qZVy9Kq+4OjC+k1xCIszuPkwftjCd3l1F6irnrnSJWwKM6/AzBbtL/CeRwb9g4XZQCaoOdrOnqA3IAkNSMTrPmVMGbwqBqxdsjo5J54Ne1lNgQQ0ouRVKRhVNyiHXDNcJYrKQZQYE352pRa00IAT1wSL/o7NUr3l3kxWI7tYixOZNBLm8SkChVXtVC7mA7laKbEyEjPPAVAW3YdO8bwpjXlOwi4ZtekQcYV9tVCeRZP2q7Lm+u/sw2hu0fCOV3kt6xiD+h/PFowH7xLe9LpZqwQ8RN6HcSa+rtmQAYf88K6Byo/dGoXXQqaynF2peV+5K8UNavIcc9GGDeJ7D7TRFlyCxtK3YmT/JgnlL7EKc9Y1IL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2535c6f-7271-412d-ee02-08df2ab48a9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:05:01.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4Zzy7tqZ0tl3XrEHRMJUDUhPNCnSuXWdN3TVOHPxPg2VxjBDGvE/JZY+OPKAB4zWChuw37mlAGZVzagCdnbOZEQ4ZMIkd/RJHfQm+UZuq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993833

On Oct 08, 2026 / 11:17, Yang Xiuwei wrote:
> IOPOLL combined with a PI attribute used to leave iocb->private as a
> uio_meta and oops in bio_poll(). The kernel rejects that combination
> with -EOPNOTSUPP. Add a scsi_debug reproducer that expects this result.

I applied this v2 patch. Thanks!

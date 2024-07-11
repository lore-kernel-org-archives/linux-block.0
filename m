Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C01514E3
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686248; cv=fail; b=SpX30/Ukv+mzX6dojUvyG97DYlx1eHFJRml6Pk8T4X21Ux4e1Rb3pC4MeKQkagHX0/DSIoE5S1RFts5rDX6BHc9PPHmBa+oEI+NvJYEFW37bNYvgO+HPinoN5n/H+jEogT9x0uFAMmPnLyeSP42JIbsOGSboZIFrnqCK+Bp3snM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686248; c=relaxed/simple;
	bh=ja1qi3Y0t9LYmOjADADtqHqB4whG/93eYpN2gGDayr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qz94u/9/c7AU9mc918j9/DqY8BeDBSDKdqbfOVyrjBQLyTBsUhQZ2EMq2TurbtaAn+LnGgnjEXtC+MAiWwoQ3OP5nhREianEQfh3S4PbmhG7/t31Bt3EAEjXoM6e6enbeXxAfeTniaqBBv32MFCC4C8zpfkEfKRX19SYyTgqNHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aglE+P18; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g1ALvMFL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aglE+P18";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g1ALvMFL"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tSJT026752;
	Thu, 11 Jul 2024 08:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=35Ei0gnRI9bn1llt0A+E8EedvnbRXVdYM+a0zGkZonc=; b=
	aglE+P18aLEvcOIcJpAZi2B5J8zwWVxplD10D8+LJqyF9ejUzpcy7O/vzovMfOod
	5unpvHPsrqKYK/owPao9lT0grJm1j3+t5P18DmJdkYSnFcnIjVH3FQGPphYZeCaf
	I2+07g5qO2FHxMrTF1mgUu5f9noYMTas6Y7VkWvLAsvd426ib9Si71WkXZi676y0
	pg+tydsgHZfrWW+KXj3vrAMNTwFn7Ob9hAMOVRQoetKggOZa7j5pA/6A1IqLY+xS
	ZBs6dw3nM/B+t69x6FbGmaorB5S0j8TreDokXa0BZ/5Szn6ojhZWboKPIRq1dIx/
	S0v4jsIITb2lSOUybCd1tg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkns2bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:23:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B77r7o033812;
	Thu, 11 Jul 2024 08:23:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1wsge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F36hB/fme/CgCZ82RVdHd34QBCfHFBcaoyNxPnN7HZ9tquQFfcGou8A0aKBbe2wweQ7uCGuJrpzjaedYmCCLrNyDHuFAUOuwIKYtTtsqdhwJhGyx1AICHLYgb8fipTTLBxWMofbTUp4XyNj4C3linbvUooVlEsJvyrFn9ZtGOdl/GIncyawvTWCjCU/nh8S1CRlXRghwRB0Al2aO+J4WWzyH6slHSuJvk3c49RyVNKgiCq6u/5f2YgHA4ZQDPi7V1GQZS5s1vIjfvwZgcsW9w9L92Ybp4Teg4969i99JUiAiZ5fgbcV+5AanOKXVksY3LiflcP+JwhpD/Ye5VeRrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Ei0gnRI9bn1llt0A+E8EedvnbRXVdYM+a0zGkZonc=;
 b=qkxowUrN2oSf7PCLSp8ji/m//rEFKSv8GEX8Qo3v+WDyIrGw8d8dWa2nZvaFovc3jjreeF83/EQY+aH81uO10kAMQ3uJNcjCJGa/Y6uvPWN7weGSZevK7GrUyTg8LPIaQdVdZSovHrKoYzYIP4siumFyuBPudgYTSbGK44PkF0JCFOIjDEn5yfmsOOYtiadVuwCNSbcNLk0y/EUav7GSXfbh9nFaVLPHSS0bQ5x5XfHpCSls+ukaYHFqb731Fd5RC8KFEHWehXD8YiDqaui9u8xLdVsLzlRHQ5qlimSA7RyobnzYEHxBsKh+t788+xjcBeKW2GgCFvlpya90XQbIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Ei0gnRI9bn1llt0A+E8EedvnbRXVdYM+a0zGkZonc=;
 b=g1ALvMFL2liWK3kgpstG7JdaDe13xdlXwrp+FR2h0ama7fx+6exskLm7t5QnGT2jHYBSXBrLlERACXwa5mN4egx8ZPtJO/u6gBXyw1C5eKUOjvp0tqReN+7J8QN9Wlcie9WI1nnnTKO1VaBmSWWSWDDJbDaFVsepSqMD7h9hl68=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB6970.namprd10.prod.outlook.com (2603:10b6:806:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 08:23:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:23:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/12] block: remove QUEUE_FLAG_STOPPED
Date: Thu, 11 Jul 2024 08:23:28 +0000
Message-Id: <20240711082339.1155658-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0778c6-0599-4677-a826-08dca182cdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6G9O+kuvykN5UeU6W9qT7d9zOYts/yTm5uznzaFckDIRvf5FFvqKKQI01Qq3?=
 =?us-ascii?Q?jB/W1vPxMXoJZwtXMzxM2/o9yCeYIieajWFzkqq0FB+XRPYeQwrC3Irw86C+?=
 =?us-ascii?Q?GB9w5aKahqGogsqp2xgCkTpSF8Ztx1y53hhGiARDFqu0HeD/eR1Sx39w3V8s?=
 =?us-ascii?Q?e62VdiP01+tePiXHuMCS6bB8ps+ITdwazAGBBRixzTG29QHBHJWotjeQbmDA?=
 =?us-ascii?Q?2D5xL7Cv0JiKVOsRopKKGtU2QlusWkTKXuYzH4N6ViQSdJXABJSun+ZYoucl?=
 =?us-ascii?Q?aof87PM+Z/azbTUg2JBXkbWj5nHQz2ZmYHmKJlCUExSaMJG+99pBIeQclqO0?=
 =?us-ascii?Q?4UcdABIGwmtR7XXTtzkvcnt5GbmraooJKeDHbSX5cXI1n8JNVAr0PhnSJkiT?=
 =?us-ascii?Q?krwsE20KxsAj18FPhGniG+pNbo5IGk3FHDrxoz3C4aLlsbFs8pflDdaXN51L?=
 =?us-ascii?Q?hY3JwcMYZiVv7BMtCDudh3IAXfGd70B8eJYJK0lLiMJ7W3VQz153OpmsO93y?=
 =?us-ascii?Q?DqVSuajIC302fB0fzFmASPxwtDnSaFcW5Y9kE/uOQe1F6/pgCt007/XfHzn2?=
 =?us-ascii?Q?BsaO5SN7/Ub6TZmUCarcSuRa3gFPIn9Te/OXo2hEwi+1ExZ7meRQPuPWEXBo?=
 =?us-ascii?Q?zf/IttuyFP5cZhjwsYP7kU0GR7YR+tM8cUmhRED3zBP1H0rGFKFExLR0QcDF?=
 =?us-ascii?Q?n07b8PUUGdu28dvW3mgCOfWRwHgbGT8eZKMNhbACQxzOaAd28UVoZCc2vSLe?=
 =?us-ascii?Q?NrnNQFxX6Wn7r2ey21DCrSD53b/+w92AQXHuE3eTioKCDlTFOpT9EEH4j1gi?=
 =?us-ascii?Q?QHnwUvPCOj5+HxaeLakexo2SaLvjCSHQbFuw8WXDKvBeQPLRHUWtQYVjx9mf?=
 =?us-ascii?Q?Jor4wLs4h5KlPQ2nfShqa8YOgTedZW9inyQ5xxLlFAW+eKqv2jYPTSLq2oY6?=
 =?us-ascii?Q?CbwUk32MWRY3uGOEsWeO/rKkqcCih1fgpnRI4fq2344YuVaPqxiPhGxmvzaS?=
 =?us-ascii?Q?HKpYN6B7DSqNavAFhf1se7dVOr2GshMRLCaPU2H0yDubypIHSjk+6mH8966/?=
 =?us-ascii?Q?01DUR/3ap+zk9vMIPVmMM9Zni4qhu4urH3gUvKmRVgbwgFjs4il0GujVvWEe?=
 =?us-ascii?Q?r+jV7ErKPrxk0ap5G6cI+lLcT1/ZJeoLTwS9RyFaLoKeCf6f+9ml0MLOG80o?=
 =?us-ascii?Q?GhjzuuhZ74TXGgjiTEybHjs5HyEaG+yJ4mHDKeKzGLgt3k6hC5fM5fXSdsp9?=
 =?us-ascii?Q?z1eVNMGm0cnRs8T60ScJvtS4hLOigDT3ty6C03gLVuetDDOyCCLOfo2gCUZR?=
 =?us-ascii?Q?2VQQOSTw36ESMuGJJSEkpMCOFKksAdUY/SUjaFTZl/ftzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8EPs60pX/7NwPm+2i1G3lf3mt1CzoNScXmZ7jhPbJV7UlUE4Ao1uiSkACNYB?=
 =?us-ascii?Q?CHmMBfNyPmphkGDmBap2znKj5odiXJQz6rP7Q4o6czmV2+xk6goI55+T0myN?=
 =?us-ascii?Q?xn4IfilsNWWBxfFnbSVOU5i4X+ywrfuEUviUYdUlV3h1ZsxrATNMyiPXAicw?=
 =?us-ascii?Q?9nzLbV2lJRo9hMWUgF4axZj9nz/Jx/eJuzCceicMF0VuLSk2+6B+JMljinmO?=
 =?us-ascii?Q?F3BJLBdTPrmBpiU9vQbHJxxwxLKqV89MYiEeV2cIRQoUsUbbw0OYsN6S/6Q4?=
 =?us-ascii?Q?nk80FDL/a/xiJuf12jtdFhtrjZ3GtxIPMyrX7c9PnNICrGuxX+kRC6pu+Nz+?=
 =?us-ascii?Q?H9cIfTyYWDPomMyNdpnrx+IdWWatqKnjpJvl5NQzaQ0dZ4sx6L/1erggvRmn?=
 =?us-ascii?Q?qoOm7JYbLKxqSZBRwhForTEfJAVgsdVuQi8PuPkmX9/rDKdf4GYMwTKrxdQF?=
 =?us-ascii?Q?LGac0f1wn0Aywnk8kBmSbF5hNkjICwM361dt373nTs9yKPpUM3uzDUzlm0I6?=
 =?us-ascii?Q?rW2nPKSA5sNqX/d+jgkKSt5CNSDoLRi0UPz6RZ5NU5q7UGlHxGX6wNCrsXq5?=
 =?us-ascii?Q?ybBA3MguBZDtW3S+fx66g+XrQAUHdgOkwzlyqCJVw20ZwItPN6JP6FvD+S9I?=
 =?us-ascii?Q?/88wKv+itU2v2h8xO7G7CziFz0+0tDqVMxbdHFdowoJfF1bU0CPV86djFaQu?=
 =?us-ascii?Q?8yb8AWo+CxKrAn587cDijvp+riFkEDHv4wsZ58ySvK2fYyVSiFa4HGjp1icc?=
 =?us-ascii?Q?4KLLY/jYIoLfegFVG2sCQ3L2IQSBY9fus5fLUXEGchpeRbu6nrvzScQqrAe5?=
 =?us-ascii?Q?9RpEesyhxuaIxUSwnWASPWirlzkywimP0tJadxqBcsCdN40eojjNuZhDGYBx?=
 =?us-ascii?Q?grwiqslx89YTKuLz5wd1fUCI32UhNFyeEL/g9ssW18rm6VBsfz5dkmYijneN?=
 =?us-ascii?Q?SKoWEnfFpBIOswDmOUG9ItQc6UjlQRM0bBn7ig1NBhVwNcNsZjwFf7wERxNa?=
 =?us-ascii?Q?YhwvgEiCnCsNKH4lod5+lLvklcUGJff01+9nTyXQ7NX3iXAp/0N+ChJrrfil?=
 =?us-ascii?Q?KAcR+YFiyIhBJxT8j77KVusTi8TXnAhb7Hq7NyIXwzK3GDXb/7DzxcFcUHY7?=
 =?us-ascii?Q?1gEYfhh3WT+DY3gmwNPU8v5Kxhxz3X2aVJljwcZ4rd+Kxuk2pB5cTPF3f7cl?=
 =?us-ascii?Q?ygpQRt3puJ0ClII9bSpbggRhqywZoeCfaV62lOl8fsqPhgXWoQqHiIZ7Aqfc?=
 =?us-ascii?Q?tdhervssr2bNwQKKknE63FbQ0d+Q6aw8960VaxiQK3pE6S7zhHneFipXTe4i?=
 =?us-ascii?Q?EdPZRSJ7P2PrDpRwIjCPA3jBTPuNyq9L39QlEc66GUayDe0QeIvtXVExwUWL?=
 =?us-ascii?Q?nHDb4E8ghYCynihZrhDgDxbsO9IBK5sLI+Jj7bNYrXWNGUeQbgpQ2rdpcxvn?=
 =?us-ascii?Q?YidOQOg2+yBs6G8hGYQUF3JCkTGlJPT43qdvy9cW3/sVdaRoYKtxCvzmQxxe?=
 =?us-ascii?Q?zWJIrX0xQJYUo1CTrLpOPVD9Oalqq3NKiNA9XyFRYNcmZDzvGD0cMFqBPL+L?=
 =?us-ascii?Q?sGaVQ3Hy8Be8ramHkUl2h4nEmJX3+CiSgiZhRpWcfuNDLo5Xr9+iXU9ynWgT?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o6+a+uGOM+63ivW9FKl/HCrQ6Co7uDXgrzmnZFSldZXWrvgEa/0HL5nM76U9FvE0mSp29HE7uYa08a23s3AwZ6KQg/eN+N2Q4W+0+e6SzPk63NMXCsGxcSY6oADanHXdDrNFfZpqdsTCq8Bkf6GDIVppBR0xfWzb6yDf2fwC7kWjWK8Ig54evXzEwcjicY05xxW/+dw8e7TmMGyPQBbtaCN/Zowy4et4YtWd5XhOX8Q+TzVbywqJJM2BeMoY8rQONiPpq3IyfRaDS828VLqYAIWjDQYONhTsPbW5WK+fEQhVRy1a+syIv1X1QHmjwuXZnkOQobo2Z/7QYAQjLlHcZ7HcJhvarn1MsfMo4WZjEHCxfQCRaEFNT279/LGkaadRbm3DtfA7sHG4i2sdH1wABmAqDaEx7TScvSBaIBXiYJHJWtYr/4yCDEvN2NWfU+dUCdGGCnp66UTQw5NchOfl6tgAjfTZFtJL/a55VmQwkdmi1FtkgdEDY6Y355EoF9tuogia4H64mFu4+X1/JglzeDbnn+l/RTl2F4h27MKL860LoLYYilIwF/sZs32OzgRzNfikEoBESFaCyTUmvEBQt99Y0dN6VRkN9DMJ1p/dSnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0778c6-0599-4677-a826-08dca182cdbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:23:55.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ielU4ui1kqpZGwvTwiXhYjIL/qnCF9O0FWfUU4Ej6ZHUoOguzilIzYy8Zy4hTG8lxUcS1zrYiDqoJ6NnWGoeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: m2OTZMtUR-15ZTBN-IJ8EOXgIoQEMCoS
X-Proofpoint-ORIG-GUID: m2OTZMtUR-15ZTBN-IJ8EOXgIoQEMCoS

From: Christoph Hellwig <hch@lst.de>

QUEUE_FLAG_STOPPED is entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 344f9e503bdb..03d0409e5018 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dce4a6bf7307..942ad4e0f231 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,7 +588,6 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
@@ -608,7 +607,6 @@ struct request_queue {
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 
-#define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.31.1


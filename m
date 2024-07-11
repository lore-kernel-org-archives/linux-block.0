Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA19BE6F
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686306; cv=fail; b=tIoUW6dytR3oUn9DWDQhc83a6mCzYv8vOYGdiEINwBc3RmStLWgE/wLQ2d0p3aBxxoSHbF+C09VT4fJSosR/ffXYstUwa9A2hKto/zkbgZJ1PPjr2RF6FNSoyNroznH4KgPQNuQLztuAdjFpr+a6g/xx/Vx+ewlWLJZZ/leP9Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686306; c=relaxed/simple;
	bh=NVTTzQCfmeMoSpIoG4EKWQRfWmzw2nxXCOS18mxgY3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+R/1kRFnXyFvVug7VVrvX/6kORVTFOLmPkuYMLihkCNMumX8WnXCdZLZiyz+A/rgvSG53aLZFyFRB18zV9Rg1SdbGh9C5A0kBqLkGM0J29xnwQShNvTj+hVMIIvMwTBpmbK9BlgUyuY6mdiYUM7cboZtDsZ2BaUqRr+GgYgp68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUdx3MnZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uRytw9RI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUdx3MnZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uRytw9RI"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tSJV026752;
	Thu, 11 Jul 2024 08:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XvTCzitd9WiR8/fYTq7NI8wse8gAAjcsWxQZy6bcEPI=; b=
	KUdx3MnZK/gqBoYub0uhPotIH7B/VpFsWAKqASB/xI7oHRic7YXdxKfpurfVKIGz
	eRKh8/tt1+hAJEi/WBh3CGjhmexcmz2L/ehsCpvIy4jCJtQ5dWj2VBaKnfHGG81I
	wagTlWUqOiPT66y1hFs5EnL9UAAcQbeLOoD5XTcCW04eTaZz8Q6tzM+sfZXuaAb2
	W3dz4wWICDFkb4JP/uzpjXAKXt2UWoTB0pIbRqqmB17n3keMjytWhgPG2hRXlRMk
	ujWBaUIujDpYoEVNS/HXdtL7qvPuZMIS6t3UztCvRrl++3Myu8ocNLIhfeEvmqhw
	qEkN1odaRPZJbMNSDk8EtQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkns2bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B6gs3f008976;
	Thu, 11 Jul 2024 08:24:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4789y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLMSHrJaqgb58sS6J6pFJKlLC8zvGSVOi2+FLqi+d5KO44M6csOGB/m7/biZJ2+9UiDottBXk1GRP0wLn8Pc3RwWmrhbierAnbuudD/hXW1A31TQPCsRylJBBlqqME+PRwJSCJnQVui4RMjmHwI+YpVenGwXUBZaw5kbJsIT1C8uPI0mbhigXF/TgXi6+N9cOkrjH6CL+ifKhyC1grNuL5tlF8QelmlHZdE3yI4V/t5TMbmxarLU/VYtsTaESr3KTteJz+Sy5CKnTFX0Di72WiuP0xQdlCTid2bdwEBm1XileO0tstjyWoqJN9moOeivSUZ//7hrFYpCytofNAg2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvTCzitd9WiR8/fYTq7NI8wse8gAAjcsWxQZy6bcEPI=;
 b=PyXjoCWFAh0vWGblK7Q6VaX8ruiXV4JJGs6eARu2snWjH2Et9jJppoR+hbaU3fUxDiZg+93KdPMTXREq+/OXaF6Bt5cvSAIfdKvK6IikLwu1qnE4rDNLXbViNckH38+NCtOawwNPv5WGHTy0ZltcqdswqUDmgWILXm95Z43QAxvdoAXbINJEDA/8m0+iQO4+kiBF3RINaNW167PMw8XUlUn6+PyncMBHQFofDVtgSdal2MgNsNMkfiTbpTg8nti5Asb4KGRB4rQ8R2KXO5OTlj79TxDZQ9e0zZ4Ypf+QnlSB7sNLMJ44IfdhjD07G18D4EL0OAOhGku/MQgLk+J+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTCzitd9WiR8/fYTq7NI8wse8gAAjcsWxQZy6bcEPI=;
 b=uRytw9RIuxY1zdHm5ISVk3zFTTZItQ0FcczgtQnMEfIlPPoWdwAdraZ/XTASQtKT2rOom0JBGehIu+WCGbqq1j32x6/NWKSixhZ0XC9e5Cc3iznbzSRYZIpCFP8yRX6u2VYKPGePiKyQwD4g/yH3Jx7cdGmbgYUPZT7a1BiQ8+A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 08:23:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:23:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/12] block: Add build-time assert for size of blk_queue_flag_name[]
Date: Thu, 11 Jul 2024 08:23:30 +0000
Message-Id: <20240711082339.1155658-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: abe2b748-61c3-48da-94e5-08dca182cff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5y0+G+ka9Daw16huAoNooiBF9wxyW0YpCoPcylVgIkCuQ/jzDFpvlsVIN8h4?=
 =?us-ascii?Q?Ye6uLNKGUatgqyaK1uXZ3LteNKzr8ioCePOQ3jpk+noGrlIBDjIKR4p6xyyn?=
 =?us-ascii?Q?T45Xv/bjHUQzHsq4C866M5j5AtI6IZaw6XM3wonlQgH/zlm7s8+4KmZd/xuM?=
 =?us-ascii?Q?GQ6nFu5TmcwUnQ+cn0keTAaa7mrTPBsqeygYL0PkWF0QsdoQEFMx+dSLmXpG?=
 =?us-ascii?Q?KIAUIc4tdZe6pw1wTr8EuqWJicGkFzV0Sdo1qlHEGQo9cNc6GLqL5K8tzC6K?=
 =?us-ascii?Q?2rwkyZjqYTydoLdsh7ipCWxi+viqy1Thoo9ZH/uoZya/6jbtimSAM3wMMVFe?=
 =?us-ascii?Q?D7/cSh1FrnWz8xMVk/GavGZueWaGPyqDJOfndCbBwGb8HAI6GvkfboF6IhI0?=
 =?us-ascii?Q?6rX0TPENJMeUHaES36GmobDDUluHRrDltrJYoEO3MNggC4XMbhrtrfGX0CiQ?=
 =?us-ascii?Q?GPZtfDZJm6XnCh82ldj43VuVeEazwz1cVrfu+fxQF6b6uieNAWhoOKGEe+Ud?=
 =?us-ascii?Q?/4UOc6bskE5CJogZ4rbqUqKGi+2zWL80j1ct+oTmzVv0R1WMeqTfsecJ5FWz?=
 =?us-ascii?Q?2dCQ0/6dyN5VbTImWB+B1+wKBdxw15qtH4VzymjHzPx5s54UM6jh78BjecBZ?=
 =?us-ascii?Q?g1MCcyCMIt55SBLA0maLzjlqgzbjiKFBBUFy+55YKsKNEjprdtxjRyJo/TLq?=
 =?us-ascii?Q?oQxy0N2UVg6mhEO1Vd8jrFBPt5X+WNWY18/3YpBj6+pBHKZklQOcFO3mbXBl?=
 =?us-ascii?Q?0yVUT+S2euEGx3pmpCkf3QpiwXLTV1DGbAs30IzHtPTbUS9psZLz/zBRfZJi?=
 =?us-ascii?Q?tRrb00wEuJ6SNNxludJlKGkVvzSsWIjqPbZdJ0QdiGDgmvScmV9wtfVnJ8ZI?=
 =?us-ascii?Q?tBVyJNlwKvOWIlNIxcE/RdMlXpcAfovpWJDW1ABzj++UrXAzg9kBAQrX08Zd?=
 =?us-ascii?Q?hpe5hy25C4Wt2HKY6hLnqdCNMN+CgiCNxRSZU7L+Q6LErONjYtPC1Fklq8Yy?=
 =?us-ascii?Q?rCLjqE7+NaxcG7b81MnI8hD1o1EtV36r18ZbFVMd9NbFgAQdwc1d/H9D2u63?=
 =?us-ascii?Q?nRBtruIScxLpAlT5WX/6tP+1OVOK4jC8t+K96A4IEsE5XIhc9fxibHCJQsyP?=
 =?us-ascii?Q?d4/6aE15RR7Lg1mHRzkYYyESBD16N1Erg4vLZJNE8np29bbWZFfJycjpVdHH?=
 =?us-ascii?Q?Ef2VDC4eKMenPMnwU9ECSQLvYZErvROhz7VOd2/4/zsyTBw2iZrxGBgoyCqS?=
 =?us-ascii?Q?IA+EzqEs4ylrUtsRC0oe61Y7zH5/c2TYeVNO4zGegfIB7I5T5RZL4NKPl8k/?=
 =?us-ascii?Q?iKqITb3YIWgG9t9RhTYcoT1cE+NWSNJdTSXTb/navE7orQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J+Vie57nAwPPLyoIgtRWk+lpz5t+hVdPBt88sE6lPbmFOy9NzQh/GygKAPCq?=
 =?us-ascii?Q?ceDaU5I6sW1Rn3mv2VALCK9NFy1izlFp+5dfZLVCFyWWmQxgA6iLQHjDuBr4?=
 =?us-ascii?Q?shbAEfUL1YAVf916KfCKd+Hz4rd9GYO5tz9mX5sWG7Osw9Vjox7JyXs9Ul7B?=
 =?us-ascii?Q?5Wk/WAk4uHWjxe3ceX/J7UhBx8ly0WMkviFgEOrVpZQCAlZ5W8dTmQEQ9KU8?=
 =?us-ascii?Q?mOkLxdiv1jr+9Kd66ze/PXgOfgv8AaWkSiC74oL36geV37kEylQK2DRdkUYW?=
 =?us-ascii?Q?pWGlziNX51NKpbMJlA5L+Mv6Ljfg3BdJUADSfyVzRAtFXWZeRZZHRc1uY9mR?=
 =?us-ascii?Q?wpymqrb5MY0/ri9E6pWJLkClAny+42Sf3ndm2lEW0ANVGNwddibSw4idUJLm?=
 =?us-ascii?Q?RxZsbBEMzAvtCV6i5+SACv2SqYniZWhaG+8POvItnNjIC+MtFrq6AU6eql0T?=
 =?us-ascii?Q?MswqFCyNLn8W658FF2QZK3z0XUgXotzFgZinuLHcDd1efeG73/6cR5TYO38h?=
 =?us-ascii?Q?cItjVJQuK+AptsIetNzUyHpAKt9ekPDw1+fJRHWD4TK2cpDSek+i79UgqBzl?=
 =?us-ascii?Q?GDAft9Udg6MjhFGiYiCGfXxZUjG7STpnkEu0q996xRm1lSUJ/xwSfdgOcWSV?=
 =?us-ascii?Q?F4urFFH/S4YH1OE7kg/KwUDSFNmefRYJSTmsL1ViHkiZI9M8T6jwFByZj8G6?=
 =?us-ascii?Q?bQotiyn2zzaXIXQpJBlpgHeJiMo6HmhSh6pnK9JhMMzFUziMiPNIIHPiEy0+?=
 =?us-ascii?Q?ZATkoWFKwUUU4w3XLgBznRmcxU8suUN90qakRTPt1j/fuAJRCjQdyGJ3Rh3X?=
 =?us-ascii?Q?LTHFhRmU3viy/MaPqurxPzZEN8If0fjmvrbPNTDVk7CgbIkCSMu3Of/tbexG?=
 =?us-ascii?Q?eVnzIYxEiyWxta1IYhwnv4m3rAC1GoyeZB1wAyjXLQcp9XcIJmUG+e5haktf?=
 =?us-ascii?Q?lvd/OUGamnLb+ZFvIjyL6JqcktpaDX/+25xyftp9mkjVNqQCC14zwVwWYvwt?=
 =?us-ascii?Q?SgF8YE44XBvK7HLfivtgl9kj4dCCGmyLSeWDAvv/+Ptxye8+iJps6cw1Pqye?=
 =?us-ascii?Q?kmtrqYtxfxov1iTizb14wp4G6qVWYIpF5zgWn3VT9XdGvIo/BRqzuaZLeO8J?=
 =?us-ascii?Q?St7sjUld9pJd+i39njOAThvWgLsl+gEQu0/D2D5mXa8/2WGBBlrKHcmllwUS?=
 =?us-ascii?Q?w7r0Yj6yjJAMXTNs8lzV/u/Q7u+BvusBD9srTYKYU7GD2QKW+Y/ISidW4TrY?=
 =?us-ascii?Q?f3FPCoEdyPrbpbLrxAVvN0WTCNWeBrjAZ7N12DKLYo+PiwECf9MT72RgjEtD?=
 =?us-ascii?Q?kF9syZUqXr2HL2YrXz78B1Gg2Iuifu6m3skPsPeFEXNCG+4O69hYXfSjUArb?=
 =?us-ascii?Q?LBFrsA/NdNJ02WLGUGcEEupJyr6NqsfTLi7AtsCg45+T27S/lwzgwsvc8sBk?=
 =?us-ascii?Q?AU6TYwUcYW0DBL8chzlceY8+djcNEkxUKQKGecZay3JvN2RtZCRlEs2NbtnA?=
 =?us-ascii?Q?HA9THgzvTTK57v4G69kjzSIXx6AVUpRyjuanx0QDsi3qpoVkEb0ixtVlK7sW?=
 =?us-ascii?Q?wG+VGBmFARLpTCCeA5pwUjNe6QNU7B1xfo3Mqaq0quoHlEPBoNqZIkrK9SdB?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ws6f4Ic4i4ZFv/mPg2OZMnX1UD4gKzIjUwvcsC6nhfCAR2aEiK6QmCIxcXZR2qOHOHBQPnQe4lkJU37LOECFls4P/u1g/3DA1poaaxBGeMi4NmDrebnF54dQJlWCKUDVXO6uVQ9e/Cn9qK9f35a6fLZvP/VP6zlFYkJ/2xqo06GkgdTXs5b+u8R9M//0+TCHJTzaJUxqNNY83KmOMwXAlLF+QNPlLpcFNmCwLtBMIoCQGO7+qc2NUdVJbQPEJdFi3YMzaKBikEMY6AoGPwOEUWURkDM+NgN2pxXWrW3HVNWwBJ/39uMDNQ+HKSnmDPnW7bW+ARK0zaLi5QB1pZsc3ZS2dX8HXtiUDTAKBj3Xo3a0mqmWt0+bhlm88aevYglEGF7srOgEcYIigMxsU2Rg2RJ3GRnzlfUa4L8Afb1pObfLjjGjiN/XzNHwoP9hlDhnT//GGYL9zs8vjwJBptxomo5DnvQpHLRfa9qrsVqphykp6G/uSDoacKBQZY/nnoy7d5dtUvpJulOD6fJg0L0p/ffbTbSuaZmua1iNQ8dyrLzCFuRJdWTmif3jO2mO1H22FvjraV6ypqrDSi3h7zVK9jH3DgsV5WevdiZKDpzZGVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe2b748-61c3-48da-94e5-08dca182cff1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:23:58.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IeXyht/f4SHovqSCs4J9WsDXWWPlwxfMcXRvDA7QoNe4vSwZeaya92jSZYqg0qNxw9YoQn9R3X2PVsMeYfD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: PDLX3_75iNfvEIqL3w71afCjbfAOgqj0
X-Proofpoint-ORIG-GUID: PDLX3_75iNfvEIqL3w71afCjbfAOgqj0

Assert that we are not missing flag entries in blk_queue_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 03d0409e5018..9e18ba6b1c4d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/build_bug.h>
 #include <linux/debugfs.h>
 
 #include "blk.h"
@@ -99,6 +100,7 @@ static int queue_state_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
 
+	BUILD_BUG_ON(ARRAY_SIZE(blk_queue_flag_name) != QUEUE_FLAG_MAX);
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
 	seq_puts(m, "\n");
-- 
2.31.1


Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63F2874F6
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536701; cv=fail; b=EZys3biu/0vnNxLEOm0HRL+b+o0gjqpfvBtHwEkv90l65FJVv5bxMdM3SJrr+QMJytjCYWBFHwuXai6FsVz/v1Z849x1UNrJK6lXYqA6ypKkEuibLrSWOjIYTxuxNyUhpNydpPNpA0Zbdq1ag9kIQE2SzOPqpg2Z++t/rYAVfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536701; c=relaxed/simple;
	bh=gf3QrtkHYXXikaG/4Et7RGSTE21/LvIgQDa6bI58kAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvjH9esCz0aNkOPmNmlDoEMK4k5EspqMPzRZWyHOsEhZl//DRxbHiMwPNMT3tOtPfgC1zDo6s4tfyfEdgtNgA5Z1iNopAKxL18hiaOA29AIRt+5Th83bCxsRUTIlg4KIimfJP2rKw7SYXNwGrpgZL17yTnl+oyB0kMrcru1vgFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gBKtBvX2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q4xLQ2tG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBKtBvX2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q4xLQ2tG"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NL1s024114;
	Mon, 22 Sep 2025 10:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RzYaa9qrskFARHCLXfysVpo1WmGbqrHuqI57gemETHE=; b=
	gBKtBvX2xUdjQtIyxWE7clKU9L5hmKqgoTg1YMkCSTLK+oassUtck/0S9J5xg4lt
	pxoUilA5P3BcduNcP89Ga+zi0CZ4LU8e0EcIyRoCIuxKroq6RYVGIkGkxBnaVNRD
	e3xR4auFhIiDjHu6/Oqkb1y/p9WAfgHQ+LRdg3TmiGPWWmfalJ3Ogbg2GXxbeCjE
	bGw4sv7F5xe/QR0mf5/doVCJ8QaECWvh2oFGGuJp3qH60KSvCFE0jEyXGSI97O4h
	c3plwqx7o3BWl/9ZOa0zN3LCm39SiPjp18U/mC7uJzsFAtkdT0M7ULnUFKb8XLjL
	FW0eisM2f9TY9MLsVm0QFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdj4m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8HAVg026008;
	Mon, 22 Sep 2025 10:24:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1/pkAbTrViK8irH+SSZWnOyYQZhSgOZgU9MP59skr70m7M3Cv6WBHQ40ecBtNklhxuivzB9ZnZ2B6kuoj78s1dmQQz4trq19kYpV7Bp9EgXGQhYuFnLLeKpIP7KScLD/Xq+jfxjNgakn3nMvEFxuLKetT/ftTr+sS2X5sWdedMKNIWugeA/A3qFOgucsNCA9Zq3uEHrR/c/8fnZR0OnHEWx6v42QWxhvhBfNrYpGtPwOrWOqImAyqjoyWS4c7z5ShHDrOgSsZSgD7QRyfplGwX4x7zCJuOajUcTzJLDPuM2mhhI6QJpfu22VxlLhBBDGdLF3XxJ2bhH6kOKjo6gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzYaa9qrskFARHCLXfysVpo1WmGbqrHuqI57gemETHE=;
 b=p+G+1pr5CKCkQd/lSrwjXTSZooTUsAUisF7gCddF5TTDXU4eShKcfrb3YfMTxYIArIFnbaLpHBAOeC8VYarl2oJKZEtGdOdhb4T4siFW4V/yr3R553ay5ZZQmYf5sABPvHfm4Gn8qpRUf53hYzWde+V2L1r5o1hlqzTum8GK5cd/avprmbUn3gpdQB4W53Yci0c9np7LoSvFbmM3BzYq5wCDBU0CSRI8HHrChGrxNFVOyrzQerHNFmiVsIRTbzOqWl1O9I4N1pfxKwDSn/2eyy06HtvE545yD396lGJPcTtYge8AsZcvmjuJ3oo3eEwlC3MtGUl2VAg4afEpakqzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzYaa9qrskFARHCLXfysVpo1WmGbqrHuqI57gemETHE=;
 b=q4xLQ2tGYPHkaUtqm4gYsM9EwhvySJduJRWh32Xl3CmklMKCId5RhHL/ZmxYl8k0FGwZuR9NMZ9FUEl2mdKV/ZbKSD+f9L9NuDLJEAZMOcx2hBs+bw9FGS5f3llve+wULSsyAYYrFLSr0KPmz9wpazmGiQDoEagCHCOU6cOib8E=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:49 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 4/9] md/rc: add _md_atomics_test
Date: Mon, 22 Sep 2025 10:24:28 +0000
Message-ID: <20250922102433.1586402-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:510:4::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c79676d-3e2b-4ad9-29a3-08ddf9c242ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z6f31RrkfeAw14CeVm3IihIINVBFhnokDWhmiDiVE+BZplpA8kT5neRmNhOa?=
 =?us-ascii?Q?S9ZcxdXPlrgy+lxMi0Wj03d0aiyT+srXoflcEutDqAX3iD4L/DIROdeMd0w1?=
 =?us-ascii?Q?AZs6bcRfYIRCIvQ25r1fvtGtE+BfPdvlkmKfBPhq4/aib6ooslktD9HqRKL4?=
 =?us-ascii?Q?xpfWODpZWpkuqTiUv84L86nWoVZb0uhe1wsQHS/ZNLu6bzNwu+MrsrhsF/Jl?=
 =?us-ascii?Q?8NmWYpPY+KUfaCKAJrnqkseLJ+dJbeqEtxefYoJKKKQ75hbQ5iEmbrgvXjn/?=
 =?us-ascii?Q?C1TbD2uJhKhLonVh16RcbGmqrDatp6PGiTJFCoxqq6c7rdatzcj9RRw9eSYa?=
 =?us-ascii?Q?VJe3a0TEtuTgnkBCMN/rWbopcZmj4tMJPnN6+v6kZbHoKUncXi8eWiafCokd?=
 =?us-ascii?Q?T6V8Aw/3anP4ih/aWt2PKkaQdXTMjnAbrINLlqJoUrZGM4XwdcN2SdDWX82e?=
 =?us-ascii?Q?QY50FKZ5AvK3lQTnkXgOn5XAY8iLd28oG4dSUy0WZjVASVwAo01l5hHEaiLG?=
 =?us-ascii?Q?j2HSsxhRHhPxkYzIN37Tad8UyPKb57mw1GGMb2wYp0T0nA4JHk/q05IUZ6nd?=
 =?us-ascii?Q?sfj+SJs2D3is7a8qPU1ujXTBkg4QgMP5CXuWL6XVzXSwLI4q4OSUi8xQUMM0?=
 =?us-ascii?Q?ps6hcWR7KwwptuZRyUgB67KUbACHBLqY+WFGgMrY63azcDlWvzlssFdwubGh?=
 =?us-ascii?Q?sxpy2iXYmOFOJ0sx0qDnOeVcmXGSrJdLNzPfUUxN1+CmIScFVYSI+rEyX+uw?=
 =?us-ascii?Q?BOU0Q+/dhJLSIn516VGII6hQBxSdL6+jIDmg5hbHGMgT+orkfNgaqaJj1LDa?=
 =?us-ascii?Q?GRIcQBE+PGsynVmHoeNkrl77WZvOXsaU0iQdSo98ZOsIy27v8q7SKJktOE8W?=
 =?us-ascii?Q?vjnoATMvFVxaF54I+hDM6/9lrzJQhZjMoUVbY4vOAGA46ojp3T7VqAchoOJj?=
 =?us-ascii?Q?NSVuW2DcvCux3eu7oP57JwE/1oq0flTY6gg/kLAnxydkTq5ysOlvQ+nfqDqg?=
 =?us-ascii?Q?44XlApxVWt+jhReB888cFvKyiiiy3fYwulv33hByDvy7uJzZk9JXq09Z7/hZ?=
 =?us-ascii?Q?0h8YQcwF63SkFaDgHyy5AaJA4YreI7d9RwaB6is8qffAgfQt3RPp+3ujjU/o?=
 =?us-ascii?Q?NzLTkf4ymOQRK8MUPZJSaCETpC29c98B3KjPGdk6hKKltTa6J6GAxgKQmS4S?=
 =?us-ascii?Q?+xg6m3XIOCZDwJe+gdbAO3KUmbQrM9lVOaqER0rFt+P46wujCKdCdL4EoFsR?=
 =?us-ascii?Q?4NM3bGPe649BEnFdm2aljNB2fOWEw8MsdXyeUe/AXOmNKtgv2+BiiKC5moYL?=
 =?us-ascii?Q?x37TR6vyl8JSsNvM1k5fvdE0h2uOVp/IYzaaDX4zbk8LkqOvtsx59CLb8slc?=
 =?us-ascii?Q?CKe+J0359CQaVphWW690F9fzm2ViQeVJ310w2oeXurwMwn8FhtgE+gBLKqbv?=
 =?us-ascii?Q?OgzJnLmU5Qw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ir/dqaN8OPR7qZBDp8H4Hqp2vzLtJsvegGXJHCa+togLj1F3m5rd8MfT68gw?=
 =?us-ascii?Q?c82TIvYfdCJt/s1s8Q7ktMwTvDJzIfZtZwLgjXcfvMkX9+dP4zqfhs8AL4G3?=
 =?us-ascii?Q?+wncKkeZhkjLYxEA8bP8oZgM2D+y5H2llRJqrulUhFUFkEleZyfZo21kC/RK?=
 =?us-ascii?Q?jMxs2J8IjGKTw6IxkitTUsZ47RBlufevJHe0mHt6T0WG4aMOISaFTbV0f9ee?=
 =?us-ascii?Q?k5173Vc0onmPrniQwD6ZXiQ/+2+5YZvc2rZfHC08OiDTjqHYo2ArqS2FMveB?=
 =?us-ascii?Q?E3dldg1eGCIMwzCXkocyWIPb2/ytpYCyIhxgYfrMOW+UjRQOerOuGru1T9Dt?=
 =?us-ascii?Q?sGWU4SBovALQefPbE1Gub/bEj27ypPPkVy0NsL6KuhZIHX7GU30XRib7pJZG?=
 =?us-ascii?Q?Ug2XdSrC+eE/Pll3bB33AiY+K7sgOdncdby1IZln9UV9hg++IrW/V1YEbnoA?=
 =?us-ascii?Q?HHsiWiUE6aOaMEMbBiHlYBRF6nlf2Xt6Z6Ct14ymk+qpxcdF6XUXLFmOG2hT?=
 =?us-ascii?Q?5eMI70sehgj+OaDmi6V7ZvOy5C8nLxa3BYcBh1Qg8f9CcVwOfhfoffSuA3dG?=
 =?us-ascii?Q?T0ruF7mI0PAwZhiiN975N+nfRoD3OM8nXV0WDtohRafxNzDtyBTXXqoI4KmA?=
 =?us-ascii?Q?ZSynmifC80dKmUAW7+AQ3tXAdwAdec/MFijwkSz2pbFcDrVxFP0Q7HRAB4Yr?=
 =?us-ascii?Q?fagULX908Q9pDvjPi1xSrhmIm/csWVR4y8JB/EGck78+pe/pdluVemOZ+euc?=
 =?us-ascii?Q?9I81T1KnI+lNU1sJNmlITn+Kw2gFBc7DCF6cCkIiJLBkk27aaTc3k77l6mXt?=
 =?us-ascii?Q?BvXZLZNBRurlKCfpIiLgMliDPhcI094/V3KnTT0TdZQb9QAZlSgj/ZjlzXl4?=
 =?us-ascii?Q?0tnm+Q/SBb5NoX/oldONymzpYkRqC+frf9n+RTnbPkS1v/Ej3BHkGOYYsszD?=
 =?us-ascii?Q?DpKcy1oXyoA9JHBPooIcVvehYXii7KMg6RUhng0+EbyABcakC4mmVhJ0Ydmp?=
 =?us-ascii?Q?7kmgnz9qg76kCLwfhJYm5zPYTHwt82BfY/4KbmdDJ5PwuGf+icIQXy4MNiXg?=
 =?us-ascii?Q?r+nohrnOR99isE+ERWz0jcb0M8kZzyfLBrtmBNKiklY513znEtzYYOwTQ7ZV?=
 =?us-ascii?Q?oelU4h3fV45vBrW5fV1Agvwyu0jQrVjBRLxxfHi8aODIWw/D3rk/lhOAs9tl?=
 =?us-ascii?Q?P17VK7clpREoLW2sueo9GRhFHRDsKfPp8XSfZEwLwRNbzY26PUzyPNHU6c8K?=
 =?us-ascii?Q?DHyhCRqixgvO4jrjZYcgeKtIxUEYxO2VAEE5CrwDlkq5rXlWUuQduJsLgRKM?=
 =?us-ascii?Q?aXHR0i3k0b/h1KmbA+sqzFSFnlgbiBiSCpRaOpKpCGLjwyQ85z9gL5RErZxv?=
 =?us-ascii?Q?N8uLHuWiFQnaPIpEnRNP9lq7p6sDVSKIx8ijzxJqeotelF2ZdgCfbPUkH1rj?=
 =?us-ascii?Q?1DMPLtaFytnwSd1K5DzHMsQKnKTdEIArJt01ZZgtzFjI4bCEDkSOo0g9pP3U?=
 =?us-ascii?Q?5+4L64NHBVBz0TLHleIQSZPohBRgpKLw/oCV+6AIyYU2ycB6UhjYXkfmxcfu?=
 =?us-ascii?Q?P1J0wyzPF//XieY41ml+UWxDrSSmQNdTt0nP2Kf8EQM+do5yKVuVWnDWXfpE?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MvmHBYMeHFTrhSsdqBk52EErtK69MsIHgXtBppjXFWp4A0syBFlGumDrzxLVHOli6me2f6vSIXrFN0VFBwSjy3AJhOB/BmObzTa/Bsk6zBnAdzof9AwH5NEtNi1lTRmuZBfZusCh4nujnACe1YgJTPLN1wktiyNmuDj5408+oxy2NGG9q+obMrp249iKL34mozRNKRWoWxFxl4imsBAEDTIp0/91UCphiLGaFoz3QWoGDHQzRHErrj4r5HeHAvycDMRnoYJ80Ni5Re5wthcsrIPmVGhu+dERNodgjV49wxSkbUMlwJQEJpOziot2Nh9HiJ3s3oUp57X3G6VPJpVHiI/i+AxqfEp8LorReD7VXL+n/ldxuPxKAplLJNeS/h7bZ+B265uRe4WWvJeORWrijG79llQmqOvLXXPKOp0pNGMpOf6uWoHy6N6XSHqTdnsLeodKPWfR3ZBOJuxUG61l7wR9+jFzEeMpV+atO/CSdKGPVd2q8m44izEuY4RjX01+82imL2V3X+idrq0+F1glGKkijV74dd5XcGktgc+Ep0CSmmY13masVt+hzspJbpJ3hi9U77MEhWhg+8M0v8EqdwKbi2slYQdBxs7/yv+4bb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c79676d-3e2b-4ad9-29a3-08ddf9c242ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:49.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+duuEteg/M9Dg5LGAWl1N1ZMg+M7SOHSsP7XSd8TyLBnXxOSdBGsCmB/Y/NMRLZt6kQH0iA0jPtXsElrKUiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-GUID: bPI3YIwzoW-frzavnp6E4TNnZfSG3L7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX6Y8Nm23/dgVQ
 LRj7VYXQrxv977I5pOPyNGlIpFAgFOjQVw4TvfPY5zPmnsCoo9oUTC4COeoqxYNH1cd5XkMW2GF
 qNmPrjap9C6lY+HZ61i60DW+HLPaCVAuPmsgpM7alWCqYbVc7Qfz0ATDoIIwxAJHrkGVvrvbzUW
 ohg5+AuOpcKn2P0xf8ukjQrBQkX+vQe98NSGWsxD+knQh50tYZCIO4ZuB28Al/6SA2QqN81RAZs
 DIyfiJjJFf7Y5zAJrjHs13BbzWK8ebnXcDeBTDRYq+uRRE5o6MTUxQmr3GwugJB+n5fbAyiINPU
 7BviezASXYeSPEOl+1P+9LUpmbGPzkylu4rgboWdbx6DhEaWking/O89kj7ZzAETPEGmB2Omccc
 qjFH3IKf
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d123fa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rxNXlR3Y_y6O8_09eUkA:9
X-Proofpoint-ORIG-GUID: bPI3YIwzoW-frzavnp6E4TNnZfSG3L7w

The stacked device atomic writes testing is currently limited.

md/002 currently only tests scsi_debug. SCSI does not support atomic
boundaries, so it would be nice to test NVMe (which does support them).

Furthermore, the testing in md/002 for chunk boundaries is very limited,
in that we test once one boundary value. Indeed, for RAID0 and RAID10, a
boundary should always be set for testing.

Finally, md/002 only tests md RAID0/1/10. In future we will also want to
test the following stacked device personalities which support atomic
writes:
- md-linear (being upstreamed)
- dm-linear
- dm-stripe
- dm-mirror

To solve all those problems, add a generic test handler,
_md_atomics_test(). This can be extended for more extensive testing.

This test handler will accept a group of devices and test as follows:
a. calculate expected atomic write limits based on device limits
b. Take results from a., and refine expected limits based on any chunk
   size
c. loop through creating a stacked device for different chunk size. We loop
   once for any personality which does not have a chunk size, e.g. RAID1
d. test sysfs and statx limits vs what is calculated in a. and b.
e. test RWF_ATOMIC is accepted or rejected as expected

Steps c, d, and e are really same as md/002.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/rc | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 377 insertions(+)

diff --git a/tests/md/rc b/tests/md/rc
index 96bcd97..ee5934c 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -5,9 +5,386 @@
 # Tests for md raid
 
 . common/rc
+. common/xfs
 
 group_requires() {
 	_have_root
 	_have_program mdadm
 	_have_driver md-mod
 }
+
+_stacked_atomic_test_requires() {
+	_have_kver 6 14 0
+	_have_xfs_io_atomic_write
+	_have_driver raid0
+	_have_driver raid1
+	_have_driver raid10
+}
+
+_max_pow_of_two_factor() {
+	local part1=$1
+	local part2=-$1
+	local retval=$((part1 & part2))
+	echo "$retval"
+}
+
+# Find max atomic size given a boundary and chunk size
+# @unit is set if we want atomic write "unit" size, i.e power-of-2
+# @chunk must be > 0
+_md_atomics_boundaries_max() {
+	local boundary=$1
+	local chunk=$2
+	local unit=$3
+	local retval
+
+	if [ "$boundary" -eq 0 ]
+	then
+		if [ "$unit" -eq 1 ]
+		then
+			retval=$(_max_pow_of_two_factor "$chunk")
+			echo "$retval"
+			return
+		fi
+
+		echo "$chunk"
+		return
+	fi
+
+	# boundary is always a power-of-2
+	if [ "$boundary" -eq "$chunk" ]
+	then
+		echo "$boundary"
+		return
+	fi
+
+	if [ "$boundary" -gt "$chunk" ]
+	then
+		if (( boundary % chunk == 0))
+		then
+			if [ "$unit" -eq 1 ]
+			then
+				retval=$(_max_pow_of_two_factor "$chunk")
+				echo "$retval"
+				return
+			fi
+			echo "$chunk"
+			return
+		fi
+		echo "0"
+		return
+	fi
+
+	if (( chunk % boundary == 0))
+	then
+		echo "$boundary"
+		return
+	fi
+
+	echo "0"
+}
+
+declare -A MD_DEVICES
+
+_md_atomics_test() {
+	local md_sysfs_max_hw_sectors_kb
+	local md_sysfs_max_hw
+	local md_chunk_size
+	local sysfs_logical_block_size
+	local sysfs_atomic_write_max
+	local sysfs_atomic_write_unit_min
+	local sysfs_atomic_write_unit_max
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+	local md_dev
+	local md_dev_sysfs
+	local raw_atomic_write_unit_min
+	local raw_atomic_write_unit_max
+	local raw_atomic_write_max
+	local raw_atomic_write_boundary
+	local raw_atomic_write_supported=1
+	local dev0=$1
+	local dev1=$2
+	local dev2=$3
+	local dev3=$4
+
+	unset MD_DEVICES
+	MD_DEVICES=([0]=$dev0 [1]=$dev1 [2]=$dev2 [3]=$dev3);
+
+	# Calculate what we expect the atomic write limits to be
+	# Don't consider any chunk size at this stage
+	# Use the limits from the first device and then loop again to find
+	# lowest common supported
+	raw_atomic_write_unit_min=$(< /sys/block/"$dev0"/queue/atomic_write_unit_min_bytes);
+	raw_atomic_write_unit_max=$(< /sys/block/"$dev0"/queue/atomic_write_unit_max_bytes);
+	raw_atomic_write_max=$(< /sys/block/"$dev0"/queue/atomic_write_max_bytes);
+	raw_atomic_write_boundary=$(< /sys/block/"$dev0"/queue/atomic_write_boundary_bytes);
+
+	for i in "${MD_DEVICES[@]}"; do
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_unit_min_bytes) -gt raw_atomic_write_unit_min ]]; then
+			raw_atomic_write_unit_min=$(< /sys/block/"$i"/queue/atomic_write_unit_min_bytes)
+		fi
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_unit_max_bytes) -lt raw_atomic_write_unit_max ]]; then
+			raw_atomic_write_unit_max=$(< /sys/block/"$i"/queue/atomic_write_unit_max_bytes)
+		fi
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_max_bytes) -lt raw_atomic_write_max ]]; then
+			raw_atomic_write_max=$(< /sys/block/"$i"/queue/atomic_write_max_bytes)
+		fi
+		# The kernel only supports same boundary size for all devices in the array
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_boundary_bytes) -ne raw_atomic_write_boundary ]]; then
+			raw_atomic_write_supported=0;
+		fi
+	done
+
+	# Check if we can support atomic writes for the array of devices given.
+	# If we cannot, then it is still worth trying to test that atomic
+	# writes don't work (as we would expect).
+
+	if [[ raw_atomic_write_supported -eq 0 ]]; then
+		raw_atomic_write_unit_min=0;
+		raw_atomic_write_unit_max=0;
+		raw_atomic_write_max=0;
+		raw_atomic_write_boundary=0;
+	fi
+
+	for personality in raid0 raid1 raid10; do
+		local step_limit
+		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+		then
+			step_limit=4
+		else
+			step_limit=1
+		fi
+		chunk_gran=$(( "$raw_atomic_write_unit_max" / 2))
+		if [ "$chunk_gran" -lt 4096 ]
+		then
+			chunk_gran=4096
+		fi
+
+		local chunk_multiple=1
+		for step in $(seq 1 $step_limit)
+		do
+			local expected_atomic_write_unit_min
+			local expected_atomic_write_unit_max
+			local expected_atomic_write_max
+			local expected_atomic_write_boundary
+			local atomics_boundaries_unit_max
+			local atomics_boundaries_max
+
+			# only raid0 does not require a power-of-2 chunk size
+			if [ "$personality" = raid0 ]
+			then
+				chunk_multiple=$step
+			else
+				chunk_multiple=$(( 2 * "$chunk_multiple"))
+			fi
+			md_chunk_size=$(( "$chunk_gran" * "$chunk_multiple"))
+			md_chunk_size_kb=$(( "$md_chunk_size" / 1024))
+
+			# We may reassign these for RAID0/10
+			expected_atomic_write_unit_min=$raw_atomic_write_unit_min
+			expected_atomic_write_unit_max=$raw_atomic_write_unit_max
+			expected_atomic_write_max=$raw_atomic_write_max
+			expected_atomic_write_boundary=$raw_atomic_write_boundary
+
+			if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
+					 --chunk="${md_chunk_size_kb}"K \
+					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+
+				atomics_boundaries_unit_max=$(_md_atomics_boundaries_max $raw_atomic_write_boundary $md_chunk_size "1")
+				atomics_boundaries_max=$(_md_atomics_boundaries_max "$raw_atomic_write_boundary" "$md_chunk_size" "0")
+				expected_atomic_write_unit_min=$(_min "$expected_atomic_write_unit_min" "$atomics_boundaries_unit_max")
+				expected_atomic_write_unit_max=$(_min "$expected_atomic_write_unit_max" "$atomics_boundaries_unit_max")
+				expected_atomic_write_max=$(_min "$expected_atomic_write_max" "$atomics_boundaries_max")
+				if [ "$atomics_boundaries_max" -eq 0 ]
+				then
+					expected_atomic_write_boundary=0
+				fi
+				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			fi
+
+			if [ "$personality" = raid1 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
+					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+
+				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			fi
+
+			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+
+			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
+			md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
+			md_sysfs_max_hw=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
+			sysfs_atomic_write_max=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
+			sysfs_atomic_write_unit_max=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+			sysfs_atomic_write_unit_min=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+			sysfs_atomic_write_boundary=$(< "${md_dev_sysfs}"/queue/atomic_write_boundary_bytes)
+
+			test_desc="TEST 1 $personality step $step - Verify md sysfs atomic attributes matches"
+			if [ "$sysfs_atomic_write_unit_min" = "$expected_atomic_write_unit_min" ] &&
+				[ "$sysfs_atomic_write_unit_max" = "$expected_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_unit_min=$sysfs_atomic_write_unit_min" \
+					"expected_atomic_write_unit_min=$expected_atomic_write_unit_min" \
+					"sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+					"expected_atomic_write_unit_max=$expected_atomic_write_unit_max" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 2 $personality step $step - Verify sysfs atomic attributes"
+			if [ "$md_sysfs_max_hw" -ge "$sysfs_atomic_write_max" ] &&
+				[ "$sysfs_atomic_write_unit_max" -ge "$sysfs_atomic_write_unit_min" ] &&
+				[ "$sysfs_atomic_write_max" -ge "$sysfs_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail md_sysfs_max_hw=$md_sysfs_max_hw" \
+					"sysfs_atomic_write_max=$sysfs_atomic_write_max" \
+					"sysfs_atomic_write_unit_min=$sysfs_atomic_write_unit_min" \
+					"sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 3 $personality step $step - Verify md sysfs_atomic_write_max is equal to "
+			test_desc+="expected_atomic_write_max"
+			if [ "$sysfs_atomic_write_max" -eq "$expected_atomic_write_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_max=$sysfs_atomic_write_max" \
+					"expected_atomic_write_max=$expected_atomic_write_max" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 4 $personality step $step - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max"
+			if [ "$sysfs_atomic_write_unit_max" = "$expected_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+					"expected_atomic_write_unit_max=$expected_atomic_write_unit_max" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 5 $personality step $step - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes"
+			if [ "$sysfs_atomic_write_boundary" = "$expected_atomic_write_boundary" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_boundary=$sysfs_atomic_write_boundary" \
+					"expected_atomic_write_boundary=$expected_atomic_write_boundary"
+			fi
+
+			test_desc="TEST 6 $personality step $step - Verify statx stx_atomic_write_unit_min"
+			statx_atomic_write_unit_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
+			if [ "$statx_atomic_write_unit_min" = "$sysfs_atomic_write_unit_min" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail statx_atomic_write_unit_min=$statx_atomic_write_unit_min" \
+					"sysfs_atomic_write_unit_min=$sysfs_atomic_write_unit_min" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 7 $personality step $step - Verify statx stx_atomic_write_unit_max"
+			statx_atomic_write_unit_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
+			if [ "$statx_atomic_write_unit_max" = "$sysfs_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail statx_atomic_write_unit_max=$statx_atomic_write_unit_max" \
+					"sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+					"md_chunk_size=$md_chunk_size"
+			fi
+
+			test_desc="TEST 8 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+			test_desc+="RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "$sysfs_atomic_write_unit_max" = 0 ]
+			then
+				echo "$test_desc - pass"
+			else
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$sysfs_atomic_write_unit_max")
+				if [ "$bytes_written" = "$sysfs_atomic_write_unit_max" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written=$bytes_written" \
+						"sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+						"md_chunk_size=$md_chunk_size"
+				fi
+			fi
+
+			test_desc="TEST 9 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS "
+			test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+			if [ "$sysfs_atomic_write_unit_max" = 0 ]
+			then
+				echo "pwrite: Invalid argument"
+				echo "$test_desc - pass"
+			else
+				bytes_to_write=$(( "${sysfs_atomic_write_unit_max}" + "${sysfs_logical_block_size}" ))
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+				if [ "$bytes_written" = "" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written=$bytes_written" \
+						"bytes_to_write=$bytes_to_write" \
+						"sysfs_atomic_write_unit_max=$sysfs_atomic_write_unit_max" \
+						"md_chunk_size=$md_chunk_size"
+				fi
+			fi
+
+			test_desc="TEST 10 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+			test_desc+="with RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "$sysfs_atomic_write_unit_min" = 0 ]
+			then
+				echo "$test_desc - pass"
+			else
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$sysfs_atomic_write_unit_min")
+				if [ "$bytes_written" = "$sysfs_atomic_write_unit_min" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written=$bytes_written" \
+						"sysfs_atomic_write_unit_min=$sysfs_atomic_write_unit_min" \
+						"md_chunk_size=$md_chunk_size"
+				fi
+			fi
+
+			test_desc="TEST 11 $personality step $step - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS "
+			test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "${sysfs_atomic_write_unit_max}" -le "${sysfs_logical_block_size}" ]
+			then
+				echo "pwrite: Invalid argument"
+				echo "$test_desc - pass"
+			else
+				bytes_to_write=$(( "${sysfs_atomic_write_unit_max}" - "${sysfs_logical_block_size}" ))
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+				if [ "$bytes_written" = "" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written=$bytes_written" \
+						"bytes_to_write=$bytes_to_write" \
+						"md_chunk_size=$md_chunk_size"
+				fi
+			fi
+
+			if [ "$personality" = raid0 ] || [ "$personality" = raid1 ] || [ "$personality" = raid10 ]
+			then
+				mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
+
+				for i in "${MD_DEVICES[@]}"; do
+					mdadm --zero-superblock /dev/"$i" 2> /dev/null 1>&2
+				done
+			fi
+		done
+	done
+}
-- 
2.43.5


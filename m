Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546F3793DC
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419378; cv=fail; b=RoXSynzbJy2pEp++RHVFqrvtY4dEhrMEP4XqEV+KHtOml/PFOnDGgda2zVh/uGJJHYEh4esiXgM6xhaDisq9Ch9Ay/zOHXhXmsx/CE1Onfry2caztLdketUL7EvTCBWmzssiUTzMA199Wm8HXCRu488Xw9dmj0uVy9I7pWL3q5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419378; c=relaxed/simple;
	bh=/G4Rb0l7hDy0MU+4C8oVtGo5nN+CFIYjcH3DvEgpOyc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g4zhfFaXcjmOoZBZDzzGsZAvFCKNB2QG9GlcpT/6DTlHhwdmxQGrIKJHMqNykvkj2X1y2aF1rktFnvUg4vXhKWGQPvmZaxE8cNsnk0oQTcrdxO0f6ZdDlSn9TSh/N/Uu//HKB9Yd+A1Y+MVeewbFwVTaEQIx4Q4HyflYWOzZV78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PxkEDGKm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vWkm2GkA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PxkEDGKm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vWkm2GkA"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H3vEPR711681;
	Fri, 17 Apr 2026 09:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=aWx7AkEWedWuETqb
	IqCZcIQEr7s74+n8Uvj8mKKHcpg=; b=PxkEDGKmBpWpNxcCqt+BbjwIdWvPeDDL
	1H80iZjugdSAMBFfrAvtgWj9Ofh3C7Iytc5zRM3PESG+llk2pygs+/4z8ugVJk9f
	n0bvTtOqnVcXwHLQBzTovBxDkKsWsXxAMmwglwuXfwH4LCSm0ZnVM48C1VSIoRAP
	jbBH8LRuPhUJqEpGuTQjJnCHGOlYq18ftcEVdup/4mKDdCUel1m8RuYXb2kxee4g
	+3JqvU19SgZ28I/38cvqgG10VlIju8HI/VwbF/ccrfhZUFihrlzPqAARN7O8df+l
	USrSYzYo7/drsnQ2Whuz1y9b+KKn1g3Bg5JWkgmDABKjkJHp2n5UGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qshv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:49:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63H9nPDp037801;
	Fri, 17 Apr 2026 09:49:29 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jt34jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:49:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5EsMVwWVT4ZmNiOdngiiE3SbFwLj6qrBrjdm5tN/W/Bj8Eo2RQ1LEOZO3tE6+bpv98dv8QLOkeQqj6kuoR9W9oHFE+/+QVrjUfm44A/SAKLws8eoQQkHUVIfw1FA+CoUY1yBxtki2MRRrcR4l8DiQTDqd2h/Rp/dDrrTe8GYi6c5gpnIaumhEmuOSmbHbDtQWqAqBdWOe8WU7cpm84V57KjnNIlUlpgN9OIQiwd9n9kLPvYiPk4Zum6mUGC7MlusQHT+reMmStPCOPVXbI1JW28L3Z2ZZ4MxkAUClHvFWvVEM10U5IKoEzNXE0Ox0t7T0oHP0sDH1ssnDiUoXgLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWx7AkEWedWuETqbIqCZcIQEr7s74+n8Uvj8mKKHcpg=;
 b=P9XNC25WyfHkwHGf5efybqQKLMx8+u/42UYNxshLWBDJ62DeXDczOBdghLg2KygHxMj/ueireH8HKVrNDlrTWVH/Heptk1L3hTrRRczQ9Suzo9XpnfElKNj1SEMblyal1AGFfJDKd6xzh05uRjqCX6972/uGimg4HlzcyicFhzFrQ1BX5LjbQEILyOSc5H3H3DFxNHGGcQxbE/Mn33pcphBQGCa39naP0u3kID4NUaNuabf1dxPPL4nNDeORGpw3DAE7KdWRxZ9m7II/TTjkFwNEZGKc9AXq9L2NpeYhdbPGtuEro8tzQa1TRROb+iDrRSjsydnRZAgXhGyhJQJL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWx7AkEWedWuETqbIqCZcIQEr7s74+n8Uvj8mKKHcpg=;
 b=vWkm2GkANNfLaXoCfsnBUEkQjnXjf4mTF5m1/6qfsZUCd55Xd6B8YbzfaCCOeskhgAR7sQRpXzSTS2JsCE6sp/wIIPQSmesfH3iGwXwOd3BbrFQqjjtWNeds0v2mw9FD2mVNkodspDI8nFmXcrJoOJ7T3LQZuFQRpG6re0TbTJc=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM6PR10MB4377.namprd10.prod.outlook.com
 (2603:10b6:5:21a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 09:49:02 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Fri, 17 Apr 2026
 09:49:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2] nvme/068: add a test for multipath delayed removal
Date: Fri, 17 Apr 2026 09:48:54 +0000
Message-ID: <20260417094854.2135472-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 60253be4-863b-4342-3c1c-08de9c668e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ihE2XW4LXOsJ7KcQF74duHFPcrKfhLfZ0oORMWUz0rXWHDxQXVd67mn+nqB5izrvvtECHTX5/cgdZi8Mc2/NWgsdguPVeuYuO8W2s7eOHTD+KSEa8hJA1kWX8PlQ9OWL5Eo0l2xzYtVtioHxAZL1022nXrxLhrNhhjCmfgA3VYLF4EYYumBucbIm2y27sZ9ht6RtKIbQ2bCuYlb23PHK1p3DK0G1yTjNYxcCSOamUoPkJxNHoNaqbxt7Fk8zKYKx2LkXow6uf0ZQ7LuwD6KxAFqmProc4dGy75hRWV3X25sZft0xM09vEsA9Ga+bF3JKEfbi7RKW/IQtIxllrBMQlNO5Ft+B4ie92DeuPiQExnqBMiXH7k60nNL785iSWJ9nAbuDDrsuaQMOIhnfzdkgyGsoM4zKzmwBIERNM7PvtIt/MJQGPGhz8ZTnWuMUPbLVrN6nvPkIDkyOsgQex1HS8zVAt6VNpZdbZ8/iTOg5L9WXypXSfoa/+A9kVumchqzdXT9/+C935sH5Ivz0MAcAccxKvTleyf/LZJcIJvojICk1cuS84lrYcc7JHTUZsgXKLLGBEOQxci4NLjcEukoEMwcAYYTYYfC+HajSSz1SXQq9gDUVkPc8vxlVccRW4xeKYiqqrZcUQJfp8d0/J+vDrbjQKxiXWJPmitm9rIxMkn/bRsftRNGEL8dA4Lqpr1T6lkrUG/1RRYhAkb8/CUTGzsEl0NCTKc1U5EGOa41pKyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+Q1cLdBKCnAF6V/Xg8Vzs84NV1T870S9tnbZCOu3gGrLIsQprtj7ubiiE+6?=
 =?us-ascii?Q?8iXI8KCqKb5d7A17X5qDEgnMh/sU43Xf5FXi5x/FQUTeeyUPT3A5SSosk/Ry?=
 =?us-ascii?Q?hiDdUbsI+9H4wmCyuJUjCwlWEw3R7N9kQO7abMqG55+Jlx3oObMIllf/aZTo?=
 =?us-ascii?Q?NxMTMvZHXjcJZ8H67b4okX78zwLLPPxhgFu/KkiG7GSzowSf4BSDiq0OhXXC?=
 =?us-ascii?Q?iOsaOLltl4UszfvNb1hbR8sLOQPZ7wK8PwZUUTJ0f7d1J0GiR/YFxtJa58xE?=
 =?us-ascii?Q?zjy0EO6C8rnXA0mtp1V+cDooy8OswFZnBvMepv/AK914yACof/BdIOqWKrpx?=
 =?us-ascii?Q?m6ZIuUWIhzA87sEOTvMIqSKn4IYZzSfQcuHR5YccpEk7ZhgDlYkEmTaRgUre?=
 =?us-ascii?Q?z8pWW1CYDDW2TqpArJs6I2mmRCs+nsZRpitgmlecQIb0C8hvr3YDoXHu1KrZ?=
 =?us-ascii?Q?yWySALXf4X1HzRzbInhaFh165W2OWzZIUf4Sadhk40GFzn7QFW46JbLKjPCA?=
 =?us-ascii?Q?zGa+KCyUIC6C+EvpE6eHFkjQWYO+a46uov3Iqo2yDha7sREVKMSA0zBM6Y/N?=
 =?us-ascii?Q?S5Y+teWqzwSlQU5XbZTWLwwZ8zK/CjOWbilWHXgMSjoxh2A+DwulUDZZMg1Y?=
 =?us-ascii?Q?IgnNPZS7A8OxJYxg03QFnStiOgJBL4xM51bK0TmVTFmCev5adMtQTL15C8nJ?=
 =?us-ascii?Q?pexpnmqPqIt0YNQpNLa2UWFuKHiPBZiKJTV+bbxXLRUuBdRfX/o07O2qaqoq?=
 =?us-ascii?Q?mZJQbrYZL6rlN/Q3bfY0Cg7v14sbFIGBdyFu2cvb4d+C8U6YKU4+tbbJ1/tg?=
 =?us-ascii?Q?8ITZHnlilJL9kMDS2254bru8OFUep4STd9HUuTHfIIQ2Dy1xSUeSIOadgP10?=
 =?us-ascii?Q?eOq6a3vkc6nCft4sbv38q//NAsPm3z4P3RRbQDzXCQHuhaYHuxHOhsOQUvg/?=
 =?us-ascii?Q?SYu/OqaV95adla56z6G8HU6cOoioSxSUVbldP5IfDyfQB9yBVuaPwIXsfZKG?=
 =?us-ascii?Q?Jj2oSlyoLtpA++AGeOe7BrFQKM8rC1DpCgu6xVXKlxu8X1WAAQvFUTn14TX0?=
 =?us-ascii?Q?lCVidAJK0mpKb6gBf+l6DzMsH+k2iuVKnp6pw0cAiW4vNkLwOolg6NGb9uad?=
 =?us-ascii?Q?ia60AhqKLi9JOn8mkOM1NITp3iWpxeyCec/2EUh7KRKdV5RxrRPXJc+UkSYj?=
 =?us-ascii?Q?3lw/zp69KPmm+k9kImWK2E5qhSzOiJ30figbos7xn3MA1hsePwgEaDusj6w0?=
 =?us-ascii?Q?QlIw0gF6g3E5a4ui73CWIkE9azTAPjf0ItNcNOocf3WG10KLCE6zMOSifj+x?=
 =?us-ascii?Q?/PEtsOTBVZcFIl+AVkXtvqaA4H/qPG5JC+SDsHTEWCkzDLhKRxIgI4igSmDW?=
 =?us-ascii?Q?RbJMbfbRBbud5uXPRb+EF0tM6/QKhaH8BnIzAyVbieVnZBeEfyN5YK6unQL6?=
 =?us-ascii?Q?iIr6Pb+DYWu/Egb2L8zSFoBR7w657l4nHfeVFy5r1rywKw6d4koimF91AJHe?=
 =?us-ascii?Q?l/bj1KOExlHVqXwsHFAVU3HIKYu4/9zN/v4rg7lHbq8uy+HKSd4leYkPHO14?=
 =?us-ascii?Q?QA5Pjh4xucMoygK1YDBSZaUbyLebSL5SepqxnFbYHbkv9+zKD1jbk1dM2Sz3?=
 =?us-ascii?Q?fNUnRr0e/Bk+SAuQ4CvZOdo9whgLaAEBtTrQJr8QYakGXoMMfOVtyQoOGL/x?=
 =?us-ascii?Q?IjXyI2xOHdz6QK21FroiH89snJVy5vTOWncGnzfE/8pshOdrRwp8RtbEU4iU?=
 =?us-ascii?Q?KKhRf2aavQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	R441CNym8CnCSD4EGlZbMgg9FmDEfqLaFd336rISWkMgM08/sUHt6DTmP28FIyNhErJNUNyiZpEBFM+R2fHtx0gJJpyIPFwX6AOEeVSsxchF8wCeXTIsVxdm5wEPGpQoABfKv0AfYJ5ssSLMZIztolv32onCTSSj3C3R2KYgdiVQ/G3WLHNiDjGFL77wac2p5+4Snv00deidwXAHVHxdN6QhoJiIuPpPM8EHqo74nKpsC+JGbqsaKgs4HO18+iKpX22v041nAaWnS40371GKi3BgOPuSfmHjf4vDeDBQdaDpH54iMmD79FPT0sS9jgu2O21G7ah6PEl4Yr9tVUEeJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KdXT5rAQ8p/2t9Tfd/dpomIdrniPIfJPT4C2fWF3/nRPJzV1B9zfNB2rY4O1b7E3XqN6QdFk/5MQoBK08GfFYt8DYk/yCf51BEkGWhFqNrMlSVU8XeBp2v2/dy/l/qcQOZcHuzpLGG+OvSMScQPCyiTGCc/lo61FaJGiWz2fpbj7fqvd7fOAu63XToRhzCp3xBPWqDPOHTdVbDJQnlfKbzJ/ZBC+anj40GI78XDDPJpfrqJbunojncNp6R23IxR9DnWV456CMEaOQbs/NTrJys1zM3Oq6g9SlYaK3ItuxoXCLKl1oEBZVM7uUQfNS2u8yr8f7mCHbO39Hv9O5wSFHvrC0aJqO5W1Zv4Gq6R0PVKhnYERAy68Q6xxVHv6Kf/sSUVrlQmqSO4nwkSnp+DZ8L1w4qHTC4vssjyIR4G83q0G8VWMwMuHBY/dT/o6SnSsS9ESEwEpOMrQaEQHK5m9+QbZDb+xIcoGUtDeWqU+EHdkHpJ1vUZtQgspodF9gY39IpsVjqAgIdPegWeBfZ68VmKbHRM8j0gOSa1AxoH/9AsQm+DaVUZZKSIT4a5rHGFCRrzu9nO/sLAmwYEBoFBjAYgQX7gl1ZyAIrswt8BSHtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60253be4-863b-4342-3c1c-08de9c668e32
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 09:49:02.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPypGpy/1hMefsue7fGXohTgs8RZ0YRmk1QuhNKF+Aq7hzjVyp2VTzKgYU0QxV4/qoxNSBrNT1dTBRw7/gYYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604170098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5NyBTYWx0ZWRfX4urJlWv+BAYY
 Ok8Zhv39mHROoBQtU/FpBPR1Y6PFlZzm2aYOzSQyuq87yphcnzWtHJzfA5NiBfCLxHIbNodCw7u
 dTRx8xcf+blqGnV1mb1fwX90YaGkrhHRSfYmUEQrqExSaITkK0F5QRJm0UCF1z+22ZX+jPZGNEc
 lyjT++1/gXZ28GZXkB7YC9zev+o7pEOBIHBOTWl2Qz7WZupDP7FXYzD6jIb/b1LabbXg+Zt3XGC
 ObODR4/XxNPtc1NZ0L2kZ1op0NvvDjjlxizkqDioQsnRc5qUrEMM+FRCnBpLxkt1Kc23kx+UDLQ
 dBt3YJNaewSOJwZXbXMS7TuXYC/WnLuCUzMSNaPwK5hx5PRJgrLlkNAuvllunBsDtbJR4sGKl6m
 3IUaByL39W8G4PZw5OqOzY020hLkuzX1Ob3A9gHdqBB+gikL70M1NjBf3qZTHP/uJH6RaiunnLp
 3ksL6wMYrTuaATXpB6g==
X-Authority-Analysis: v=2.4 cv=Lo6iDHdc c=1 sm=1 tr=0 ts=69e20229 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=EOJ3w8Q1cgdzB-Jmg5oA:9
X-Proofpoint-GUID: h2RZdwqxghOeS4In7mAjK2uM3WJYXclp
X-Proofpoint-ORIG-GUID: h2RZdwqxghOeS4In7mAjK2uM3WJYXclp

For NVMe multipath, the delayed removal feature allows the multipath
gendisk to remain present when all available paths are gone. The purpose of
this feature is to ensure that we keep the gendisk for intermittent path
failures.

The delayed removal works on a timer - when all paths are gone, a timer is
kicked off; once the timer expires and no paths have returned, the gendisk
is removed.

When all paths are gone and the gendisk is still present, all reads and
writes to the disk are queued. If a path returns before the timer
expiration, the timer canceled and the queued IO is submitted;
otherwise they fail when the timer expires.

This testcase covers two scenarios in separate parts:
a. test that IOs submitted after all paths are removed (and do not return)
   fail
b. test that IOs submitted between all paths removed and a path
   returning succeed

During the period of the timer being active, it must be ensured that the
nvme-core module is not removed. Otherwise the driver may not be present
to handle the timeout expiry. The kernel ensures this by taking a
reference to the module. Ideally, we would try to remove the module during
this test to prove that this is not possible (and the kernel behaves as
expected), but that module will probably not be removable anyway due to
many references. To test this feature, check that the refcount of the
nvme-core module is incremented when the delayed timer is active.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Differences to v1:
- Address shellcheck issues (Shinichiro)
- Drop Quick=1 (Shinichiro)
- Reference kernel commit (Nilay)
- Tidy setting refcnt (Nilay)
- Add RB tag from Chaitanya (Thanks!)

Note that a fix for a refcnt issue has been merged into nvme-7.1 queue

diff --git a/common/rc b/common/rc
index 5350057..375c8f1 100644
--- a/common/rc
+++ b/common/rc
@@ -117,6 +117,16 @@ _module_not_in_use() {
 	fi
 }
 
+_module_use_count() {
+	local refcnt
+	if [ -f "/sys/module/$1/refcnt" ]; then
+		refcnt="$(cat /sys/module/"$1"/refcnt)"
+		echo "$refcnt"
+		return
+	fi
+	echo ""
+}
+
 _have_module_param() {
 	 _have_driver "$1" || return
 
diff --git a/tests/nvme/068 b/tests/nvme/068
new file mode 100755
index 0000000..81f3219
--- /dev/null
+++ b/tests/nvme/068
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath delayed removal works as expected. This feature was
+# introduced in commit 62188639ec16 ("nvme-multipath: introduce delayed removal
+# of the multipath head node")
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="NVMe multipath delayed removal test"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+_delayed_nvme_reconnect_ctrl() {
+	sleep 5
+	_nvme_connect_subsys
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	local ns
+	local bytes_written
+	local refcnt_orig
+	local refcnt
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	# Part a: Prove that writes fail when no path returns. Any reads or
+	#	  writes are queued during the delayed removal period. If no
+	#	  paths return before the timer expires, then those IOs should
+	#	  fail.
+	#	  During the delayed removal period, ensure that the module
+	#	  refcnt is incremented, to prove that we cannot remove the
+	#	  driver during this period.
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt_orig=$(_module_use_count nvme_core)
+	echo 10 > "/sys/block/${ns}/delayed_removal_secs"
+	_nvme_disconnect_ctrl "${nvmedev}"
+	sleep 1
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -le "$refcnt_orig" ]; then
+		echo "module refcount did not increase"
+	fi
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" == 4096 ]; then
+		echo "wrote successfully after disconnect"
+	fi
+	sleep 10
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" != "" ]]; then
+		echo "found ns after delayed removal"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Part b: Ensure writes for an intermittent disconnect are successful.
+	#	  During an intermittent disconnect, any reads or writes
+	#	  queued should succeed after a path returns.
+	#	  Also ensure module refcount behaviour is as expected, as
+	#	  above.
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt_orig=$(_module_use_count nvme_core)
+	echo 10 > "/sys/block/${ns}/delayed_removal_secs"
+	_nvme_disconnect_ctrl "${nvmedev}"
+	sleep 1
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	_delayed_nvme_reconnect_ctrl "${nvmedev}" &
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" != 4096 ]; then
+		echo "could not write successfully with reconnect"
+	fi
+	sleep 10
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after delayed reconnect"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Final tidy-up
+	echo 0 > "/sys/block/${ns}/delayed_removal_secs"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/068.out b/tests/nvme/068.out
new file mode 100644
index 0000000..b913d19
--- /dev/null
+++ b/tests/nvme/068.out
@@ -0,0 +1,3 @@
+Running nvme/068
+pwrite: Input/output error
+Test complete
-- 
2.43.5


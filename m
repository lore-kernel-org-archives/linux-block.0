Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483F7262A;
	Fri,  6 Mar 2026 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772769024; cv=fail; b=rdkzxTj7g/Gy+JJUkZjFZP4G2yQ9XbGNcBEdVy1a9n5+jZZzuI7TxjBqDGwOScizS+qRCL7N3nxQQSXOxwsJiuQRf/NkscUTRv+YyU4U1l+X7UtPcxXsvksIV5dUK2N5BHi6NbrbH8K3gamTNZTX7FqdX0XJEH7iKyQ6LNhjxms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772769024; c=relaxed/simple;
	bh=c3vrO5OIeQq6HXAHqgNTV9uHCi4dWTQS8r8RjC1JrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cv4htPxFrgApthlC1zIgTL9m7ZIEikTRscGKmdREPi3OUXWxqe1jCWI1gxXL6aZBX09jM7vA5SXCUbRkb+WRAvwa+N27FjL14uWMVpabrJWKBaFUqImCZ9OqJvt7TJXYpSYmUov7PyqRcxrRZKd8CnfD3wdIkZyWSoY080MKun4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JAAGBc7u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LUZDwabs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JAAGBc7u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LUZDwabs"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6262Xi9o1678513;
	Fri, 6 Mar 2026 03:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=c2mFaGdtFpIQABgBz3
	STnm+HRSMsJgbvFsKOSmotRoE=; b=JAAGBc7u1qBm1MmxcP1HGplbDMwOJLYtxR
	tW1TbsUQe6liZfMq6lrkwiG87lb3hSdtUU7IjH9xZNdxx7hrsq8fTT05Iohh11pU
	zL8JGSrZLh5tm6QuXxeuYlCwytCfH3MCUQne6tV4hhlBmL39VsGBWCY4UPEnH7Nl
	cUPYFcAzkSlhbdIjlV0xjFcV9TYxmJyviKwlqn+fWFESXx2v80V1w6x3Y2xSh9jd
	aF+M6VAMt5Xlh6iG64kHi0VC0TTQQxHdY9djMEr/UVMLj6ohmgDele8tMAsJOQJ5
	A+6cjZDifR0XpsNis+SYtcuo7VEYzf4UvZGIK8fVAH74/vYRB5XA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqp8982x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 03:50:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6262mntf014229;
	Fri, 6 Mar 2026 03:50:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdvek5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 03:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9QPJ+5gq7rrXO2MnXL9puhJxlDe5JGHgzQGjzrkuffi7vpNqOZRaYv9q5oQJIVu+xKVtyrJ6u/JicyF+RDXYLzev9WgLqwEF/pRaS2fbWjNkYU1TmWy7lzwYLLXSXiDfQsnX6P2hq6SgfBtsZKgqtGoYLYEW3SaonhXp8e4+uIfl4Eu8Mjw5zqMHaJkqZqJ+QMebQhJQCzzgoKdGFza3pDxMnhSAupqAigP6Aj9TLcrch1KLrsjI01QUrLMTbnqQm1KB1hqCtRJaG6xCwNA2jRHB77/Pcg4KuCrw4YahjXCWY/6v/wKEDSSDgWY74DvOHBHcdC+UglNgCGRFsc5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2mFaGdtFpIQABgBz3STnm+HRSMsJgbvFsKOSmotRoE=;
 b=KrXjZX2cFLtPLKo7hRVePvyh4fRjpX+ubbURNe7JS9niHm9Tj3k/PKYuyqPTsEzz3IqOFu0N3UCSDslc2LCwWqJoBOg1w/KISijZ5YeaKD92SsrCd8pMnyPMNyMG9YfE3VSVojOanRmdbtpqLBzKEqIVM50d2c2ePzMdz78N/tRD6xX6yRpNEcTuUEB+dIfl5SC9EB7vG7tRSg7ST1Ux/LHXZSAG+wudcYjc+wBHAT7b8bn7r+pytXIbIF3kkCc6DADWwg1wwepY7ODV2ae6TftHY+pkjGeXyy5l9d7pAOQ/Irx/V81KzXgbQg0hPy57MVw/XJWbjWCPQwa+nb6RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2mFaGdtFpIQABgBz3STnm+HRSMsJgbvFsKOSmotRoE=;
 b=LUZDwabs43hHjsMtEDciqMuSbzs7Z1TRUddR8B042pip8pOTXoxkxBt/15AiICybuqFbmYWpnJ9C1UoIgh2JvgnzBipFNIj4mnpU8nXFm8zTKJqDKPRuy5gHFFrkZqaarM+gMwFswYXeEqM/b9F90pmCaijhPRtS6K0M78rTgcU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 03:49:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:49:56 +0000
Date: Fri, 6 Mar 2026 12:49:44 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>,
        Yosry Ahmed <yosry.ahmed@linux.dev>,
        Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct
 zpdesc
Message-ID: <aapO2Pd9d5B6MEtu@hyeyoo>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
 <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
X-ClientProxiedBy: SL2P216CA0084.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a60317-0522-496e-ebd1-08de7b336e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	g9Wz9IczOf4610BEvdvYy8Df3CB3AW6tJtY8QFDRfGzqAtiLabnzcdBZb0xv0YO8nyKYYDZbUA6fFTvLNXEtAYGUQWKITq2NX8YlMLcq7vQ1fXzFdRJ+zJF0ckHPWFDsO2a8TsXhDftrLBBRshAFpQBe8xVpsxnIwMpCuY8H50bU8JxuaKzmCERklrhmHQEZfsjJ8nDUee0ACM4iOiHr48BwNxKo771i7ljhWpcyx2yVTk9HfshQwxwFODKcV7h/qhYfKJCba5CJi4SrQpnlaWqsU7GOTLrQ2bTPHBGD4PfTHmBZ8Rzbhn+pUVM8fIySmvEpt75lnmPLSdTbig0I5xPTbWNvW/IgweQA9/2cNiQIQQX7cTxjRbanSwkDuFdMBz+92/4L3iQI3k4TByPx6c+h2fAmzlmF7YYlCwTQWNAyMPc0PBWsQu5T5KIEiJCZGahz22KgcwTDG4LUPXLBo9knV1gINLyz+GQEv7lXrwgKvbimzYOAbsQjzeMu4t/NYxsgWE9qLJumFwka58/6Ahd2BvulCW54GTqAmCYcSyd4KadfwlXmrDYx+e5QfgrAqmPElONfRPSuneZHuzmIVtVTd+F0DTsXmNva8wrIxOQXFkcqNYw4CZY1mKLXI6UOxBIBs9xdDtyu0gd+c2iF2EhE+LhIhYQTSSYDdLl/jpopXW6qNmcUJGaUTL3kasrs9brKXamLuJxYGEJmvBRrLzvXAHQIZ9dTRq8ylJwtLmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?49kcQiWAWJ2QTMtuaM9ZsMy58ZJwsFhA4EqLsh2sIXSipvbEf0Sv+UcwB/jI?=
 =?us-ascii?Q?1bMAuJORrtPnpiIxOIz/7FNHoL13u8/z5J+POcTiE/zeald4bqrChjF7arQH?=
 =?us-ascii?Q?tBvxNugSdxG0arXQUxX+wcwDeAKfSmYarLIAwbt7+SJlPNjSh4geD4PEuzoI?=
 =?us-ascii?Q?EGDRS51rlI4D4PCMY2uv12e0yNrbPVd+8CQkaeCwlz70zIrHtxsJH3aw5Efj?=
 =?us-ascii?Q?EpDJrhuw46t27Mg7xpmYA/lY51a7V3NV+Y9yd/qC3tSgkJrL6o3ip67V5z8z?=
 =?us-ascii?Q?Y3G006CXpGK/TQdIJGIlPJS/Ymn0R5C2i/E74sePBjZh/9DZx8PJjOzIdKsR?=
 =?us-ascii?Q?vnMm2qyizhjBV4EXtxZc8nCm4OTU0fnZMuxtFAiCO9VKH5TdY4aU2emRO6Tj?=
 =?us-ascii?Q?vvzaliJOLjI7E9CyN9B5FsdaFroPnwvNA9J6nzu5DRapj4Nmo5pQhbe+kkXR?=
 =?us-ascii?Q?6J848o9HkZWdj1ZHCskOYZ/Lp99U3PSOpbKHuMijGGYeCq1hWf22yRgcCVcE?=
 =?us-ascii?Q?YXnluFszWYMt2UwbKt8sNaa6n9MatHj0nm1aVjWV64a7MjBZO2igLHPOeZ3s?=
 =?us-ascii?Q?XvYp9bBPhNPb6Tk9/Z5Jmt87g3Lnjr1YUbyDR8gJRcQ/fxU/P/4yam24A2Bi?=
 =?us-ascii?Q?1aoXYoDqE8lJVXDrMfGj8K4BRMI7O5I+PDYLSUTMGR4LcXzjA1BdCRMx35DL?=
 =?us-ascii?Q?iTxP1boLaIkrimHIBNhbRtqSaxL1TVEktfaC48JPgomYxcqGRaPE+ZSBoNYT?=
 =?us-ascii?Q?8tMRvSoG5SZ5L5szhRBkElOzoUc/Nc1skXzPQO7f3vbn/XEwP5rh/CfxsOyx?=
 =?us-ascii?Q?vmVVUl5XrtscWijp1KGz3w/quu9XctKtbMx5fX7GZMqdLpcJOVSDD9o5pmwQ?=
 =?us-ascii?Q?aNq80KFeOwsvJcQYWjkc4FUkmHjA8j/gdyGecaUrtrZYsP73lkO1d4skYmIn?=
 =?us-ascii?Q?9QKz/o1zC+lzOkGa7k8DU3krKR+4yOOZwIz2UU57VsT9FzNUC69/aO5RGRGl?=
 =?us-ascii?Q?WG/hK5P2mrM3gBMOttBjUlt2q6DONxTwFGm2u4Mp4gYwoG8cP6MefrV/+1zv?=
 =?us-ascii?Q?7xoocsbrk551K3ZR1Jg2mEpDP9WOJ6gM5QL6xAg3nNZELBbkWeu9YwsstWIi?=
 =?us-ascii?Q?EzG7OV9lJJT4C6JkGIycUUsswNKeCwfeNd50rwD038PQjxZUn7Wkyo/4kWGm?=
 =?us-ascii?Q?M1o1qukthLW8zDxTfuLDwzH6JF6DRaXPLZK/ADNY2slDSgbKAUi0RFx4e9pq?=
 =?us-ascii?Q?c3uw9Ahd9ZoypflruNTbC1o8yVmCHeMyms1WDKhza0lRafzPueuAwdLwpm3E?=
 =?us-ascii?Q?B+0UkVAkMSzNvPrl1jFuY2+DpczrNCiBqeYl/uh3AQGI3CdYbw51Y+GlWfyC?=
 =?us-ascii?Q?1EY00yr73MAvxzoGODcIY6iqNKcYMeHGv7O1yAfzoiKKMhC7sbgV/yrISC6V?=
 =?us-ascii?Q?MYnhL2upuJNqrvMBuFDVL7SQNWWMgwSJ8R30G24kswbx6/lWbL7ducDaTR1o?=
 =?us-ascii?Q?/cJxw3xIf6yTcixxskqKZnKfa8ovAA3ftHMF1aoe3PN8oycNGTTdND1xBA2W?=
 =?us-ascii?Q?oC5n4yDWu3NyywUHkplaRU/3PBwd71iX7Dc4NQ0fq8TnRCjjJHcqvKLEHSnp?=
 =?us-ascii?Q?JjLjNGdTMMqv8Mmx1rxdiT+dqapFxKA7a31QX0CgvXzIuG29pz0vR9uLkdrF?=
 =?us-ascii?Q?9QCt9n6QoqWIcv+vZbxr152enhsQX9TKXgRUOzkYnIA8MrzYAYyoQzIm1d4B?=
 =?us-ascii?Q?39GhOKc0MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9C+3SsmJxgyniP4YOL8czMTGBJOJH5KMhjdThwcqp4CKnMYVA3n0dlLvSkL/1/SI4tJXx8mzJXRK/I1EHeFW+WntTME9aFJuDdc4tuiJUNyf1LZnWX6DhlEf/AGLHPiEFZ2Oy/ji+Cfwq6zsJHK1fed1rwDMcVl4ZU8lofZlYV/B8QLmkKYM5fpjxN2FpITNNvNwVQMympb4YHiSDks6gXLlGjXe4m6oe5WZjRdqTEHKICjJePptri/Z179OyHe+iuQi/NLzKlQ6qrnK1uMJed549NHcUs7BdhNPwbOpFGDPT/ac+QVyWF0mpg/yK6tPZKDWUCpwFtQS9NPCyG/ySWIccNHm5XzjF6D47g6PPoavDMBMjmchqiPtyxLsF7Wnz7c5miuEXsSUD/PsgQRiwRrRPbn2cxcZI7EcR48P+LJgAx2kYBy8LRTmkq5dD/udCcEdwtgpBCyELb3Dz3FOdYCXD48wWTGPmOlFKMavJSOgXWgRUUqCEPeN9+9leOc6sLwfSFcKQ+btsWKzT8723CMgXaIYjBZOFCIuFEBNl/QaDkE5cZ73zxH5kqUVsyyPNMn9M89WKWF7FZJ/t08KalnCKBVcyMGxsc+9mnnZaGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a60317-0522-496e-ebd1-08de7b336e86
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:49:56.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2k/dBSoInxYMdwTgotzJ+FJrkWmBzVUKXOmCfQZc3YCYPMSo6FrtNUwJBTcZvb8mqrAohcOq330XSy2xyiFsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060034
X-Proofpoint-ORIG-GUID: QbwywbOU6F6EV-wGlo9n8-D_C987D7i4
X-Authority-Analysis: v=2.4 cv=etnSD4pX c=1 sm=1 tr=0 ts=69aa4ee8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=ufHFDILaAAAA:8
 a=pGLkceISAAAA:8 a=GYaa-zu3aTor7Woy8TcA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-GUID: QbwywbOU6F6EV-wGlo9n8-D_C987D7i4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzNCBTYWx0ZWRfX0l9jb+Ftll94
 19belTu1lqKj/s5bUbtlrCnNxEGAcpCaUectY9dccavowyRL/imCjrBJdwigCHs/4DoUAGfy6dq
 E4+vhhYL6ccWXUykVFdYBzEwPaDL/4Znnj5zxzCQGoyweBurRRSVo0bihDsq5rv4z+iRBCVzkU8
 h0PPyxdXf0y5O2K2CBhA8agqtouxzwy1KBBWgYthoq6SgZqp6ntyPgYltxAqYHm3dfeWU20Y4Ep
 kOaxQ9YFc0yZeHlINkK9t0OZCQhTGEYcsfFps0251hQp+Rn9fXdYT3V7JdFASbT5do10OzugWAv
 mUiGuqK2y2GSJBtfh4g8VME0wuBnhJ3M5xjaMgplrxKJf7fxVMJC6pSilLJ7tMjii1y5csXCoVY
 ZfDi9gzkHKjBtwRGdhzqYp9jJTQN7MJlF1Mrl+ikNCnvpmAytjhuPWP1g8RzGlnTC7H5OpzRseA
 0gqBNgJirzjzr2dnN8w==

On Thu, Feb 26, 2026 at 11:29:26AM -0800, Joshua Hahn wrote:
> Introduce an array of struct obj_cgroup pointers to zpdesc to keep track
> of compressed objects' memcg ownership.
> 
> The 8 bytes required to add the array in struct zpdesc brings its size
> up from 56 bytes to 64 bytes. However, in the current implementation,
> struct zpdesc lays on top of struct page[1]. This allows the increased
> size to remain invisible to the outside, since 64 bytes are used for
> struct zpdesc anyways.
> 
> The newly added obj_cgroup array pointer overlays page->memcg_data,
> which causes problems for functions that try to perform page charging by
> checking the zeroness of page->memcg_data. To make sure that the
> backing zpdesc's obj_cgroup ** is not interpreted as a mem_cgroup *,
> follow SLUB's lead and use the MEMCG_DATA_OBJEXTS bit to tag the pointer.
> 
> Consumers of zsmalloc that do not perform memcg accounting (i.e. zram)
> are completely unaffected by this patch, as the array to track the
> obj_cgroup pointers are only allocated in the zswap path.
> 
> This patch temporarily increases the memory used by zswap by 8 bytes
> per zswap_entry, since the obj_cgroup pointer is duplicated in the
> zpdesc and in zswap_entry. In the following patches, we will redirect
> memory charging operations to use the zpdesc's obj_cgroup instead, and
> remove the pointer from zswap_entry. This will leave no net memory usage
> increase for both zram and zswap.
> 
> In this patch, allocate / free the objcg pointer array for the zswap
> path, and handle partial object migration and full zpdesc migration.
> 
> [1] In the (near) future, struct zpdesc may no longer overlay struct
> page as we shift towards using memdescs. When this happens, the size
> increase of struct zpdesc will no longer free. With that said, the
> difference can be kept minimal.
> 
> All the changes that are being implemented are currently guarded under
> CONFIG_MEMCG. We can optionally minimize the impact on zram users by
> guarding these changes in CONFIG_MEMCG && CONFIG_ZSWAP as well.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 10 ++---
>  include/linux/zsmalloc.h      |  2 +-
>  mm/zpdesc.h                   | 25 +++++++++++-
>  mm/zsmalloc.c                 | 74 +++++++++++++++++++++++++++++------
>  mm/zswap.c                    |  2 +-
>  5 files changed, 93 insertions(+), 20 deletions(-)
> 
> @@ -893,6 +898,43 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  	set_freeobj(zspage, 0);
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> +				struct zpdesc *zpdescs[])
> +{
> +	/*
> +	 * Add 2 to objcgs_per_zpdesc to account for partial objs that may be
> +	 * stored at the beginning or end of the zpdesc.
> +	 */
> +	int objcgs_per_zpdesc = (PAGE_SIZE / class->size) + 2;
> +	int i;
> +	struct obj_cgroup **objcgs;

Just wondering, perhaps it makes more sense to have an array of
objcg pointers for each zspage (of size objs_per_zspage)?

> +
> +	for (i = 0; i < class->pages_per_zspage; i++) {
> +		objcgs = kcalloc(objcgs_per_zpdesc, sizeof(struct obj_cgroup *),
> +				 gfp & ~__GFP_HIGHMEM);
> +		if (!objcgs) {
> +			while (--i >= 0) {
> +				kfree(zpdesc_objcgs(zpdescs[i]));
> +				zpdescs[i]->objcgs = 0;
> +			}
> +
> +			return false;
> +		}
> +
> +		zpdesc_set_objcgs(zpdescs[i], objcgs);
> +	}
> +
> +	return true;
> +}

-- 
Cheers,
Harry / Hyeonggon

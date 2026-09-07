Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAF448393
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773701; cv=fail; b=ikPe9/71cGNgePOjJwIiKa3IK+JLIN6J6RJluAf82AsadHw6JabgquScBV9EfZEtakHITlTdQ4IPegOz+KvTFAesey00cX8nx41f/9jIFsk49WQ8rlpo15SjaFSVWBhhXQDN3DN8CGVJ4eeJWEXuaTvV/Thrc1QnU96MKcADfnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773701; c=relaxed/simple;
	bh=BnL3tmkVdlU8uLb7+bi1dRKpxxLjLza99e1MYGzWIlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeuzm4/ULS702KgUIlSlT1ymbuQQXjQ+gRhnu7S2HSHlQriKCrrj7MTiQdAOb5sa4ioRJCmHXpOlzkhyr9yCnnRcL4kHA18NxNoqWP1NiMFpLd/puhYeJZ3aL9MmV3vzO4U4HRsuz3PMqy1nEvtfszFjSMQFImgpbdm4YEA5SEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XoMc1SR9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OcgP3+XI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XoMc1SR9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OcgP3+XI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870UZwo186187;
	Mon, 7 Sep 2026 09:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xyf+U9Bvz2r9NgOyk8+vNqJTKxBzltvMg4rfJKKiXmc=; b=
	XoMc1SR9VBfQCH+LbIiBJx3k2utVE8aliWwwCthGqn7WK6hmcnxlxRjNMqC7aDSs
	GEeSAA1W7QSt/1SbrMwBak/osevwaUpObncWjpxcb9ZyQtFatEfpdRIw+Vy+jbSx
	dBjOiVioJYWAo210X4Hwxn7LS52InB7GrW7182IRuqCtT06Fe0NSUuyD+zV9/JAJ
	Wwe60ZX2VdeTK7R4+sLWuKCPPWUBq28rU5iwg8VuLdKnjXiardMi575Q0NuOE9FF
	aipRlUAJwxV7WMH3la1E5IXP3IGKR/4+PcEvj5Eco4w/kS7qoVnqrSS4M0XZvKWj
	GSlROvkJh+VO0jDTcq5UAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbmq9qf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 09:34:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6879U1X9036749;
	Mon, 7 Sep 2026 09:34:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gh74xepe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 09:34:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ6BgoY4PdpAlPXQYa/vA0SBuJG+aanjGXDDZkWn8udGbLKmZ3W6SS9E7OzmKcqa6x3kt/hUa0KICm8GI7YRhd6egoxgQL0G/7VcKtpLcb5siEBM+C+uyp5Ur0FdwEW3ZbD0w4tlh/dZ2H1oj7ct4iMOpIkv3IagI5ZRTVXerQWOy2RuowmvYCV5yQmkjC/g28IHHlFWZoC6LZz8LIij75W2iYq3MuBAE8GicIrXeQwmOxQxqMhBAwgnkCO2+a7a3Xlewi8hGLYyOaXstCkKb03LSKzG+7E1CqH0tiheqLjv4He2Zdr+kZscLbr5m+U5QdEf4s+bjSKMOe2dx9ueOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyf+U9Bvz2r9NgOyk8+vNqJTKxBzltvMg4rfJKKiXmc=;
 b=AhfW6V5NpIaVoP1H4zOaPK93ppi6zbB48R8GtdFI8rqeSK/lIDtXPIJTlu6QOo+Jw7O0EBVHCB99OahqxmA1rtkFn6gPJXpXBiuzce1iKyIH+A2YTMeuowteMfP2RrTsxhnv1M/heB0gwdZuo67OzETaqw0I0GlCHIcz3jmrD3Y+XTPtyzXK1z3caBlnii+SkScIxBKbS+/IEpEsm8VkUVrVIi94mb2/msp+JhZwZ7jVhUIOJlifCL/kmxA7W68uJ/X+0k+qCtVua70PZKMYKHTPFashCO2OrvLNDdv6lXvzZoLSZjSbf+48m3Y15/ZlrTUBQvizKiPACD7+D+jZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyf+U9Bvz2r9NgOyk8+vNqJTKxBzltvMg4rfJKKiXmc=;
 b=OcgP3+XISdUQinoLKQI8WdYCM1F89QIio1zXpnrkuQHxH6Jyx8gR+YcTyLSPKcKDqEg/owcq+GEXGKsMF0XBOkLiKIb08FkYYHZaVLKuYk3XCMG2v0JgX0joK2RfepViiUnToGuayx+PDcnhKC/xXoifCgeINZxHPqKixdNpmqU=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 09:34:22 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 09:34:20 +0000
Message-ID: <b6372900-7be4-4e6e-94ae-f816341e4c07@oracle.com>
Date: Mon, 7 Sep 2026 10:34:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] block, nvme: support same-LBA multipath limit
 stacking
To: Yao Sang <sangyao@kylinos.cn>, axboe@kernel.dk, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        john.garry@linux.dev
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9e44fb-d340-4634-19ff-08df0cc331a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dELWym3Nv0c6vXVRbHGYFIWyOuTEuYkhDMspQ6x8xearyUa8AP0fczvSn8Woe1pt2He/tNwgVd4hsFu0Kk0jPNkC+VpUV35RP1VbWsdcg47KHywiAR24OHYpDRsqv3PSJBmSXaCH9mb6PiBwEYVhehnhA8vsoynT7PA99USWUltMUWM5cTw2nv+JpTZsHcuXi8js4LKGrVGczonEyMy1btvJ4wwLieIQVUk39mdN1JAN7omxcbo/img0AcPC5jVAnLrKjgKfomy71rYu3oWbULHaTgL9q5tTC5yLsaNaJKAswqT+X4Ix4VQrtNJPiVhysaJlSO+AN+2t5mangZVoKX9zLm73w1Lzj77tjZvMdF/626+HVZhij+TZVwsjocQYWGz2bznCNfahva0N0iVcWYKnF8QEa8rfuysSRslVIx6JAPXqeLv+M+pgP3w3j8o7wH1VMrHNnb+C6yL9yENMXnyjqrJdOdYniCFHsZW0zZ/Ut2k3OB39SHD1vcOVnoUuzeWR+mWvbIpJjHuHCgXmeGn9DZRXjNV2IFP/pQiwuKuxnL/7VT01dOPShdpQ1vyd8ljwE5nzMBk14bx2NucySZzciKKD0A9CaYqiJCD4zVMprKOrsnHechFD9Bw/xGSJaAAyXub/vI6bkREitLm1oymBaLQ7sl4Qtwq9qkQk5sE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXE3bmg0ZG1qcUtGaUN3SU9wVzhvVjdrMHJMdS9OeCtaR0x5aU9oUEtXNUNQ?=
 =?utf-8?B?SlFUQWQyNU84Q284UUFmcGRaUW53eGhXQm1RRC9QdzFpaXM0STUvZ1VueUpS?=
 =?utf-8?B?SXJqcmdINnU0aVN2cHYrcjU5eWpyTmJTdUo4NUdrUllYOVlwcEROM2JVZzli?=
 =?utf-8?B?aHRJR1RVYm5EWGZ1SkY0cU5obWprQlMzMTVuYVJvNWVwdzV4enhSd3FYMXlD?=
 =?utf-8?B?aVpHTWxGUVBEbzl1MWplTzR3bHRUY0ZUZVQ1Mm9SemNoUDRZQlJPK3JHUnhz?=
 =?utf-8?B?R28wWDlPNWFoVTMxL2lKY2w0ODlpOC9rR0ppUUhsZUFwMTRHbm1HeE0yUkVs?=
 =?utf-8?B?K3dBNEs0bnU0WW5uYzRWaDlkMmw4SmpxQ2tsQnBlVitPVW5UazRiWDhiOUVo?=
 =?utf-8?B?cWVsMXZCUStnc0MvSHNncExHZHN1VlY2UXFrdGo0djYwTm5pUWxBYXpDZ0xi?=
 =?utf-8?B?enBoeFF2dnJnOWhVd2lqRWM5bDNBaEZUcGRqeG5Mcjl1NUFRRjJZazgrSExM?=
 =?utf-8?B?c1d3azdrQVBXWW1xbVRabkpoRkkrTzJKbUU2bVRrS04zQ3dWZ25QL3BIcDVh?=
 =?utf-8?B?ditWT0pqd1I4dkRnaklxU2VjU284S1VmbENUbEIzYTNyU3IxbmxBTERPQStF?=
 =?utf-8?B?U281QWhxRjhvNDVqRGt3MDZWa3hEblV2NUFIUjJVNmFpRTY5Kzk1bXBLYU5j?=
 =?utf-8?B?Sm80MnQ2NGNMZ28yVFFLUFFPU2ladUc5SnVyVEJBLzNzY3REZVNlZTVGMWlx?=
 =?utf-8?B?SUIyakV4TVFXSmRTMnMzSDFrdVBYVmNKOFFUdmlhZDJVY2wxUFNNTkFZSkxI?=
 =?utf-8?B?Y2tRT2hPSVdvKzJPVWExT016WW5GNGU3Z0tBRUhQblBvRHhybEdLcXNKY3VR?=
 =?utf-8?B?V011VW53K2FNdlUxT3U1RXpoTGJERmhpZHBOdmNTdDdaV2lzaXorc1gxMmRt?=
 =?utf-8?B?R2U5TmszeU5ZMzRxNG5Fak9UK1cvRFdyaE9VSldldWthTUhKV0xjR0F3ellh?=
 =?utf-8?B?T2hIMCtjVVJGV2R0bDhoSVVPM0tDS3h3b2xKWWJBTmgrTTg5WWh0ZUlxamJw?=
 =?utf-8?B?Y1V4VFk0a040ZVFydDdJOUxsSnFIU3lDS1RRQzBYVS84WEk4VTV1clUrVWls?=
 =?utf-8?B?L0N6ejdOb0RBUUc4M1h0QWVkVHN2NHBlM1ZSZ0FKNEliOTFQaDRJejhna1hl?=
 =?utf-8?B?YnUrQXpKYzNXM2FJREZPRnVkc1RpSFVtUUFYYjl6TDNhS1RpOVFVbjhyYUxH?=
 =?utf-8?B?aWI0bGE5akpnQmY1UGxreGRKRDYwN1QwSGI1T1dvY2pGSDB2SllLVTBTeDZ3?=
 =?utf-8?B?R1BENGVKL21OUnM2WENKazJNRzJZWEdqN1o3Z3FsK2JRU2dnVTBiZzJ2b2Rs?=
 =?utf-8?B?K0t4UzVsRDhoZ3VkQmdCdjNFc2ErLzM2RkJJNjFPanRkWUQzM0RnMERaSkdj?=
 =?utf-8?B?RXZsZTFPbDBxS2VqUWIyOGMveEl3ZHErd05mRmV4OExEd0pyV3ArMmdhZDMv?=
 =?utf-8?B?QzlxOUlHOWd3dEFBdlVqSVdzRitHRUNYSVBqcHJWSVBQZVljKy9GUmhzMGZi?=
 =?utf-8?B?UHdRdzlkZ1ZpWXJTUnU4U25JaHdBZzZJKzI4OXo2anRKZG5QOXE5Z01Mandw?=
 =?utf-8?B?eEZ1WjJSLzJlYzNKRkNiSXVuM0dMTzBNeG13bW54WmJvcGVPbUF1eEdzdmVm?=
 =?utf-8?B?Q2JyTWFrMzZzdXlzU0FTcE9FMFIwSG1CSFQwS2xlV01jV2l6Z1pFbnpYc0lW?=
 =?utf-8?B?QmZIWkptdURTMVY1Wnp3TU85aldlT2ZieXRZYXhzR0tjY2JtMk1aRCtUYjVk?=
 =?utf-8?B?WTNVSzVmZCtWTm1PeEVPRnIxYjhVTHJsaStSZWpPN21iWEYyYXdNZDAzVmZl?=
 =?utf-8?B?QkQ1bmk4V2UyN09DRytpd3pSbmJvaytQRGUxWnVJNG9OUndFazIzTzZYdm1l?=
 =?utf-8?B?TzlqclhGa0FZTlRacnUxN1pRQ0FSN1BtRVA1SG9NVnNQYzlmVEpqN3dLRXlq?=
 =?utf-8?B?UHFjeUJmU0I3aDFhZkI0OWpKQzc0b2NLbUw2SU9FV2U4cXYrcVgwMFRSc09B?=
 =?utf-8?B?bmdCWnNIOWFkMmt3VU14UktiUjAyem9iQW9PMk53UmkzbTNzWUswamhnQm9T?=
 =?utf-8?B?MkZJNXJrOTYyZEx2Uy9WalcwdFcwRjJqMlR2U1d2OHg3a09heTIwcHlIdmpJ?=
 =?utf-8?B?Q3VwaklxZ1cyelhxczBadEFlVnVRVnJmQUViK3dEVGx0SitKQUY1RTg1UnRv?=
 =?utf-8?B?dnYvZThqQUQyNEN2Y2diZmJ1UWJMd1hQTllEU21iMmZCNy9jRHlUdEdnS2N1?=
 =?utf-8?B?UFRVeFpjMlI5eTM2d1A2MHZLYm9OakV2N2VvNnJyT0tkM1VQeWJaZz09?=
X-Exchange-RoutingPolicyChecked:
	NVbOFRb/izfqWVBF3TEuv7+X/llPIGboR+iQEAe7Jx6spx5MCZtnKhnScfFJ4cAqKSU7W+l6ylau+SAEpc+P+MgLpivytjaWJq92xGbcLPXwYIt7SNKvqvgBof8YZs01UuEgxOqXPbGSV2rw1OItMWkTfPilvV4NCJdno+kMpH0PfUgdu3I7sFhVmFSfcwHtVL5CwlQOMyK9XUr+gLdhYSbATvWjevZ9OsIVwth2T/ZyCQt50OVvrhWCHo35v4NHHL9SRadzLUf6FK8zdf0tzkL1vAjc58HtEVgzsQx1J/w7+sIU9s3loh6ZrkBJbJhFQ6M2A27iLbquT6C1lW7aGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x2Ep9KApUUina0rHLPvulk+FqMxpDiE24wLUv1WGUBQvlon86mbZy61O2LZRJypIQUYl6TGhluWjTBjc4plsIPP9L1r0Ut4RlL/k2FQcS0Az8GsMEr8CFTadj1CR+EAgqfGp6G+k6IbvyT2xRbPl0bWzKT32bOySyULJqGO0/kVDFW0lNq2kxRFn8Wdrh2/XAx2vkSf1MuuoI7HWvbj53euBCzEdOhwUYd3+KN0JjzZ63m6JP549bbECL1dmQPdDPzEe9AwGYfcKLmV1Voup7aA4Gmz5kQz32N88UoQaOsltNVG8808QwASGmrJIKYDcSGWFx0HFOhGt65SsWCqoJGw2sPfp2F3zhY+MOBlWne0OjZt66UOnHhabdcud+FuTeU7c+AwGSBSN7ow4qoyHsc+dE4LCe5fGilBG9UXzACRLG+8rDqB0N9N0XJtju3xnkS6hPazIn7Yr0YyQY30T5P92y2xMQ2UC8ncCm6F+C5BlH2c0C+HAWfga6AbKEg07SMM5SKy+gF/1NqKOJdWQN2LDiiOF/ZegX+1YCBhlgBPOe5mrMPua09vDJ/mTP+K8enTLuq0lis98wWuj0JPhUJUyaxpdVjE4eEykskZ/hXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9e44fb-d340-4634-19ff-08df0cc331a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:34:20.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R5nOQ2SF3lnbEjyrVloB3EnpgMrmW8OUlYemGCesrv5M1P1udp1zbSaYCIImYRqi3Qv/tpoFo79tH2xXR3x5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=742
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609070103
X-Authority-Analysis: v=2.4 cv=JYiMa0KV c=1 sm=1 tr=0 ts=6a9e8522 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=Gji_SseVzzSXUMt_T40A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNCBTYWx0ZWRfXwDpNJ2sYpai0
 UvetQtXoUX13VCqX2X1/cjnJkQHdgWfsZNSz0SWqWz+C1YkM98p7+2Mu8i6hz3juWe7Nhafzrhv
 r3RbXAcjTz4dWrGMwoLnR5/3fLZbN323ptFoqEbjoecVjTPgOpkRyaz3UcYC561jsLraIfg5rcU
 ZWMboTJatBXXhlayvCEYV4BMboY5mH6L02m1ibsJDRuqCeQUatX+2Nt13HBuiynzgERvFeQepoO
 kjqoJl+DxF0Kar77qZYfnQ721pNRo04KzZd/lAwvTwZbnRUINYpee8p2qHVDs07apxuA6/xpm/M
 5K8spCgEHxpcVaEnTPJI/Gq5XNgK9EW38mGQF63Y22byaPuRqV4jw7jJ9xT+XqxN4hhiuaS+lcE
 eUri8hFAaRfT0s6Jm5mtpo8F7L+tnzYOQui9B8hiOE0cKbuJpB/ZVXu7RAVxk09dToqY7j1DfFN
 +jU9CBicQX25CzA8rtg==
X-Proofpoint-ORIG-GUID: fDAlA51ShNiDhBowbkazX4BSrHnrTs_p
X-Proofpoint-GUID: fDAlA51ShNiDhBowbkazX4BSrHnrTs_p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNCBTYWx0ZWRfXzqGqZArLDTF4
 nIlERFMgs8U8vyXaKp12aPHxXg/Om8U8cuDLK0tzwkBeUahszLw9MzwSdvyv34/7pQsHRtcaPv7
 Np0+b2GiJK3huY+czGy9tzIH0stSZB4J6Y0ZVh+j5HYQIZlI0u1U

On 21/08/2026 11:10, Yao Sang wrote:
> blk_stack_limits() stacks limits for a top-device range mapped onto a
> bottom device. Same-LBA multipath instead needs to stack limits across
> paths without applying mapped-range topology calculations.

Sorry, again, I'm finding this hard to follow.

My thoughts are that we should be doing the following:
- apply the "topology" limits from the first NS to the NS head
	- those "topology" limits are fixed and like logical and physical block 
size
	- this is only ever done once for NS head lifetime
- then stack per-path (NS) limits, which may be affected by the 
transport or HBA or controller

Am I right? If so, is this what this series is doing?

 From checking nvme_update_ns_head_limits(), we seem to apply the 
"topology" limit per NS (which I did not expect).

> 
> Factor the common topology, path and atomic write code into helpers. Add
> block helpers for same-LBA multipath and use them for NVMe namespace heads.
> SCSI multipath can use the same helpers.
> 
> Changes since v2:
> - replace the exported low-level helpers with block helpers for same-LBA
>     multipath;
> - keep mapped-range and start-dependent checks inside blk_stack_limits().
> 
> Review of v2 noted that fixed namespace limits should not be updated for
> each path. V3 separates these limits from path limit stacking, but keeps
> the existing NVMe update behavior.
> 
> Changing this also requires explicit namespace-head revalidation after
> events such as Format NVM. That work is left for a follow-up.
> 
> Tests:
> - blktests nvme/004, 005, 006, 008, 010, 012, 014, 016, 017, 018,
>     019, 021, 022, 023, 025, 026, 027, 028, 029, 030, 031, 040, 041,
>     042, 043, 044, 045, 049, 051, 052, 053, 054, 057, 058, 059, 065,
>     067 and 068 passed.
> - blktests zbd/001, 003, 004, 005, 006, 008, 009, 011, 012 and 013
>     passed.
> - blktests block/003, 004 and 012, and scsi/009 and 010 passed.
> - xfstests xfs/643, xfs/646, generic/765 and generic/773 passed.


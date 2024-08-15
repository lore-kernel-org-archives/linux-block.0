Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6D19DFA6
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728605; cv=fail; b=f0p7DBrfc63y4ENjZHoHkvuktVQjgOolXzUdsl3i3DHXUtf3pnbWKAT0UBWnSRczoEjGV795bvXh9Lh6ibGcwoDx2lwdX0/+RV2UDK9ASFcqhfM4Usl/N63HqPlNHIKV4Jp0MxMNaYiBAT8c//gfSa7/lbeJXULJDnLwGob6kNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728605; c=relaxed/simple;
	bh=pMJSdxN4iqL4dHtaIMZp3HDjgodzloUsxBiwvDzbiBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UjXsoPHUC/WEPWX6N9tb1T72Gw+BrKQutsKJCfUxhvIUHNw7i6kNkZy94XI5TI7EAwAG0NOlJT66rehaKQVesThcHvColq8YSGvq8tps51GKjaNMJX1ALpND6bJaXQzoPvU4VxsIDEk+crFym+wWYI3psgszX1Ji8SVT1RKRw+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WiDRjU5D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t6AnPCEK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WiDRjU5D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t6AnPCEK"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FCtnJ1027935;
	Thu, 15 Aug 2024 13:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=LgGfLjCb7Vg4D4ghG5RcxqsqJlkRtq3iqx55iV/Xrfw=; b=
	WiDRjU5D2wyHqxAhuo8VVWNvFHzGucHlM+luiho9wKb2YqijRRTSxS7AngOLit1t
	VoPnCMPVzwTq7JGrLMWA2j+niMPENv4Y5eFoDonsX6nFQXZU096dE+Ax4nlzaSsy
	zvDI7RJwRfkBqSfsalSS3otFmGj1h4UFM+C4L0hH5hb5wZBFTXroqfAZPIyAMa8T
	8ZvxXtZL8Uhp5MyWDwKe4Y2aIdwHusJbysXNZm2VPXrf/nkLR+LtkiGvGhYfpAqF
	L4/JX71+A4h2msBZobBF6sd6eCceXx22CNOg6AVfhw7Y7iM2TAU4erPyyiSHrMa7
	6Efek711l5QzJj3tO1RM2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttjgd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 13:29:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FC8BmP003652;
	Thu, 15 Aug 2024 13:29:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnc45x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 13:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYXRx0grxvH4kx61BJURhlLTbHfyV0twRkPj46zSHXY5zCcLvK8sWPpXt22WOSFP5hIDUMHF7OVQdLr5pyv/IrdIQfOWVjDYSw4Bna1AHTK47quA8pZFQXD3EeoNW4q+Uteb6sei9TrSgaKMxcS/QxZ1AtRhaGchMJwJveO8NK5LPcBuKZ2Bi+Adfd5MTVhCDvQfbtifnWMRKtKrEaed9PdUFXVAxgBhDBoUe0NZywza5c3ZyPVATAl/OONW7CZd2uevXffzrOvFm6Wm6GfLHuSZ15xvJFV4ACYcZ5OkwfZ9tRF5plDmBrZ9h/+L83AEZw63r3O7/vDUFXo2psmkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgGfLjCb7Vg4D4ghG5RcxqsqJlkRtq3iqx55iV/Xrfw=;
 b=BQOwiYBvklKaqXCcMFpxdX83VMU7TRsZMq10vzFBnU2Fsq2rtkv8MFWjwqbxKV4SMsKZhB2/83Q1a02XUoueOFjrV9U45FQycUJb77vmuUR6L4vkwhZc1AjazcMHnRs/gZIeqJfRfCoGbZ8ssaYPeIPtCw5s4xl5qU0I1JHjW5PkQYLHQAfjvHRnXr8xCOpBoqfya1mK6sYd8spXuRVxx2vLPnF+u8WA7E9V55PSXyjFabwvSS0Dx7eqd2AW0lNsa8DhXPZaphdtKLo4Sw7iX/fo98pAJg9WklXjTY5RGePrQ/qqqFjVwIB+ezNqXevh2/4jEj2F1LUOFOFJgkf1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgGfLjCb7Vg4D4ghG5RcxqsqJlkRtq3iqx55iV/Xrfw=;
 b=t6AnPCEKFSWNiDzB355EGZwoAkc9Ogsh5Z6pdl0MDK8mhxBRdopwJy5wjG/AE+vzl8oGKrn5xkcgL53Nd0NxcjuDE5AkvofQY2hzk/0SJGWTx1F47lNF3zBB4ZA4kbYGodI0vJ7jxoIS5A6nj6g+JBEa2dU+1qpQv330EDN9nHY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 13:29:51 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 13:29:50 +0000
Message-ID: <3275afad-cb94-4c8e-b70f-3a7e8bacd89b@oracle.com>
Date: Thu, 15 Aug 2024 14:29:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        kbusch@kernel.org
References: <20240815082755.105242-1-john.g.garry@oracle.com>
 <20240815082755.105242-2-john.g.garry@oracle.com>
 <20240815124047.GA7803@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240815124047.GA7803@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::12) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN2PR10MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 80037369-f079-40a3-d410-08dcbd2e56fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3gvUkRSQnhmQ0tpTXZxOXk0SHlvcFhFWVdXazM4dmtibEVNVXFYUzFINkNn?=
 =?utf-8?B?VnNCOWEwRTNwREZuaTdJV0k2V0hnMkNIUjVOeUlvc2M4ckxyZ3JtQndxUjFr?=
 =?utf-8?B?Q0prcnF6R2RCZE9yZEt0RTB6a2d5MG9Oa0xlZUFjaU4rY0htMC8vbWVlaDly?=
 =?utf-8?B?cEc1U0d5ZU1aRWM3ZFVYS1hodmIxTUprbHFDOW9SbUtCQ05aRVVhbFFUTmN4?=
 =?utf-8?B?ZG4yVFRxU05ld2UrVzZKZVQ1VzZXRTdnaXlpc3Z4QVhSQXhRQ3BLRDJlSW1z?=
 =?utf-8?B?WTY1S2FuTW9acFhiQTlFK3RVUjhjVkpWNTZKSkdBaVc4V0VobDNoRTJzUnov?=
 =?utf-8?B?MnBmZFpkVUpUVmFteFlwaTYrZFJwNk1OUlJ1anNzUDBGb3JhVHUyV296T081?=
 =?utf-8?B?TGZDeDZiNlZ4NnFFVVZEVEN2b2NtbytOa2dwc3E4VzVmUVdaMUdYQ0lNa1Qw?=
 =?utf-8?B?NmUrLzBCYWhOY0tUTktnSytvT3liQmlTVmdlSjhaZ3AwdlJKalJxU0JZTGo2?=
 =?utf-8?B?a2tkQ0trSytFcXVMWFNaQ0tkaGJ3OWxGVWV3QTRVLzdHR3ZlOEt4bklmVkJS?=
 =?utf-8?B?WlF4eGdRQnREcm4rL2E0MmhKSlh5REJSb2lwNGlJNWdqMmZhR2F5N0pPOUJN?=
 =?utf-8?B?QkxrZGUrYk5Ma2pDYXF0MFBwMTY5eFRPUHBrSTExaEJtSGdnNVJpdmVYdE9X?=
 =?utf-8?B?dTM1R1BYcUxBTlBkbEdINVpBcldTMjBJMEZBTzQzMjFPVlE2cUFiWmNvVkVM?=
 =?utf-8?B?WFEwOVhha0o0MkVQU1FSaGlGV3YrYW5ZWWdpY2kyWlNyMkZ6SmtxUkRHQXZ3?=
 =?utf-8?B?R0F5SE1wWWF1Z2xmckJmUE1OaVB0ZXgyaUJSaXIrM2RweEgwOWlkMHlCRVZJ?=
 =?utf-8?B?a2FSNXhNU3hONUNZRmgyd2l1cFJJamtiR3A4dVUzUzNGcm5MTXBzelR3U0xM?=
 =?utf-8?B?NkQ2anJ5b2dTYk9sN2ZJTVlqTmo1cGxPVk1SSXZiRmhLaGtQZVZvR0tXaEp1?=
 =?utf-8?B?RjBLaGVVNU1aMStwQnFsNG4vcTMySjB5NlBNSDV6NUN3aFdrVjcwdldBR1ZE?=
 =?utf-8?B?WFN0amE2emFucDl0dXp4RXRKNTNLNHdDSlo3VkprWWFhSldkR2lGcEJzSmhX?=
 =?utf-8?B?ejVMVHBjTUNpTGQ4dDNMRHlOdGlNZW40TmdGd3lLTUd2SHBnMlZHenJGUUM5?=
 =?utf-8?B?Q09WR2xXL1JKM0YyeVFXUUZUVVBnekJPQ3p3YXlLVWlnTVkwcE9BK0IwajF0?=
 =?utf-8?B?K2MzR1gyYnA2N2htS2RNRTZrK2FQY1YwaVBSS2hVY0pSY3ZwUmFPSjFMbWxZ?=
 =?utf-8?B?MWQ3TVg2MlU3MFNqR1g4QVEyRG45endNZUNtMXRKQXZPZStIWXVMb2NLMTZI?=
 =?utf-8?B?ZlVJaW1HTzFuQVltR2VNV0xNZ2RVQUJ5eTB1M3B1VWxYQ1o5UzIzQmUvOURO?=
 =?utf-8?B?VU1NZWtKeW1LSk5NTGIwcXhyQXFmSXpxNitXL05qWmxKdVd2MmJyYXVrUWxh?=
 =?utf-8?B?UFd4c3dKc1N0STdZM0tFb28vWVJJQVhTRG42NEtsTVN5L2lkQ09raFhvQU5X?=
 =?utf-8?B?enE4ZG02Mzg0aW5XT2Nkb2RQM3k2SnNOOXB3azBVekhrRVcxdXVKZnI0c0dq?=
 =?utf-8?B?YzNuR2lLMXlKbXRQLzE3TTlGdGdpK2R2UkFZY2hzcUIrMXpQcTRxcEx1UkVn?=
 =?utf-8?B?VEN4ZnpXbUhlbEJKMVg4eFlpdUlNTk94b3ZSSkNYeVN4TEdUaEk1d1ZnZ2pK?=
 =?utf-8?B?TGl2UDVVK3MzREFBWjZMdVFCZjBCUGlvSXE5YnZoMW5USlZzczcxeCtXdzNT?=
 =?utf-8?B?UGJrWExxS3poM0lZUGFudz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZYRGtHQUlEVzc0UmRlVTBRVVl0dC9XalZsTkd3NC9JZlhtcmxVZEt6TmhF?=
 =?utf-8?B?WlB6bEt4R0p3T3pKcnlWVlpKZXZQS0k4VTl6cEZNMWJaeVRjK3lVbHVZSVQ1?=
 =?utf-8?B?d3NtVk5QV2hrMlhYZExDZTUxb1ozamtzWVM2dnJJK3JVTEFuQ21xWlVMcUh4?=
 =?utf-8?B?N296YTF6WGFIN3dCRFk5S2x2aFA1NXFnSEVMRXJKNlJKS0Q1RHNxenNmSVJB?=
 =?utf-8?B?SG1xVmhyb0M4ckRqWHJ4c0kyQkp3WFNMNlJMKzJDelhwZCtxenVWdnYzam94?=
 =?utf-8?B?ZHFzcWZDR0F0ekltNG0rbU1yK2t1eUtJZzRVTUNRRnBwMlRRR3gwdmQ0Z2oz?=
 =?utf-8?B?MlE4clJ4Rm1kckJzaWRGdlRPczZKNHNyQnAvVlE2WkdKUXB5SjR4SHQ5bVBH?=
 =?utf-8?B?UGpZTmdDcG12OGFKYVU1VlN4M3dKSW9ib2Y3YTliUzFZaWdMbVFvVHdXNkZl?=
 =?utf-8?B?bTNWQytRYnc4VWZPQ0xQTFNjYUppZUtnTHl6eG1JV2Z1cnZYOVZDdzliby9u?=
 =?utf-8?B?djJLRnZEK0VVdFkyQm56SUFPaSsvc2J3YzZ3NWJHbmR1aEJKNEZDdUZXQmhN?=
 =?utf-8?B?NUtacE5aSUFSaWxTd3p5ekt4Nmp1aWE5eDNLRUJYWXhmL2h2WCtTb2NnL3R5?=
 =?utf-8?B?VERvT0Rpak56MVFXM2wrTWloZWh3WUtVemdZY0xMUXN5bURMdi8wQUw0MTc2?=
 =?utf-8?B?NzVGcUduOGc0a0FVWC9yRkU0M1RQQW5GS1RpQ1RHK0J4RlM1ZUN1NFBId29v?=
 =?utf-8?B?dnVpUVZJNkxNaXBoWDd0ZjJyTmEwc0gwekw4NklSeWY4dW56NzZPUm9YWDdP?=
 =?utf-8?B?VGJUN0l2NWlTM2VDYnZFaHZQSTF3cnNCNithRVNJRjM1LzkxYmoyb2R3UGg4?=
 =?utf-8?B?YXdOV0RFTXJqUzJLVllQK3J0dnV3aGZ1QTFtaHNGaUp6T0V3aEV0UlRiLzI4?=
 =?utf-8?B?TFc3WFZhQ0RhSnY4dHNZcHhKallROVc5WUt0QUo4TGtNWnYybHo5b0hmMHJD?=
 =?utf-8?B?c1ViVmZxVUZWLzlGNStZalFtYS9xUmFrd0ljOStHdXdMMlhTMXlnYWx6WllI?=
 =?utf-8?B?d2xZRjd4RXpyczYxZWs5YnhIUjlGTStaVWIzOUoyOUF5Y3R6bmh5WklrSUdy?=
 =?utf-8?B?MUJCSjVHWkJHVEo3VGRtcXVERGZmR1JiWVA0elE3c05ROGIrQnUzZG5ERjQ0?=
 =?utf-8?B?U0hGdG1pbXQvUUlJMU9qMFZXUEFKamtpQUt4b0hvUkJhd1lqRmNUbVVHb1lm?=
 =?utf-8?B?Q2ZOTk80NndhT01MM0ROT0lPYlViTklJMHExMFFHS0M1dlZEZkI4REgvV2xY?=
 =?utf-8?B?U3NXWHcwYm1LbUhwcW5HeTBXNGx0blZqUHBFRXkyL1lBQTV6N2ZnNjg4TURL?=
 =?utf-8?B?RlhCRnNrR0VDWEVOUURPZGNZcTdUa0lLNS9GbmxqcUdjOHdxZzQ1WnlkTFk0?=
 =?utf-8?B?bk4yY2UvWnVCSkxROEc1U3FLKzA4ZnZSdVhUNUcvMGE4WGk5Z0tqU2RlbDFz?=
 =?utf-8?B?ems2NVBDWkN4SHRtTXBMTnl2MjdIRVA5eS9xRDhpUTZrS2tBeVpwaHFRanJs?=
 =?utf-8?B?U2NET2pieFZ4dytTWmpiakFGR21SR09SZGZtVjhScWhEK0ZlZFVscXR3Lysr?=
 =?utf-8?B?YjJEVE5OMXU0UXdBZmNsR1pXb3d6WjB3VEJrM2FQRnRRcGJ5bUR6WUloSGIz?=
 =?utf-8?B?NURBZ3NEaTkzeUFJaG5HWmFtM3oxVGlGcnVXMk9EbHpiU3g3UFZaUEJ5STJ1?=
 =?utf-8?B?V3BHNU1FTTMvdlEzZ0NjOTVRcWZBOEdZSnJkUTI1NllYZ0xSMkRuSmExYUhG?=
 =?utf-8?B?SENMdndGb0tlcFI4cW9oK0lwMGQxMzMrWXRSZ0p3NGdQK2xQUklWODREaWtW?=
 =?utf-8?B?Z01SYXIwdTZzOGl4QUFPOXduK0ZOVXJqT1REeERObGtyYnZlQkp5TFlxVVdj?=
 =?utf-8?B?aTExbjljRkFHdk5OMkphb1BRUTR3S25zTW9xRWJwVjdYdlUyWFg0ckZ0cEJN?=
 =?utf-8?B?elJYR2x6aGxod2VkRmhnWWJIU1Y3UjdvZnFpdW1pUGlRWmZaREZNMjBmL1R5?=
 =?utf-8?B?bjdVU0JhekxUeEMwMXNHNWRGVFp4YnFEb0xrY2lXM29DV2xKQUJFaEt5ZUU5?=
 =?utf-8?B?aVR0bW96bDUxNURuekxMNlFYanFURGhWa0t5NzhOa3BlTEZGNHA3WlR0WlZ0?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s0AsesAFH74uFEiHIZ2+TNV/Ipr8vqYNtFMZmMcXg3GWBeJjU8vLEmEjClK1ymMMF7kkrvhaEXYitiAjQ+Lr2dqr8GL5Tq97A3/8i6K3w88F5VdmkI+w57dDwFeC/UPDEGR41uefm8bj4uxoHjQBFBDJWsO8hCF98Ncyc44/1c3P58F7E6H+oYU3AJ3+FT/wNl3XNkTOyMZwjLeB2cLqaumrM+bLSOvJ9SlK/x6dJ4WENq+OMtdkDABCKGvslldtVclgVNcNL783wWJ70KOd+ZUJYF4M8+uUHyE/h42pZiNqItf/hZ9W40vZqpvaoEi+OXyY2mcKEcOZEVlSQiLI9FWnidBQqFSZvKlF03UvTCuKinx4a3LWIa+kRtKTvENc9pqhTBZbq1ngSzhLUNK7w2lxhWroHI5z5nhUPQMYbzgeLFz99ND9eOZS2L2/dwrp/s5rAXcRd3tPznUyP+EEeYRbRlnDFU6vYOj0wJ3ejUlXP9BRN34PzfPFNmuq1fTj+UsIfMF2P8Hlu+7ydbJS26nCFg3AS98qE+tsg9DOxSmYfoC7lh54sXsa/t9lK+oN6KpGaHwiEAgCv97hbEel7bX8QCmmYJumpwFZ1aFX7aM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80037369-f079-40a3-d410-08dcbd2e56fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 13:29:50.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YTEqTlFesYUVq5PmR/bXeCAEvAiT+qj6gMsXSM/SrtdapTd8bivlbcXXWqN5dvuD+jlCIMa53zTW6H0E/SUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_06,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150098
X-Proofpoint-ORIG-GUID: xF6N2yc2BRUMmdimbrx5NAVTmJFRsp_f
X-Proofpoint-GUID: xF6N2yc2BRUMmdimbrx5NAVTmJFRsp_f

On 15/08/2024 13:40, Christoph Hellwig wrote:
> On Thu, Aug 15, 2024 at 08:27:54AM +0000, John Garry wrote:
>> +/*
>> + * Pass bio_write_zeroes_limit() return value in @limit, as the return
>> + * value may change after a REQ_OP_WRITE_ZEROES is issued.
>> + */
> I don't think that really helps all that much to explain the issue,
> which is about SCSI not having an ahead of time flag that reliably
> works for write same support, which makes it clear the limit to 0 on
> the first I/O completion.  Maybe you can actually spell this out?

Please just tell me what you would like to see, and I will copy verbatim.

cheers

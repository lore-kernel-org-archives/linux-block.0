Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9901C2337
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015446; cv=fail; b=Dy7IvgwzzvHsfwyZu3g8173qkGxNDRnlk+kuWcj0hgMBxz0Fx0eGXh2wmmjg1FpTQYiTthRgT561Fch0mzDKSKt9HP3tKIJIQo4EEJ550x+8g0PJrBgl3zgWUBRXTltGhAiiHjp5eB7nIBrm2KK0VvAYEBtD0dYwNsAZIhCM4Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015446; c=relaxed/simple;
	bh=SD9goYICVKsSNbnZwYvYAZNBtKz+uIHGtvJEUiv+bXE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=L+GOgBLbVmBBcyTyYWIzJJ3Nooua7wSJ+BLfZ7TP94jF/SnVjznqk78lZZXjYs6ruBgQgak4G0SHx3Z31Tb/8pEtGyFFNADUp0Ec8Tz/RRYUf2IkC6DkVojfhhI+Oxm4CLzxTOsdop7LqUKuxoSZYaWsrq73PBFGrNuE0C80DqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XiT+vWD4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cx7/yoE2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XiT+vWD4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cx7/yoE2"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7fgQY028524;
	Tue, 19 Nov 2024 11:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6UbQU6zt2CNEz8bWi1
	kxZXd01nSPCUhQvNtz02wDrQ0=; b=XiT+vWD4rD1XPNvpW9e/PzYYga4BSW8G3w
	2caRkX7Ch6Ms9v9s+bDmbiRg5Z0fE/XcMCWgN/Q7cfZON0pepaBkRwpAP/OAXY1H
	64Pc8xZurvzZw+6+gTXhuDFsb/tZybibindTNqfPHJQ4NM7wyiMWIZA9mFm9ZKWs
	lPiDLm2Yt9N9I6wsa7ufR9OKK8SOYZ4qhSbVP5epmHLtVYbTt6dnATQGMAn+iXuX
	yqWoj2mtQnQte9x3W/w7AAmwxYpf66GVlhxzoSavKm/0qTQHeddqNaPSIuc+TuCU
	e1YIp1WdpuMrycz4x+8eMsAy8VxUC3BpezSSG6sBguUE5uwSgRHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr363x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 11:24:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ9sGCb023380;
	Tue, 19 Nov 2024 11:23:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8ssse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 11:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB34Gqkfsv1Dn4ncytymwS9CslAaClAXbBdTTLxFeglM2e8Vi0aJS2//mddVqX/qqPNAEWVMi+LGg6mJjQFzluaO0DGJswlvvLLCK2OW34IC3nORlqOahdZbtHEf510H2faTqjuWRgokbNhOvtwgy+/tJm8qS/kibH/vzLFHg9r0gJPV74hHOGFbG5ki56oTAYLCV97q2JsnUz/mMPGBpKCjeoWNkjbYUyvowCGlZonfvNnRwURt7yYuRTVfmay5r46A9pcgGflQzGfofpkZPGDIZQ+5Kj0pf317joYzI4pvbjfvIgcoZlkYZDBZ38ee2naJyssfIa8/DC5I7XGNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UbQU6zt2CNEz8bWi1kxZXd01nSPCUhQvNtz02wDrQ0=;
 b=qoVxfHSu0ZdQ4DnqOuIiw4mF8VGdTqMVT/4H955sW3uns9mbuxerQg11iknu2kADLcZ+Gw/CZY5wflG5p9/agSO1KnB6WKDpsX8jxUat680jurT7s4bU5U7qfYgo0VJKsmwnOX1FD1pl+qFY9cKtAFrb50YTIClVoq7GILroRaqnTguu7ZeZ9s+cs26tfcL6TfDOsmvsLAAMfmxHs/xlgBB4zdllYfCN4NGGSpf1M8Vv5RbAfJkaksNiH97kII98nGrz/5BEnh0NWFu64I+bUTAlh/W6elllrr0i7cEESbw5p58ULpjZRBZ4Ga5JgDQU1KK0/dgVpzGRofE+6S+ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UbQU6zt2CNEz8bWi1kxZXd01nSPCUhQvNtz02wDrQ0=;
 b=Cx7/yoE2Yd2rURIbXI9YDH/2dOjpI9Acdruribtc8sy6LUQzwbsJRB0Uj1oM+bPih0iw7dtIebTERuzmc3y5wohfTXDp8V8LICdK7FqmP/qOowR9uqnE8C+Q5eypT7z5PtIVwda5I/KxaOJHFNWPHSbU2y4HQeojGGGogwgPZ1w=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by DS7PR10MB4879.namprd10.prod.outlook.com (2603:10b6:5:3b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 11:23:57 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 11:23:57 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: return unsigned int from bdev_io_min
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241119072602.1059488-1-hch@lst.de> (Christoph Hellwig's
	message of "Tue, 19 Nov 2024 08:26:02 +0100")
Organization: Oracle Corporation
Message-ID: <yq18qtfsc06.fsf@ca-mkp.ca.oracle.com>
References: <20241119072602.1059488-1-hch@lst.de>
Date: Tue, 19 Nov 2024 06:23:55 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:408:4c::45) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|DS7PR10MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff2919f-cf26-471d-e0b4-08dd088ca897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYIs4IyIqu2/g8jbvg2mQM+vnftjSTMPAAIegF7hlC5GJap5BidU4OCBwd0i?=
 =?us-ascii?Q?nXWOSBv9DCSAkAwURZ9n6dyG8rKgCNHlc0RfZmRd4MRiSzCwtr/NIKKx1nXT?=
 =?us-ascii?Q?j1NrKRy3OEJfkThtJ/Dov3lEnL4zFpAeI4iXEGPTXG/e9PPkkxoPPsn70Wb5?=
 =?us-ascii?Q?mvvftoit+ObW9C690i0BGfngq9nsEUV0S9NEwo5L2lRf4gmiD4/UWCSB99fM?=
 =?us-ascii?Q?JdZ/XJuqZCaDNhqhUJeqnvaNYZg93MF5rvPPiS9pxEMMtDX7pTfTZ0NJZVzn?=
 =?us-ascii?Q?GCzQ5gTA0+Z0+bJvpjPVX+BsZ/f9NUPPcHKgyZokAFA3fZC8pQ/bE5B5JA4m?=
 =?us-ascii?Q?374ryxZKeuCaeHP4PjfLhB7hQQ3vQnWt65lu6q6LEK3bAiiyMAajsBFam/Aq?=
 =?us-ascii?Q?8IYg4sMUlfOUmPiBVMN7h1U5PKJ9mFw2LLZdfwFvDrfK2teMuNyorwzq2AJx?=
 =?us-ascii?Q?E75qks0DmeojPlxeYQfLQAUcE72LeosIjlA/9egs6XP6AMwFg+hrPVd5v2WB?=
 =?us-ascii?Q?WGVh6zj27CFogkoR/bKxmM/6L4/jlbQkJS+J+7EZoDvmx1XF6f50e2bjw6tb?=
 =?us-ascii?Q?PVd5Be39KG1ZbUkQrlLi6MiqvvtxgA2B/ll4wZY+Y+or4hvSPgQ0fWioUgJ7?=
 =?us-ascii?Q?0gky/WIfjRai+Osmyswbzg2C4uLqQ5Qq22qS9/8IVLipweEKY9s/n5zPGKBj?=
 =?us-ascii?Q?pNJKxZ27b8CcFocUzUgAxbWPpSVVaHJVcNa6rA1Xw6pA+G8jYlZP6NwRFLRY?=
 =?us-ascii?Q?4nsQi+z2Y8lWL8n3s66Q/eWWDZPD9+lwKKlNFU2v0XSKDI/ABhcV56sp5TgK?=
 =?us-ascii?Q?xiEbPaAFujJ++QFLJkycAMM0RJ7nPh0toAbKg3TAO3bEzsG/7TBKVRffcxML?=
 =?us-ascii?Q?81+RQ6fXSfpvUgKknXHWBXZWcMscDGEMmtvu7UaTRHP+m5oxYIl+P95YPnQF?=
 =?us-ascii?Q?jgw9WO7JMcRpko3w9YMky1E/NN67UA1tcsWBrDWZWbJV88zaNUiu61npEpUJ?=
 =?us-ascii?Q?v8z9eGRiyTDvEf7mJ4TjirjzNNbWgnnKr2suA88K5518Tf+0jhDkWbj7qVDr?=
 =?us-ascii?Q?9SEpHh9gY0TBJmwOTgFzueAl3rSzIYW2lLEdFiTDhqfvr2DJxoBPRQqsEvY4?=
 =?us-ascii?Q?fPahdAfKtnD2/wTCdhp7OS+YlciV0vdN70JFAD1KI1woloihedEa0D/9iEQP?=
 =?us-ascii?Q?RHRndt0eT9W8sTp3mIuKkM2JkEuKMNApW7U0bx0zEWicwbj4yuwBvWvSz4+m?=
 =?us-ascii?Q?r04DiOniA0go4516ixh/bM37cx7WqjfIt8JEi5jLvG+ucKomS09mrqno0U5v?=
 =?us-ascii?Q?GHulWhmBnCKZmMNdHEZY8XsB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgWS+JWqdNfiWiwfiFAHdL72jHOYoMxLdeBHKPeSTXkQ0C/zhCLIfOxY3JhE?=
 =?us-ascii?Q?p12KmEJhgiRo1rxCE2IM/ZZcjgWi7YEB1wvQYJXDjDrtGxD5yhOE3/mf996S?=
 =?us-ascii?Q?K3TqjrqRy6sn2hDkawbvlM3ndZkk/XndgZz3f12QpHOqG8oB3xQMcZiR3XX9?=
 =?us-ascii?Q?U10B3ZglgXf644EQ0iP2nLehR/UTviovomBJin6Hq/IA+3eclZDNy7WINw1B?=
 =?us-ascii?Q?X5MTHAoW4XNNLACmDM3bGB8mjPd1Xi+8l9WtivFbjZqDWeZVRm3VfGRIeigb?=
 =?us-ascii?Q?be/P/ZzO2CY/9a3io5iZEbpKRUt8mvKbtd7RhvcpD6fEW3+pmN+a1CqbF5z4?=
 =?us-ascii?Q?Doq3kmXa5EL2ayXy7/oTcwYAWMsSmFIZ8koSho78Tjjiis81nOgUF+hy3d9x?=
 =?us-ascii?Q?5ce6NaNrWEOpAQPGGjWjzb4LjfY2fcqG0jAfyXz7bSVpJhXVwKBso138YZCp?=
 =?us-ascii?Q?oCgra8iEOLO7II3/VxpPx19NEucs+soj1aPDQmwmoV/pacYmBI3yBZ/L5EZ9?=
 =?us-ascii?Q?r6SqxZq0tg8Lqrq0B7Er46XP9In6epfl6H37350nUM85wLJYTU8LGONpuU04?=
 =?us-ascii?Q?sKpndOooCpj1v8hLInQiPfE6HMAz7AHqvnf9O6Bdloh+lAS8kPVKeC/H/+jg?=
 =?us-ascii?Q?J5YefI217W9eUZTJfHhCW79h7p5zFsT+3Q5wvNojxNtR1NMJkiwwiDybbn+1?=
 =?us-ascii?Q?LDSaw/BM2FaqsAOscLnd49dx7GzEbROse1+Hm/cgkzhB/FWCVeHu2qScGXWT?=
 =?us-ascii?Q?yaQ90DVI7pPkfDdpQFUeUjc2Fy/b8fJtOOm6oK98SbnXMEvcLA/Hq0L1R3hq?=
 =?us-ascii?Q?WR3iZC4CvMPE5isufCPkggb+AEW/6wBf04sUZwJj9SrypsCgnMke3Y6uvbNv?=
 =?us-ascii?Q?aTfax8W3iIXL6/kr+1DEBwrGfSe42ljk8KlOeAgkBHIFAJVjTmaMC9TdDbiY?=
 =?us-ascii?Q?uOHNMKJ6IkceG7SP/2CahrPqmRbwooF/mADpUnOKc9awpDCrKbgy5lSCJQnh?=
 =?us-ascii?Q?rKHPQkIvb1ZTCIY77fFE1/jaIKlWf0SvEcF6mMtBsVEjSLKWxRqnDF/68tRN?=
 =?us-ascii?Q?pHYIVWY3Bp03CmG1I1FDqOqBPpMF2jRTmorz/rijp77feMovA3LzoyMPRzg7?=
 =?us-ascii?Q?POpkp+cEmo0AiSLFJZ92fMOzIt8Xu85+i4dZtUmWcSP7T6IGMas5qP7x/vaP?=
 =?us-ascii?Q?eG7m9QduKOn2EEMi8E4K7o7jWUmY5XJA1IdyoP2UQxWy6d9ZxWdKdcamx+2S?=
 =?us-ascii?Q?zdxmK3+12avfayOQs+rLKyU6ooIWB3eJyf+pXyaJiGFj+37h1d9FsYrb0ae2?=
 =?us-ascii?Q?AAcfGjLO4nPJdr8Se2LsNx+7urQYDbMwZxTgtVaFb4asG98zV3PWKo+KKvuG?=
 =?us-ascii?Q?Of0vLEU3m3HqAereUrzgDbXqoAo6pIN2uzLSkCStUvRNcq+Ng/upDmc1ifzS?=
 =?us-ascii?Q?ktp4hW+MtZQ2RbSYV1xGo7M4fYYiILRoHYwUuYFauvf8iXioAgWKb5Uo7a9C?=
 =?us-ascii?Q?CAwnHHboeweX3gJ77RagfPoO4knowjufJE/Rhl6RGtjFJNrp1FD4sVZGcFOE?=
 =?us-ascii?Q?tbuBM4TYWChrqrzCiy/8ZQycJZTsmpG+2H9gn0QlOISmu3yRW373u2EYKcfp?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X1nTxH3GcPsqCcRZ8tr1IVGYhb5VifFHx06b8GE0msI8LckHzWsjzVpGQUjOoUdPZV2O4rYcDF93AufWR/Y2ft6YpKFYGFudv36FlQ1+Ib6uOlPnC9S+/jZJcbuP+ybJ1ZBUs8FeeXOhBCmzHnQZzaEMolnylE+DKB/gp1oy6cBytr/FVG4WOM3G52SNo0r9La50twIQ2lU8pjOn/zEH69gDcJRhRvAW/rwuVEgcDTJaEmgi0BnRhwGdGLAk+5eDWwCB/dfmBIL4XWy2NWingsLeeYmcGng5dpMNv3EypVErVKrghtoeFMHFBUHmNG+baDf+cKvH7jCDGVLaEt+pboSqyiVG3r6w2p1hg1nlgDcVMrQaXJcFb626Hs4hW2XioJRURTDqiKEsviXXS1WkLGceRqGmedkPTdnUN+IUy46j4t3yuLFNAnSsxB/otjPtn2bpwk1CiYNUjI1tE/7RtyqAKqT+K3wNKcWtKOXO1SGK34GXgwdrOfZ22kniKmJhpqTA0xPyHL3Mv/gTC21j3hREp1ZHQxmSdNJkEePChhLfNV0dp4JIGG46BBLnHmDh1hBpUlElfQmdSxfZLODpRZ0mCioq5BomIXQaIORKzrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff2919f-cf26-471d-e0b4-08dd088ca897
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:23:57.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMzlxck9rrBz+DTQeE9PaMIlHEb+ELmHX0Pu8dnqWkD5FtkV1xvBEmpH8ytxtn3fasU4/8+EnDh/mecd8OOFyE857h4zEJRWu2veuIlxBhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_03,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190082
X-Proofpoint-ORIG-GUID: w6lg316loe3OrDDH6OKyA9RWygfJAe3B
X-Proofpoint-GUID: w6lg316loe3OrDDH6OKyA9RWygfJAe3B


Christoph,

> The underlying limit is defined as an unsigned int, so return that
> from bdev_io_min as well.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

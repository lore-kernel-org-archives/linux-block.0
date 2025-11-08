Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A371A9F97
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573951; cv=fail; b=c28KfUJMWTlbSDmAxoOqHQPfomAKRQz7c1a55dyhu2OQnnZPpTmCPV5PlYvIfHUGlQYn1gPlUy8CMLGlWmo+0mp+0hxjBG0fWX5XPCkRKXUX8g8V2wuHBMnvqnh8p2nHXj0DF42bln4hM8RXmejHUW1M1OHbyo2mKFMS7zA/uK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573951; c=relaxed/simple;
	bh=KIRCHjSE4+3/vrFmkmG/2FEvASiMdt1PmstKf3AuOTE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=aGqgAchTdcCWPlsxYWPQ3kbQy8F2zZCRlcisxW7H7MA5OUGn4ueIRvM5DfzFE89n3r+OX4kqyuYxLBLdFGj31AVSwowU3gMJt0NrzpxzcTJPauOspSQ0JlX2e8ctqy2PcODHpXOSVHxYQPdhSJ0fvlSmGJ9swfW0dRcXkxDdNno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXmZmyGv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sztx+8op; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXmZmyGv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sztx+8op"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A83XxVL032322;
	Sat, 8 Nov 2025 03:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bIjj4J/uKY3K7h5RaY
	6jt8zYpCEEplUoaGNpypThXuM=; b=IXmZmyGvlb3lvHstQywqg/tpVhb2yAODex
	jdOBu6/xeg8Ke0r/xgY62gfQ/nqVQbJiaxFa4eZZ8YHqMIX8Z+OpY2XHkOpPKwhC
	oajE4pnoK5quG+6C8UDtYshc/aLVnp9Xa3Sygnyl0ntnRSIXNYVkfH5EobLE+wJT
	UBNY2eyww0zTRoK7YHTR29HS8cfNfPwTv1gqfrZQr4o4APb8Ky8Z3XTZLO9L0EB0
	4Q2wo1VV70XrStQTQY3CkBquHm9ZLjs8wnqCjClkUz29wp1wmhfDhosKzRmCdpxS
	om666///7QmehB0ztZTfliq+ntW4DaZfJUvZuQRWulQ+Xzyxaepw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9sah89md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 03:52:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A81XOJ6007466;
	Sat, 8 Nov 2025 03:52:20 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va6tk7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 03:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlM2TsWwieTScsL+yAN8sHESLVLdZHzKxGF/v8PuC6CJhmlPnD5e7Y3KRzWzm3c1neEXc0rhwx4H6bvuZKAY+Z77jOMrROnY3OXki816MCyNsKD4YoPGDpz3mNiY0MswmkmBnNS3brRkZG75HSM7fHX9iDnbiW8mSjeaJSpaYz6oDDcI36D9luia5Dp1+8uTv9L4AxdBUlzb7MHJLdbUxRkuFYpa/sjsmyhAspEHqolBwUvGmsWSSdlhYO2l04u5qqVxP/j34YzkoOJJNDy3UUYapZSVrAetVUDPy3MRXATsQ0lnDbwEvWnlnFIL7N0PGCvinicmkcTD7hM/aQUlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIjj4J/uKY3K7h5RaY6jt8zYpCEEplUoaGNpypThXuM=;
 b=DpwmyJoNEsxu4IHx6Ang+h1PDDbrwE0tCkblaubv9rfZXmx5uhGiVeHkjpuu6s+5tlE9LmpFlfIGu1b1rBQFVSdGE6pJhnbGjNAXwB+bGDbhBB1CJPjj9KNI0ggpFKnJAzYqTaBAhHIrisbHTdm1/WZS+dTsCkvSngO/TYPXCrffaJoT6UYtoj3dqx+6Hk+Lk5sHzn8U40IylTpx5QNXRykItBx6b6dzTWPfe7tb6YL6+dIHvNWN70XLGfsDc2rpNIKoctQdYfmOUgI2S1atIYE6rTuA877nMsyUodln5Of6ek0UFn3NaEIP3tgGC3VUETNUFLKLNZNwqivr5P8nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIjj4J/uKY3K7h5RaY6jt8zYpCEEplUoaGNpypThXuM=;
 b=Sztx+8ophD3P/xspguB1pAtiW59CCJTRAQ+nuQW143EJsq7YopteKZuAvfaePDIY2uRYBUVcswbwq2neAkGKBRKXGPjGN87wUvJ7aQvPbCD1riMUwTsKHabubJBhEeuhw5Cr6HRiskwaA4Uboh+7FZwGE0rZuunkTS5qJGcNqzQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 03:52:16 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 03:52:16 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] blk-integrity: support arbitrary buffer alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251107232358.1324461-1-kbusch@meta.com> (Keith Busch's message
	of "Fri, 7 Nov 2025 15:23:58 -0800")
Organization: Oracle Corporation
Message-ID: <yq1y0ohjk5a.fsf@ca-mkp.ca.oracle.com>
References: <20251107232358.1324461-1-kbusch@meta.com>
Date: Fri, 07 Nov 2025 22:52:14 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::6) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 17158d3f-2cf6-4895-2d6a-08de1e7a3518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sV6VERh2WyRz4bJs1/f5ZaNO1zOTdGkpW6v8FCb3lsrCIZypcXhGLTav1IYW?=
 =?us-ascii?Q?C8neDzLSEWxbR4vQBQ2tDjQ4sAsnXt0CypLRy6UoQYpqmChKjZMbVidt6Okb?=
 =?us-ascii?Q?BX1qTdUAMfnI7LnMe+ZGWFIc2gu+wqA8vYnKjZ1xp8OyqsGO61Gjil2CDC2C?=
 =?us-ascii?Q?XxpqL7tk1x15hmoCQrMxqR6oEkamacv3odPj4qkIXMsb/2wFiYiTLQOt39Mm?=
 =?us-ascii?Q?P6t1crrAMKMqZUMvLB+EcMzN5ULpkfEfILLCLqqjC7VG5j9szJc2dRSiPQ4O?=
 =?us-ascii?Q?74HzUOovAIH/NE6UnzNbFAGXs/BW5P+E3xky7RUmznYs28r+M/KiQ6snRQCp?=
 =?us-ascii?Q?gnJpVSjXooGR5ts/hsim4fhlDW+fKA1UvGDfQzW02w3t1OSsCPXBPnxkcEaI?=
 =?us-ascii?Q?IeehFCCqLiVzyCLgeT1hRYEuPITw/g5MNJFwoXSPOoNaQlxbCcfcAdtFE/x/?=
 =?us-ascii?Q?EqWRxxmwf+9MLuZxZRuKhgKQJjVj8vbT65CdazUFMJFMtQLivACVROEV2Q4D?=
 =?us-ascii?Q?LA6jLuyiKCJvXKnQPExxW09YtMxXOD4o38sBg1c9VF3czav/iAlIr7w3c9ts?=
 =?us-ascii?Q?wIcjXUOCRCb2Kg1MgDIJ7MCW48idw9e/kwpFHs8pIaJOxxs2EtGZ7x5oWLXB?=
 =?us-ascii?Q?mpefnCkqtr2VhzVDJ8OZqQSuOKBMe2T5msGo9CCQ8fWdnWPrUxx9ItS1iTQh?=
 =?us-ascii?Q?Go6xjbYk6o3fpBSmPO/cs7gNSkbAsMga9S2H7WFTrID1njijiGKynlfyhPyn?=
 =?us-ascii?Q?JeuUo3nuB7WAbgAyr1354RTnx73xEUpL7DaMKXsJqUxYKrPPPlZ3+NgqnVJX?=
 =?us-ascii?Q?XmZO8Wv/ofyVf+RbDFycsR1dS5/Ia/GhseKjMyZ7aHkMBXCIaRqJfoEBVU7v?=
 =?us-ascii?Q?cWdYb9iDzx7IV6YWgkWEEmGT76qBnAIHWqn8u+sUwqcAUmcNSwzkRGxfBQ9n?=
 =?us-ascii?Q?2sbJZrOic47JGcbbKn5KjWaxfrwiDE7U1UGdyXR273i/Dvm34yYs0x+v6wQ+?=
 =?us-ascii?Q?CfuOCFlyqC9G3CZ8GQdCbZiaL1TAXcBWKLUUkQmN6P03b1DAUsV6MR7Ndrj/?=
 =?us-ascii?Q?NLBGlVhhFc9/Kmvk0bePu7h21rSbwqbHk1UDUzRq1Uja49gs7yTw1xBo5NRn?=
 =?us-ascii?Q?uM6hUXu3HhnVEzozvB5eMTskQDClXyGLJVf0KxFiMRI52k0o6qzbF3BsNGKl?=
 =?us-ascii?Q?Xkz/hYC/q54EYTxiCTqDlZr2eavSYMr75sBWxw9X9O9JRVOD0o1vyLyDTRju?=
 =?us-ascii?Q?tg+fOt8+D7ENvTubJ3zRgyFpxnvZZqtbQurDmLTImGbz2Ws1yxohu5QZSuUA?=
 =?us-ascii?Q?rEOIUJaGKfims+VHWGmKRMq+kUXb6KlGvRnXV0EyNi/WeAWteW9KaMrPQXsm?=
 =?us-ascii?Q?nDUpxDrrDDnsD7imumasAW5+zoSFzdaxCu1yLrZ6OQHQazVMftIjrGnnGkyE?=
 =?us-ascii?Q?BLZ3Perq9Hqpin6Hc3yivAM4TMPvbNX7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quMQ+3tBcdzd25VueWEb/KwYetW1+urc5Ivtc3jtj8IPmPN1w1cEv16GcHBo?=
 =?us-ascii?Q?/ZWfnK8cnJ06TZV3LQghp7U9yIahRLEsMHe5vMdmAm3EkWeILettSCaIIzia?=
 =?us-ascii?Q?KY17OKiA6Q+x6Esj5CGvqmCwG4aYmjqsAS07IMDaiE7mQsMtgt09tG1aEuPD?=
 =?us-ascii?Q?IQ+GVWLpC329F/FVVXoNd9ZQcVs8tyUY0PUcFs83IQ1KxScgCDJP0A/BQSoj?=
 =?us-ascii?Q?t4lYS0K/piLvcZkgpvrfPeUNl7hyOOM9ZVRpPpAeHlL/tjpY39bQKr3er8x/?=
 =?us-ascii?Q?oKoL95Tu7RgXzotdNbt5vyVUKaXbjBmbmdAExrNLkC8+OkZZXb4mrwF+vfuF?=
 =?us-ascii?Q?C9XhHOPS97ybPWhzLw5c38B6t8ND450HcuR7SWcGe+/fb170PmoF/OvvVaQX?=
 =?us-ascii?Q?9vy7oHr8z5U2bZ79NC3/m5ZJbHx/QHPphfTYo3b26IhXweRTDUlBUneFw+Mi?=
 =?us-ascii?Q?ZnJfTau9HCkd6Ksg8MOdW0J+ssLHNx+exZRUpdpZuR86BqlmG73jQhJHRhvY?=
 =?us-ascii?Q?EgPoxrstDqbJZwUUWRlkHrXsEnmVYV1ECVflItmZFQWbSxO/YfbIHv/NBCEr?=
 =?us-ascii?Q?6Kdh31+Hyd8RPGlluCGvSZ0gnXMAgaS2sMAm2M7Z3mTsRcLtftnMXV+Qhd+p?=
 =?us-ascii?Q?bEqs7V6vH0S6Yrgu3xlZgcUH3vdliRmoccZmm7678hToOOvXljiKSGFcFlq9?=
 =?us-ascii?Q?aatNH+7Oolopi18nWqd+SWHsuZ0nSsOa8jxoXKdEVWLmbFgPkzHq7/TlkIvE?=
 =?us-ascii?Q?Lwc9qYKKvfXfheq24rhXeP5FV9mQhHiWR2BoqvEdpr3f+OOFANHdxcDMyD2N?=
 =?us-ascii?Q?nPYfCoJz8JHlFiWWZMZ6YAgYYPtBCoAZP8EPLo4QoLSHIEaEyctjLvT997p+?=
 =?us-ascii?Q?SIV1zZjsBvmzpWTyjdJjepAlKy148+xJxq7EaRwxzXOTKYQHIfiqPEi92o6V?=
 =?us-ascii?Q?TH/oxjzCWuGK/2EX+wXWtEsvxukHVms6Mz3+p+MYSzTJ0POQQrwybv+KkjAw?=
 =?us-ascii?Q?deA334luTTY4dvM1f+UTubbEnkgasqqj6F/iVXrAw4L0wftzO38Jvbv6FSWa?=
 =?us-ascii?Q?HwMcn6jnw9HKiF3ZYgzZcZgi1G7ezF+FT+OkWFEMrx9lS1GYOvv5MAClKODp?=
 =?us-ascii?Q?PXHFsLfT8XeStO3Z6fPDCQrXZz43zbaqCOFZEfj7CQv55sDuRpDMSOX6dVms?=
 =?us-ascii?Q?wsQZwPZiBbPk3/XeYUCIdAGfOnBQncYrSiAUTzpJ6ZGUJcR38AKdxE+jMf/o?=
 =?us-ascii?Q?MidlzM98Lr1OgD7IwiDo5FYF1M79Ew308liLlvI6p7J6iVpqBsDTwpkG+TKq?=
 =?us-ascii?Q?oCAk0834t5dX3NefET4clCGPYXIQ1MlGUXsIEuG4pu6a2TjlTC34NyjUOMCL?=
 =?us-ascii?Q?jmrsumcZlm1/AQP71wSjGgK4ayAxICn0xyuqVhs+y+gRhIKLSL0181EkHYQj?=
 =?us-ascii?Q?9obe3VisLcrS4SCBPOu9zUUGsd8tS1L1ZB27FQdD5mgObuwM5OxP0qyLWczc?=
 =?us-ascii?Q?4izQ66tzgNxiI04ZjxF+6p39xpuvYRngpDplgl84RnWKhION9S6Anv/Ij7fH?=
 =?us-ascii?Q?MLNRWHw6bcnFwzh9D/XIO4sVQQnKFyPbJzhu/JTuT8Qi5rJ8X7EDSJ5iW4y0?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BPA/cw+bjx7HNFS84O3tSORbgCfCQvWbb/FO0Uc9gy1YoffIoNvMzUxSndjASRtjc618JHuip6KHPD6YcqZ5hRyidCCXeOezvamXuZFZWnZkXTw7OOzVx6MN2pmVGKXmvY1FwoORaDjemsXcS8Iw9UwAvfUcplalquoEinZ8SROJBaiG1MnjTnu6bD3hHkjZEKxq8UZ1h5WHcoSa35xmHEd7gZQF7L2PQ8P4SATh2iBcGEoWYS5NfNSbrM2A9whmdBbyDFkI4vtGOEVs3wGXjEMQvlBvYBQqiUD9SZzZi+h+IkGo0ClohN+LUbCsg0XR63EnJod2CHUzkpDwGyGZ4iOW/vkcyJN3ytVPpVytp5k8LiuB12sLXu6o/jMOdYimjt6qHFFtcbUgMrE3gSjxzk4MIjCpbQb54qGgNsQNi3sB8c9BplWJjjf+h07ZgYAaq00AduGcCkoB1Ehr/z3INWzff3ztLOs7x3bNDoc/Y7V4C3MGxzCaA+pdH4M2odbPkfjS1fOQIYAQ6p7yoUQtpp+nHK4ekArYf7bE5vxrgaHvDRu2dFNw0BI1KSMMED5HYtWr2cMMAxGm4DQaMiwywvI7wwIoL67TNp59yK52rvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17158d3f-2cf6-4895-2d6a-08de1e7a3518
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 03:52:16.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o2Gs4w6VVCvmvyrEGV+HDz/U7CDoLznmmZEQGH/dcWzBlFyaQCzvR9yd3IiDiybtYAQjNa7Wm91pxbMJ7gk9bpd0ts3pCZVt63M8JmgZpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080029
X-Proofpoint-GUID: Cv0ywq0u3Pas3VbyTajqvIaaYgeOd9sF
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=690ebe75 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8OUypy0B3JaldwkWoCwA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDE4MyBTYWx0ZWRfX1x6xBQbra+xS
 KyUOq/KLihQL4dRFSLlUBC8YwZ2VedxPVW7CL0r6BEhQh6Fz0OluzFKwHNIWL0w4HovyV1bCzVt
 QZa4I7AW+KyaRzzpHJlxMQGbpeiJtPvd1nQWPvOmtHLaKTJVcJJCnMSLD1Q/jbwf+QhIHMuXOY7
 Q1JfJNRy46+AgKnL7wV0MhezAF07h5U0T4TLmwY8nlvHdKIZi1IJT2afXnMuoh/V2ubwJ+AEQOA
 TNu3x+I9Rs4wok1Gx9q/BQIqcduy5IK/VBe2ShJvOjCBcPZHopsnIuAS3mBgp/yLcyx5OxauqKz
 AdZRP6C8zP6V+A8M8XmDpQepzsDaXJ6oOMAaZMzHNTtKikAa/Kvt6uR5+1JXCsYz/zF/MTuEmVK
 TntGnTzyYzE00ADfWB4Md2UuDy50IA==
X-Proofpoint-ORIG-GUID: Cv0ywq0u3Pas3VbyTajqvIaaYgeOd9sF


Hi Keith!

> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c4ed97021460..6266ce0043280 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -12,231 +12,136 @@
>  #include <linux/unaligned.h>
>  #include "blk.h"
>  
> +#define APP_TAG_ESCAPE 0xffff
> +#define REF_TAG_ESCAPTE 0xffffffff

ESCAPE

> +static void blk_crc(struct blk_integrity_iter *iter, void *data,
> +		    unsigned int len)

Maybe blk_calculate_checksum() or blk_calculate_guard()? It's a bit
weird to refer to the IP checksum as a CRC.

To my knowledge, no SCSI controller can handle PI split across segments
and the PI tuples are required to be naturally aligned in memory. SCSI
controllers probably can't handle split data segments either since the
design constraint is one PI segment per protection interval sized data
segment.

-- 
Martin K. Petersen

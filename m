Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B17155303
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523231; cv=fail; b=ZG7zr8eU99cLuRIClLuLUWh9vhZPi8KJg6ueBW/kx/QFXOig/PUz5v+0Cxnwpmb+8SUn/9xYK1XwIrfhiuyC+nvzFGWlqVK9p6LReZ5J9ek5Q7PLIS3rLyJVg0V2BnNg00yBsQM08cFDsDP0ck4mOBETy/vEZlK7+EGrS9jjEls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523231; c=relaxed/simple;
	bh=PHFtsaADugRFpMcEFoaQOVX4nK7PHTWYgY9vj2chtRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVP3XZmW+22ZiC/czMWZXxK595P51cz0AzpdENFg5SrXzH7xg/35wTGMAJK2n3oyMf3LX+D6BSJ+KTPxWGao4L2pil99D55ViIs2W1PxIInrZ4oIbuwi7nZ99gCg1CCTeFlsKNVxx0WVB3KBerXVGqsfnRZo+JLXiGNdlFs23Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mAh0IAcd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSLIhG2g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAh0IAcd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSLIhG2g"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYc8024846;
	Tue, 9 Jul 2024 11:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=hANCuG6R/n2ecFhxuXkUPe+YMAkNKvqBvgxZKQySCPA=; b=
	mAh0IAcdlaVhn3DfNCen+Axip8lXLf/8dX+K/eqsQXSCxVRccPYVi2QBgYTp9lDl
	mi12811+iby1ouo6KrZ9uFX0YSJEF8TXnX2Sj4uOsIvZ9/jC3Ug3tbh19dAMrVB7
	IUP72yTQEALIfCyF8QhsuKeD4tHWC5vNPH2lafPtJ52ZPf+I5mt+bIrIslAMPBBY
	+3AbMcvLRQsWCF/6upPT2vM7ZCBik7uTMY2TxJSJZr5jeR9v74m21Iar+WsMJ0+n
	gr6DN/hPr2Z1CRQXcqcTfwRCdb6bVMXB2sJ7fXK4E/JUOctHfRxoAxeBBb5fdiwC
	MmASEQVDukU5KVBNb3jzxw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4ps0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4699mwL5007191;
	Tue, 9 Jul 2024 11:06:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu31m8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRAsmdBYOBeZNr91XAt3vP6Yzr8kQ3FZ7UyoV+BE7fTShH0g8BsHCLqQq74j7fHw7ZaGihzffzrpOvYVrZfASrI7iqR+9rWVg0ac8E/PPn23C+3RVFoxh7R/LBW1vlLxX3usep7TqjR2lGIHcMKmdIA4o2q7xOOduBdrpoMC4IwKlEQcAQaTHL9EIT5glfyIjv2EEuE/FZnQQoOPSRA7AZYclmdxvBnEK+tgB2ph9ZvsiQ6LL64QdZCbDZoMuGfDmi+KEew24clQTW5UNFuZ3m+1t06eDA71/IzPoFvceGq2drUAHTAiOr5LfYm1jH+2sWmofbSQUySZvBojcy7/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hANCuG6R/n2ecFhxuXkUPe+YMAkNKvqBvgxZKQySCPA=;
 b=QUbvF5yDq73P1r5DbsXm4s+WWPW1F25PTx6rnPtB3WAvZHdcne+6wuOzwVCO03FgEyEk+SQ4d1BRfbff1a9DWYHymmyQBUoCfWD92JwnVPjFup1LebYuuEyb3bWPAqzp0Wt0mKbTZ56G0QCGiLSFPI1t7hPIy6V81yN8fNZ7Uc8ccQKIgvV8WM8IirM8npjplSjK5EWQHiIMXHnBqb4wOyIvYqF83+Pe1rBLKJq14y1noEIwzgYOaUabYm1W2FWIcTHDR1WJzgBRO4oNKv4PdIYnbi+hsqG7RDzMKw65HgO0c40fCuJF7IdSAJZDdDERGReQzXgIbCNHsmxuydlhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hANCuG6R/n2ecFhxuXkUPe+YMAkNKvqBvgxZKQySCPA=;
 b=HSLIhG2gmWDRNcBSGErswlTFYnfdiOdKKAx0flxa12+c6sjkZ5KeNGcorNATH0B5wu91/nx0ncrS6hfDXGuFjxC8GiEFp2z7D9KpCIV8P0vujJH+YuVtQjdbtU39UwDXK6RUnfqX1ir+bYweqEbAuyBmXvyn2Ron4fn2JRVzdk0=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:06:03 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:06:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 09/11] block: Make RQF_x as an enum
Date: Tue,  9 Jul 2024 11:05:36 +0000
Message-Id: <20240709110538.532896-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 6533db19-96e8-4ce4-b9fe-08dca0071f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CJLVqqZIa+xRItQnKEfwlgYW+cO5neLWAr3HdSrb9fMC+PdZ2fXcVtAs0wo3?=
 =?us-ascii?Q?4MSvtxy5GD/HXsPYIvv21qOEclETUtg9QTbPgPhjisQQ6vhSS71B5ee++zHp?=
 =?us-ascii?Q?kc9fip/DX+G3BGJAdy3aIJdykeAdkTfCF0xDIk+d6Iu4OFqAf7b7jniUap94?=
 =?us-ascii?Q?KF3DIRwNO8EBteFohxSCY7XEQjWMkwm67H5PilJv48a7HZtSD4TTLsMpoq9Q?=
 =?us-ascii?Q?NNUyse1l7bwDNlsO99vojiWoIL215kNKXNRluPqB4sUVO2MhD37x1ffJ+87O?=
 =?us-ascii?Q?AtQzbTBeUO0Z61M9gtMerKy57qB1ifjKxaFul46IY5mthh+xMQPcDqZ1Ekjp?=
 =?us-ascii?Q?0P3McNp5ZkwEZ2c97yhb2pgoAROkXpZqqjrw70gBn3+GSD/j4wO5qgGJWwgk?=
 =?us-ascii?Q?ApDjwEl27H7dwbwOCEIiJun45ZzdWkkU8M9iF3HDC4jp3U9bm32uRplyu8FE?=
 =?us-ascii?Q?P93bvcc/4uSy0Ifu2Esr1qcJy2rDAJuUKJsqbowlXOFKIEij2u7VBhErYMt9?=
 =?us-ascii?Q?VNr07NJiwBrq10bMbUBzyGM5tZ4EkYdB1LwTVmpi169GettTE+YinjckdQgM?=
 =?us-ascii?Q?cVKqGxEBLSgpvBhSEXtXtBsefxhxPubRcx/euDVLqgN4B5Kaagasqy1rXi8x?=
 =?us-ascii?Q?vriH+1vvdSxXy/BaPhSfSld6kWq6Y+rLnXdlOF6YiaP6bYNZGtSE+w7U2fYK?=
 =?us-ascii?Q?m3vAwDaeN/XTNJqdy4GcZ2OxhY4X0xeLLT6sOafLVmO2GthjQNoGt6CoVYw9?=
 =?us-ascii?Q?HVQkSobWuetVAYtjv3DSzyHEyGqUF3iorhAdXLudIPF7SQSEAt++t2ZIfuzZ?=
 =?us-ascii?Q?sRgCrcSQJGmfXRNHj9+O4WCO3rLhhARbW+TnrSzJn/sCmijMKlhFTUTPd3H2?=
 =?us-ascii?Q?/sEG59ekv5n7owBH/xsCEOJJW+ttT8gF3KygD2jTN864stegvA6zqYFMBvAr?=
 =?us-ascii?Q?ieOtMPA7Jv/agCG47ecP1xsxkbpX92BgNh2XNeT8PrJebBmyvWrNU7ssE/Jm?=
 =?us-ascii?Q?zz9YUFyJ62FCqvMvtRlc2+0qKQPxyG79wEvV89sFdLSe3qxBEf3OM+1B4Yoa?=
 =?us-ascii?Q?BTw19Zk1V1N2UFnzCNJLKny7IFXpaofgtKO+Gn+qfGqu0//YZXjmqG+GM+b4?=
 =?us-ascii?Q?EcqEOZzKOEe6h6zMF0EaNhzw5LIunSIuIEGOBrMyQRJJTgQYu8d9sFOfYyj+?=
 =?us-ascii?Q?nyLM7gJl30cV5UEziC4c3joP6Jy5SQ1uVsrpMB5cC8QDAE/hyhOkI+51Xnmu?=
 =?us-ascii?Q?39lZMY9KtobE9WNX7knQ75O/Sc0G7O6tvMXT/632FPn96oOJkhnX1ek86z0a?=
 =?us-ascii?Q?i7O0c+rKdyEzMJUDjhCKQAgkoLE7h3jLFRpXUZrL8d46iQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?slPA4zYTjG8zm+6wZlQ28U1PSklK5IRc7NKvv/PNTZ1WxAL5CSRDXQbgrjga?=
 =?us-ascii?Q?udFybBGoBwrtPHMidnrzJjkIiTMIaKKM3H/kYGrypVeWHGaVDMSVO5/Wq2Nc?=
 =?us-ascii?Q?wbFJ1z8GmcmER3djWqHv6PdEkV4swGFdeD10BXuZl5yRvLpbdEOr4SgooHXh?=
 =?us-ascii?Q?jEfTw64K9HuB3iNaRl2oBJFjVmzKI2xUL4aXKMyIO+ug/5Iz7Rz8wXd2b5HB?=
 =?us-ascii?Q?VTBvwj62GxZIDUv8rd/VD8/D4viXbYr0SrWbIkY9gg8my2tA/K8hk0+Y9sAK?=
 =?us-ascii?Q?opxmYQnrrTr0g1nppUMkl1g30vNROsF5JEAmJYmvxfSp5mQm0Sq1LV2A6xC6?=
 =?us-ascii?Q?qfn2qB4MvZpp1/d906Aog0lzIM0x0q6msvC/xRW3OSETWe0mNRn4CjozO9f7?=
 =?us-ascii?Q?V1q6mhpESsAbnKZSaJaJjwLhhKfh2LjTwdVQ/b6YEyaj5l5x65WYn5f+6wXP?=
 =?us-ascii?Q?f3Ax0KzMgNa7xF/SigYUyJ7C/TVZYIykSmO97XtGzPWGW0ZBItjg+b4x9jAG?=
 =?us-ascii?Q?kkB66tB2MGWEOJ4U7CzhpC0ahMZti9R6qKOTv/LwQ/dRA3ysxHEkjzwrhTsa?=
 =?us-ascii?Q?xixrlvhMV1eyUrVCHNooh9tCHVFjxZrEI/1m/9mfVLo/N4WtGOBYd/CvS48U?=
 =?us-ascii?Q?a+cfrVuJ7fNCo96P1KHbP2Pw9MIsosJB0r0WfpD3SutF34mr5BFcDmhI3m4x?=
 =?us-ascii?Q?5eE6dhcKNChdRBQAbL5BqaKDj79uRR67tFCqNF0F6bH/FY3WWtYVscxqrLDR?=
 =?us-ascii?Q?5n3YQUUfd5AAbFeZx7F6lN5XsUCyIHQ90EdU+MwyqlMpOEip49P4jT8elW9t?=
 =?us-ascii?Q?d0rD/DGHkXvahp5AL34SQ/006ea4XlyPSZq6pcb29gNZS3/iDy0HkzgC9AUn?=
 =?us-ascii?Q?G55v0tmhDI2Z45GIpcM9rBRSNJKZj/uokEtsQNRbRVFl1UVKjzTznoNJthML?=
 =?us-ascii?Q?LLxMrQQQhfkk1CdXpATpbeNbY+FGYR7P5qMHZhsYEtBgW6v9ZcpExRZDwcYV?=
 =?us-ascii?Q?xEP47mSBD4CA/K91/zXmNrjBuOna6ENkmlC10X7DtS4UH7rqIe+q40GkNh4R?=
 =?us-ascii?Q?kClLFTmQWrAWpTnk3NyC1oymukQUUJ5G1KpvWU3PMbXF9t8ov1L98J4TkNjS?=
 =?us-ascii?Q?TrqdvN3KR2l4jGFHntRfWKI9SzVYjyNob6d7b15eyYaLGMQ6S+DMYdrMMYwk?=
 =?us-ascii?Q?jVe8bLc0MdODi9lJH5hGqU5II+YAlN0Oyg8aXN4mjtgEW+evHoPNe5fsX3IJ?=
 =?us-ascii?Q?KaKcthoBideuDkMEQahvZG3G1eczVJp5AtjbeReqhlDMQWfa8hMcsiT0OW7f?=
 =?us-ascii?Q?hRROh/NPVpsL+rvcrKQBiIK9ksux0E9/k7VgGIwAPpZuI5ydIsycTvlTuIae?=
 =?us-ascii?Q?VUxROOljTT6DEGMlhjWbEcm9txzkJAsqQpVTMd0FTkHOZmozAu4SXIsFdk/Z?=
 =?us-ascii?Q?8GbVzKIME4P2ZOFzyvMOIvJcSXKwrFn/+zgcljJkGiHv6cBkvQ056tLgBk8f?=
 =?us-ascii?Q?3UFWBANaC4jJlKGmV2jNIL3zsSzF4EBYE6Q+f641cTA1zHeUmzovQL2l5kDh?=
 =?us-ascii?Q?8vPJyLde6BQEwGDJl0tgC4H/0GDBpQyjQhnVck6hQcTomIJkJHhDgjThGm3+?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mjW9BOoXEW8Ua6s3TCn1Vw2hKw8JEfgR4ciFCvTF41iGmSEe2q1w4lJfX8IciqoqWZC3VjYkQYITZX504iy1lLPVOLmwvbR4JTeoOgk+3fPWv9VGjz3hffg2ECYXwpVX0vShqECb47PeNmkIrFQqD3PqssZ22GOfCvd3Hzb3v1jSx/XGuIANz5UTWVI8ZFLGhiyqZx+USBzcjaNDpy+9d3JoSIhEPfG0rm12CfFl3WXzeKbwWPN8lzcm6Ct/rgxfLCAKYXg4l4ivUGxIk6vbTCjtTz0QjNJOrucOFNZQ9Sigw/Rppxd/fLcTsGqjcmDpYR0enE/J/HzB/nDuMffoKrd61ySdEmBT8caQWhbzUu3Mc5N/8MgIUmWE7JqfC80RiPvb+kpcdkwBbWsXUcwYjrRWehjlzkr9anpokBjVHHt5WeoywrRXOt8Pch3Pgc4FxBKzQVeMcLyDDJ0xSmWZKam4PtBsZN5kJ4ClHR0nJeQFyaTYr75xyBQvzYBD5b0gewP1Q/KMHhXrcG1fCfwwO/xYGQw7kBLQ4xtZR7/2QH+q9IAE1v3eNyoRlzqzqYF/89MH20XunQJTBYNl+TOLUUx9/J2hu1mGywA/V5U8x9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6533db19-96e8-4ce4-b9fe-08dca0071f3d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:06:03.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mNOq07j3d8B4quuvNiELTrQjXh8qnfMulPcP2unhncnthoQ29wUxwm8Kkl91KCf2OcF6JWALCXDCXnZxA/ziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: sU98eem7p5LgLxZhX00URI9T5Sr9TU3j
X-Proofpoint-GUID: sU98eem7p5LgLxZhX00URI9T5Sr9TU3j

Make RQF_x as an enum to better order and number members.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Maybe we should also have an enum for bits, like:

RQF_STARTED_BIT = 0
...
RQF_STARTED = (1 << RQF_STARTED_BIT)

as RQF_MAX looks out of place in later patch
 include/linux/blk-mq.h | 66 ++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index aefbf93d431a..f3de4a0b5293 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,38 +27,40 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
-/* drive already may have started this one */
-#define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* request for flush sequence */
-#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
-/* merge of different types, fail separately */
-#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
-/* don't call prep for this one */
-#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* use hctx->sched_tags */
-#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 8))
-/* use an I/O scheduler for this request */
-#define RQF_USE_SCHED		((__force req_flags_t)(1 << 9))
-/* vaguely specified driver internal error.  Ignored by the block layer */
-#define RQF_FAILED		((__force req_flags_t)(1 << 10))
-/* don't warn about errors */
-#define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* account into disk and partition IO statistics */
-#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
-/* on IO scheduler merge hash */
-#define RQF_HASHED		((__force req_flags_t)(1 << 16))
-/* track IO completion time */
-#define RQF_STATS		((__force req_flags_t)(1 << 17))
-/* Look at ->special_vec for the actual data payload instead of the
-   bio chain. */
-#define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The request completion needs to be signaled to zone write pluging. */
-#define RQF_ZONE_WRITE_PLUGGING	((__force req_flags_t)(1 << 20))
-/* ->timeout has been called, don't expire again */
-#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
-#define RQF_RESV		((__force req_flags_t)(1 << 23))
+enum {
+	/* drive already may have started this one */
+	RQF_STARTED		=	((__force req_flags_t)(1 << 0)),
+	/* request for flush sequence */
+	RQF_FLUSH_SEQ		=	((__force req_flags_t)(1 << 1)),
+	/* merge of different types, fail separately */
+	RQF_MIXED_MERGE		=	((__force req_flags_t)(1 << 2)),
+	/* don't call prep for this one */
+	RQF_DONTPREP		=	((__force req_flags_t)(1 << 3)),
+	/* use hctx->sched_tags */
+	RQF_SCHED_TAGS		=	((__force req_flags_t)(1 << 4)),
+	/* use an I/O scheduler for this request */
+	RQF_USE_SCHED		=	((__force req_flags_t)(1 << 5)),
+	/* vaguely specified driver internal error.  Ignored by the block layer */
+	RQF_FAILED		=	((__force req_flags_t)(1 << 6)),
+	/* don't warn about errors */
+	RQF_QUIET		=	((__force req_flags_t)(1 << 7)),
+	/* account into disk and partition IO statistics */
+	RQF_IO_STAT		=	((__force req_flags_t)(1 << 8)),
+	/* runtime pm request */
+	RQF_PM			=	((__force req_flags_t)(1 << 9)),
+	/* on IO scheduler merge hash */
+	RQF_HASHED		=	((__force req_flags_t)(1 << 10)),
+	/* track IO completion time */
+	RQF_STATS		=	((__force req_flags_t)(1 << 11)),
+	/* Look at ->special_vec for the actual data payload instead of the
+	   bio chain. */
+	RQF_SPECIAL_PAYLOAD	=	((__force req_flags_t)(1 << 12)),
+	/* The request completion needs to be signaled to zone write pluging. */
+	RQF_ZONE_WRITE_PLUGGING	=	((__force req_flags_t)(1 << 13)),
+	/* ->timeout has been called, don't expire again */
+	RQF_TIMED_OUT		=	((__force req_flags_t)(1 << 14)),
+	RQF_RESV		=	((__force req_flags_t)(1 << 15)),
+};
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.31.1


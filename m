Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501B361DD1
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189095; cv=fail; b=B3j0m0MOWoYJrom0IL9+dNYatSuf0zv7DxYUxPJVAKGvZDj+hGV0Om2HBBYHsB48PZGWkMmytYc1/6aKY5JtvEirRCa3N5gB5O1BuYc1VPl1+zsGpNpmbt4hhDCS4vnnodILrhhu38JdVKqvctHPOSxUw9I2zCLCqCwAtE4FwyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189095; c=relaxed/simple;
	bh=wJXeA2/ecn4ZdU0J+VgaTH+XZcshj2h/EWt07eF1wIE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S9NB0C6ZLJcqy9RvokLnZ04muIQP6boN0n2x10irpG9QeXXgHM1+P+yi7Mr5a0gB4pkc+QzkjGZJwNKS/5ZjzZbRdSi+kftrr/sd5/93fEhLuy1L/By9nipx8mf00wLlEn+cW7rYcQ7fwJLl5GPnxR9iMfGc5/ZEvlC8l4B/w3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dDOAO5MN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDwwM0eP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dDOAO5MN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDwwM0eP"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9utOi2720373;
	Fri, 27 Feb 2026 10:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=pIY6eqc0E77XDDhC
	fC657YKwRZot2CDcmBDRL8Sazi4=; b=dDOAO5MNOQ9IuZ6fb5EyBGsFOIeq/YW0
	lL8haExEbXxB855J6Wfi9snAan2K+gI96QajbZlS5pZzxWzC0FOeTypfzSsqc/Iu
	zSxkcJbpW6Hb1ntZvW2zsOZ4pgCwKWE8SiBZR0BHc+0X3gFyxU2v8Kgkqj8gu0Be
	FDslg8eTZ+p9rM+kDxoPF9WFevwCOBHUTtq1KJE0zevGaPrhstOKqxiRbmNtVx3y
	fOXM7cdqfcTKRcrgfnl853xevaz5yyWriRkhHDeDcyAYeCVLy9meNcSPBb9YptKF
	jAfdZn9GO1Vl81Gu7HFmJSL3n3sUi9JDwa42pnCQK+6uZXMS4/2TPA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m820h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:44:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RAdZjg038512;
	Fri, 27 Feb 2026 10:44:48 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35qxffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW0yF0TXNXkNg42hXuaI/NOIBdF5dWGvzUyd27Ip98t2Wd3sDSWC/bL0I5JMhfzfxGfGhYDwMWDlj1YTRnAOu17MTClcTIySJuyceDoh5zTVfIw5NS5mdhb1LJ0XfBn97HXJTZRB0AJj1ZDEFvis7V+Mh0dry593i639vnwC2ZBZk0YWqNFN/hkoF9HcUE2sUSWO/w3aNC5aGyoYFj7KPL4nFMPPW0oJ18DTvE8ZAJm1zMuPlkFHbp5TkqdQl/UmPaQAM0qrX3d7VMJr1LKJiUFlBP1NTTSqxE/NZVC8Z8huHxAzw9Wi/Tzqdcq+SgqmbajUI8rwrkC/J06cdzlXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIY6eqc0E77XDDhCfC657YKwRZot2CDcmBDRL8Sazi4=;
 b=TG6NIGz+K1aCdUdYK3smvQTUndBQrKADhHrAjaVEgkFRUycpofEGCc2j0J8G7Saf5avdz4QMKnv53/jZB6VtioCRRf1o2zbPZMKv5CMaaWmZ3flf0mnsVy3GXHnt1Hd9wOtR5F/taau7G3yy/0QvMqTHxDbQJ/basCo/CcK2/qv7g78+yDTLIMsjAjavqLEIO2ZKYdAZgCOkjt18tAh2iVgTVdCtYN9ZZihuCIh01TDhWO2cslBPPepmBZ9zL30Av6doadJo+NixGI9sKDj7H3Cdi8it0SqurQdTJhdc3O1AO1+RMBJmzx31UqcRHHJFJ0wjZzgz2yTfGgdTWBgLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIY6eqc0E77XDDhCfC657YKwRZot2CDcmBDRL8Sazi4=;
 b=SDwwM0ePRTJpiDe4K3SmRIx6F+KNxb32M0E+nba0wdbil+vZEv+c76LnFD8X6VDNhZ3a1lFLE3KI/DGbay+Hc99/+n53W418K0jmMJg3Zq7oIkyflzmO52dvB8R5VfrLmnw1Z1c+6WVIfnGIfxkI4AT3cYgfU50kTDA5Q5gsN7g=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM4PR10MB5917.namprd10.prod.outlook.com
 (2603:10b6:8:b1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 10:44:43 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 10:44:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] block: Correct comments on bio_alloc_clone() and bio_init_clone()
Date: Fri, 27 Feb 2026 10:44:38 +0000
Message-ID: <20260227104438.1646405-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:510:e::25) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: b2919c36-c2d3-4522-ce33-08de75ed37c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	zBC37cy8pbvDaoIxaJJcXMSsJ2sy59mK8LM1apsvVsH773eZLrfwaHrH1Zwk7lfyQAPX4YO2u0qHmUlRC6GkU3oeZWzlHkyyPURhx8VSCeQbzCNp1LoSCuNJUr7LzEnqZ6xrPARR5FFFynd9iuJlT3IxVZSYhD51gBLIVTF5pGlQk6gki+WgNe4OA8u0PtZEowyCJ/Lt/3LtGEONqMEbdlGjxtFOmUYX0RMMHk6OEGbjhApwYpz+6wKxNq3Gto3rhPuD/1A3IWuaF40aUxn/9/xg9WBsQhMzEZQW9gm/9j5YlJIbCtwNx1ace1Z9L/PFNNSS8azBNk7cimOX14jdCseYP+JZ+kry93QLJ15oSWpLozpF7p1ReZnZm/NmZD1ByRragavvoP5i9W/p+DrmMtZzCpIpf/tFn8nvXJzv4ClULbtxmNRRrIoazpYOr+Xo7FNcYi/PBPVQBsatbJgDvZgUgDKYss2r6dLTBwBmnfZz3iv3Pint1PGB4+NQRP+su/34RAmRC22YWgov4+NDLPTjsit8aIZRopqN5Gt/2BjKdaahbvMF5HcqgXX6RP8v45Vy+emlySlAZb9BE9eNU6uD+4Xmx45SrBItntZoYw/QLTkVxcF+cecJ8mSajRQOUyVbSfS0lKkj0+Sqmwoy2ERvvmY0diemG+cuZJ2ugtKDc8rfyLzo+vM5Enzp0jHcRE0fn8aBjVE4GxbgRHktzj6QI5yMXeMG8C+iNlX4jQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+B1cg9nIacrLUYC5Ebv492r9W1waEjbpq6Xja4Ov8Utpr01pQvxniR/lzNGt?=
 =?us-ascii?Q?oW0Nr1ZlX5pp4MuC5Bw0bkBQXA/O7HNEKPfn0/uGzP1VFLzR/aol12beGmOV?=
 =?us-ascii?Q?8lBKlLW2kpad3rGBSPyc0SJub2SymTi6b1oVu22cSxprzH6GhJa8lumURtff?=
 =?us-ascii?Q?3grnDkRpWY95VPCPnOJhdmSRGwFeGQhPaXDDbhBpSKLftegtuGnsPeiTFTwP?=
 =?us-ascii?Q?g4PdbEDRuxod2pLMQAjJt0bLE5E23w1xliz9npmALY/pZs4NAib7JE7aQ4Fq?=
 =?us-ascii?Q?WMSJxcD/sArbgynZvY2FZrEA4S224SAppBAaB3iW5ul2lv0iQHqOUjy5yM3i?=
 =?us-ascii?Q?psEnX3RsHG65DUIYxxnpARKJmYu48/Vra8bHBK/KRl20Nh5fUEtc4eqcSbmq?=
 =?us-ascii?Q?VbGWGbo2xFov2cbF1SCNo+BMa/2GR40KfUn0s2jn/m05JcrrMbyRuZA3nyrr?=
 =?us-ascii?Q?jtgYbH38y82H74ZUtpbi+l9HofNkUdNz89qpa+mbXI6YhYi/kelEVCE1CehB?=
 =?us-ascii?Q?OThzmSuJhzhB8X+vDS7K6sj7CPUe6t1oicEeIj5E6wCWW1MYirW5WbEW4ySA?=
 =?us-ascii?Q?njCyS7DS9V+mpELLKefLEqfBydkL3tf9HxNF29SOr6ARAsGjOBmTODcAz1qV?=
 =?us-ascii?Q?QHBP7dIr5XfhV9YYqgI9gx6HNhAwWBWktynkwwDhMozO7BhHyiBux8RZMqHn?=
 =?us-ascii?Q?Za+KOeTYpCDiqyasJ6baHzXq3cMFomoA/kyRiqnofqVY6yJDvmw00kBQbriL?=
 =?us-ascii?Q?ij1IcRrrbvSQS3Y3pCV6sKP0w7uDYnWDgMsZHiLUM1Efp4r5Tn/jOrw3QPxX?=
 =?us-ascii?Q?XtmYIDHUi8HFwPPIwHAZZEzYV76LainxlyR35ovvdJ8xyTWRYTOJLMHPPB0L?=
 =?us-ascii?Q?46r0b+SHKtCRqomw+jPsCN6zniHXmZlkf3gjkA2F56nhWTNUGbfvdbPg6Yk6?=
 =?us-ascii?Q?dTbiUmvXmSY50EuhbbVTWwub4Er8y1zlE3/j9RrUoR3auWfrTFTEqu2+ldgi?=
 =?us-ascii?Q?Rxy2Lo1lIY20kT5eIp9gA7xxGK8Ps0PvvMc/L5LZU0/u/pU+faC0cEJeCyVS?=
 =?us-ascii?Q?zs6nsnjnnHnyXUlLN2kptsIcwkXUgUmibdxfjCM+wCN8d6fwNAMMeuipnmsm?=
 =?us-ascii?Q?nZ2DLuowtJjz38psDETk9mMla74g+0DGDz9Sv43jJzbxy7l8lUngXZVjjelt?=
 =?us-ascii?Q?ixnWGwqYxDPp147Nn25XHR+MpLkKv6vpHUC5bFxP9RRGGDveVHXUr5h4n21n?=
 =?us-ascii?Q?o2Y+2tx/a3gQnpU2NKbm0iiH75FraUB17IIao4ReXFx9FcujIaAxI5nkivrR?=
 =?us-ascii?Q?jrFQKsJGbEQLeEaS+H5NNfjkfGQoNELzAljOQBth6rNdw9rECUkgCBgxgAA2?=
 =?us-ascii?Q?1eXbiGJxlbfpxahDSlM64UFhi0GsIP9fj5zOYrf65cf8SICAwAxPHpQa4G19?=
 =?us-ascii?Q?fYufXKD3KJEQ+3Ld8oe0m7qtkAHpH3bPUF1owvxnMWa0hBLGlhzHAJ/enJQx?=
 =?us-ascii?Q?TzkrMGrQT9WDi0ikOukMrZGDUjTjECuWjtTBUfktyxfnnXtN3+xbtPbWPe+M?=
 =?us-ascii?Q?I2JCn5WfxqQsWkTV70bOisEtRt0BWSis3Ubr05V7UagN0x637eX9J117aq5P?=
 =?us-ascii?Q?SbLCoW1uzL06rlSIbcEgfiYzX5kp0jDuLdUAiRz9NKybuERnkmUTWY2fuZsK?=
 =?us-ascii?Q?UWQ2nOXjgRs8t1ATb98Pp/CBQU90yy/75ELZY016TR/tgCH+Np2sWzPg9M1Y?=
 =?us-ascii?Q?/kffx5S4fw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	BtRKB24/JiE/LKHrxHHdTOOtPfjKySclgvABmgMRSda4A4QDgcHDnLRlgBR9Cq5+grh7v/kD4tYfa6KSXxphV1UDinOG3+kvS/cokUZBGP//GkCGa/vFyoeGiWBtT52V6bP2LC7yrEJJlsEHHql/K16N2y3X5bGsdp6wS21yIK2f5EuGB/B1L3bi39cw8Yh/YNpbQ5PkPq+cdzEJV/LdK5/ECYmELSgWbjdkr6oru5tkKFRGpveA5/92Js9GkxA56SXK7JKcCkUf3omNGxlObL1OAWl9XsxED3mLeaq+C8o/kligzCwuenHE5yqyM97VkokrJI+0OecFYDSiHTtbUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vOPhQkCyPhkbRtAr5ZQG0EW+LfxbJ6ARnNbudDbbn5+CMA3vQNFu4U3KG4ZR37IiRUIr5k/zO30eamHkM1JYq3ygZeAAqtQoF6WH/b5DplOL4d8lKoQlNZ1sgIAFg49K+CeL2bxctwRR0mvp3KKfRoVVhlPP9K+CVzfQoUjvdLQrmF+x0Q9ZEC90gSwysNWZnmRVLp6hvaIEQR3zmGK2mPGXyyNKu1554mi6xsFZco5WoSyOsoqIgLJG10qiu8c97L23Zc97fULDYbArJ7WSyxZ2mH/eQyvlZp16r0R/ly7yFQ1OuU7p1E8PV7LaqGuK9mfNCvik14/tA0BphAsNIxTEjiMJe74+j/LcSr9YMdiEIisVtWZ6sU7QhNrPYEwvffEBPbpBD6vtmYImvkHUp3cmf7zlL9eQTros2OIIcfqB68M2P8rGe+LimVbp7+XlkRBmeY+Wl7xenvA/CiiGlKSWwfjCUbOJOH4e4vBcd8rKmyFQOoi8OX/dedWYjGDOymadgJO3xvPF9Fg/T+H5N9uKVBXP4y27w0dI5N4Ta65m/ygYGRnOAEMdZEJy7zJZUp5zr5geHa3OqUq3dna+3oZ0Ehy3ZGBW3As5QS7DM/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2919c36-c2d3-4522-ce33-08de75ed37c4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:44:43.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bNHCv/eOY3TdBHAw832JAQuJ9Bt2B8JU55265uMdz8I7tZ/wthtztD4FUErg0c397XTdvm0G3b4yKYteoUzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270093
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a175a1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=5k8_V9iPJfQI8mVfKRsA:9 cc=ntf
 awl=host:12261
X-Proofpoint-GUID: ACxJdBvZNjKHIdlaLFyofeJ0U8ZnIw50
X-Proofpoint-ORIG-GUID: ACxJdBvZNjKHIdlaLFyofeJ0U8ZnIw50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MyBTYWx0ZWRfX5T6QGVWcRpEC
 jFg8zejzUWLLRwhlJ1fD0L8DAgzG72ukHN3x3n5knCFWpLZYvfX2p59QzimAqVQ1lEtJSIaMJGv
 yBnbmO2lDz8Ck7O5QJwTNuPALMnEVAjR8RMJSkMnqcU3qfOB/YFeFeKVMcqCH4yXLG+tSm1/ab3
 2woa7zXjhdYDB6XS7bXW/C1+ZoHiXsxGas3yrGWICkg4pIdqTZbHQ7L/xflMEHOk8ET0qKlj7pj
 He2EZ385smKh45Bn392XXrtth8TRd3U9LqIom4AXtrl09GtKgHYQiCrJ+Agv+inTTur6bclZaCX
 sZnlg/rKy4uy3SJeEl3u+wVOT7GBIoyQSc6Ef2LWmzl0zWTFQR/REQWiOzWFAAWZPy00o6NBEYD
 k4WsQQZ0rqQQL84M3YvqBEKmPIjH+yUz3ACeG8VZ1O1UCZediUT3Z8HzBNhEmzmaPWwvDg5Zv6Z
 QYT7i0EquxOLIeGctvHbOQo9vwbASVe+KayQzH0I=

Correct the comments that the cloned bio must be freed before the memory
pointed to by @bio_Src->bi_io_vecs (is freed).

Christoph Hellwig contributed most the of the update wording.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/bio.c b/block/bio.c
index 8203bb7455a9f..156bb75f55298 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -897,10 +897,11 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
  * @gfp: allocation priority
  * @bs: bio_set to allocate from
  *
- * Allocate a new bio that is a clone of @bio_src. The caller owns the returned
- * bio, but not the actual data it points to.
- *
- * The caller must ensure that the return bio is not freed before @bio_src.
+ * Allocate a new bio that is a clone of @bio_src. This reuses the bio_vecs
+ * pointed to by @bio_src->bi_io_vec, and clones the iterator pointing to
+ * the current position in it.  The caller owns the returned bio, but not
+ * the bio_vecs, and must ensure the bio is freed before the memory
+ * pointed to by @bio_Src->bi_io_vecs.
  */
 struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		gfp_t gfp, struct bio_set *bs)
@@ -929,9 +930,7 @@ EXPORT_SYMBOL(bio_alloc_clone);
  * @gfp: allocation priority
  *
  * Initialize a new bio in caller provided memory that is a clone of @bio_src.
- * The caller owns the returned bio, but not the actual data it points to.
- *
- * The caller must ensure that @bio_src is not freed before @bio.
+ * The same bio_vecs reuse and bio lifetime rules as bio_alloc_clone() apply.
  */
 int bio_init_clone(struct block_device *bdev, struct bio *bio,
 		struct bio *bio_src, gfp_t gfp)
-- 
2.43.5


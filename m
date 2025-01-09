Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B322216E0C
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422822; cv=fail; b=bgqTVJo2SsJo9IDNVO4/9Qb0Eb/eebariS8DnEkH9mSPw9dsYNaQh1mGWBW6AyYCEYsQCkYDzoAAS/rYSrxFSiFgnB5/aDUZ2V/kEvsPbKFAfBX0r73Kt0RAaPKwA8oRToyEE8auVAMDlX0HafjjyFzTVHxqCk31HzYe6qRxUUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422822; c=relaxed/simple;
	bh=0wNE1W5GQxEn3xCeHI0SnZtL/g7R6v/xOiOmoIdLv2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hk6dwjAWmhHywVPJZ5F3Oy/oRYQasU9DteEmqDmRlRDqn/dK8YrKJHz6Kp8pHBpJTBKcV/9+LJUHzH7idEoDw74QipIti0hMlvAnttSRLmdPn7S8FIaMpPnsrNDCzyYZ3/cjCBH9eg2gL2eRE8E0KE2OwXmLl63l4AT6Whmy8p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uhcv/vT5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qSaUdJdG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uhcv/vT5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSaUdJdG"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094hLxM017640;
	Thu, 9 Jan 2025 11:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O8bMRd4GppXiq8/Ecn8Uvh4Gt1ZwKrPqe+M4ELvWo9o=; b=
	Uhcv/vT5OSw2z8BhlvFazC/l1aDBIi+bQgM6ZWj3y+VLly54r5IiABFSMCp4MASR
	AZ0dAPI+XKWuKYLVETKTcaOSsabgfKa+Rv86b52mFuoQzWObWQS5uA+W7bqbmg63
	HS02hYUQL+4yWv7Crx+BW8YtyO5xqwHZ56KkEtd4vQ2IV/5QmgnI46xqMYGUnfRM
	GHklbbSBEteRMvzgLT/ZaVG+7sTpCFMVAQFUy1Xp8O4qm5FuDauh7ATPXZAIFY18
	rxgJAuBMEe/yCFOCBppUNmPjtbSttBkfzlyep2Y599JiokDEAR5zOjx/+EsMhZ2I
	8LUPzW5WLTRAFX9KxERL+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4427jpghb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509AA135004767;
	Thu, 9 Jan 2025 11:40:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb00f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9Vi8E/k243Kcf/OUoXVr7zSdM+/AS6H9NN/sB50ninwrRrC2TL/ASFtNB40qiBRSf9BYtjTS85Oz3bdZVGUvWtUs99R/HMFYHlQFNW2uj2PG3VE5+pg8pwwTf+HlDl4JhU6bDeRCZPkLYH6WLHB1TQf4mPQtcW7ejqIzWweZrFoaVpD3nGIjofPV7LKfhYB4A8vUZirXNCYLbu4TDMiPKdxcuUyHPr2cW7dhUb0vLe+xej/mbTGvXy3dse3Qy0JTAGMldP02IE8/bVDu268FigRASYsr80e8HT7NO9dhuVCdx9dcIN2sfmmgwpnc6C1F4EGbkityleGS5JE4wKZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8bMRd4GppXiq8/Ecn8Uvh4Gt1ZwKrPqe+M4ELvWo9o=;
 b=aR6F5ODFFfBMzF3ePC75/14VEVkcN4EzYsbrTZc5IjuwhU/apJAuxi6vKsD0bcw7Q/AywnrkNRQmqt7yZ19xypdu19Vp62OJENI3XpZmZi2+cUPfIhkAvGVNCf+4bNcx5A5+bR8UjHF1qAJ4gOAso9rxJb+EXbEaBlkiScGGn25g+9Cgor6vhtp9SQMYKlQH5Pcv/zPchEBqKybaqjmWIa64YRXEgOCBXQfN37cUdoVjKoM3Wua8vHTM6OTy7a/3+nQl01CQYO2uCyaluAbmt7Bz3fVI2dGoDnVWaED7VIaMHhrmkiPyEyKaOK+x8qqw8YfJErG1smOADlsgBvQIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8bMRd4GppXiq8/Ecn8Uvh4Gt1ZwKrPqe+M4ELvWo9o=;
 b=qSaUdJdGITZ2dKg2ZSQagD2ZmzfbCAZpHsYbJpU8SzNHyZmZQ77T5zglrCNLBm7205ne/D7veHNXjwaL0VO7+Sx/Ku0eU7iysKWjpgTyX799fKTLxypmhICD4kJqe6mw0i2G0R/nMtta/OmIKjEztiofQJU6G2ZQCT/RlSS/Q1o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6067.namprd10.prod.outlook.com (2603:10b6:208:3b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:40:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:40:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/2] block: Change blk_stack_atomic_writes_limits() unit_min check
Date: Thu,  9 Jan 2025 11:40:00 +0000
Message-Id: <20250109114000.2299896-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250109114000.2299896-1-john.g.garry@oracle.com>
References: <20250109114000.2299896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:408:f6::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db10fe5-453a-4284-4e45-08dd30a2603d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Qegl7LCDWnsD0Hs2pVmfxZT2dDenoRPKS6E5g2vrgdQtRdlXvz+sgQgidYY?=
 =?us-ascii?Q?Q1b06U+fDPjnH6iS8abzhtE0jBTNeVtNmTtedui+HWIWgikfvpLp+i1uXlZ3?=
 =?us-ascii?Q?qFsfB1cT+yAdnHAHSNSK1YqY3itBbAVCJrL38iOF9eQBcK/eN9XqDRqJZMIl?=
 =?us-ascii?Q?/nIcuF9A/RS2epouZoT+INeo1F1A3F1GCcn8pEZmRpZfTJ0Zx3KBIqQvCvrC?=
 =?us-ascii?Q?ERPcUwi18YXeVPz8ysDtvFYNvaqEZ8eALIgXKovsI6MgH3x1qXLG+peHS6ks?=
 =?us-ascii?Q?AEkNy7SJWwdqCdCmel3FTp+/DRuB44Q3BNQOCdEqD5m4NRFn5SOgV9c3KwvQ?=
 =?us-ascii?Q?gMgDANmOJ3kuO/v05EoiFMr3R21LCt/xrBx2KvhmlmZ4eBIHXYfNtQP1VIA2?=
 =?us-ascii?Q?G0ngvlmarPniTyqvggvB6ao9ftk4kAzqm4yMJaM5pjgTXbF3cgiIChOrBdut?=
 =?us-ascii?Q?CZmPhOjPLNJGR0e194Xb+3C/39DE9yGwWUbvx9q1/NEFYA+ah/srKU7QSLb9?=
 =?us-ascii?Q?PYpT27eg4SLeZr/xJRB43vcpF1+DZj1QiuaeNEYwy7aVGQIk875WZnaDROHN?=
 =?us-ascii?Q?TrL4NP/hr1JkQVuX/wLrqrJxBF0KVy+Q35N8ggogMiRqJRmOyBiyqAmJvwQf?=
 =?us-ascii?Q?NnsUuP/ZelQSXwMZvkUKgTZ3uapVGOw2ZUPd7TVWjTpo16wFy9YUyxk8Zu4s?=
 =?us-ascii?Q?+K+Q+4HwcEhGRZbyfoJOLYdakgYaWfJ+sZNFGjWwnrghKGP9BnIT+G8coLB1?=
 =?us-ascii?Q?GB4ZCoGmHxMYrbjq3+QWNkBoHOYkjqmBka8rjbOE6mepDvllTQXpSjzU05nI?=
 =?us-ascii?Q?a/VvX89rrtt0R/0p7fGtpYRr5OPZB9paHIf1pCEbL0uydOMkPkf38z0hqVDU?=
 =?us-ascii?Q?chrmi8s5WuHlm+O5zdnSXDMCrfIToOP1MR+UOWJ1Ah0/yjlyqJ9C0e+XsAiX?=
 =?us-ascii?Q?w+LQ/9DjPivF/RG8fqxmbbQG9c/guYbKY3HFo8LFhR3sUDFFbFh+2VE3Ciou?=
 =?us-ascii?Q?vuwg0+X06V9FKjAY3pt3bgKRh+W0hrhhIf1LVwF9fVYFmcE5ES519Q+qrSPK?=
 =?us-ascii?Q?dsuq8Lmw2wc49nwrb2r1xGb+4QkHUQSC8Ro5BWlZnGID7gEMArICWAjvp7SN?=
 =?us-ascii?Q?uucyjTum6h93RYQgZO6k3ZTy5GeVhFKANFdDBaI0LDZCTvsj2KdNL4u+ySZ+?=
 =?us-ascii?Q?ergafMzcBkYKTMiQt04dxRM484Hz+ZjXpnjbbImf7G2tjfld5TgWDddIi40S?=
 =?us-ascii?Q?JaR3xLo3RL2K0+flgiOMs5yCCDVLQFA2nWsDeKPKrruj3lRAF76N/c0V0bmy?=
 =?us-ascii?Q?FBPbz22Cc7Nm1+uTjleE1vEQLGhwymrSq+zJDRw2cCTiPNqhcLiicq6xKBkm?=
 =?us-ascii?Q?I5y3+9AC9sJpfgVTX+IA0/20WrPK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAasgQtOthHLHExIiGM4E5joZDktaHQG0h0zzb0TvMhZ63k2lXF45d06UN17?=
 =?us-ascii?Q?K8qgBUZlvvHf5uMbYEign85+jt5tfYsoWFbXNEY6EDvyuK/boZSt83UOYXRR?=
 =?us-ascii?Q?ALXxHfLYWHBxzq1ElL3FrGZsU8P5SdOndwwo2OXJDvMGPrX4sRri/4NONCtx?=
 =?us-ascii?Q?udaKyq+IIkFAPI4NTr/64KZlz2FRCIYPRWsXIcDgjiR9zJPL02vLDRY9yi+H?=
 =?us-ascii?Q?mge4bdninVCsB+WJ+N9272SoXolNHWBNii9X31Ow4blz/sgpk12vat6E0zU0?=
 =?us-ascii?Q?od4tuSw028e5uPF7fETOD9YRWA9S9WHSIYZ/t2hg+PtFdgPBkapzplJVt4S0?=
 =?us-ascii?Q?PMTpmPDN46vsAq4R08bF8Rd3KLFCybbIuQUOqRM98G7xgRxxZp9Kh5RC3se2?=
 =?us-ascii?Q?+jl/klyWdKtr+dq0fxSjx7qGZ82rGL2owSUEn8pBlLFLyPQ5YSB9lxpnMr2m?=
 =?us-ascii?Q?cBuJUihjPIoFQd2oZiS2gv4QKzQpCkF/aoLOfhhP88CXWBz1rPmlPVtWxNsq?=
 =?us-ascii?Q?HRJ3OFN6ZZZHJYEUhpJFeIrnYX4kl9NkTcC+FzzEFscMg6j3OWBjdXQ5y/7R?=
 =?us-ascii?Q?q254L0OZ97FG8nmn0IEOTfk4ZJMLJP7Qaszq7///sFL6TQwxHjkrJ75Mnd9T?=
 =?us-ascii?Q?XlJxNZXDitrJMk6CERWMHYU/YCW0hi8c8uMsElj5aXo6LtKoe75rN9yBs1Jd?=
 =?us-ascii?Q?W8Zts2NU/CpROItKYfbQu78BrCf65sg5zAwNc81GPnIVHwRZ+dZBLtmgoxkp?=
 =?us-ascii?Q?ObHOFymoUMjTu2d0088dK+zYtz4EB3+wmGsnCTj1+gOCjZyoRFHT8FUOhlk8?=
 =?us-ascii?Q?n7IDWgOQutv6XS4ezJJpAIMIBS/CENvRMmoIb0FWk6BP5Gze5htmiKhoqVBS?=
 =?us-ascii?Q?mfvvZwMekMv6e6Ocyt82taAB1sovbipu5V3MPnW8w6yf2pbgQU3XdUm+vfy7?=
 =?us-ascii?Q?5oUD6QzHBTfo/y5GD261OkR2nlfJ9Wf5c0NsRAcCFco8aNAbNSHWL43iu36c?=
 =?us-ascii?Q?1UjEvPLahp0J/SR1sZQQci1IQ3tDAIdfJet6k4XXfqAZ+zD3cyIC7rdA3QAh?=
 =?us-ascii?Q?ZSb+N15WP0j6wLKmbFI2APlYjF+k6tdeNfgKiK2tS0PhnBdf8QgCTCg3C07x?=
 =?us-ascii?Q?/h22zHRy2GYnzEdlqCWBaZIhtNuDLz7FZbnCStckGbjIdhPRlWxoRv8BFVSW?=
 =?us-ascii?Q?QFGXBQUtLM64hG81kkx8KxVow6b7VdJq19pGxKxw1lA/Lmydw8OehDvbYHc8?=
 =?us-ascii?Q?FgHHxdCRGdgBN9gO13YDgH0CzLP6wQl225wj2Y9am0anWp1XxeNm2LjBwXfk?=
 =?us-ascii?Q?Jc6B2Jz5xBl/87TRYTgDFSyoqYzq9qDd0rNftShAbe0sXcRUND5v2AWh5Zyq?=
 =?us-ascii?Q?wDy5HvywanDfVUNnNV5fJslTlkznpUZYuSHJoFmjj9UHtRpZoLWi/bsMoj7P?=
 =?us-ascii?Q?6nZFXbWBf987eWW720haJaXFfB8BGPjV5fpz7uvPZaMAWn6gx4T9vbZ7BBQh?=
 =?us-ascii?Q?bnjHntbO2HSnF8wtkTNI7xHlop9UTRmLDLMgFG5q9ImLyrop3CF4FsS02t3c?=
 =?us-ascii?Q?Ioy/l5LfTNsFM8F+tHSbjv25hQLWZ0AvrLBYYZP4EBZmPT/23zL5Cr1Al9WN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yk92HpGAj+GuOrAlgmBVh7um4IRMjKHrMOgRS+HIVLSY0i8nlPv/eycdwMe+3O9SlHciyMx+sN71j4WOtEDCJf/GnO4Wbd/qafutY8pJYbp4sSjp6a+mjpvnR4lB8xTw9W38X9JGDoDUg5Fqpx2Hnqxv/cGfo30IWWY12hOjkIRnKtBPb+wkGIbXPJXomqyPaqHkcBnSm1WQGDZseOURKaf059eYp+CbnL0T/9qnFK0cYrD8gBH4cBrVITe7v0yT2uZPbMyj3qId/JQhgofuKvvwCkihQZnDjJOY/ehpZCxrAJDhQjVXMTLHd0Vy9X7a7eoz8qJNIN7H4IxRYDxMWQxgl9edGROsq81BXvAdhEH/65jmySThIPTFc1DLfPemkln+GlazFRcHLhJXwGfyB0De/n93ooU9ys4oeq7AxbabxoMNndyC25ogPRetBVXQdDLWiUtxOKa7cHiD28TMMvzVojZeowFCA4MSPCM0UsvqrGa2NRiVsNSsvTIDMJ3DMxtnJp9W6RGf+Bruu/MPHQXRlttHRTICdUWEj1dFY5dcmZgFHgmSFTEV8QYfIX5Gm0wkEpwVub48ctZBVrWOcubpEUoN32lIjPnpmK6j3Sc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db10fe5-453a-4284-4e45-08dd30a2603d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:40:11.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPQug37nL8rQ9et/JdXZrXHdTcbY/teiDb1bKNI5qAtO+JTB3xPRjBxCOf/cDQHUUZoLWr/b671lrk/iIrhAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_04,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090092
X-Proofpoint-ORIG-GUID: U0jk3BjrTyS2fN3Hx7VIbZu0FuD8fwAz
X-Proofpoint-GUID: U0jk3BjrTyS2fN3Hx7VIbZu0FuD8fwAz

The current check in blk_stack_atomic_writes_limits() for a bottom device
supporting atomic writes is to verify that limit atomic_write_unit_min is
non-zero.

This would cause a problem for device mapper queue limits calculation. This
is because it uses a temporary queue_limits structure to stack the limits,
before finally commiting the limits update.
The value of atomic_write_unit_min for the temporary queue_limits
structure is never evaluated and so cannot be used, so use limit
atomic_write_hw_unit_min.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a8dd5c097b8a..d4fccd09e237 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -589,7 +589,7 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	if (!(t->features & BLK_FEAT_ATOMIC_WRITES_STACKED))
 		goto unsupported;
 
-	if (!b->atomic_write_unit_min)
+	if (!b->atomic_write_hw_unit_min)
 		goto unsupported;
 
 	if (!blk_atomic_write_start_sect_aligned(start, b))
-- 
2.31.1


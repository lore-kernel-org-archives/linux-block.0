Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E36358368
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054974; cv=fail; b=lmKCPA4TZOzO6VzFh8JfoYI3yZ7tXjDSkcvSjbhUxzD0KqGgYRfwVJSdHRlZSYcTliBKpQiiH1oJwx00rFvOFAubIVyUTWNuDuHFeGKN3NBW4m/V6lF/izJrSmRdf8eT/DcvxLe3cwdwOHyv/VTV/x0OOC+ipexuN2cA/mqzZTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054974; c=relaxed/simple;
	bh=WMgFyhoNaGD6qnLdp0G6zqjvOm0/j9Nlbl1l4qP0wuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aipRsI6KV5yh8gsACSCaSjCSu7HSOxXwARU6r/5Ib70hPBDeXkridK19LnYynVPI3WOmHHDE2ZbaysZIKN6x8WU7FF83EnKhprCrILhLAk/UYfxrmFJEorOxoLtnSXPBsAJQgFKQa8Z1gOTVzVD0ZXhb7xP0v6bvdhvpJwecUEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HvMMuEtu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ioG5JMZF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HvMMuEtu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ioG5JMZF"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I9cPaK1414983;
	Tue, 18 Aug 2026 12:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Oqpx/d/NheKjFh263DZONnMziljrYM+uZP8jeWRhvr0=; b=
	HvMMuEtuaLFen1f2mwacIeYpKG9nWg4DDev1hANpgdnCR79kSgceHofTRe5PZ52y
	6DSd2niJHGAxaiJ1wYy3cMGCCaF0tHXYrKg7rxph4FBzUTH5wNQBLmNH9di3EM+h
	Z3d2il0bfKOY77bU4WkquE7yZaaPyiR05JA5rgVjX2mHnrNhcwwP3a9zccD4EfHd
	h/l686oUfCGdwIrPbLzup9EtEM4yh6bHV4lY1Nrpe4e4/iNMDrVML/qOANQ07s7Y
	jfViEblokS6v1WwXrWC7FS+4uL+BW9EkRooPEmpa/+zoVJ9+fSjYLuq6CAmIbsne
	O2w2Tfs+JRjQU+5SdAReQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2epy4u0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:09:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67IC5ib6030048;
	Tue, 18 Aug 2026 12:09:10 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejqjw8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 12:09:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8SfMSOiSgNug8h6KOD4U7Ann7afqHy06BkPwiAednJlYQOVZ7iNvgNMWQJ7YSZC2hMotT3/FOf8Il7bv7GGF9/T+jjDSzW9Ci3psK9DBxZ72txmaiw2JcGsACPmwH0JaLda2BKeHn2w6WyNvsXj57LFUOkK3ntyIOpkOxK7s+EuG8l2QY6H8mwbcwH9im4as3uUOmIolc2s5qMZI4g3lO+nbCKBkOKjUyfZ49ACoatOX08tSj4FFWCngoRqVh9CMAS7mMFs+3dgT727VCiCQL3nrTeMcsLDZGekFdFDk3qpjRVeORVTt0113yCPuf5HfCjsZOSJRI2avJ7EMBXm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqpx/d/NheKjFh263DZONnMziljrYM+uZP8jeWRhvr0=;
 b=JbM11ebRl40IjZISy88Da4mi/VbLlaApfduu7Z7JAOxpmEpgs1VWy50+H341SEiauKvnEfl5ut5rnnaqz1qF64/o4mnIZbAvN2WR1fVh87YtK03ETw4yej7eBMzb0ZmX3cU3n7xbUphtd3ymC1jvRkGXLID8q5S13VzanSM7ync6CAWhUevUD4JnfUKT/GaG9hwd75UivfHZzINcwN/zQO6sMkFwXMVFYT1rFQ/enwE6LYs0zrdKstY3N+lrUzc3/wTGIH6lLb6sust3RVVOhK39isbp4XaUzu/POrYuN/9t4PYbUeznSw/XC8HVGZOCqMfgioqDQdQtJyDHxpoSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqpx/d/NheKjFh263DZONnMziljrYM+uZP8jeWRhvr0=;
 b=ioG5JMZFkq4G2CBbeP74NvT2lVi+k1GT1t4NerWyuqIRpUlZ4+bwTu/lgA363WM3pfxIgqiWgEGhQLUAxkPsyaTOB31NVjljFnFsTjPpgQQ2auxtAydOA0gsZtiuILi46BzTkfXRHtm8Cfqx5GET0iZArWPMcj1hf+zo8sy/omc=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 EAYPR10MB997949.namprd10.prod.outlook.com (2603:10b6:303:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:09:08 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:09:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v2 2/2] nvme-multipath: fix diskstats for partitions
Date: Tue, 18 Aug 2026 12:08:54 +0000
Message-ID: <20260818120854.3151628-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260818120854.3151628-1-john.g.garry@oracle.com>
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:510:2da::24) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|EAYPR10MB997949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdfd26a-7a46-48cf-fc75-08defd21813b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CYRe7Rdjg5ebvEo7TfSXHx06sSC1ABjpbk5Y2n1ECwQum82XQNPrbk1HAxXhritXahf3uhgGA9cyiImi73hMX8gWX30zfY/9+078qYwZb48oAN53XYzdGsgXLnDFX+HTgMsNSWDQYznYARRdMKci1Lbk5yugjfRlzNc9lhv9NpAIHFze3VHFZ6G7YZxxLL77buWhDWMBq5Ifxdd0TD210lO4LzPV7i7yo/NS1oiPZeHVCHWktVblTuquot1fJ3QNoDgtoFGM/j5TXdceASPzGHdTIU6QZyz0GrjgzloQQss3rEXORcoSrc388NafQYv8B9iq+kYfPw32s5bFcrXcyqk8bcWXtDWHdE8pPIlT/8Mi4xbZ44QpAzYLdFtj4I2s58hA0QSDH0YQ/wU0/yeE9jskDxC/X+7Y2l+M8K/+icOLGbYCezKVu5200z3K+MZkFoo+yoD7Y8TzWJkDloeNHaR4Ua7PpbbYoVRgdHk1us+sxzFl7jcDlJq3kieWSK5BBbzQf37QfrZnV0yT2Rvi4C/n/0QFGkJ6USSXvMZv/TY6IDs/Kkv3Ta7SBj6uue1tIZVLwywBael21lk6N2tkeKGchCKjv5fC2fpXaaYcyyGhnUBtWTPMTr7AJ3G4phtVJrdmf3cr/kuYkyIJmRQfvOUWaVgtrv4OqCGOFlYOWyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRJM8SISV9SvPJsPDIWJqrZYIj+WTwrjFwlUhl1QGDmYALAfg9vi7NBr+/W3?=
 =?us-ascii?Q?wOMwIj8mbk7HjXwFEYv1A9qGb/Fv7NJEpF6puWFJcpQIMe+Hytng3v5Zziws?=
 =?us-ascii?Q?mokmqRmHRSjJHP3DeI05TbljVd1oKqo7+tnfey4GkpvS8aiMq7djds7lr+vP?=
 =?us-ascii?Q?nFhB70C+p3aBm+Tv5u5P3ZPVEnxhwW0OR4TOQWK1K/NhGIxRZtQtKnnZBgG1?=
 =?us-ascii?Q?/Mcm9KqqeeGbeTofnBoMgK4t3JRcDsUWFzSbyVlCuxs/8SBDMoNL+/+eML0Y?=
 =?us-ascii?Q?TcV1xOhjmLT+ek1up1Ir4FR5gOX4LIY+/50D+oeE83B9AQKxNgvLpO6q6ii/?=
 =?us-ascii?Q?R5gciD5dKFKk1d4kWCp1hsXrmv8dxsExia11gEmdZqIFX6K91shhXiDbBj1l?=
 =?us-ascii?Q?ZhalY8Ec8e/YpNRObo9nu5Pc2yzXCG6SfO55ewVLs8mNs8Pg31Pk8bUL0ZUJ?=
 =?us-ascii?Q?5VpykRezVCSoNn5cWVEXfvZd+HR75SgO3iEHmCb9v0AGgVl7NF1iTIKmUlG1?=
 =?us-ascii?Q?Jc97BXyAbRFmeLSlYP+3E8b9HXKDgXUrv4x8hvemqLZanFYftxzfvZhOsGh2?=
 =?us-ascii?Q?4yCb6JYXPW2qYz9CPgx2iMSE/nJjcqLQL43jQGTOChMkyqk1YYZ2LeIHHtc7?=
 =?us-ascii?Q?4poHu6NWdjWCw4wCYgnsuiSY/5bTARmOnExgIjF4vKzmgd6WFtyb8+lqUY4S?=
 =?us-ascii?Q?vxQn2AeMLUSz6nPBHQ5JkmSCtNPS7oGPqETy5USclAaXmpxoJVFLO4hkkCJE?=
 =?us-ascii?Q?BffLaCKcLL1fYz2J7KttjP1lojfRRxXIh/EuH0unrcat3Vy5zBDWwqVFCNbA?=
 =?us-ascii?Q?3nierXbYRdX/TRLpuR7bwGH3DqIO3UavDTN4qMHo77a8w8btRLvy8zgC8WuD?=
 =?us-ascii?Q?ZNHxkcf4qwNsy76IG/X0o0DesvvkLncS7hzigLjX59DZislTr9TeHH2a4CQw?=
 =?us-ascii?Q?89GJP5gV276d5v5HU7/TjWY9DtzVmAZ45cYqXCmSixFrXWk8z6mmuty+4Hh2?=
 =?us-ascii?Q?bu+U1OtODGwHkIv5GRlxET+GPBXlR3ORhifFhcsfp74vc6+b7KcHuyRN9KAo?=
 =?us-ascii?Q?Df/5ooIHdi9ai33X8b978PirRChMtyoRKHZ4WZSw64p1YFwAXA79kHsN4+0V?=
 =?us-ascii?Q?FH4V7VDGfBw52CJWcDy1neEFjfmr1gE8MwKStW2l/SRumnmTxFzpRlV/alEp?=
 =?us-ascii?Q?4oh37V1Evne2pEB7LRNNAuU3rsgu0Ej+BD7+qi9KUsYv6Q3W5MTqXDcxtDLO?=
 =?us-ascii?Q?CcBMx/GI264dM7XGAcRFXuKlJRttJpXjD7WuHdqYVtviSliIN3FljNsU8YCE?=
 =?us-ascii?Q?wzRUnMnI+1b11Z0r1jTjBuwYJQ7KD4LjvycyIQfDEPdySiJAtgWfCGzg5HEm?=
 =?us-ascii?Q?2EzFX5wnGahg+NH+vUIGP9Lr+BgpEdyps9ZMyBpOkT23mFP4ZZwa7V9Z7KPs?=
 =?us-ascii?Q?uI7YuDGWdOPv4L2mOHefWejVKR+ktO1IqSxDKWaI5jcaxAUneiW+nNmOfXtE?=
 =?us-ascii?Q?qBBXmTx1rY2GLT7wdlJuovbVMSijQdSPpSJ7m+BVdUr4QEui6JIeZBjhjefv?=
 =?us-ascii?Q?CThR6Ij74C8sD9bqpLf+9ZtgN6Qipg/Ga6l8A1rcUKK2bRzM6TyFhOgA1Kpq?=
 =?us-ascii?Q?piNAskVpyXsM1Q6fOKJTBBB66kba3g2cICUkiP/B/Z7H9i4b9TiTu91xgT1j?=
 =?us-ascii?Q?KiO3FnbkTLVcnGefpgSLd/LGp6VRw9CP6dah23LoUui8fXdUhHAyjheUfwkE?=
 =?us-ascii?Q?2N/ONJXFJv+sU7COfOGAGbMcwOAHUco=3D?=
X-Exchange-RoutingPolicyChecked:
	HfpcBNpKvH3FtQT0w4ulIVQTX52TJpUYxsywkovVIKEo8aWawqdM5HeLsYM7bVFhizX3LbHvN6adsw/mDOAJx5oDaRBt7sO2+7ZeL8iqymQ3c+ypXuHjKeYrPYQJ5vVIjLVAg/ZhaRZ2TeaNu2iV8F7isALS/aS0uVOBuPorYhMBeNPDs9wgP/xHYtRo252YnWjQvM7zGAa2bTQjMXGBdJjRoBift0kI5w7zI5xn8NAbOkx06ZeRWAqpUazrutYeDY0LaLY3671LKPqS7H91GHKZmz5wbdHmrCce2vu5jz7wCrgwryJAzfoH2f/xrboXZ5CKfmFbSg+gNsXKPgBxHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N5eq4UjK5ydv34ab7Fx+ILOLEBKsMPC20RJFRyHNFRRv1myowy0m+gIcBMtq7PYNfDMCsgf1FuSuajbmA5eEJIaaxe8Vn8PjNJ0zJC3RrBbQ5Cxh5aBzcCb6pxlUuVVkdcZJ5KxGQVztyO6lyXzdN6ErguF0h3l2K/8YpCPiXT9tYW46m4QjqxbvhK0tahUpfnKXihMvKLTIcNfaUZqrMCC/aioIu9mZ5Hwa5UObUnzPBJSRZNbl8BS/0acbbL5urrJRZRiN3dLZosshfmBt8Qjvf7KDNJC9SLGeLemWR0V1HYU7kY1Y0rPRgUjkvoPpXq4q/82XvYqI8tkO6DtoT8Ujr13L/chyftzOtVsA5JCMUDxX8YfWprjn4R31uyfMWGM9o2KG2gfHyYA2ITfqUnCVr14T9J/AMaL+RpRMgetdFptaT1mNcfrSpLyyCkBUlUbpXi2/wHlIV1S921hOGeP1Ki6iWd5MI0sdm17/Oa0Q5CI5JwQuZg2OdO+PPeZpnAVW2i5/FH2y0LOaXA047S+ccQNoyW8lZQGbzW7u707Qm8zrheTmSyhtBMiI5yJBXiJGOy9dHi761WZsoLFuQ2/vG16STRKXWzUeWCxSi+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdfd26a-7a46-48cf-fc75-08defd21813b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:09:07.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0pAiIjxNS6+E5T2CumEHi/aLL8m26tGnSa55peIJQYK1YIBR9KjgxxkHnwUv6WZ0KF75f6yK3zv+TnnOiQHFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608180089
X-Proofpoint-GUID: TLGQ-XZuPMpAQpHiJMFQYnHtUnqiZta-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX+jaErVDEy122
 FEVyFb4v13K2g2la3X6cLQ7ycfHwlqsFp4/RgtH9GtFXz4Zx6IMKS7U/dMns85BOXTfQFBQq4gR
 tXZQ59AGtx2DjO2+r3PYRTSBTIgNhTMViQqYqUxD+KDui/RoFsgqEzMJx6Ho1RKSkaRws71MDIo
 3ocGAbVcYEa2W+vWasRWR+MycKcw2omwYrWy/+pa83OVEuuzbI7sPe9Y+7xukCvxDR76ffcykAP
 jTHhdpJPHqRtyfr6zqg1iDOc22DPkNg9+qx9CVzI1TVrDN95fbAuqmsrV3F9l3AE94JfYNJXlIB
 8KiyNKslVjWfyWFnCPsuYtaTtmjf8vwBn3e2uYm7SjBq6SRwbnA8GxBjZV8xPR7t873h77XItrs
 1raN42zC82vkqTXClNkXJFNMevQapuAakLokcoxLgsxIGz3kx4SLkX+Bw7+eHs6ByJ8+kIVyXw5
 cKqCTVB2qeXQuIV3AGpAkb3PdPdiL54WL8ojCWIQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfXxbAxDu/CETzA
 mP8nCLoS/k3WntPSjoTXt9LRHP4HG6fllyRlJnuBwbzbvg89qHHAZGTPXQy/cmafIixrEFdop7U
 jA8ZmltL1QWe+oud/T6quwPynSc0rEFrymalR/OgUM8U3vmVKRo2
X-Proofpoint-ORIG-GUID: TLGQ-XZuPMpAQpHiJMFQYnHtUnqiZta-
X-Authority-Analysis: v=2.4 cv=EP02FVZC c=1 sm=1 tr=0 ts=6a844b67 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=KsDUD1bgtjCq9nwG9b0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13509

From: John Garry <john.garry@linux.dev>

Currently diskstats for partitions are never updated:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

This is because we only ever update the diskstats for the multipath disk in
nvme_mpath_end_request(), and we never take into account that the original
bi_bdev may been a partition of this disk.

Functions bdev_start_io_acct() and bdev_start_io_acct() do handle
updating diskstats for a partition, in that they also update the whole
disk also (if a partition), so use the partition (if applicable) when
calling those functions.

Change any functionality which used to lookup the gendisk part0 to now
lookup the specific gendisk partition.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a32..5c95a2ab7755f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -144,6 +144,19 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
+static struct block_device *nvme_to_disk_part(struct gendisk *disk, u8 partno)
+{
+	struct block_device *bdev;
+
+	/* Quick lookup for whole disk */
+	if (!partno)
+		return disk->part0;
+	rcu_read_lock();
+	bdev = xa_load(&disk->part_tbl, partno);
+	rcu_read_unlock();
+	return bdev;
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -165,8 +178,10 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
-		bio_set_dev(bio, ns->head->disk->part0);
+	for (bio = req->bio; bio; bio = bio->bi_next) {
+		bio_set_dev(bio, nvme_to_disk_part(ns->head->disk,
+			bdev_partno(bio->bi_bdev)));
+	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -194,8 +209,9 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
-						      jiffies);
+	nvme_req(rq)->start_time = bdev_start_io_acct(
+			nvme_to_disk_part(disk, bdev_partno(rq->part)),
+			req_op(rq), jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -208,7 +224,8 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
-	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+	bdev_end_io_acct(nvme_to_disk_part(ns->head->disk,
+			 bdev_partno(rq->part)), req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
 }
@@ -549,7 +566,9 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
-		bio_set_dev(bio, ns->disk->part0);
+		bio_set_dev(bio, nvme_to_disk_part(ns->disk,
+				bdev_partno(bio->bi_bdev)));
+
 		/*
 		 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
 		 * enters submit_bio_noacct() for the per-path device. The EOD
-- 
2.43.7


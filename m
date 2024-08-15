Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A070224EF
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710518; cv=fail; b=cdH7sMIfie+XxQ8VgSWdzMz/GYxZNuokEM/7AnLSeCjz9hgqZaz25AbqKWNN9H4MWVQMzW5JWiME1G8JWlwNkzpxGSCfGp3zmX8zWUcIxB481E24r2Kk8Lw3Fl8h7tmu4seNvG3iaKWfnrEEsbwmhOIVyY9A9XQNCvkUtAmYF9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710518; c=relaxed/simple;
	bh=KRMjbne2YUhkbzehontpkH36Bf1aJjbLpLOepUh5JbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnZTpCEJwx1HLcpqpeJxCOtm1nSVQDekLZ0utUPCgyn9ng65VpsL2FDva6mTjVzqubQ3QaFGfXkLTieaTxiD9L8aMzMHtmSO9x9miB/0GMKwpU4b3SwW8S6xmxjAhH4saIKU2nYA+QCEGIv3bfT6t23Buf2yguy7lHlH4JYLYYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEKFmVn3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mz2a6MKT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEKFmVn3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mz2a6MKT"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F7rc5N006074;
	Thu, 15 Aug 2024 08:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2UYrNRt6Hgk924NAfHO0Za0D48oObid8JGepvNSC55I=; b=
	nEKFmVn3xNHrkhndA5O+RxuXtLU1R6DeJ4M77yjuhKJOHCbRkM9MlphyCDOTJBzw
	i63mbamcJ9N5lp3CDxmZYkdlUoQMo+rmv41KB3ZT3xB0mJQZRkbSaKmULyh4+pKr
	IXuQGjNdge89a66coca8TvxV9DW0iF9vB8EynAokKoORIPKvc0D/Jq2gCG6Qno2H
	U6UY8SIHy4QtEjGotQlSgRP53hQBUedD2pPvGw/LJbU9/Q8iL+3mgHzEhv9P/5mC
	aDBJoHjoNkhgPhyRhS66xrIqy4S16UHnBuuEoYSPTabS7brTI6UCpC6ERqBTh2jv
	9iHkQhNHcLhxBhSVE1BIjg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bj4gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47F7owbZ003825;
	Thu, 15 Aug 2024 08:28:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbvxtd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAfeI4hYN/urXsFGhxJbaRks44r/owanJSPmOUQecby7Poe87+rnKr6MTNWiBgqvCmn5AVgH3/QjCE2cqs9iN36qhkBmKskKuVt0QjCCdgsipa8W9yP6VhCa+lKK7rWJ1QyEccw0Ezhn2dtCa4VRPUU0TEsmIUDLPiuVwS2S6KGUClLbUXckx62TfeeBK/3jz65uIl/gSy3a8RIZ48t/WlpsljvXY3dDBHdZm3qN75TSThk/4du7aMflDbzBCoifySJEU0r4ArbcCafNxvduLUVaUCnOP+pearLAxx+7vP+0jQzMGLScb6YelAUWywoBk2UzX+DltezR5cGpMLEvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UYrNRt6Hgk924NAfHO0Za0D48oObid8JGepvNSC55I=;
 b=TEZM8ccLqDhxPEB2/bGSvynoYgL0RG6L+r5vQHMgdcmHxWKFFZNi2FCY7pJPNRL0xnzbvsiLoiRhV+rag+rQwaXjBhRNsKdiberA0NUbDY+lRqk15qXYdFK7ALc7VdRYlGx1kMDLbajO4IP838nN6Yl50DrcQs2fRObhYWEKUYAySichi2hZyuAIT6HCGsnLXOBo78zb28aZIgSy++kwqeyJYVs9o2S30OIxpB1Wl0AfY3lw2ATzNhGuox+GP7uK2TiJqpkf148rXL4Nn01es/2ch7ZI14pqIpbH54S90RmAHCtRBeTCQNLjJY8JaZnStzRCKbgQ3y5A45+FCJxAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UYrNRt6Hgk924NAfHO0Za0D48oObid8JGepvNSC55I=;
 b=mz2a6MKT2HCIpXQ83NLLb2N+p9ci2qIfwYmclaeMZ5OTnXmdBNQxZQrG/X60rDxMx/cFFsaIkBwmTN3LVHLJdjpFuACrqS4Mjbgqk+fl89Nf1M5f8md3DtuEnbx2S3zWRyyCIi18mfHGZd5vcfzd21RxZcWbQwC0K141mO/f1y8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Thu, 15 Aug
 2024 08:28:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Thu, 15 Aug 2024
 08:28:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] block: Read max write zeroes once for __blkdev_issue_write_zeroes()
Date: Thu, 15 Aug 2024 08:27:54 +0000
Message-Id: <20240815082755.105242-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240815082755.105242-1-john.g.garry@oracle.com>
References: <20240815082755.105242-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:208:35::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6331b993-008c-4804-eaf3-08dcbd043269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQ+Ee47pHsw4ssSCUKX8N5qklXRIk3p/fk5WWd9MhTAX2hYlAREtKLMJVdZa?=
 =?us-ascii?Q?SQ4VhIUcgX7G8S696F4lEwb0kGCYwfKexlr+fUbCpJ1nshm6BwDo/mNUEIbY?=
 =?us-ascii?Q?uJsAlOy6KDSQQCUZ2b/T8iQUSsaULZc76xwvAyy1mW8LTckYe19YrkErAlfh?=
 =?us-ascii?Q?tPMt7epwsNDM6GD3Ym5QldeSlzC+vSwbDIdr7+SJbZNMmszZghRbTuolHKvO?=
 =?us-ascii?Q?ZCzV23V57vfMFnu1gWEbZozerK1QqyDZca+0XmL48m3DS8VoAYJnUXoukKLi?=
 =?us-ascii?Q?YM80olJEFouOJbr718XDXdO6E7+imUpER6bA8NiAJj4/cUkRQUpqJMNbrLsk?=
 =?us-ascii?Q?0YXxKigaUwSh1qrpAB4s7UphFe3HtMNgTukhogiTcsvLbXRRU7XhG6zf2l+N?=
 =?us-ascii?Q?2FqtHXF4DVXRwNfSQsV7AeKlY0Wj+yvnwMDPdcC9H6ur6EbbFc3cnhdsfYH5?=
 =?us-ascii?Q?d7L6S5hsB3cDAwqgJWPmFSjx4ULAazxiDBNU1Gt9BiVHdJM4iaeqvSZfGuNn?=
 =?us-ascii?Q?iUDQVwI9AOAfogvnlCsbgd8PbdQnlWQuqRnKSGm3kXsAKkXatmLV9ivL5nqY?=
 =?us-ascii?Q?MP+1poSIZe0VWafgpAJ2vv0uAjySzdZJLONimf7sH4z/7HPTpycyPCYPpTsJ?=
 =?us-ascii?Q?JdAinKr4bLpZo0+MBr6+NtMl/3zY2uqxuckt1WBCQPnO8FybLQcwH7Vp49li?=
 =?us-ascii?Q?nPE8e1Yi5AdGwq20/w7MZE0FeRyjIJPLTPv7tuT5p5WBkn/dG8b7F++jVHsV?=
 =?us-ascii?Q?Hq+muXS++8FuEkwsAjZmzcCjri3meI/xkfMvLvW56lKhrE4ilAPW8An9kgFF?=
 =?us-ascii?Q?zo0lhJQrHbimGvTtiKmdkcT41n/QGOCk8BMGNCzB372pn+qhMs8f5IQDh9Nz?=
 =?us-ascii?Q?RECGDwyOlIxQ+eQ32uR2Fy8z+1QsJnKUJr+6KnqvZf7V2EnNTEbUCjxaUhuy?=
 =?us-ascii?Q?DanE1LtBOMy4s1apef7SGZz96VN6sWtUz/Wjc9o3yyOl5fhlUIG+s7tp4kEH?=
 =?us-ascii?Q?vsaPCvdx4BsYZsT7obAz0jAKVAPHJbOYs9YiAvVB49Cce/232XEncgeOMHKl?=
 =?us-ascii?Q?UPrE8iXGMaZWENZqnurbaTWRkM2rkTgXV/2QwtcpLeUEXqjZf35kTfKTQJHi?=
 =?us-ascii?Q?hKNizOvhhGX0W2VbcFZXyxrIEf/jYn2sXMOLzQ3wHmtbqN4PnfmLkGL32bce?=
 =?us-ascii?Q?qGcYaFCgUj3ygimsmhuMpJyPtRA27QKfGtduepUAvNt0i2evFauesYOT9+9q?=
 =?us-ascii?Q?B+lD2a9f+3k+y76VBbDRMecXqApxSPi/puvRrsMIUBWeUhBbUC7Iv3R3ap1L?=
 =?us-ascii?Q?C1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6Y+tp0gvXAiqptfwFWa3SDHJMehAuqArqBXYkg9PuY4sCuMcKJ85DZL+hs5?=
 =?us-ascii?Q?StNVS1Gn4JJpOdmDw029Gqzr+2F7/T82xuL0oX8dSrAUh3WRedH7UughpMIS?=
 =?us-ascii?Q?5amBJoE99s9GbkQikCicVy/DO7v7HY1VibzAW2uVEYeES/6gapXVZDQ1rPd2?=
 =?us-ascii?Q?RQs6JyrDxWQn0SWiewqsBiNqG+My7MeUZe8tSZf/Qj6LDGYE54yfnUkJ63o4?=
 =?us-ascii?Q?O8uevOep7/6SWgx7xfuX2qLdPXWcD402rrr1HXyaXlYTrSvkIi26Y3b9HMSX?=
 =?us-ascii?Q?MwdOmhh8jtnvyTggX5E7qdbzzeduR/lLeUc5GYHNCaXz0l8GW24ezjBHCs9y?=
 =?us-ascii?Q?i2pcujky3j9IxdHAc1c3irkkUPYdGYMfMQnjmvyWeF6HXZdDoIbvnh82zYgb?=
 =?us-ascii?Q?SKzcQOr3ZE9IuULD4+uajHeaitSVeQP56FvXwMaMOV3KHXIYd6RfSD2ZEt7o?=
 =?us-ascii?Q?BYce1KxgkILR+IZ0Q8W+VRp4AssjFMvd8gzeemARYg3WrCjTiti+Degd9Rci?=
 =?us-ascii?Q?W8QBfqsHLbYIWyQh5LbxCZPgTtiFqR0CtqwlalL5+nxZORuHVNqqbh45ag/x?=
 =?us-ascii?Q?LUVYDILpJoV40BF8+8yZS65A/HYEtCnynsGYpM2qy/umNDDiXF9Mo9/vQSkl?=
 =?us-ascii?Q?RO/MPnFj2vl3LqYoiEj5NjCXAshmtj/TDfd341OzuCyBETSUoYDqr+jpprDY?=
 =?us-ascii?Q?bHcmCM947YH8GunvWhJz4tvGqWdmL1kP3NbGYLNIUPYS/2Stw7cZe7A7e674?=
 =?us-ascii?Q?A6IzD3B1oaixIGue0jXDH75BIDYBsCTvzEthA1jxYmmqF/aH43uah7tPwSHO?=
 =?us-ascii?Q?GVf3C7nbLESUGoN8En+XuAwIOryM+OG2wWl1LOIeq2ZN8tfsl93p9144nBvS?=
 =?us-ascii?Q?1KsLgHVQM139BplN2d8/20vdbuLAGVhAO5IFSUTB2D2kCrc0WUScBlpJNec2?=
 =?us-ascii?Q?2itzDOx2XXs/XZS3bONX2HR5+aDMFkVSGfq3eOovve7lk4EaUIddqoFb9KnE?=
 =?us-ascii?Q?xKwwNPLS4/X0Prdnn3GWA0InngLEl7p5KSVHyjPNcAHQt0vpX39yEC0fr+z0?=
 =?us-ascii?Q?4f9jQQwMw0hC+4w00gxw0q5reSFmdVFkJkzCltjBxJyx7gnIxOJgSVw9pScp?=
 =?us-ascii?Q?VJANUzx7O3/K3Tkv2tLw+k5Pc5mOYd7Z93Bb9YU0v8ZNKDMS3bvl39jxwDrf?=
 =?us-ascii?Q?i72595JDzs6cliMP3bRUDhd290sezUf9OTowYJOKg/vhZs81oDTqeO0g+ffW?=
 =?us-ascii?Q?D5y+br5AXx27fW/L1CQMp5Qei+yz1WEVrPPAJbnya4DGauorKbao4REEeZfN?=
 =?us-ascii?Q?lYvEjlhi1gRmtNao1HpwZhmXGRxoNJNZU074YeakurUYsb+Eyql5YmMkzfHm?=
 =?us-ascii?Q?0B/C/aD/AbH9AiMjo/WQqezAM8nlA+LTmWzkWB84zOk4AisE8uVh+ENoorHe?=
 =?us-ascii?Q?SQkZVBCDZxI2fNOYoT6Jc1m8aKxZ5RK960hUrneAdtb/yOhbbV8dk7bo5P9g?=
 =?us-ascii?Q?JytxFMCag2EvkJbDgZSLUmnk/3AvS0HRapxhrnKRfAa2SfE1tdMKmYrLbgQc?=
 =?us-ascii?Q?GjJBmlcwap5tpKPfEhwcTcOX2z9B/Pbkb/KxJquQW/FCEYENcq66GLDJhcTJ?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TbPtN6Qh8TW/ZT51CcvDpRf0hmGqebVbKsCQLgz54MX/1jMz2ytkffANF+guVY+um93NIij/tsyVTX1fTm9MSH3t1ibiQuIMEmHcEz6N177I7gCxln64JgMHe877ZWHfdlvpTZkA4ofjZ05T3pEpzJ5kTasknVK7LFv80WCmUcAJ7aVXwjTIvG6XSNekJXZa1nMxpaz2gO4bwT50kw450rL+/3IfNuHpPVaUa38rIapN7OTencFPuNS4Mw2SA/SA6upBIor673TnpnKBq64QPhH+RoX4dITxGHT23xwKw/vfQhJ/9d1kewqjSE2AaSaD79Ontm3zdKo3jKySw3VZEFAsLuxcPFeQ6sJ2w+nQ3H2JKDZtWiJypsBGB0yowIGEIWVdJY6AcJMjeFmz+istyrO1QGEyLWMHRGxusejXzF9yVDOsJgirm60Y1EjBi85WXvxgHK4A0Z5tLvkXwCoxpuRUpR/SUhEJvKjmzwHK+6WrfHIq7MuyFvoG4uJ7FvgSl84ZKKvRQUrKxcbY8sVxxIs2OYLzdB+Ls1Y5k6gTmY6sWLyfk66xZ9l9oKwmqLHvg+cuQAucvYqAw7SNlPmMPMcmjCr6u0OnNDp/mmlHS14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6331b993-008c-4804-eaf3-08dcbd043269
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 08:28:10.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hNGlweJNnjUZx2/hUNzYqFU/0BUh/Ufom8YwWVD9WPN4Qk/LeeP8ZHMM6ClALus776cdbjzNeLpHkkgPH0Apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150060
X-Proofpoint-GUID: HFq9dSrVhxKDVSOx2MsHlhXShM4gVgoC
X-Proofpoint-ORIG-GUID: HFq9dSrVhxKDVSOx2MsHlhXShM4gVgoC

As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
drive.

Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
changed __blkdev_issue_write_zeroes() to read the max write zeroes
value in the loop. This is not safe as max write zeroes may change in
value. Specifically for the case of [0], the value goes to 0, and we get
an infinite loop.

Lift the limit reading out of the loop.

[0] https://lore.kernel.org/linux-xfs/4d31268f-310b-4220-88a2-e191c3932a82@oracle.com/T/#t

Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-lib.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f735efa6c94..00cee94e5d42 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -111,13 +111,17 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
 		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
 }
 
+/*
+ * Pass bio_write_zeroes_limit() return value in @limit, as the return
+ * value may change after a REQ_OP_WRITE_ZEROES is issued.
+ */
 static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
-		struct bio **biop, unsigned flags)
+		struct bio **biop, unsigned flags, sector_t limit)
 {
+
 	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects,
-				bio_write_zeroes_limit(bdev));
+		unsigned int len = min(nr_sects, limit);
 		struct bio *bio;
 
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
@@ -141,12 +145,14 @@ static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp, unsigned flags)
 {
+	sector_t limit = bio_write_zeroes_limit(bdev);
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 	int ret = 0;
 
 	blk_start_plug(&plug);
-	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio, flags);
+	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio,
+			flags, limit);
 	if (bio) {
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
 		    fatal_signal_pending(current)) {
@@ -165,7 +171,7 @@ static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
 	 * on an I/O error, in which case we'll turn any error into
 	 * "not supported" here.
 	 */
-	if (ret && !bdev_write_zeroes_sectors(bdev))
+	if (ret && !limit)
 		return -EOPNOTSUPP;
 	return ret;
 }
@@ -265,12 +271,14 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
 		unsigned flags)
 {
+	sector_t limit = bio_write_zeroes_limit(bdev);
+
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (bdev_write_zeroes_sectors(bdev)) {
+	if (limit) {
 		__blkdev_issue_write_zeroes(bdev, sector, nr_sects,
-				gfp_mask, biop, flags);
+				gfp_mask, biop, flags, limit);
 	} else {
 		if (flags & BLKDEV_ZERO_NOFALLBACK)
 			return -EOPNOTSUPP;
-- 
2.31.1


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9B3DEFF1
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190593; cv=fail; b=te6bVt0jBOX4RvMTwfqBq56nV1c5hzpcbgQyw9RFXfiIDzRRn0BIr520EGmV1v2sIQtN0rLgagwkmezFKR4vRpoU2MfpV7CNPhrMjHek1+5rrTS2y3EZV/VJIsgrGBk8RRymqrgL3dgr+Tc8btVlhHv9DxSovWz01M1pbh/KCLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190593; c=relaxed/simple;
	bh=c66pZcev1w94e44Bh2Yc0LIHTdXaJgn1IvC7Cz6PLNA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IiUQ2AahBoTVbv1hrwe7DWy9pox4I4q+vArOOmaRIsiOsiyUtg4sdDD6J1L7jeB7ilGJtSlhPxP/bAq6ePfNUuJZwy/k38woxd8Pt/jDf39rafBWtJCFTkde7MrHcjU2Zs9hANdzfIKn6DatFjJdWa8WVhVDm1qpEKm3Sj1BI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C0jGaVXQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lPSLDY63; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0jGaVXQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lPSLDY63"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKN2g53106727;
	Thu, 16 Jul 2026 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=HVbli368+nfLHeXY
	JJCqHMVTKoi5rLLnAQ1S0mtJwwU=; b=C0jGaVXQsguXCfxOPVV7s44fMKrfNqel
	zNH5mxrfc/cV+0CgO8Q72K+Bw4SWAuXbKDKHJgmLSmJjaFynzsr0c3aHTGTFYTTB
	RT361+b8JOGGCFpPeFgaDEeTAhmwFFot8wvyKcJH+MOLcM5tJi5gusvKUYY5u2ZW
	LM5GDVaYQ1ltPnKOAL6RY/c7q9U6EUsno8eGwMg0DxRNR7a4ZnIYwhbEbaJ/V4XI
	ZpeZSiPM7p8NnxVzKsOlNU41AeqWtCQQKxJ0sukviKTYBkwRpk9CBf2GGS8eODm3
	8iDqyNG10FvGSCxPQa/YEd3Ej0SeHAy1cl+/Hul/f0eyEqtpSTMWbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeedra1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 08:29:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66G8SETc005993;
	Thu, 16 Jul 2026 08:29:37 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4feqyc70qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 08:29:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk41f0fWuV5kcYh3gJ2uWO3cyJ3HlEPBJy05a19cln2QT15ZjoLSngeYk2QSlbUXhHxOgaf5XKrFMHoG1tybQmTYZH09UxtdMiWpphd3Ii3MVj+aYAOgpPENyFfHEJ8RuoefSDinVs8WJlEX/SIJ70GM5Y1mGlzOAa3ksHwCSRv9tI3RyEMX/9+rfjyVIMChQuxIBpYuLuno9PEd2NO3iNK3Efs2gYvtrRemfU5aLip4ZReu+EOjqK8MgBTS3gmPS2+5SUcJFfHLKaME9EFv1O+iURp3yvZmFU45njgJNgdKZfk2T7SqVZrUfTdXMcvJaDS/3CQu8e5c27XcK6AbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVbli368+nfLHeXYJJCqHMVTKoi5rLLnAQ1S0mtJwwU=;
 b=GPwAyMaTCLxLO3tM5pcMucT5P0SW+kgaz8TSviJhF2fpbTpjRZczkBUVhD1SCxLzljUm690KEHFTZ+JxC3JV15xsO7OUoNJTFieAQel3OAkCTkCy+pUBnFgAM+Y7f0pdnmLX+1HfWJJKmX7Xbwva+Fbo9g3Iz2+2gFai468pnZeGGQc1zFdS4r4Lr1F20EqSV4HtyYH3kJDIg2ZQc+IQrRbkaMrw3TLu+OekTtgK6nYpw0YehwnAbipa2Nv7CtYM2lcFiBFtPICRzTQsliaBK1MJXP7uRjEFzi45okWILjnpLmwhfL2yMvdVYIpTUZBD6qEyIPOKqdA+o66YnOOpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVbli368+nfLHeXYJJCqHMVTKoi5rLLnAQ1S0mtJwwU=;
 b=lPSLDY63wXQIBtrIh/GzcyoyakK2TgAH+0yT/2wkxtfOAaCWDK+nr2kNOTtlJN3bm0LfcwIaN+tFCYgTakLi18EHjEiDRry4/C35YLLeEeMd0bOGljnhY19JZClsfUVjs/rkG1JQwgM7Mp63rP4PYlEzj1PEKZmCCbtiDphtKao=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 LV3PR10MB8011.namprd10.prod.outlook.com (2603:10b6:408:28b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Thu, 16 Jul 2026 08:29:32 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 08:29:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
Date: Thu, 16 Jul 2026 08:29:27 +0000
Message-ID: <20260716082927.4053505-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|LV3PR10MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8a0092-1c93-42b7-e149-08dee3145cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TgRUvrbxsCSKYa+4XwP4X57TKgY7ziE5B9Ctw40j9m90AbQek4sYQGufZgeEnsfO4l7iEpQ0a2pkE3UtHyGncTaAbSqmhczyJ2jlukqq3U5vGmCQPN/3mnb7wyqncfj5IHB79DlKGZNTDDifIyvab6JJiNj87R0OYCSkW1tIIlDygNWBzDZZZmAe2ybKTagEzb4YEvKEP5ameTnx0YpbRRZo7Z1Nw4zcl726N+ovacCKOla1C/Eg+rjXgwrE3EZImBlhcw1mE1Vlru+fjb+rrdK0sVgYH303HE5xFka2bDdx5LhDlAdO6r1G8nVzwTxpYJTft4D6cyPdMnXO6rhhNeoW8jzQWhl39nTbE34wu7M25EjWRCbS0xzRgEf2wYA1Q6nvbgYfAkkADCCPoEwh2jPAkaPQyjy4Ju2klM9/P+UgDDJrin+3UsTL3UZBBO1itr8hUCfOgWLpkzegzxJe9UkngblhJz/ifx0qy2pb/RPdHvhr8ivH0Nm+zEzxSNdyanfUzzIbp2cS+fnqN6KTlb9yAKSkO4xp9VNgpyYq9s1SLkBBsm8q691mGEtHJtmh/gjTETPk2Ef/vIg/bg0hLtt8Fem5eVdV2OtBXq4RQntzpjSS1Ovx+5wflbW8DXf4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSXhdW7qM1787xGi2XXyy2Fd0RB3gGXeXdNPrGOIj3jNuSmeoe5y8pdwCbMr?=
 =?us-ascii?Q?qtqmhv/9LbtryWO0oHyCBpWXiSXoYZKXmdElsQ2b9vNm4Eb61WU5uiASe75N?=
 =?us-ascii?Q?nVWrOr1q+OTiNhKJtijsB58gVDtZT/4F1ff8WvYcgsM3AaLoDttCf6aqra7A?=
 =?us-ascii?Q?8dzW37j1GJjXfROg4lfhMjVuonYhubSb8JaRVbUAX22GIJEkbCdJNOtNDNxS?=
 =?us-ascii?Q?eytmD/GXj5+YaeDxKRHQN5iAd7MrlTS5uBMSsFcygwB/+ZPgjhOmVDqgHAIK?=
 =?us-ascii?Q?p+ewRJ+IJIe9hDTXyxEpYg1B+KU8W2X4sgrgkhByHsZECeERxxVc3HeZUyaE?=
 =?us-ascii?Q?IAzgD/yno1EXcPzN9I9D2f97DeRbMWLDiQAwYu3nptB+4pMygGVcKPK5QWq9?=
 =?us-ascii?Q?2TVliM7cGyeAi3JRQ7MFPp8Bm03o2w9FcQrk0/UyTvdHwsVeTfxx8VmN2uJA?=
 =?us-ascii?Q?0PeSOTIBJpHDLHjMdd2nM7FMnH5+thYBaRYxYD2ctLX2caHelio1i0dYdAxt?=
 =?us-ascii?Q?u0GfayByHoToxrNT1CM1bZ8ih2OP5oJIBatvRQ5cPWuoBXI9cmJsVuJE0plG?=
 =?us-ascii?Q?ts9xi4kaTqeRT+tqNGoZLo5yNdFbVFF29zcTgEYleH2pXU+67zqk/+eWUNn2?=
 =?us-ascii?Q?rOFucy4lNgZImkztwyxoTA+smaibxk2JPvLOqeS4AyZNig7wkz1g7lifw69p?=
 =?us-ascii?Q?/72jCofEbuW2HURuLhPlJ44zbuqThKQu6kv8r/ZiwcTJhClUjGkuWW+eVf3N?=
 =?us-ascii?Q?9mMc+qi42mF1zoFhVVZKHJgkj+eOOB694Pf+XSX+YzTvM2mP4kXIqLmLhq/D?=
 =?us-ascii?Q?jvIoApX2DtGDP6NQO20L5rsAb+cZ+JpkG6SXGGpJKXwm7vmKVElSUdQfOg/P?=
 =?us-ascii?Q?B1D3XOkJt9VXXjUMeWOzxbjHYMCNUO3Px1ug6vYp2B0LkMi22fLAa6OtggRT?=
 =?us-ascii?Q?bGjTxg9Y2xnTjdFqAZJ7iMrsz0sOHnci1++U4HlB0lxMJ5DAaEjk1jKqQ5ti?=
 =?us-ascii?Q?ykNSpOl/xOW82NIkQ4fnMiJC9fXb5rmM+1muSIxdNBIRNjKC0v9DdUkKlZRG?=
 =?us-ascii?Q?qMqW74HIcklX18wHZznBvunz6Auu57AN0/gzY2OYhS1k2YnzCt6LzCX0e2t7?=
 =?us-ascii?Q?RtM1fPd5hIUmbwWreJNjX68ps/3vJwvWUUbXYPqdxEoq+JvW+SkjnwhcbH+o?=
 =?us-ascii?Q?Sw6AqEUsLVl8/QZmXMCSWuwPpr9k9YBa9VI4RUZne+SpZPp9ehwlAL+VOOTi?=
 =?us-ascii?Q?qOdStpAKySnBPY4AGi7fIhpz1HZAAzzSHsgjQ0rlwDsj0mAOcERlgFTwlfxT?=
 =?us-ascii?Q?IeTMKk3DHJUJP6IMxdqxUBXOEdKUgHU+KdGdlp1leZFTR/e+vMMCTxwCrTFW?=
 =?us-ascii?Q?2pUdf9jiXnV8C9PhXYrpUZYAX6gxm6ezw1dhcdecba8qbnLTIjeTZxMasXIN?=
 =?us-ascii?Q?UhzUHeGP6xT0RHX+085anURwwDdi0WV5xjsZB6rAI0txRJZaOPjtKQHhpNsf?=
 =?us-ascii?Q?aEzbzZBoUOKdgv5rip8Gc6usjvYzxt98mkTNVzE/IANYgezQSSMVYh3jbhkK?=
 =?us-ascii?Q?rczDbTXlxad93r2msKteDBg6FC9N6BtN6FkMEEeNHE2pySN1AXBpygUxxfr4?=
 =?us-ascii?Q?WhdUHTEXhF6TVLQg6Q0dsxwtcF6jfaYNan1WmnSQ09lHL3x1AZnT/PJZVXs9?=
 =?us-ascii?Q?K6Zlsy3qOefoOZxOmR+RAHR/pgsBffbeMLbeIKjSIKES6x6jhPh/m6Zp2wHC?=
 =?us-ascii?Q?RXKAypWpNyVIwr6hlPm1jhcJfA279gI=3D?=
X-Exchange-RoutingPolicyChecked:
	aGzulADG5I2jPmxWkiss9zeWyNojgY10Xi75S/KFF05D5tAfZYvoJ7BhelxX8T0tXmrAz3OzilEbz9msp44dBJhpwWUJDkh+Wtz/Hg7gEOdn6tLEWTPFPZzG6BwjmSt7beinnuppuqSvMdOriiuW4G8NZFEAe6K/8668hfL0mdRmlnfznzjmRAvGt7Lv05DgqB7hi2DaDEUfccEtaGxgr4p80xqA9y6ZNAY5X+0N8xCJ/A0nBlWTbrfRVoxXt+qJnLf74g84zGvL+xr7dlUU/HqjFvSmn6FUh5tGKnMF2mPprzC4as1l95YCx2byMntx5pwqTeBVCNbmS6BBGFcuUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LnQqLpM5ZN7oicqDPftJmG9hRTWTCOX9ifVU9YO7VgAaCht7vftpkgi68Wpmzxj/UXU/JCVw2z1iwdyLqmWcQg0LOsfa5k6R06TdgXMeF1kx+cHPB0MobKzbPqfqgvN2bInHMeWUqyxleu1UqgMO/fDWVEVVFpu1GkiEH2unLfFoB8SRixXgGyo91JKrSvq/2wc7Vk3jEm0E54jzVCytts+QmdkY4M3J9XZaaZRThuGmZzLVZa/RDUwftyyP55e7adwtPUnFjnjylbez/pOucVEzBSQIO8B1TAPQuxmq4wlu/eLUjV9vpMEjxEj/Zq/o1mG5NClOIW+03eZZTmHk6J/To2BJ74Uo7eGJyjFYz9HuJLVO53G2jarqlu6BBMjLctCzgmknaw5hVQ9iFsXe0MIEnn6FAXMYHtVt39LnG2jwaRnbaTz2e+FzXcBMy51U3xL38lkBryfxxbctK5FVqNTD6c9XShuRHR36bRSyrFwyqWSSedE/BD8F5yoIGYyUSFxd18Rfl1mxWu4vTbDL9TnlQH0VXUD1eCOHMPeWDamxplys0YqcqnBlt2rbsVOzozqw8anpcCHpAE0QW39/hnXG18vTeKGIi2SYkN1Ypxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a0092-1c93-42b7-e149-08dee3145cae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:29:32.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPNJOGoxfY9KWsvdSHCENJZylhkIG1lkhKqw1c8f3jLHRfUPJTuDfHOeUZUn/BWijDfqUjJVi117ofSNOBxcpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607160086
X-Authority-Analysis: v=2.4 cv=d+bFDxjE c=1 sm=1 tr=0 ts=6a589671 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QOYSxItt2YxLaTtbhTcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4NiBTYWx0ZWRfX6oYWQsUrm51j
 3ssaehzi3yQQp75n+tPv9WvTK8Cfkhecp/2rK1MFn4H5/cHpC3heBaJ5bhk87U0jGCM73JcJBgR
 TYd2DpWgAs0U8jU02QDVH3QH+aGXe75GVIe+p7ag8ti8IFM0SoKUQ2PpVj8hsSTKBxrx7ybu+ve
 yFsAevDCnBWhkq3V+W+ByualK37hOSr2QiQVxCLBuXxE8QkHpbyuv5AotvYGcfFIO87qSkqb6RZ
 0lsVMCZrHaWs3tcKB+gx1AMhH5fwbWQELWOFZblDnBiMCjIA3ViJNR+i7fbKuVrGy3ED3GKHkRq
 mgTV4Qbo13BgrJrxslSmcyaIOImp3usNid28Xoa/7IOGvovFtOt5geCEcYVID7QSX4YjCKxWfSP
 YlQqOKIIBzJJwFXma4lHtHynMT6m2vasVfmpF7mcqE6g4AOlPC3zNKSTNT37HLP4AuNRGuRL4Jv
 F2VLAde4BsIGymW3Z3w==
X-Proofpoint-GUID: Mk6aDEwV5T3BnJ8U5ESWQ7Pay75hgMcK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4NiBTYWx0ZWRfX8Khj9FPryZyP
 72cb8yWPGOjyIehdR7N+jAR3RhNCUSx5Nid+/KLqFtCHEcU9HR7nBqvpezDrdJikrTtEB9XII1l
 6a9DzLIqsl6Vdog5EyfKP5bdVDMO2mEgU2N0kId/gScl0iXMVAUV
X-Proofpoint-ORIG-GUID: Mk6aDEwV5T3BnJ8U5ESWQ7Pay75hgMcK

From: John Garry <john.garry@linux.dev>

In [0], a fix was proposed for the NS and NS head (multipath) cdev
lifetime.

The issue was that fds for the nvme-generic cdev may exist after we tear
down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
use-after-free.

This test recreates the method described in [0] to expose this issue
for NS head cdev.

First a fd is created by opening the nvme-generic cdev. Next we tear down
the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
the kernel fix in [0], this should trigger a KASAN warn.

[0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Differences to v3:
- Add RB tag from Daniel (thanks!)
- Address comments from Shin'ichiro
 - script syntax
 - add copyright
 - wait command tweak

Difference to v2:
- remove sleep and use signal to sync

diff --git a/common/nvme b/common/nvme
index 15e9c3f..42301dc 100644
--- a/common/nvme
+++ b/common/nvme
@@ -300,6 +300,27 @@ _nvme_wait_subsys_removed() {
 	done
 }
 
+_nvme_find_subsys_nvme_generic() {
+	local subsyspath _subsysnqn subsyspathbase nvmegenericbase devicelink
+	local subsysnqn="$def_subsysnqn"
+
+	for subsyspath in /sys/class/nvme-subsystem/*; do
+		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
+		if [ "$subsysnqn" == "$_subsysnqn" ]; then
+			subsyspathbase="$(basename "$subsyspath")"
+			for nvmegeneric in /sys/class/nvme-generic/*; do
+				nvmegenericbase="$(basename "$nvmegeneric")"
+				devicelink="$(readlink "$nvmegeneric/device")"
+				if [[ "$devicelink" =~ $subsyspathbase ]]; then
+					echo "$nvmegenericbase"
+					break
+				fi
+			done
+			break
+		fi
+	done
+}
+
 _nvme_connect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
diff --git a/src/.gitignore b/src/.gitignore
index 988d785..af9ebf6 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -14,3 +14,4 @@
 /nvme-passthrough-meta
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
+/nvme-delay-ioctl
diff --git a/src/Makefile b/src/Makefile
index d75daf1..4779ffd 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,6 +18,7 @@ C_TARGETS := \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	ioctl-lbmd-query \
 	nbdsetsize \
diff --git a/src/nvme-delay-ioctl.c b/src/nvme-delay-ioctl.c
new file mode 100644
index 0000000..2cce95a
--- /dev/null
+++ b/src/nvme-delay-ioctl.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 John Garry
+
+/*
+ * Simple test to issue an ioctl some time after opening a cdev.
+ * This is to test lifetime of cdev, and whether we can handle
+ * removing the cdev while we have active fds.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+int main(int argc, char **argv)
+{
+	int fd, fd1;
+	int count;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/ngXnX", argv[0]);
+		return EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	/*
+	 * Steps:
+	 * a. Signal to parent that we have opened the file so that it may
+	 *    start the teardown.
+	 * b. Try to open device until disallowed/gone.
+	 * c. Sleep to allow nvme-subsystem be torn down.
+	 * d. Issue the ioctl on original fd.
+	 */
+	kill(getppid(), SIGUSR2);
+	count = 0;
+	for (;;) {
+		fd1 = open(argv[1], O_RDONLY);
+		usleep(500000);
+		if (fd1 < 0)
+			break;
+		close(fd1);
+		count++;
+		if (count > 10) {
+			fprintf(stderr, "%s still present", argv[0]);
+			return EINVAL;
+		}
+	}
+
+	ioctl(fd, NVME_IOCTL_ID);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/nvme/069 b/tests/nvme/069
new file mode 100755
index 0000000..61f796d
--- /dev/null
+++ b/tests/nvme/069
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath nvme-generic cdev lifetime behaves as expected.
+
+. tests/nvme/rc
+
+DESCRIPTION="NVMe multipath cdev lifetime test"
+CHECK_DMESG=1
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+	_have_kernel_options KASAN
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local nvmedev
+	local loops=0
+	local quit=0
+	local nvmegeneric
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	nvmegeneric=$(_nvme_find_subsys_nvme_generic)
+
+	trap 'quit=1' USR2
+	# nvme-delay-ioctl will open the nvme-generic cdev, wait for teardown,
+	# and then issue an ioctl.
+	# We tear down the nvme-subsystem in the foreground so we can catch
+	# if the ioctl triggers a use-after-free KASAN warn.
+	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
+
+	while [ "$quit" -ne 1 ]; do
+		sleep 0.1
+		((loops++))
+		if [[ "$loops" == "100" ]]; then
+			echo "no signal"
+			break
+		fi
+	done
+
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+	wait "$(jobs -p)"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/069.out b/tests/nvme/069.out
new file mode 100644
index 0000000..cd2e1fd
--- /dev/null
+++ b/tests/nvme/069.out
@@ -0,0 +1,2 @@
+Running nvme/069
+Test complete
-- 
2.43.7


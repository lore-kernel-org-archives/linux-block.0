Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD8372ECB
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545142; cv=fail; b=H5Pp+lktrBhtPXVat+E8/pqYJM2njkXH2DQk9jWFw4U7/vacVigp+G0kPgeLmmbVNefma4Ji8XdB1XDjo8r04kyezOB71Qp9oypnkOWqoyMw1ryz/+hAOwiu3uszOs5uSfsfDjQY1pbYC/zkeZgjwISddwDVAI1TFo7glExWITE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545142; c=relaxed/simple;
	bh=pGnm+g8RacCCv0U5rsae9zxNK6vG4+uwxPq+2cuffnU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bhRzHQvefsKdyQoG2ZlbrEzuKbGCxWdJ49nmrVXUhqceowPnBQ6FVwKEfvvib81Uz4tvDJxZClOUrA/2bh7qUcQkSKeQ5uy1vTdhTI8kKpSp3vohY9LL9kS28pak8kBAwpcidh1MvvDnR5SM+rh2kZAFmTa6wetFkWZmlzlol54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uc7tAk2p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ONye4NJF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uc7tAk2p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ONye4NJF"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U0BZva137221;
	Thu, 30 Apr 2026 08:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=fRhWGOEVMcBDgPTj
	pShWPEkqAGQJZIvQ4cC5yewePp4=; b=Uc7tAk2pG0mlSU4bHAZCkeX1/doTLfj5
	os9oEKTfJe+LXItAF7/vOWxeotnxiwmpP5Tat8vORfea7amwDvGnLBEIam745y8e
	1v/9aedp8n4A/sdnG3xdOoENwbbmtUnUegGxko8Uh7R4jm7srg+tjahmu2GlgykT
	OY0NeS3UKRnl1T1q3RRJiw50z6M0kSSxC42Fg0qZ5AhjE7K/S5BvoYGQ/ldFina5
	dWPTNnd7viC7R27dTMazV+k0AzX1wTgNY04J87eTl12OwkofUSGS+Ed2q08czvHk
	gnbDraL44aXd0rH29ne1gZl7GgcRpOZ81tyfhIQ9RCyqLncElNQKRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drmd64ncc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 08:46:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63U8fQoQ000729;
	Thu, 30 Apr 2026 08:46:48 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2necap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 08:46:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCwsMnh/rA95478H7Jk3nMjgiJocjTuEvC5rdZgjHYxpTqCb+qpt3HYePDOmXzaFylcjnGFFTqGucPm844IeJzI8gURRaIPhK28ah4FdCUJIrzbfcLjEELVr3F8Fp2Fm8SpLCUnnK7G2kvjQngTLEVNZ+2oKDOBVIFi8XvbVc+js3ydMfEfUbjKpBA7S5fJ2t0bFgd+gNdvrMAA0Bw7RQIEi95rVxReu+cnfAG8/60zB9MIah8aPg2evUOgy/jFA4qs04WiBHFYXx40p1JEj/MhIZ8Pux/5aMbaYG+FjIzJHlOmgUxY3ZvCNIYUqYDfnxulIoPjglc7qadFLle7gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRhWGOEVMcBDgPTjpShWPEkqAGQJZIvQ4cC5yewePp4=;
 b=E0hG8VWqm6bC5k9JfsqVBear3hpEW1CcYhGLQzKP7I7HGx/4Nw/gRbB2pOmF7mHw5n4rNMypxZEBV3b4rziU570WUl0F/OVhKlNM0D7G2cWSBiRnK9JSydcQFEy45SD223WeEpfqIMmZY7ZNF+/AFeXg9ABSij16hMCeXjudspakByUPNQDUH+xteEtG/Cjxc/t5uIKnqCOFTafCKAzILqXYQshF+cnni0TMgIbFv6SXf9TO04gptyFTK2zSMZtVCbYcz3rzuj7FJF3AEKVs+TjY4Q7Yo9igcbKpVpCuKa5Jbh55ycGLh1lyFBRiuX12zN15v1GMRS3CcYGLoFc0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRhWGOEVMcBDgPTjpShWPEkqAGQJZIvQ4cC5yewePp4=;
 b=ONye4NJFGko2W1+4fjHaN/VtW3byTxLKGMimKteI4558CBhXnyGdHyqByN/Yt0zO00j2E2NhofalJooDf9a1f0O4yphKils/LHrlJcKAY7s2EGiNCG8cMCjdxgFN26KtrnMI/gn5mgZLR/c449AY6vfEYKEBe4G/Vawiq848bT4=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH7PR10MB6628.namprd10.prod.outlook.com
 (2603:10b6:510:20b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 08:46:44 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:46:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, nilay@linux.ibm.com, dwagner@suse.de,
        John Garry <john.g.garry@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v3] nvme/068: add a test for multipath delayed removal
Date: Thu, 30 Apr 2026 08:46:35 +0000
Message-ID: <20260430084635.2438048-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:510:323::26) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: d17917ca-e00c-4030-0f8f-08dea69501e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TRMGRHDMBqd18r9DhI7B6mKFWjd5imZVw4iXSshc0Oj9UY/Dv2PMS4bgKSDjF6XT2pL3kM/VYctRc4dgry6uJFHohvePESuLBARdE4poHeXB52+YQAq25CY7zWEFtnjGL+0Oxsli85IC8oFSNYhu9UWdSuUMACKe1uKY4IwHNt5a2Lnm7JzZeMqQs/yAnnFRCvuYnC2Xg2grKyScURmxQesds5SCxfHqb06RRUfUOPMKuSLUKVLzSPfwDZXFT+AgK2DL9tnfTaZ4hs016v9lqS3eTgyKqf84kA7uaW1O7idVDlVZpe+QrEe9O0U8HCM4xA/fLfW4tWNu1tguZdz7B8kUDmW42neI/B4qbeaHwpaY+jkJEHaZJTuJnWOtgWl/HFqIRZisaiEAhP/d7kuXyiLSfPaUuMxn2TSveiZtq3zUR6iyw56YRVeniPCWb85UA8Ov/sJo6KChk4aY4WgAMuqc5osIyOMU2uWdY/8kMG5Sl3Z7/CjqwN04Dl4yR2hbF3cNx2VobYcNA+aqGuY46+zss5NBMCqvaXgn2mq0yuYQrnwwOg+c2qqQ+UUmMKAtVOsuchS3X70V3saVGuA90wk0IYMTAos9U7qJ6JCwZ31BWIeFbHL1eSPE7L02J4dl8VR+n7aATQ9bWbYRjaaulXvvezeOsgAejx4l+BS/HCL++RMFp0++318pPWsPt8DHmrOX00yFuNX+4M1TyvTOAi4es6hAPjJTzSb6PO8yXq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N57UIew4fy37Db2Amry/In1DLYU+JkLPyzsh2NjfyMsvD7gVofxJmhEYTi6x?=
 =?us-ascii?Q?yIs5/EKGrmpeiFkcpZk9vGw9VKzQAGYabO6lHG23W14uj5mcrG4JypYotUeZ?=
 =?us-ascii?Q?OfGv1FXznmjkaNbGFKCzSHkSmZ/lYBJaT2VeyPJuFgRwuOFFVmrKH1RxcF3q?=
 =?us-ascii?Q?uBmuxHUD6Dh8tylyynSmZmsKHHY7CzgQpvoUPaf25mrKFGEqPcRChGmuOnfk?=
 =?us-ascii?Q?yTk5kT1T9PvQHSYaK2iE04rLCyM8/vew61yO6CeAWu7mOwsPp7CeHhLw/QjG?=
 =?us-ascii?Q?EMAp7EpFrNDRb3k4A9SzoAFKTIoS+E621rcO1/Yfo2v7+kl5NyF+3yhnZGOV?=
 =?us-ascii?Q?/0OCNVYYYJkJE35FUS+KN1dVNmc+iGgkakKEiGJhopaQ3YRXUBsrYYeLEfAO?=
 =?us-ascii?Q?MzAa0iyb0ESQ9W6f0ahR7maKJStlDQ2SPQidizLj3MtEhB2+C1LfgK6QDUL3?=
 =?us-ascii?Q?ZR68FEfqx6P2DVK1ycmN/futAJB2Tnj6I3+gHthgAuca6AWY+/Cme+0lrL6a?=
 =?us-ascii?Q?dQUB7hd15IS+YQI8T2RExtgOsZNwa56qvb/Un8XFU+Tv1jGbU/JiRNRqYaXQ?=
 =?us-ascii?Q?3ofx3Wj7LJ41Wq9aRtbxE2eAQyJDKSnotr1mqZ0wAyIEo1AY11BOcOD0LNwH?=
 =?us-ascii?Q?TUY95xcKzI6Hej4XWFv6igUDhXcPHHHxDAziswl1izBvBFuy7o/gHkz9Aulj?=
 =?us-ascii?Q?W6CVWXPsVtZelxoUN1m/XDALBMe7m4iMGTFVKKfklP8p+/CGWfvHrDCxnzwF?=
 =?us-ascii?Q?4/EM7GdYOong66OKFb9XCLztnIewBtcsW2RoZ8lTyIJfNuhd3wb0TQFWLg8Z?=
 =?us-ascii?Q?wFAn31XY5W7zslpAU4JoaN3Nw7nju1AbquXIC0FeP2gdRe+U79fi292rDo1S?=
 =?us-ascii?Q?9mVGdZqTCMUnkxkGoHl8EYLzzbA8ag70UJ7FcO8d21iS9Lm8s2zWqrVjhPAZ?=
 =?us-ascii?Q?lRVVtUdYqW0cDd95r/wcEEWTsF0EFQbhsYbYcw6iT9GSb8DLWPe5VRqf8DFq?=
 =?us-ascii?Q?cJO6ZztivTQPiKcLhinfDanH87OCm3zvIPMa9PnJlao6AXtn2MPRooWTT09T?=
 =?us-ascii?Q?apiEoOyE3yPpxdHwqLVXxq+gfmOb3owOez3SktXglthS7HV+7Ktw6NtBjnxb?=
 =?us-ascii?Q?Ni6sU46wyLgf+YdKgzL8FCHmmDFU/ZV9MtVz2Zlnl2ScDNZrx51Cu90H3j0v?=
 =?us-ascii?Q?QLVN+jQkV8gHSUqTrrrF5M1IkFwePoew8v0bp5IazdSki3Dl1R52QlHLciG9?=
 =?us-ascii?Q?1Wi0kQ7ASVOXhq4QQrUfdSk12X2Nba5wkXMaLX29+j31ojY5DJszaoMzADBF?=
 =?us-ascii?Q?FGDRL5AYkPkW6/Aq2HrNt37n+Ri4VE1XarGRKzQrGRO3/rpWcmGRmChCSWCA?=
 =?us-ascii?Q?T4TOoJz6UtvAu1h7B98GfG218KehraBl902HpquhBkuqCjIm3PoF41+vHCXJ?=
 =?us-ascii?Q?0+R2Uop+7BG44OIoK8DALbBMv/+7vYGh4MzjoNgMsiR7pBa8ej2+jto8uUFI?=
 =?us-ascii?Q?sfjeVD7btAcvUgldqt+/9cbiUvzig1zLgl7Ww6vV4RNRO7hP6/AoQvK1HjSz?=
 =?us-ascii?Q?oSCW3Ay/gb72y/EigHEfzNtovNPh9R9NWHaNXA7vDRPjnFWycPoH8vWx3JB3?=
 =?us-ascii?Q?7fmzRu1pzcazXJT5CA5CxLYiXBDysqHzs4Nl1k9ecfuygLl45JKjC3NDHr1Y?=
 =?us-ascii?Q?X1plaAkQlQ0mhrflh+nJcAQ3mKICKGUXzWMCNWm3V72nH2gheCK/t+vKv3j8?=
 =?us-ascii?Q?IXWudgI6uQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	UYplDsVRnIA3AvOm0WIe+vKYFQMSWH1hEPxaWbmvOqe16+N5dbeesNzlYR3xSxZiZXndm8SuuO7x0KPqX/a8ST0RLSmJQqWL3t3qNdUF/v/zjLxwNqQikZtnr0N7xGjDl9xpY3ag+q+X3HTj6cJ5Mv7H9UrV97VNxP2/fXlL9by6kseKbKEzRNdHt9SGJeRP72Oga5QZl61KONVjSDDM6IBLBHht8BUlK4RbASWIFADw8JKjiRlOxU2480ksMj5bH2F/1nb0TYBx2RdkxqLXUzREvfedqe5tUhuYQIuxnA6zKOrtbPaXIjhzfKnCf50gy/YuQjpb9lF4ru8KO0nG0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vr2QzaBQstYoYvTiWwWlT8frAqzGzrZhLp5g11aNORJAv5lyguMF/csn4RK8Jke9m7pebXuhIqVzTTozwiNqKmgQBw5Vs6Ur4cEJ1/EUu4zTDkoO8Qnh3WAj6FhG+pNiT8cR4efm/0YXzJgJp/FtyOeb3hrRbhG8LEhrBj160TlHPoyn8cKF6CGf0Dd45fL9NlEPNylA0et8V3J1pfo7PIzfcesag+uPfLQWGt4luHH4OpCsIjAe70efzTHj7Y4ybiB4VuiN48pyw7dH1XRplp/yp7X6TAkOZ+VwmR1UKryAWa4NQ+xtVhlRuA1ibNvE5lcNQoF9SZ+ZisFQnq6EhuT0IRKNS8bilblFqmRr43XrfLSXM4L73RsAO9+19RxKFx6AGyH5MR6/2oWnhzrXh18noBu+k/j1EbBaFYcNXp83Zsub3akS9ZfyWTYND3U9EwGhhs9n41D3qK97b9OOjs4Sf+ZwHJwl4l37vsODT4aG7IYfKv6mVYK6Z15QJ5dG1xGtubMM2/w8yMyzMWhh+bntKSjM3wATjUoVyfM42upjA+SyoBN2PHriS5uUMnMOxagn6hfgrqtaFXsPPWfFTRGxQ8wJil6LrbmcljM4FqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17917ca-e00c-4030-0f8f-08dea69501e9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:46:44.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sOgGvezbbnJXaiFBhTSNqS0Va8WLAHbbulgGTLGRjhpMPioP3qE6GBleLtYLG2gaZMN+SCjpgHu91hAHuySxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604300086
X-Authority-Analysis: v=2.4 cv=V/VNF+ni c=1 sm=1 tr=0 ts=69f316f9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=kg-MqlmDwuTp3Z1i_K0A:9 cc=ntf awl=host:12309
X-Proofpoint-GUID: xmoEM9sFTqLpL_9hVH0epvMcxlJ90XP5
X-Proofpoint-ORIG-GUID: xmoEM9sFTqLpL_9hVH0epvMcxlJ90XP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA4NSBTYWx0ZWRfXx3G6tU3k/7A8
 j802hfkTSXLxqnonXM+bXXc8OJADEjsB722Lg2QU9mFGOKb2pXweTrhj/TFeEd0M14/pdSg8IY/
 5JfpWEK/uTJoTFYXllCScdjporFAsp5l+yOc5GZGBQFEbS3RGNTVMg+2UIDA4jmG74w8cL/g6k8
 zWLD7qRtZq118NF4h12ikWRSoGohWlv9MzdfB1f2qBOrQXIwTBJyClq1IpVi863yN48oC0UoB70
 w+FCkIlJeA7GQxCdmTh32ZsadisKnzsH3TNOtcmOQeeyUN6trpGeU4VU50NbxNB4hQtYh0r+iw0
 oNRy8/LUUi/6ZhanoZBRO0mGjVSOXRSK6N/fZCwyIQurP2zp9MylNK74uJZoj0tw211x9ImhvQz
 p93Ey2qjRynjjcJ7jBs0kBJXPN6qdS5BsjFGxvfj/fPjnx9Yy+3dde5SIDEXyNDHSXFTGLlibTb
 vZdzId83CfTwxrzNB1DAr7nju/ZdZjItV18Vdsic=

For NVMe multipath, the delayed removal feature allows the multipath
gendisk to remain present when all available paths are gone. The purpose of
this feature is to ensure that we keep the gendisk for intermittent path
failures.

The delayed removal works on a timer - when all paths are gone, a timer is
kicked off; once the timer expires and no paths have returned, the gendisk
is removed.

When all paths are gone and the gendisk is still present, all reads and
writes to the disk are queued. If a path returns before the timer
expiration, the timer canceled and the queued IO is submitted;
otherwise they fail when the timer expires.

This testcase covers two scenarios in separate parts:
a. test that IOs submitted after all paths are removed (and do not return)
   fail
b. test that IOs submitted between all paths removed and a path
   returning succeed

During the period of the timer being active, it must be ensured that the
nvme-core module is not removed. Otherwise the driver may not be present
to handle the timeout expiry. The kernel ensures this by taking a
reference to the module. Ideally, we would try to remove the module during
this test to prove that this is not possible (and the kernel behaves as
expected), but that module will probably not be removable anyway due to
many references. To test this feature, check that the refcount of the
nvme-core module is incremented when the delayed timer is active.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---

@Chaitanya, @Nilay, Please check changes since RB tag granted

Differences to v2:
- Stop using sleeps so often (Daniel)
- Add RB tag from Nilay (Thanks!)

Differences to v1:
- Add RB tag from Chaitanya (Thanks!)
- Address shellcheck issues (Shinichiro)
- Drop Quick=1 (Shinichiro)
- Reference kernel commit (Nilay)
- Tidy setting refcnt (Nilay)

Note that a fix for a refcnt issue has been merged into nvme-7.1 queue

diff --git a/common/nvme b/common/nvme
index 565de59..3dc9e2c 100644
--- a/common/nvme
+++ b/common/nvme
@@ -268,6 +268,38 @@ _nvme_disconnect_ctrl() {
 	nvme disconnect --device "${ctrl}"
 }
 
+_nvme_disconnect_ctrl_sync() {
+	local ctrl="$1"
+	local subsysnqn="$2"
+
+	_nvme_disconnect_ctrl "${ctrl}"
+
+	for ((i = 0; i < 10; i++)); do
+		_nvme_ctrl_ready "${ctrl}" "${subsysnqn}"
+		if [[ $? -eq 1 ]]; then
+			break
+		fi
+		sleep .1
+	done
+}
+
+_nvme_wait_subsys_removed() {
+	local subsysnqn="$def_subsysnqn"
+
+	for subsyspath in /sys/class/nvme-subsystem/*; do
+		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
+		if [ "$subsysnqn" == "$_subsysnqn" ]; then
+			for ((i = 0; i < 10; i++)); do
+				if [ ! -d "$subsyspath" ]; then
+					break
+				fi
+				sleep .1
+			done
+			break
+		fi
+	done
+}
+
 _nvme_connect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
diff --git a/common/rc b/common/rc
index d2c1d74..f73c22f 100644
--- a/common/rc
+++ b/common/rc
@@ -117,6 +117,16 @@ _module_not_in_use() {
 	fi
 }
 
+_module_use_count() {
+	local refcnt
+	if [ -f "/sys/module/$1/refcnt" ]; then
+		refcnt="$(cat /sys/module/"$1"/refcnt)"
+		echo "$refcnt"
+		return
+	fi
+	echo ""
+}
+
 _have_module_param() {
 	 _have_driver "$1" || return
 
diff --git a/tests/nvme/068 b/tests/nvme/068
new file mode 100755
index 0000000..41e799b
--- /dev/null
+++ b/tests/nvme/068
@@ -0,0 +1,113 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath delayed removal works as expected. This feature was
+# introduced in commit 62188639ec16 ("nvme-multipath: introduce delayed removal
+# of the multipath head node")
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="NVMe multipath delayed removal test"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+_delayed_nvme_reconnect_ctrl() {
+	sleep 1
+	_nvme_connect_subsys
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	local ns
+	local bytes_written
+	local refcnt_orig
+	local refcnt
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	# Part a: Prove that writes fail when no path returns. Any reads or
+	#	  writes are queued during the delayed removal period. If no
+	#	  paths return before the timer expires, then those IOs should
+	#	  fail.
+	#	  During the delayed removal period, ensure that the module
+	#	  refcnt is incremented, to prove that we cannot remove the
+	#	  driver during this period.
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt_orig=$(_module_use_count nvme_core)
+	echo 5 > "/sys/block/${ns}/delayed_removal_secs"
+	_nvme_disconnect_ctrl_sync "${nvmedev}" "${def_subsysnqn}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -le "$refcnt_orig" ]; then
+		echo "module refcount did not increase"
+	fi
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" == 4096 ]; then
+		echo "wrote successfully after disconnect"
+	fi
+	_nvme_wait_subsys_removed
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ ! "${ns}" = "" ]]; then
+		echo "found ns after delayed removal"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Part b: Ensure writes for an intermittent disconnect are successful.
+	#	  During an intermittent disconnect, any reads or writes
+	#	  queued should succeed after a path returns.
+	#	  Also ensure module refcount behaviour is as expected, as
+	#	  above.
+	_nvme_connect_subsys
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	refcnt_orig=$(_module_use_count nvme_core)
+	echo 5 > "/sys/block/${ns}/delayed_removal_secs"
+	_nvme_disconnect_ctrl_sync "${nvmedev}" "${def_subsysnqn}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	if [[ "${ns}" = "" ]]; then
+		echo "could not find ns after disconnect"
+	fi
+	_delayed_nvme_reconnect_ctrl "${nvmedev}" &
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns" 4096)
+	if [ "$bytes_written" != 4096 ]; then
+		echo "could not write successfully with reconnect"
+	fi
+	if ! _nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
+		echo "subsystem did not return"
+	fi
+	refcnt=$(_module_use_count nvme_core)
+	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+		echo "module refcount not as original"
+	fi
+
+	# Final tidy-up
+	echo 0 > "/sys/block/${ns}/delayed_removal_secs"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/068.out b/tests/nvme/068.out
new file mode 100644
index 0000000..b913d19
--- /dev/null
+++ b/tests/nvme/068.out
@@ -0,0 +1,3 @@
+Running nvme/068
+pwrite: Input/output error
+Test complete
-- 
2.43.5


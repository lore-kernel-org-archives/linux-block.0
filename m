Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2540344031
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054973; cv=fail; b=XzHCr/BD3Es70JCAZLhN2mTR4zp0lc1YxjNCQ29EEYkMPL/b4T6n/KqQ6nI4/l1b7fBB4eHL8c08/Y7gLTXHUmkWEyRrXk4qsN/GlIdir/BbCkzOnue63N8hD75PFD8Xo98wqHYDyJqwVz2SAIL3cVRyZBQj9cf4CiSMSc+1Sd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054973; c=relaxed/simple;
	bh=elBW546rMibSQ+xl7tOrBiSQCar5NRA+lvplIkW5jZo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MYkMA88Z0vv3mzTiUo1OKqxThfajEj0kqT4OnLt3Irgki6PTGSy/odA4Tw5C0RpE/bnCvCcVIAK9BT8Kj0CizkdhR26hVAsSaJgR6WfjgQMIBN/1gYNbjMB5tK09AThwzyG8EETka2Ad1Rm0iEvQ7xa4CRgZdktyjlJqlAIaRRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xwsl7hKT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XC7GVSpD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xwsl7hKT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XC7GVSpD"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I9YQ3G1702955;
	Tue, 18 Aug 2026 12:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=f6cCk3P6dlQdVFmp
	A7OI4imTnhc2YXG7E0hEbvORuFo=; b=Xwsl7hKT6bGmclkEJHyd7Gm35m2pY60r
	a1mVuhJJkCEQHz/qw9a+KX+WeG2zpLaNbwu8rG36KN1LsJNqD4QQ/akEDltHEH6M
	7a4VkGTC//KdVHeCXUyzUzYVPI2ui5+Vs5DX6/6XMp6uAI70TODuz9JVOrJZ22u+
	XH9m+NnSnytJuU1ZZQbj3s7q8rozVO4o/Mmgu4r8QFo9TURms4tjLV8Yb++2DRgR
	hZq+XAhAmlUW5Ro9RZtaCwkUl6J/DCmeamxpLzOI00EvZq9JhZCrGr+l5PluB+p8
	H0204yICGvxDj0JA4XsfyeajfHcK7nt+WlZCXF40uMpwwY1tgP+zeg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2g07mh40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:09:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67IC67p9039145;
	Tue, 18 Aug 2026 12:09:07 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hqpqjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 12:09:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSemyGWVBxcwQW+Ghhntd8JC4dFOfFCAxwPMFgentOg4L7kX1cqwVLI3+J+223nc7Ipuqo1bXMB+6SKpPPcOqvBCrdFazoy/DDV5g2f3kBlYUTfAiw2wSV14J+srYY/5pv+K3OccN8VFUhfEoA1gVVsvmy7uEnJCuQk2/bLgW3AXhr3OEwuvvmC9OC19tmdOueg1a8082OZdGQKebwx/AbkaUaKbXNuToprlqba7pfYnsfEinb141EvnKivhHgOO9QV/MkHaIDHKPdDv2XHhg278CNQl5QHqAWuYVkcuPYkWc2gtelZcKBFDLwJLMWiHfpqFQgmxWd2VRRD9Q59iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6cCk3P6dlQdVFmpA7OI4imTnhc2YXG7E0hEbvORuFo=;
 b=mzm+8R2f1hujhqonHYX5JweYfG7D0+TRrqE3Uo32sjmIVunjWCSAg4azgczVZF0y9xA7ei7DqrdZPxelVrjRF/AE/DvoPDDgMViJ8/qPuNrt/SYSOBxXuKh+DV7xENjks9vGs4THDsQltxCVT8k7cVBkDjMhoNHeWpGlwCR2TiELoSoki1GiZNpWsp8qRcKwczTvYn9Qbd3b6hXtG5SAH1hhIDffjY3EvGg9oMdDRYH0QBI6kYHBJ+/dswTnApI2Tn5Nv4CAnn+ZKRXJZWKqFj5sX+9VtLiXr/cHE7pcvYCDukz3pNVE7xrWpE/sI+krgEWpyYb+sRCpbo2HcThdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6cCk3P6dlQdVFmpA7OI4imTnhc2YXG7E0hEbvORuFo=;
 b=XC7GVSpDHGCY83Vrj8AXTYwI5tCoguMfgn0Ynn7rXCi8ocrpfHzlhZoaqN8QGFgWTLQ400ij5KDd13eX4av+vZbr24uiVncGwoEh1sa90YHfj3sk1HLYgxQ9jOt8mcyjQZD6DKpUW4qXehBx6yqTq/hahaotdrotyOUD0PiSnCg=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 EAYPR10MB997949.namprd10.prod.outlook.com (2603:10b6:303:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:09:03 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:09:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v2 0/2] fix NVMe multipath partition diskstats
Date: Tue, 18 Aug 2026 12:08:52 +0000
Message-ID: <20260818120854.3151628-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::14) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|EAYPR10MB997949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cab4aa3-3326-4da2-5ff3-08defd217eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	6eKwd5jvM30ASls4geqcXORd7w6VoNKdM7GqEmd6MgQ4QpSDff/to7tNocrs0TUC9dZP15buZO/yCXZtVih043Z35ck/Hgma1u5KHPqTfo/KxnxKdI0Q4HBFjIcZi9OHSsRaA2p0+jBlN/BWqM8+GSn4iCw0Wwiszaq00kY0bUAvLene5ln8crHVpnve0Fc/Qc+Nq+ZITGPtZseLQMENir2dydcx99VEhjKYQbsGNGk4HFjC+giBIar6TtguVo89NH4r5iJD7GPnR8VJYtxP7OUYWvlZZNGta/j7NUVHoJgsiGTEqTzKRagBdry8GMOF6hQs6r0IFoeh6LSdjIAyHCBYczTyj1aWhwU3PyWY9qRcel74l9re+HUCl3WTJwO0C08lWvUhGHE8yYa0/UoriTSNeSPViifg90fgBJusAJgC2TVHplP5EFlrwx2isYhK4S2Kjohg6CeBvFm3iKJ9LNxlX7uo7IB+re7YFXN/DQvlVHkdURHudgwyKFIXwsA7Yz/70WjpNQBaAeSOosfVOIfvsKjhOq4GCeKl38Okyn7Nz+wZ70K8mQ9GwbsEhFuybRXyphaDD4EVFMXB6hEn7sYkzaEvljAuuOwveOElKV+1c7WqKiNGo81WcWyjGhor5eGj58eXsSCS6GiDLIdBC+mGnGotx8xRwVuqJpgTZRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABE47KTbX4r+n3Sn3fqnLPqHqJCu/aJwRpqjm3w/EiPv/eXHOD4WI4W7QE7d?=
 =?us-ascii?Q?zbwR4MmEYOZxhL95rpqEzVJ+eYO+GdroR5XPM6NpvERkeBjFKySCffNO+e7x?=
 =?us-ascii?Q?SmB2UwwjmrkLMnfHLumblBqRoNxIXTslqxQgKRkb1kApVG/e52R2EI6zSKLE?=
 =?us-ascii?Q?jcuOPyXz1r46eTIFlzPiyPS9Tf9zBlqq9SFEwPrmb2LlLrcxgb7oVayPRMwW?=
 =?us-ascii?Q?8Bw2a3xbWaFVoflMIelPDEQT+MO6mRx4rHYbmNLX6GbHdnQkR/t4Qg8/xQUU?=
 =?us-ascii?Q?QNEUfXTa320ANH0Qj23DJdjMLsWk2q2rmmWyLsdMz3AJT3O9OKHorGq+6npX?=
 =?us-ascii?Q?ne5cY4UHwWwt1i72YJxSgPlwP2SlV0M5R1RXuQBCJMEjtVim1wURTo36sd2f?=
 =?us-ascii?Q?qjAaHKXHNj+BfUza+TJzSLTi1DEscnFLmrRxOZFZBL3lKfztC2TEdT1MpLNN?=
 =?us-ascii?Q?1gdmkvyk/ZXMgWe1i63IxPJNfgQTrCv9ylAeJsQ+12MPzarzsMDsNMxl1hi1?=
 =?us-ascii?Q?5XSZ6RS6cDbbXt7F2+xaSlV/mrVixIjFAGzmoKKuYzv06e2yXAo82eSxhC1x?=
 =?us-ascii?Q?K/yjsAoKQPh+aGLJ1UGe2jQOYGPbOtNbkHbQIjxqbYZRWsECDJvZ10VFeUgX?=
 =?us-ascii?Q?gS1ScCxCmqsICGGXHwoc57EpQXNylI45YskeG5Q72RkIqFHeiBU6QRQTVHf6?=
 =?us-ascii?Q?Z74vef0bjjZv8L5hhzgw3k8CRJtoBaMYXgmIhGK7ywg4UaIDLwvE0KMwFJ+D?=
 =?us-ascii?Q?fTRA0A01IchvBJngcrrOibCdSUgODiaBxKX4gb0UqezOdYBAtLvhahQ0zYjj?=
 =?us-ascii?Q?Bk6vYNSOzPFjKFD6ksLodRBmt3uqhMukD9XsFYszLpmwqIMth8xPzPFoUnKH?=
 =?us-ascii?Q?JXsmIlQo6tdKs1Xf46IFM9iVoWVouF9IqOQy+m6g+lVE1OW93a7dyrQ76RzR?=
 =?us-ascii?Q?X0fFGrlE1C/9kqyZkGWP9Gpv2q7+Ia8JTZV1DixAHqCB36T23Rqvg8ccL0ZQ?=
 =?us-ascii?Q?4eZjvET3cmhJ4n1YF68o5ICyRJVh9sHUbhqyw+Vx6OOJrdzScZ7XmYBN1opg?=
 =?us-ascii?Q?4G2/bXnz8e9qE/QWUPHhujUMkeuLzea7BY8R2obrrZwhpq7qanYnqCaNjZ7u?=
 =?us-ascii?Q?NATKvGoHENP5nh3sjaqrMsTDXfKt+5UhVShquqirm+vyZ3oOnZj9ik33jZx2?=
 =?us-ascii?Q?RiFvMn4xNHKiFfkDoDtdoFbUAr3M8FRcWEu/b+5a6PsIUlvjpLJF05w/oZaB?=
 =?us-ascii?Q?dgV2+XNWlxdjTvsuCGWT2aF9xhnQ7RpK8AnZRk4kTrCHt5qbfuj+KEx1SPZR?=
 =?us-ascii?Q?MPLvg76hltpAJRne105ExxIdJAbLcsRKDkOEOUwUCJtG+crK7Zs3BlP1sG8j?=
 =?us-ascii?Q?H1ZbAYbtgClQwcolocG9IgZAEFstOXCcdS8d5lj7FzREsFKyaTbTIw2l3vBb?=
 =?us-ascii?Q?X+xq1Pw9o7Tn9otn31CD/+FWLBfcN7sflmidLgl3BtH61/MMbvbE/YjKLJYa?=
 =?us-ascii?Q?k0Shi+ylJ/5QGfDZhqNbcUla9RCRiJ+j66g1YFaMKwfRM4GDasy61/c+EVXw?=
 =?us-ascii?Q?Au0G8JGjZ/9NlGSCbi0Mn8F6xmYtWtF7Kw05VHDNsgY7fwzi1y0Ahw6mTR1a?=
 =?us-ascii?Q?nVOUMGG6f/qI9FXHSO3CkGCBMSacu9bPcWghn+Fx+2617dTAXulYSRTDvtaz?=
 =?us-ascii?Q?RPqi3GA0MKcaMuq8dfJhmUTAxXfTRtCxEuvPBjNLv6PCn+L4lcw9wSgUdZk9?=
 =?us-ascii?Q?CP/sOLEsXDjGmgJhXjI9SJr/uoe0xAY=3D?=
X-Exchange-RoutingPolicyChecked:
	YnNtgzGRWuClWF9Qy5OF8ed6yQBuCuPzmP7/2nCnDutLgrsVTrHsZWp40ewRqTvjH2oA66579Nj4fbuaNHXjFup/tcemHZ/Ck330QYJcye1OQWe9QXNjc+BZ8OnaGVfjqKLYhtUqwKs/+7HeXcW+RuiLGTJbDFVu9k0zR1vcdGUStG3sm0yeoBVXpNMIJPvVSyiLmokmftIUzWA/GIjhcPCDGgXiVacgdkXRy4zodYtJOhO2tfxraLfQszSppZ67E/szjqJzCbXg+LLSiQrv9h0auX3hyQLA6//mU0Th45fsoSUElRdiD39pYahloyehV0Z/LTdy9KqZ+8D6xb9aAA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pBvOnKpG9xA7Gzz/Waf6Cp6pGiHBRyg8WJg/l5M6odNVnY6xPCJboNWWCIaEGBJm0ovD8q9T5fjkbHenKAm13ubfGxJG/U6VGPUV6BGgP/YE9utjefvTdm5iJNNPb6JqIi8n6UcNscM47JdpzfQyZfQ4visW/sYAJ+cxyWkSs1rklKV216p0VtE7TJzK228VZQTQY9xVUd2fVRZdyVniSWwTvWV/TVi+X4gnXlT8fsK8T/l1RVUYvTqSvdmq72tVapIn6D14NR6KOZ7V8gGNQViFBa83ZESmZ+S0tbC65hCicC5SQLEvo930ge/Eyp45y0plq7rGkAvByc8Kssn2OMShyLPK1gFyyqpwDc4Cpfcxh55AsD+on7EMUt4lvFzTeUgv8x7MKeJDMMrAL+2ue7XlAikoUTUjf87cIKA1s0VkkhEw+lsjD59HLg+CJuIkwur1bwnLvM8BJFRbI3EGWL5F5R4VB+wfkPrsLQ7B7hxSwoZ4M9TpDIyyhrU2m1kf9tjj2VmQsKEyMU6sRBeVfNo9oaAHDUr73Uz9s7R5HED4qShchvId4qejobzCaOZrANIU5QvF51skH9+DTTHgMBNzsWHv8q2iZsZrNiWeXPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cab4aa3-3326-4da2-5ff3-08defd217eb2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:09:03.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B6aPp8AK7AxEvHdTBdEjhAmc22dVHi0pphxfUIxOwstAj+X6NuZeM0g8C3Yu5MrsVm5z/W3J2by2xlwvDun9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608180089
X-Proofpoint-GUID: wKvDDZaVbnt3V_RE-besmg-dmjDP7zg5
X-Authority-Analysis: v=2.4 cv=Hu9G3UTS c=1 sm=1 tr=0 ts=6a844b65 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HIHkP1-6fSMB_94SzQkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12099
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX5qQ5bVvHEr9u
 GtXYmSus/dP1S7+Y9tTqn6n6hbp3TUYoM2w5nXmC2IVgqKlrWrt/B3K2JF6clM9HZGWZYomO7It
 /TWKrhNi1MAa3FL86jUmhD+ZHOx4wr3c8uKx6n8DGjeaLMI921M+
X-Proofpoint-ORIG-GUID: wKvDDZaVbnt3V_RE-besmg-dmjDP7zg5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfXxY+ogqsNe8Ee
 47gzh92AL6vWNfsJgRwYQrCF8TP3zxgigrk9+QD+DEqJDbyOGDf1lBX6UV6vqILX1IQXlsC1tIZ
 xC+l8upZ30G25V9FprfjsNLEDeeVgqPBEUquIAmnxZRZaCoAc+Nk470idO6+qqnMc/9ms6f1xxZ
 j8Y1UOqb/bF7jFuAZyRDAKTFLrVrBT6vydNYliAIFeePAx16Rqd+xBOCUrEJ8/7MD/efoHEUFNo
 yEipb7A7RiF6fLz1ayf5001XVT7DcTrM/vxQMGcMnY5GNJHiR0mAD+dALP8m4GCCMUxUObzRMWc
 2a8qNIBLGJPBfN4XsqHPKUaQZh50Q+E4MW+u6ov2R03fRWCTN3eeRwg9dtxUOJ/2T/bcZ6dmUqA
 zYPOITA7NTkk7OuXTpDhBH5Mwf2wrLPiqEo8TNk2ZiaKSUNS0kB2vNGyLEgvqJPTiNotIQzu1Vr
 J3ZDdHdAUgqkLyjWtPfgxv0FPzTiNjFL4o+MPgrw=

Currently the NVMe multipath partition diskstats are not maintained.
This is because the functionality to update the diskstats only updates
for the whole disk (and not per partition).

As an example:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

Notice how all values are 0 for nvme1n1p1.

This series addressed that problem by first updating the gendisk code to
create the partition table for hidden disks, as suggested by Keith.

Secondly the NVMe multipath functionality to handle the diskstats is
modified to handle the gendisk partition, by looking up this partition
from the per-path disk partition.

Original RFC is at the following:
https://lore.kernel.org/linux-nvme/20260721114553.1657841-1-john.g.garry@oracle.com/

John Garry (2):
  block: scan partitions for hidden disks
  nvme-multipath: fix diskstats for partitions

 block/genhd.c                 | 20 ++++++++++----------
 block/partitions/core.c       |  5 +++--
 drivers/nvme/host/core.c      |  4 ----
 drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++------
 include/linux/blkdev.h        |  2 +-
 5 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.43.7


Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7041685C
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054975; cv=fail; b=GHzVsRP/+zlMdhUwSFWNpNFxZI5HVWMhOn/Coj4WX6VJUYri+1xs1HEnw3C0Lqaw/qIVidtsj7cWKzG8xGcG6OXBTOhfxOBLN8a7oKAqmh5ImEE8qzb6+ODf74YwPBVK8hND7FgXcJhHp/g+cBGfdNh78jVHUntPsfRkrnTbEu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054975; c=relaxed/simple;
	bh=H5Vj6RuxhLs71qPAaQSMpJfXtpd4mIQ6jchRLk3h6Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3f1OGl3m/QjkgaifgxGaGRJq+duoFbWCWEmfRbilMRVAnKFBt54a5PZmcEZuCwD6SPJMf7Km+oRYesytDuGkcCU7HfXPJmIA96vtBbebqtuuWX2ZA563LP+A7yFTTkHHnsOjWYu6Iv4e+tmZKiV46Lb0GIqxJd5PlD3k/R6sd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5ocFepe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c+JjzUgN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5ocFepe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c+JjzUgN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I9c7cc1408645;
	Tue, 18 Aug 2026 12:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JhwBAz/lBw+ekSq0ZCJFs2BtxoetfGF2SI1nF0s9S7g=; b=
	H5ocFepeltXUlnzwt1WtVsCzGM8R0DLr50uiytjJYHHfZmI3lOADJbPdrEzI0MP8
	7H6m7O6YL0YPHzY79g8yZTp14FcKEWRPX4mt3pUFV8lEKXb1a9cTsk9kxoIoF6W0
	iYPbmoSubhcGkTUXCIhCFEgg1KvHk7/b4EE8ghUfozrZnjpKaYR15eDPUfo95O4g
	gCpLmNHy351il4nuqET3SSzwSaNtGcM68O7D88lXwRh2BO4quDninragYZDaT6Xq
	J71G1NCJfuv5cCJAB8V3vVboxkjHPy7RPkUXphl6ZPDQBabu+1DHs5vIFTgrI3Ee
	759g60sQQ8Q7FzqmzINDGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2fquvmen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:09:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67IC67pB039145;
	Tue, 18 Aug 2026 12:09:08 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hqpqjv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 12:09:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZTBlxUvCafqX7jZsuoXxQSw4MwCwJbhpVsbYtLCKFmLjIDLaAM9At7xm71ngSCdCJcMuVwAGogjA0FDFm7jDOdAv4bqbCkM3gW3gs4KvcmJbyvw/ZkakB9KYBnae4rcOYcTLal3T4C3/k9nFJ7v8sS493JUNmB4sxkuy+4tq9ms+W1ibnTShB3F1vqhkyXdJOGOY8q1FgXnts9lePIQXxLlNgJ2TNJxnlI+Z37gxv+89C4rjhTidaNp0c9QoNEPFaZE7AsdonKrK+vVK9bVzARroAT9Lq6wJzTMxgRgqsB0LviiOmdFQcHUuhYsccDri8GCPX8qDNsGqkq+auMGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhwBAz/lBw+ekSq0ZCJFs2BtxoetfGF2SI1nF0s9S7g=;
 b=n0op6juMYg1+Lev7RUq0qludyayKprucTQQV/Tl9foITbu8xm8uniU2Eqs8Lpps6FFGldGg/OKJGhtmamSHZ4q5Pjro9TCMPAOe6cqdUqnALzd5tniSskCN7IWQQroNQ0+5tl72PSxrv3CsCHVBaT1tDjTccqmlPVsePy2uGuEP4CkPzZrbVNy7NlXvaaEA+iJ971w6or1UoRAzbIqMuA0DSIpMJD9i5Gbiwb8bSOyBoVBog8fr4MMSPkXHnVC4Q1DvHEB98sbByr17WehiACrrsGFR8yrOe+Gf4jPBOsJp8q+uvHO5qBr1Qh9kKBEWADT7gTV4l8VvxWmYco1/Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhwBAz/lBw+ekSq0ZCJFs2BtxoetfGF2SI1nF0s9S7g=;
 b=c+JjzUgNiHxVUtfAfpCLp1NiZjpip0WcvlbogneYAUTR1AyIacfhzz6OYYfXjzsfMG7bwwEq0rDg6QazShexsOMkk/v4Ngf8CJDZEdSUlmvlI9n7C7+83Vx8tP0mgLYND9Dn7V4fgfMwpOen7stYXb380kJ/EjCEV/ArLydblWw=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 EAYPR10MB997949.namprd10.prod.outlook.com (2603:10b6:303:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:09:05 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:09:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
Date: Tue, 18 Aug 2026 12:08:53 +0000
Message-ID: <20260818120854.3151628-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260818120854.3151628-1-john.g.garry@oracle.com>
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:510:324::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|EAYPR10MB997949:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ace075-e0cb-4727-cdec-08defd217ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|5023799004|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	2Vn5pFYkkmIkP5NuwUtQFX+hpIEgYqQlWA3Gt/QCkkyQaSOX4/JXk9AO8XEAnGOcLsnC6j9vtVotdng6xHKjPd3uODHhiBMXdKb93QfdAW2OqYVmd7fw9PgjSM6eqqFRrO+Fdymn7QHIRyF9/DXU1iWBqdBNIRsltCHzgF9M6BktPwraNB10lADLUZkqS4AI+SlDp1IhI34s0YGeiJlmUl+qlvHFeXhHcb8nP3CDiV4sFbbm7MlO36DUTkpGDnw18/KmUra6VIorOeWiZ+TicbtGigK0Q+L5W7hme9RkGFjqJ7TgPezdO1ZU8jXTL03WmI+f3cSOriEckU7MNjCF1hSrTtIghIl9rlF5zerhZCPC1XFgS3fGrKerp0ab970EbLLGI3naxlsp+FszOuCJHNBNrpxtGdHM/NhmQGTMX8GoN7HLlzFY7VdwHWvr601fEMhifR94JuHQHF4ECIAmgLoX0hHMMsGJjTvgtA7TgL3In4FJFJCn4kfquKDdIuGAEwx09fCtCjLV6C/wgr9ah/u0K0pdU5Ppv9HNd2CTHzQerkjLq9q8sUXF6tsF6qLlGM9IqOwi5LtHqHDtgULQol4XB5NWT/ySUSLSB1IwKG5d5AYxQuEkchldp//CXtH+cG2C9WbmtCmJwD0nvq/qSvSl/tb6EUbHivjC217PyUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOV7joUT4IHz4fLr/N8CxR5WY6Wzqun5YeKMxcQm/htenGe4GkKSkrthJmab?=
 =?us-ascii?Q?5h6enwGLwXAA6OuyoNMissGN1W9YlIuY8zLAaEZQ65sy3qjMwJPcvedKF7ZK?=
 =?us-ascii?Q?+tfSvAbyKy8epc60l7UJ93K15dS6cclEXtzUdSSQT4A4A1kX40lT+dpv55qo?=
 =?us-ascii?Q?02hkfuOLDoBOtcDBRvtipuEy/o8cWXGWq145CPkgDZdj8BQvJKIABDLBCLXN?=
 =?us-ascii?Q?4fG5x9jVSgmNEr583ZYu5jqsjfEkbXJeR5ssy2ZxfL83LeG3YjCRCRRGhGR5?=
 =?us-ascii?Q?uEJDpucaWMBaAPOICuzOLrZ0lpOM5c/TwKyDBSoaEAVbbFJGA0wubYmVViHo?=
 =?us-ascii?Q?ScF+GTnJZA6uT2BVEksTEH0sYGNHacUg5mFaPS/sBkhzUwqInTTqKLSGeN8H?=
 =?us-ascii?Q?6gB8uERdMgEJ+VbAqNQ3d4dLcai0CoRa+KYg5ljgx8BomPYV1g9oR/G//Pnb?=
 =?us-ascii?Q?v6D2PnSltQI1yEAB6CirESBHTBp483LumuFO+TUGNhfVOgzwk6qwMroDyT50?=
 =?us-ascii?Q?nnTogV11nvMDeaxDVU62Ci7wXHOfz/OIsxhatE0q4Fao2uyRHzKqhbl8Tlkb?=
 =?us-ascii?Q?lPyaqH/8VSIgwhz+0v4barTuhQZ9oz29H6ZlCkW7BdQ28fPNg6mA6hSH3sHN?=
 =?us-ascii?Q?Uy5PXywpx9Sy4sWIeuho71GZfxMCaPl6+sBEhdfYQUaJZRLvFqcebTHJLaJB?=
 =?us-ascii?Q?MSTjPjigb59Z+4DBfiYvvoiTGdnNeDUhP9tPqf3pcTHDlLzrTBketJ4C9VS9?=
 =?us-ascii?Q?SoYYfatUHybNuahqRyrGk61EnAyeaCa0gxSAMRqrWM6FvNEbXiYIH2o0qSDe?=
 =?us-ascii?Q?A0GWbPitJ/LE24YhZ8DY1tQJ7VIwZBX1lc2DW6rfrfVgNDQt+Dfw2hL710WI?=
 =?us-ascii?Q?lXqVMQkjQoSBNb0VTPZoebmZbBlexv8wTsuCIqWoYbBRMODF8JVvAe2MRQAj?=
 =?us-ascii?Q?PIIgC91PfMiQSa1sy+tv4ruKww4DWfiWhqlpHwkgFiw3HDJ4rXBgNelcDFk6?=
 =?us-ascii?Q?yi0WcnkR4tWq0XW0667O5VQQzuJevXrBTd7zrjPn6ke0X8nqw/YoPG49d1nT?=
 =?us-ascii?Q?yoYo92x8Kh99tL/PGxaAgEU8aUrg2mEDrXr6TgDkEuG51CPRheLZQe+rKloM?=
 =?us-ascii?Q?MI3TAE5W1XoqCKis/PPJU+4InbPhMqfHgQj3J2jHhRbi/JOkCMttpbTFPoBP?=
 =?us-ascii?Q?l55ZW+VE3MAUo6eQpgI8IkkvsA/Ks27ucLFPUqUiMzsQ/JkQ6cvs4lOlhqEZ?=
 =?us-ascii?Q?S3bhOWaMur+yvgShdCZsaXLxL1JCg8quDrjs3e69Salu5xT2kTJOwToyCJ13?=
 =?us-ascii?Q?7XfYdf+FrJ6tKmoJGpUSc7ygG2jRxiX7iVfeckrgsXDgYwrrWOQxUWckI2UF?=
 =?us-ascii?Q?ngaOpuwPozw6X/RZgGMehDSWhZFxKBVWf9/n22f6hLdWTyJQDdSikWc2qI4h?=
 =?us-ascii?Q?Txbj6uB6OVvB7S5jPA5/LUj3tPhlyssrVcDmOTeWxxljvppKfLjpyfunqeER?=
 =?us-ascii?Q?TPFG1L2k7bKra5rTAgcHf0JggTRCVHBWtQ093DnUVjn4Fpp4Wnv2gDUhRWPu?=
 =?us-ascii?Q?uR+NrEYOLpzGy+KguD27ODHZCg51nJSIFUWGDDp+EHSinVO7yEkI4XNIulN8?=
 =?us-ascii?Q?iG1aphU9MCtrmIXo4pc1ZPtgz/ALJq8snUmiTzc1/rgHVEFPHkO9Pa3Fl9un?=
 =?us-ascii?Q?iV0OWmq3qrnZkLBxOI83KnDtSoQRX5n/j1Yo8EfKw71jVwMcgvMg3ny9eQBu?=
 =?us-ascii?Q?2l0GHvZydYBYYZ84niHohyHyqyUbtYQ=3D?=
X-Exchange-RoutingPolicyChecked:
	mCUH8Cyk73m1/PhwZd/4eKpdPh1VMMpLMPiuSaJbq4dFFCO2xO40XZ5DlZM932Sh6kay01WJJtrV0kePTqW193j+Wh6xTqDOzVwM5M23sFdR/CxNLIMMTbyRr1b4VbZg9LPcjpqh7/lyFnIG1+pzmUCA/rhCq1AzznKyxIcNTvJeTvbeax3n3mF7wBiQrYWVAljzOtG+Mwa/iqkWifqBxF0xS4tCy+YlZuHv2VK8V3o5M+2BEf+yFG5rSLu1YofSgk93z4h0vqat1mpbU2mb5/YWM89vwxdm1PzM5VUbVYWOxBXogCWOZWZ3xrzHQru0X7VFIm/4VglC0jDYUy8Yhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5vUnp6iy1ZshgvaAMnCV7qYb/eWQi3wIQJ2LeYn+nSeJ1kwN3daHpF6+C0+emr40g7X5eDCctSZduBTKLomrQH5cWsCcCRXkfbsvr+ZNMOBlVX/9X5+EJfGNnRQpOsYBl/uIYUAxCK77xFfMA8gaSzgmIBmqUeGMOjf6LZikOTKfZm/zE9q/3rtCKK6EC+6o0VrbGO7GTjzhJXA3dXWN3y5+I0xVJjF8aqThLapasWRojKjTmg0p/Y82lf+zHzzVns51W+3RzfwIB88SBtGKhKPyzq0dZQOv8XoKkvNzfme168HngnO8YArvDIZ9ajUgcUk8JBRc/vWMqkBhlVHB2NkXm71CTQRx04q7yDEdYrRHrOOUQiRfMU7GEVetj83AOZUFmPvmunI2yAb2X1EpSovMBOlZttpx7ukhDjID2VY+4h7tyWoISJ2D+4mwNrOLHp2z9uEX/VaeVt2zCAveiojOsta3maDVeMjLQcaJwgfyEzefvXrVYk9rnXKIMbhNBJ1wa2iSVDMjAY5DXrSIlFXwrHwLJfaF+LFQTMWWBqdKFa9bg/Pu+JqhFtPshsbXnZ80WTK3bHbUibsh6/t7GeaDU3REgDI5YUuGp62LP4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ace075-e0cb-4727-cdec-08defd217ff8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:09:05.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ8mEC7V9SSnUpoCz3ItkvZTg7dbv8L8z3t29zLwiWvHKqgcA3QWXZ3r/7jOzDXLtH+RuYMoqZ3u09V3EuakIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608180089
X-Authority-Analysis: v=2.4 cv=W6YIkxWk c=1 sm=1 tr=0 ts=6a844b65 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=S6uqhoeQNADX7yJJGfgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12099
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX0yY+a2fwfdKw
 JtrJ2c5rye6bYIXWqKd2YjaiFjM71gAZHIQN+S52BOWAn2tj7Rn1Jv3v3oa4Erz6/0GpTQRO5lh
 FUb2g/YODqzu7tGdOIk+AyI6WEjKTdVvnIsbRU4do/E60ILs4XMD
X-Proofpoint-ORIG-GUID: DyKafOExWqZzhe8QiGncrex3JdU9inga
X-Proofpoint-GUID: DyKafOExWqZzhe8QiGncrex3JdU9inga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX6Se5xmUEUcsZ
 oWnPSqW4nHOyJGoAZyiE8zYKMBa0iWvPRzWXvbz/Jmr85W8TNq3kzpQg0SEA018q/c6Niefi/Wi
 6nvXYvn2DHXSdD/9yyfyAT3Osnjxsv7Rhb7n5PV5scxYfQQw9rltA5CPE3JhfPCzpH3gCBQlysW
 Kpof8mJvNBytaJezQgseaEjpbbbA/v8qG/CV9Lync7DMR/NQ43Jlc4uhFaCepbSuVU7Pa7up6bV
 gpZkHj5vb05U+5XVI6Ovpgv83TalHcrUuUYwWYcxpINTs67EjBmlnmSMgOyhpHNw7cijmOjDUbB
 FtJc02nLme0bApU56s8xh2/bFHNxWfJ/4RiBW6hK2xANcSFq95MsZ6I75qsgWaSP9/t58Uq6BKV
 4wfEJcNDYnIuj/bE65zpNMZYoOqAOfBerNHnPftQ6aPTaFpZTZFJ94POdkQhOVhPgV2OERqih6l
 eAeXwK4op1B+alyyfjBb5uls2UQhfth5or3oMLTA=

From: John Garry <john.garry@linux.dev>

If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not scan
the disk partition table.

GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
disk.

However, it would be useful there to actually have the per-path disk
partition table available for situations where we want to send bios to
a specific per-path disk partition.

Change GENHD_FL_HIDDEN to scan partitions. For anyone wanting to avoid
scanning the partition, flag GENHD_FL_NO_PART can still be used.

In diskstats_show(), don't show per-path partitions as this info is not
too interesting and can just bloat the output.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/genhd.c            | 20 ++++++++++----------
 block/partitions/core.c  |  5 +++--
 drivers/nvme/host/core.c |  4 ----
 include/linux/blkdev.h   |  2 +-
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 30ac0ffe65174..05301ee5d4ca5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -406,15 +406,15 @@ static void add_disk_final(struct gendisk *disk)
 {
 	struct device *ddev = disk_to_dev(disk);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && disk_has_partscan(disk))
-			set_bit(GD_NEED_PART_SCAN, &disk->state);
+	/* Make sure the first partition scan will be proceed */
+	if (get_capacity(disk) && disk_has_partscan(disk))
+		set_bit(GD_NEED_PART_SCAN, &disk->state);
 
-		bdev_add(disk->part0, ddev->devt);
-		if (get_capacity(disk))
-			disk_scan_partitions(disk, BLK_OPEN_READ);
+	bdev_add(disk->part0, ddev->devt);
+	if (get_capacity(disk))
+		disk_scan_partitions(disk, BLK_OPEN_READ);
 
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		/*
 		 * Announce the disk and partitions after all partitions are
 		 * created. (for hidden disks uevents remain suppressed forever)
@@ -491,8 +491,7 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 	dev_set_name(ddev, "%s", disk->disk_name);
 	if (fwnode)
 		device_set_node(ddev, fwnode);
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		ddev->devt = MKDEV(disk->major, disk->first_minor);
+	ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
 	if (ret)
 		goto out_free_ext_minor;
@@ -1368,7 +1367,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&gp->part_tbl, idx, hd) {
-		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
+		if (bdev_is_partition(hd) &&
+		    (!bdev_nr_sectors(hd) ||(gp->flags & GENHD_FL_HIDDEN)))
 			continue;
 
 		inflight = bdev_count_inflight(hd);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cb..a48896c6c791d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -152,7 +152,8 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 
 	}
 	if (res > 0) {
-		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
+		if (!(hd->flags & GENHD_FL_HIDDEN))
+			printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
 
 		kfree(state->pp_buf.buffer);
 		return state;
@@ -164,7 +165,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	 */
 	if (err)
 		res = err;
-	if (res) {
+	if (res && !(hd->flags & GENHD_FL_HIDDEN)) {
 		seq_buf_puts(&state->pp_buf,
 			     " unable to read partition table\n");
 		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb8..ed21f4ef36c9a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1808,10 +1808,6 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 
 static int nvme_ns_open(struct nvme_ns *ns)
 {
-
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
-		goto fail;
 	if (!nvme_get_ns(ns))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95a..a270cf1394c7a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -260,7 +260,7 @@ static inline unsigned int disk_openers(struct gendisk *disk)
  */
 static inline bool disk_has_partscan(struct gendisk *disk)
 {
-	return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
+	return !(disk->flags & GENHD_FL_NO_PART) &&
 		!test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 }
 
-- 
2.43.7


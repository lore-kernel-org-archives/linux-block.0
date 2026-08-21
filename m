Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D93ACEE2
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302145; cv=fail; b=jTd2EAc+oJCUGvdUUADVBTfBzQhB2//4aQpkI/KVOdhH2I+LcbnU7zEflU5NcPG5I5mUeET8p2qPih2H93JTqvTWDsf8F3Z/F+SuLA0U2F8TdIPZySVvcefIuZHwuc0Dun223V8VkdB+5qJ3ThywxIQWa+6wZUWymPrQ+1/JdMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302145; c=relaxed/simple;
	bh=UAdwSCK16k4htOaa+0JV1R0eYgCJfSD1K8BPC+RpPyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8RTLwAwWEyXStZq1cBKSS1SnnxgVuk0kwVNWXXVN9IO2B7QtUl495rr8ennJC+IAtN/9mO0HS8gJwHi64cVk3cwtGa63Z9JQOsglMoL1BskVA5k7fLQHzNgXZf6AaG9B/nr54Jj73d4TP3L71n3kj5UM4wh0kpa7e+wNvECa60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I9yJuz+y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oPEyqKuY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I9yJuz+y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oPEyqKuY"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L2AbtK4191359;
	Fri, 21 Aug 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DhSGlenLhVbEUBW1IaqgJGbk5ae/Qbku1r9hdvth0qc=; b=
	I9yJuz+yoPHCLv+OB4fCHZRO39hRVhatv9TGDvFDfPaZ+sG2L7+fv/N9sO7ptrpl
	fx7lbJyMVyywigEgtPlkNGRbR0j3DWtVGkxwRF5T4qrmNUhAKnetYD3csUyWhotK
	lmVtiITBuoq17RgzwR1jOoU/tFwenJIL1D4/NS+ujipB01CnQQR3zWJQBcM2rr9k
	NdQnsf2xcOvMX6BlCeK16QjskYblfmcdnAX2lftj5aQwFpYe3QQBo1oxeEZt1SgM
	5RTJRUAi5jHrEgem/bU+yPj+RsQzMJzxhIoisP7hHKqsxNYAzTK0qBUtBpb1bTah
	1aDDsnP3daMYuqDrywxF6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydempm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:48:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8eUHM012153;
	Fri, 21 Aug 2026 08:48:47 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2eju6vnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 08:48:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOV3MEuABvLtZ54pI9Uy4YgZO1OH2G6928u9NYvb6Vyo7UFBlIrpRoFqiaKbCwnCg07ABF+5cHVdgu02/EwBdtkRfNYy/MRlFz4yMVHCkgmV+fOvm5hCEs1ao9vzv1ZWgd7fT+qPYsvXR9llV11TzFIapm0buR3E8BUvqX3um9eaBIrf6xNiRrqSIBTBEtvldCQR/U2L08y9aBbeHLlO/oGHzyQMy6HJW0u6VbrripaZ70+adWKEiNaLJ11V4y2nv0DnQoCp40GdwBF0AAMuKdqUOoFQVbsqLsqiYjOMsfS+/5LLL9YCCCAxaPc0N2UyJbeZrpYjnhi2SXYu48OqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhSGlenLhVbEUBW1IaqgJGbk5ae/Qbku1r9hdvth0qc=;
 b=fsjG3cEeHPh4nMUnIbzDgWGvYRbBh49ksy7/WU8/BoQWpYQO8U2J1W0cxA3o8cZFQUsLH93sOOuGM0s16aLXPNpWUh9U3kF1KF75aHaaFLoxQmr7YzwRcuvrqMc4KUAmjXHFNqOJ2LYKdh7qtdociaWr0+hjSOnDN1C2X25zq2vH1zPJnQ+SaEHZE6456ZjoEhMYiR6JF31wen/RNwrDsiVW4qVfnT9BkacnWzE1lODkSDPcazotVF8ZTjmkplSrV62b55p3f1Zcib35yq7nLF7bFP2m7Rql6VyYuBXWdq6cdHsGy+DDNL7p015RWUK/JN/2tkpcKn0pz3U8udEl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhSGlenLhVbEUBW1IaqgJGbk5ae/Qbku1r9hdvth0qc=;
 b=oPEyqKuYFA9S62GkYrtfvOc4YGbSgaUqubSAqx2oIWCfZ6ufVKoKxaZFyXsrXI9yICcFLhNnjP2Wk4Q2RaZBgqWs891pK8Trv23X/KTHbmWdQdI6JhHVme7dJbVHWgSbWBVsk2LH3Bd6+KEcqMfuIMKeIOR12Jl/xX+OLg9ASW4=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM3PPFAA42ED99C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 08:48:44 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 08:48:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 1/3] block: support linking disks to clone partitions
Date: Fri, 21 Aug 2026 08:48:29 +0000
Message-ID: <20260821084831.4155943-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260821084831.4155943-1-john.g.garry@oracle.com>
References: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:510:323::20) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM3PPFAA42ED99C:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e7d5b7-97a4-4da8-6007-08deff6101cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|5023799004|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KTkMoQcm4WtMD9WEHqLn7RLTKUrncEnbbdrW4UUy4qUgaYCLaVTYtOZ312mV9en15CnwRSv0T0K9S2oBuudXdtBrxgLXCJHat2Tj51/sAqJJfnf5qfgWw+TAgS2Tg7ia+kOg9s46ahblXx9/lJrkeQpG1aHhbBgVVObQ7QgzW9ytFyeTIyk1R+PhkR8HFijIM7MOXiv8MM6bFCOQxDHHVkYAdQ/0n04+9l9Dt+4SyYhwFo43+mXzeLGxO9u5Hk/5/lq/Z1sPjybgRpSv2kIaBoE/p3BCrQQUJZLfbSZr+of8PjO0hnsxWhahVcNFZN7QT1BtIVpQITC4t7pRl/g1TwDgpcWOL79ZiRgZN8xSTGi5aGXDNsHAbDgy2qCHIgBpLs/Fklo9eRNsnMo/SgdD1cp7XHes2GqbuoPwdWOliTiqzfOfceEGc18qO/GsqzKD+STmou8Mj9RQVcNKxPvulrcAb+bNvVHHr2y3OugexxgsYSJ2Xj0OggTwFKm8jnhuhgePLrnbR8sffRmVl8JAyp9yG/dfS+kCzyR807XZx7FpD69IWzVF4oV5IoV+mK22ypHz1HK1QjoDM0O5UW45OXUuN5MZM4qjh4NNauvpmnxK0LyTRzZ2GimBEYD7gzfAexo/DrLLTxfkqqofdR7lDAZU6lv4ZnXr6UaLAeC5HmQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUYLfrqE49Hsp2CUu6TLRSC7o+K9t5iPbNP8qKDGX2LBooP0ZvlfeE1DIlTZ?=
 =?us-ascii?Q?TwcDnrkTRD4GwcDUhJAEKwUHH2nJBxMEnRmZYpgrhAbqIABJC/capGxy8Liv?=
 =?us-ascii?Q?fnDscd/fuS4qJCsbrcDf1Pu8qkeG+xkUlIYIBZoXUULovOnbkq1pyQirMgwr?=
 =?us-ascii?Q?VNhHGi+HOccGYJV6aFyUTZgXbIsHynSjCwWhvqc/gmpnLFMTcYm3Cpwm++jU?=
 =?us-ascii?Q?uf1YZ3yPVJmdY9XJ0hokOsGMFIKsew6fsojITzpfIXvtaKckZQw/Zhe8P2i7?=
 =?us-ascii?Q?Bm5OvNzKcy2I6Kf24lQmrrlrrt9IFIee10Nkg8z69xssUk6jyVhtesOaqOMR?=
 =?us-ascii?Q?+vefXWtju1JXwRqWDOcDsCEldSy12uRDxWZE/WS3LGr5dGoIkou0NUlQyjmu?=
 =?us-ascii?Q?1fd8oMgbyEHPXMPjBNust1l56kiwlG1ZDj7OY0CyaraJFhH/hpy7pxAY3Ki6?=
 =?us-ascii?Q?NGI5J68FXYh7a8GJNgKKbn95snrrBOCNai6PyewbmZ7x+P7MpULZWpLTjgk6?=
 =?us-ascii?Q?3mghIpgwb5Na5mWos7bRY0jtFHPNtji818g3GEqTmfBGFdW4+qT18MtDUe5W?=
 =?us-ascii?Q?OThcfgV8JNLA8/YFLkFv+9bWCkfzpEnqrE09MJtDYa1wtawJxAPU6OVRsHni?=
 =?us-ascii?Q?D7aAN5m/cuYoafEqTn0XQPr5BGMv30X9CjcxLRA3/kP5YSieIXv6X6wf6vEG?=
 =?us-ascii?Q?VfkQf70Q2J7Wq64qOktL4IMmwpiEPpt2Ud97/tj23GH/5vvsQqsVyf5HARF9?=
 =?us-ascii?Q?rYeKVRfRDDeuk/yxswW4SRt8o3xyKv98Hs5qQysQravkOUKw1jfpvJ5grYyt?=
 =?us-ascii?Q?pnpT0yeBxnO1iMSngQGdow5YG9Q4I4WPYP5G7gOcPXjHENKCkTam1XITRe7Y?=
 =?us-ascii?Q?/Jx/6pzEUDq1HD0Xv1sVpJrlT+UM60JJrQXgDoItzO0PsxXiMh4MMsGXgWLl?=
 =?us-ascii?Q?mQzFMdZ7Y/eFXC4Jkq1m4ITqSluKGrOzpSxrZUAkmH30bhxrka+O4YHqPu/r?=
 =?us-ascii?Q?5yN2I891qZI/D/RTkyUCrS6WXdnG10uyzlLWuAdt72fcxuqoeIYAOrrpfUdV?=
 =?us-ascii?Q?+XxAVGULyKep1bTKYeBC9c+J2FNwBqpdHce2RsKwzhRtJyWfZAWYJop0mxbQ?=
 =?us-ascii?Q?M/8zOmRiJs7TmYfSA1SBSTaidXKX+Lo/FbHv8GVhtqLLVbsptvQTSQqnzpTZ?=
 =?us-ascii?Q?sqAfFCZ9gEgb1VBqZRwkgxTNwidGRXg7TfoU2ydknRY68HmKw2ORI3crpM9h?=
 =?us-ascii?Q?nzVuADx05z4AulaEz+jXbyu/3fIxPz54J6htLmE3DntHVTYfIy/0muLnexMm?=
 =?us-ascii?Q?xulXwIiH896k8s8wc3OGljF0n6UcscDfboq2P8+F6Brj3vFwpABcFuKY55bY?=
 =?us-ascii?Q?TcrcRl5ybdZuJbi1jHyOlZVibyZn89dhALSdL2zlYFcvnTOuNBXaaexn2VoR?=
 =?us-ascii?Q?YXEMWqR5v7jayfC9AdHIt2FM3+jbjhbLlbD15BXmJJLQzvD/QrxCMyYXGgKh?=
 =?us-ascii?Q?KnqmawfNhPva4UnBBj1y1GeM0LVi5Hst2z2miaj/+M3gX3ZSbFI48/D5fHiR?=
 =?us-ascii?Q?0/MoHBWQ8A3zJEyt30aH9i76YAuI8E9BWRxpimqwSvxiUBPpCr9YjpDmd6KW?=
 =?us-ascii?Q?a4LCwtFsYl/kfZsu018z95VKt5IzLycfthKndf2osKKMG7OkG+NJ9TyPkcOM?=
 =?us-ascii?Q?nLzouM9t/cecV53DiwiB+5vaZGXPDjzd7EtoO6lj3yFggk4azat/Zm+WQgRC?=
 =?us-ascii?Q?9SnWncWTN7ElOm+X5ydp2J6JlzdVcCU=3D?=
X-Exchange-RoutingPolicyChecked:
	J89K5KoJeIrHWNc+37Zf8dhZ4n1TkGNAy4mvqlC0DsmYBw2AJ6NiRO4bxpttJF/oF+sqhRy0a0d+AEDZL1DAI0BEXKbZCPaPeOfCqpH8jEpOZLehACDLOeyuuNkc6xGZ+emrNHpuxqj0PTIGOT9LwcXFOZdSHFF078MDFh1X/j5XuhrCV0RB2A0XmM+bhI+tkU554FBRulmt9QazHdoPNuLhna33Li+PDfwj80IbKNAL8ZR2RyiHNKNKOpQoG75JB+gNdSIWp/trHdIaxd6YRMgp35CWrNBDppxOdKjvHNXLip13H7XctJYVe3M2q/x6bdQhAfyoHQbeg+2ie07dLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w4Dob5I8HDeQJr8+Rituu4r8IPbk8OKDEebferjVbuAJpz7M1RSvpR1AsPUmigE8upA8CtkeeyHBJm/BxnvO9F0qtLWrII0V6ZrWmkhW+7MVO6yqal8Jt23JOBFE82xCky/9JvVu1lv0SJ3FOzAUneLSkA0k98fXYEC+YgZjVWtqxkLTpNZbVoNQfTUIah0d+R8bY6DAAtE5YQFpTflQP07r9XAPzNnUND11JpbdQEsyN/O1cdR1e0hOXO1Vo7ODXFUhB1c4Js9dYYKo0zkfEIxgMc+yqLSk5KUvj+6Pm+gq1gMZV5paCpr4gFIMFO9DbW9o8g5qrolV5HaPMk557frqkJzxALjUNHGBBr2FPVUdFz6eHUQ87Mx3fxW7MPr0s4b8Hno2BEtJ0tnu/ufHUVvGBd/pBuc2L6Xc5pkJTBLY8YoovmY9cHxvoVjza+h0u6ypTG9Qz0au7TkZdWpKyVJicrqe5myZ41FwtmEPnSteikE/tpMwFPOFbXgHu7Sdf98+QvxE8+BkUSiRlD7zKrIk4A2mXoWoGEj55XuxR5c9HZ35ISVHAG0BKHzEZgQ8sTPGBP4b3KG20KZW7nJLUf/YhSQyzFF4/sdZyK76gDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7d5b7-97a4-4da8-6007-08deff6101cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:48:44.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3QCigw0ReOadylaQsngcHte85jdlNBJ3haINAykII3PSJgG9TlfmI7ZRRA4SmQX65q6dqb4NULJaobDYRuOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAA42ED99C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608210063
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfXw4IPtn4OKnM6
 3N8h8kDYyYBz5vdS/dFg1S+8Jg3cCDmfhAm1lO6lFX/ZaUH3aMo0b5oLCrkO1xJelHCE64EaYQY
 aAa3S+zesYyTscmbQ/YLmtv7azjJ1zw8YoKwiYMbGlPF2hKR/qOH
X-Proofpoint-GUID: RTHtFcj9jEW34BVHAdJ6uaxYeui4XfZ5
X-Proofpoint-ORIG-GUID: RTHtFcj9jEW34BVHAdJ6uaxYeui4XfZ5
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a8810f0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=Sj-9yVlXfOsMsFkmnDwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX60zgbju876IC
 HvPF0n/b5ALdKCJzqWiWHMp6HEPCe2jTediQTx9AHH20xUy3ro3XIV4jMStGjhuIoksxvATP0FR
 QDmnVEkpNkxonqVZ/KPvit5kWlI0Ac54IY6fFAjuAI48If/QJkTkY+yi1bup+a6m1MQDdgKHIqo
 0SB0ZXx6nuxJ55DEH3FUgawgg9X9zVpWaUF07Z3Jp/8HDsD2CSKrLxALk3LfJwFCg4aZxD/T0nD
 TlETHNMY3BJBv21gh5S11nwhc+PtKQdvxp29tMIordKn8oJ84fvu69em7ZNDqBkIwKpKVSKYbbY
 w5FExBK24xZZra0+ahwK5VspKD2hlV7gVC1XgYDkdlLEVy9O1YcarSh47tV1A1ZcAQh4oztHOOV
 7CLdRGkHdcPGUiGLEfOcqfjC1SQM3nYmFqPUTRNZ2cvvfqFDH2eEtOPXuc8dTrZGt+oUwS9ejl5
 rzV2c1qn69ioB2JiPoGQeE2eLYmkaVtMuULGbDTE=

From: John Garry <john.garry@linux.dev>

For NVMe multipath support, per-path gendisks have flag GENHD_FL_HIDDEN
set. This means that no partition scan we be run for those disks. However
the head disk will still have its partitions scanned.

Even though for hidden disks there is not partition scan, it can be useful
to have the partition table available. Such is a case for NVMe multipath
when we want to send bios to specific partitions.

Support allowing a disk to clone the partitions from a multipath head disk.
The head disk would be a mirror (of that same disk).

The head disk must keep track of the mirror disks, as if the partition
table for the head disk is updated, the partition table for the mirrors
must automatically be updated as well.

Similarly, the mirror must keep a reference to the head disk to allow
updating its partition table when that mirror disk is added.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk.h             |  1 +
 block/genhd.c           | 32 +++++++++++++++++++++++++++++
 block/partitions/core.c | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  8 ++++++++
 4 files changed, 86 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index fb95d3c58950c..9e9a0d3b9950d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -638,6 +638,7 @@ int bdev_del_partition(struct gendisk *disk, int partno);
 int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 void drop_partition(struct block_device *part);
+int bdev_clone_partitions(struct gendisk *disk);
 
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
diff --git a/block/genhd.c b/block/genhd.c
index 30ac0ffe65174..79cf26e8f5dbe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -423,6 +423,17 @@ static void add_disk_final(struct gendisk *disk)
 		disk_uevent(disk, KOBJ_ADD);
 	}
 
+	if (disk->head) {
+		int ret;
+
+		mutex_lock(&disk->head->open_mutex);
+		ret = bdev_clone_partitions(disk);
+		mutex_unlock(&disk->head->open_mutex);
+		if (ret)
+			dev_err(disk_to_dev(disk), "could not clone partitions (%d)\n",
+				ret);
+	}
+
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
 	disk_add_events(disk);
 	set_bit(GD_ADDED, &disk->state);
@@ -436,6 +447,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
+	if (disk->head && disk_has_partscan(disk))
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(bdev_nr_sectors(disk->part0) > BLK_DEV_MAX_SECTORS))
 		return -EINVAL;
 
@@ -712,6 +726,12 @@ static void __del_gendisk(struct gendisk *disk)
 		bdev_unhash(part);
 	mutex_unlock(&disk->open_mutex);
 
+	if (disk->head) {
+		mutex_lock(&disk->head->open_mutex);
+		hlist_del(&disk->mirror_node);
+		mutex_unlock(&disk->head->open_mutex);
+	}
+
 	/*
 	 * Tell the file system to write back all dirty data and shut down if
 	 * it hasn't been notified earlier.
@@ -1509,6 +1529,18 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	return NULL;
 }
 
+void disk_add_mirror(struct gendisk *head, struct gendisk *mirror)
+{
+	if (!head)
+		return;
+	WARN_ON_ONCE(test_bit(GD_ADDED, &mirror->state));
+	mirror->head = head;
+	mutex_lock(&head->open_mutex);
+	hlist_add_head(&mirror->mirror_node, &head->mirror_head);
+	mutex_unlock(&head->open_mutex);
+}
+EXPORT_SYMBOL_GPL(disk_add_mirror);
+
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
 		struct lock_class_key *lkclass)
 {
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cb..baf792becf699 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -644,6 +644,7 @@ static int blk_add_partitions(struct gendisk *disk)
 int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 {
 	struct block_device *part;
+	struct gendisk *mirror;
 	unsigned long idx;
 	int ret = 0;
 
@@ -703,6 +704,13 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 
+	hlist_for_each_entry(mirror, &disk->mirror_head,
+				mirror_node) {
+		ret = bdev_clone_partitions(mirror);
+		if (ret)
+			break;
+	}
+
 	return ret;
 }
 /*
@@ -711,6 +719,43 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
+int bdev_clone_partitions(struct gendisk *disk)
+{
+	struct block_device *part;
+	unsigned long idx;
+
+	if (!disk->head)
+		return -EINVAL;
+
+	mutex_lock(&disk->open_mutex);
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		/* Same as bdev_disk_changed() */
+		bdev_unhash(part);
+		WARN_ON_ONCE(atomic_read(&part->bd_openers));
+		invalidate_bdev(part);
+		drop_partition(part);
+	}
+
+	xa_for_each_start(&disk->head->part_tbl, idx, part, 1) {
+		struct block_device *part_added;
+
+		part_added = add_partition(disk, idx, part->bd_start_sect,
+					part->bd_nr_sectors, ADDPART_FLAG_NONE,
+					part->bd_meta_info);
+		if (IS_ERR(part_added)) {
+			if (PTR_ERR(part_added) != -ENXIO) {
+				dev_err(disk_to_dev(disk), "p%ld could not be added: %pe\n",
+				       idx, part_added);
+			}
+			mutex_unlock(&disk->open_mutex);
+			return PTR_ERR(part_added);
+		}
+	}
+	mutex_unlock(&disk->open_mutex);
+
+	return 0;
+}
+
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
 	struct address_space *mapping = state->disk->part0->bd_mapping;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95a..3a9502f5e22c6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -187,6 +187,13 @@ struct gendisk {
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	struct list_head slave_bdevs;
 #endif
+	union {
+		struct hlist_head mirror_head;
+		struct {
+			struct hlist_node mirror_node;
+			struct gendisk *head;
+		};
+	};
 	struct timer_rand_state *random;
 	struct disk_events *ev;
 
@@ -977,6 +984,7 @@ static inline unsigned int bdev_nr_zones(struct block_device *bdev)
 }
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
+void disk_add_mirror(struct gendisk *head, struct gendisk *mirror);
 
 void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
-- 
2.43.7


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B737C911
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302152; cv=fail; b=Zv4ToKsqntx6etQsNRakk8nYzN24ZYpM1mt9dHe2u7KIkusfKcD4JHpS0A7rUN579dnpWffbetZbUQDipXzh2YloiOob8pe8lM86sawWzC7YERg6TXzt0i1mTeRvmi/fOJ0nieUwRwk/1DzfmKMZh7yGa9Xxs5MTrlhItbyurhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302152; c=relaxed/simple;
	bh=Nkvxa5RegopOhCeG7Vr7FyfGs4k59dxFQoccasuPpRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4kOVhG8hr+rbASpB3t91T7JaPO7VMGUuRO1dx3iyk51qcbq58csUDQLUuif4Pb+qKAcCuLGUCkYI6iqOlsOujwfnwIsFL06tHV+76EQ5eHjhwkeE/u3T8/PgJs9oxSyF3ZgXCQMwpEAqnLbL58/HCYtGOtIdMVWPteAUjmMTU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHVT2zVI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PolJQaee; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHVT2zVI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PolJQaee"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L1R0Lh317148;
	Fri, 21 Aug 2026 08:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0dAQPhhD4p2bHJxewmZPYn3XWFWV6Z7mtECWwaufPIA=; b=
	MHVT2zVIzwhfnAw6e3hW8eSeYeR8TFgHPIASlCVS5ifcxRmeE83sohL4zA+OC0kB
	NZTr4hohK45Y9WW2d5xtRpxJhwoas9+FynoDwxkVwq+KgTJiT/BnIe6cHufozZHb
	Bciae2cgALYdGcVd8fribky2tG45PiqKlQj9yO0JrynQaXxV06fdalUQ7WGY4Uuu
	2flYs8T9oGq0BUcSADMJXOWZZEBZtRrdvfpP1xj0jMkaBieB/9IUfQXu+brLJxes
	/R2rPkpSox69o6lbUstLfZBwBSampmna8EGtQy1LqsbtUfTaOwb4St/xo1MEuT4y
	PeEbdJpXf8HFiZDCLPQHsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydgmp03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:48:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8eYPF012478;
	Fri, 21 Aug 2026 08:48:51 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2eju6vpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 08:48:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlXNmvFVaOvL+SoKLw2Yxue+58hXrMckqANnLa4aX93oKmhXkCik+AarTsarfLw3tHlLlLUxpPmqQJFI+Hl/PQhCLr1Hrf3QRlGDwGl72pX0EERhQ0NPd+PpJcS/KNwwbQgzmYh869gBzmdvzI1rMt6XejZpLu154PIq/QjTWKy6F3tJ7LzCmXG1vHLAWIlrCoMmjH1SaAfGXxNo4DkFklu0zLBkM61zmziOv4L3dOETVw88QQFI+y4ejmhw9RQCOQraiPKLzHeh7WV05RowmuE5ykafuh8Q4Y/6JYmfV6KpXnPW1c14s7A4mMZYclBOYnIvjqk13owQr8rkhI/beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dAQPhhD4p2bHJxewmZPYn3XWFWV6Z7mtECWwaufPIA=;
 b=LBkH3SdjbY/KNk35DgWVIb2j2HQl16mdiPzMUNITriOk+sNkRHm9d9WTyOmFhmAxRtvqTuNUXqpdF9PmkrhH0zGCBRD9M9NVlfrVfZ2lHRM3EkylvtpLOjorJwlDJMe6tt+kYFCgy+B0O/ibcdsDpaFyltMwaR3fqd/ldE+3neS/R9OsHfR4IqyK8xnQnyu8nl+zUzsuG9dbxBQ/Fb5/8Pu7CpWgbRGMij3yOQrQKhHzajJ6VA7kcEw24vtT43k0yyrhRWSUnqF63eh9e/vjXsbZqyfsdKhzyiWBwoMDagk/ncNGnQAbRQ1uOt8p6hYDELBPZ67cIlxt9PjoTUFL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dAQPhhD4p2bHJxewmZPYn3XWFWV6Z7mtECWwaufPIA=;
 b=PolJQaeeJ4sbr40QKknnBzsCL/390nn94IMwCSCSO7FS0tJl+dBYquvrs6ak7kF7cNa2rL83Wg8ReW4Efl0KTHVm6k4zRS3j/Zmmxq3W6KuR/+ekTVuXz0qth6dqnFOBEkF9CD7pDP+KWCw8RfNh5qQeFA4vRZBhJEz/TUFbsic=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DSWPR10MB997801.namprd10.prod.outlook.com (2603:10b6:8:36c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 08:48:48 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 08:48:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 3/3] nvme-multipath: fix diskstats for partitions
Date: Fri, 21 Aug 2026 08:48:31 +0000
Message-ID: <20260821084831.4155943-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260821084831.4155943-1-john.g.garry@oracle.com>
References: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::27) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DSWPR10MB997801:EE_
X-MS-Office365-Filtering-Correlation-Id: b587b745-e462-478b-9d9e-08deff610451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|5023799004|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FzneBYCHgCcKxwmKF0R3CXz9LMZO7oqM+0cj47nB6NsyIWzoBCN9lbYBS7sRkkbrQnxbxZKHn/4svGAFxmblBdcwBMdRr27vUvzKk7wdK0DxJhsLMwxfim/pEfUK1d9AiCBkldyw8DpiZyTvexhksQSoE0zg+Bjh+d42mUjq04jmbRvpzTvhii+bSh98WTmx/BLPjpPni1FkSDfg5vX3MukXpYOWu0lV0zV0quwbWqYN54x7JQ6emQV3nT5HEi6Uzzt+Auv021TrKlxQ6t44tiNblJcITJkg3qaPOJapF0F/mfxmg1+97u8Nc63eP+wOcICFQ/D8ppifFd8UeDCibEBhXJonJnjz3uV/aaKykY+HUDuQ7qyM5SDF4Cpe4sQwzLyc3EqZ4Aa00R+lKKqg7Qj00yeISRi80vTypKkFSCkPFzwC04T6C3eW0yFddRIHp2pbc2rwK0aCx7WEw37l3XLST3kfjdiV0wvxG3y22hw8mjyApkHSSJgmFG96sOVkkUgKK0fKIu7N8Bqe+R0p1OWV3kBzAuU6LE3dwQzLYez7E5cWlZmUsdT+9QlGzmnDNUnGbBkmhPCRjvLxgpC6A+4rPTCp8E07BbRr2/fPWiTqYIkSwFrBUiU2sPOmHdkBwcBB8HTvRUnkF9h3q8b2dIYryv9QMayhZXa4m2gWlBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhOEMo5Crs3G3bXt/PeetxEKVzxXSu9/DFbTNiIz6zFy2hXyMBTFU6vyYPlq?=
 =?us-ascii?Q?ZapMNNTns4SSqz1i/th+c64CAvPKivin60orMFJzWGqAhC10E2gbxwKJe08C?=
 =?us-ascii?Q?+yji6UcYC532Bl5JWAfjCU95adQOGqJeUcoLT+aTO/Ju/lf3bw+hMEn1axaa?=
 =?us-ascii?Q?7pGLFJJdlUy43XP6ndbrctvkaiaYDo07mn19oNsMlZ89droghhWfj/tNwxBN?=
 =?us-ascii?Q?04rYQ2fFznq+CIzubrWzpi9iVEE9X2T07vja+V4HOkT8nzOUZYYzm5gdzNJS?=
 =?us-ascii?Q?RcyN9f7OTRJv4bS7/hdPe6/UoLRw8jJx6S5os7u4eXZ8aCXhk7mr8N4Fjhxu?=
 =?us-ascii?Q?Sd0j/3wJFueYDOluRTHqBDNsPkNRzwKACvGR0ggJM+RbHM50L+NgWJxzE7a0?=
 =?us-ascii?Q?6cbzve0TjvCSrkg2AOX4byDrUI/qra3wDHDo6+Cw3XKq0LzuYaD5xHzEqf7Z?=
 =?us-ascii?Q?BIi9DibAzBPFttSSClKtmEkYZFARiBQ2tTJ4WAOZLbZoZpViBal6G5vkALVf?=
 =?us-ascii?Q?Ns+sT1OeWyfPp5Ge7hcxdJpZcL9ROHY9u6gKiViukHCkZluVR9CqxpfyLAlP?=
 =?us-ascii?Q?hTbaPBc5oDgOYYjAT83FzDWybnfbBlBL6ncXvvKfDYJPATWWBjCEWWBYnvyt?=
 =?us-ascii?Q?OOfNe28NxIDrjcyVz73tISd6SEO3q1cwmHYtrzhlNQnZjK0bdGGDD77Fq7Tt?=
 =?us-ascii?Q?VLsErTwjo/uD+voh2Kk6gessB+7IEh0lXPIYafHTwfk+bkc+izIPyqYHw+v0?=
 =?us-ascii?Q?Tbz0zwAKKh+JbQ6ITmU0VY8u27UgxFagb5VsvITn5uswNwKXpAbXnVxmsYqI?=
 =?us-ascii?Q?QxYlvrLHQ7LX8zyf34NxbbZYRCJbEG4HZQyM1EBEsBPk7QqAzhKxTyOhRJnr?=
 =?us-ascii?Q?2idbZIg9JlFFMOOBndPGSk2BujB3TfZIPw8iE2otx4b84cdDFoGToU/xjWZ6?=
 =?us-ascii?Q?elOOAQ4n70LgFLg200eOXKeR2O4ZHAC/x8qYItVfknKYRV1m/PfEPPgvLGq9?=
 =?us-ascii?Q?BWaVkgKtZXqBSkhlrFkOjcTMaxjEwWTdHViyZyBxFtpqpohDUFJWxfhHLhyt?=
 =?us-ascii?Q?qY3iqJIh9Xz83e+msg9Dv0W9XJgwjHik556gfGupGeQDU5S34GfOHsYHo1Pb?=
 =?us-ascii?Q?3MdJB9TjmYLOEtkLEhlHIFoWd46mhWB53iLLsS/xJeTSocmzUZc5iKJFcRON?=
 =?us-ascii?Q?6wvuHsQFsmpQG4ZSA6n8d5KcD+M+o1ayBfpK0Xyudb6zWWwokxU0lQb3/h+w?=
 =?us-ascii?Q?gltdj6plLX8/wCbLVNylzGWo8W3AKbR0HvtsnbnHfK551K7HULoBpjbhsE/w?=
 =?us-ascii?Q?/ivL6b82DFTfJ5FSIToBkSnImUEzAeH06pFPaIrNINPTOZ/trQBoMpQoowT8?=
 =?us-ascii?Q?6CkSBHleaWhAoGUvk0palIdz87suh8+u+DxrglAQa1Tw8dGVIOF27K2ARzQ0?=
 =?us-ascii?Q?4MN5ORCPt8OyqkPPkIolHDHIaQOJQ88ypG2vpWTlRnETj+GOuHtOCLGpf4ps?=
 =?us-ascii?Q?52cTneRP0hAbkShqls1fN9fpoBCFw1lGW2Lg1VeQbNEqVzg0C3JmVMMHSlXm?=
 =?us-ascii?Q?AiNNIt7i3XQH9JbWXOCQ8TXkzdr//pRQpPNQSo6J21VBJW7RvMVg0A88iHrG?=
 =?us-ascii?Q?5jn+kpAHxFHmlDb71UsQQrh5xLOCSktbXsKaeWADgWwK/QIBRtw6sI328F5S?=
 =?us-ascii?Q?5eJoDHorKsB66KUso2tMHcnhy8AftAPVizr4d2jG0DEyzCqZuwDpY+vQkx8o?=
 =?us-ascii?Q?sz6/R7VOkxPcyk2bqjacddjUvTgV2C8=3D?=
X-Exchange-RoutingPolicyChecked:
	JH/xKa1zospDAChR+u9k+Db+jpy+5MV6BacaNul2GuKK6H/2/c76aLIvOp5JWCrkCB1TOfa06GRuBg3r2aSFd9Rkadwcqymj+0jHDjEp9Z6V7+q+Kv009L00kPiKaAYCL677Z3faVKKm8yVd2qnu4cLZZMLjUdQoDlCqb84UpPJmusKO/nmHrhdib6dC+UnXClEfHAEuw5eN1LpjUdzVP4/EU/eAWPwGAzs/sSs0KGocet5eBDo3j9Ha8Cfyvozo0D/9eyzP5fWov+FRWcRANPPVX8oTunYmOAqRsqfIOlMS1b/SYK048V0XWSOF2NJeiBXaiPlJ5B1ZV7eZcUloNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NINeA9hwwDjwvmot4eXxgraDBe7fcx00W2688fjDlsI0k6j3yT+ogRjB2Fvc+UpiaPV5vN7inXZ/Kv+KfTCpaU+mwF+IVsqpyjigjfVYxcfPRTjHVrm9grPG2RqGf30B+bn7PC4BTXL3Hsy3AY78Lhc9V4EMuq4dHoHCuebQQ2JUG+gg+quB58Xvy4X0rpyTl8+dwq4YzHD2geWPlIkyMer1HEwVNtAs5sXYfOc5iAAdXsOcAZYFyZoJqIvsDhGS46X5QTADQ0dkn5xbsRhdkURgtXhz5K17aXCI70GtLXYy3+MUDdsrmQFSFsb4meZ7xmCnAXZJDEB9g5omEyRB6VG0yX4WN3qGnWyuwBAYiCz2LrJ8lDzZuw+SIrg40+7st9mxnDwdl4eutLOaAvRhH9o7xhGhwu/Eg/GLWNfT6Y2mb0BhvzWEcuHDMNWVrEblZtqNA6nA/4CcfvV4C0cwVn+YVStn4wgKgJNoLOkJWeDZIX5AYfIJGRG1zh0LDBhkQjgo6x7p15CHa+ZmrTgHWekKKK3bWX0YrHJU2N/QBo7lqoBNhic9Eti0ZXLbT0yFHEDqZZY7sMQH/5XZhm6RI3CkblCviTX48zzDmP8J84c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b587b745-e462-478b-9d9e-08deff610451
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:48:48.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Auyd29lVOes1nsOVmZR8y3kEc4KDPaAlEao3jH4oGrmce1Cng7t27hbasKSnpnBIu1Wo3RK0iX7Dx/RjRi1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608210063
X-Proofpoint-ORIG-GUID: EC4FDjRokRXGSeQXK-8yf2-EpEQYIBYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX2gRlRdmqJHvf
 x0z96s5fuYwMfg3AnaZROVZFha4lNZrN2iE4JoNa5lR6gfUg+3hGgYEuL9fh9meOhApGmMn5Aql
 aOh4IK992XV/7j+woUwraQgu6wduYzp8PqkWIfW0aDTkNTbRLS7OQHEPHvSDhriRudtH1cuH7pL
 /wF+C0IvqPU+kmYBUZT/9H1O9o/Xk98gXXyx0WYmvyd4Hy9Cx+KGwGQT5HqAuHe2ZDE8+zM96LR
 vwX2V7c3WvShaqlyZy+bdC/IGmGrnFXX7XMnYl1Lx8SDrtk62YoUHWAfck/iHbWCL/BwK6hj1wO
 cqitGwwd81CMv3DBAcua8qdVN77s1ytxadqXIclpfsYANjRMlw4P6bwJwl5zcWtzO7m87ag7ZaD
 I0jJ8OrPFHjFWJJeJEjNFbNvXe+RRCMg7FLAFMHNNoBgUakaqZKWFL5Q2dxpPDB8nbTf2J8LvBY
 O0pWcESBR9U1gmELdkpzeMKSEzIOcp7euUViG+zQ=
X-Proofpoint-GUID: EC4FDjRokRXGSeQXK-8yf2-EpEQYIBYJ
X-Authority-Analysis: v=2.4 cv=ZIDnX37b c=1 sm=1 tr=0 ts=6a8810f4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=JZfiM8t-Gqk9RkH-230A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfXwdN8bCEnUSZj
 Bj/wdRCAFSZgRn56oSMSAdH58hQZl6J51vGKBAieEXpT6WJEyNRglj65RojVO8GBwDrfgXdPpdS
 ZUusfeCrHXSBJ6tvoMa8jxKSyxGnTmfLzTAidfa8gr5sBVXfUaM6

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
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb8..b94b9a3bceb28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4273,6 +4273,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 			ctrl->instance, ns->head->instance);
 		disk->flags |= GENHD_FL_HIDDEN;
+		disk_add_mirror(ns->head->disk, ns->disk);
 	} else if (multipath) {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
 			ns->head->instance);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a32..bd4056f1a9f28 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -144,6 +144,23 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
+static struct block_device *nvme_disk_to_part(struct gendisk *disk,
+						u8 partno)
+{
+	/* Quick lookup for whole disk */
+	if (!partno)
+		return disk->part0;
+	return xa_load(&disk->part_tbl, partno);
+}
+
+static struct block_device *nvme_to_disk_part(struct gendisk *disk,
+					struct block_device *bdev)
+{
+	if (!bdev)
+		return disk->part0;
+	return nvme_disk_to_part(disk, bdev_partno(bdev));
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -165,8 +182,10 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
-		bio_set_dev(bio, ns->head->disk->part0);
+	for (bio = req->bio; bio; bio = bio->bi_next) {
+		bio_set_dev(bio, nvme_to_disk_part(ns->head->disk,
+				bio->bi_bdev));
+	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -194,8 +213,9 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
-						      jiffies);
+	nvme_req(rq)->start_time = bdev_start_io_acct(
+			nvme_to_disk_part(disk, rq->part),
+			req_op(rq), jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -208,7 +228,8 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
-	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+	bdev_end_io_acct(nvme_to_disk_part(ns->head->disk,
+			 rq->part), req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
 }
@@ -530,11 +551,21 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return nvme_mpath_queue_if_no_path(head);
 }
 
+static struct block_device *nvme_find_path_bdev(struct nvme_ns_head *head,
+						u8 partno)
+{
+	struct nvme_ns *ns = nvme_find_path(head);
+
+	if (!ns)
+		return NULL;
+	return nvme_disk_to_part(ns->disk, partno);
+}
+
 static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
-	struct nvme_ns *ns;
+	struct block_device *bdev;
 	int srcu_idx;
 
 	/*
@@ -547,9 +578,9 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
-	if (likely(ns)) {
-		bio_set_dev(bio, ns->disk->part0);
+	bdev = nvme_find_path_bdev(head, bdev_partno(bio->bi_bdev));
+	if (likely(bdev)) {
+		bio_set_dev(bio, bdev);
 		/*
 		 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
 		 * enters submit_bio_noacct() for the per-path device. The EOD
@@ -557,7 +588,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		 */
 		bio_set_flag(bio, BIO_REMAPPED);
 		bio->bi_opf |= REQ_NVME_MPATH;
-		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
+		trace_block_bio_remap(bio, disk_devt(head->disk),
 				      bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
-- 
2.43.7


Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008A48C8A1
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130970; cv=fail; b=fGjZHM1vh/1Tyg3GX6g/fpN5caUQ3EjLbcKQ6NGT1jdqf3+CLRjrSqKq6QZFohEG0hTqyl+sRYINZHmlUTUdpOWOVck/vMisWLeVuqlIerilLjhtyAwMVsCeogI2zR3oTBiKej/s2PZenY4SqovGYDqN+u30u11jqgBURiKUpBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130970; c=relaxed/simple;
	bh=Dxh3lDQfANx4Z0/a/8gH4cO41y/daX7zeFSB2UPMBtg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QtWkwWikiXHGAVDKzHyli+rIVSSzKqrgcgAgsRL2rneLy88ZEBIsbzX+v/SJc3tRR+1IaLEQ7HcOAv80+1c/xrEkC8FzSZ5fGcFOAO9o5gBle9xHmgDW0eqKwM5BxFnfgysEl2KI2l2TrZ2XUxokyREk+VYbtC9cNefI3IkUwwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDETbzZb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wdhXkHmG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDETbzZb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wdhXkHmG"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FEwu9i1169970;
	Wed, 15 Jul 2026 15:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dIJ5k8mldU3xHnBN
	nci9qZNHR53khsmQJ0xvA2ocT4s=; b=eDETbzZb7cHB9XaBJDYKPB5e0p7f+272
	O57u/t7e35TDBkOLhNwxrfMbSfZNFu3CWgnprSCXf/3qoI0eQ758Z9D+45OMRtEl
	avH982HZWKskYAnYmzfJQ7Q/MInB2OtuFAe/XmMbjxFyZsOSV+Oj28eMyDJLxlUL
	+JlGJGXMbBa/6gJ2ofRwSSDpd9xNCyWWg0ojUjfTGL3NZrtd7oJKwvfymswxyky6
	rv6+8POHXBhLJXtoluLyb5euLi5HD419leG1ZFbxgtBbXYZc+QufS2c1anmVl5kM
	yQBrVvC2j8GdEm5eRLdAYXBz96huJq4WAj1gheBqTGEtw/P1v7MWqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1py37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 15:55:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFr8re036099;
	Wed, 15 Jul 2026 15:55:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9f7a13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 15:55:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp5wruyGgZY1CGNOxMq/tuhgxBA1NfE91R8199q7wCr9fBQHYM4U8Q9g8j1XXbaj0Iz06ItGEwlSgjRY78tSzbHqwwd2ZWvgHgw0ZqOoY2MPjdjXl/9B0yipxFIpjgkxuar6bUfBpPkMcCpKD9gruPlv8fVxJtu6d7D5J566KQMk197M4QN8FQi2+Xdda9QTddvviFeoCwi1Y1Kwk1WYyCI6Kh/0eTvjyfuPfKgXxCUquj8fBMNQBC5/MVfQcMhLFI/9NvoSzDNlGmDPzjM6YXurUJIxL+rR+twi5VaGiRhys7/gn97QBhItnvFmc5HZarT/p3hIO274kQEGE0mtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIJ5k8mldU3xHnBNnci9qZNHR53khsmQJ0xvA2ocT4s=;
 b=Bu1WiXSVcM6xWziYcihk0kNi9qeyyDkQ9B/wn/8tW+o+I2C8VBap9AHjL35yIwT/W1nwNl0EgVN0chi/j/5w97KyZOhrOCPOmLGNfOJdNdF9asK540zFZJ1UbfO3krcd8dhluTiVnIvdDhpUHFuuFltjtYctiPYXGdiVuvU9LZAgj18dGjkDar6tzBR7hF3hvS39Jza1Z07sIBX8uG20WuN37k8WkKDh27++BJrVMWgbAdv9gfCM7q5ZQfug/WdAv67aK18Y1CTB4PAzBq79N14ffpjTnXMNIguwbMDH8QQ5Yb35tSAbbDpnYr8pJeG0HVzzeoATouAgxzu7poPC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIJ5k8mldU3xHnBNnci9qZNHR53khsmQJ0xvA2ocT4s=;
 b=wdhXkHmGLQ0VBK2lTgreu8J5yT71pCEaAcHU8X53yyW7a0J9HWJVCWMJ+jhxcg+P3NFL1YvjxQS+3sCp8mIRViSEjrwDerjzyToITVcVLgik9XhVYdR3iJALSNxbyEYJujZyVxyqwvc0HUqz1nP4298F+sBxFkwjtadyjaQhUuU=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DS4PPF94A902B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Wed, 15 Jul
 2026 15:55:37 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 15:55:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3] nvme/069: add a test for multipath cdev lifetime
Date: Wed, 15 Jul 2026 15:55:31 +0000
Message-ID: <20260715155531.3811457-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::7)
 To DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DS4PPF94A902B17:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f66e195-0209-4ce8-79b7-08dee289834d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ViaAC33Q9gb2/c6tiQt8GTj98AuoWu8pNoEU+i4PaDGBtvRx/aWvSXaSv1AczEMudXpQEdtvUPETB0PuwsJKLwD30IQ2nRvP30+xll0bZPH38QnNCKwUXRpN/qT7ccCEOoM4JuLyM6maTWZgazVksMG5t44ixdR4lQmTbgJKkeIF2lH/51vMe42Jghm0eanxqpu/MVWVik5WlPoBaWo1hlLa2IhmShKzVJI4C8uq3QLSxXyLsGvRYFQyaVHFe8Bh+jHijU4oF0xVkj8KQM/dIxDy144NfnIq7bH7LHvQ+GIclgiZlvfa0hEORqwyjSnQ1QtKkONfM0ku2YvLNbFoR4WAK2C7VmLGUNLfoexbNwR/dezMXauCYynJfNt3G84qv/IndpJ3K8lbZXSHJV/Bayuvq1kZSgy8kABDNa/GrOwvoMBN5rEtpuq+sn9wqNFyXZDoINroGd52GLhlUBV5wSM2G/aRRroj0Tl+s4F7QdwylpcpitJg8l0qjAqNMrruUAR+kyppup2mX43JB6zWuHS1Up4ls6l2sMR7u0jNFN78RMF6D6bCO87lMiKa12vBJbEuxBCtgNBW+s9SQ7mm6b/bP/IHCYlQVPALCcQtQ7gqkkKnN/3DYlyGTv1Vtllo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVsUezmn8l0IDUS5xBQ0ybiMyxNWCEpL5AbLmtEM7//9WQGOH+voHGagwswA?=
 =?us-ascii?Q?6cF3aMsQ7ChPeYNRniJU4kimc1NGKiL4qaShDfBh+OPX69fGmH/p8J+nMVXI?=
 =?us-ascii?Q?kCS5BXdUrx+CMkaFh3U3OP2PvTphQI3phMa41AytUuITjf/PNN/9NbFMW65o?=
 =?us-ascii?Q?lOBL9qJQLtQyYrlPBjGMLJsAZJ6IRphv5QhrKaDqNDtyCWIV5nK9E1Vgy9N2?=
 =?us-ascii?Q?0M7GszZeqcAYRWYfzEIINpTB/VmF3mKAEuK3ILkWXM4qU1x5fTYAmVa1+t8y?=
 =?us-ascii?Q?1AvHDAQNABofEECZskLoZe/8l2IJb4i0SlNT+Y8+1EEHYh5CaPxaJ+ub7vP8?=
 =?us-ascii?Q?poJS53cICrz25Fa/Qi4ZclinnAVVLgME7sIl5FglDfoebRLqeZ9ILxj88iQ0?=
 =?us-ascii?Q?2R+TmOJP4wlWIP1QpFDAHNzxNN8YqGtDkNsYuxJxRUVil4ilpkptfbm1a7YK?=
 =?us-ascii?Q?EN7QwSlLKX7jIXCodMTN88i622bm79N3bq5IGi6/9yFsr4sJI9TQZzjBnUlQ?=
 =?us-ascii?Q?yzdTre3c6lDjpm3B1ba8aO0RMjw8HcQHAsm+DbF/ozq4wttS5k5JvFuw95cW?=
 =?us-ascii?Q?9A4Lpbjszs2qWtc+YrQGMw7bXp08m/s3GQpJqoRtkHfUa9QpwsNMv+Fxmzbt?=
 =?us-ascii?Q?nbCc+MJThz3JR1xa/3O6HLSQ/sBdkIdblwAoKxUsROvlcjZDQV/580pPyPyb?=
 =?us-ascii?Q?n3/gBL0F0FaiS+Dex7ZJ9nj26V7UvNXlvY+VfLUOhyPpC6GSUqTcU4QPHZZk?=
 =?us-ascii?Q?C5gQjsk9FSyshb5wSLU0iemWH8dyT50hTVm9l8K45WLfThNSS8p1ynsvdxCZ?=
 =?us-ascii?Q?QjHlyXcRHONqQzpFTxXhbEsfiokfM1Wrkqo9EZJRO/tTbSMeI18g4Y7LscF/?=
 =?us-ascii?Q?SBSK8GGumE3zzP1XlrLn7iRm6rcoZCRM7ENVZHkPQRXAIlCPYwsL4r3Vwz40?=
 =?us-ascii?Q?Lcg3YQJlkQNTtzUp65bU9BWrfB5sXA1ZNiPasGzz/fUIJ0oYOyfo1kZXGK+k?=
 =?us-ascii?Q?0Qi4Pehnug5NhoWISHmkgcT6bH9BV3nEazL1jb1lYfmo93apqcrC8+denB5O?=
 =?us-ascii?Q?Z56cihWeZ1Pjw0AeGun7r/qhOR5cp6pU4mxCPycXlPcQEhavejkzBU7dVL2d?=
 =?us-ascii?Q?nfSdD6YHxJc9KV7N94CWbS7aTIHp5bX0AFreT6NRZIV9+8PPcPjIyu/rHWTh?=
 =?us-ascii?Q?ncoJlPmUWLpaUapazQIUV5sW2wYTQkC12cQEOizrr5PfueYk+F+7jg+I8r/u?=
 =?us-ascii?Q?8PAOeH3MIoO3SeEXiOj52qp8IMb59/GuAsAo0j3CSNgRPFEj8k483fKqyUN1?=
 =?us-ascii?Q?MoW4yCVUtoodqyXk3DhGVHdnZsrYrcD8dOeMKOIa3lQzeC/AorxG0ADbUPRO?=
 =?us-ascii?Q?+sGg54RNZg0dfLD1270kPblmtobhGbqhlsEOAfM2/DWaiYvBSXw2z8bMj2JX?=
 =?us-ascii?Q?K03pgIXm4v0grM6evy3nC33TWptCV4U1fb27E9ppnkldXgFZc1M1AS1b4N66?=
 =?us-ascii?Q?J9zoMCyFYj9kCCCSrxTt5EpKpPoRRaQ7npFLrF4nMSUjVeHNk5aHPfFHptEr?=
 =?us-ascii?Q?Zg+27xdWkH30vzNE+6aud1PG5nBNtugLuO8/GttYeF6S9NM4nL6/TUzoi3EH?=
 =?us-ascii?Q?Aa0xWT0SaOtsudqlyq/ivGJcVFkXPYYe+mAmhYmID8UUN7Uo4kKCyRAVsgGn?=
 =?us-ascii?Q?gNucm1Ez/NQPBePUV2DUwWMW01LcONx8nKIUfue4cuJOGDQybQxTj7P4D0Ak?=
 =?us-ascii?Q?6F0N4BoP8g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Sz7iS/FsQ7QXQtm1CZGh+8o8oJs4QDdGoDJY+xB7PVdFv+HU5EYC0ZFNLUPM0+opY8L2pI1/t2HbX+vxpYcxcVsKPkjBVzK8GlgUO5Me1+BZqTdiOFwd5Ox4H1XZQKHpSsc/RWBaJohw3fwz5igm/KidVBHcty6xRPjw8u/VWxeSmoXRkqzElfb3tEfEI6TJ+Ehh8fOZCC01HO/DyNzLQm5OPP77sXPQiPuZeYdFhPxQ+VV42FO+mWtwOWP9N1Fs/TeTiuShTxZi+sPwtjiW7jir9EptdrpHyFv1N/XRpO02PVOehXDNB2iwleVIBrum7RYGT2+EWGIL0F1pVS46pQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QcuRCVE4iYsDOiZPWOTgHY7ZsB7msx/5oPOScVmXUmHzCSnw8tBHTdckzOZmsXZyDEut1PeUzHnSStjWQyx8yt5qApmQIFAAjMyLbn2GdIUlXQPNsh6tWOdCa1zljBiWJ823ZDoSaz7dF2VSmb70p40IMIMUyXQ7Wi9pVjyL5NLyFsA3ZWaNPaLtZVS7KwMr7RUfFAIPZwVwb96RWmCOXmzF5UajOaOX8Q8j46P1gHePBgM1wJdKjqGpwszvm+6h3lkPjWDCSg0h2Vamr9mxFlXstEQs1WG/nt+5rrzdf14N6RAL1va3/2DEM0vC0u2uVZ6NJ0SMIqADSB+BvJZZcRgesmK56Dr4pltmFMr/ma9ILqbfnM7qRXPs3+fJH8DLHxJrsKp3DvLiEaSDFCP/KLoiirVaRqcI2cfAnqC41/ivBovUQ1p2YbbzIB/PEqVUiD2te2XcgPmFDxThDKsjiN1/FGe6qjSjDVrsTHp6ZvYc/k37m3glvN8NznEFflnFCH98Jwem/Xy+S45Wb/m25r4Em5LIngLjVu9AFgfbN44iMCQwgBFJxecwnsgVdU3pfWRZrMjqcHr/JIqBIrVn+f97oIZMsjc83Z700Qf4CNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f66e195-0209-4ce8-79b7-08dee289834d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:55:37.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIPqYTt1e8/xu+AVupE5xBARbh3x6U4bp9snsMEqsd/8uhNLwoBEnf0jZKkmEeRaLvfhUkrEt15lRx+iDrh7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF94A902B17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607150158
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a57ad87 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QOYSxItt2YxLaTtbhTcA:9
X-Proofpoint-GUID: w_Z7r2d_JZF6X9U98dAnkXIjvsaw8B60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1OCBTYWx0ZWRfXxZt2kkfh6+cV
 81PP+jpAwldHZbwQV4JjeUm7oXJAtBW42pt3yt6tBsIrDBGkgETQW4CaKY8+jzf85RJlKwYwW2n
 j79LyKPXrWaDqii/H8mklfA6494SQmzMPHbSzfnjsEYSDbb/0tN78eY6/lceJbo44jKhjOENKSx
 WdgCasCY7weTEQQsqdgL/QQ/nOjENJ0/F2Gn7VfYyFnWh5aBbvInAgdBP4Oiz0+7bs78/u5NB16
 inqV1iH1R/RyPtmT0Rk8x/OcH3vOsAH/nO26GBY8XPnzSZCfvkTmxHjKwjU0cP3sywlkmF+wfJk
 ysbgNpzKqz0cifNJ2hYUdOQw0uZs2uxrgwdBB0LabSV5svLB0aiGAJw7px+RsSO4Om+YgpmUTkB
 vDfYF9FUsXUhZDAh4PjSAF0dZduGCiQqzdEpo1bXO/duq7nDQAFaoPu1xWaUbK6sUA0zu5XQ0Z/
 oOV7RzLW6wTBwoUhubA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1OCBTYWx0ZWRfX4tzOrGo8g9K0
 URPYrHyWBtmS3SX7zDElmMdCIXaNL2+CK3HMnLTcx3zzZ5mRZ/qXr4hcmiLDiRQEgQesRK5WCXu
 mtKLGk4wi1k0FfuAdW7Cw64teHCGT1j3E77nM/ql9DIhai55eAc2
X-Proofpoint-ORIG-GUID: w_Z7r2d_JZF6X9U98dAnkXIjvsaw8B60

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

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Difference to v2:
- remove sleep and use signal to sync

Difference to v1:
- fix script formatting issues

diff --git a/common/nvme b/common/nvme
index 15e9c3f..902a33f 100644
--- a/common/nvme
+++ b/common/nvme
@@ -300,6 +300,26 @@ _nvme_wait_subsys_removed() {
 	done
 }
 
+_nvme_find_subsys_nvme_generic() {
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
index 0000000..854b702
--- /dev/null
+++ b/src/nvme-delay-ioctl.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-3.0+
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
index 0000000..89f048c
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
+	_setup_nvmet
+
+	local nvmedev
+	local loops=0
+	local quit=0
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
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
+	wait < <(jobs -p)
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


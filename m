Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF9188734
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529029; cv=fail; b=daIjzSTpaqeeq38U8HVhDVqbWYhGlaw5Tr2oEmHrJAqS8Fa7cRjHvjcyj1FAeHXla9kF2nS0QBPApW7jy5Rlz7xWkK13StObB6eIxLSN5jY2Rdjqs1ogICahlJ01ynKV4yyw4Kd+bDNw05rOkqO5RWcZmY9ouHzsViyuZYqB4Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529029; c=relaxed/simple;
	bh=uFpZUYmTgLdnTjoGj+gBQf5PQFkgunoQMesgC2C9Z7o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mk9KXcQ0Lg2skw6vHkZ9YI1bBzutdNpnmDfBq30zxWHYz5ddIJ0qfMPwBCqdiNQfpuRxFbqIq89NnTS96AVc8fjYR6d9ZaBtWzcmvVKfUnsgAw4TznRbe4LkakrTgQMSrAeQhOXzW8rFnFLNk/cB55ExGrEGNjttCjBQFrJqv98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEXEcUa4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFPQnwjm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEXEcUa4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFPQnwjm"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6g58d004811;
	Mon, 25 Nov 2024 10:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=+dKUhSU0Z8bTZIKc
	srUxfe0wvnM7Jp9WI834O3mK2Ak=; b=IEXEcUa4zsWj2DtFRCM/i+bMC0GG4NOh
	NExMz2/jbrGQguMXnXYfip2QW+/0sxDqA3sijT3ZsURpT0iYxfUudy2Fvx5cufIX
	TP3tniWLx7EugaeFwCjlVoQsPoWmKOrN1/EMzoG2WN/KtKC5scVdhluG9xrOWfFu
	uauJIt7K0IXg5Pv7zsxaV+4mcyRsSQXnOv6UcDRTmjW/lxQo4FQgdzfbHB4e9ajH
	DBDlvUgwYmREiJC8EqrqwyaedHg3jTvtaZ0+BUr5k3wSmORUdqUkdexikLk/J02D
	bDOUu2pR3X438zFPtuiFp6aQaVHlxkP+OURKsDTrCrg3DNy4o/+5iA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384gtsd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 10:03:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP93HUP019461;
	Mon, 25 Nov 2024 10:03:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gdsqg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 10:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tab4vEwascHMBd6dKRFJ4xN/q9Z+/+zX5DQTh1/LwCoMAQgKEnmIqq+Wod4ujmTNb6/ziS5MKg5yaRrefADekS/kztdZRTMok4FkXojdxFiAs6/Du3M4B0QjjX2dyQwokdogE5SQevOwF6r1NQONDFeEfYKFqG93TYoHWgfk1r+HAGeyiZOWUU1q9XYK4Wq8An9Tbc8I5qFqUs6Hm/tiZvZZwr19OsNnQoLezBPsimfYGTXx6xE+mUk1rWMcFVA1NZLagXBKXXzcoeTXCKPwOlHkZbOE+O6aIeWnYlnDLPBaeT1BrVzlxLXT4Gg10h4kPEt3ZfehrJBMenLIaQBJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dKUhSU0Z8bTZIKcsrUxfe0wvnM7Jp9WI834O3mK2Ak=;
 b=o5yQklJcF2lQroSR/JLMihq9Bt7ThF6q7PpiWYX6LkAMIkW4+vuu0cxY/Fto/z2aogzc8FQ2DGKTG9JgigDmAV4p4lL7+VPWOG9TYsICjeVLjwzq+ulu3pko0AnNQb4Wes0I6g5cikHJs4hFLoQog3yzs8Gznx+JkPwV7VNi8CkY7Wij/RlbZ2MJCwwPn8jpUdLWsukBxEH4FE23GUSo3V4GD47zCR1JY6RxV11mijsF+o6GjtTpTpXL+b9q3Nmklay2v651obHGKAqPpG68ebkhwb9A20BvRnspjb9191coK35KFduD3GSHZaZxcl55ghap/u3FgSF1APLDMqKW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dKUhSU0Z8bTZIKcsrUxfe0wvnM7Jp9WI834O3mK2Ak=;
 b=YFPQnwjm1MxdNERUG/Jyb/b157FutJ4KW/+aUd+laGNTPw702ryAImzNt4jf0ONHS8Sy8wgYxOgD9fT5+sai3SbJCo24ZSqrDYtzIKWhc+Qix86l4Y5dIZaf3y+KGaIgZy5wpjram0GgNPJfezVOumkRKRpFLvt+DCJ6vX9Q7ec=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 10:03:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 10:03:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Remove extra part pointer NULLify in blk_rq_init()
Date: Mon, 25 Nov 2024 10:02:58 +0000
Message-Id: <20241125100258.4172774-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: e469338d-22f3-40d8-cd7f-08dd0d3865b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12TWW2keV6ITZ+wKzmwFX0EMSNred9Edv3trqNtLuMjnM5PCjOJmwTX83tIQ?=
 =?us-ascii?Q?QgvGhe1NMMkE3iyE8lSNNUoWlNGTcW13lHTLhVY3JNcqJMLJgKzylp07AC9k?=
 =?us-ascii?Q?5/v8v6ru5KPYfnsmsl51C3y2kImUBI7ZhG/g4At0WYH4fduNstevE+Yi1TZo?=
 =?us-ascii?Q?feHvi5ZktdWOgZ0fhIRvW0KNWpaKQsQeMFtDvMblo2jgqcJLNqjIwboPGmeK?=
 =?us-ascii?Q?mohs9MFFRUVduWHiPYCfroCOlUO2BxkXDXQ15BZQ1SVdTcFggOLykFlTYLvA?=
 =?us-ascii?Q?xboXKdnew+OWm/laz3uYV5+AM+G7jBPjnoqlTItmZfnsUYNryJCvXU/Lu5fG?=
 =?us-ascii?Q?7+lB8BJUiRsNQQJfy+zdTRhjTNNKartq7ePFXyyht5/k6LD5HHjMkODLfn0l?=
 =?us-ascii?Q?oo36zqPNHQ96XE1qinj1v3TWbtjRxoMIltwDg3DqlNXQa9q6FNiSfRyBJU5B?=
 =?us-ascii?Q?piRMuZtXVbH3k8imJtTNf3tDNa+DnUK+rLyI+MH1xhsRwYFZDHux0pNmiUzj?=
 =?us-ascii?Q?VQocatxebwbdqDzCdFQNehFBYO7Pa+4emiEy4ww6FBt4TlrBR4VhmcRE3yU2?=
 =?us-ascii?Q?v+4O1IlKW/XdCVOwTjNIqwGRFtnD8q5fenDxB1fQ5T+Ui5FmIVcG3HhK4pY1?=
 =?us-ascii?Q?Vpv2Bue+TWnWPMfP0VRDBNwnX6AAMno1+fynJJyswbx0+fJOdqhlTNaaSmVL?=
 =?us-ascii?Q?YbGCKU0qP5vPns/Qm7oWBMeCt6DaTtDeU96mqOSfRB34XMR93XzemF7pjjyN?=
 =?us-ascii?Q?ZLacY4qd4IoCDMn3wMQyErn4qnPI/Lqm0ucQwee94E6OkfQA+4usB8Y1H4Xd?=
 =?us-ascii?Q?oguE+17dphCjfQT2w8G7k3NUVm7xptr0+yhDZC/+fuGJAQgzvrz8sUFC10ww?=
 =?us-ascii?Q?Mw6uyfcfmrenEf7uJZt6eGYmVSBgdihdLfqVBHO/7p4Zf3HZgtly4Zn3g6ql?=
 =?us-ascii?Q?7uvo7D7qY9VWWW7NA/i1Ynp0x/GpJNhVViO8+97ykExhdQOn7zGBO5+6Sz7W?=
 =?us-ascii?Q?SU4ToH4bE1uQOlwJZ95Nf6OMF9tpad3VZR9p+W+9FSCfke3ix73JQyTGZp/r?=
 =?us-ascii?Q?pqjwKW2j2FEaiwoW2GvY6aSDESTqq/hSttJ8OetgN3CeDFS4g9ivTEtpCFQA?=
 =?us-ascii?Q?4dmsxwZ//bUuJTq0akYRfwp3nqKObSwwJ+cMyhSEVUK4555445OaPNdnO4/5?=
 =?us-ascii?Q?Uk6vVSUkqtDmJRhptcgbfu2dkiA5K7rPDafMr4SXY9YNrL2crvCLdydOo0ys?=
 =?us-ascii?Q?SuLMJ18By84+8vQMgk6I4unjWOllZZtPgPUdyUxeXuxIXCIErZL0ER2oNmgm?=
 =?us-ascii?Q?ZfVvO4Hg/7YRYy5hVgssaH+E4M2fig8aVoxaRfGPa4rfWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MkfgTeZAeSFBHyQ0mbygWCFMQ0mHY9+5Aau2EEFIJ+e7d/FlwP3QBcHU19l8?=
 =?us-ascii?Q?uQxDT5uZBOlFcWwUn0jpjeHN8ThIP/94KHV/JT/13XYcxWi06LyV07/7RMQf?=
 =?us-ascii?Q?widpoTbwhxzHtF7URIkKkVNM0VgaaOIZr3kPei6ZPlTqk1VSq9TW+NdY8NAx?=
 =?us-ascii?Q?tjhTR2GOb9mAXl0iUVjX2nvGidyYqzRcMzGxiEd0s1u18WgRX/bfbjHggLYU?=
 =?us-ascii?Q?sbaCqUvBfbB+P8I70CW83Qkz7ZNpFTbvLHLQSMuiamwbNsWZoS+4hyAE1CBN?=
 =?us-ascii?Q?4vyEa6AnoMZAtwVjL15PLBnslQ21UaYDIemMVmC3xhW+Ec2fi+lq39RVfKJ7?=
 =?us-ascii?Q?YO/XEMOtAaBy3ibN5OId3ZtcIGwvpuh8lLLjbzUlzaTGJD5FYgowBPakdrW3?=
 =?us-ascii?Q?CZtZfOWRTTjTqZBsJfftNjCKm+Rws/czUC7i4GEjK5CvYXMGfoGnTcF86FrS?=
 =?us-ascii?Q?4P3fYWOBS0PQTKmDdTx+oHe1XaporSULl5jpVVIAqJuGBsP/+YNUjebuw2cI?=
 =?us-ascii?Q?gt7cXVNl8MNUErbNl7PIw+yJvf3/mOgDCKRki9a1p9GqlCROIdOKlOMfh1+H?=
 =?us-ascii?Q?4UIWrx+AP/9/JRxpqU6KUMtczw2wfzA1rsAWKThKyc2xy/bIGCV2+vCZ7ikj?=
 =?us-ascii?Q?Ga+7RCEoxOVuIxtPMH4Hf+N+KNH8M9RxG61TJQ6X5ORscGzBhQP4lonf14oX?=
 =?us-ascii?Q?znzNNKM5f1hLXDJWi5o0uBrlYuwrFIl8tE0lqTRe8y/Camp55iPE4ri/tg0M?=
 =?us-ascii?Q?CnmuzMjukmXhppIVUvYQkogWuUwthclcmygkRyGo4tv/FsecAblF2/fuh3g9?=
 =?us-ascii?Q?XZo7HVVmvLhbYHU+neV1zL5kpZ3AmfPPAKocxyFBfFDbHRQl4RlD8Pqa/5vt?=
 =?us-ascii?Q?8tfonyRHWI5DHbDHXdv5RyNJ+jtu8tV7bI9wznQoT0e/OME3bQ6auXKxB3oA?=
 =?us-ascii?Q?JZ5tyxDz+z7XTcz/SPBAenvUcepZFYyvEzEVCsp2PH4YvnE7jsrHLgY6GccK?=
 =?us-ascii?Q?dqmk/n2k9xkEDS60PrulEhTMoH98eFThoNN0CeHc1zHLo9/56dsy381K8CIG?=
 =?us-ascii?Q?fcBV7Z5r+BSOf3caW4qk/S80No56gVnSLpzCjSvvmN5fc05XuEVEM/s+mXSH?=
 =?us-ascii?Q?E+/ZIwg69rRHqJDpJEvWJhdTHno1KEjqAtBVBkUZ17oddWE3276YrX1OLOuf?=
 =?us-ascii?Q?5ymt+IPPkxqzki6f0GG+VxBwU+mNGtl/fvoxaDsU3leAFJLecf4pqBUIX0Eh?=
 =?us-ascii?Q?fugiXs81lmi4FROzYN+aMYGG4dy/kH5/zvEFKpetxvgRyo4jDOekbETVcSrX?=
 =?us-ascii?Q?FGkKbWFt+x3eY0+H3NTcFacr808pAbPZ3OPjajFeNruu2f1IQ8wQ7R1v43Iw?=
 =?us-ascii?Q?lxoQpHB1l/0uRJeFTkixXB16LWTeqSlHEfFkWwtiVltbN2GpRD7BHO4bHzTG?=
 =?us-ascii?Q?vPfyekDH0B/EtTZQR+LhlCctQd31FPpBvdnsoscrPbMLV19rKfLFwRBGYxog?=
 =?us-ascii?Q?LCqoOrCHtGe3WWONfcqBomTtCCcbAY9YyKQG60Vfh2K5Dm1jd0fOlRQMVg0f?=
 =?us-ascii?Q?mkVKCFaXVzxEsS5f88hbHZRGjm7XhSXvV8KHzNX0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8v3i2CY73+9lZEQfoaBZd59oy6uP2OBoGoMCSCn2GmfjDrsQtf38gIJAj0Uwqx5UyJWHD5qJKT0XoJqoWylFA7mJPTZzL6ee6xMhLapCvrkviXmTvbZlDNMPfor0fQ9BWvvS2bkAlqUedGnbFatNFLT49rZIG3Ekg7U5P8mtK1YoHawLBoApmluUIVxYmbSA96hPIAzlqFmOyprPoLwDBU0Ig0IJoR+g5rPvK/BPJYwyHNHEFZexVd7zJiLhSYXhfiQkPbymgELt1dh/k91qNmYD3P+BpJHi7el3ONPhNv9/REa3A9s/AnvkBu9afMFTm6tkkUw8MOl9UHmdZBiiB+tRIMu5leggS3hbSMFsjzL5a+FA53WgD/9xDYrjGDhJLsHZI1g3hnhHVzhTNHKN6rObfoRajpw4izZ+HYqomwM3d+kH35Ds+chFjWxKgsuAEHgD0aLFkFXhMO9gYtfQVZXtJ1adgCw7klfWnrteZ02VmEpTs8VJ/k+Bz5fAG0P9hVnwg5i0FPRjNFDLzCxkxvFF6thEcN3NQqP3ZUa1pvXfvLEL4SqFPCYDYCxJCYr2e0mEtPcpScor1/cUnV11uH+onk1+uIshRTWbvVAstnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e469338d-22f3-40d8-cd7f-08dd0d3865b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 10:03:23.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzQVlSjihA8Nt4XW092YmOUNoWad1RutUY/wOLCjw+qrSbK3Tcy+QvnZ5O+//Q9GrlAgDtTQGX1ItHdtk2+xmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_06,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250086
X-Proofpoint-GUID: WnaCxlAhlWBUhPHsFr7dgQ0MW2XFbkXK
X-Proofpoint-ORIG-GUID: WnaCxlAhlWBUhPHsFr7dgQ0MW2XFbkXK

The rq->part pointer is already NULLified in the memset() call, so - like
for other pointers in rq - don't re-NULLify.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abdf44736e08..424239c075e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -388,7 +388,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = blk_time_get_ns();
-	rq->part = NULL;
 	blk_crypto_rq_set_defaults(rq);
 }
 EXPORT_SYMBOL(blk_rq_init);
-- 
2.31.1


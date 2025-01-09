Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029B215F46
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422819; cv=fail; b=rP1DOz1R9DTA5yWgOyQ1mBy6ubf0uOR39kqSNWFkU2v8BSqdJc5Kna/UbtcOCfbSJnWLY2ja7w5NpyUqsn9Lll/WjSUehmgTEqGkOJrTiokHzNiNFlVmjg6Rq/FYvUxhOa0x6BheLRAAyVSQqSyNV2ljeatnzbnpvZTZnTtPXI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422819; c=relaxed/simple;
	bh=B7rmcoeujkyii3OwgPLlW4JXph2HKwkGPPgOKdEXk4o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gEOc7fGLgBqtI1ECfRU0/ItKHbw+6KQZgNd5NmhsfS+SYn2gk7UFOP1Ode+LKU5YIKdW6CMmZMVale8J60AVfPSvUMUdlrbuxweYl8yQy/d6JYVHjL6aaRaxFvzmwQUfwiMn5w5bkZ5mh/itgC3kot2+vCwVR19hTNgljExC7OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bK4bKn75; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vWwWLMNp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bK4bKn75";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vWwWLMNp"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094ftQC000370;
	Thu, 9 Jan 2025 11:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=DU39RKrowzLHypRX
	KuM99hsxtpCWlZkx+5pRRxJ5Q5k=; b=bK4bKn75ozTz5HaePoGCAZ+u7rLHHrjP
	R2o3IGYb1LjwMRuQUoAJcSjNePntg/py5HhWc48c2QUNBHnG47k91DC4UJ8UiBcx
	YhHvQbY6xKf2Pd2pqnSqK+Ba7rse90SZBXQPXyF+31hWuQu2lqPQOrOOyiwaPiFf
	DILnO2a0endPYE1PqWo/cJur52lR50mJ3yjyHqZxm5j+QNK0CAdle2ykJZafyjzI
	hwO+xWDcsslqIWxuq5NSrHExrD2R0cDKTvAHTuU268h9yeVU7wg5B2GNImo/UKpk
	4dsKnnyDQh5G9s+Zx2HOM++my7zjtJQ2uC8GAqso8G/byc18Nr0G6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsrjdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509Ak3cg027555;
	Thu, 9 Jan 2025 11:40:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb7vfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8tYXBl4mCXIYvLX4ebRaWOIZDqJCJj1H1hXy8v0EGo2UAplMyZpFRj1/+yjvOO/joQC5Mbh9CRDWJ/4r3veI6cCiKqT3Jv7iE3UhV1TcRSaKHs2uX6+rHggMlkiWvZf99KJDzs+o7bHC6IZFS4mvuP4m7vgK5vgRym/YIegTScx23mCk/xWNI6/QdyC41CVVnNgLjdMTNEPM8wAlwbOC2pspfhSV+cQy4Y4sRcLFh0iywshP2XeKC0wU4kzf+755c+2tE+GWMoqJRyBcMPcrPoqlnKcTOure6EEoAQlUXLyA5yqOQYbdGmf7tqRFF75w8kmvwR4xFNses+WxtzF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU39RKrowzLHypRXKuM99hsxtpCWlZkx+5pRRxJ5Q5k=;
 b=jhaVvCBS3b/SMGh58btBg7z1jfSIzNsXFIPI8mJJZuQH4DOug0hexIAbD5ayyS9eoJjcQzh9Ahjf4a7Abvil3hrqCoMyG6+dwbWqiDnl0/85Gu4YgyhJNoC2JbcGm6OubhMiDTW2UXSIIkstwEB6Yxz2KJRBKZ9ie08FDhALqQONVL7ghYLQ/UVoj3EmLRu1XbP0bZiKeTEo5r2pzpQoYD8DxQaEyfJCV7Xq+CKC2XTO/2qOXfRXGrZYSQ+tgKmKhCSQRB3DqvIta4NbdBsFuBavwwrWIUobn7aO+sVWO95iMOqN7O8mjgrZreOpuCPjdIkUsQCLkUkur/gSovWWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU39RKrowzLHypRXKuM99hsxtpCWlZkx+5pRRxJ5Q5k=;
 b=vWwWLMNpqVMqVLSDGkybM3tcgksD/tqBz6jZwiukSRrk4/Mgf65vMbcDBY1fGy92KNzCkKwofD75Yl/atFhk/FDn84wEIjtOKtaPbDI1zGCDg6HXP+1fMuYuwQWS0wkxZFygQdgCjM3Nq9lxxEUoMh22gmlR/jHvs8cUFp4Pryo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6067.namprd10.prod.outlook.com (2603:10b6:208:3b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:40:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:40:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] block: Stacked device atomic writes fixes
Date: Thu,  9 Jan 2025 11:39:58 +0000
Message-Id: <20250109114000.2299896-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:408:f6::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: acef5fae-96cc-48e5-6e8b-08dd30a25eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?htCLxazAjtE3anCrpUYx6WK6mbylJsmm14r/mKkLeADeG/Mlxiu8n/4flZsE?=
 =?us-ascii?Q?dI/+mlp7/cO1xFMy0PIEVH5oSERQZ6VKNBssePxUMoFqq+8Gvf0wxB7OJaE5?=
 =?us-ascii?Q?dijuXJBDgVAadmrT/17eaz2KonQdxW6NN7qR9OQvVzWmPojeqSC+tmtNJZlS?=
 =?us-ascii?Q?AWMKuKSB7hK7zdIUEGvtyuhPu1lDRUzP38WYUda1oKboem3M2ZBT6t6Ui4dI?=
 =?us-ascii?Q?jzvzrZ7r3p/ug1eJRftLBWlzpq4pSH2xDfcW8HCcrEsegQxYFYhs2N53XmsA?=
 =?us-ascii?Q?dtkTruhexiwhsWbOcmTwJ3+RYNMslVcSgYL/ua0Af8ewCWA9pcUJhx0pIYg/?=
 =?us-ascii?Q?qH2NXFO8i1zngu7KDEzh3X10oRpNdW8xsEeWhKWSNRFqCx9gOgWE95CH0P9A?=
 =?us-ascii?Q?cPPe9ZNUqxtxoczf391u4d4RNPFixpe+9qrkoCaYKtofge2ebx7VYZOhnNDz?=
 =?us-ascii?Q?KDyC3vpOFmIoEdJZEkOYdswCGLWvTLugBnxspfdEeVcKo1Xg5IbvNDcXs4bf?=
 =?us-ascii?Q?GxHxzjUXvNhkbTvHUSH2ecv4zHYllhJUAHY+ly3nvrvr4zgAyereeHaCl4C5?=
 =?us-ascii?Q?I9ttW8FFgsmq9PBXx2KDjVbXoHh3NB1V0Vbl56vZaYuKnnd2yGtmSBLbLCI5?=
 =?us-ascii?Q?hP9G+oM8cEAsXu7wTmX1zWkjuqz5iOEqHevPnIVsEm+0R3YJzdqdONL1+4Xz?=
 =?us-ascii?Q?6sh84iQmfSeQMT1zOX0syZvWXKHldg7X+NnQBYDl7+w2jWsDIoOOME5HdOFv?=
 =?us-ascii?Q?rejoCbittX/+Tmqh6rjH02dVdJFy1YSFo6HWDuMO8SI8if79sAXqYIc1dKUH?=
 =?us-ascii?Q?AZ9sGUbzhSZtf7cCn7moET5ZO2mkc8yzljcTSJRkitKxzUde14eeDZ4bgXMZ?=
 =?us-ascii?Q?SbnzI1GGTfdR42574y0HJKcEv8t1zGNpGu9f023fzHXhvgKpKL8IMe/0FbDy?=
 =?us-ascii?Q?70hy/8Bz7muwx/I0aLiGxlrRmOEsyUUJvMUlIyf6lI8Lr5f4/QICGef26+n4?=
 =?us-ascii?Q?d4b9hpCsDD7Uu9SW88Sscz8c+A6fE66/xgKnv3R1npy4GxKov08rUz+2QNU+?=
 =?us-ascii?Q?ik4mQs3ukRPFuyv1i0TSUY3MXqfDtAe3DimWEcSUE7L772E5/7KSGqPSyKS2?=
 =?us-ascii?Q?UjZOAuphWbMzSwziok5ThRZZdmWM2Uqel06EJSkoHcDxCPLsxFXk0a/janxj?=
 =?us-ascii?Q?ITVobC7jzY3LjK/LTc+FcE+kMppZbK7nbjeM4RlUdkTQRMOyPmzi+70zJ8oE?=
 =?us-ascii?Q?LPsrKpmcUaLOX8Fb6gGZvYev5lCaBtPko2URCLOxCmfliERUuyXAaBFHAtoN?=
 =?us-ascii?Q?1j3gGPPfzjAfie2+OBgJnKwOdQSx4DLUEmnj2XxFse5Hjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PqWgVZX5GkQB/+QzOhrwyEHVyUn5Bx8gv2gZxyDevG6FIc+Zz5UVFxApMDO/?=
 =?us-ascii?Q?dQAPksLG+Fb7feNibMNmxF1y0wEx9gvwKyRQcnYXr0twwWQddjNyjdJJcbKN?=
 =?us-ascii?Q?7iuboSt+xsTQlRJ6ere+qcpHorHypKbKPFxuZ4VkWAv8FsaU6s6JCpz1LSt0?=
 =?us-ascii?Q?0ZC8KhoY9l1JvHi4ufvW/DTZUXyCvBF5+n+zT8LhskAq7n9wTKQYJE6cL9V/?=
 =?us-ascii?Q?52bCnPUZBeLA2NypiJwFANUAUR6gahCmxIOrB7aoFqlvSwGKbBVIdCVkmvib?=
 =?us-ascii?Q?Hj247J+vT9jvFy9iNbI/5fvacB+6jTlDmXsZvyGDlnGhtlVuIc+mzOtN4kgb?=
 =?us-ascii?Q?lTlHuWGNv0HHUSaL7gcUPS/592o2yLDRZMXkeYdvo8Tgg9XH5n4UXhGr4vKO?=
 =?us-ascii?Q?GJZWApPUb+zy+4cETzi0P3ISV9vfnwhN17QvxbsaZ8DJGg8j8Ta9OLPqDgHt?=
 =?us-ascii?Q?WEk/eJXoQftS1PHDYHIVKibA4Ndvs9T1UyHA7w39q+/q5wZ3Xcph+UZoarGn?=
 =?us-ascii?Q?EG4NmjgJGbM9nb8WW4yp4kdnMJGSuB2qP24WNG6VoELH/JNqH9so4kOeMwSI?=
 =?us-ascii?Q?h0nrOy0frxINUzv7i7ieq08h8TZvRA3sKqgsf0hdCxzL+MCqlG26xts5n/Bc?=
 =?us-ascii?Q?AC02/JHsZkKwke68GKXned44DEkPTCZ8cD4snlK5++Ean0muNmQOxMbNMHwH?=
 =?us-ascii?Q?kMGrFBtHGrB/3ZtFAOT9IN2mqzBHItF1FkpIG1J2WETj5pLfkHku6svVKopB?=
 =?us-ascii?Q?cTPyYRIMTxHcs+GPRCxyp6Y3XxSgI9zsF9vppxSPHzdRMf9lI2ema2kN3Kf8?=
 =?us-ascii?Q?l7Equv7V++fuAXgSnyTlOABB3CZBjbelyIeLoh13UE+A/fnH+pTmL21chemv?=
 =?us-ascii?Q?hcGigxgahHdszH+TGo0N7Q6wAAvUkuY3G9T4Ig1mw2ZEcK95LEuVEontWXVU?=
 =?us-ascii?Q?6oQ2jAzoUW0e0LHx6NFSUFGrj1Mkt2HfVRP4GLQvs7VddVRg2MqXDzJJdXqg?=
 =?us-ascii?Q?AQt4o+5A6FlynWaizTK6u8T3oNwx6RABOqSlVYwpNgPkboM4uNghX+jcu6ox?=
 =?us-ascii?Q?H+KiDzWolGMIxz9FQemzk1iSx2CkDvJG6eBgATAeZoW9a1eZTIshd9BBWgZG?=
 =?us-ascii?Q?bbYHzdN3MbXZn5PVvQvVug0Ch6MEqCXIOc0SwOlwZU0FF3WBsdoMwVhMQmCg?=
 =?us-ascii?Q?8mzOiIIBXZAJyp1vde99GzQJNNthuoST1P8ktnKLBmOvgvRziuVlZAU+91Px?=
 =?us-ascii?Q?y5jydaiQj8ZBtLd2V7FDJSFfvUMc5FiITfWEVHOHZ5IRXdv+xZA5FuXy6C68?=
 =?us-ascii?Q?ZWN43+KnwxGbmIsrLk8ecACHnekUqoSHsXebMBUGkl9mJUvsx4ktK9VT9eYZ?=
 =?us-ascii?Q?kMVhiVzSdpBmETlLcRmRymo2HwPU9zT+6hbyJGajEmtVxXgm4vmFR1OJta5/?=
 =?us-ascii?Q?pWy0BRqtulgvbudfzrK8gm4cefSli75xzUNbch+xveSbZC25do4t5CwLGwp6?=
 =?us-ascii?Q?LUQKO4cscPI54Q7n7gvjkupqPbwoi6A+NONpPidI5Nb8mfuz2WFWuhRQAHlG?=
 =?us-ascii?Q?iCUfP7Lg9mXr/HvP493UO6RKk0VoyN+au3HOEWAhpvg5w6sljgVZXr0g2smP?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YaVvHWS1zFpJj8wF3a+wtLJ8n3fAWjOv8EALMms4cNFS9VxwbY7nWdCgjC5dFaJRp/Qj1IcWVV44BXMiKdJcrqCPbuYI6qxuGhKoCdXOPKB30WuVKxHvJBcOF4MvJI04mUmwQNXn9QtdlkDldgvsyK0ETS03f9qldPSfbhm45ldxYFxMNZhS/b/DYt2krE5wMFQ+Ul7rOmWWB2zGWAeW46mKRMAk66vXkhgas2ln/yvxUYH8Z56/P08nQP5iVC8cn0K55G9p0606Lwe/hmHPUd523djjiDxf8aVBwlR7VvJ7BRNv8lQXFvNZIWgDYUw5XDDQl/7QVQyhBUj72SqhaybLXbj6fQtpjylOBUXHB5hBOFC/sN3q3DbnaAHRRkrjHCtShQVKS/uuuu8WrH21Tc1gRkA0mQ/EnEjpfzlrTwhII0CJgtUpqczHKT8u81L/LL4pKyYiJRitD4GcqJEKOqxNSkyrJcKvWxcDR7HHiXj+RnwsAZ0XvhKOrDWcvoVUIYx6AHnPshGxg1XCsqipIHCuUPOf7xAeFXQ9Z9y9QsWppYXs60lhwUsSzMHO+7WV2rbPRtJBldTbc0U1yTqJCUoKVgdbu8bvgC4gofqsruE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acef5fae-96cc-48e5-6e8b-08dd30a25eca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:40:09.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YulAiB0AInnlCCTUcCU1IXjfdoN6hxp8n+tL1V4+1pZVkUbZJjCmI3oS3HSmUWhggEZPq0ruEmawJ9O6k6TT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_04,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=939 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090092
X-Proofpoint-GUID: pZ3-5RoysBLU81TjJFLiZ82InaLKXhGG
X-Proofpoint-ORIG-GUID: pZ3-5RoysBLU81TjJFLiZ82InaLKXhGG

This series is spun off the dm atomic writes series at [0], as the first
patch fixes behaviour for md raid atomic write support also.

https://lore.kernel.org/linux-block/5a24c8ca-bd0f-6cd0-a3f0-09482a562efe@redhat.com/T/#m42a9481059ef011f2267db1ec2e00edb1ba4758d

Based on block/6.13 . Patch 2/2 is only required for dm atomic write
support, so could be added to the block/6.14 queue.

John Garry (2):
  block: Ensure start sector is aligned for stacking atomic writes
  block: Change blk_stack_atomic_writes_limits() unit_min check

 block/blk-settings.c   |  9 ++++++---
 include/linux/blkdev.h | 21 ++++++++++++---------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.31.1


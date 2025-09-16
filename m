Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC92C0F84
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047168; cv=fail; b=eKaMX4uCePCq1IdtsZeOdS8w9FGVjy7VzFa7IzW+NGM2w8G+aeVg9GPtavsbpgjx5bDwEhbPy0j2aSB5VYYTLj/TltCmlZ6M21ys//7NT9INECtiPr26xjZFvZwBTHuiHFAIPoiXZSsSOF/fdXO+cEJ3EYEJwlvzJhXQvKuUsYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047168; c=relaxed/simple;
	bh=oLYILqjdrMvSm7roXvdRZU47EqCPc1qMRNJ3+m6w8OI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=tNuZJW4HsCP8B+lxwm7JY8jwwR3KJYz43xCjMx6BHEzxpLxHbQJYyeY2hYwRHUa183XDDaJmxJ/fUE1JmkrhIuqNd422NrOLIWdWKDk8z4OXV304jPEtF1YdiGTTh7WuqveIDaRsS9c3uQpAHU3X+t97zl3pVfd53n91HAbPLt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9OeFFUl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fbozhTKL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9OeFFUl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fbozhTKL"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GINPM0018015;
	Tue, 16 Sep 2025 18:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=guLIci/QiJJR7AQF+g
	DEeGL0ntDHhtjc90NKc9H63Us=; b=X9OeFFUlrW7NGVVQakntguDAvNJi6lsn+t
	mNcs23SjOms3GInfKn8FBVtSOSN4MWTRwITxUzXj4k36JAqkBtIQlX4b5vi1zi5p
	CHcB4NdSBhCgvIrtB8+pnZl0W/cSi/6ZM7/aIIt+FmlMrT/MIYX1yylY3g5F3VFp
	RVYT2+NKda9/HF304ASOPmZOREHszdbNAeGhFvg9GsqWkVRjUhmituMtUkMMLRV4
	9Wx7X4Sk7QAaxcqpcebv+4fiE1uY74s+v9U1KEDJU6kKuX097ZJmHWF9BKrNrL2R
	EcXNI75MNgnX+oq5YxgcEack7nAHjvrSIgGDBinVTo673GSN9Aew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w5an1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:26:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGsN77001483;
	Tue, 16 Sep 2025 18:26:02 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2d0s37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzaQHdKHr6FgzHqOajTsJPMTHT5/tNTd8HU5+kQXxh/enED+TyCHqHo+P/PYi92zQA1Nlt+6RRbo6U/QfRhF4wfKSchcEYH3vFmJDQ+67DEl6QHqCiVE8XD5H9jeaH7YOWbSWnPRNnK91VE+mqoBll8n1FTA8l/ljfAPolRsyk4NtmLBC7fkP5ZqxVhP5Z2/iPyoT8W7x0j/dCsyiuHov9wR9XBOhOhXDbVwECSYkIQmX0Nic/W4JdPF1zTXF561xNw2oenrkcMiQRDqU+1/0DNxKo0Obouwim4Wh3kDoPxkBTPvjCL/VGe0E5fNuz9p9MReNFMxCySvwMD57ckwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guLIci/QiJJR7AQF+gDEeGL0ntDHhtjc90NKc9H63Us=;
 b=h3w8coLo8tyoyWK4njRunOlHWEsTnk2UFWaifjWGEXxWd6mvRWkEHjimkf/QBfB0ag600eaWAGqWjjakLHntZdGLzcaKyvojhZKx7HK6atLIVOkKgMC/rUP+euaoUpFLm953P8Zem+R0RiM+leYlJi9YvbYbmqsoKFJp9q0B5aK+cP7W7XLs+pxoTZZBJ3r75Ls5bMhoS06dAVNqhxA5vamsvMFH/VB14+oQyh+nXZBTSTfu/8bx/0UVaHpF855IfBa/B/OO6U+FwypZcQ4FjBF7W5hLatp8czAANixSjMA8okj462MSH+1apnkD2ygWAqEvTKIqb+JVHhwCGhL1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guLIci/QiJJR7AQF+gDEeGL0ntDHhtjc90NKc9H63Us=;
 b=fbozhTKLYt3hRHLoIt/yIS7qbDIdGhy+EQkbwOFnctUupAqaY58qrwqvyyjx6YOivsMqTBCpnOgaOkKcupEBs+GAFOVJsMCFCn2OfM/WgrmDFY5Yo5ui8nM2LZoub4AT0/HzxXRl1OOpE4vSRoxE6eD3SWIMMOe4DEmYam9U4FE=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:25:59 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:25:59 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, nilay@linux.ibm.com
Subject: Re: [PATCH 0/3] block stacked devices atomic writes fixes and
 improvement
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com> (John Garry's
	message of "Mon, 15 Sep 2025 10:34:57 +0000")
Organization: Oracle Corporation
Message-ID: <yq1ecs61cgp.fsf@ca-mkp.ca.oracle.com>
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
Date: Tue, 16 Sep 2025 14:25:57 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c19132d-eab4-436b-9faa-08ddf54e7c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOwpSvygrhIJleEPSOW8eYlmn67nxyMmrH7NFD/1ID1imapOc5DvLWAlooFc?=
 =?us-ascii?Q?r8tXdaFLr7I7CFDv/AMFu+1DHxHS2j2g8eWaf0BYjTP4O6eYHqft+yP5zRe+?=
 =?us-ascii?Q?S2iVu9TmPFq3FcS/JH89W2h49PovWF23aHGPcuHORfIrsCqIaa1N3fCvTuMj?=
 =?us-ascii?Q?tMMdXo2cAGtIc4OzXfW6DxrVvmbLmzet6Ww8HfDZqxEsrnOy5Mz/Jo3LMQFB?=
 =?us-ascii?Q?6pooClVqDsA7AZyYoajQmg3c2pUKM6/r7U2OfqoPyC4EdkJ14XoY9Jc+SCeM?=
 =?us-ascii?Q?juS4x/o0Nu8ToblsESh5SedsPrTkmipOXn6JRChgBsluwVAOiLVxh5Q/3LZR?=
 =?us-ascii?Q?x5eci/RTMTZMuuMgQRwk7FBKf3dnnTJprbUw+2/8wJRdr3Yc81c9Z/BuXpb6?=
 =?us-ascii?Q?Img3zAbnG4zn542H4co58OuJ+juN0y+37hyTPAc3s+fEt55UuwBlUIdis4qO?=
 =?us-ascii?Q?so7iHdwbM7MtQaa6t7tm/shREDrb9HCUpyjv2/R3xIjtcKV/fGWh8XJD+r7u?=
 =?us-ascii?Q?abGq+3IhCPhCwMPNEgFpxkuzSn67jFjrRW/fiEBkILJO/1KVUrS8Th842/IJ?=
 =?us-ascii?Q?5mX0ME6Enos62WCnD0WjRnZJvVHA9dPCiK8ivh4M+yF1qK3OSy9M3LF1lDoA?=
 =?us-ascii?Q?7MoraDR7Tg59ekHt98Wspfn5PAHTjPxVLVHaYcYHr+AVGepqzkdLyIneQwHx?=
 =?us-ascii?Q?8dg91iAVmcVeDiwTjuvseOtyfhrKKGVxoXl/0Bbaibd1loxIVrkz/L7OfENy?=
 =?us-ascii?Q?dUqpb/wevR1C1uGCMkuxP4kZo44K5gp2kpmGpEe1I3zR+n0Dr6sGIc3Z1kaq?=
 =?us-ascii?Q?/+Ks3yA7U/uDV4PSFhkawrk8ZFQEs/pdeDOOnGdCrNQNc7DW6D46iW4r6s2r?=
 =?us-ascii?Q?KLAsCyeQvo+/7JZvebDJgFsvZRnZgxfpDRsxXkxhwIfYlht3ufrCixdNqqvk?=
 =?us-ascii?Q?Y86nbN4GJ/HsCf8mzr26FbuH7zzv4LPlNODP038nPF4WswKQU8ztWylFyHcU?=
 =?us-ascii?Q?wXXJaZxs0ZFwyDKalqT5Hs4fdPy8rUs5Hcm2Y/HWAZlHOy9OYIAKs5QCHAbE?=
 =?us-ascii?Q?hwqBFpPnqPVJ8MZAjjQaWUxcLNmA9mrKxNi4+gIIj8ipIKyucgu2zdS0ip+O?=
 =?us-ascii?Q?QLiJihgey4lQjhcULDINPpoaQt1ZRmK4lUufyWDOSWTUnGdL8kdxB3zOXrIq?=
 =?us-ascii?Q?TCDzni0ZOGiDVBWUvYufsfIDntAt4mcyaU8Sa+X/asdQc5jAb0dAHM+eUYYk?=
 =?us-ascii?Q?O0zSgXsNiitS3qNKAEK8kdvlWnzrdhma2my7iE9RGMULx8KwPFQrRCpb+Uwa?=
 =?us-ascii?Q?04eLCi0RrelCf5ZmPPQ3QUwhlfJ2mbBlVuBVQY5wLoOQLyISgDrgMXpaL+vI?=
 =?us-ascii?Q?T410FOakEnRlHx4XHCileqOaO1LaElz1MwVfmdrI02KuKkgK5QQ2Ez5rPrCQ?=
 =?us-ascii?Q?aZfBTnVucLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWMDi46PniheDdwr1Ms0MJWltcS5/2Jqv/ctoj/w0dS+DRHOZaKRfB6QlWue?=
 =?us-ascii?Q?JTE1bwhaYTLbQy1xlvPrybrTx2xIe2yTOOuEnoYBd1Y289hJH5JJXUHsBcCm?=
 =?us-ascii?Q?gyz6/UF46NRqhPOsP/JsacoFw34ItebbTSRVwTjnUE58ZoYkLz6lS/nvdiWk?=
 =?us-ascii?Q?7o42x+k+GFd3LvmJVHmsDzAPmTLL0Bs1SQiiFH1OvRCj+2EPNXe5M/+1FaWO?=
 =?us-ascii?Q?miD0rNQ7soz8TOO9Kt+emQC310fMiR2zlgBlI1aw2ZbBug0thyeGY0Dy3D24?=
 =?us-ascii?Q?n4SqB9SJREpDzyREpoE2Lt3x9EBTLWfLrUxpDSufaSZ9KOYyRXCCAbWg1G4s?=
 =?us-ascii?Q?sJSyXsizpnOKsvRwTKP4jW+Ct5BEVs3Nr+EuCaiV0pjKcNhWSxaHVkgnS8Vd?=
 =?us-ascii?Q?YzaixNaKqvR2ptqwptkG547fTk21GsrC4umW76Gbp97RBu5g08Qn4v6tArEQ?=
 =?us-ascii?Q?d2zfXZuFQ4aOQSFq6fJerOxt5Uv1FE69ke/2vCapFdDSeSJPswJq6MzNv89c?=
 =?us-ascii?Q?Zj7LpTzc0YTQJSwQxXipaJMXvxb6Ti+gerZzu/HdW+keXgAhE/kJY9ygL7My?=
 =?us-ascii?Q?IgZnK9oYRBmjtuz2xhHXi+aNf7HlQ7qcS8lUZxbP6PVRreJMeUdxQ564YI8S?=
 =?us-ascii?Q?lIJLSxzbVGEln8Rp1LSoMyLKcdzuBE45pqV7Psf73ezt1Rk8t1aJaz51WUcE?=
 =?us-ascii?Q?13B0Tm1ki8ZHu+0JOBmbuUeU4xTVyQwZXQ03qIgXU1webLTNxXt16DTco+Kz?=
 =?us-ascii?Q?u4mj6atL3AZjAUzTDMom6zvCeFO6F7JZTWi8ZY6NdAqykKxiaiqWAYvGA0zn?=
 =?us-ascii?Q?UGa+ZGAa6QLPJBOeDcno3fuwg4Cnz6TdGon/K8+amdDr41Ute7ZKjinHyKA4?=
 =?us-ascii?Q?X24uTerWqtpGDUbezk1+uhtZ/XkPZywqGDXov76KfbLOf3TlnlQfJcagnAra?=
 =?us-ascii?Q?MZGmf6aRU+2o1F9HI72kv3E9EmoeS48NhYzkCdQFNP1KoHHTpNbMzyh3Bw7Q?=
 =?us-ascii?Q?wRi3C67ebB5ySW5zgUDfT07dToIN2jpI8A/TsQ/tdPN7pMqA/5A7OaAc7d48?=
 =?us-ascii?Q?7ybYDS4gflVDQl7fQ12CM54D+kvyUWzMn8Q+L/zbfoV+DGEhoq1Abx1TCg7A?=
 =?us-ascii?Q?I+KFHuEezk7YGID/zfWwj+SCky6MUkkCOj2KM0iEK1QjMOZ/hyPEwLa6TEKY?=
 =?us-ascii?Q?9pS1Y4FqH7RMDCzPOk2OML1JawAl5jhymQ/5jEaJywfClP44onFLPV4Qid5N?=
 =?us-ascii?Q?y8EhuXeFG9qLmIJ/zv5ltuOtqVSnnhQA9BZBWINEtJS5r+ZropPctaQJZu5H?=
 =?us-ascii?Q?PAgaRtQ606TvHIsuvTIRitY5zPxDWyDs1KWV32EO5kZBdMOJ7zRUFqh/sQHy?=
 =?us-ascii?Q?rljt86b96AbwD4KCY9cmulRGpSsxM3WnEYVHdvdF/qK7oMWM+UCC540z1yFN?=
 =?us-ascii?Q?Kmag7W88Le4/lyoJJueKMuv0oDb6H/YYEkYgIKC4+NanhiQ3yHvtPNAnm4dJ?=
 =?us-ascii?Q?vK3x8W0XI6fw/n811OAEfCe8TB4IuYY5rJqB7ke88l3euoOKqrSuyfWejD4D?=
 =?us-ascii?Q?5CZgWLdLb/O0dxAMKsu1IONhYZbMtL04EmYXJc04DtNjHCc2sbHOgW0jM7rg?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	atjmF5xAcJ/nKRoPyjdVaHuAXgpuBJ2bNoDs68mKbq5EuAzhIKEUajmx+S186fdg37S0aAhKu51wiOPQmiGGrSDHFW0me3NCosZZJyOr8fQzvKhfcCz4DkSKiZzU3OL7Qh6ZEebolx5jZ/YbDxiwYBi/bPf3VVroldEAzzE5XAdjE20U9n2E/918jtLRsva3wwdt4weEBF48iN3DHjUXLyoF07YeNIG16NG1LnIfA5J4l0DVpt724SJ/JvMRq0eb/YYde+AoVUkh8E7hzf8KTNjvI2sriNorD38Qfpjdf+qlsLyywLjmpX5zwMrpI1dwPRQdEkK4524ajGv+OUmWWGgZ2ow6FBUjKx0gjqkd+izfsSPknktVufOkmk3DeJBLzy8kdZPsGPZAij8anuQ4UXkYuuRQ1e4ZqANc/owoet22ZUzsW8iuCKav1Wa0g/pIccGBMj/ldFG4rjYadhY4ri4yCJnR/j+UN1vyhdTY2D+N5X5xGOJlQTSwhiHPrZpzaZPPfnC4q1aN23/IhLTpzEBkZTXhfB9Tn0CGVuWX/Y79q3myfM2AYu4aaeHn3zKOhnWFqFghVe0x1u88CaxM9AyBUq85z1SHV4zeBSAkFrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c19132d-eab4-436b-9faa-08ddf54e7c10
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:25:59.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FouBKIBT7vLIGiGo6D2vVheKpKaLTwJycH0DMPRwtnJi1QSfnwnmUvWRU0Bncr3ZiximtM9JZSaoAgm99AdwV0jbp9n2BhmC8eZkaepBE2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160171
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX/ZWCkC/8hdA3
 SlVq7MliP+z6oHlNXgQCBz17edC87ZupLKpztu74wZVSa1tOXACR5EFQ/hrkbb/vLh1Oy7jT/XZ
 5yj7rl8VWlUg7i2gP7EfEjzYa6l8fvCNagtthoiIuuBXoSsODuOEVdSd0XJN8J0DBKM88iMk3e6
 nC5BdKj8jSaGKiztHX7gkLE5vfdS5F8gdaiBsHNfb+DxICI8cDL5F2MtD7toz0g7pAxfqMIM4ow
 5rt8+ar9I9dXkV1ANL4XX0cFWfDjxETqw6/zIheT/flECpcy3lIujX1BuBgKFfo25EL9a5rqwYC
 XOdF4+lGBtTUhkBvticJXFGw7r3MHkU0Kukkat63ypkBsHLuSbBkQ9Uceg59tMh2JH2lcOusVKF
 ZUiBEyL7
X-Proofpoint-ORIG-GUID: 6RTwXecwtyuNeg8edK7Qt4DtDVZ5YelP
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c9abbb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=FGSBRvrPRtxE8kA74fUA:9 a=MTAcVbZMd_8A:10
X-Proofpoint-GUID: 6RTwXecwtyuNeg8edK7Qt4DtDVZ5YelP


John,

> This series contains a couple of fixes and a small improvement for
> supporting atomic writes on stacked devices.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

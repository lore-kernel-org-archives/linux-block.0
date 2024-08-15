Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C201B1429
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739574; cv=fail; b=RJsirtdIbM3eDeAhVb7wkHKQSNTd1Aka2TAz58PlN2lUbVqFoquXmyEFIaWvAts6bLRplg4XMnyBQUHzTGDdC9lNZZWxb1XHk+21YQtDC2KqYv+HTXdMHjfg0/8mNfCfKoWy7/xMoo1VQ2OzDd0zIcXBJXRdcabPEPBQjmJhBl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739574; c=relaxed/simple;
	bh=4yik7i3wTf4TzufS5syFPr4Q/fjuZQGNJJNx8/33hwA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lz4aFzuctNu7r1O+17h3ec8b1Wo2upgIB5crE7WQ98GOhBs4L01QMzHIN7K+bMLe5gs2znIvIDtEalsssGJwpRLog4bxKvX+eh9+fqTz6ILFPIDMdWFecL6d8f7C0q9vhrVAgoJy3eV+87bJZVEtsDnRTm5z9ESgsIxp5CrgBMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZHkzYAP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k3QeTPhD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZHkzYAP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k3QeTPhD"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtVkT017293;
	Thu, 15 Aug 2024 16:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=t9TWADw/xxkWT8
	zCVsn6t8BuryzkjYxLaQoq7tiz1OU=; b=oZHkzYAPgMBZzCUd7DbwgIYgta+mTO
	jDxwpBE2Rz/9BNVBx0FyeKSLrYwsBNelBJtdktTnBbajc6cMSLxyoL+LtGhWSkXS
	feH3ZT3Gp2iN9sk6ojRfjqiWONcN11Xb1MHVg0uV0HHBtkN9EZ9J1DA3buzzt4ZK
	JvwrrL7hWyYgyHUrQuW+rE4MqDgd6Wt047TxAqB2U9SXow5T9Mwe8+nHC1xRN6dB
	jWpMn1UJQ1HFrvTvIZjrTUgngRbcS5DZRN03rxwt5tdVczQBRxP8riSbT4jlHS6n
	0twx7tJVeZUgYCerhc8wv66cYFt7qsq7T+EYYrdvdemNiKen9V5eXFxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttjx98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFLxpQ003771;
	Thu, 15 Aug 2024 16:32:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxncbctg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE/EC4UPa3OyErXiZdT1GHVQBVP2XR5M9if00xg2lJEmODfjgQse7s65P7YJXM5gKI0MyG0b53LT65e+Q6ZyDHIgs7BDpu7w+j1wNQGO70Rp0zDlcufefxc4VPU4rrQrp9a7VBZn6ZaYZ9nJYBf4VvhZS13YtYdbSCqKzAXUF2uR3xUdjTyvhXvdR04OuXhDLsWnfBFOW/A7J6wmLk8s7FtArgprrUDXGhziOue4xWFEZoHuXkrp+ikG8EmqaYFoAwiO6pf0h49ImQBbDir6j13h8U7P/dafjTPmw+ZGpftcZ7BM5Suw4uJp9BsSMreqbEPbpBNnX0lXq2I3P3fcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9TWADw/xxkWT8zCVsn6t8BuryzkjYxLaQoq7tiz1OU=;
 b=t8tY8Dh5bnJE1dCfBWo0vTBCQw/tHV/tS09bafA9HpLV9TbSnUhecCDd2i0p3SpjlIkYLKL1toU+Y5adv92T0VFimthvZDNMTxMwzryk2GzJaPH+/VUtVzGMWBf90uLvvTuFRvEUzhnP+BIb9lS3dbmk2WjD0ZzW3WU1GxO6f8sdLCnCMohB1uCT9Svf80JSK9uVfrkULjAQbk7gyFkSMgOygtpKAREuufXU/7czhG464w4bqhX1F5lPCDmE0lRLUPZsc0M1eLR5WPVeH9cdpH5TY8jEOs+xtzQgF6JCZ7TTWmmF2s02peDNYllBVrmbwXXGPbdbP6pdlxZpbc8NqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9TWADw/xxkWT8zCVsn6t8BuryzkjYxLaQoq7tiz1OU=;
 b=k3QeTPhDD2iacoaG9hXTkjLYj3g72Js6uS3ACcwQg2NWyDk1NmFiQRHEPLaRWVgvo6LDMPNzZiVe05ASIgi4FP0vGgD+4/lkq1QCKSIx+xRKIxKID8ediEaj7u4u6zyLPS3yz/uZWdocxKE/64UAYhg3X52T/uKDdNVmzFQGMTY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Thu, 15 Aug
 2024 16:32:39 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 16:32:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/2] block: Fix __blkdev_issue_write_zeroes() limit handling
Date: Thu, 15 Aug 2024 16:32:26 +0000
Message-Id: <20240815163228.216051-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: e14506a3-8b96-4dfe-9809-08dcbd47e105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUhdYrLyXUOa07+YvqYkbctpx/3rLdhptvMnYhW1TZlhgPz0Tf/NtYiKyhq1?=
 =?us-ascii?Q?ir4HwMPrkse4lN74KSPFLbpwYgDMTmZXHnkqL4sbDtbgWXcwTE8czXG7yIM7?=
 =?us-ascii?Q?7VEGXa2W5Ke8e7Nn5F+ooUGmW69wBuzkuZiUBLkJyd47qEGdv5U9pT7624Z6?=
 =?us-ascii?Q?mzy+/+Z3A9OxM9Tk6kc1zbtKD4VNGqNluCNliM8XUR+utnlJXHpDthga2ruY?=
 =?us-ascii?Q?okYi35qzlxYR1hhXYBVyYkvrF3JPJ2vCl0Zh75RlZJZI07s3UYfQH6FbsVCB?=
 =?us-ascii?Q?Gq6MLlFmwUzax6lyM7589HEdZ4xgzIN2czWrXyJ+RyQaavOBIB3eZKjtYsvh?=
 =?us-ascii?Q?c51y719OuRADg2ao8RjAHmkRw7FQU1d9RQFGLQ82TxhAMmnm+pMhddGZ0dGQ?=
 =?us-ascii?Q?ltYWBYJLh3eug2sJS+LMo8oy6RjiO6oKEA7JojxwjOv18b5H/k66zxYE1/kB?=
 =?us-ascii?Q?Tlpy2simSEEKE392JaFgVl4TjORiT8VkThHInl81tcrdcPnS459SKaYEbHMK?=
 =?us-ascii?Q?0+FVxtmQL9N4mJqjCqOK3Q7Lo47xpf60mD2r7xrWY/MZ8E+3rwDXSw+KY6+e?=
 =?us-ascii?Q?TfOuRSq7etsduQ+nesaTUxLOVszXsL8SqFTMmY6frgNZW5WMa9SHR53crY0X?=
 =?us-ascii?Q?mSMAN8llv56S01Nvs/zQOAmFc9LFkXkYtTF3boQWCC6YXskRIDZuSOIWmwa2?=
 =?us-ascii?Q?aiu4BF2p5DUPgL64FdejD6klmYsYiZVSpVHjry1Hu7+GSByHmGoeQ6Q69MUU?=
 =?us-ascii?Q?T4G/m+1yJcw8kBODQ5QIDJ/iNwMkNN6WQ8Ph3LFTyj6IKdiDkx+lArcH/5/z?=
 =?us-ascii?Q?KutDidf1H9Pz3ApeWDCkOVA9XYzNNxbHaq65IcNv2stq06SK4rW88R4OY36r?=
 =?us-ascii?Q?sPh+uQhl2Ww5YqSEGCJjuJYcudu7eHqTZ1qhD2LNzM7HL/wBsb967x1c/EYY?=
 =?us-ascii?Q?J1Fvp65LRNPcp8fRylY6e8S33RBcWl+CbS6R7zKMbSeST8uhHBV5pj04+UKh?=
 =?us-ascii?Q?+RGeepu9fX/FTHUZj8OjFPauD9Npr8+akKztdU+V9eFMybqqBmntkYNg/Mky?=
 =?us-ascii?Q?8Th3cUZyMsBRnEaSG+fSrQL1gz59mopUSN+xnyMvC/CCW34kXIx//6YvU1WI?=
 =?us-ascii?Q?fZTlnNA+KoGdB+F64uL5C3jiyDyMuv8Q8hNd+cJW2Cp8qIX1TNEbNkyU4S/X?=
 =?us-ascii?Q?wnykmf/PP0xiEjWW6wIFfLsX7sbm5W4vd767HAsm2nmpL8dyg/BZq5+KttCV?=
 =?us-ascii?Q?z5ab7F0rTTeoWYkKFb16j62wByXsf8oKf6TkezS4V39KOSizdaeTjqsVi0wP?=
 =?us-ascii?Q?xsFzT2e1DV9k5w0It6aMeGFqc9XBb9hixxD6891gZLH/X6ga5GMmtNj40Xhd?=
 =?us-ascii?Q?74lc3/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFHS/gKNh2aQAGBoW32jounC8fVgvKSWJLsifKe9qaxi6zT5AvB2fDNztxT7?=
 =?us-ascii?Q?P4Fgru/kAs7F+ZTd4GGNXaIV1SBck+Pr0aikVGMV9PZYl/w/WRJYy6AT7xyz?=
 =?us-ascii?Q?NLjk+xsO0FNdaiKGfUdcbgJA/FNjH5DLdP07Ll8aWP/TocHBHhv2J25mIjqW?=
 =?us-ascii?Q?kNtl8QuRF4vxL1McmjQ6Xsh5ay6wSQXe6w2RWZwBMeCHqsxC1o/o0dc5LkYK?=
 =?us-ascii?Q?yWoS3quUDUqm+RRnLWNRkuUz8aeaAV/bMnAVyrfw7qz+3zLrmOjVbTM1p7+3?=
 =?us-ascii?Q?+JnG+YkqOafOJaiYSyIC/UjW/ZteER44UlbBnSqYNxNlSF9/9Z1X4iHa+k+W?=
 =?us-ascii?Q?tEtkHePEtbsXr0jaLR7a57BhQt58EpYbG3Wq9MPYJX/UvXXtwvVqOqSLw4jY?=
 =?us-ascii?Q?KNrkQvi0YX7yLduu6K+Gd4140iXeDcLpNUGLdubN78umrMuvdRjOxHrzkB+5?=
 =?us-ascii?Q?ZdzRSIuOW/KyNsoraA+ZRChvHQSmJLnjMtETM+Lsa3LZDC0CHOmNoTl4UtHY?=
 =?us-ascii?Q?AJF9W8EeBavObh1wQnBJ18XqxBeytCDt0VGDFihe60hdvqb/DOA9+E1uL/if?=
 =?us-ascii?Q?CjY9Wvn/y34b3MKqhw7qDQfPimgsxIx50ebfPv+4Pa5TytAx/7xHPowA+TqD?=
 =?us-ascii?Q?hjGtsA2I6T1IGdQKpBWZs20VjsKH9aVOiT6JARCJsxss6zaWuMQAbJsjbDQO?=
 =?us-ascii?Q?Nw1e2oL3odaLy8V4ySA3f0IQot2NvmQJbXIimkJqwpu+YBJU0wlw5ft3Q2pJ?=
 =?us-ascii?Q?GNoco8IuF77H1X68XDBwsgjK8xC6sHU34O5E4mJsZ8XZE5vszZM+WPI2J4FX?=
 =?us-ascii?Q?mOT5OYNcxwZFCysUTiEfQshpFmSRhQTH40UTdsmeFVXJ0jtDJxntWxKfCwfk?=
 =?us-ascii?Q?39CmqzRPQyrSR+MCbESd6x0TIQAIK/ZzfFy7lO4PhCy4js/xUsGckl/n5FQZ?=
 =?us-ascii?Q?uE1pxwvPSMxc21Ex4nxcyXGTVkqyAoyaQP4IGkQ1o3/duW52ot18w9v2neBd?=
 =?us-ascii?Q?ut6R5XP4V0/Fc/BXTNPw+AB4HnS+aeDF/G96fRES/x1/hNfqKx3MPUg9/WeI?=
 =?us-ascii?Q?3plOGt2y/u+RNGJ/Ac5DBWvVIw7p5iBrv6rbgEE+PnOQ+3dN2BsgpjLpXeIJ?=
 =?us-ascii?Q?2994cYkKgtdjZAT6rYbjPuEGrau8tKgpbrXTV6FUJ2RorVib2PtrhVmRqMYz?=
 =?us-ascii?Q?xU2A9mSQ29f5wCA9AoCef1aYw4xVPQjJOkvHw+ExyR/I1Y1Ccs23t3MkxtZr?=
 =?us-ascii?Q?Ev/s09RvGrbstuJurkfirMSxiy07roFixuTaqhEcm2DXUChVRRI9mJsseabF?=
 =?us-ascii?Q?BIvtkoXfUau7kvEnjgSXIGHgTOwEh4fN8WFEBKGXGgJNIwV8VNpmWtm91jJV?=
 =?us-ascii?Q?eYUXTGcjRTgtAP6I6FVlnUIH6igXy71QOPctINL4frdSn3OZ+0yInVVaSCU2?=
 =?us-ascii?Q?HXwaI7OKiP44jFf23Et5flmmkhuDPJ/UEkGG6kalbgQ2NeZb8UOJpZYKkmpk?=
 =?us-ascii?Q?bDkldrIhqvtsSRy15InljPC7Hdw5Hs/GA+3KLYdRD91cBd/+eFFG1rqpun6S?=
 =?us-ascii?Q?JBnwY0J3kMJWDAKZogxwzbkGPNwupgJbMqJANGTyrx6WB1rlH9cD3qcAMFpu?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JlLSnRoyKn/1S/Tn/K5IeDw54KhgQvQazs4aVtHV0J0pXu5Z3KeoQ6Kcg4fsWgIDajJooj0gXcan5hKUZdb3BRK1bnc6YmJgsQGvFcX/J0bzRzaxhi84nR7dY9ojo6TKU36Jl/9F0/2OZQYPYKKPMLReIctV0hAXtUeFv9wzw9dd1PXVZ20/LV2lHwWx3FL05oj/b4qhERNXpnK/n1aWTC3m81ygbIC3LlL8eAKTme2pnsxlLCEijU9/EHL9dwdS+H0WnI7WXuSVc1ArAUxDhlFazNQHr4kguMYnvk8s55r69+r8I4uS+2bT8yEEbWcXe1w89qCfltmpLwLTi5yJ52ejqiP987Ec5uEgyG96b8+tK9q4dRho/piykvO6SII/CTyzuv1rajQtP/5R5TL7+b1Pj8bY9SnQXwjNCMyRMn9ybUPz2s1FfSFSPDrW2GENZz8kusXWnv9ahg7RDYRc0FKnxEcdBo65ShoaFNnNkOZjQU8IyRjLUnJH+fE7HY9RiQfSM7gprjnuskeug9/rkASp8ujullspZ7XhlnuZNWREZ8z+HJ4XRzy56PW5xFed/bm8nDRfr2FnlpbnZROJD87BFlZkM0deExWQ61xOoxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14506a3-8b96-4dfe-9809-08dcbd47e105
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:32:39.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE4JCqutXP+fsvC9a0HOthJXanVKZ8nU0JYqtbs3p+XB3/rRRd+lF3zukMp4ie2gx17JIwRLzz6sADnhLeW01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_09,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150120
X-Proofpoint-ORIG-GUID: eUgeoKhFrf4BcVxJVR3wCMCGB9DMgbZy
X-Proofpoint-GUID: eUgeoKhFrf4BcVxJVR3wCMCGB9DMgbZy

As reported in [0], we may get an infinite loop in
__blkdev_issue_write_zeroes() for making an XFS FS on a raid0 config.

Fix __blkdev_issue_write_zeroes() limit handling by reading the write
zeroes limit outside the loop.

Also include a change to drop the unnecessary NULL queue check in
bdev_write_zeroes_sectors().

[0] https://lore.kernel.org/linux-block/20240815062112.GA14067@lst.de/T/#m14ed5d882f9390a46cfe2fcfa2b51218aafbd32e

Differences to v1:
- Add RB tags from Christoph (thanks!)
- Update comment on __blkdev_issue_write_zeroes (Martin, Christoph)

John Garry (2):
  block: Read max write zeroes once for __blkdev_issue_write_zeroes()
  block: Drop NULL check in bdev_write_zeroes_sectors()

 block/blk-lib.c        | 25 ++++++++++++++++++-------
 include/linux/blkdev.h |  7 +------
 2 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.31.1


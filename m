Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1D15279A
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686316; cv=fail; b=eQE+hhA85PC8ruVfXo7xVIbVsiB6L7fwdwN1HFZ/ZZvQSZ/thqX3U96ke5nhmERPNrCK/dSAamBYxD3pMK6mchXj9FsjIRYxbEPuzYD4tcu1M4t02HK767ko7F6p/z4NfCBvsOlaEio123Bkkg5WyFjefj5dLhK0BxOgR28+xcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686316; c=relaxed/simple;
	bh=ldalz7DlRWURK11PRLZ2oWlNnmNxvFZ8Ztz3+JgqpI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilafDRqICbvl/MdKswerD+FHx8enQ62Vh0Ptlj7VaI83SWTgJ8hKwtf6404Imv4C65y+FhLyRWS0mU3yTWzWPxl9Z7f4sW3Kskc2nY4pLA0AxmJCJhMzpL1yYC9e8gHVlV/ATG2ycosH1d8viQlN5agN1SlDuPRBgWlG3Vx88rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2L7Kh8M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=adplWn7B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2L7Kh8M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="adplWn7B"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tUrN016823;
	Thu, 11 Jul 2024 08:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=5on8O/RM1wBkuy7JzTXgb5d6tl7mhfjt+oqDN4y/7y0=; b=
	W2L7Kh8MfeIB/Bpiq4r5jwCTnycQE962QvWZWC9piW4zjqTNNtPcbUN1Dfj9kCaB
	nw9zATju2NXruYP7Cb5avuK+3lazfpxHKxjgExGObi3y/NidPOiP6HTT1VF0IYzS
	3L80AuLZi0jwG/5kvYZnCtBwSTJZGrEuVxVG4SL489iTGBEGMHnrrgOl8Q4XCWRh
	gDq0fph+vm84jAmFSs0LimeKN6P+MGS1lWrXIPIIcUIh8OUMWSrCi6kuF7lOl18i
	my5qfPyrAa/MidyYvBckwTrFcmGMNaoMmmIJ9ROmjhu43P46dWg8r/61A6bEx5/I
	AFax9WDWrAF5YGICVEZqZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybs4pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B74sCu028750;
	Thu, 11 Jul 2024 08:24:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4p3yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATOmlaCrkFH4wOj7qhvHSD9UJ29Yd7xiCTGBH7q610EFtc61OxIFBr2Wf9Vr2o9jnKR8WJe/Xev0LF1v5tdGp4sZK6tRd78gubAOcYZB37lBDEmvdGbYdLaWdskhNweo45eZjmultmS3ngXt6GFPpZjLMbXMG+LPtoexk6N3TO06L6r94DqD9Pa48KGdsx+8+UsC+KRQcXqsVjbYKmt71cMyHbEELacOTj3916xhX2/jRnStUMZ0a4+yV6nNC4gWpGnMykLqEjEofP9mURhCX2/3aTwfEjaG6Q+4NhqrQ6wFeOyT+JFo4qHV1iCEU3RtH7saMNP6PqaS1aIo96A2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5on8O/RM1wBkuy7JzTXgb5d6tl7mhfjt+oqDN4y/7y0=;
 b=abI1UhjTuC7FFYs2VkRPeeDeFf2sxSuv6JGoFlSc9qAh+kt8WM7eBYON8zjaovfCtrNuZUH8oGJLKKCJsrUK3AnO8gynHtl9IW1dP60ArNUYbsVArlr4DEInnAmbOarrjOFvkRaCWMrPOO7Yd2tkT/skcKVQbJJJxMoOniaRyMdOBlCeUYPsLCmuHZUTGC21isGqRzwyVw7JUTRJHRyfmSoUGrI8v0IQuUAPJKY9zPyke6wd/VmNJuQ1P7zKxHR4jfNquMQUjVbhxgJBJ5jU3bA/N9g8h8SXgd+uR92WgAiAnwlfJBk2JeiEErRGPzFKweWQAcRocB6YZxsVBnUrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5on8O/RM1wBkuy7JzTXgb5d6tl7mhfjt+oqDN4y/7y0=;
 b=adplWn7BVhfLvlrK6LPZJVO7c4Xq9hhmyfHa52LIqU4kEJKQDG1XHsCRve/MPoidWD2J0SD903yGf3XZcQCu6gkdni/5iHYQCNO/D/HgysOiTCxOvQpUWTqyFw7mgndGDwS+SSL0lp+BmGdasF6TrWOrAllPGp5T1eCJfsnVMC0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/12] block: Catch possible entries missing from cmd_flag_name[]
Date: Thu, 11 Jul 2024 08:23:35 +0000
Message-Id: <20240711082339.1155658-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 75998924-8ddb-4b0a-c93c-08dca182d64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gTpk2hJ/m8hIXSaGI6C3gCJx+O0S3Xm3ZS8cF5mlXJuJNgAnZtq189dFPIKM?=
 =?us-ascii?Q?4yx1/D2GnjBVBo0x9fh+mtJAs24c6Xh1oKgkUUU6pwRCD8LkFPFr1ur4qHfs?=
 =?us-ascii?Q?KOlckMFZ4F1ON5b/r4kpzMFL0SaTWy8LMCr1zD7A3V0Z7GirM6UnMWx3pVZ9?=
 =?us-ascii?Q?mzIAkR2J0CL5Ufix13MBSpDXtAf0TvrmBSdWmRt30WF16MNM5jIfxFErsyU4?=
 =?us-ascii?Q?ZHv8wNYEwzXCmBM4MQCUKn3tjqpzQmubYy9vWrX+9CO4fpzOTxosef6tjemI?=
 =?us-ascii?Q?ixjpl1AFwM15/SZ4CTaXLN5eihHytfCK9tzdsLMw9hLX3arISed57EbgpwQi?=
 =?us-ascii?Q?7XyPY9z6PwNQUnwXllFySoImaRnvhy6aok5Q37fG+LAQ8EeUg1nlTHrstL+1?=
 =?us-ascii?Q?6+yDGCk15XnTgk7KisM6/1pYNqP0PrIp1jFkrddICnCKFeQqQIXx1fZl98Xl?=
 =?us-ascii?Q?auijUPeRG7xnoDgsgMfLcAkRvgNfgV+WTLaSTEGjXhLq8ctPrZ2u4YJy7uez?=
 =?us-ascii?Q?LAO9XtgyeyKxObXTGriXwsg3qm+cNIKKnb5oEU8Q9Rs95DP3eV3m1LnXQSX5?=
 =?us-ascii?Q?UdO0Tgn7VzW0DW8GwrYk7mmJ49ICImOuy6fmT3pSCMbYMNNtNQ26qYPR0gPj?=
 =?us-ascii?Q?CyCVKvn3KUUgjoEW1K5/xQfLvqNbSN3ndRRSkB624V030EfM7s3sSe8NRHWh?=
 =?us-ascii?Q?DBS62Z3Y493zIoEnr5X6/pQe4YgnEaQGDR/Dgr33VTU4t857roEwaak1xG2q?=
 =?us-ascii?Q?GBHOeNd5KJD1Q52ZlYP3HAXzusDx7iS9rVO9Y4v37ZL3rTwgiCADh1GSneQa?=
 =?us-ascii?Q?JmwblfKT78VgNMPSnS3Tqz+A1UNKjM1/deAXqsdDVMpw+z3pRnUcJ2hB0CNZ?=
 =?us-ascii?Q?qGkJpLYq/op2r9PkAoZh5xH+gAxYGbaDZu7untpXMExqVvY7VXeW+AYF/NyN?=
 =?us-ascii?Q?CvG5VxVCuCkkcQ2HaPFpDJYpzGgDwLsvbzTsV4BNd8jF63PXOuEzmBZHppgy?=
 =?us-ascii?Q?CicJYiehJTnSLDJ0Yhumq9ZcubCIqJd1m/Er9WbaUdDxLqtnkaAuSDY76vIh?=
 =?us-ascii?Q?t71QPNzOw8Ky3IYHCLtObdWRhCiKpjDwt9ZkmyFXvLZlgxddYM6mReBFdadu?=
 =?us-ascii?Q?YBWHofLlc6b7k1AJua1+XNK05Jq1GJkDM/hsoIqvNbvg5GoaFeCnJmJDV8qD?=
 =?us-ascii?Q?ebPMM+HJdzLOJt1BtU/A1lgavn/ihhXnNooPJH/VjXOYPD/jCdZX6An1wGQT?=
 =?us-ascii?Q?Ue5Bbe2X4ndUyCSAw3/qCWVPM1V30T/5skcc2+1XcQn/ZNxzapfQ/3yXf9SQ?=
 =?us-ascii?Q?LCfkFJHhIMnEu0/SXJpwpfYkurKHl3eIbaqCctmLeMDD5A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6TXoPlTy9kOGPbeoz6a4V43i+BZKHLUW3/5g0b24eRVQqbrWxkGYNFMG001I?=
 =?us-ascii?Q?gKO/6osmkAhfowm9lpMNmBkJU515Z3x9P9hAKX2+zUP8tTyZjtTbvt9R+4nf?=
 =?us-ascii?Q?gVa0bIfF4lhrrUygA+tLgQNeFIepjnmwlogBOp7u5L11+8n+QMnPk5QWlH7j?=
 =?us-ascii?Q?HzFgz0KiWYyCF2t8VtlO5x3MVHSpZFUVbOqVbScfMtRDbvzZL/IcUMK8VY4U?=
 =?us-ascii?Q?+QRK2NxcYK/763rGLFIzDrCf5pqs7gObI11fWgoEnxsKrjVE+XUnkNoMfwod?=
 =?us-ascii?Q?dSe0ei5iidZ8UpLuGE73r5iinD2LiajhsbJpvX3eOojm2Z7rKWQjM6fvctSj?=
 =?us-ascii?Q?Hh9t9GEgff03TmWaTZ2kQdbpBrbF8pzIoyNALGhLQ6HWKpVp+GzxGIA8Qg83?=
 =?us-ascii?Q?km/MeBaQAK0DIfux8ZrPvusrmp1lrVn7FdoG9NqtOvJaUxoYJj9tiVaIE9ye?=
 =?us-ascii?Q?AnNs9WL/rYmqUXIk+EvU6tMbNtLsNmVlLXrD+800bhp7E0mJWV4M7aGsBNXN?=
 =?us-ascii?Q?/rkwNNNNZOzNHOtXAndOiLhgxz3CjaOnLn4BWuSLPZ4oi1NnYazYKFTMLtm5?=
 =?us-ascii?Q?u1OG7CkvppxGn+8atHwqMZ5xI0FieocL2zhbV2r9zT3iMMF2sEEc2g6Hp9J2?=
 =?us-ascii?Q?01muUTnpPbfuggcoCUI9OJR3INXX7v/pOeaHW5Al3tXRSzeAFwjYVmorsd9W?=
 =?us-ascii?Q?YIBpcpoN04Arfklln77jBf8jUqirvQ3TvB97w/CXlUkBcsBAlRCflcQ3qQ9M?=
 =?us-ascii?Q?y4oSgenFAQP7KiMxzyCCMoIcP1xNTYVzS/dAevYRTYSbRuoJ8qZbobOOuHxG?=
 =?us-ascii?Q?pRThmv1VGIiLFfxMwSP/9r+YwVPjmgG10a1kWe9C0kppx8v3gmU75md2gE0e?=
 =?us-ascii?Q?wBtxFCImhA/D8jxOEVzSko1rl7F6pOLFZUc1QTbQ3IUTkL2D5G8PYjYwHWey?=
 =?us-ascii?Q?GLlTKAOaWfAo34qRvjzsTxhWcC47jrVFS6QsLb7LAApWHjluxHqiCIjtZViy?=
 =?us-ascii?Q?YNuVbY43thEL0AzqtvIKrK3EGDp1Fay3APkOzV+uOjMwut0bYbjKgr46Koyh?=
 =?us-ascii?Q?5CxwHbCrmEfjIENQL8rLyft9XrupXge8BjN+mwrzqS1DNmUt6FyD+BsXi29n?=
 =?us-ascii?Q?+nGtbK2xO2enF2TRefKSyB0k/sTjiw4DDWYxkkbJW8ttNOgn3XPkuhTJRJ+y?=
 =?us-ascii?Q?/YAjf40VWs6W+UDbvZtKvX/zo8TMG4WfHw2J/Amcri/oQO/3eRPoWfMMBzzh?=
 =?us-ascii?Q?agpBlciwKbWRxKYlLctNN0HfVfaeNkJY7rp97MZpLbNdg0SEk+a0XOjvuFTp?=
 =?us-ascii?Q?Pri/L6VrtKBAPKF2b+NGIGkRny4vTbQgyf7mjJKPEnp9tRgYIjdmh+0UZB4D?=
 =?us-ascii?Q?WzSkU8dJRi7Z4x3bJbMaxpcVKc5NsKO68cFp5fkZL/b9qIxON/1KHzxkAVmv?=
 =?us-ascii?Q?Spvt6uAMSEPEcOOC+1aM1fLNrpLpW8bvX1+3BH9p7Ir2j+b8/erLgu08aC8l?=
 =?us-ascii?Q?A+7Gsi2jICScF7oZ/layUlNfRvdhO5tbmmSgMU+KR3aCLrtsBPfZIMEAA8RI?=
 =?us-ascii?Q?nxU8OSfdl8Do3d8i8x3Jr/CssdQqu9Sf8TsPkLxBVaA3edhKL8g2MVOADDub?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6DJL++zmwZ1qefdIHoU3jAw53V3PAsWJ2RwMztZNHlCbw0Gem4hs6TdfU9MQooJgQUyFqG7oQBskIJXKd7d6M4dylOJV4j6C02V5/q1RIx1ouC83h0oPg3xCrMKVgTxBwwfoNWo4Vu32l0jxHjmbMQvDt52AX4bSr4QzGesQA8DkNDw3hZ523qdYWW1kV2Vhc8RmxVH0bvWQwwPp0migYgFS66JEkq+2ME2vx8W2fyv0+b2aV0xnXp73FWjgBUb1gbU6vJk058oVi57gEGb8wKQNHaC+BqSd4MMzQ3ZaHgbwwaTizNG3lbQweKbPgZYfiXI1dIdDACTfdtOVAwTJ/PG/jZZOEqBcKsWB/MPwCRu8uFWN5AhmySxY7/oVXKjSjhaCz3VGTvktHIDpWW2SaHUYPZmxem6Dsq9fuAKBtbyLixf65DTA3i3i1V5h/DaUeIBXZgyN5uy/E9A2z3FEtRFD1ddeosPlRe+DVfk4Lawoi1gdvPBtr+zDELefMlpFdpltpa6zNaZPasmAaJ577onaG+1QdN2RH8pZeE4+A4lMkCmUuC2lKleFaIixjkl2FWScPkDsR9SURjajVmBDDkda+Qe0v8SnPb2kCLHNA0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75998924-8ddb-4b0a-c93c-08dca182d64a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:09.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmx/rQ36hjNjA7M5/SsWF7c4OoIb5TCM3w1/Ttw5zhbdNJ/mYSSIm7tm9Vb0BMt8cySW16If5C4PU0A9flPiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: wK1OjB0-xNFU_D-9oW5apdCVqkACt6VH
X-Proofpoint-ORIG-GUID: wK1OjB0-xNFU_D-9oW5apdCVqkACt6VH

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in cmd_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c    | 2 ++
 include/linux/blk_types.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb22e78c1070..971457b0a441 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -280,6 +280,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const enum req_op op = req_op(rq);
 	const char *op_str = blk_op_str(op);
 
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 632edd71f8c6..36ed96133217 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -354,6 +354,7 @@ enum req_op {
 	REQ_OP_LAST		= (__force blk_opf_t)36,
 };
 
+/* Keep cmd_flag_name[] in sync with the definitions below */
 enum req_flag_bits {
 	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
 		REQ_OP_BITS,
-- 
2.31.1


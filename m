Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE084DFF
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686242; cv=fail; b=l33iuFkr7uvEwDkx2LzquZ8xY4b2UTpZ9LPn0DVGmKHCyEOeBStda2ISa9Ctr7h4hoyzgBx+A2CH2oLV3hK2dxkWOxYFAHVZkZYSvboUFPxgSS1rQh8L5ehkv/oTaeR3ioEw3i7V5/iIyhETFx1sLhZhxBDwbniC7YEitw7vlsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686242; c=relaxed/simple;
	bh=njWmrOpBbYgvoTFzmLZ5H/bzYh396ENplbEbkYL3PPg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BFK41UFqY/GTDZh1uOh+soRoYaKKPYIUb95Lm0KoKLONxAf8GuJ2uSZiwJP05cUtUo+H/foK9On+mm2yAmwwaaBwwlCGtGJaT3uJA/pUoFqrEIA6sMEfD23j2wNOuN1FNoTQsaLJ7LdCttJR9pe27wyTnblTB1d9USPx43/vKOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YpSY/f8V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HMql+lIx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YpSY/f8V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HMql+lIx"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tVf0014041;
	Thu, 11 Jul 2024 08:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=SJHICjZ2Z/eJd7
	kbHNG1pJfpW0JRJnyaxng0aVqMPFg=; b=YpSY/f8VgwqiiVt8FSHVJYUdNDH0cY
	HpEG7QOYHGf7gK5LL3xoUJlRFKCU6nOItpix+rHUJixfi5g75/c2dFNNtPWHsHeV
	vsXkPlLxa5/mA2oqYeaHfaEmxVa2qSQwzVFOYDjJbutG1NiPa3kvdYQrXO9aVnw2
	HtwdaYpM6AY61hMKH6jaNJcAmZPV+fsiSK3ejES8HpD82Fm6ClKfHae0Vsb/vVQH
	TJdklXZLK12zFgydVHyRhsIHL7t/epd70WWKYDdNQ+1EdkXf1QEEG7FXHmLtQPYL
	tydKJNgP4SgtVpM6PjOBnH0s/2cjYs0pnDVjsK4dex6mryR/0EP9M8mQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkch03r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:23:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B6wQJk033696;
	Thu, 11 Jul 2024 08:23:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1wsfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkWwtg9yZw0Zip0lvCiT+l3H8ohgBc81XQ1WO4Ma75ynuaXvYAn6fQLJ+zSs0BNbRj2RBqWkNBHGiuIwXKjOiCRhpgwJ97KZfVGemLGX+xI5TejyG98rm8HomORMusuucuxehThve8kdzdL4NkBaLweL6qx0y8qy9HzZbVGC4RVqU93ooiTWUaFNNzqqmUL6zfSfnnKEXPyAGnI2yb6tscev2ooZYu7rwMG3yq3gj3HDdO7Yjg69LQykyerp8aAeBXvCwIzxJksGtMNa+k53ejtW6m5X9eTjZCqidvURmW6gMUZIE9AsVFKV73FcWi16Jww6yz5mgUnHQ56T6imquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJHICjZ2Z/eJd7kbHNG1pJfpW0JRJnyaxng0aVqMPFg=;
 b=BjL9vj1QLKEWLQ4PHY7eNFZ3iJ1FrsyAn20+7x0RCtCTDQFNOf+yomCElmriSgTgwrxVtarm5HpBG/hWp3HyfHXxTs687xRLWi0MZykUr0Bz9O8dvyZeT+EtFyJdks6wj7CRujrKGCtuNReC/OpS/JZTwlRDj+duvqYL8tXDDCRQJmKoR7Hiv7CtU2Z8XXJ2O7O8cqsB5jl7yrhoPsyycKAmXoxbuXwE+Ayrofc2zGbMi87rjnOPrBfS+VE1fuJcnZaXBJOyp5InBxW6CINMLUIGIxp1wsT3CtqIld+9bDCrUDPZ51zpM2tshtLV2qT+x7gNrqtUZgJ3RNGMn1dXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJHICjZ2Z/eJd7kbHNG1pJfpW0JRJnyaxng0aVqMPFg=;
 b=HMql+lIxLtWkDaXbPNSoSOeZEqxo+hrbhPeEXMFbAouEaL4PU3/GhSLYajN7L6SDpnrS3rnv5v8vvPf8dGAPI84F3d/ZKdrGcsSJM1G120Psit9MvQHORErtDvw9tD8fqLXmI7awzyFIK2eJHQmA2IzZ0dcH15NG17YzGzggD8Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB6970.namprd10.prod.outlook.com (2603:10b6:806:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 08:23:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:23:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/12] block: Catch missing debugfs flag array members
Date: Thu, 11 Jul 2024 08:23:27 +0000
Message-Id: <20240711082339.1155658-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ee6650-4bba-41c4-6db2-08dca182cc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WTwZlnhIts/+jOWkYhWcFhZbnGerutatSWu75SDHnNWIqWTvdlsKhL7nhpuH?=
 =?us-ascii?Q?6q4tFYJ1M3AA2K37ZIMDFr3K2+5DUJGxG3Au9qCkwhuF3PNwk8Su7JCy9WF6?=
 =?us-ascii?Q?mXHgOnOGE2gcqozBMrPmMj5nFxTAChG61TiHExOcTuZe93I+elhOqCHhwFat?=
 =?us-ascii?Q?DOIou/Wz+C17EWlElO2/ggvC++BpYu7cu1zV/E8p0jw3l6YAkP/VwYw1/keL?=
 =?us-ascii?Q?92RWtp3rIXaCmGIhx3qmPU+TolOKZ7nbjV5nvUNIrJbCjDkcoM4/B8RDUbZK?=
 =?us-ascii?Q?g/m0r5wlUncblwoBJzdZVza96XM7ImJdLsicjE2flWPgqQg7pm28YUQl3dIK?=
 =?us-ascii?Q?Q6BaOob+Hs9vhRA+BV2YDMZk8ScLSr+p4DcoXgUHi4iJp30zBD7eH0mr6EzW?=
 =?us-ascii?Q?O2iv7d1gG3jZu7Q/O6Ld3LCrqtJHEUAmMvipXBrcmJKHeuXal0JiH6v9gNay?=
 =?us-ascii?Q?et/2Y16jqcENDp9X3Wk01OSY9lP2MISquU2JOVwYFzMtIvJIlC3Ek5gY71QP?=
 =?us-ascii?Q?8v9wNcCkFSE3+WIuIn5olI5k38HNBmRgX/KGe0tifmMix1zU9nvaMlwbCvv4?=
 =?us-ascii?Q?xhiF70b/0f3aJzFThTQ8xSiq6d3qETyfOFkaPY70hqFFIbQRv72JxwsZFPfh?=
 =?us-ascii?Q?8bjhYsXplX8M1D01/J25OAmZjxUYqedSPmcUu0aSzm+G04hLSxpfELw5mrKT?=
 =?us-ascii?Q?u0fJmsUWkErrPzyb/jgd9DUW+i9wCfHHFbR8Y36aM9NstF6soVXGsCdKeHTf?=
 =?us-ascii?Q?pkFLLvwJ3U6lb1jnh7dH89L8ySfyCcGxjKWNW7spHNdE2X1fu71rLgSxe42X?=
 =?us-ascii?Q?VOuoCce2fx0J7oJBW1/PInDwIkTrT3TnbNvB0DdnVvaeDRaHPwthz9cdmfol?=
 =?us-ascii?Q?mUt4L519LnKPf+DcPonZ5xB/WYw4c2j7GENiBQivyTWteAmRil/ptKW+DM4H?=
 =?us-ascii?Q?7MdLJ262PqG4udZd0j5+/UYbfIJDbCEut19acvNx5fTbr4KI0b2VI8nwcJNu?=
 =?us-ascii?Q?HvovJNdQstpNJZ+SbfZpd8ch6O4oiHmBxaT1VIfudFIpFHdtsrULNDT0gFNg?=
 =?us-ascii?Q?OsgZbbvRPAvYH4JIy80ICcjrihLoAPAndNTVUWEu0Gs52JQ48qogU5Z2P9YW?=
 =?us-ascii?Q?4g89S+t+1wr4asnagZg+Lge0na7+oX6/aJ1H3fmgj7pHLqq7OlrVAKNmIc53?=
 =?us-ascii?Q?xMHwVq8xvtXY885V0Nc1rK6knWVVmmLHvvS1CruqOBs09oiWD4ZNcGCF4e70?=
 =?us-ascii?Q?6/3r55FZitJYN9id2SUQoJcUZ5O4g6DZgkGswr90EFBulBG+BUyTSgd094Y8?=
 =?us-ascii?Q?TObAffeTxo3QI/UStgWI4auH4+bun6+qu6RVtvz0m5Z1TA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QZZaGD1pzunwywC/f4r2KBHkDiexa/sjbLCPv3rjpGuKXferIUqSbZJ+730d?=
 =?us-ascii?Q?iBLokIpUNPTsLTEx+khhtHCqf+AEKw6sfWw1WvG7oxzHcd7xUwySoaIyaUSd?=
 =?us-ascii?Q?zuX0Txb5xP39gR5AUeInj1PfdN1nOXM+MjgagWY63aDY++FAAUYOYJbYCwqX?=
 =?us-ascii?Q?n10fCWcrAlxNQR/v6GxguxoHbmyJNb/Kt3d2acYt2Qd8tslr4s7eOvogkUck?=
 =?us-ascii?Q?PwqiheMTAvfbm7qLFPKY+FzPGhTgFLko6XtQVx+1SgUb7hhoLBgx0lFH3cE7?=
 =?us-ascii?Q?CaD3cnaU9OFRjpEtYramaaTffWX4r8V+/+tk1Xt/3NC6sDb8OPEiOgqWmATF?=
 =?us-ascii?Q?BcjfMDVq+Ye+ZmieogsggW6U9Gsjvee0lbJ5VCkVlzdUCPODfcoE//ik9Qhf?=
 =?us-ascii?Q?Xo5xCe3zWwEooju4BZBOTfacmLTbRXL6bqJT4wsg5iZaKvypcDCheC6yS91r?=
 =?us-ascii?Q?wu62NRGRsxA/TBYjz9IQ6Udy8QCmL1JuJr4G5I3ZdtAd5LgTYypBANkKS7lT?=
 =?us-ascii?Q?IBR2LhquHquzbZokgoWH4KPs3909H6hc+WcMVGmm3MjjB2xtajHPnJ1Ueta0?=
 =?us-ascii?Q?O/mlmD3I271tXjEwVXXRiETHaqDus0O0E3ldyHe18uXPLWni/0n6iR8kJu7T?=
 =?us-ascii?Q?2BPpXpSS+Qtl+/2JTsyzDzn0VuPvl/oXsSAb9laJTuXaqSPPIzz9gcf3JU+B?=
 =?us-ascii?Q?ZXp7aaTx/Dhvq5tbgAjJZBTHDgV+gHx8PPWM2N6CmNT94M2DTRiUaFyAJbxt?=
 =?us-ascii?Q?Iwy+naGDEmVSvfq+ui4pftqMoolZWQFas+GeMSOyEwf8qMGuVEMzRK0hqvni?=
 =?us-ascii?Q?BXdp/p6LQjIxqPvGguSHLoeiB5p8poZSVEJbiajYa2lXvWzgQKDpnZeJA1Fq?=
 =?us-ascii?Q?x/ZWCaCKQ5Cqx/7baEavYzRBaLTbpq04WPfWKrFMIOSyKADkgxmD96pPL6hA?=
 =?us-ascii?Q?yUF+7nvyFCkFqfeVGiwMCeS4bkRIhdjnw+bSbYLBP0Tg+7L1o1dSg55wD/Ai?=
 =?us-ascii?Q?d4tQzusPS2DDZroy6vLrl9Sb3OjWzLJaJ+n9v+pjFzWRQtT2v3pHO47CJEjj?=
 =?us-ascii?Q?QplSeHWSqiXLzzQSC6Py9bgb6OACOfDVukOUCkKRhvtIchD7jmuzSFs83OR9?=
 =?us-ascii?Q?swUeIVkyxhZ6DTG7HgjnxPyMN8bxlWeJRY47tyxtWqE+cqzuyG79DTUslMyv?=
 =?us-ascii?Q?MM6DT53eYgspklTEwI3iIlcBV357NEPSwYfiXA4M64/VUB/vKmE8q5EiWwBU?=
 =?us-ascii?Q?+J2+A2utOM/Jbp1hsWBBZvXhJ0ALvh8ankvt1U7I8sQF3qB9ZS2JEB/v5gfG?=
 =?us-ascii?Q?s76lz7bNwZE4aKMUhUO5zvYQIaF1bi8nuODwYT7k28utskQ29EbNo69y5ZiU?=
 =?us-ascii?Q?3mcRvb8j2OUsIzdotN3MBmGQuUakfNBKrr8fFOByGdBr4DqSidYeH2D2GRVN?=
 =?us-ascii?Q?ttecIUh1ebvnlXMOkHj5Z/UWu10pG02U7ja4jWb7nIUtCXCYLnHDHRIeHq9b?=
 =?us-ascii?Q?uGFib4DpaeFQXxfqvUJ2STAki8zyikz0/egEGzoU+EHrKEt4KzrpaL0ate4w?=
 =?us-ascii?Q?CFmUPUMGm3vtG7YLHeMBcAxBGkkVpQCII1US8V76252XGP1Me8Eif1SX6sLU?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aW/zlWEm1x7KmTSJS+8GtP6mya5jS+ub8qJXk/ayTf3Byw4XFXF0kpD+Ch2rZPFHWT+nzUnvdXw+cMjzn0d8zFWvJyh8qwmh9Kz3HvtPOqznOIhyysLp9Z6Kt8uqPEN2lp/mq6QxhbyyxHanoXfauWR5a5+SmqQZhv13Uf6evpGPjYYimhnIapjjG/+tiB6S+LxfPlIgRAyt95wD8TSuW4EMAR7XTauXLJiLNt6whis6INUdvu5vCZe/H6VP/JBsHsS3jh/h5dKCS3Z1w2Xl8jM9KCp1BmJieBHEnYrr/NvCwGsxSmvQ25S8U/Cosl7DAvFX6c/0q3KzYhfZpOmAhu6PWFWQZJKacqZajpXZz44F1VJuTbpzKdHKBIZvAi9jg5TIWTj1tD+zislzOhVUVYPXXNSZrBu94IJqUL3z+CmNCa+8cJfGTTLNl6HN9J4lwzXY9nLDQFe+z8k2kM87HpPeV4HgvMFbOcIxuas2Db2zbNKDFNMmIbFPdOULuNiYZVbMP55kn5RJc+azwe0HHTQnxsHhCQSSVs8x0PvD2ikJxS4E9zLQ95nVAboOmqDTnmcjq8GDRRSbV9MRs5mFIKt6+suv21kC/onK0vcvdA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ee6650-4bba-41c4-6db2-08dca182cc99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:23:53.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV7SrDGppsaCS1VO5j4xS1gXzVBqDvip379OD0AY7W8s2hbtDPB2IGjaqGf1BU7pjKnbZWtQyBOS1O4/4XXVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=688
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-ORIG-GUID: NZni8zGY2mIDT4KMeY67C_vKjTt6FsyY
X-Proofpoint-GUID: NZni8zGY2mIDT4KMeY67C_vKjTt6FsyY

Currently we rely on the developer to add the appropriate entry to the
debugfs flag array when we add a new member.

This has shown to be error prone.

Add compile-time assertions that we are not missing flag array entries.

A limitation of this approach is that if a non-end-of-array entry was now
later removed from a flag name array, we could not detect that at build
time. But this is unlikely to occur. To actually detect that, we could
make the flag name array entries a flag and name tuple. That would just
add extra complexity and slow the code, which I am not sure if is really
required.

Christoph Hellwig (1):
  block: remove QUEUE_FLAG_STOPPED

John Garry (11):
  block: Make QUEUE_FLAG_x as an enum
  block: Add build-time assert for size of blk_queue_flag_name[]
  block: Catch possible entries missing from hctx_state_name[]
  block: Catch possible entries missing from hctx_flag_name[]
  block: Catch possible entries missing from alloc_policy_name[]
  block: Add missing entries from cmd_flag_name[]
  block: Catch possible entries missing from cmd_flag_name[]
  block: Use enum to define RQF_x bit indexes
  block: Simplify definition of RQF_NAME()
  block: Add zone write plugging entry to rqf_name[]
  block: Catch possible entries missing from rqf_name[]

 block/blk-mq-debugfs.c    |  26 +++++++--
 include/linux/blk-mq.h    | 109 +++++++++++++++++++++++++-------------
 include/linux/blk_types.h |   1 +
 include/linux/blkdev.h    |  31 +++++------
 4 files changed, 109 insertions(+), 58 deletions(-)

-- 
2.31.1


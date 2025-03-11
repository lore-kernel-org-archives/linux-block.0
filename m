Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25125E812
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705379; cv=fail; b=dxS5qL1LqcMPhRtSUZ2UVQtAUoZ9owPEBkM81ZZc3x5Qbpsu7C2PdvkS5hyG02sgmrf6xsACGMpDNSjBJWWLj3ixMTkg1DcvzM1Shfo0tdMx1JFzZ/uDNXCX6uYKgS96ZXvrwgR/GxbPhnk9yAkJWyksUoW1kGCGQrquW80CX10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705379; c=relaxed/simple;
	bh=20aFzDka0sU+K0CJGR/cHpbpKvyFy11MddU9MTSL/5A=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=hlZlfyp/lp8HwfinMIdppTsoBuINDW7li33ZpJ3vJH2b0w0+WFsKHwR2yODhUw2e+9kKwo05QurSKFLh+MuazLeuOvoXfc40rWcBNypEmI8PeLlE+qtQngdrYqtNYcC+QEh/KZCl+9aOeGdq7g+hU2ikUOM63AfiG/hUC/JWEC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fW2ihWX6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uv9bnt3Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fW2ihWX6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uv9bnt3Q"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMuND028753;
	Tue, 11 Mar 2025 15:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jeQBF7qGGv3OVuMH0F
	cSFcW02hx121Y188nSuR7aCN4=; b=fW2ihWX6JF+A77Vlg0aXon75/gfyJLDuV3
	neCEYgYngpASAGjR5LE7U7zCYPQrb4QVvZPk6arh2j3cA772QOw0x0pBho0j00tw
	mJPMlrVaCEXYTTbtH1DOVxdasQFuhKrjEpNNaM7TcGwqrRutNAoVMmLzbGOu2v1w
	6a+xKilq4K8k+Pojlp3uFYU4xSQp85nj/Q3idMoHK7SVY9JstE5qA8zOiW3ug7DM
	uwdsWSx0fwaAEJYyTF1jwcVGioxejewFDv+LWAV8kBXpC47d/TOv25uP4MiASvcZ
	SnxG/9x9RN9wOMvHn+9AuUhPwe3FtzMf/oZDxAFc90ocYlGl0pkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu51n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:02:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEupsQ030533;
	Tue, 11 Mar 2025 15:02:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcngesb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXjsuMfUXaCumdY7KpeVMH/Ls8JrWaAkx6RD0oBa9dp/jdoh2kZSEVO95fV5j8Ryj0fwy8SNI+kfcJOjDdONR+HBw+oHskZk7jxR1fUGFV6CHZ0Got+5oRDG0TRNIDTCirhpe1rgfTMtvwhgjC1eyYwGgKiBTKRQCaeNjzCcWV6QOXeWnIpYzz/0L1k4CTW3y6/Ia5udIl707jRmgHv7+71iQkABxStyxFb3PSTJLCd6CZpcbAv0e+9MpehFbaNKMZnMnaz/fkWgM9CACU4pzv4gjnO2wuhNBVHSnmcZmKDtTR6008OotH/nq0pEFkzWWACAPcdhX/K+l0m4bKcJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeQBF7qGGv3OVuMH0FcSFcW02hx121Y188nSuR7aCN4=;
 b=a1679mfhlK2634TnzhhX0PBokuJddGVYNsqz35mMvTa48hrX8C61KhAaAYPivbVIFDyRgCFZNe39JXh4Hmf5se317xr09kjFPDxklA03il0Fd386Kvq3G/H87LleWeTEsC01iDCfQihojeRG8K437BQ0FrmvX6HVWVWTTHT/kVVkjZpjrY+MbjnLwW14Wbv1Jp+o2TBar6f3cfuZM7dcM5Oz1LfqgE9h22S/DsA9rWZ7082d2Lj6Uq6JEc5jShf+mhPNDNwMLeWzTdFbWRuV1eIKvYsBXR5lnEWTuVWElsrhb8AZ2dNDx/193zpSQS/WJ2fJy9hcwB/ICbnTycCY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeQBF7qGGv3OVuMH0FcSFcW02hx121Y188nSuR7aCN4=;
 b=Uv9bnt3QNQ+FZT1zyepg/3FGLH85ozLoa6A4rorimqeghOgHn0Fq9qBWGZ+Zg/rAi59mlTIKkpvrIWPUe4YySz1rj3RLVHxyb47ALlPDuSiJnRnp0LD0zzVYPViomFLeC57nfjZpRI8ASdkjxfQQNqk4OC5Vs9B4oye8fHjMZf4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:02:39 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:02:39 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Allow REQ_FUA|REQ_READ
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250311133517.3095878-1-kent.overstreet@linux.dev> (Kent
	Overstreet's message of "Tue, 11 Mar 2025 09:35:16 -0400")
Organization: Oracle Corporation
Message-ID: <yq1bju7odgv.fsf@ca-mkp.ca.oracle.com>
References: <20250311133517.3095878-1-kent.overstreet@linux.dev>
Date: Tue, 11 Mar 2025 11:02:36 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a9ea95-0e61-4d31-3718-08dd60adc408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4U4yMaOQD9OAN5r5qmOqcwhvzwsxJ2NEnWQJhhzFKeXlaM8Fmni9QXRfKCbE?=
 =?us-ascii?Q?IBbR6nk3+gGqGojKtvwne+g18WIISooiyIzLMCBsgggSA7ctltcWlOAXFexp?=
 =?us-ascii?Q?9e3gc4CHe5O2qVQUfZcdYC7WYHYnePY9gBjNuajsl49UbWNilpOc0xlQgkxu?=
 =?us-ascii?Q?8zlWenFezB0V9InZwGuURv3CcsfoWzVhAQ40D8DRVYkFb8qhe5tX6jwpj9tc?=
 =?us-ascii?Q?8YO3WLGeomDR/aXRwu9vxwAKlUqAcAikAxedzZhnMOmnUYXrHJ5uHvApn3cC?=
 =?us-ascii?Q?NofkldjnqWPXml/kD8FPGw9upp9w3olsNKa9pvv8Zo/JLpPXQzokZOy0pVCq?=
 =?us-ascii?Q?a9TTWVdzQjoO48b8GE9qVvSzu+qIo3JeeHxHXBObjm73PedMlfvZlt6rasm1?=
 =?us-ascii?Q?v3YQ5OpMUYg4VK2pL1kv+UKck0+MHiOLPO938MrUgQ0cLh/iNeRmBvMB2eu/?=
 =?us-ascii?Q?EQPNEYahuUmK4b/obyavqOqad7qJbLiv1C0jQ/nBcbFTy7Gz4bz+y0EnLEo4?=
 =?us-ascii?Q?jGIaDnJ1O081spq40Y4u4CkZS4BiDdzflnzCIDETw4st3q4BNRgH4jos2CMP?=
 =?us-ascii?Q?KXCYRY8wiLjIr+ICT6AsZbS3L2Dqzrr/9HrbZ/74FfcgmJcvjxa6TfpDjYLd?=
 =?us-ascii?Q?Y58/5vKcbpEinLbtsTznr/CJyqbYMB0I3N7FzfqlFI/gFCt2obzGuRiQTBdl?=
 =?us-ascii?Q?7hiM7wUJyKWqwiz3y33xQbus1qyTsvt4bzS3W/FghiDd5V0Xkbt6cNCD3Lyc?=
 =?us-ascii?Q?qh5NRj6MDnTlX/xiEFA6tiv+p30gK4ykp4FdkLgp86R5lhMmBr2d8OBbQb12?=
 =?us-ascii?Q?n6udYTbqHt7QgUWlmQHMFhF8CzSHCbjkYVoz+U1uLc8Iy4RuWeNUipxuNQS8?=
 =?us-ascii?Q?ajfYkbrQLkvrY5HZ6y00sBT4My67nWUUVS/47HsSXSXVgoEDKB0esaNt0LC2?=
 =?us-ascii?Q?5Y+EzoCZnlll6bqTwhIHnqVyEMF70+2Zk+8mbjB9VfdZYmbIUIdY+9X9J9Kt?=
 =?us-ascii?Q?XI3AlConhS7mwKgZYvApklQ1MzyQqrIz1dG/hGtkBMhBBfsjo23ywpTeP1QD?=
 =?us-ascii?Q?gYJNTP9g/6eB8hoRZBioQ1TiZfjXRc/Wt5dVioPQ/n8QHP8thQYecv6DqY44?=
 =?us-ascii?Q?CT2QApxsDf6BCtL+PwtqAwYyxf8uTzQlnKtc3ZNPQ+2V71P5b1NBan52kcT9?=
 =?us-ascii?Q?izf5UFXsDrzcQFuh+GtsDgqQ49tEQ5uNFhN0N/uoDCnGrCqfcG5er6N0CyYW?=
 =?us-ascii?Q?2ACLPVSUUAeW5WE1KR/H359d+01UNL3dV5b9l7WV8VqA6Ef1RsayrYBJE2+f?=
 =?us-ascii?Q?zaaCMuG6wsauhkvxj7qMXk9Nlfrhb2JYUXthecB9teqoJr94Eo87yjcXl79Y?=
 =?us-ascii?Q?TjNkDcWTswO4m12IhMASZT1v4cI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSPs5AC9assRNFjzl+nVie3uT0aZkc1cnoL4pNI9JVIbGRLiJgQVOWQK7aAW?=
 =?us-ascii?Q?DXBMzp6r0Kto6VmsrsYyzdXCZGW8HjQZZic+0TBXoR08AXa0wHuRuctx2BEX?=
 =?us-ascii?Q?Ki/2GpdhtRpbqXDOFoNqq6N1XalePhEyuQr1BkJmsP9fnF7nXYV2N75751OF?=
 =?us-ascii?Q?ClHTlJGza9QFi6hI70HR4slbkEy6zQiPKlf61GePIKRgMz8pHxGjFAmSvH6G?=
 =?us-ascii?Q?pSPRvg+IledxB9EJZY3IaUI4VrrAb0T20SVzc1JLlnnjR4K5ZgFVZT4hGvdf?=
 =?us-ascii?Q?I84nqFuLniumvQ9iwK5a9YcKOQKzvVstZWzBpNMcp0iQLx6JETof6UbPgflJ?=
 =?us-ascii?Q?GpDvjRrVOX7au8iUTiUXctnMW1QzQqZFxW5XOO/gHJQl1P8WCj8GL62t9OJR?=
 =?us-ascii?Q?bQ1t/JZ1I6T81we6QiUPIfIY/Ldf/XEkntb04zcpMcqGF7K3DH8ocCZco7uP?=
 =?us-ascii?Q?KvVVHcO66I9yWwUkRcYZwMspEKwLmpU6+STBz6IpvvgIZHND+E2kB64zc6xv?=
 =?us-ascii?Q?K8Pu3FqRyT0GtRYEv53Ia0MTD4Vfy9vZN6yITclqV1GTC+fBJpYVKRYrHrUZ?=
 =?us-ascii?Q?2LEGMldzeJo7mRBq++t5e9H+otDaQR91ngZq6t2J9hGkYVf76T6Px8asWbL7?=
 =?us-ascii?Q?cJImr9S4pskeWWgPkWx+bQ4FM3MB5orxKYO4Gy5m2o7eeBniGSuLT+5kbRu/?=
 =?us-ascii?Q?MdLbhan2mcXCdm1oedjpCgsOgz3KUP8e8fJruAI7MGcU1vh2xygD3N7dJoUg?=
 =?us-ascii?Q?pdkGMB0JHftFLLeTX4oOTy2y3M0Fahgcjj4pqUIY6cFQ7uh7RYoyNId+kCeu?=
 =?us-ascii?Q?U9JJ6gAGCXORkcAmQfVqNogFuPlCgm64+AlCQ5oyl2kfCMU/4x06IhfKLipw?=
 =?us-ascii?Q?daDb9WKWzlLnaKoKFatrjvkf7352wvyPyecNCn2m/YGkYbaLhBIAbcBWyl93?=
 =?us-ascii?Q?qUGy6zTt3Gdkox6KMGIZDftRWGAg6NadFJ2ZJmxq0IxFk6curR8rQnk5oHg1?=
 =?us-ascii?Q?I0zjRZZJjL50Rr/aGmoAGu4NtPCuVeCf0/j2VRc+5uBF/2IA72nZaEImcNmK?=
 =?us-ascii?Q?uVF704LvRCnylbJhL+dQwOoael9tIkRDBO0t+mHRY8+4cg1W1en8kddpO7Os?=
 =?us-ascii?Q?qy9zK1fytCAeh5RxPf8AnoVarMQoRuq6Va+YhmHVVmRdxPR3MDmtRLcDNQrp?=
 =?us-ascii?Q?7YlWhZ7I750TVj/HDaiqGIW8k9vnWSvdMj7xk90/OfpaQb27g+7Ve9iOQJo9?=
 =?us-ascii?Q?eoLYJx9/egAb05GlOPzVRue77Oi8gwajuDvtZhrZJUO1Tj2JfAngFtB+uJL6?=
 =?us-ascii?Q?o1pft7RmyhaZ3KJH9vDXGRw1TG6KoqbCbAUJfk1Ka1pCmO0iyt/fTi1zfyC2?=
 =?us-ascii?Q?2D45Uf3rq6mSxZB/O4BF6NwP06R6aQX1GOUlRXhhABjwD3aOnPAB8nBq3bc6?=
 =?us-ascii?Q?pRL0B0/MKVq+WkAODZZ8sFSOAlIF0NZPWVMYTy/pVe8VVee7dBISJo55MboI?=
 =?us-ascii?Q?JYMznaOeD+0oi+PkxIfnMszngv6TWPm7Lwj6r1qzvLhxm39QyEM44AYMh3tv?=
 =?us-ascii?Q?S2yxdRR/865sVgWGUQvTyD7Nly4sXr3CZQk1ka0dqvE8hB7Nao0xDI0i1n4m?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hcJ2RwXQ02bAz1Gd260GKEDV+3WOPWPJSpWBKEdDeuMGxDsxLs+XzymnrFZjxV7sxLSAbhhTy8+o5NSkJqLPnXdwMU/gJFTbcBOqSop6SUTyfAs5FrOJ9zcboaNR0z0mn4hm9HLFo5zX/C2NDR3EQzjembPp9iGlCCp7jGicr7OAGTQgRSVTBqT0oeLYlVR9J7twOAkXCVIwg+sa16ZHwwtUTcxNsaqD7OoTl+Oplz86bUbqvYA3B4EAS6wZSUjEgNzz5pUnSu530nUDaHLIJuRDRnaUjol1jIjX43t5MFshHGkxz22cSK9+8SA0mrnfuv+RtincsBEttx1iJhOLS4Lkj5XZ6u40cJLR2fuAgN/t6todfXumDF6XVbQZqBaoFnTp4r/Bw3nKb1VB0629qs+TEpXMW9vacwaFiw2NnOHYM4B38dg6RLarBfic1KbZid7E5181bLE5X2pMvWE+6Lik05yJyzDy1Gsn5GVvGphtEEreWZM1myHEnC9LxpX2cd/oBNBrxpv+tl8unlR3SR8SiNqs5UUvt+ECst/a1E6rJF3Erggq8QJBNHUuJrzmAur+vpNKrfoTVLUXpW0QP11rHfM7MIeZBTnGlyjri3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a9ea95-0e61-4d31-3718-08dd60adc408
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:02:39.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NnBp7OPv0M/VDQUb5yvAJ9sgltKcTigZjOuzsjzyuWXvVd2af5ShvKATMu0fqAGSJOtBmpJBgQ64gYIi8OpIRXh994t7PA86n9B+LmhPeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=784 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110094
X-Proofpoint-ORIG-GUID: z6mQjRgvvO7aUf4dRu-MdX3L1IvnZp9g
X-Proofpoint-GUID: z6mQjRgvvO7aUf4dRu-MdX3L1IvnZp9g


Kent,

> REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
> the same as writes.

FUA does not bypass anything. On the contrary, A FUA READ causes data in
the volatile cache (if any) to be flushed to non-volatile storage
(either cache or media or both). So I'm afraid it has the exact opposite
effect of what you are looking for.

-- 
Martin K. Petersen	Oracle Linux Engineering

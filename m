Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6A274B2C
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104060; cv=fail; b=PKA4dYtB8YxRlUwsAn381cjrEOXV59ET5PoHD1nHxrfq/MKzgOzEpxHv0S/kWBGfgQGJGRa4WCxsA1iy/n+1IkwkVMMfQ3e4M1iSufwyJWjD4OSIRcxFW7HhIZB5GurdHA0KXi8EKy8AZX0Euh83Rhb8+u/6ESVlQlJTOaNnIgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104060; c=relaxed/simple;
	bh=Ccwv3ARcV+2M294V3Mj5MciZ8dJpVe6rHnqtXkinAAQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=hurTcpBjc8iYSvGKP+cNikDCM4mzvSQaWyVbOQVAvGt9AlD5qp9bPMNOBNuzoWsvYOOgXMMfQ4bRgqJn/+G/H4FqVjxFI0i3q7sZUON3lBMpg12vtgLcx6PXLLSDp9dtt9RgkBSAg6sKaMUQ2qUp00f5VzRMhx6K0VJdBe92PzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F1daH2MQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fi8fXN+I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F1daH2MQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fi8fXN+I"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DGC6s9021725;
	Wed, 13 Aug 2025 16:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+LxecpuCZvIekeN57G
	5zEDH0mnhUzOmkr0Z1z49KAtk=; b=F1daH2MQAu69zzWpKuhVUvnaE5E1Gpyu7q
	v8uw9OXLP+BUPRyxakb9kpX9uu90i3/r1CQI8Fz3qehxOBEIL/O1SJKIIxcQZv9G
	enwLR042nDtAf2YjiPKJFCAB4G488XLN5ZTtHOlfS/LmcqrZVD9oT7XTQhxHFHuG
	8+yl6j04K4Lnbkl/6wdUsbSiVEPrZqpVwKc9zPxy8/xFpT0ydhsx8NDjvLH/FN3q
	IuRsCdGps/kjRd5gHHNv/WPgttCl7tBClI/v7JI3QirqL3/Pw0fN0lXtymavRC0y
	DfHV+KjFkTSuEAy2sqOMyxnFnzhmzlPPIVZqC7ax1gsYAshtD6EQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4g24f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 16:54:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFPhSv029997;
	Wed, 13 Aug 2025 16:53:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbnfyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 16:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuXd0sVpg2mONrU2Uv10gsDHLik8U63JHdMie8dUE4rkHDM3+9eec65vEq7e6587gi91AIOKAvUkSn07vGcnEbvKYR0layK5fU9k/A7IN+1zXy8zTmORDJQ7buZMJhaorZNnTOzpDQ/Q5dztvs2Ma3vWBlPKsTjBwZnLzS/naTGo+jyiw3DmxqFe0Q/g1pb/9V6QFlch+wNCB0f+R5ZaMbJYCVcML+dDlxXlL0EK92kxA9myoxtVT5gfjRyC4tbsssVkCrga1MSu5kneLaSqAjAz9cEauDA+t0d8v8LuH416FX66L/SfHOeAvm6oR+CdOMYIGuA6a+0t43buvOUf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LxecpuCZvIekeN57G5zEDH0mnhUzOmkr0Z1z49KAtk=;
 b=N8JD+6MbnjbrODAGi21sXZ8+qCeCg6XN9soGVc3B3BhMSXZ75HWyk2qGZ4DAyev4M4UyPi3rPzdIiC2V9ehx0Fu2RANSeoON4yoFzCR8qTq/2aZM4mPKc1gnW+Yeuc2cz4Xe46w+O9tETV9spXf2nW1xi10kvnGTxmwvPPKagKaxVQRDPTjwAVLvzuL/w19FXCU4/pUBsrRcrOiZjNiIFGwsn3GPuaPsjhz5hmze5gSwarA7uUBceHfZR/zGLEdyIF4c5Y6v6MmsFD51rqPJRsabdwG+g5NJdplRBoTXMRl4N7LBG7pzQVDuAE4E7K8+NlHkzXxsTPesSsAZv8Dg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LxecpuCZvIekeN57G5zEDH0mnhUzOmkr0Z1z49KAtk=;
 b=fi8fXN+Ifs4s2IrOyQZ5uarMwu27zwJghoH8yfnNRzeOyWnv2IBisSxqAZNbJdMEIapzlFMQlUALLla8/UUtS1oyR2+E9bHhloH5hpkjPOrlftibg7wFilRRttwPzP0X1ABcF5OVdLYkvZwVGfF4GlArr8wJ+DQQksZL2p03BXU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB6151.namprd10.prod.outlook.com (2603:10b6:8:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 16:53:55 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 16:53:55 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv7 7/9] blk-integrity: use iterator for mapping sg
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250813153153.3260897-8-kbusch@meta.com> (Keith Busch's message
	of "Wed, 13 Aug 2025 08:31:51 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ikir2mff.fsf@ca-mkp.ca.oracle.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
	<20250813153153.3260897-8-kbusch@meta.com>
Date: Wed, 13 Aug 2025 12:53:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::6) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: c49642f8-7979-4222-acf0-08ddda89fd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nJU+sfvgTpXPSrS3Xrjzr/O+7dZHz3rSFefN/22RCudWxllaD+ru/7CDbw1L?=
 =?us-ascii?Q?VLaK6pv0Jm4VJDV2rs9G47WPgj/s/nPsdejnSvnHNy6Lrxiu9bDgxArgdr2w?=
 =?us-ascii?Q?8YumeTdG05pt7BDj+IFjJawla6aB1ZU0dRbqXkE4SF11DBwOtErC01iBKpkK?=
 =?us-ascii?Q?1bPn+E44xbc3iZGGgV4xcmTXIFcAbf1SO4iBjEvePebPaRui007s4JyS40Wl?=
 =?us-ascii?Q?j+v20fe9yff4XqdM+zkZlvn2vR5EI/gq8HXYStTYh2u2i7SAWFM9eIG2o77g?=
 =?us-ascii?Q?5YvSTObqcqoeI2/Ix4x+sqZ7I6o8Lf8y5F/DZ5Tz27FbdVbf1n22opf7TLT+?=
 =?us-ascii?Q?/LYasgQ5WcYSLsY/smB/Bn0ugYzt5NqhVZKVxCiLzcQhqRFqqBdFZZnLh9Sr?=
 =?us-ascii?Q?VbkuxZzb2eiuC/L8cdafkohud76MA63hkTwaJ4pVVVQJnYVK+Q6LWIShWssk?=
 =?us-ascii?Q?KcfCfvW67OV0egN2OjaVM2GlVF0aUc13GcNfvwG9u3ODlJHeo/evJo4XJa2S?=
 =?us-ascii?Q?7/ZaQYn+SKdeyba6jCuKAQkOTJ/+HTe081mg5yIw4dksFeZm+wC1l6EzGyid?=
 =?us-ascii?Q?KgwpR7tfjApuHD+nFVTFkCVZ/UGMZLIXdoRuGnDj0L+4sA+JMV30qe5Pww9Q?=
 =?us-ascii?Q?JDvP9gzyj1J5X2n08FrFrR454UBZq46D8SeIT69zJfxFTLb2eGpnoV/4GlJ5?=
 =?us-ascii?Q?SGBfE9CKoNlyybtDQ3EKxobucJ36zLpRnEPEvbVtf2DYNEihKF1pxMCY4LFy?=
 =?us-ascii?Q?yow7RIKjbA2pDt9//+VeqArbEbDYQosZKWftLhHUjjmWFUgWnKhg7LuggYn2?=
 =?us-ascii?Q?9Szx3ylk/GxVgSQBQNFcEZupaqwz7t+/jkiFy4pMTrrENmkm6o4OIP/RkETO?=
 =?us-ascii?Q?55Huh8VPAR8uob2ZiT7dWPmHmiGSYgYeKdlU1peIw9zHgp4oopq6EJJx6b5v?=
 =?us-ascii?Q?VnejcB3Us3i6bIUihOoR77vZ1KjtLjSA78FgbZlnh/93zXl2895WP9LA9SfA?=
 =?us-ascii?Q?XTbrAgEEF5G0M4C/r8ugsx+X88+k58T4Jp/jTP2EXx9W1LdUhUjV4bvTDUQl?=
 =?us-ascii?Q?2rYT0IOohqNG0nW3OQwBlRFmfIagwIpNEknKbEp6Wi943m4v6hGLc9/TRYm7?=
 =?us-ascii?Q?4+70Ci3ccQkt3/lnbieaIhkJxQgRd2iadK4DTvHfx3Ew7y6fPSfl75C+SsHB?=
 =?us-ascii?Q?YFPhLWJbDs7Bn6JNDpuIiJ8jn7onsvF+bJ58SViaYLlslx6/xdZ8nRLh/tGZ?=
 =?us-ascii?Q?kLjY0+AoKF7IDuxQWWNE0VnLc3a8lNdfC3KCDaGtNmGDLtQyvi1eOKJS9m+e?=
 =?us-ascii?Q?VHHcgL40y7bELSfsGZ/H5SHLOwzMsJoz+TvzxdL6nfYvkkCXLw4uyhpzD8cH?=
 =?us-ascii?Q?0ykqwnCqDaUnH3B3uEgNIJGD+Z2R3QeRXWRajUwKgwbWFN65bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uE3MZA+NVWOwnwrn0cVdXd9vevvE4XjIKYUF1PMPJDbCbbR//h1zDKdQkkU3?=
 =?us-ascii?Q?+rt+O6riRUas9HgPp8jFyRdonRL54PxUI3tErgdDsW1OIeYTGut8NT92vm+e?=
 =?us-ascii?Q?6wJSU+Wt1AvQoQLqTKrmN9T9uQE2+24ALJCOOwIuVx8hDbhyTQeVfBeti7B3?=
 =?us-ascii?Q?28/sHAVBKdWE+WyMJoJq0oGyLu3zJVF+1P4ev3KCXJ06uHYZ6Ln155SMBPq2?=
 =?us-ascii?Q?czEb325cJB7C0D+XTmBClp8Dup/ygJ8PmtBZD/2kOMMKECqU9riPWYpAG219?=
 =?us-ascii?Q?5W5KTUNB0kfsIxPJy8Isu8/CgzcsUSjahNfVOTrmADV6sJArkkoBDsq6iVq+?=
 =?us-ascii?Q?7B0BjF7oKWNPHYxdYTkYZpuC3UgMnQCpXsDkUsGOUH/RtHDo+ns+bQgo24Nu?=
 =?us-ascii?Q?QPs3U94NV52s/JT2AWFJFPWFsfWsCVO4uLJYaDw95TFaCjWqWCctBvzb4B3Z?=
 =?us-ascii?Q?tD4GhGpPeLaWjJjU+31qaNIUjBiNFZRWzTr64cmcg12DFvEZy2EytaTJHv1h?=
 =?us-ascii?Q?k58icCPumIQP8Sjh5VSERrdvQDz2SgMSFTnkJCvR2upbym2NkPvWDczb1vM1?=
 =?us-ascii?Q?KPEbWcXCGkEb37nsh74eNVaQQ3+rSySR0aHHA5Vdt8N1SaHxvjUfaZGrBU5x?=
 =?us-ascii?Q?zxE5kMHpDUb0hbOsrGvhirfyxsoKmNKbCqJzKMxC/dUo9P9MGnsXRz5TX/Vf?=
 =?us-ascii?Q?76esxjTPrYcS0zpwFgQ/5CX7Gcud9W0dxyhrwX9x8hPWchwxLOGgjYRZ/jHD?=
 =?us-ascii?Q?+MCFqaJLxJnZMc9pXY4wSnj+vVky4NLmY79422891gbby5QezpbykyLV5T4A?=
 =?us-ascii?Q?KDXUY19HNXFYSRtuEUdoTcunJ5wBoLYwHjS+3AeNW0r7apoeOfp7LKFJGBJt?=
 =?us-ascii?Q?51M1eS7/nWlY/tObB5gzfbKdhcrXav03o2kcJBwULNkW7AvovsxLb3SxXSIT?=
 =?us-ascii?Q?BByIFTvyxbNBawsjoW7BAmgSrgGFxRugGIuxpHagilCI358QWi290OjrfZPK?=
 =?us-ascii?Q?DAs1R67RLgES+eU6pVNEb36mE1YY98CFawZf0EF4yO4+y2/k0i/MwXUG/8N/?=
 =?us-ascii?Q?N7wtZyrJA1o4UpZKisJALD0NCgZvXRRyOI0aqleShqRCo5XszGa0qPS+GgVq?=
 =?us-ascii?Q?gB40nXrc6g3tT22APew8CIAsYRylnRaC7MHBt7bZJmuMBviTptgs87hlsEz7?=
 =?us-ascii?Q?T3AZMWc2zOCTrE7hEM29W9t3mGzHYJ6xfajMUC3Fsj1bkY4oLcsXzEtS+5AP?=
 =?us-ascii?Q?cf4CVW1lbJSJfoXVS6ctsTJJwUty8W4HM5R1lmTm1GL3gcVAZvYhHIz2IXRB?=
 =?us-ascii?Q?/mIe3hcw/rOZFY4jn0SMVQHE4LOuQwCvQwiRyZy7qXnBztljmkuDESVrVUCm?=
 =?us-ascii?Q?0V8dNSFT9Qnr9GrkrCDtiV2r9xG3e333fGc+6HgvhuJCHEnDjJH05axy/VEg?=
 =?us-ascii?Q?ey5cuTeTgn8El3z8NNCiLkG0bb9ixC/IHZ4aQCmkoIjHIx4NEWDhymMm9GPA?=
 =?us-ascii?Q?Xg40LiAciLwbuKnCVPKFONJjPDFmgz8PsrBj9vQukX9z6Se1X0dpoG1RwZFf?=
 =?us-ascii?Q?nhbIckA4DDLoy41qOIyUNFqXFS0DkXKV0wEcNImaoySqxQyzP8s2S+e9orB0?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1YrWkgTAUVZwFQsriM+C6mWkiem37zk6vn+4YNCLHZAGRL3CCAaCWIMOyT4WK/XnntEMLj6r38uTOwY3lywmrLh/iP8kkNrMbQ1/amMj7rQyQ+2qQRsAA6VSxfp/cQjkjNtYwD4FMhlE32Z0aNDgMM6yq/uVS6sC4LPdao2mn2amYahhXTB2/03EK8g4HI7YbMRfObQlB1fhD4lmh2btywuXPsH9yA8R5VEZKPR9iOC86Wh21uyPTAKIs+OXYeXxp17JcKYcM41h5gZ/LkRzpDTJDfcrBA/ermLIpkCIwmEyG5G2yZ7FyIx1/Y8ND5HIZSzlzxSyXQy3WdCUMDYR0WOkDkBkhlX9u9WFbtYptIRNy262A1s/41chMrI12HMcm9mHGNM8u+XImknYPCFCTDy4by0NS+PN206Dx/VgER4D27iyTp3vN92poy3HKWpqGSrucEbY5TibrVxyvaL74nP5jVpKzkQ4wnirJV6GZLjqOamhyH5a6siO5BxTbg1treENftZASYjazBfSlFOH/JUQEfD40MVArybh0ki8TWwTslzW9+V9cTKCOooypwc8EiF6pN1kCGHaZqHckSyD4vp8fWsPN/jP6mAKd3nKhfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49642f8-7979-4222-acf0-08ddda89fd8b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:53:55.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej3+n4EJZFGxEmA/L+6tN3279YpO5yzmnHaaHoTor94AemA347mcqOJEv5UbU6gfopC8m1LYiCYO8zvbsHVgV8Yu0ZDF+f+M+aAVu7s6luU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE1OCBTYWx0ZWRfXz6xZuLNQ3czg
 j1Af13HUUx5pAec8+eXhOZpexfMQocAdlMjImy8x8I96TkAXgAFvR1Klm521wlWYLs4K8UL1TJt
 eRGnuIJtezBop3n9hDuoalKNfjHM7r6fg0D9fcXwADrj2CmUf5b6osCxFb7RKySPqv/eagww9e3
 holGbY3+rHMPCbVJp9vS1WjQa1sK4vgNICtZxEo/qYdMbD48Ek13flgUIV36U5AkOLKb0GKh5EJ
 GxBjK5DtQAHm+kCMer2aNoEMYr4J0z0HjXPtdQqnVMMTCbuGFT2hwchG0hJnCs6UKGizHsO63Vf
 i8NS1MCfjJmcdYphO4RZ5BbaTxb1TJ6HE8kmK19f/4ndB/cuks9MhArXUR+Nhp3+rexyMYMOaEC
 BrVdzF3iF+UhWQOP6dSv7jD8Vnc9dF1CLTeEBhv40MWWi9Rk/CLZckWNz3GSn46pk5YElzxf
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689cc328 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-2qC83Wwu_KAxuU2tosA:9
X-Proofpoint-GUID: XD5X4MTyQBrosmGfKV_4wCawKNdGOiu_
X-Proofpoint-ORIG-GUID: XD5X4MTyQBrosmGfKV_4wCawKNdGOiu_


Keith,

> Modify blk_rq_map_integrity_sg to use the blk-mq mapping iterator.
> This produces more efficient code and converges the integrity mapping
> implementations to reduce future maintenance burdens.
>
> The function implementation moves from blk-integrity.c to blk-mq-dma.c
> in order to use the types and functions private to that file.

Very nice!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

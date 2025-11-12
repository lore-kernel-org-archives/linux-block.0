Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA8274FE3
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981518; cv=fail; b=GcVYWsYRuZ+scULgp+3ZFcEsgiQgWaZsMN9fivmr5r4Y6gUcDPm8sAOGtBx1dNZokoyP2t+LzV9CIantHbTk5X3rSVRsWhiudHDTmb2NAPpZf/5WOwvG6fWtIyEezsZx6kza6C+nSx8kP7O+mHjKKZ0O7yxPB7nZe3AhcGtuBzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981518; c=relaxed/simple;
	bh=OqxTSVMR8hhRN6rH/Cy2hhTsGnopG8RWurCjNuG6kqc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=IN2xuqjRZ2+oMQOHZjOqsmXbbNx3zSZHE23e26mbU+bp1r6mkWAQDjicFXAqPZaJbJpXDxesT24krPBvCW2nKwriCx5arVQj8IgMI+rz82q1pxWtpD2QzyBJpIHribJ0s+evFxU0ggGuzRldxhOdHkOkbul10IBv3rdJEJ4gy5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSBCrC94; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjMBljBA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSBCrC94";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjMBljBA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACL0Mab031117;
	Wed, 12 Nov 2025 21:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p7W3CnQT6t0TgVrzby
	/JcVF6Xh25Mvr7P2dPbss5q7w=; b=SSBCrC943Vz5//xmkA5nn/0TgoFnwgtca8
	KgHSQ/BWvmXFDqLFvZOSHUtWhoP5Z9Lmxc3HTRTEWOM9ptAPfTWaspP96dRo1llx
	v4Q5Gfr5/g+dbGRlTnWiZUmJVvqGSz7/TMzQp3VKw1tzr2CQU/KIu2bOPTl/VoJZ
	sdDFQcCpB4IoPc0J2E9vCb8Qich2CP0Yeq1JvuK4/GvHSA3PfXh7mrxpATeOh0iF
	WJchecMp7225B4rTAr1I58l9yFKA8hEslh7VUZqEhCp6lPDcgMOTXNoXO1nrAeYC
	ntY5kDDPHF3WXA3bWNzo+lfYy2j7k31syBCrmfF6QQo1p39rFXLg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpngfav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 21:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACJwZ6S019012;
	Wed, 12 Nov 2025 21:05:06 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vab842g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 21:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFXyPXk75UnM05faePDvT1cXfR0wScrY/I788xYDRO7JMWSq18BFkt8xUrP8jLDMwBoQJeTe+4gwnuT0iqILRTeUbTm8j8QF7Bpbc7aziKsXeE3VrCVg/vkDO5NzKg+wPsoM07arj+CFCPCJwuUNqY2kZISEL2koyviMKHf/BEcK2vQtkmMEff0wWnZqwlJeX8eIreG61Pxj5ODtDLW3xB4mXM9JXVOlD0PPvYu1zCGfijI+WRinnEAlNx73+8NT6RtUfiUSjy9KpG/BCZOxERk8QqYfflys4pwBWlx2BFtoDZ80MiaL68V0rUWGMvvmWQUSHkqKOHNDlHXTT7JiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7W3CnQT6t0TgVrzby/JcVF6Xh25Mvr7P2dPbss5q7w=;
 b=kST8Ee3BmPL9VcOCHrRhIHwTltdsqA9BN7g8kTIYAsl7PmGqmO/H9CYM5AJegBTfcUAs9ItwkFHvkNFLa3ggrxGTZXJ2w97VdEJj+Om5jpIwvnVIuEsYMWNf9wk2S5p4G1y2ryA7yo/Vhwc/K4UTMcM0yN34XA2JFUKTWyQiP26F9Fu+xpWFOgwLYSCbjnvK8+JMHEpNCXZMdtB1X4cIbQ6Xibm+4apVr0KgcFiHfM8b4DzdbneHnLg+HVPlLEoqrzGLAE3E8mvAkTwew13Ya091vDTxo5ctDPimJN8im7GyvU/WT/SDhEeKP+vVn3xVUwsRNWpNupQJwM412Varfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7W3CnQT6t0TgVrzby/JcVF6Xh25Mvr7P2dPbss5q7w=;
 b=YjMBljBAOutoFzXXm7WwQXMKZj1n1j+5NpBnlrshFQ0bQtvLzpJvh/X1qtZGlNc+UvMXTI2XBu/8CWUnpX0iI79Z+RNUfUQclJNEQVS3BfbuugKZhBhPJu5k2UgztgjXqhSpp1LgXLCO7Y7H4B2EKk6MPBcKaMQPMO0tTkkBxlU=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 21:05:02 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 21:05:02 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/3] Refactor blk_zone_wplug_handle_write()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251111232903.953630-1-bvanassche@acm.org> (Bart Van Assche's
	message of "Tue, 11 Nov 2025 15:28:59 -0800")
Organization: Oracle Corporation
Message-ID: <yq1h5uzezdh.fsf@ca-mkp.ca.oracle.com>
References: <20251111232903.953630-1-bvanassche@acm.org>
Date: Wed, 12 Nov 2025 16:04:59 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|SN7PR10MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff74053-b4b6-47c0-a5c2-08de222f2525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJerC3uUcelpVIuE/X/kt23sA7GKBr6rASSINQV+iU62hbc8XtJAXHnjEC/T?=
 =?us-ascii?Q?ePhKj05e3XAabhBEQj8xbXj8kMlxDUBigtntWKcYfE+J5TIuhAkjekOChz6Y?=
 =?us-ascii?Q?jiCq11o9+zmSNvxhf+a2OKbFn5gbT5mRXvG3eLKB/OK5y5Q7yji9mePkHkmf?=
 =?us-ascii?Q?FBxAuOspvby2J6Jvva8UE5Sa84OLXtdpqC35uLG7biahlsUQ6szgzqvdwNf1?=
 =?us-ascii?Q?mY/WwdC7JiaZ5Qtz0ksNsTStBvwo6FfMR2kHJrrSRq2pydRNABbtQh5HCS6L?=
 =?us-ascii?Q?3z71ngxypu9sHojIvRtykV7/IwsH4qKMGns8eLK1NKudrOAyQuywdaQlvVod?=
 =?us-ascii?Q?PgOmWJellYaG2LrcGwVEBcVT+q0lHkd2i+9tiwI7GKjxfVHkIX/RMpOLlp5J?=
 =?us-ascii?Q?6hK0d4aybUZMd6ZDgt45rIoSjjK9dOc1sNxfR22vFJBXNJ9bsEWDTI5X2mtl?=
 =?us-ascii?Q?2IIpW3mMsVyMuhRz2Jn557FoODQ/xC5WWGSty4MCJdCtfIOMs+MHOyyCUtE0?=
 =?us-ascii?Q?UnyaY6BMlSY433VPknzLOF1RbiB1hN6N6rNPo6i30TppxK2dV4cfdgLwmVA9?=
 =?us-ascii?Q?hVmafLr5nX0+PGYDOckzOyixT66PQ5LahDm81vazUogwy+2EvYVhqx5wjFnk?=
 =?us-ascii?Q?0rWkOuR+eDFbCz8oQ5C+FVm1Z2o1RW5WeLmotd7BH22z+5ajTcs4oE39A174?=
 =?us-ascii?Q?nV/bMF/BAZ1KYsHDb7NYsIlxmzFwPcGkWmQUd9+dU2PMUjF1O5zly1PN81pU?=
 =?us-ascii?Q?vCSzb6t0RfTECPbQJ5wdBOqOjcjgtH9wlen9L62D4fB8AXWIfhNPElyki0cn?=
 =?us-ascii?Q?UAmPJxMXXm7bvgvtMyZnj64JB5FV3sDheOBvtEWs2PE6AzEnunfjax4RvcWS?=
 =?us-ascii?Q?upeNobqEvv3lgxR2unTHTV4tuB1nxjJnvkpvT+BBPxfnXUUwYG4gNhHwAy+1?=
 =?us-ascii?Q?qOtqDLWRfInQebZmqA3MIr5BfIsegUJj87zMD5iEeQviTqMOohY84/yrM9pU?=
 =?us-ascii?Q?LTT22BKJurEePxVX3S+jUtUQJna8GqHRNLJ6bxQvHY7YRWbw9bw8v1S8qI1q?=
 =?us-ascii?Q?VM6NONoLdEifdKTE2vOogj0/ceIBVTa4rmNAK2iQVFP4btTPxGsbJMOfxMaU?=
 =?us-ascii?Q?Of9pFvy/yMBMiEGXaCPXUYDjuAwdXwfHjZvR72t7r31H4JfiRuX2/xMfzqPX?=
 =?us-ascii?Q?QLuNjMVJaiMRHsfSdVnTCNHAfyO8F/lVOfnI2WdfWm4E4DqRPs3G1PM1WUp6?=
 =?us-ascii?Q?TlqPWC3gdQeuRxjKtk24vIEwYAUOGRUjpEbu/BNbVLHO7A+6JQGQUA6PfwBx?=
 =?us-ascii?Q?zTwZNVXXbGM8D6BQiQRAJR5MhG+sZv0U6wzXe/f4jBNRbFiGqmVz3Z/NYjpW?=
 =?us-ascii?Q?UagVNdz0bqoQPbeyYIo0ICfsl1rnyhCVyQ41QdfrAEI2bdWxb0rvVT/XW+cI?=
 =?us-ascii?Q?G2BzDqhrigFR7iMNzdJF2hCdnxe7J6Fh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5YtMPyyA2pskKWexQfwINU04EBv/6KlWSAiCUviylmhGFex+1kiJgI9OO/w?=
 =?us-ascii?Q?UvaNit0tEZEwJFi/AnvyAXeN9yt48XqSzcQOIIzU0YNHiLVKAT+eVWOBzIMu?=
 =?us-ascii?Q?JMWX5mMYdv4U4eI8DNSvGAGF6Nut2X5v324R2esFuSFqyXCxYcm/HwYGcdBP?=
 =?us-ascii?Q?z7PnzTTAQx3cf7nvlbBCXASKOwJNThrqaBknNbAyQndrT7RqQX19F18E9kU5?=
 =?us-ascii?Q?9BwMhxl9laHlIiSJz6lcQy/YFWLt5J0k8EnSQyOzBXKMjGnlCl4orj233UTX?=
 =?us-ascii?Q?XYt7qpxNVmrsUPsHNX/ryN+tj8uk7u4UFyO3EIxndTIMZ67HACa1L3xB/p65?=
 =?us-ascii?Q?2PY+7m4MjllGcfFzhd7tkyL77gBkDo0tIDVXIlsRJlMhkrBttLiV6rVrrVVF?=
 =?us-ascii?Q?WgovHy5L6v8ywyRtW1OFQxObfco2rBAgfNsxgMClEcOmrIU/9scvGX2TE1mG?=
 =?us-ascii?Q?wvIuKVu9E5ncYBG4KZB0gpiXvM+pPbYEhkWCR1eChIcjX3vdke9o+SD5DPKR?=
 =?us-ascii?Q?5CSkLbipxoAc4ZGrW8ztW5V2AS9XnFzXhEKjB3rxpvABjF6dbms3Zl+fxvMe?=
 =?us-ascii?Q?3vZX/iAosDEDe8M7C/jbSjE9qe1NufRhX9gC2S4Udxvt/E4+K4QXcE6dqL7n?=
 =?us-ascii?Q?S/YM/ItP/dQZksylekDRUYTrPrR2q5WwgyawZaH100ypHC5xlNSLT5XYiBSW?=
 =?us-ascii?Q?/i9xyGLlXBzDJ4u4Le+OviwfWO2gJTfw301nZDt4yxCFGBG00b5VL5DWrPOS?=
 =?us-ascii?Q?meAvsUXQGBujQGwe3KiORs2u5VQD+mGYJIyCrcgF+6egxGK06u00fHMdzIlI?=
 =?us-ascii?Q?WZEZWVlyJjbTV482+SYxLF5V0O6Cz8aHftPKkOwwyn0tj5Z5N1dRKf0l0QjK?=
 =?us-ascii?Q?8Saxkf7XLfX82QSWhjgD+UMyjlt5eyhgEaz3kNNcaBGD4M2FI7nrSATjPnXU?=
 =?us-ascii?Q?abwweHBrum2f8EHczSZ09ivs368uKOYXbm968lF6ikwkxJAQD02cxygtlLnJ?=
 =?us-ascii?Q?0wTXzNcWFJdepetJ5z5j/V1b/Kai6I5yClZk5zIHi0S0Paur8lUFS7jVv7KM?=
 =?us-ascii?Q?joLjha7gRjE9/HFIK6BQ6rCqbxhuyIZYeftYo8m0xzVxppMeD480Uq2rZvHy?=
 =?us-ascii?Q?0YqPvShvDS7XjVQYn1piHRsocP7O1w+CUN6zsyAcq87guR/cTM76ej27x2jz?=
 =?us-ascii?Q?nqWsCYRQ+CbCCj22xzbQ4eaTs5HCEBGpoQob0Ym2jWC1RKMwt288Bi3a3Icu?=
 =?us-ascii?Q?fXE5hgOmpxN2BQ8h1GPWWydsYXfytT+m+H5ja5VLxr1hbxdajtvH7eTq4yu7?=
 =?us-ascii?Q?LzS5UP7hd+kfdH4Xi9AIEY1LYxYzYR79wb3TG/9MPAG5kMCQ8tu1j/czB4Q+?=
 =?us-ascii?Q?8YDa2VN8WXzfmJ1/SHkvkZBVOYEdgygrRndbK6jqQv66KOh8bzoGKPwgPnua?=
 =?us-ascii?Q?VgZWkqk2GC2M6kcpyOd6SqJj0Xa/C53HfdOXUpI/c6KUsMDpmn1iizeAN6fS?=
 =?us-ascii?Q?bNyMGqmzoiaL683ijb4O84TpxlUUYsa89/3uxQYwMjwrdrJELvIwA4KlDR2r?=
 =?us-ascii?Q?YXSzFxHjvI+hrv1evN564GEEspaj+1YIW7bPQjeyswgUvbAB+K7ORtpAQiDM?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ENqEPZzJSZi9dECLN3vj4FxlP0pwelQTD7H4j6pH44dXiAxkx+gc8pl/W7XDt5Y1/i4kPFb0PdeGS7rBIClUBkc3xCUz4DJUzJQ2bzT5Yclvlm0Ci8zjKTNIRpyWulonGCkIiHrj0v3V6nZlyzx946NWBXwKDLFtit8OliM/+UiovjJ4+xt0Gfq3QLK/TEM/3Z2qcvtmUAJNrWos97itoNs8C9bSobfwUoGVROevwmd+DwHQemiwtHqLUlEAqQPHCn83R9/MB4aE91e1s4j31VzTRs0JRnORuvpczShNcTxHh9h9d5ZJpOUUj7VPooxC2xbZuvkYFbXEuXVyr2CiFQA3twaRZZ2WSSBud2VipaQhmStMpqUwK4YMtF3dWQWZ44NS0cxp42ufVdWyDRNTvvkU+NZfNG1yfSDVYt3OFL233Si7XcUvd7yA+mq3gAESM6pp0rF7hWqpin9E++hvH2xofML60fiuyc4Ze6lJTnDbooPSPmBdVplWEzlvqo3kmdjlhRif8cIJ3ZD8Imu6LD/QOQQd+4JiZsNnheUn7vINuWRqT5TfWbEWfVMsB0x0bBN1AoSjD1/MIaePzK375+LPm6MRd0Ec2HavLbRUWiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff74053-b4b6-47c0-a5c2-08de222f2525
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 21:05:01.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPgO1YCbEBfUqy6AlQZBbqTQVX3iySfQgEBSyshSK/SfqSr6mzGvTXyBp4zhx4yCDUwZWPdTPa9Gm6kx8l3/odjyZHPSQ4qGCp5I55wUb1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=786 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120170
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=6914f683 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Ryy7CUR4IX1P7wxjFToA:9
X-Proofpoint-GUID: S9OQ4_PUjysRB1IVKg1HOBHc_lh7KpQD
X-Proofpoint-ORIG-GUID: S9OQ4_PUjysRB1IVKg1HOBHc_lh7KpQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX1Z02rh5tCJ3u
 +VvNpxt3uNSqbgdIA40e3rHmI9pLxZbleyIeKgAPy8UsJuhgElW9nv9yY8x6jdDWE32nCg2pKUL
 PnnDmQkAhPiNJwPpP33Egk71/7ZplobOFj9e4dJp7XsH4jqPSU9wq2ezf+51c+lBOh0LsfALt6Y
 nuNuMZJDGzKanICk3g1cvjYXeYYL8a0tYlSPwqek8Rnnj8QAK/RJbu4TsKTHRdqEZbA5FpHO5Jz
 sV0dGn2chSBlv4il38+1BZF4A5IfXh3rPILyon7Gv4IpHrNL8xaMdQZOoCLDX4RoOyvd2ZqSlGV
 FRtQtPLyY+lwTHh5xaMVELNFhVN4MH7w6InSiuMUPhBXFrzJgodT6XcqZZKeif3WPeG8syd6i59
 Ezlb7nGRbHsWPwa/j7mewM4bRuBtVg==


Bart,

> This series includes three small patches for the zoned block device
> code: a typo is fixed, a lockdep annotation is added and the code for
> handling zoned writes is made slightly easier to follow. Please
> consider these patches for the next merge window.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

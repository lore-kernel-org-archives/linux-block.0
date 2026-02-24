Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776E3321C1;
	Tue, 24 Feb 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967943; cv=fail; b=ARQA1D6IB392GYr1/wKtg1qXuCymEQlTjO+wlb8Dmrp9wxeOXQgSzjfoQmLtgBMjP8yTP4TSW6Q5ybQXWt3uP4zlChRbKt8ZvStJC/LOiPZGNbuvzxwTsooyney+6YBdYXTMmjfyHPEFDLy5p5Z583c5QeKMaq+qxT5RdaGYBEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967943; c=relaxed/simple;
	bh=zvAV1C/Mj6cYJyk1wnw2iU6PPl6Sw3/pwb5XkJcrWr4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ECtNsS2Txzky1LGcZHXap7AJ+FMP2q/of3tFy+TmlJkmM1bOYxmyrwVfLGH4I1q6gE4mtVaDCkdNsUXiKIwnDcD2BETPkC8q1CyDYZgGLoIgzbzlawRw0Z0ld8pm+Y5ysZyJHhud0B1P6fUiI3/HULt8tv/17usI4v05cSi64ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UV4n+pHU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GkgQV0Pk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UV4n+pHU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GkgQV0Pk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIuhJI719893;
	Tue, 24 Feb 2026 21:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RS9f6qznsO03zLBHvC
	0OnQYCV3bGBjsd/7SADTmAi5M=; b=UV4n+pHUXndj0cNl1/cDIdetkS2Ehddnmw
	7HcSxTJ8VZbUz8QewgKIwYvmkYbKgNc13H9RGxEaTuBqFz0IkSGLEwEt7BhJw7Wi
	wOP0Dj0t/x5smC2fmxwYrlaPyTfUKszjpoYiU0rue3UVieWuyAWODkZnEpT/ag6R
	0OkfL//MuKcm2HOiRVFLQ/8941FSMLNXkRisEcrqhxABjhrsICeMUN/tpkDKJ96p
	KOSKrrEpewan78RDe+tbJxa24SC15XPdqwwiZonoHMEMKD+hZ+ipV95DgdIypBie
	4f82MUtPEpC4Z8dkDB6wWCqNUJnqsDZmz3NxvEyIIlxUQbKQI1Ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b53r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:18:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OKDUng012411;
	Tue, 24 Feb 2026 21:18:56 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35efxt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubAmxL9a+8CjJ+9KKjJN1Cd0Wfz7L30P5IkTjgA64WeFUmDnLgXJtxaAtI1sjWMqLYtfdZH7Rq8JjG7CVZgFgcIZtiAhV83Qb1EpqNDrnWL8DKSIGasSHYobNDi3914clDeP2FL7kv+EqkOkCmg9sBlJ9FmGq/B42g3ct0lnWeWFpL6DelkjiyuFQiWcSpJxzklvuCyYP9Tf6PIcgicJkq6lJjGnlhvUJtGgJgwX5zwAGmhjOm24LPU3zLHiV9jOpPgNVNYaIQURhtYW+fm6HPeNkgFvU+JXNNAEjlKGtqxABwdAV+4NPHc7dnMpLwmaDR/FVuTpTbEPO5yFVg33JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS9f6qznsO03zLBHvC0OnQYCV3bGBjsd/7SADTmAi5M=;
 b=kr5RJMFqyehyHGmTCM/rBZzEbRgjnSWujZffH+32V2Q2+GOyE2+TEQE+DpwqpsPTBcsEpIiiB3cfCp4N2r8JUYV4jpqC3EMrlJsMcpzFzTyBBUngB4/3vfEsQ/MGs5DIjXHymE1YocvhUstsnsbfEi8fbEW8vY64nnd0psp189h9WG/tdpcSsLvwrbDUgIye3KZbUuwxSLW1YnwRcUCRKVSog8w5k+UVfOlJuDZeXPb6D3vRdnbEErtcqA0FQ6qhAizTH1qxRE2YxLdldwrIbk61fqolZyWsqz0sq8sle8YiWOKTuo3rehnWDbgvzt2tBxMUkLhf3Dn3YKkuHk1Vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS9f6qznsO03zLBHvC0OnQYCV3bGBjsd/7SADTmAi5M=;
 b=GkgQV0PkVetYB/7gqw/SWdh5EpuTDV6xE9GorwhgcMZeq77Vhq3C9NJROLbsg1XGMaHfba3SP67wn8AC9NDnIlh/4BcPvAQXvl5m8Wqsv+/8o/z8bBIiHg02/zB7ZyVGSbE2Tq/5ckfcCAejXu6MUKb4VGWQogiT2MtmV2xYmeM=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 21:18:50 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:18:49 +0000
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Keith
 Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.1] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260224155724.3142007-1-csander@purestorage.com> (Caleb Sander
	Mateos's message of "Tue, 24 Feb 2026 08:57:22 -0700")
Organization: Oracle Corporation
Message-ID: <yq1h5r57sd2.fsf@ca-mkp.ca.oracle.com>
References: <20260224155724.3142007-1-csander@purestorage.com>
Date: Tue, 24 Feb 2026 16:18:47 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::35) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bbc461-64e0-404a-aec3-08de73ea4db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ArAMIg/zwgwKZ6WjwVtUoerSbq8ALQszyrlHyhRg01JVG26QUNWDEs85py+L?=
 =?us-ascii?Q?lXbrzhZHfFL3Fim8rMcaxLqKSgdZrKodRXs9Y6K5tFrhEL8vi5SHCpAkdz69?=
 =?us-ascii?Q?XMvpu49evRBOiGsW5IHmzayGtTFnojR1jwdq7uy/uvXoFOudqkEJgH0OE6JK?=
 =?us-ascii?Q?+k/rdtc9rTeaQjC1PjoStcET1Cz4y7ibgCdFJmQupvBKABmDPpY9e9i3FylB?=
 =?us-ascii?Q?sWtPHDaXV2hYK2XUCsuTnqLS5vrTcDdmmkfIZ0gaj6+B1TSdYjAOQ0jCwyT5?=
 =?us-ascii?Q?EHNvy8jL9zLOo9DeA0yafVhwZe+cdAJZbY/scaLP7R4tRBbPlNPAQVGMSshJ?=
 =?us-ascii?Q?X4w9BdOU+0oIVaQCktT5aI8r7AMSeKnwoPDzOB0mac0VX7uPBhEZ8xS+pbdi?=
 =?us-ascii?Q?QJ/DCDkquO1WMnR7HSwU+IDUYOUVLQmMA2k9I5f+bd4s00C0E+EchCk/kf05?=
 =?us-ascii?Q?KZ9VtWSwIjHcPTOU3oked0Bu+hLfsQvpnGTy6sU+PbtMiMKa1980DsgqFrLH?=
 =?us-ascii?Q?xVdy2pHofaf2Qzb8cB9yPhqcN54Af+A0YmhjH9yklW24Bqz6Yyp/WYKXNMkS?=
 =?us-ascii?Q?9KRiDKaiTy1AX/tpEFs1JmoVmhES2EP+Hn6if6yrlRfpUVRh7hdyV4ZkNc04?=
 =?us-ascii?Q?TW2BE/MujfYKjNx77sPuBcV210KEPZ4gDKZZYePKdxKSUguLhCzRftrg9v7A?=
 =?us-ascii?Q?6KYomnvDzisLujBbYAMCUcxSwwIAW/ryJnnPMgnDieMVi8dq5sANT7J86r9H?=
 =?us-ascii?Q?esPdC7gjlkFTADrmauH2cZq1dtDfGyE9l66RY0bqm7HSu9Sxwtd9xvHxIi+g?=
 =?us-ascii?Q?Bdej0mVFNoEghEs96L/77lMpEoyhJYXpxRkOdcWhpLIvjqrllIeP4Ca9GAXB?=
 =?us-ascii?Q?9KME4U+dec8RZNJGVFTJ2rij5LcreGXgW4WXRtQ66YOwQKA1cuJ5TIP4eIT9?=
 =?us-ascii?Q?zMOylb8ztAfVcFAA4MxIzMWv8QlbB7qac12Fe2W7VjQyoP97BKuouSfBDuur?=
 =?us-ascii?Q?rB+pXz2z706XStRN+56ZOqgUUohoLuBRDIL9uWMb1Iw5JOSUwWnGaI/8dSyw?=
 =?us-ascii?Q?uFRQVQEcSlQs+cKZ0WSHwRGB1KLbaEczMveYR+gyjUIDSwgmJeo61LYbyx7n?=
 =?us-ascii?Q?R01fjK3pfMoAny9nTlHP1xzvKu75/sVAtwEsTQHorSDz0jLvS8wBF4DfAlzT?=
 =?us-ascii?Q?BlYg1XGjOWCAcvTp3fkAV7QJ7ziZtgBjqPxNf68doMEz2FMErxMCtLH/sdyO?=
 =?us-ascii?Q?J6whT4UO9Ing2PaVihVBqEA9bxVaNUKG/lE4/iD2pkiAmgPRdcDnYeXl7RK8?=
 =?us-ascii?Q?I8E7z30LihXvb3OFOSTF0tGi+bfU41/gF/G4g3bVge8jgMeiL6oAIjsZiOsb?=
 =?us-ascii?Q?zC5AS8p4P5vKE8Gevivg4oWooyrl1ld0T691XTJ4WNUJc4O+KjKrPf006UH9?=
 =?us-ascii?Q?PhbLBBu4oEpW78p9n5e5XMO//BDBFx1VN7bD3waEgfnhiRo7H/GTy93vSx0l?=
 =?us-ascii?Q?DI87Cs36C+GM7ZYgIiAr7EZTXMu4999ktaSzsmurQqdvIX9Bz8ZTYWKz7gNX?=
 =?us-ascii?Q?nddHVKJfCpPKBVI5cpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n91GATucg1EnKMzQx8nXS2D0OehTrDoS+3ozr9Vg0Vpy/5EUnCIazU2nJP0R?=
 =?us-ascii?Q?rbeRgrBjMUvrJ3ABtwkl3XiqzjNI5oUgpGJtieAFFxADKn54kZXrVdc60sgm?=
 =?us-ascii?Q?jLvn/paIQYe4z9HWwKiJzE3hWL/owJkhcynsFElovf+IQuJjtRq/x7Cjxbpw?=
 =?us-ascii?Q?oA6u7Y5DV6RIoG303OKBYihAiSNnAeeGyY1IdN+fjpBUbgAfhas5zhgNKNxj?=
 =?us-ascii?Q?Qo40jtwWeKYQ+UID3ZarRUx9zipYSGBXmDaiVrkYb4fLGlLEr2U3LAqQFoQD?=
 =?us-ascii?Q?Y97tnKhEocMigTc7Q9ckMMagz4ImeySVCaJo71MU8PDyiup2kmVvFntEh/xt?=
 =?us-ascii?Q?JHhuK56NZ9jxEjZ3KytBLeLfBgskZq1MNxJwPd4NzH/PW7srkorT+e/M85pq?=
 =?us-ascii?Q?eMWvmAsYVri6Q46k3NUTh/oIhPTdjLeoCpNvS6jBgMsR7wBwpYM9D2qYbjyU?=
 =?us-ascii?Q?x0rsxyP0sVTi17q8jdnNiKqaQms139IxuNPvOp8edWRW+VT+77GQQA4PTfOD?=
 =?us-ascii?Q?rkFEfyfEBNhmEM6xbiTY4YHILt5TvCi3//FR5oTZDOn9L7KSIwTYU9zxEFln?=
 =?us-ascii?Q?gESC76NhjbYg+FDe8NYTIUTSlVuvHpRqwe4REJQGqj+/sQqUAIS3+rO7lbOM?=
 =?us-ascii?Q?8cQCh10KuZ5XzZ6Z37uqLx6mAVF3kAZzTVeh/u5g+oPTVB8rtsIwzrge21QN?=
 =?us-ascii?Q?KTaZJkh4BtTSRxR8xsyHIdDkT8OfBmmG0jvDWygdHy2eGz6KBECEjAaDVJpK?=
 =?us-ascii?Q?PJn3C03+Wv8fqAAIyxOy4ihRAJMAbASThWhGbyuMJzrccCQczE/JCTs8TsoW?=
 =?us-ascii?Q?atusbajrG0AX3iT+4EV7dsSA1/YPt97QystI0kL9A6YCJgejAo7965CzIrdI?=
 =?us-ascii?Q?u42Hb6BSicFZdQRMlcn6OnHucxHIdNuKiZ5qvRyamSd48QGhsswv1F8qcmg6?=
 =?us-ascii?Q?yGLqXMfK89HJTyRo5DaEdLxK07z9PKz74GA4TQdMh4Q2GLI+CEIuMq28UELC?=
 =?us-ascii?Q?PGjL7Z3RqdAvVA18xwXWpb3YFog8mDOLUv9DWGJ9TS6vsttOTYUXxOEmUY7e?=
 =?us-ascii?Q?pwxble1h0hYPtjZvyK8ZJIBX0UGm+T5elkLtuQP0awmHoYsOrFDKAL6myfn5?=
 =?us-ascii?Q?MTflTc8gkDqiw4uSGlLBi/DilzFRJtwSIvQMtv7uqU58El3NbCFxM3IkWuw0?=
 =?us-ascii?Q?pKBbgV4HccJQ+v3I17xgs9F20QfMtmxU8WPgk6yAxpRPgSLhWMN0Y1rfrBnM?=
 =?us-ascii?Q?cwWBkuMBcikVr2KtCuPvaWD/XO8U3Bw4bhqGVCk0A6bocwx6CbinTeGX8hRe?=
 =?us-ascii?Q?Wrljqm8f4JrSGj6mxu0bpgvez8SjpVuwHfC2UzmPPujDnetbHbwEgGcje2u9?=
 =?us-ascii?Q?weZr3s+w4p7fROWhmAJfLIpkwN7YeYyEVBva5szEC/kQDjj0jq7Cyhqv6hWM?=
 =?us-ascii?Q?uJpL5bI94zDNIbpapLhZGX+bWRJFT8JfZfLKNPBaAdVaTfDKxwM2bdgLT0Rc?=
 =?us-ascii?Q?y0VCVCbgwowOTm8uNOQZsiObhaEQM57sBxQCcWSFWCCXoEQau0Zd02UhF4hW?=
 =?us-ascii?Q?7Fj9QwJClI++6bO2o8tRByywBZgMJRFxvZ0IL+9MkjWBXcsALJouG1YcC1+M?=
 =?us-ascii?Q?OiUWbOn3g1J5K8LjBDwoE1T6Y40VSewoFH36WD6SL5s2g6Su8f6CQ6L+6rcG?=
 =?us-ascii?Q?rkbeQU0GypB46uQOu2UVpuWK2FLCRsouRoaFEExAuUJWsLHM8ebR2fnq8GL/?=
 =?us-ascii?Q?h5Kiq3AfVQwzh2WRgxPjxhgqbTgaSkk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XmsX1UfSQGXUbkZ24kNr2MLHHM9JUR1VZUbV3nAAGSimHqZ1IDPuZbIR+lUhFtIhLESrRYTEvTnFyEziNpzPZ6p7gArBMmm3o1FkPL2HYIxdPZhqZSzHjZ0MKEM0R72M0HW5AcJpTbIBDB3UlBcDth6Mb6OQD0+ICyucPQw6VWLUqxsPMEL/8om6Mq1JQydqcBWBmj+SY0loQCl67E3pK46/1Ih+D4OqdNkVrj6Ggf6a4Cbs1O0DqiPKwT3T7gAvTM6MCdEv9hOqRv/gWbNCi4vi+BvcECtlFy5Mpv1YuWQ2hWRKbiNsy3c7JxANcaKrWkB3MuCo4GL05P7YcJa0QqyQfsui/T487YsQtUpV183Dnx28w9gFeKJyUbLzC6D+HqNjn92TaLEEOLy5GOyl5D+S48CdnWN+3dbwN5bF3sKv9x4w1X/hxYDMRzXhd1UfHD25dK4/Pa7oYokAavyhy82eQa4nB9y5kf9q7cMeBvoIYIK04HkPj6xCpaGF2Pt2SmJ0iAZFFcaZRQ4d2O6nM0M+lRl3m0J6O3zQzKqKxyDje0ibA5LqZexTLph1LDhRPl+AbPQQMIrixJFnKbWjeeyb6vBL4zpBza95VZo18y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bbc461-64e0-404a-aec3-08de73ea4db6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:18:49.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVBYlJgCKyTBb8Jf1GfOfdGJvqcdeJB/eaN6VnRW6S+y7bFjln/Q0KPgoI823IPa0czhtj8upA0O4lIj3W08vQhkMZ1Aa4OQcsJDij49Gos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602240185
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699e15c0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=78OpGzoG4vgQoEdVl_oA:9
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: _DtdzuCQt90bEcrk0-9rVOs_9fNIql26
X-Proofpoint-GUID: _DtdzuCQt90bEcrk0-9rVOs_9fNIql26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE4NSBTYWx0ZWRfXy3Jxs0YE+he5
 wyxk+g5WVAvizMqz+wZHtXz/LYJRxkzZ7gvYizwFb74xME5TVXsZrGnsxVX+iLsOx0+JRajoork
 DLpt2FS3TG7YnrL/q33w7IygSQV5yIHbVXo+ccC7iSOIcOInrRiw6eUmLrXTqw161jg45W5lKLP
 YBqjug/JCUxYXS7cvdfLQIJNe8qtlNiRsNEXzIBotmxulIlx5vSnUYGHTKnwjwnqT9eIDTDcxAM
 mOWUymX+6sFTPW0Co+/EmFbHYqWswj4Maf+8xkWQgRVrUIsOMCtlaKxeAahZelkufykveeTXhgH
 LVRxYL5dVIZFb6cZ1eISs+S6X/2kk3AxtRor6sajRhuvbeQaRtEZCVOdnM8BfNClvpwpXfNNfWr
 DV6BsT72ZU1X87v4mUBypuznpeUvkVbiNGphI9eI/UwFtFfPSubv9SiuoN0BDBFnkRPWeR8EZSQ
 35zUWrRyfLMAn9DEtN2EsatCuGe/L2XeHq4KKYWA=


Caleb,

> The ublk driver doesn't access request integrity buffers directly, it
> only copies them to/from the ublk server in ublk_copy_user_integrity().
> ublk_copy_user_integrity() uses bio_for_each_integrity_vec() to walk all
> the integrity segments. ublk devices are therefore capable of handling
> requests with integrity intervals split across segments. Set
> BLK_SPLIT_INTERVAL_CAPABLE in the struct blk_integrity flags for ublk
> devices to opt out of the integrity-interval dma_alignment limit.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

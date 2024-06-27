Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7414EC75
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490160; cv=fail; b=EF8jza8a5n4UIpf6gr0yY/C+Nz8TL7ywztkVfL2Idn0UbAKwvmJUoaJ+JbSJWQ1lygsBtP+i7cuWWogtsq59WL05abpJKayx66TEsNY3+U28HA0PmUX3TrTSg6UsEA8kFgidMhXbz0ofqdYrM9Eb7qfgvg8sg1XpHklBEBsFlqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490160; c=relaxed/simple;
	bh=yVsmzy1dxSqNz8zD+Ksf+WChULgYR1pClFKf884ZPW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvXTZUR4FAcmba/8OzPc3x0csnR8Jx/nA9+69/EYjn8hcqtxf+F4iOb+TI4WPH67HW4KLsUsKzZuwSog4S6P2c5zeIPY5gY+BT4aRJf1sDzU/ySz0jBTFbmc/CMNPUQ5Jx4XWgemhCP/MxTDjpqJfXHVSNrXikK+OnUdlJP4q2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXf9HRxV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lV+oMU8F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXf9HRxV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lV+oMU8F"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tWdn029141;
	Thu, 27 Jun 2024 12:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=U25GTOH4i77Nv3pRIxVQ3q7DzozEd3/nR1o4e2i8/qQ=; b=
	IXf9HRxVbM3q8/q59wveIM033TDLo7sPbAd3hkHJ5qdBMM7jO2zRGYb+2q+K5FlJ
	fHw6hy9mnKhBi5YC8TNwfciGN1mgmaw2d1WTHc3XDXb67OWuWswX3231qIyTavNl
	+B7O62LWINL8hmza0x2C+ECqyj3lHy2pZKirBEVRiQtVH4mNw+xqe7lVuF6+WdEz
	0PA91WzoYUTODIf+QAtvoisau47icYAE1aKDCbiZLpRH/F5/ICkw6fg1z2gjIE8x
	OmHnrCMnK4vjYSk4a1k7fanEWjkmSdW+kt/Q47I04843lTejLBLDi4pSsVLHKtL1
	VmK4vn3dKIWqf6N+Gamlng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttn9exj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:09:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RAWhBP010948;
	Thu, 27 Jun 2024 12:09:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2gtf8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4O66RZdLOVkHEDLGIipilcDKhYn9iJ+TwGCMExEth8e+OqgmSHM/CcgU9IaJ565rm2erd2Z9UgC+dwosrLMtBFFBT7/taEwQYAEom33T5F+d04fp07X5a+NkGsbBvKZqR20lWCq3/J4NP6be3W893J7GYRLx82xejUDKRZISA/3eFLeodmDXnA4ew5Q9Ig3K6hs41k+8ggXL+6AvokcDOB67mJYEz9I/lDWStvi71T17OoYjV097gH5S8m0qbnpX/fMkRgs+Isvr1fcEuhRoZk6cGqPDprB+Ro+LeB8ungQKxJJqaiHwqmEMVkcUCDxsfH/3P9w+TTZsPHKT6etrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U25GTOH4i77Nv3pRIxVQ3q7DzozEd3/nR1o4e2i8/qQ=;
 b=UCShMWWr/5jDfPNlyeLFyOheJow6yvP821P1OVq6KFPfoxVkgqMjR6SfX0yfKwdcR5qqWIYVypcm59PwQ3pzTfIkJZy9hRt7F83fG97OKk71VwGik+rqy4i0OJsR8ELAzCKoeE5OOQs6wHw0jpTphvgsrWFZQ/tUgX2XIdHkeZN75p5vdVsxBSBKA2+FxnxoCe9FllzD7oWZHtU8q45vWtJjifHsjUArwbYC9/PZFCOOS+4TYWzbLp0BpGxK7IANvYxbe5T61NALaQHNKWNUMuwtj4hWd2BXtJgC2qRvxLQ9VgDQuzGRo6FEh4UkHhiVaz6E/JaWiq/DtKjl4QTwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U25GTOH4i77Nv3pRIxVQ3q7DzozEd3/nR1o4e2i8/qQ=;
 b=lV+oMU8FhfNbIwYCmWp2+gftp2414hfHGGiyhwlmQ5GI1ltpl4OnoDw+2dsoVMWdYqOvc/SXPV8FAVwfqgSYw2wHDV7ZMcJ6hgxpB67sxc7dc39EaIuDXazijZGjCtZtdxhH8HELUEjE4YDGJKjFDFgd7Gtt/ABujzWxFzENZ3Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 12:09:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 12:09:11 +0000
Message-ID: <7a8768a6-f128-419a-8994-9f3b68c6dbcb@oracle.com>
Date: Thu, 27 Jun 2024 13:09:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: simplify queue_logical_block_size
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240627111407.476276-1-hch@lst.de>
 <20240627111407.476276-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240627111407.476276-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 228d6936-adb1-4fc9-3e4e-08dc96a1f42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUxWQjNYTkVDbUNwekRzajFqQXVnSEhWQjNjYmc1OEZWTzFkd09ZTDBFUGtU?=
 =?utf-8?B?UUtDOThNYSttdWpFM3BZVGRZclVQSnhaUEJoWmZLS1lhdklWUnlzcWhJUUF6?=
 =?utf-8?B?SWFyN2QyVHRIL09MaDRpeXlKYXZwNlFybjJiSnRnVkJYY1ZidGJUS0QxZ0ZK?=
 =?utf-8?B?RGN5SGhhNHZDMTgvZnJOa3U4RVNZNnpKdVQvR3NoNFdqbWR6bFhIaFdhdFUv?=
 =?utf-8?B?OHIxVVFvUzgrb2o2NmxhTUQyTTEwaGQxaXY3YzQ1bThsRUwwc09objZ2TWZN?=
 =?utf-8?B?RDhEQjY5LzI0L29EYkxoRjdPbDRoU0FJK3lLajh3ZmtHUGg3NEpFeXZnSGxh?=
 =?utf-8?B?OGNIWEpQQy9ORWtPalFCS3NScmtXeWNmZVlYeld0THdGTzVwZFZFcVJOUy9H?=
 =?utf-8?B?SSsrbGNoN01QMmptN1ZkOVc2a2RsY2EyclA3Q0RRTHVKVFFld21kRzcvNnJy?=
 =?utf-8?B?NUdCUjBDYXNqSklFd0JtZjRYa3dBM2JkSDY1WGY2MkUreWZYcUFEbkgzdlZR?=
 =?utf-8?B?MnBYMEt1cU9TWVNwbEtPWjJkdXNIRGticHEvRnlVTHdRQVBOVTNyV0w5Zlhl?=
 =?utf-8?B?NzlrL0J3T1lrZy83OGRORU9ySXFWVmpwUVloLzFWc1k3NTdMb1JmT0djUXN5?=
 =?utf-8?B?Z0RLNGRrSEJiM2l4SU5NMTgwcnV0QklFTXpEZmlITnVuQlNiMnJPTmUxUVI3?=
 =?utf-8?B?NFNNMFJVRExHTTRibytuNlVPUEJQeVNDTUJFRW9jS0ZjdTBDTURiTWJmQWNI?=
 =?utf-8?B?RU5yTncxUGRWOFBZVFo0ODg2cG56RzJYdjhMbDJyc2hjbEpRcERFcWpvK1FQ?=
 =?utf-8?B?ZXV5VnZ3eitQTU4weXR6RGNCUXJBYzJJWlJZaHB2Q0UyZ0o1bklJOGxPT08z?=
 =?utf-8?B?cmY5NlZRT0lUdTV4OEY3NUx1YUk5TVhtRm5LQUpoMlVzN2ZseFkzaTdNdGJS?=
 =?utf-8?B?cndWMFJuT1Q3Tkx5NGtnZm1yMERQeWwvdjlGazBVRHdMVUQ3aGxrd1pDTnp2?=
 =?utf-8?B?b0pOQ0FBMUVkTjdpWkxZYkdPZE50dmorb1NQYmFiSEdtS2lLSUtlUTZmQ1BZ?=
 =?utf-8?B?YkIrSy9qQmNaMC9YcnFCWE5Bb0lybkx5UWIwRjZkcVRtUlZISEJPVThGWFU5?=
 =?utf-8?B?Nng0ZmNMWCtVU0dZYTRueXlrYTl0bVUvdER6UXdTc2x2WjdFcCttQWFWQno3?=
 =?utf-8?B?QnVSZDdiZkhhdElVMjV4cVhSUXJEeXNyUnZhYU5vK3djVUtqWXc5aVAyYkdH?=
 =?utf-8?B?Mk1IcERrdEhUNHpFc3ZHRGRMUHJxS3EzYUxBSy9XdVR6b3E5QWRqTGpSZmcv?=
 =?utf-8?B?OTE2SUVWR1F2Nm90ZlpUbHlqR2p6cEp1VUJYeitVblNEZ0NVaGlNNEVQZW9M?=
 =?utf-8?B?L3NxbUNVQUlUUlVpZjVJdTd5ckUwNnRraVMwaytGa01jaTBVVk4zRExzL0ht?=
 =?utf-8?B?SnRlWnNmK25EYjA4MmMzYVBvc3F1Y1hQaldhSGtsYnZ0R3ZYbUROV055WDBZ?=
 =?utf-8?B?cmY0ZEtyRWIvUUFoUFNSTnVKTHNVZnZLL3ZTODZSekxoL05ET3FSK2J1QTFG?=
 =?utf-8?B?S0pORGo5OUtaZGkzc2pZOUxQMStxTVNqYzZkeFFZOTRmUG1NYmZaeUt2eldI?=
 =?utf-8?B?MjhLMGd2WmpHMTlrUlZXeUErZEw2R2tFQVlrVWFTb1hQZDNpR1FQZ3VTZTBp?=
 =?utf-8?B?cnFrdUpUTXFxdXVqN3dnaDlVd08rdGtUQXRSODEzcG9ZTXY5ZGM0Z0sveU5q?=
 =?utf-8?B?WDJxUHRrS2NKckg5S0paWXAwN29KWHgxcFhSUzRGNnA3S3lpN3dSVHY5R2w2?=
 =?utf-8?B?ODRQczEyZkNsU1hUcFYwQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDlBbjlrcExwSmovUmdhanJ2NDRXWmRCWjhZVzhyMTBYSEljRmw0MXdtYlg2?=
 =?utf-8?B?RHQ2TmZFbzFnQnVScUQwSzFId25aUjhWaVJNYWdMb1crTDZWWXJoR3RoNDEv?=
 =?utf-8?B?bWpPYVRLMkJYUU0vRkJSandwbDNIejEreTNmNDJEQnRRZmRUN0VyNEsybS9R?=
 =?utf-8?B?c1FwbmV3VnZ3ajdZOVNmLzRKcXVEY1Fhc1NZYkRUWFYvVGtUN2tVTE5xb1k5?=
 =?utf-8?B?cjRKU0lPamFhRlZMbHNUMGZ4MnRwZ2tobzVzdHpaMGhzRVlERDdxeG4xdy9P?=
 =?utf-8?B?ZWJib2padlhRckU3b0ZxK05Ob01XL0t2U1M4YWh3U0pjd2JYTDkvNDZDL3Jl?=
 =?utf-8?B?UjF4a05vTDNoaVhOKzhBMmRabkhreHBKeklGeXkzR2NNQ0Z6VE9zMVBEM1J0?=
 =?utf-8?B?emVaQzNUTmZOeUR2YXduWjA5NmJGb3ROWDZEb3czUmcvVFkzdnpOU3BTSFJn?=
 =?utf-8?B?NkV6M2RBelVKUVg3V1hWTnN6WFlTVXlqeWg5Z0dMMkgvaGV6dHlIc1hhalUy?=
 =?utf-8?B?REpvNWllUmZzVlJPQlJzbk1EOHphNjhTTEZiMXJLbkRDZGFyZ2FqMEpveC9l?=
 =?utf-8?B?S00yQXZiSGxnYU84UHFpTkVKQlQzdEE5ekJ5ekVzOXJZajJ3cGZJOXNuOVBV?=
 =?utf-8?B?OXBLU3FyRGRBeUh2d011dDBnYm1lalRjWDFkNW5uRmhGVzRvbUNPOXA4Ykd6?=
 =?utf-8?B?TUVES1MrUGtTV3RoWTg4bkxBbXBhRmgrTWQyMHFjTCtEZnNaTVg4cFRCNEVU?=
 =?utf-8?B?OEx3V0RPd0hRUm5FRk9yUEttSngwb2ZWUGtvaFJuQSs1bzR0OXdpRGFZN0Nz?=
 =?utf-8?B?dzFtNXFNSkg1R3dNMjlqZUFubGR6eXVRcGM0bWdXbGlGU29tbG5aTHh1Wmxp?=
 =?utf-8?B?TGdlY0YyLy80RHFkMVJhRlpIejl6QzAzVEk5OVd5OEFmbkVpV0IvRFFsdkxS?=
 =?utf-8?B?WWxyNjJVcGR1aDFiMFI0WVM5Y01CbytpVXcxaWF0V1RYTUZxY1dONXNLdWxs?=
 =?utf-8?B?Zm5JWjJCRWJqZ1RieVpDY2pCNGY5VDFMZnBTTFRTUzJZdDNyZFp4S1JJVlB1?=
 =?utf-8?B?dGJOQzVWTDRFdnUwWnBsV1EvRU9aRndnQVdOWXR3RTFtaWF3Unp0RC9Qam05?=
 =?utf-8?B?TFM1UnMvUXpBa09NVEdUTStRaWZjVjJVMk5vY1d3U3l6amlybGE2U2k5VWdN?=
 =?utf-8?B?R3pLSzVwUkJzN0FLREEzVUprZHA2MFpEQ1R0VDJ5NG5Ia3BJYjUzMFpsMkIy?=
 =?utf-8?B?Q3owWk0yMDdwVmRXVmh4VGlqa2xGS1NOSWhXcnB6R1I1MVk2aDRaSXhqWXpz?=
 =?utf-8?B?Nnh2Ni81K2tyRUppczZ1Y0h5V3hkMXZMRisxSzZ2NTZ6cTFQNER0c3BhcXJL?=
 =?utf-8?B?a0ZKeGJUVlB4OEhNcjY3d3hSZHVaSlRCV1REcjd0RnUwWWdaM0Jta2QwWXdW?=
 =?utf-8?B?dURNQ3lPR0xCZjI5SExtMXN0TWdrQzZ6TXRiZUpMeU5WNmdVMjVob0ExNlha?=
 =?utf-8?B?R0NYQldCZkZ4K3g1ZERDNmNuTWJITnZHWDBUeHZqQ08zbzNsUWhZbUlydDZr?=
 =?utf-8?B?V0VORUN4a0JyWW9LaWVMalJhTzd0V2phcFkzeE9aNXRQSS9kUEVObk1vUks0?=
 =?utf-8?B?UjcvOWdPYWtJMWJaUDB0WHZac2tSRkx4enpCeVM1b1pWZ2JtQm9ZVzM1VEk1?=
 =?utf-8?B?bUtWaUdJUEgxNk9ldW9lbjhyUkFudG5iSzVzMGFjQ21EZGdxS09kZUJPTGdm?=
 =?utf-8?B?TVcyQmNrSUs5eUZpOUEwQy9ObXpKN3dvU29Cb1R6aUU4RjE1WGlGdXZ4NVhh?=
 =?utf-8?B?WnpxZ3g5RVRhZHJHQW5aaFpYWDgrTHhzRk52a1Z5bnl4MnpxZHpPNVBDVHZo?=
 =?utf-8?B?UjJLcUNaMExHQzFVZDFhVGo1K3dvM0ZpT09VeHFNTFFqY1I0SXFqRTVvS1dH?=
 =?utf-8?B?ejB1cjRCQTlmUWF5TVBPcHpVMXdIajVVR2RHVW1ud3Rmd3BjZ1lDaDE1aTFH?=
 =?utf-8?B?VXVlc0NkVjIrRWdINHNydEYrSGZZakZDYlNqM2l3cnpOMkk3VjRrL3YyRzVs?=
 =?utf-8?B?V1NmSUxOWTE0cUl2bE5xbnlqZ244RGJxVlk3aFBEV295NnBtS09sd0pyTGpq?=
 =?utf-8?Q?Im7e7p+XkC8hd4Y8U+FnU9+HY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hp5dIPZXeICZwn/qvF3S/4Caq2tgogRpv0JhcMiXph55RR1WE+lVPknk4BnX2kmW4MkGZyK1ALGrI9yE8U7q6nEcGogBhROoALxTn/u2wR+baZLLUxDFVGCekda1qRYf2xIm+iddfzMuSVtNwU2W23TkJiaSIkuK4EXOllG8q62gq6l+Wa4zyg+x6lq2+G2kcQAFLd10aL0O1SBqCCRU4uH2jeMeEkZxeUs4GiEHXW+IU2CFfYep53V5An8bSYzgKOtikq72/Y5rbI8tU39P2hhboDicgjS9f9tQ7JmbwMBrQnYlqe2InYS+LYj5w6n/hLdVV3PUShWGxrIGry5p6ltqftpZESVM9Ci8PgFvQ/baREJKt83qK21tGBykkYZ3n4EnE2pmJVzh8lWXAAcJ1Zx/VyZ28LLsorrMYjla5cpUZrRejcwiAVs8VPImNCDsO8Wf4VQ3mlAiIj9tDo2DThApaR2z+jVZ8Cx1KhYlpRYX7hkEw+TRLxzDM1PVjs2kLD3891WIQ4PlCCn47jMJKOr86HhvHe3c6fKJgmXHc9qY/3Q6BCeox6P6mFigd6dCZ4WPDGSoz368o0qFJZ15yDQQWDcFPS59vJSVq40Y5k8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228d6936-adb1-4fc9-3e4e-08dc96a1f42b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:09:11.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvhXud2MNddHch8L07ywetfEeLiUzHos16pzxkV8T2lFpMbWSA8MOZrd63G0a9eSxHhIDAnQ4caUXJsZDChG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270092
X-Proofpoint-GUID: SUltdEtqj_DsH3pHnvHbDLs5LFQdSEjY
X-Proofpoint-ORIG-GUID: SUltdEtqj_DsH3pHnvHbDLs5LFQdSEjY

On 27/06/2024 12:14, Christoph Hellwig wrote:
> queue_logical_block_size is never called with a 0 queue, and the

nit: could use NULL queue

> logical_block_size field in queue_limits is always initialized for
> a live queue.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>


Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D819DF9A
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139971; cv=fail; b=UzHAHdQ3NujVsXbWQeHnuk58fdCmTDWMydOMLzNTpAQxo2LdS/Wd+5PXRczDpjqriHPgFufGCRlOT8HM0l0il4YuQF1qj0YGpd/AS0lEXMjfqETQMyZHh8U17pehuVzUMfNs/IRq0nOFI+8H84d+6o+ZbwOH2tNHr0iJWxYYMMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139971; c=relaxed/simple;
	bh=Avyg5hWFGv1pZASGpRaoL7rWaKwRmP9liAB25YV5hQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bJKGqklVscNSR/nbpMFDgrDomi5x/p/t/YfDTJczF0tGQvAFZt3ZZQtlnfsocbRcaWNyPfe0Tg3Hf8JeWu666XLTBJyYJrtNCuBJ+/1lY6au1Q2wDYPzirrbtJEWn4qWJV3eY06XFT1NGaKSe1bo9EUp4b0T3MtcL5jvfX+23kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UD08NdzF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vUf8Qh8y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UD08NdzF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vUf8Qh8y"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GBux3V018715;
	Tue, 16 Jul 2024 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=oE6INkUEqZffLYxoNqlD5BDYkp2s1hMkqDG+zDxiYmc=; b=
	UD08NdzFJU7pqtA+qVd2/qKSp14IgYXW73y0/Jv+lak9+n5svO8hSBGpHMTBvCVp
	CZMMk/wRhsy1SPufzA2VuAugZkM3tT6H7Rpq/nbwLLWEcKeZSgvQe8DmbYR5Eovk
	zJ4thav60L3PUkCrz9XNC0yrFiKHeRodgCUszXP9XRKzzL9XGgnEg85MNd8Izckw
	T+nD5IlWZ1Sdzo4RVGJB689GqMDUieVHbXnUnS6+y38GorvvfUrqZtKq026PgHML
	mOhcdE7jFrSQjh/bKoILEohbUhxSvEt5ZtR6k76NRL59PNjVYRkvBya63JNQyYBy
	zqT4wQnqVrX9SttNdlKEWw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg0cp3sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 14:26:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46GE0PH7040707;
	Tue, 16 Jul 2024 14:26:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg19e5p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 14:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6GhB7ga3dBSumCCcOjKP1H5gpA0EwduX+dk7VzNRRcfy+rui4FiGELOeM4YXKn4VeqIQ20a9XFbAYhJfJH2vd92UvGXJ3UOBa6e+dz45c3lC57w03L6jMEav0ZQj//NP52wOHWu/umPRpIiYDgqYV+iK01L7gFD8L8t9TEnFTgcGk747cHXOF41qdr25mJEENT59mZwQwPdZLFaVf05C/JbkYhhhU61Rgl6H/1I32SDUyVHmXpgmR2aax5NDgDtEr4jqNZSQQ/dT27ljpXe7NRSoefmrUOJJry5xZg5quf8FqC+CcoG64xhsVoLb7L7Aqbz17HWTUib8JPwNkjbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE6INkUEqZffLYxoNqlD5BDYkp2s1hMkqDG+zDxiYmc=;
 b=kU+N7I1gZSRiDwQGLb8FM+qjSj5F6HMWPX6KuQvx8Azru8FJgj/EqeivRSkqaTGSYUTeHZ5KFZ3hPBNBYiRIkNlp6teIJ2sHeqRxnf/Ozf+6vPumEvdqiE7FqB1neBiLLAHWKV3x3tRK61Yjl0MpwW497m1dy9QukHwoqI0qw3T9dPL4Exu7+N+E7nN+bjMRkyARiA71rASnjft4X9L2YPzdBpxm1ZvRCV+iCNBIhZFlEOPabHlGzWT1E98Fvh2oP9WzKRKoXp84TZf90sm7bdQW2iqLYPGxfPxaUI5wW43eTh60Y+D6sUllxH5BJ72Xb0fhLT+0LF8OsiUdRFvaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE6INkUEqZffLYxoNqlD5BDYkp2s1hMkqDG+zDxiYmc=;
 b=vUf8Qh8yM9l9bogSYIXe3BdIXnWtXVvvf9+9p96hrBl5zncz3JvYCHA0/KzoP4Ru3lgj8KDaT9UEecGrSeY9tbI4EEDIAH32m/69x7piKGZWcauFNu/mrB3XqCQyJaTZ0EFXfK5b7uQ0k+8OhNQQ/XXWvODEYzaxSXFBzafG4Dc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB6992.namprd10.prod.outlook.com (2603:10b6:a03:4ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 14:26:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:26:01 +0000
Message-ID: <9cadf5bb-1d5b-4979-84ba-c2dcfddf4133@oracle.com>
Date: Tue, 16 Jul 2024 15:25:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
 <CAHk-=wjZzZJCzRd1Cx7e7XbXCL-dRJTLZUoVu3ki=GvTuA2gxA@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAHk-=wjZzZJCzRd1Cx7e7XbXCL-dRJTLZUoVu3ki=GvTuA2gxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ed48da-5244-41c0-4f8e-08dca5a3379a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnZhQU1CcURjcExuQUsxd1JiZVNlYWNzYUQvd2VnZkErSGdGdHBoVGV0c1Y4?=
 =?utf-8?B?V2F3VE9QNm54UjZ5UGFLNkl1am9qdkNPTm92SmorQmFLRzBXR0t0RmtvejBN?=
 =?utf-8?B?bExuSmk4SG1vSWZwK1lMZ2JmbjNlWUZRUmZoQkZkNXdobnRBaEEyZWFpRWR3?=
 =?utf-8?B?aEo5TDFzQWlFbmFVQlRPellkVGZDODU2dzJESUFwblo4ZjFaYlRZa296bkxs?=
 =?utf-8?B?V0F3VmhURml0VHVNNUszS2VJNjhNRTZjL3o4czdCVTA0V1pnelQyRkNLVEFv?=
 =?utf-8?B?cWZnVnVPd1BFNXlkM1IvNjg1NUZOaVVWaktsZ2I2LzRkZGRqN0hYYzFGVkpt?=
 =?utf-8?B?dVBsU0xJcTlWQ0ZjYXUzSGlBaVNESSszSTBZaGFVUWhpZlc3ZGxxQ3hVQ3Y3?=
 =?utf-8?B?U1lhU1ZxdWEzemVwenpYd1dPSVBZTFk1ZmRVK0VqR1h4SVVibVhZSncxRXlV?=
 =?utf-8?B?UjRWZWg5WEowbjk4YnBQb08zM3V5VkVoWEFLYWc4bFVyeHVsRFF5NGF0WTNS?=
 =?utf-8?B?cVFYVHpUL1JyWmZWYnlCZXVtRlJlM0c1M3E4YlZnSzd5ZzN2ZUZzUDhobVBS?=
 =?utf-8?B?WWh6aXFZSWQ3WXArSm9sMGprQVFNdGluWXdkL1hGenAwK29URHBPSTBoV2pp?=
 =?utf-8?B?Sm5NUW1lUWpqOVQ2bk5XNVlHWnhhYThTa3B4MGVjdUlUVG1obklHUG56MDJQ?=
 =?utf-8?B?STk5LytsMUhjTTBuVmlPL0pLRnNWU09yNVJXMnlCc1pndFlGcHRzOE16L3Nk?=
 =?utf-8?B?ZklnQnpTU25UdkE2bER6QlRIUktWVldaYTVUNzAzYk1LVW9kMDdaZFpnenFu?=
 =?utf-8?B?R3BibGZTSVlMYjR4MW50TG8rMk1lTmFTdy9yeWF4MTE1WWJYYUNTN1lhdnR3?=
 =?utf-8?B?ZzFDR1ZWRmdjcGttclpEUTFUN0NmUGJzeHp4N1pKRlNwM1h5cmZ5NldTcDky?=
 =?utf-8?B?OUV3emlMVFNwWGtuVzZTQkZrL2VucC9tdmdoQmt3ZHN2aHhPRnZ5aHd3MTVv?=
 =?utf-8?B?QktubXpqV0lQUDR6ZExNdzdDc1lvNk9oOTRPc0Z2SmJCSU9CN0dZd2RMazRB?=
 =?utf-8?B?QVg0Wi9Wb2lKMzJwb05VcVdEV2pOYWo3NEQxbTM2Wk5rc0YyNjdoQmxRYlB3?=
 =?utf-8?B?QW1NNjhoMUp5dFA4QjBMZ2dJRTFyU21HalNuZG41dUlQT3ZFQUdwbTQrVVBN?=
 =?utf-8?B?THVZVkowTzlreGRueUhkYndDRS82TElNSnIyUUh0M3hCekp4ZnJPMjZwd05s?=
 =?utf-8?B?WGZlNjhvRUxWMEtCeTR6eUZUSmpMaDFDVUEya2ppeUpFbFJjWnRHdTVaVHF2?=
 =?utf-8?B?NWxlZGJKd0QwWVJNZ2ViaHhZVUY0YjNOS1piU2tKV1JDODFqTVhFbis3eFlt?=
 =?utf-8?B?cER6ejRiem4rWVRuL2tETEp3T1B6Tnh1VHpZZkJrTnFuY3VRV2dtc3V6OEdo?=
 =?utf-8?B?djdtdW5DMVhMZ2FBTXhNZjltSWJQdlNRV0owdVFmdFdxMG5IQnpYaWRUay90?=
 =?utf-8?B?L3Y2Q0MvbmZ4S0ZrNld4TGhPR2kvaEFZMDJyWko5Zk8rb0hReE9kcTNzclU0?=
 =?utf-8?B?WGhwQkRjWEJsVXB5d01NV1d0b1lNZ3JtbWFhLzVrNG0rTmRRQTNiOVE0RDVR?=
 =?utf-8?B?a0FxY1BCNi9sNWp5WE1JcDBVelhMTEFEaVJzdFAxTW1vTVVWa0RhQXlaSGVZ?=
 =?utf-8?B?YzBzNDFWZEU4T3hIb0szSElnWE45RkFpLytNUGZhbVgzOCtMUEFpODRaWFR5?=
 =?utf-8?Q?S13liSSJcUS768aKWU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bEoyU1FuaTRUUGQzTFpRamUzeWd5L3BPaVYxQXlvdU5RQld1ZTBrbEFnTW13?=
 =?utf-8?B?RHJJQXFTTTVRSFN5TUVORUprZTRmalpkYjNTZDZ3TVpoSmZyaW5manFvZmVY?=
 =?utf-8?B?M2MwaTN3SnVVYUhSeHhlN2h0Qk5DcTFvZ2RkcDJxdHhFSnRiN2FNdnYwcjVC?=
 =?utf-8?B?YTJ0VXBzT1NIbHpadGZxQU9rSWN0T3R4VzgwT2c2aTJLKzMvbzdhb2Y2K3JK?=
 =?utf-8?B?a2hPWUgwdnZzQ2ozMkFTSllXTWRkbTdXaDY3OXY1MkkrTzRhK2Z4NGJYS0tq?=
 =?utf-8?B?VWRqd29SLzZ3V08rdTgzOUhiZGc4ZVJvZjZXdk13WFE2eE1ZK1hHa1RBeGVo?=
 =?utf-8?B?blZOaGg0aERHanRWOEozbXptVFFPcGhQL1N3VTUxM1lpenM4c01lQWhYNmFG?=
 =?utf-8?B?WUVPYVVCaXBpSXRIOFRUOE9tNzNXVlJLMmtsZlJTMGthcUZ3R0ZlSUM3OVNi?=
 =?utf-8?B?a3NuUW9UUFFzWHRUVlhXWCs5citLekczOFlkVHpTeS8wU1dmTzFacTBwZXJh?=
 =?utf-8?B?MmlrMll3VFhiZFc5ZHhKTlh0YzZNSU1mbHBlMS9xUXQ4UkR4UERsWE5LOTVv?=
 =?utf-8?B?UVNDUjZYVEovWnZHbnJyZ0dYTDAyR0FscjRyYzVaclJCUnB4MXVwVUJYVExW?=
 =?utf-8?B?OU1QMVJLVHdqQmFKY084ODB3TTA4Y3ErVVgxODNlT2R0VkQxY0docS9nejlv?=
 =?utf-8?B?aFpCVXFaSUNod0NDWHU0WWZ5VkV6cUhZV1dkby9QbGkreHZEM2RTQ0ZDdjhX?=
 =?utf-8?B?S3VPTVBFc0M2YzU5bll2QkhtanB6aTl3WGpKNFVlcnFhcFp3eERUc3hQNzll?=
 =?utf-8?B?WnJSNDRlU0pIaklmYWJHbnRnMVkvaDVTQlNvekI4dG1takQ0NHQwT1RUbkgy?=
 =?utf-8?B?dFZBb0JPSkR0S0t5RUpYR0JldFlPKzFTSW5rOHl1a2JzZDdkQ0pyTDl0WWVK?=
 =?utf-8?B?VHdsd0N6aGRkcit3NUxLUGI2N2xRdDJkNlRvbWowMGRoUG52MFpaNHJaeS8r?=
 =?utf-8?B?N0ZxLzRNTjFOQnU0OFQrQ2hDKzltSm1iMXNuOFpHYWZ2Q1p2bDdEMDBTaUo0?=
 =?utf-8?B?d29tWWJxcFBqTkZnTHlGS2l0WC9pcWNxU09PaEhocTRTU1ErTlR1QzV2aDE3?=
 =?utf-8?B?ZFRLSWxudDUrRGs0TG5ZNmVtSkR2WVpkVlZ6cGdzbXNRRXJGMnJkVFlLWXVL?=
 =?utf-8?B?QlRvUzUrcFJVb0xBQ0wrdmRtZWkxbUZuMks5aFlhcWR2SkJCTWErb2lqcU9v?=
 =?utf-8?B?eWpLVGxpenMwQTJvS21McnMwWmdmblRMS1NWekNUdXgxUVZFcnZOYWp6TUF6?=
 =?utf-8?B?ZHByTVhBbXcvSGZYSnBzdFVKT3ZqbjQ1eEJVOU9yY2hueTcxV092SFJUZFdx?=
 =?utf-8?B?SXFWT09TZ2N4T0FmSVlYc0NTSWpLZC9hOU5hR0Q3Z3p4SHhiamNxMzc3RDNk?=
 =?utf-8?B?UXk1QVZaZTFENjBaUWVUK2xueUd2UHQ0SlhGYzdnZEw3QmJudUxpZ29wa1JQ?=
 =?utf-8?B?anJ6Y1VBMm9RbU8vM3V3aHFBdHArbDZkMU1NNVk1Qm9BSVlRRVhkaTd3ZXk1?=
 =?utf-8?B?UFVlV09uWjREemIzckdXMnJzcHgxMmlkb3puemRVUDNERTNtakJtaVBJSUxi?=
 =?utf-8?B?alVnaWZDbktCWGJYeEFrMUFMQzVvZVF1eHptbmUzK3JnVWp4dXp3Y0JqOVUy?=
 =?utf-8?B?blZkbUhoV3c3YVBFZzZoTnVNT2pBRnBOTFhWMDIvSjlYZDM5TWFKekgzem5s?=
 =?utf-8?B?SzdwSjBzMm9rMy9nb0ZvVCtYRzdOV2I2TllkSHprK2hxLzVUTGdqeHZWQldI?=
 =?utf-8?B?ZlJyL3Z3Z0dCZ0VKVnFMZTNKcjRXUnFvaDVhYVljQzFGb29KTHkwejR5d0cr?=
 =?utf-8?B?ang2OE02MGJDVkh1WEhUbGVUZVZablpReVB0Ui9MVC9acEZWL1FrQWJqcWt0?=
 =?utf-8?B?d2cxZkJ0b0JudkxPTlJ5SnA0UlpDMUVmK0ZLMlh0dGxyMVMrSWhUVEl2M284?=
 =?utf-8?B?RUFMNGRTaVh0b1MxaGRoaFVBejQrY1VpanN0ckx5SktEOVJFbTFBR3l5Qllv?=
 =?utf-8?B?RlJXbEdJS0VCWERuMWtDS3oxbDVVdjNkZElJUEJzdkJxMm1lYWIwNzZ3V0hw?=
 =?utf-8?Q?J008yqKZhmqXpcsmTTloCBr35?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SoZq14EDDolv7tSl5pfvJm3AYdvPXr3wJlcw2U6z7vvqiRljZEXwgkhAtu4JDPipknjs91y0ANAg8dbDilkc3ny7AwiddCz7QuwBCyHRTBwb7MqHJLeKyrP0HYxjYxBcHFga5a77RX24REIC93emviJyW2w5VyhUWmJ8QH/xXHcC4E82r6h71AwboRPmI2W9vsgPfL1Op0v1DeLFFvcid4UfKXNpeMG9O2iHupnly8mVv+lagi/cSF03/5c/F5qgnz4r1a/+2hVQ3jgyuVfY/CIupEeL8GsJLDhsY+Wsot53z6kdfV11klsoPyqdXxpdNjgHn6ILSZ/yPwopZsKmn21A3U2cEesUJFnMv/fdCtGkYMIkdNuwpsEC2IpsVp2NF4aeEJVoGV8wuMkc8mHJJAmI0GFjA/CxFFNtlb5Vvq4yxClStceMcrYTCFb+Qm801vzXomXOC9qNcpsRqLdnxpD/XXahiyM1Q0HDj0e4em71xDYA/6bt/fqzWLIS1PVaaboBZJ2did0q9toHcsVSgB6sfxefRjulsk5BRHg/KpRRpFBYFsOZ2RgH2NYOIdAnD91oGWbx/ycae+XY5y/c0O2KnS4n20z6Pgc79Zl9uFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ed48da-5244-41c0-4f8e-08dca5a3379a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:26:01.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eTUCzqm07kKYqKOY03lNdsnnPdWoDiE3EWRxoz1UmT+MtwQAcQ5GIwTvPVqb93nPr2Ww8ZxLp4agnDx9k54YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160107
X-Proofpoint-GUID: x0PbSRfws_QDCPWYxdLIcADCIhK9hSs_
X-Proofpoint-ORIG-GUID: x0PbSRfws_QDCPWYxdLIcADCIhK9hSs_

On 15/07/2024 22:32, Linus Torvalds wrote:
>> Note the statx change for atomic writes will cause a trivial conflict
>> with a patch that went into the 6.9 kernel via the vfs tree later than
>> what the 6.11 block tree was based on. Easy to resolve, only mentioning
>> it for completeness sake.
> It may be easy to resolve, but as I was resolving it I threw up in my
> mouth a little.
> 
> That whole
> 
>          struct inode *backing_inode;
>          ...
>          backing_inode = d_backing_inode(path.dentry);
>          if (S_ISBLK(backing_inode->i_mode))
>                  bdev_statx(backing_inode, stat, request_mask);
> 
> does not belong in the generic stat helper. The whole*point*  of
> bdev_statx() is to not need that kind of bdev-specific knowledge.
> 
> So I rewrote it to be
> 
>          if (S_ISBLK(stat->mode))
>                  bdev_statx(path, stat, request_mask);
> 
> instead, and that whole "backing_inode" stuff is now inside bdev_statx().
> 
> Because wasn't that the whole point of abstracting this out, so that
> block devices could do their own thing?
> 
> And if the backing inode is a special block device, but the "front"
> inode doesn't say S_IFBLK, something is very screwed up.
> 
> But hey, maybe I screwed something up. But randomly having that whole
> "d_backing_inode()" logic in there seemed entirely against the
> abstraction layering.

This code bdev statx originates in 2d985f8c6b91b.

In looking at the lore history for that commit, Eric was passing the 
path at one stage:

https://lore.kernel.org/linux-fsdevel/YrgPOHarxLdMt2m2@infradead.org/

With that change (to pass the backing inode) came that big comment in 
bdev_statx{_dioalign}() about what backing_inode is - I am not sure on 
the value of that now.

Anyway, the change works ok for me.

John

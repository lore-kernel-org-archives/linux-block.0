Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446403D551
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297625; cv=fail; b=k5odULA+sIymtGi0DxdQ4aAzra0GcR4PZBldflCBqw5wUxlmgDaBCjK2zZMci9XrpXa5NkbT6SJ3ypGXF55RuNas2NFJGJ0g9qNFds/PrHC/iAU4aUEzYXkpVGNJSy/NzcQIq1orQTms/wZBipBBll58tZ6dwrYs4FfXE2vAzqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297625; c=relaxed/simple;
	bh=rh/pkvzLyNGEPexgxsCIcKxf2IKPz93QCcyODTaRTZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5BV9pnVxuADTNprbt/jmPfpcTHzbuQWl57d/fNeUmKj3rnsqnA3AcXqKDskh0sZWnM2GFqfd485X7oHQtK0RZrfJLHazAlngbTRiDNkZQ3DKbS9wcwg2lCPGt0gs9qqy9rNpFC3FEf3J78zxEokWTBsR63nOPbtYszTd2TiMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KmHf4ECy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=smk8LuLG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KmHf4ECy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="smk8LuLG"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UCPAB1018971;
	Wed, 30 Oct 2024 14:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k+1e5dAPjYuBand3caeDpOITGrJrZiiS7SKMv53Al78=; b=
	KmHf4ECyWkL8gRR4RjLI92VL4KLR3PTKSSWELN/3oJUD818LOWKag9HwSBerO+xW
	XWforBjBM80Hbv9nUjBWAXOLOkY9R8KZPuotgRPk4VUzRMleaQzZqbesmsQgwAqT
	W6OqPlRD+nqr8eGryjuv2C2BySO1EYebE6i7hD946prG1QmqG7/LethjOXSV2+jS
	m4lOrTfeUC7pAJVZBr+/1i5yR36oGK5jQvI0QdIbso/qgKiwgciLWpHUy/qq0jhi
	0vKJ8dInidax08ejoF8hpHgBWpz04oExj8JtTCftusCvKjLDFKSrWMFMwvKhRZcN
	tJtRHI+OLeKYWVveBCdbGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc201k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 14:13:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDqodZ034886;
	Wed, 30 Oct 2024 14:13:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd95pt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 14:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRKNbk7P/GomP5uPqvQl0y3bRtjKvEOxeCFaG5tj+vLLR/TjJbkaKYDbEjuuKD49/pZ3a+JbCF397LMqdySZ4MSrs/zC+EpcgLbfpbkuWoSDHMjw3GQgENXAJ84YcHSxNRk/bJNUN8iEx/Y483UiQL3Vs8VSZ+X6TZcqiSLlAPZ1EnEo+lJYYjdqrW4k6Dmtwfz4HUnW+zqT0m3EqoP54ox+1hJT6XUkAD4MVEFZSoaHPjBxCEiYsFlqA9claQYY50ViFgr2RmbMD+cGLOvSi/wePVuQHSgi1nXTfKrFcCDRVAju4AaE8rjirvUGcV3nAA72iZLmu0JpZEYTkiU/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+1e5dAPjYuBand3caeDpOITGrJrZiiS7SKMv53Al78=;
 b=dgck5vlMiUG0QG4UZtrJ1DW95p8p3A2IyKl2xTLN60r2iN9mJj+QYleB7+bUQVAyb/9/TdXtKQWM4D29eWys1IYAtzs0x4KU7cvkov6IsXIJNoc8mPei1DcR82Sd5AlrEX6E7HZUbkiLJyG4bYQvmJFVWyhILanodB0E3Yc0Sh1Bd8QArFwsv40ftnPfP8OmoKFYHEZdt+Uct3noWhKWrYVBn1SqjxlnE3xRTAS9gvjCr/yUuwBF9QKdR9zE7O1otW9x4yJd4eCg718/E8wP4kf9e4WB3o/8alLyiwrIdVtnDTWBrxY08hfArgKsp5azx/L4wPUR+q2pnnOkSFG5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+1e5dAPjYuBand3caeDpOITGrJrZiiS7SKMv53Al78=;
 b=smk8LuLG3FpHh2eQCcWjFYkFWf8eHOPOw7+JA3i9XwQcMk1GJaci9yL4rJSEGAWMYWy4moQcOvhAXaVf3CbUn68GkyMoE6NTDuVuvUo0QJ2Q2z10jV6k1oDf5DAplGwrqTdPA6H6dtgTkCCe54yuIP5gGzDDr4oQukR4FJ8at9E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7452.namprd10.prod.outlook.com (2603:10b6:8:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 14:13:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:13:34 +0000
Message-ID: <27a2e5e7-9dbc-4fa6-81c2-1a8df906187b@oracle.com>
Date: Wed, 30 Oct 2024 14:13:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Use bdev limit helpers for configuring discard
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20241030111900.3981223-1-john.g.garry@oracle.com>
 <20241030140601.GA29107@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241030140601.GA29107@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 258b4211-0ab6-4f50-52ec-08dcf8ed0a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0xtajRUaEdIRlVjUy90akU3eWJwd0psVGZWMThMdzdzTkQyMkY2czZGMTVo?=
 =?utf-8?B?d1M0VWM5cHVOY2FxUy8wNSt0c3gyZWZnclRvNWZKNmVtMmUvWTNTSEQ2VkxJ?=
 =?utf-8?B?YmRDYW82WEZURFhUbnF6aVNVZjVmRWN5bU13UXNlM0dHV3NyYjYxcCt5Q3pD?=
 =?utf-8?B?QTU3NEFOWVQzRTk3M1QxZUgzb3dnRU1HUm1OUjhiRGR4RGpDTDdRVmdpWDZ0?=
 =?utf-8?B?Tm1OaXlpK3FvODI5aGJjdXJRdmcveitSM2Z5VEdGcVpSUDRnMWpha3UzTDN5?=
 =?utf-8?B?VkoxOTFqYTlMNXRQRmF0cFF1YkRDajlUVHFvYXlCU2o4YUloakNCU0IxQWtI?=
 =?utf-8?B?N2pLbEZvNGM3NWdVbDkwZW5nMHBXUnFVNTJVSVNYZlNmNklZaHR2L2prNWZu?=
 =?utf-8?B?OGFLa0w5UDdhenkrQUQvYXYwNTlpZ0kzanQ2Z1lUR2hQWFBlNnhGb1g4NklO?=
 =?utf-8?B?VzZwcThDSE1VU0NpM3hlenJoRWpqaVNZUzBrbGVvV3dmZ3VQRnplakg5aGFo?=
 =?utf-8?B?a3lGTWo0R1MrYUtTQTZVQi9nV2V1ZnBZME56djIyZm1JaUVvODlFb0x5UWI4?=
 =?utf-8?B?b1BWejNBOHNtNk5vVmhLWWthWlFlY0ZhMEJlUGlJNHpBVFV1VStKNlBNVnNM?=
 =?utf-8?B?QWJwb0xGN1Z3UU5sVlhzZmczendWR3p3VVVLbGJwcTdjekhPUldYd3pWdFph?=
 =?utf-8?B?U1p5NXB3MnlDVnlLU203ZUpyRVl0VFMrdEIzbVNCekQwRG5ZYWVGVzAwNmZm?=
 =?utf-8?B?STJPYitvU2hZRmdxSzRzT1RTZ2NQYlNHVWNqUER2Z21QM3lnWjBrbnk3cGFs?=
 =?utf-8?B?MDlhelQvcnFhUkxtNmtRTE84TEY5MG5PZ2xId2NLYnQ0WWpNVm8rN1k4R0dW?=
 =?utf-8?B?OVNKS0lHSUZlSThZYlBLK1RaaVFMYlI3RWhBMVlTNXBaWkhSSDl0OUVYNEtU?=
 =?utf-8?B?NzNSWmM4d3E4NmZBL2pyNlRGSXBNMEltVDdiQW45TkFxcW9aakM1WjRmNk1s?=
 =?utf-8?B?RERnR1BWaGVvMmJiSmJ2eGNHczhvcHRjTG1CMmJlT1hJT2tGeWRXRFlCbTJB?=
 =?utf-8?B?SHZrekxNUy9xMXlUWHVXWnArYzFmZ29TbEU0eWtiUlJra2gzQk1TK2RnNXpl?=
 =?utf-8?B?STZLN3NUQ2tOY0E0M2p4cGRWZTVtbXJoTVRodkVVSkVLWVdGb1BYdkhHNFlx?=
 =?utf-8?B?a3ZaWHNaUEFsejNzNWpTWlVvOXBrNzJJK3ZsZVVaQ1VjeFRvTmdReXB3RCtV?=
 =?utf-8?B?eTRFdWdhTmxiS3RQVVgvM1NyUnJQOUc1VFFEQlVoQit5cFNKdnhDWFV5REt0?=
 =?utf-8?B?NXNXbEpaS0l4b3IyQVF6WkJ3SHJXYjY3SitRMjlETy9vdHN4dzlEUVQvU3NL?=
 =?utf-8?B?RkVDY2xHRUFZckJBV0pVenFqY3JqUE40WkFOeGlMSGlsUG5HYkRMRmxvb1lq?=
 =?utf-8?B?WldYbjVBNkVORXFraTVjN3BxaGVUbzdRV3dGbHpXZHNBcDdOM1Y2WkxqenU1?=
 =?utf-8?B?MlhpMUtCRm9FK0NjcHg5OHhCbFIzSXlhMHZFOGY2V1o5aSt6WHQwNkR0dENG?=
 =?utf-8?B?Q3VUUVdVU3c2K0JBSWZleU96V3VrN2pYbG1yT1dTQ0ZXeEQyN29uSVZKb2Nl?=
 =?utf-8?B?ZzZjMEFQWkg0TDdwbWlwbXV5cm94WmhjMURPdStQL0hSS1lzYkZRYVk4ZFNs?=
 =?utf-8?B?TENRVVJkM00rU1ZMZCtKZitlYTVVd0xiZTVmWjBHays2MmlhMS95ank0Qi8y?=
 =?utf-8?Q?+lGHPZvqv+SuLGJgWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVc3c090dGFScURhdDFYQ2M4Z3ZRUXYxYmpWSUVmUDVNZ0tCMmw1Z0swUGZO?=
 =?utf-8?B?LzIvYlA3S0dNL3BLLyt3V3hSM1lqTDZDUUJySGlNSWJsU08xVUtYTkFkbUt0?=
 =?utf-8?B?V0E5ZENtVlVuS2NYdDFxRGlpY1Vaei9tUERBc0RJc01sOUFqb2F4dEh2K2Rw?=
 =?utf-8?B?cUpjZDhxWDZnYi94UU9xWkc2TU5PdW5BNTkvTWNJdlQxTVFxMGhyWURwdTdv?=
 =?utf-8?B?OFZ3bTBsWFZ2QVRLbEttNmUxbXg2NDJMK2hEMVo4WDJ5ZGZKZXNnQ1RwQ1pY?=
 =?utf-8?B?ZGpnNHVKd0djYTJnZGhGNUdEOFNEVVZDZ1FhWHpBRk14bm1hc2pBZjRBNkhy?=
 =?utf-8?B?cWl5RngwaEpDZTMyejhvMDZ2SWZiMnoyM1JQSnVtYVlwWkw5amJNM1lQblRh?=
 =?utf-8?B?RlFWa1ZXTUxQWWRCaE1LNFVPK0RBMFdEMDN3K24yNDBvUGkwOTVVeERRQ0g5?=
 =?utf-8?B?VUUvQVFreG1lUmJXK2VqWktINzkwNWdtM0M2RWF6dUg0UEFSUERsQUlSQ2FB?=
 =?utf-8?B?WlBIaHZURmNVNEk1UGdmNCtoOVRGZGpBOGUwaTM1K0E3SE9DMTJQSGQxWkdU?=
 =?utf-8?B?VGdwdURnY2ZKOXZVendocCs1MVBzc0Z6NnQ1c20rWlZySzArRjU1MTBmOWIw?=
 =?utf-8?B?OW82cXo0ak8xRmlVT2dmc01MTHVDVjlxSFc0TDlTeHJVNFU3SUtXdjZCUk5Q?=
 =?utf-8?B?UWhNTk5ObURlNzJ6bWFEUDlWYnZwZXc2UjFsV0JzWTRZTGdUYUsybC91d3lp?=
 =?utf-8?B?RFRJM3RiNmN5UThhOVIzVUpBZ21zU2ptVnRxQzNzckVMYWJDdDdHWUxFbXpl?=
 =?utf-8?B?QnN1K2t6czZMMkxqNTVtM3drN2dhL0t3SjM3ZitJSG5vWURUbzlDSVk5NGFt?=
 =?utf-8?B?OVBhT0x5ZmtFZUVwcVFPV211eGZiMENuc1JXejNiMkZuZWlNT2ljVzVtSTRO?=
 =?utf-8?B?dG4wcWFOZjUzZ29LTWpYcmhGaTgzejh5cGlYN3gvd3lPb2NsNHhLQXNpbzI2?=
 =?utf-8?B?c3pBWXFmdXBFUGZoYVdqQU10TlAvc0w0azZQMlNwb1I4UXZXMGd3aXZjSFZi?=
 =?utf-8?B?MjlFMEhRdVd1S3hxNFQrVThtMmtXMnpnRHpGWlp2aGFVN1ovaHY1NnVtM2dK?=
 =?utf-8?B?dWVnaWJwREcvcUtkbnc4VGtjQ2lqcG9TWTBBc293bm93WXZBbklpNmNVSElE?=
 =?utf-8?B?Y3Y5cTlING54dDZuaXlCaHA1VWdaR1ZVV205QUtaQlJ0dmpBTmNFdmFrUTUz?=
 =?utf-8?B?QzNNdGYzK3VWdVhWWU5Od05PVjhBeVZRRHQwS3hvQWR6aU5SK1crOWxDVlhP?=
 =?utf-8?B?RzhjNHJjNWU4d3JjeGZpZ3M1YysySnFkejU4QmdmWVc5c0pMdE45Qkd0VTFk?=
 =?utf-8?B?Y1hmNEttc2dFUW5jRmFieHlqZHdvMksxUUVLWE8yYWJmK2s0cDJoMTVldkZT?=
 =?utf-8?B?NDNQYWhHb3RBY1VOQVdhaExhVExoZEo3NGtGRVh1K2lCZ1d4aFVDTFg3cFM3?=
 =?utf-8?B?MGkwZ2JqSjViTklEMk11OXNXdUw0QzQzLy94N2V1SWh0cnRQRnFGRHRtVXVI?=
 =?utf-8?B?bWZYZW5VdEpsMUQ1TSsreThuUGw0eVdwWFBvR0gwUVhGUjJNaENDNUgrUVMx?=
 =?utf-8?B?dUd6a2NYR3hmN3BvYjQ2ZitNNnhUT0N1aWdvUXBpZjdzTlAzU3kwRXdEZjEw?=
 =?utf-8?B?c2xkMUIvNVVDcklhQVF6TmpRRFlnek9NMlE2RVZZU2NKcm40b25IMmJEbGFX?=
 =?utf-8?B?NDl1K1hjZnN3cVZVekMxSngyWG9KT3AwQkZOak4xY1p1ZXVHdTh4ekZuTmt4?=
 =?utf-8?B?SFRtSnphTjU1NUJzcG5JSEJ0elZrUDhVQ1c2b084VmhzS3ZYdTdMbTN1eVV3?=
 =?utf-8?B?N2RlaUFlWCsrZHlCVFFYeWxZeXVjMjVuVnNxeFRGMDgwNlBGWndQTStjTExt?=
 =?utf-8?B?M1dFWlZrOFNvVWhEVWE2RzRad3dncnEvdThRM3NtbEtvdnpPUGpOdUhTb1FH?=
 =?utf-8?B?enpHNlpYV1BjdW1tK0YwQzdGdEJmS0pmTXlkSmZ3VXEvK2ZOWHdnc20zMmtD?=
 =?utf-8?B?b1IrTUhEUU5sai9lNm5qUmxhd21YOTVKT00vTlJhRkJCY1pMWnk5WkxwMmlk?=
 =?utf-8?B?K0Nxdm9rN3ZmNVhSTzRZZFA1RVhCZWpVS1JKdldhWGhXcXZuWEswcDg3b2gx?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZkw11hsQZWoeqBNIRTG1gyDlasDg0ZQaYNmZz1RmFImwtiZiNkrpvY2TxOYh+qsYZtDmXZUSMZ27biYjzeKvBrcaL7vpi5HsIkfPxp7SVIkI7kKC/kiT6/+2rAROSTstSNwYCJGkLjlCJSlwtDCpk29IOUUYSFdq3y2Kwr3hLi/UYfa6TaQ+K2LCCB8sXJYRINJ4GQMS+CicNLRdQPLpDWnCPjfJOVGZPUR9h0+47CY75QOB+tmz0m8OlhqV+bC4qHc6H+dyxeFNECZORDKFx/GiqK0MzKIuS/xyx3M3OlJTGfpT0NSUnm9M4ahf/jXIwQyldg6nZre3uESP+pkCkpxYDoqX5diblQ6P8a5Mlrir5UPwqgbvv7itQHr4Dng0IO4JebSugCUUDA3BpWfhPz1eir1vVD1Goe7FIScWgNNUGX1eQZYiWsmnTmyOCtP3qTzMXPj5JTbHVv6VQjjDvK5rnGekAO7M4JjS+hUIiTcwz9RSjLFw32eYkyJyAVOumlULIXldMnpis11jQujjbTpsMig580uXOJns9/3pOGOzB9gHaSgPskjllADvnXIFdCrTfFhY80pEJDjI0OxT4/yGBQRcqFxBgJLQ3Ae5AI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b4211-0ab6-4f50-52ec-08dcf8ed0a3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:13:34.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTEqucHKG/9Pga3jnsN35XzaOD+AeLWezwOs41R3MrS2Ld9HaPFAu3rcFGYp7kN+oxMN9vgRstuOEV7UFqwLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=850
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300112
X-Proofpoint-GUID: 42_TcAK90VBYO5lO-4daoTGHL2RAMUV4
X-Proofpoint-ORIG-GUID: 42_TcAK90VBYO5lO-4daoTGHL2RAMUV4

On 30/10/2024 14:06, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 11:19:00AM +0000, John Garry wrote:
>> +		granularity = bdev_discard_granularity(bdev) ?:
>> +			bdev_physical_block_size(bdev);
> The discard granularity is always set to at least the physical block
> size, so this can be simplified to:
> 
> 		granularity = bdev_discard_granularity(bdev);

ok, I see that set in blk_validate_limits()

Jens has already queued this and it is now buried beneath other patches, 
so I suppose that this change can be made in the follow on patch.

Cheers


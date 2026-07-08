Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2C38837B
	for <linux-block@vger.kernel.org>; Wed,  8 Jul 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506209; cv=fail; b=iyao3LUOtxNjKl21xVaR3S8TR/cugl3AcO5ktM3qO8T3iTATtCTBALaDdV7u08hZXgz0LMI+i2XeIsXTRIFVFPHFsV+dMp13MEGAhgK3tz2LAc/vMx0JVt5WaBF0lRSpEYNGmXYzO4hHIhJS8rAnkoP4iMgY1sML3uyVcOsPnho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506209; c=relaxed/simple;
	bh=R3V77rPWd7su90D7mMaCBHiGi5WNVQH17QARL2N2BEc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CeM8T4nP3PH0iLPh5QpJhktJCHwZwHeSNjNha98mRFOM2JO4M7+Ul4LbZy5j+lQz/KVfXo2sKr+mQ1OXKT1W3TcXwej82nV+iEfwTlEskSIvqm61uc4a7/aPKBV62XWXFmsI8tmAww0lyu94+ky9nXqR91igx2NUecgUvQJiuYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1i3DAi3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXG+C1DE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1i3DAi3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXG+C1DE"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667NHT161779363;
	Wed, 8 Jul 2026 10:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8eIaDEgbnc+fDIIoArpdMlvsg3OxIHHxyrE09VE1a7g=; b=
	J1i3DAi3gr1dBgyEh6f3Gg4uwMg2iWzUPjrqImcJ8kF+lt0UL+69oH3RNoWjN1Ru
	1bDRDzo2xPKyEGLgif39rG7xuxEQrG0HYlhNLUsYSo97n6xD85WwGmJZbRKfjYbI
	2BpVvCK9Miugy2U8ObCwnTdHA2JpfhDY2vwrAKVlYbCSOFVS8YEwjmKZh+Zl0aM8
	F2taSexPlx6FpcrzOd94cspYNzHGDqnmAqYdvgfa3zRoekabInucUJPUawtYSn3w
	t8nlRiUTBSF9lhWge6doW1HAMh/8FOCuzAoSykBnGUK7wx+sz0jLljrSHQveTU0m
	/6JxBnyOJWU1qQhg2xqrDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6ry4ydxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 10:23:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 668AISpX034804;
	Wed, 8 Jul 2026 10:23:19 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f8yuy14vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 10:23:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV0eoUxUtEJ8eaPIUwc9Auu8spMgujKJhe+oiGpJfYecRgK0UT5aDqDUxAAkq3NbVOl/mVQuh2XcYntM09ARzJIQS1hf5MhiMAiaC/qRIGfKnh30mF6mVSibjHXdVTxrmwDzBjqd0YnXruwszlniTzEUS6RHBdeOWdKqPbVkrOXvZyZi2sUV5Pe5tg6jpH7pNQEyCoD5ycuqt7ytNyEsF5I6AAwk8M8IdHMhVIueKxPZyksIwkc+wqyXmHGtTyNF4X1EB+DioiyLBPVb/osFB0QOxOTIAYxRD5Rc5xb2i+hZ7PDkBp+UzwjVaa53fu5ohbGCjU+OVNkgbXetDLj4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eIaDEgbnc+fDIIoArpdMlvsg3OxIHHxyrE09VE1a7g=;
 b=j7XerfaoGHUc/PNlNdkgSktpW8szIJ3VdTvq8O2PDjo3cuQPvDWZyLWsQLcFgkSKIUcib43rtWP4k791r3UoVJXLFm3w9T7scvKZ+6aaAmhJYsaIivbre+0AjL0mQCW4ngtrEKN9uVP/MygPvn7uXZSg004JxfBxUayZ3a0ujgILZjZi8nxn2Bt8+cFQAkmbsmkz3LBgmH3SHggeNItOUslBfT7vGdmU+PlwLIluQeTsuk4s4LDqPWqIBXpPC6DWBCFxq83xjUIYmCPMAuL9Lv3o/JS1zZ5SPi9V/WIu4HZZSkpGyX81z86gq3ahKRIUi1Dv6Zaca6K2KAB3RSIG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eIaDEgbnc+fDIIoArpdMlvsg3OxIHHxyrE09VE1a7g=;
 b=aXG+C1DEb8K2jHQe8ojRn/0yrtsTs54bKAWUgOc/mopt/ZynygLum2IHEcj0fD719dD7GhUeWGuv3EfNyOw8kA0HmNWj/rekeZtw/azyqrOWGzUPAtPdVunzE8/ahZWSIBo4+soGF+zhlF+6lLqN5RorokOpzgeyQc/diTNnClg=
Received: from PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11)
 by IA1PR10MB6194.namprd10.prod.outlook.com (2603:10b6:208:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 10:23:14 +0000
Received: from PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d]) by PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 10:23:13 +0000
Message-ID: <befb1709-62d1-4a76-b9a1-26b57886a95e@oracle.com>
Date: Wed, 8 Jul 2026 11:23:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/039: drain udev events before passthru
 error injection
From: John Garry <john.g.garry@oracle.com>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260630101936.2371-1-mateusz.nowicki@posteo.net>
 <e3bce895-51e5-424e-8e86-8f5f295a9ae1@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <e3bce895-51e5-424e-8e86-8f5f295a9ae1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6228:EE_|IA1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8eca66-ba8a-4c3a-91c5-08dedcdaea73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z7gUNrRYcptNpxr7DRyCf7XAjO5qSf4K0fCvsDYtVLHzPm0QMTS7ira2qk04RDX3nvlHGqgb76ZlUZI+0G+D2ijqLRLwU369cEf0xiKJMWmLf9HWF47JlWEYAex0+0yJO9oaQpSZWorHgh/PufG1CKaGnqNWSliThW+G7ukTG2WHiv7ikLE+TvPTBLtvC6nLUE1251lUXhr1+utuG3svkVLB++IJx0wmlwvYFA3+fTnJl2aXI9ASgngPyEzMI75VWHWwubfnRNWuPNZEdmqR2wuyfDjpS8YKg0PbPYyPRHrecqEGjpDVp8pT1DgkA1BhXtyBIPCby5KTP1C923eHqtEdJO4osFVhOake3PShlk6+2M58vKiz1g41gkKEaMtXCMF0NzpVYkzLElIUOuNSVHKvnYSxTtO0cUqbhpp3mqjdYcQxh1Y67qHuqnWtV3GuIiLo8k4Ph5Vf9rY4pjOIDf1uw8+9WGJtd2f/ipNhohrbNpbbU3u5U5KxxjYmDLno4SVA/lI/yAVCNB1Y8yw2y8icry5PMHinY1LJUXpVd+le//MpDw0/vofIfUrUprnXZ4FZu6x5VfkELN8tCzG1reHTqVf8ior2sOL8NCda1p+bwp8aW+QhgWVVpc/zQU8K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ZBMXk4Qm9IZjFsV0dURzJ1WDc1MkNYcmpwckxzU1FkMGZ3cVI0S05CT08x?=
 =?utf-8?B?eUZsazFEaFZTZ1lHZFRQL3VYYzFRQ1ZZaWxVWUFkYkc3TGlsWEZoeCtseHM0?=
 =?utf-8?B?WVpzZFIrdmtWa0IzUW05STBCU0oraFlVeFJMZWU2Z1NYSUtSOFJ6elMwRkJL?=
 =?utf-8?B?NVRMdFkwYUJBSVpjdGgrQWE4NzFVNmJDcFdHY0JudkZlcFhqeWlJOG1sT0pW?=
 =?utf-8?B?M0RNakVWMGwvM0lkZ1JwRSsveldVVTM2RW5IU2grUHNpRnh1aTk3U3J3WDdu?=
 =?utf-8?B?N0NwNk43NHNsTXlvUXJ4c09jdzFrdjNXN3RKVjdCekNNKzdjL0g4TTlVRmc4?=
 =?utf-8?B?OC8zWWo5RmNYM21DNW0rRGxQNmxKdTFITmdSNEpGQkxmSWhVY2hqRHpJNTJs?=
 =?utf-8?B?cmt4TmZDQitSYk9wM0VibnFnbzhjRTVnNnNGcjJ0S0FTMU15RnJXUnRWalhL?=
 =?utf-8?B?d3dDeHZnUXU0UnZaWGVMWUlaZTlNZ2ovK2ZNS0k1bUxuS1JVTmFmTGFJczZF?=
 =?utf-8?B?MWIrYnZ5dndmUjB5K0JzMlJBekh2Z2RkY0lRN3U0ZmdnK2ZJUVFyb3ByZlBK?=
 =?utf-8?B?RDVEaWlIaGhOUFE5VmFNbjB0WTNnMmR6d25DOEMrN1FlQmR4ekVUNEpTUTBp?=
 =?utf-8?B?ekZsaUdsL09ZWHNvbkxzM05kalBYbGFOZzZ5S3BXRzJqVm5BK3NEQWFieHF5?=
 =?utf-8?B?S21EaWxONVM5Vitsc1VvNVBob0VmQ3h1V2x2WUJpVnQ5MSszelZDYUJnR1dQ?=
 =?utf-8?B?RlBoTkQ2Nlcrbjc2c09YaDNBdmxNU2JmK2tJM2hyRmszeC9BeVpoUGM3dktq?=
 =?utf-8?B?WFZtdE1wc2M4NmZyUHV5VWlnelcrd1dVbWJEY0VwSFpEaFh1ZXZsTXZUeUE4?=
 =?utf-8?B?Q0RPK3BJb2t2allBQUtBZ0ZIQk8valI5Y2dZRC9ucFA5YnZzZUp2bUo3b0xt?=
 =?utf-8?B?TGJGRXJONmZTRkZ6ZzE0YTMwTkc1YWpVL1VyR3FveGNWcE5YVW9XczJvWGgx?=
 =?utf-8?B?RVJReDhvUHpRZUxjbkVyWUdmam9DTU0zbW9pajF0WXFkdm1VdkM4UEZucTdm?=
 =?utf-8?B?emZ0WEk2M2xIZldicHVqVUhNVFM1bCtQbDNsSDVYTUFtNEs0NXFlNW9pNzBD?=
 =?utf-8?B?eUdaaWtpS3pRTVd2MWJhRXREMXdkQ3pMaE1jQlhMaHVUeG5ncFh2UjUwbGhM?=
 =?utf-8?B?QU9jclhKVVJjTi9hN1g4dVN6SnB2OTBWN3RMenFoYkU4eUE4RDc5QjF5ZGRL?=
 =?utf-8?B?YnpKYUNkL2JKOXFzK0hvQTNSckR3QXNJd2dVcUYxdnZENFZPV2pRTkVQQzlx?=
 =?utf-8?B?SnJTdEdBTjNJSHJSazV4Rk9wNGpTRXZsM1FQTGN6dzhPNjVVNHlYZHRwODVl?=
 =?utf-8?B?cGVxQ05HdlQvVHBHRXB0QlMrNk9MT0V6Y2xpNTk1VG4vNUNBdDhucjR6bFkr?=
 =?utf-8?B?b1prVm5qakVlS1d2V0VXYi94aE9kMjJVRUhCZ1pKSUZDLzErdHMzTDAxbzZl?=
 =?utf-8?B?dU5RdUVzTXFBSjM4bjBVQVFnZDc0Rk4xc2Znb1lSM0lOK3E5NjRuR2pERVVX?=
 =?utf-8?B?MzRMRVpnWFZHMmxjREw2UTRubnBjNnNzanJteWliM1k2MVZ0RnFORW5oYXc4?=
 =?utf-8?B?ZkJoR0Vqa1llNjBrUFNCTFBzejBzQlY0R1JtT1N5ZldXak5lbDNjVUJTTzVV?=
 =?utf-8?B?cXZtMG5mZDlPcmVKZW9ENTgvM1BEL0JScFZlTFZmUjQ4eXZBWHdsZ3lic0Qx?=
 =?utf-8?B?aTV3U1lsVFlTeWtrTXkzMDMybTdYVyt2S3UvaHVya1Z3MXpOQ3FoeHpWaktq?=
 =?utf-8?B?bnY3TER4MTMwRFBteGcwVm9tZ2NVbmhPd0FvV1NjelFFQmhLK29HN2w2aE95?=
 =?utf-8?B?YU5zSjRwMHBMV2R2RXJDTjFQdHZpS1BCSnB1aHRaTHhwZHZMWmlXc2gyRXhZ?=
 =?utf-8?B?T1RJd1J6MmUrUzljci9tYXB3NElSUlJwMjR3VmlpK3c1OVpLRy9RMVQ1VlN1?=
 =?utf-8?B?VmZBcjBKTW0rYTNISVQ4dkx0VzByNmVlTjllTWdJamszNGJSTnJra0ttM1V1?=
 =?utf-8?B?ZFJDb21VQmhMQndKeDAxSFJqRFJTR0g0LzEwZmFRdGRQSXdWS3hTZVJZTWVS?=
 =?utf-8?B?WldMK0dOMDVWTmJVb1AzV2N6ajhNNTlVRG9mTlE0S216dHo2emRkUGs1VUd5?=
 =?utf-8?B?SnJ2TFlUcGZVcFVlY0NlVG1wMFpYbTJzSFk0UlY1MUh3OXdPNnBSK2JTZlVK?=
 =?utf-8?B?TTR3cjJWQmp5NVJZbXBOQzQ3UHZHK0RUbzJRSThQbmVYNFlONk0vaGRYT3Ba?=
 =?utf-8?B?SVI2VkhYWThiRGpNVFB5MXVnbUdES3dld082MGV3Yy9QcHNDdWdOQT09?=
X-Exchange-RoutingPolicyChecked:
	mwEwCwPm9h+QPu67dRM79jFjuXaQF0/D3y7zcH36R4ZocLGHoJq+5L2Ac6kxPRzVJmc7nXpWl7wigqKvBKiO0fdqR6WoIBwJZIlm0sX3fGwp6Tq0SxjZzAWYNA6fxyJXWnp8SZ7LuSNI965wXlS7ly8NCDw8XTd5sapT6dt4C96KfndBtbtEvjJrf2uaNhWYQWsUvUY3OsKRVZ43Bb7ffzbPCrAx1OtYAuzGZcEBy5DPjE8zEn7BJbOdtt9ZSEv/ADXshDV0k9ONDeeEgEdVNidQFVXIX+cA6kVdBnp4Gaef7Pwith/FUxBGhr1/N4Yzx3wmA6mklmMkIibCJho2xA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iyt3x0pg/EqDAkdL7rJrlfgKLJY4VOMQ1za/dEJoLsu/dFtNoJ+CHztsxDxzXu0H6QEFeNMJqiYkPxdNydBiW2vJueeqhSIh0go5l2TXmjPjvpk5VuEPDa6YTjvYg1x83V1HGk/gxKPIrc0sg88IXj5q3sQDyOS6uVIa3slmeL/NB3E5fhZQghN5doD3FoURyq7d4jkScpKDHVoAvMGARz2O4H0A0un2wvJtfuWK3uh4TAZi7tprE/p1S17NEs/hBgf/uQVeQ8e7fqF1lpoEOlIPM0UCcXzS/yjbH5p5GalheTnEj7NVaSrRKR3l3Hjrh9rfMMjJ9UjIMcJ0kBKVyetOGslNrGvwN+wu0yFnXyC+Q7lIslNkd5jBRHv3cgpRN4+/8VRwnsDB2QfgcWwmvIVngyIAGUkgPVt9BgLK1eyrOodm436qR7PbsIxmRM128QHFq8WTNrGHQIHAPMP5iCWJwqeVrCYVwyXca/l5Ns8qmg9qpEVeyTlS/vBYUYjZ0PnNrE0HU4z7vP+eX7lSkTuoZflymHw0sn6sbhyBoX4Z4p15SwGPB8I85uSIXTOn7wrp516IbmcOimHBd2TUL7ORd/joTsdKGRveDrjUVx0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8eca66-ba8a-4c3a-91c5-08dedcdaea73
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:23:13.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw3OEqgs4ym92UFiEB+8Ixk9JRxvcNO+HOFjV/OJZhWTh7GM9CTsgeltnEU/P8bY59JqB3ZW7VFigpBDWk6uDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607080100
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=6a4e2517 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=uChsZFC9AAAA:8 a=yPCof4ZbAAAA:8 a=uDNV2h8FEw-6PBOO8NkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ULtXvzFHYWHLyBAuiDia:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221
X-Proofpoint-ORIG-GUID: RYdgJGPMbACctOLfnQdytld0BzAe2ZaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwMCBTYWx0ZWRfX07NDQrSl4/Ji
 ToOI1S5jhjRKHi65V7dYVrftIyPvTMxzxV5kyDmZJF2VP3s4DArRDj5Zeau35McNQFAuVhGTjY0
 s23r+qaH/2H9Jf0MpsSDHCmP/CpbLwC7Yzg/+CZqU/1K3A/QlHJtvGti2S2PZe2acWdzs3madms
 mX913mbtQysWEDsbOtwW9zYCvIYBOLm1ndxA0ZglKifMKviLKzK5Equ73V6SA79OszF0Z5RCCxF
 ZPcPigB5aE91gHqztca0CuCw1BUIp2ZUvicANaQFP6dW7cd8ppIyclUYGKH3XBVriB+ZidDmcj9
 MMsLOVNE2Y5yYzt1u+oxAjS4ufvIjgfSDgff12eQZgat+qQTHwRIhmbw38LVPsyYxzumVcYfUiv
 yzZTknTG12gdtWIlDqNu/zoQxGVfkJIqFKnITqKpqknbXavmurZQ544+UkYOdedx5cQlAsxgGEg
 XGTjQOTqM3OMpZEXL2KZ4WJKXw6nWHbueEvCi4Tw=
X-Proofpoint-GUID: RYdgJGPMbACctOLfnQdytld0BzAe2ZaK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwMCBTYWx0ZWRfX4O838n7eED8e
 KUMrYqLVX2VL+ZkMdy+vlVMjwUoPAcAj0PlTcw5ZGIMRo0keYUZK2g1PIgvWAwUNw6jEIoLVoNo
 h64g2O3xqJ9rtQ/jdQOwtrsHCSrw6BGKvpmIGjYKzy/xNiPsM9Z2

On 30/06/2026 12:29, John Garry wrote:
> + linux-nvme

Hi Shin'ichiro,

Can you kindly picking up this change, below?

Thanks!

> 
> On 30/06/2026 11:19, Mateusz Nowicki wrote:
>> From: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
>>
>> When run repeatedly, nvme/039 fails intermittently with a regular block
>> read error instead of the expected passthru line, e.g.:
>>
>>    nvme0n1: Read(0x2) @ LBA 0, 8 blocks, Invalid Command Opcode (sct 
>> 0x0 / sc 0x1) DNR
> 
> This is not the error which I was seeing, however this change seems to 
> make the test pass reliably for the me. I have not debugged why the test 
> was intermittently failing for me.
> 
> Please also note that I did trigger a kernel warn previously for this 
> test and I posted a proposed fix in:
> 
> https://lore.kernel.org/linux-nvme/20260630102717.2671475-1- 
> john.g.garry@oracle.com/T/#u
> 
> thanks
> 
>>
>> inject_write_fault_on_write() writes LBA 0 of the whole-disk device,
>> whose release emits a change uevent that makes udev run blkid, reading
>> LBA 0 asynchronously. The following passthru injection arms a one-shot
>> fault (times=1); if the stray blkid read races in first it consumes the
>> fault and is logged via nvme_log_error() (no cdw fields), so the expected
>> passthru line is never emitted and the test fails.
>>
>> Drain the pending uevent with udevadm settle before the passthru section.
>>
>> Signed-off-by: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
>> ---
>>   tests/nvme/039 | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/nvme/039 b/tests/nvme/039
>> index 7ca48ec..8c70c5c 100755
>> --- a/tests/nvme/039
>> +++ b/tests/nvme/039
>> @@ -206,6 +206,8 @@ test_device() {
>>       inject_invalid_status_on_read "${ns_dev}"
>>       inject_write_fault_on_write "${ns_dev}"
>> +    udevadm settle
>> +
>>       if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then
>>           _nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
> 


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06814659A
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890336; cv=fail; b=M38f4eC2Kvn7j6kfAa3L49KkCejOb4qN1GC+9Sqmx/eph0BZJaHTF+MO5h4IJISuOhGTtqjy1F0uqWjVxV8uMul5tOTt3KmGZAMuoA8x/s9npciAdLarU3tDtwQFg20sslP+Me4A3Fgkp7176P9xyleiee3FTTmZ5P2W+CVN/1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890336; c=relaxed/simple;
	bh=dZJLZB6WhjSVZZucUS/gCwt43c/K0Qi+cvD3iXeGcZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nx7uzygIbV1q3qnfSZ373ZwhPx7VG5P2D6S9UTCirhZ9vIwxxoh8O06FnGX7d5Jr2ONzyljWyOKVli+iKZJpb10QkAmlUNaSJa9fyJycYtJH2C7IBqJKw6bX4NX1oKttJXk8TdpRMEaCTA5u/V54pBMUgvtsdswqDP6mmpCBd1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QqOGg88W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ib8Wh2c/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqOGg88W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ib8Wh2c/"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DNZ2Qe022604;
	Mon, 14 Oct 2024 07:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OS+STXIP+WT+kvfr4hFUPWUIJGljMO+D6ATjpvHWVZk=; b=
	QqOGg88WKz19ZOCf0K7gvP8N4E0AXODq9P39p57iJ4qU5e8MiyOK/GyvFZzca68o
	4g2vODrFietGEzddXri9ldmz0iWINOoi25kQV4rWHHWcq4Fd9Ei383qzkJU+2d4l
	iDsCDgWtVoHccCNy0UX+8Fwmb86qsBbhH6VuH4JJJLPIOeGR80IckpTkhlE6tjwW
	71f9AO0aQSdEKAQWdPK/HzFDfu5qNex7zquWUXKqX7GE1z4N5PDNNNQU7FdT0UpA
	4W4wM1/voz8Zbo0QJwqowoHWCq+xCeAD/VBkAzw12ASaqZxSngPZ6a+REJjqE05e
	dXTnuLXBLbJdH5zlB/V99Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1adk3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 07:18:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E619PV027308;
	Mon, 14 Oct 2024 07:18:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc8523-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 07:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJGYnDwyuj14dbi6wBpO48C4X6ETndlIdzvpXODtWHQaypSUTK/X42L/yC1q+0hdDWNFwYxjjE8VsMf3dM050940rMXiYe12sEE9iPSUcJPaFYTy/QS2Ykh5G792mITLUGvMiQNW2zjsX4UuP/S3dt7QTidfbZvqRD3O2+y5UnS+nt2Mk1EzMseGgUbjb9gxWypajic1LqrpHGMhepDiBU+Cv32P4yNk4ePeMBrISd8SsGf/eGYgquP2Um9gOCwjqOHz6fbXpGljYVCmKdNTEWRS1H+Fo4Eu9+G5r6cdD0szcOYcNGakBdXDM9nS9zRIDpZ8HpDWWc6AMIwUdNVIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS+STXIP+WT+kvfr4hFUPWUIJGljMO+D6ATjpvHWVZk=;
 b=fkMDttUVi1Do/NI5lSdNYfQ+IotQoFep6ZtH62k8lohnQyPAKhHbi2LxO3v42IuLwULBfHQKbHkECz2dMDk+pvqfNtNR8jLibObg7kkjkBpX90eBzFooz16wJSSCCRtDBy5vZCv5ob9YSyu1UA0ZVu6Q/z1LR2sUHTVEs4Jq35j3eta6f5xr2XFNsMV7C192VgMS7AnR3uh6sA71sz5gtzlsi0VqF3FjCCDdzFjG0/DeXXg+32+B4UyfvHEuEh/z+T1+7g08cPSRkWZZbR4wdtLTuMuYNWMuUo/myfF4fgek4DqeKMRMyuznFdFxNmrAi2HgFYjqwkNcIO9q2Q56Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS+STXIP+WT+kvfr4hFUPWUIJGljMO+D6ATjpvHWVZk=;
 b=ib8Wh2c/pQLpQQLk6aVneUBt0RQ7UQD8wmmfm4UPCP//1830TJwBDZCQmRHj2QQZXHIedOgWfod/XaYAHFmjVEk630mPAqest9NSDVWezeaC+VtOtpB0Btxm1w6QdK3cv5YDxNb+ebHCuLrXLBbpGSC1S8Vlz/rjB6e+ndi8Pnw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7055.namprd10.prod.outlook.com (2603:10b6:510:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 07:18:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:18:39 +0000
Message-ID: <e3aad91e-1265-4335-94a3-4fceb1605fa6@oracle.com>
Date: Mon, 14 Oct 2024 08:18:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: setup queue ->tag_set before initializing hctx
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Rick Koch <mr.rickkoch@gmail.com>
References: <20241014005115.2699642-1-ming.lei@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241014005115.2699642-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cc9336-e1e4-4f80-e9ed-08dcec206cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3VDVlpCbDU3Z0xWN3pxZVNRdzFhUGpHRFNGVHoyaFlZUngzcGhMdWk1V01H?=
 =?utf-8?B?S3pPZXpmTHRUTU5vZzFOaHc4YU9OejVUbkRhVXFUUU0wWVdGS1NtTXhDelpk?=
 =?utf-8?B?c3pOaU5JM0hpSjR0N3ZaMzZHejNpSTBHT1M5azk4eEtrMU1YK0FiS2I1RklL?=
 =?utf-8?B?UkpJd0ZraDlNR2wxTjF2dzlmU0phbUhlU1VhOVpBU1MwVkZqeDZ1RGM1REdh?=
 =?utf-8?B?OFdhUFJyN1puSGFWd05kMHN2eDN5eXRIYWhiU2JhV0lZYk9RK1VOTDZqTzhp?=
 =?utf-8?B?a3k3ckhKOTV4b1UyR3ZIVFo2UUhQTVdGQ200WG0yaGxkMGMrdVRkVzkwL3Zw?=
 =?utf-8?B?dEFaUGIzOWZoODdHSzkvL0ludmJnNWFwSUlveHVoWHZjdXF0WUw5cTZ6bVNu?=
 =?utf-8?B?SHZJZzR1a01Xd0x2MENhUWZaRjNydDhadktuMmRYWllSRTRkK2lBRlA4NjVi?=
 =?utf-8?B?NzI0YmdVYlZobHFXS3ZhQXdmb0w0b1F3YU5lWVl1d0xFcVF6VjJTU1A5a3Nq?=
 =?utf-8?B?SVFpTzZTcHJ1QUlORTQxY0R2NjltV3RDdEZyQ2dUUmNmNUIrRDFHV3NUcHV5?=
 =?utf-8?B?bmdmUFhCMldwaW10UFQwRzRuU01ERmVOYUQ3REF2L253d25FaHM4NDA2RzVM?=
 =?utf-8?B?T0x6dXFSMXNVWDNsZ1NOSHp2K2N1ZnVxSUVDdlN0Ykl4Mis3ZVNxRkFMdGRE?=
 =?utf-8?B?WnUyMVlKNWtSRGR0TjA1d2VUSDJBQWhwQWluejQwNDNBOXNkUlcwOTBGMCth?=
 =?utf-8?B?ZjJEV2FHSE1xU2wxQUNHYnduNnhHNVVDbEphVzN1dzh2TUxuT3czbGk5MURx?=
 =?utf-8?B?bU9zZCtVRlk2ZXhqa0JRdUxaaituTGVVRFZYT0JWczNDdG5ZVG50RGlPWDNq?=
 =?utf-8?B?cmdHS1p5MjVtUzFpcEFjWHZKaFhmUXhTT2tZclAvMjFZWTAzSE5sVkNiWEZt?=
 =?utf-8?B?UVE1ck5YeHozN2ZpeFFtekpRY2R0UE1kMUZtRFMyeWlOTnFOb1BNM2FWamhu?=
 =?utf-8?B?ek5hSzVuZmRzbXpXd2QvanNhSVZxQ2M5bmMvWDg3ZmJCK0wwQmtRUjdLcURS?=
 =?utf-8?B?U0dYajVZYjUwS21mdjZaWDk1Z0oyM0hselozY3RIWjFiKzNjb2o1YVozWVhw?=
 =?utf-8?B?LzFwemZxaG5EbzZyNE1iNkFiYWJxZXJ1OXBMU1lNVXZZbkxKWnRUU1p2V0lS?=
 =?utf-8?B?MnRsTU5RUXU0bklhaU9pdDJRanBPZ09mL00wZUk3UmlLWlpHT0VwcDN6dUhJ?=
 =?utf-8?B?dk5kQ1ZlMVkzU3Qybmw0UUlnVEFkbjhVT054MHFIV2FhUmxrOUdlTUZJRUdi?=
 =?utf-8?B?cGVVeTBySjkwaWlxUmlwdnc1ZVBUbzJOdEd4dEZFSk56WFBkd21TelliNks2?=
 =?utf-8?B?VmxQNWdYbVpmb0tRellMbmI4T2ZDZEw5MFlFUzd1dkxaNERiK3J3dkdzYlRI?=
 =?utf-8?B?QWh6VDZlR1FPNnZZSzNRS0FlMHBCT0xhNjdHSzV1aDQvTnZIck9raWlEemNn?=
 =?utf-8?B?aW55RUg4Sys4VGhoSStkOENXU05vWitoa2FYTjh0MVkrVUJJeS9FZVJjMWkz?=
 =?utf-8?B?VDl4TjZBbGZMSTdHd3R6eWtON1I3VFllZXQxcmpCeEs1OXJKRURlb2cwNy9p?=
 =?utf-8?Q?SYakKoGWLcCkQT+S+Ib9jRXwkHNWu5dPh9R2/NFy092o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDdyaGtFVWU0dnZjN2FDOEMxclNHZ2lMTDV0QmRZV3FGTzlrMGVzSnJYUXp4?=
 =?utf-8?B?UTFDZTBDTzl4STVBRWVZZFJFejd2U3NtNWJkWDhVYUMxaXhLdlE3VDFHMmpw?=
 =?utf-8?B?MHRsZlN5dzMrZkxIQllNT1JCczlsY0ZyeUpMSGpjaFBoU1UrZGl3dENCTmk5?=
 =?utf-8?B?bWNha3d6WEZUZ1hFcVYwSlhEa3BrS0ZNL1RzcUwybWNKRTk0WmVhRG1mTW1i?=
 =?utf-8?B?bC9xSDBNTWxHOFpJV05jdzVhenpoLzhyaFNLVHBuS04zeWgyMVlNQ2VQVktD?=
 =?utf-8?B?eVNmbWwrYk9aVkw2ZTZBQlN1a0VhNEhYRGYwUEhaWUtJbk5NSzYzbG1kWHJi?=
 =?utf-8?B?Q1g3OHUreEZ1bUFMd2pIcHgyVlFNaDkyb2VhRGhhNXBwejdDTHhOa1hXN0lF?=
 =?utf-8?B?SEswZ0ZMNVFYdzhLWUpKZXlPYnJCREtRcndzenV6VEtmbktvWXNGdXZUU25o?=
 =?utf-8?B?clVBZFNSKzlHUDdFbUJkVjVuVnh3b0JiT1dWMThrOFloSnZnNE5GTGxJSHVC?=
 =?utf-8?B?TkZuamZKSU1VYTJqZFJOOU5JZUtKM2ZhYXV2K1FuTlBsRTNzN2xDUEJmWitQ?=
 =?utf-8?B?MG5wTUR3SEN0SG9JVThydWtUWnpBY2NPUkxtSExHSFAxZmFkS3dlNjdDRGlK?=
 =?utf-8?B?bjBMMmU1QnRENGxiOTJxM0RaNUlwRXgvSkdEV2RuOE9vUWthcU1BTUVMN2Z0?=
 =?utf-8?B?NHFwaFcxSTlCWUdNYU82b0NBUGV6cWdvKzd4cWRJNEVURXk3NFYvUTU5d3Rn?=
 =?utf-8?B?SDI4RSsyVENuU0lNTGs3T21WdmZjRTlkaWVjc2R2bVp2VGxIVlJEeWVFUUZV?=
 =?utf-8?B?WTNTS0oybTYreGUyUVlNY0ljRzZYTWJZVnNkMHFBdkhodVArM2c2ZmZJZkto?=
 =?utf-8?B?b1VTRi80SzFsKzhYOTRBSmZ4aW9Bck5rb1dlZkU0ZnVWMXIxczJEV2Z6SW1q?=
 =?utf-8?B?YTlCVmhrMkUxWFo3Q3UzQzFRTFppYS94cDUwYUlXME90SEhCNnJtY0xySVMw?=
 =?utf-8?B?Qm80ZXNaTlZyM2ZScnY1ZzdlUVNTVjJQSXZtQ1ZyZkliVlRxanZkc1MxNTVp?=
 =?utf-8?B?eDV3QlQ5QzJ4RVBEU3pLaUJJSUEyWWw1OS9aMnZVTWpnWGsvVnhTSngxNml6?=
 =?utf-8?B?c2NvdGYwNHFHY1psYzQwK2Z3TlJ6ZXFCVE93dGZRbnZ0N0JDOGlXbUVzRHp2?=
 =?utf-8?B?dGpuTzdoc0hVVHlsTU5zZ2Zmc1RVMVg3bStvdVpoMmhUZFFOcmZMOHIxV1No?=
 =?utf-8?B?Z0grdnpFbmJxWUFIaVVTZlQvWXVuU0Zhb0cyRUFxcTFkbVB6WTAxNWpKOXVY?=
 =?utf-8?B?SDZibkUzVUJNN2kvcHpxWE5kMlViTUJQTCtjalpZQVE3Nzk3TVZrR1hVSVNu?=
 =?utf-8?B?OFF3SVU4S2RncnZGTy9sMm92dlhYTm1mS2FqTG5mbS9mcHh4dkJUbXFNUkoy?=
 =?utf-8?B?MHNqcE9RTUh6N21SZUVMdGpzRUZsUEpHMlJzbUFCaHh3dGhmbmR6RndLOVBD?=
 =?utf-8?B?clgyZU53QXJZclB6UTZRczFNaFRFUm9SeHpoaURhVlVlQ2NybnlaZWJ3MlJY?=
 =?utf-8?B?NlVWcmNtV1lkSm9OcnFJV0NrTUhUbng5L20zTkRYTUNvS1czeDJOTFBFUzBT?=
 =?utf-8?B?RTU5Q21tRTFldlBEcVZ4OWI2aWpSNnU0MlhFUFYwVndaeU5rRHJLTHBVYmFO?=
 =?utf-8?B?QW9NWDlBMkIyaWM4dEFlcVd4MFYrVm80bm1JNnZUVzZTSWFsVkEzWXk4UUUv?=
 =?utf-8?B?R2h4N2dwME1WSFlhd2lJZXdQUlVhQ0NrWk1XQ2hTSkl4N282L2dTMnRSU1Z3?=
 =?utf-8?B?MkxpRzc1b3ZEMUk5NzZJNndUN2ZSenI4eXgreVlCZUxjVWFLbFR6d1RPWnNh?=
 =?utf-8?B?bFd1T2dBKy9MOFFWS3ZRRjFqWFo0OU9pUDllRjcvU2tLek5hdFpGMG5XSjRx?=
 =?utf-8?B?SGk4ZmF1aGlDTTczd2U3cnNhVGo4QzBuWHZUMXRqZ2ZBUit5SGF3TDlqbXBz?=
 =?utf-8?B?RXJMZ1ZsNWlIMjJVY3V1d1ROcHg4TWR5K2FLRXpXUTlkZUhPeUJDQ0t6TDBv?=
 =?utf-8?B?ZW9VQkdBVkYyeE9lMllISkg3UGI2U2FNN1M1Z2FFZTdFeU5rZmV0cStsL2J2?=
 =?utf-8?Q?dNdAKM3Uil8YrQa8BIzKYyVik?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oHZq4vuPBjhOvJwxNIqPdeMd/TYvKbVypaFTJYaSd6UVZuVejP1ahS+3qnF0MJz85BiYfgdt/ipCA5kdxxD5pjPbSoCiEIPPPrJZbocMvgEF/kzBdjqg4h1Ej739rA4U2cAuzdYc5/3W8CcKHl5qBodDgrxCygXnj5Sp0EK05YuEsOfCCb0dnwYJHbb6kGQxKPLnpw20yUP/EOvsVoSm8vbOtwgrtGtnO91HCYS7XFCBHMrO5lzEgS2RtKM/CM9H0fpuUQOXvP0n3DL7ty694ibqEfPN4sL3Z9rhtR4sQVaxAaNdXyei5tVBpX81nyaaW/RDCZqkbZRDvBCbnrRVYL2BINg8yqHuLJHMJcO+bPz39+gA2DR6rQneB28f9uzNN4Jz1AWw3IpLPoSPF2d+YqmXjSxEFeRgyPvxvbl6WpN+C8ksL8bzILg5w5Xi4w7q67ZQjF/F1OowI6hwcPz/UTDYgYjENe3DeNSe/N5rPSrbzhdrTnyerXGaqYtEiur6QHjtQkTpiOy/CWS8637p7QE5nOBmURDiJS5FHRSfIn1MM0J/0Ub9MOSlhl0BRRiAwW9saIAHsdUsi3gnhiqlC838j+SD2Px/krHOAhb6K4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cc9336-e1e4-4f80-e9ed-08dcec206cd4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:18:39.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2bolvTWi58lOcuc/BXkLF2r1JVDgj6xXk56dwk5IWOfG2J1QyPBW/ggue/yLcVEokkHbpA+gq6+It4ufr81CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_06,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140052
X-Proofpoint-GUID: lY7PjqRO-HpBv0tLU7Xk-Hgwsg4IJZGg
X-Proofpoint-ORIG-GUID: lY7PjqRO-HpBv0tLU7Xk-Hgwsg4IJZGg

On 14/10/2024 01:51, Ming Lei wrote:
> Commit 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")
> needs to check queue mapping via tag set in hctx's cpuhp handler.
> 
> However, q->tag_set may not be setup yet when the cpuhp handler is
> enabled, then kernel oops is triggered.
> 
> Fix the issue by setup queue tag_set before initializing hctx.
> 
> Reported-and-tested-by: Rick Koch<mr.rickkoch@gmail.com>
> Closes:https://urldefense.com/v3/__https://lore.kernel.org/linux-block/ 
> CANa58eeNDozLaBHKPLxSAhEy__FPfJT_F71W=sEQw49UCrC9PQ@mail.gmail.com__;!! 
> ACWV5N9M2RV99hQ! 
> I8rs4BE3PAgb5C75MUXZygt6Rmrgq1Nf9gHkileqLC5dagKa9zQ7aaFcJDNZkQwwCAKyu0RXanbmTtnTcwOR$ 
> Fixes: 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>

Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27B14658F
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959358; cv=fail; b=uJ6aWlG9SWgLmQmd31PErCl5ysP5/xyoczvKOMmNqE92eH89r0Zs14NISNL5sz8YuC+8GuDIjoXC1ibVwXHHpeDS+zlbgprKrZrhDtRWrJmpHZulZtTc3hxWwWGPQvspVuWMel5X2LEpu6xNhB4MujVNRt2Ywp9yFy+eh6FoAiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959358; c=relaxed/simple;
	bh=I+S5WugD0jBME5h06TXy87xPMAo1jIvKLDfKAbAa2xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rgH6ElcTzpFtq2eY3JCo7wlIVmcg8tyIe6OYFAtjig6VPvo9kPBPcmPNlaZhEDo8J/fNotqFGizv5xxwppOJL77vtgd5KCJF4otCDikQlglg2sZcG9OLg2en4rBZIReLQw7xDGkDUcXqFxm+it2VNCTPpXwSJJl+OhRe6a1vgHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bcAY5XhA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jhT1oULy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bcAY5XhA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jhT1oULy"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCj9Vh018682;
	Wed, 15 Jan 2025 16:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ng7OrCeNMYzcXJMJkDld8KqNXahwEkfuon4WIMmwh4c=; b=
	bcAY5XhA2WwR+Ql2wfMH/aU81GQ7vHBp+B9K0xGhoYkynKuHc+gtzYnMML2LP3FT
	VA/ckTZo/xLLVSsDXDzdJH+bJfnrN7GQbUIxZfElUZiXWWMlxNKUjwIVOlSAf037
	j6pCiO281IMJ6N4xkWa3cqgcD2oDb8/LF/oq9OTU55UEeXJgdvdX59OEIT1J9T1S
	UTWdC9xmKbZL/Wy7qmIkWMf9ErlzuQgZuJBlsQ7zKgUFE5ZcI2DhQ20FW7SjrUh8
	kcnH/1KvPOvtYXUmjvllohalxosAv1wK8pS9dHS3uPsF3E0HUtxPGHKIeO3fEhNQ
	Ujl7MAOifTWTAJKHSXgzOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sgfsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 16:42:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGg9t7037173;
	Wed, 15 Jan 2025 16:42:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3a7uy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 16:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og90JZTSBgzx31O9LVN4ksdtM2QqJh7OAMR7ir92xI/DsJSqRrlVp8vlOpuDtBAEH93c66t2mt8UEkB1Re+AzNGYhnz129vT0mRDWJ7PqyELYRl9PK9epVnaiAh/Xy7+L+3baCKH/Y7ZylkDXL2MarrevndodSnfIRYhhwsegHjUcaohMYpZwhfdC5wm+RNyhjXAdAKIKt0NzJbjkAbZcmkHkHlBCpv/3/VqPGy6gbM8niMW6Hea1/Fq0OXTxCqfzcIP+pcL9e21gbA7xIOP94H8dTGhWLTc7fk16Rwl2Z3ksnmPqbU/jklHwix/eufXh9FCUf48oAEuUVOWxR2F1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng7OrCeNMYzcXJMJkDld8KqNXahwEkfuon4WIMmwh4c=;
 b=Mr1RLa5dVYVmj8J3yALnRy0+2VnnzbUGSpsuz1PcFEqmDM0viMYdLQWzZmV9kQR5JPLi7imHGE7VMx8Mxqtv9cutiiZUnq2KPEtkNvnhnpo94V9zzEkf2BTrWi3ZU8xs6dgy6y0voJMfQJ/htQQ2MkghQY9wurwsgAig5M82ZYOR3YUPu/B7FtZOE4Rcv//hVUSQa/T6aqurh0girnHNvp8au4IZ4QWGnfNMxzUOVa2Yio5bO3wep5ny2zk4f6cup8PjgWTEyBNj/FZyEpubfWykCdHqK3Q+k9B+zk3SN/jNXnN0ECQoxbZLhnVwj5TZ5Ko9W+GrqV5EeLTvHfsy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng7OrCeNMYzcXJMJkDld8KqNXahwEkfuon4WIMmwh4c=;
 b=jhT1oULydUmEaeaO0PFlGzA92Xi0yoWFj8hiVYMIURX88BkbG2m8jpsZq2g9o1Cp30v7+/y+CfrDRI2KF0s3Jm/7wo6n9UB/QqDboDiGpoWpQGBhJmQ6cTMZEG/b2D+4EUkzLOgIQKhxiG45iv0cpMIxZ+DugN2Pm/K8x6Cfgwo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:42:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:42:28 +0000
Message-ID: <94cd0246-d100-45e3-873e-52de03dfbee9@oracle.com>
Date: Wed, 15 Jan 2025 16:42:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Stacked device atomic writes fixes
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com
References: <20250109114000.2299896-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250109114000.2299896-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8b2834-56b7-4b96-1f65-08dd3583992d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1FTFJBQXg1dVRSTkpPdEhybTgwcU5VbElDZ0drZTZSQ2R1K2ljckN0MFQw?=
 =?utf-8?B?WmQweFVBUFFOS1U4cjhhNFlBV0tTZFRvZHBLUEZRR3M2aGRWcms0OURXSjFp?=
 =?utf-8?B?OStsRGpWMGRNSmlFZmJhZ2JOSFJmME45bGxqVEJuMDV4S3FiNk1xL3hKcVFv?=
 =?utf-8?B?Q0dyUUp3R0NERzQ1UDNtZDFpazB2L0pBWTNnWVJ3K2x3ZmE5NSsyY2pobjJo?=
 =?utf-8?B?Q216T1NvZFNmbHBBZndIazZIYTdEMDlnQ1QvTlNBZFRQbG0yU0lzUWhRbnEx?=
 =?utf-8?B?NitiNWtodW1rb2dBb0lWajlsTXRYMGlMUUFWbUdHa1Q4QS9QR2xIWkhnZDRQ?=
 =?utf-8?B?eENDNlFpaWswS3gwVGhEOWNlM2tzNXJjVllhUm5rKzgyMFJ4RElkclFnUmc2?=
 =?utf-8?B?VDJtZlVIWW80bmFkUTQ4TW1EQ3JxSmZNZmNaYnFGTXFZR0NWMHJLVUc2aDBX?=
 =?utf-8?B?MURTRlV5bEJ5ajduTUlwb3YzYjlJZ1IrQXIxeCtpbnFTWmhONzZoekRhSXVL?=
 =?utf-8?B?aC9Ub0VtTHh3YkFhZVhLdmJ6U0c4amhRVXEwaDFmZUpkRlFNYkg5ekwyODc4?=
 =?utf-8?B?bkxyeVN2S2VGeW1GWDJjTWZ6MG9WZHcyWnlQU3Z5YUR6dEhTUC9KSWxrSEhI?=
 =?utf-8?B?OW9pSmljN3o0Yk9ySXJZMzBoZXJqYWI5a1ptMVpYemZaYWlPWHUwYlgxY2FE?=
 =?utf-8?B?bVlFSDdGdzMySjVCa1RsU2FOc2VuUHVyVCtpVWdZcjNKNmRRTnFocFo2bWVN?=
 =?utf-8?B?aVlKL05oSnFSMGdFc1RpREJJZ3pPdDU1c2p2WVd2OEMrQ0NtMzRrRXVDMDBz?=
 =?utf-8?B?M0JnZ0FacC8zMm1aZXVVbDRMNWM4R2pjTVV3V2NHZjJhSmxyeTE3NmdjZ290?=
 =?utf-8?B?czBJZEFLWDQwbVNGM2RaS3VHMGxYU0NuZ01Kam5lR3VHSndrS0xKdzNxK2F4?=
 =?utf-8?B?clZCWHlDQVdnQ3NXUHRUd2lLdS9lOFN5cEthdWJxSDZJU1BYVDA1b0tlQ0JR?=
 =?utf-8?B?dVExNFBJYlZKVUhrWENoV0ZxdEFEanpoWjZHWWh3Z252ZXRLeXU2TjF5VXBC?=
 =?utf-8?B?TnUwL1ViNkMyQ3NJLzd1V2g1ckRmRGZaajJFOTFKS0RiMWZEdXlLNCtsL0ZK?=
 =?utf-8?B?UmxieFlTaXJlS0J6VURGMnl4M2VqQlByb0FqbmtuS0dvYnRNUjZ2T2Q4TnJh?=
 =?utf-8?B?QWJla21HY1Z6OHg4YmtYV09Vdk1QMkdPdjU1QWFLVFlSUFdZTmxQMHJINkZD?=
 =?utf-8?B?MjBkYXZDMGhzVWxhcjFWQW1FYiswbTdqdmt6NytWTSt1N0w5ZUVVQUJmRDJv?=
 =?utf-8?B?cG1MNDZvWDdDd1NXZkUrUWplbVJpK2gvdjlxN0l5ckZnWjBldzJZSFRKdG9G?=
 =?utf-8?B?T2l4MGlaL2FITDArZ1M3Y25WYWpKU2R1K3ZyNllQUC9RT20rblVjWmlKUWZT?=
 =?utf-8?B?cWRqSktVZ1FqWXdwclBpcFVxcncwNFIwT1Z2ZWpNeE9DZmIrTmtpMWJILzZi?=
 =?utf-8?B?anZQSkNSbVdpdlA5V1lTYVZ3TUZnOElHQWNDM0xFWW1tM0Mzemp3RWhjdHlE?=
 =?utf-8?B?ZTc4N1RwWkx1VDBSNWZ4Y09BT1RqU2ZNK2lNUTArMGdYM3hXVkRuYVQxSnpi?=
 =?utf-8?B?UzMzYS9zcE1mMzJ2TVZYbGNsUXVlUGR0dGI1QnJ5Y0thSlkzTFB1QkM5ZmtH?=
 =?utf-8?B?THdIeFdzQ01NaC9tcXY2NU1DamFwSnlHeW1mTVhwbTl0aHBZSUlXa0Zkd0J1?=
 =?utf-8?B?WXhQemswNmFzSjVpYjR3aDhoY295QzRDTVJaVmJCVk4rYUJMbU9nVmRObWwy?=
 =?utf-8?B?c3R5K0kzVWtkYm9kcGdQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNNM0JqSkRMS3pOUEw3M1ZyQXhSU2toazVIR3E2UkxicEtqMGVyQ0JSMjdp?=
 =?utf-8?B?Vng5dE1EQXR3bG5LRVB0aGpCdmVpOGpzWmgxR0NZNHNCc1cwemJJSmZOMC9I?=
 =?utf-8?B?eVdGejZoTlZIOStSZjNFVWN4aElzOFBEZnhCdEFkZUZlOUdGeFJMSVJLaFBx?=
 =?utf-8?B?clAzRnI1L0dtTkpzekk4T1lwMXVIWUR5SnZpTGh1dENsdDVRWEtqbGxrc0E4?=
 =?utf-8?B?dHQrdnFnZncvU2hrdVN6L3R5R1R0L016dXdMcldaR25SWGJ0NjFqS0JiMFJQ?=
 =?utf-8?B?cndYZVJTRWxPREdHelpNbXI3UkluWEs0Mm1iOElZS1hKMEk0a2xSTFVFZmF2?=
 =?utf-8?B?TjFkdG1JWjRYbWJVbVhwN3oyQjJLSnRsOWZjZHZPZmFQSzB1K2wrckJCdlho?=
 =?utf-8?B?N0o3eHptWUR6alFPWTlSY0lYaVZzbS9FM3B5RVFRNHhLdGRZSFIxMUZMc0I5?=
 =?utf-8?B?NXJhSXozNG9USzNuNUNkV3l0RDI3cVVOVGhpeE9wN29HWkM2Z1RzNEljcnlo?=
 =?utf-8?B?VmtyUE0ra0ZObUxESzcxcWZQbUV5TENydWVOK2FTL0lmSFlVcmRjNzhDcHJE?=
 =?utf-8?B?RkRuSzlDYzlwMHplSkJxNWc3b2w4M1QwUXk0RGJXWmQrY3JlOGdvQTR5TStq?=
 =?utf-8?B?bzdEMUh0YUpjbDVCbHkxQk1aYzhpeklGT0xYN01paThLb293Nkkxd1ZxM1hF?=
 =?utf-8?B?UHlZNDIvU2kwdFFHY0ErZC9yZXpOZ3VTVEJaNk5VekpZamxqdW1DMTRKMmZt?=
 =?utf-8?B?b3g0SHZvTHY0aFNEUGlxMlQ2NlBpdmlFZG1iZmkyamlQNVBhcElhSktMLzY4?=
 =?utf-8?B?cmFvZG9pZ1d6VFk2YlB2VUZGZEJXeWxpam5Wb3Q4YXJaN09vUTlJTTZXVHJu?=
 =?utf-8?B?UWs1TENnbzBIcHJicWt3UjlnUlZ5MVNjNi92WitvMDFHQy9EZ3A3SzNhRlBW?=
 =?utf-8?B?VjNLR3NLbXNRWEZ6WXhQYUpTRzM0VnVFdnhnbStsVWtzdnBHMlVEdHA2SVN6?=
 =?utf-8?B?Y0VndkRQeUY2RTNKaXM2L3NzQ21GMWJjTG1DOTZ0Q2lLa0lBSnFrNGZPdHVB?=
 =?utf-8?B?dlFDZnB4VURWWElFRnF3RmxLL3pDRXpLanRqc1p3aHBud1poUngzaERxQmFj?=
 =?utf-8?B?aGZtcFhCUG90RmRiUG5VZTJaQVZTUjRvTmNiUU82WkRBVk96RXowdnQzVFB6?=
 =?utf-8?B?cS8wQm1vaWxUSDRYTEhJeG43Q1VyeHpRemVHYS9vZmJUT1NxK3dZS2dkRFdI?=
 =?utf-8?B?OU9qVzc5ZGFTNHA5dzdxeTgwVG1zblQ0MGFXUDFxSFp3bjliTGt2eWNHbnMr?=
 =?utf-8?B?dnFhaWlwRVZQU1FzTElUMkV3WkdMejR0RHY3dTNzdkVZRU10K0xONW0xcTdm?=
 =?utf-8?B?S1dBVkp4cmRtZEZKQzFPTXd3RVNBbk1jcnJpUDgzYlFyS1MrUXNJdGp2dzdU?=
 =?utf-8?B?dlk1eGFaVjFkN01BQzRsN2p2QXk1SzQ0eEJOSjBtQnlpdjNpakxZK2VPNFRp?=
 =?utf-8?B?SDVGUUViMkszMW1tQlVldmVHWWFRY3l4Zmg5MEpoVytGZjRiN0NoY0thMXpv?=
 =?utf-8?B?Y2VJRElrWmJMQXhabnRVamgwU2szNXY4REVzcGRJNFVMVjhLTUNGVXFoNHMw?=
 =?utf-8?B?eW9YejNyeFZtN29PcGFpRkJ3Y2cyTzVoalZZb1ZyTW9sZXdoaEJ2SGZnTXpN?=
 =?utf-8?B?a0tucVU2VDlXYlU1QnFBTzlXcWkwWkh0dVprd2xmc2xkRUhRQWlxV3ZZdE8r?=
 =?utf-8?B?d1pDaHVoNjJKZkJNRVFjRmJ1MmFtdHdOMzJSalFUVjFPZVNrZFl4MkxvcHB6?=
 =?utf-8?B?UGh1andvL3VjazgxMHpRNDUrVkVxVXh6bWYrYWFyckFPRGY2N0U4Z3lVeHRu?=
 =?utf-8?B?VFhqa21Qakd6NWpwQ0Zmank3M3VqU1JKTFZlNytqblAyMDVidXZYbm9xZEtw?=
 =?utf-8?B?VkNEY2NBK1dPMWpZNzhMQmc1b0JLRGpMSGhmc0poSFlLK2UrV3lubTdtYWw1?=
 =?utf-8?B?Ly9EbFBHSHdvcnduWlU2WU8vRk1UUmkyN0tCUTk4cjdCMVRaQ3Z1bkUrK3BI?=
 =?utf-8?B?L1JNcldjQ1MwNmtMNU5yQ1hHakxVdSs3VVZXVDQ3YTFUSFFYQjFSczJJd08w?=
 =?utf-8?Q?Q0xjpR21TKqBh7AXcyfU80J6v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AXI27GBg7RQ+lxVcbjrtlRBbfeSLtLctPOGYX/d6OrqMPueOqvGXPq5TnhyEAMGk/qQJmOvP6Ho/G3FmEQTEBo+uBl2bZLQ8EaSEv7YBtWCMh+oeDs8kcIeR2WLsVXCphnKbNpAp9hVoyiUFwKbNYV/61LcHlIooRNTuDPPIYR99BQwJ1IhwpO3W1JhM/g0cF+UqZZ6FbpwRJivzlN/cFoVf7Jl/+vpS5G6WyYrLoYmM7/CAYn1F9ZiuHxyPmKMmaqWAyzxiioZitfrG1IOTzXEGJVj0MkF+6n9UjWhsGgq6/QzNVogF82pS+LTZZUPSV5uvFTyDKAt0W56t3WXVeSGwPG8BYx1pFLxKrPh5ISTo0rtVzxL/aVHbg7bbepjrnq4ORyv7qDquV807NX1oDvYvkA3UPoP1O+v1QihOKNSdWYczEHPgiXGZhlQlezVWo3h9yLFoxl/D8Khr+Q33WH63kLt9nrWGCfSzKaxN7PGQeI5i9q5f9B9B0baUazJakqGX7oiegeRm22z6WKh+0gTLmr39MHDqFd3H45wm7qHSMAnm13J0l9qb5LbHUldD9tHuUZC945Ceed6FzjmR4QE38NRc5bpjYfJ0EvO6XcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b2834-56b7-4b96-1f65-08dd3583992d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:42:28.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgDwsOtSfsEeVvO0NDFFIMpNRGEsFg6elBXsnRM3WFvB87SpdYYLqMUnPv7KDZCwgLwc3HnvFqPZJ5Xpoo5E4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501150123
X-Proofpoint-GUID: SekTWUyhhtx2JB6yOvgEIlwQ32VWCXeu
X-Proofpoint-ORIG-GUID: SekTWUyhhtx2JB6yOvgEIlwQ32VWCXeu

On 09/01/2025 11:39, John Garry wrote:
> This series is spun off the dm atomic writes series at [0], as the first
> patch fixes behaviour for md raid atomic write support also.
> 
> https://lore.kernel.org/linux-block/5a24c8ca-bd0f-6cd0-a3f0-09482a562efe@redhat.com/T/#m42a9481059ef011f2267db1ec2e00edb1ba4758d
> 
> Based on block/6.13 . Patch 2/2 is only required for dm atomic write
> support, so could be added to the block/6.14 queue.

Hi Jens,

Could you please consider picking these up? They apply cleanly to your 
block/6.14 queue

Thanks

> 
> John Garry (2):
>    block: Ensure start sector is aligned for stacking atomic writes
>    block: Change blk_stack_atomic_writes_limits() unit_min check
> 
>   block/blk-settings.c   |  9 ++++++---
>   include/linux/blkdev.h | 21 ++++++++++++---------
>   2 files changed, 18 insertions(+), 12 deletions(-)
> 


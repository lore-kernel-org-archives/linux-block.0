Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCA255F2D
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823477; cv=fail; b=ASYulzGP160/sy2efG0LddMAwDfxzY4VRIQcjowyO1se85hhfMGCjYJjE55hTbmT6jYwBbHLqjfmTf29xEmEWWwd7sG+KOQeBW8voeyH1fvTTy5FvSpYqcwIaYn+gmTBJAm5IkrOj75rtxINU7mOjK0NcqvIQRBndDAaso/XPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823477; c=relaxed/simple;
	bh=XqA7r4yzS18M998pM5Tdz7CdzpHshJrVex2GchRYTU8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaEKyeMQ7lGnfVDRzjhn2GHI7T9d8Xyyf6stp71zwbKBVlEia/+8pbjjTGqrW59PnjPbXubEtRlVRsHGMb4a/YjOvy+z4W6g3N7pd1S0DLEWLbofjFruI9+jwDDRydOjspILpA/loDbbzldRmWmv4M1wPh9kC0Ik1UYrbThlZtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RvG400cp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ALbUnfl/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RvG400cp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ALbUnfl/"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5977iggW024265;
	Tue, 7 Oct 2025 07:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LMxzVrfHw85+KKdQEz0d/ioVWnksogx/o7tgpsQpOuA=; b=
	RvG400cp7A9b+qnR8UO8g6nNG8e/KLe5XryTSTJBOxXLoIDSlvj3GRjG7YVR2D1t
	LI6urOM40JZBvWtzUJ8O6tr+C5oushpO3w8BH15kQCuG/jOvLJTrmyWQq5s6yno+
	2rcwrICOBMB7je+YPNqpFwesE4VcmZt7YToubwyOaDlpaVKD45W+7wQNdLUaQqiT
	sdEppyLZnnzoj2BU/iAcY31clWccmu6NGHw2PSWn9q+R95/hmRv7qHTuXiADLAL5
	I31nrBaonmcSvTFKgSlB9IQ90TZCDTqeRmK5qsgpxB1dE4k5r98Z4QpPZMkzlAPK
	QM6nI7Q/R7L6Uq+aj0YdHw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mxr380a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 07:51:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5976GMP2004209;
	Tue, 7 Oct 2025 07:51:13 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt183xhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 07:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+lL8uSoagVCFLSjDMjpJGOrWoMteyun6dzT59fRSMAfBGyZ80NZlqDgTlYM0eH3GP2Souzqc5VzA2jfFDGFlywWok9MnZBEscsCeYGuIUR2xRYQRORkXvzFbyHCRS0I+TNRvAR5hEcbWQexSd6ysAJrGmG++jmORyscTP5ksG7ZdquVC6sgAVoIpSrPlV8hgEuate+Mv9rnhPWcY0eI4pmvEpzSgEpLezWifdF8hGjHkmW6gm6dVx1yLceszDz/E9mT/AWJ7DqxVWEJSWReJC92YoEXa+yPcCd1fTGtM8AMJlF5LTnyJqFvF+QdcLeN5y8swLraNxyP4jKtRHkE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMxzVrfHw85+KKdQEz0d/ioVWnksogx/o7tgpsQpOuA=;
 b=gyup9w6YTRRqN2CUMYP58hbBir8CVpGa4MBJBC1CnxpwZuRV73WgbOwNRo3ThOa4hWAwT6ISXdLVyzbY3wzu4bYfHAmGTOeYDhuSx9XqG1fpWsEyesB6zU5I1qJX8gDGoT5VoOtnjPEU06deyOalNr2aWtZnTUEmbYrh54Uce7g83QOiDaFEzYrbNtffzASrWHIE/ZZjQjSL/Bf+RhUo46ZDVMh/7T1Wt+ONjIOGd5ngx3ciNO6rB27tP4nUxQeS43UZtnV+fRH0S6gOApdG3uHVUC42skKcu6ufGsXVrTsyNb+VBLvyzIXCsyb7ThCJHL6vzi81nHbqme/NXpc4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMxzVrfHw85+KKdQEz0d/ioVWnksogx/o7tgpsQpOuA=;
 b=ALbUnfl/JFG/Pf2ByZ1NESBEDaH2d/iZDVojIL6z9ZYSPl1lW/iVflM7Acy8YW200+w+NY/SHFmH0w4xRYO0+S+xDY1s4ObhO+qKCjbiH9ymubiDV/HgaYEIaSfkUos+ZbcFaqE7fR0L17i6gz8+MO8vj4/u1Vhu9kgOs5JrszQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 07:51:07 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 07:51:07 +0000
Message-ID: <1f86a692-bb0c-4fbb-92a2-11fb28b463b0@oracle.com>
Date: Tue, 7 Oct 2025 08:51:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] check: print device names provided to
 test_device_array()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20250928081537.337008-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250928081537.337008-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 790e348a-494f-417f-ed9a-08de05764609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VndRaUZFbnBvT3FNNGRRQXR1SUgyUUQwTGwrSGRWR3hOYkp6a2x3SHZiei9i?=
 =?utf-8?B?N1lmVjJpN2lJcklpT0F0NGJkbVpQU0w5TmUyeWU3Wmd1RXVneFNQVFRudzdS?=
 =?utf-8?B?OHpWc09nRlB1RmY0aEludmVVZXl0SzlvOTEzbnFFenAxVjVUQk9QK1JZVWZk?=
 =?utf-8?B?c0xPQmZCQVR4RHk3SE9qdTdiUHU4LzQ5TlVTZDBvZldhMGo3YVRubjc2VlBC?=
 =?utf-8?B?cTNHR0t4QzZoTnA4bFUrci96RHpYUWd6SExMdTlqbkMzRHpMZDE1Y1hWcEpu?=
 =?utf-8?B?RG94UythQ0dlZyt4ZlZnaGFWdm42Wkpwc1pSeFdJcXhQb3NqcmhUTG90bWFh?=
 =?utf-8?B?TTRkc1FGT3JFQnNLa2VBeUdVdEF1SytDblh4RmNmOWhycjJvVi8wNHFvT1N1?=
 =?utf-8?B?SFJOV29PM0lpaEowYURUbENXa3BhQlgwdndHd3I5T0VPWGlVY0YycjhsWVAr?=
 =?utf-8?B?WVIzN1l3eU91RDk0WmtpTllPeTB2ekFyRFlyOVgrbXdjTlpyK0t0VlVkaFNm?=
 =?utf-8?B?bk9TTGlTR1ZOR2xwNVhCRDlibG5rR204NUoxTTFkR3lkU0lyMVJIU3FNejRz?=
 =?utf-8?B?VHJzanNXL2Z1R2s1ZmowVGxtQXZFaGtRTTB6enR6eWgxMEJLNlhzajhlYnYv?=
 =?utf-8?B?L0JjOFo1Sk96aFZjTDkvRVNOYkp1ZmJnR1Z2N1hHV2dPdWF2WmFWRDVWVTUz?=
 =?utf-8?B?YjE4LzFYQjhuQ1ZSVUdwN1EvMlR4dWV4dEcrWkhFdUNRRVRPbk5ETi9aVDNQ?=
 =?utf-8?B?VjdWWTNmRW9ESDZ0TUptR0ZQelAxanE0KzB1SmNNd2lRWUdPcUhyeEV4RDZY?=
 =?utf-8?B?cW9BcFhhd2c5bGw1anFqN0VFc0NqZ2VvZW5pZmUzaHJuTk10cktaMks5TDkx?=
 =?utf-8?B?dU53dnR5eDZvaTl5aEVYOUppMGtQUGQzQktjKzlhV3ZPUGRNa2xKMkIrWTRF?=
 =?utf-8?B?K1FQdzYxTkdYczVjdkdydFQrZmNZMTFXQzdoYkdaNlEwZ09xYlh3cHFuTlpp?=
 =?utf-8?B?bDkrL1hobUNCVzJaNEhwdU9ycmxBekduWFVkc0JlaVBxSDFseWV6SHJxbXBV?=
 =?utf-8?B?elcxUTVXYVEwYmU0dWlEdWNqUElHZXI4WjB1SDQ5STNtb1dZSlNueFkwZFkv?=
 =?utf-8?B?ekM3RFg3WUl3QkZTL3NTZi8wS0ZqRW15b3VOWFBPQThlck42YWQySmJhNENW?=
 =?utf-8?B?MWF0bHBsdytrbUJ1NUpqU0pSTS95aDBvNm5lSy9kc0w4SFJyNjlWTkFQQVlN?=
 =?utf-8?B?dk96S3ZQcmhrR296TEd6YmZtSHRkWGwxWktibS83SmpUcFlFRWdna01pQ2RB?=
 =?utf-8?B?eWhvK1NkOURYNU9oaDZWNzZsQlowRDkrWitQK0pyYVZEeDZoNDBQZTdFQ3ZP?=
 =?utf-8?B?bVdzUE5yVmFSWUNmZytYcWdPb2JyTm1YYkJNQzFVSzg0dXBTTlN4WVgrT0Vt?=
 =?utf-8?B?bUprR0JuVVBOaTFianlWYnNaK0dESFpMTjN6QjU5anZkVW1oeDA5Qk00SDBK?=
 =?utf-8?B?SzlHajM3ekZBUDg2MldwMEJZMHB2YUYxMTFSWEREcGJYNHAwVEJMcVNCaVIx?=
 =?utf-8?B?a0o3REVRM1FnNWhWVm5CTDhEaDlZMGtuSStQQW4wZFhlV3ZQYlkyUUZsdXpo?=
 =?utf-8?B?MlZWZUt6ZDVPbkNzU1g3WXJRbFFkMDR6NVRidEJ3Tlo0d2xHNzk3M0lKNWI1?=
 =?utf-8?B?VFk4RFhDWWtOODNaOG5kQnF1OE16RXBIcXdMYjVnK1lJcm91b2hsS2VCVnZ2?=
 =?utf-8?B?NVNpYXNpTTRlbGp0OVF3N3RXY21aYitGMDdHK1ZrY1BycjlEQ3ZWQmtNSlN6?=
 =?utf-8?B?TG5yTmNRNk5pc1NOQ0dKZDRXZ0hDb0hKTVAwenVpZXBGZ1pXaldzWkgwWno0?=
 =?utf-8?B?WVdEQnBqRTYyWHk5OENHOGdhSngxWCtyRW4wSnN5SitjSkFRM0RZNFpDZmI1?=
 =?utf-8?Q?LC+W8ph6SmMo5pFb3gSWKC81IwrMjprq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmNNYVNsQU9DVEFEQk1sRVFETGFoUE5kMVI2dVNhUEZHdlpSQU5jdmd5NDJJ?=
 =?utf-8?B?NzVRTzlESUdlZldMemRtSkdaQ0JTSHZPUFFxTUgreDB6SkdjNnBVZjhVdlU5?=
 =?utf-8?B?TWpTdjhxSFk2MmhVSllWT2lzWHZ5QWk3YUxxYUhXOFZxRGs3eitBeDR5emh6?=
 =?utf-8?B?dkUzUWFGc2p6dUlWNnNtTG9HeE10dnRYa0lpKzlpM3kxYjBVcUhIdlRTelBk?=
 =?utf-8?B?eE1tbHl2Qm5IWHlwRUsyZld6R2FHb3NheFlMVENLWXJHbWNFRXhFYjVPbXp6?=
 =?utf-8?B?Z2JpZjFWbVF4bkxJZXNtdnc1NkVjRVNyMktWWkZwVjBEakxENnVlOTA2dERW?=
 =?utf-8?B?NFRLQjBEa1RqN2hicktUNC9UelBrTDhwbEJGeXZ3SVkrZ0VQWm1Lek9HeTNB?=
 =?utf-8?B?cUpyZVpxNXAza05TaTNpZHJwUThyV0FxYUl2Uk52VHNObDZnVTVxVWtJSFVr?=
 =?utf-8?B?UGZHb2IzSFBiWkJTaENWZTlZc2tORzRtSmJid2ZjdFZJNVI4cWowTm1ZSG9W?=
 =?utf-8?B?MUQ5YkFVYXZOdjd3OTV0a3NXMGFVMVJMSENuUGprOHBwUkp2OFQyYmM4ZG51?=
 =?utf-8?B?RmVKc0NJK0t0aEozMmxsYlh5MGkxNFZvM2FYaDZkMWppU2FtT2p5czV4WkdF?=
 =?utf-8?B?NEZZTTkycmk0YWZwVnNWTFRRM0VOVGlHUnZ0TDFxa2dDZDZHNlBLR09zVkx2?=
 =?utf-8?B?a3hhck5iUTFaaWsveE1aeXUvZ1pPUGY4SEYrOUsrK3lPdldXTDNPUnFFSTE0?=
 =?utf-8?B?OVhkb0duSkdLK1ZkUTJ6QlZ6WGxER2plZlBVZnJjS3hmeEQvODZEOWRZaGhC?=
 =?utf-8?B?RGk3OTBSczdRcm5iQzNza3FydkFYaW9YYmlVYkZXR281MXM2NUYwc1NHOHYr?=
 =?utf-8?B?WGxCTDJxUTB6TzdoMDRlU09WaWhwVE5DeTBhMTJHOVRlZ2RQU3E5THFid3N2?=
 =?utf-8?B?NTI3eUxwT2tvamVYV01yTFVEa3hJejhCU2NZTHNoYSt2ajE4b3BsVHF0SzI0?=
 =?utf-8?B?UW5hOVlkOHdsRjJ1bWpXQjh5UXNJOUV4dTEwMUVRQlhEVmJHT0d3MHNJOFhB?=
 =?utf-8?B?c0ZGTEZLTzhKZ2lrbk16RG01MlBpYVNiY2Uxc3J2NmdSMjNUR2RqUCs1MmJo?=
 =?utf-8?B?T3IyeDBzVVZoTThwUXd1bmxlWVhtMk16NGh4eDNQZUxSMFQwQ1RnTVluNXNR?=
 =?utf-8?B?NjM3MVdiN2VvV1FxTWNEUVlYVVU2Y1hMRkttSGJFTVkxdjVJU1ZYaXdkb0hr?=
 =?utf-8?B?S1hWYnRCejNPcFRNc3JtMDJrK294dmtMTGRkTHZaakpWWThvZGwzdmllRENK?=
 =?utf-8?B?c2QrVU9aS3pBWFdGS09nRmJqMVlHNzc5K2JWKzdkTjczUDBFa0pDQjVPMXRx?=
 =?utf-8?B?R0hPMkZUMnN5a0xDM3B4Q3J2bWN4VkZMOXpzYkRHMmRkck1Hbnl6NXhRZkZ2?=
 =?utf-8?B?LzBRYU9aajFsM000MEFtWXhjcVhETXgwcmxuRkFicEkxamk3RnhEMUZoQmpB?=
 =?utf-8?B?VDdaYktNRit5TTJBUjJWbDBySUs3WjRVOHc1SGJHY2MwdzZQZENTUTZBV1c3?=
 =?utf-8?B?RVhOa0l0TTRvdXA5RkR1N0RhTCt5WFZvNzJZcGFjNEhPRy9vSTRWQ2puSXRM?=
 =?utf-8?B?VVpVempmODNiZmE0R214ZkhFUmNrWEN0MktYZ3pqSm5yV1FKS1h2RXdSd3lG?=
 =?utf-8?B?TTRURnRDbzBjdGVRVlI3WjkzS05XT1VuTWxtMSttbE1rYmI2L3FEYnB1cUpi?=
 =?utf-8?B?SXBvTUFlN3pqRnBkY1M3MGhnOE9yUXo2OFVqOEt5SkFVQXVIQUdrUDFiWThB?=
 =?utf-8?B?NkJVeCs5bGJQQU1UblgvQ3NmVG9aUmNwTWVZaXB3ZExaL29iTU9MZ0pkdzdV?=
 =?utf-8?B?RXN1UitHR2I2eHppWGVWTXZyUnV5WEJaVldLODg4YVhuYXE1VnVpTDE1eGZi?=
 =?utf-8?B?Mmo5UHFSRTB1cjZRaGozQ2l0UHhEREhLcm05cVFiV0U4c0xlbHBuaWhFZGdG?=
 =?utf-8?B?ckx3WkdTQUpjV3ZmdExwN0MwUmxUZ0sva3lub2tuUU5vK09lSm5ZcUUwQlJR?=
 =?utf-8?B?NmZoLzR6dGlDZDFTMTh4YStWbjQvMXNlc3hIdG9jTTlPVVZoMzQ3eStqb2Q3?=
 =?utf-8?Q?ZVn3hVSa71rydbBQjcy6oGqKm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWf8va5K9cyfCQEqP67XeMIIbfuVSublbMEGZ4aViMx2X15nS0wY/X0Wf4EUMosZop/WmRJOmQWsrJOcBJ7D07H61yaply+1JJmRIOtDZseOXW1PzR3QM6l27hfmaGtYKpv36EVD1lSMPnKkIL9jvkS1qRCXmQbDUC6P6muSu4mTxQUurKvzI/O7mnyntv8r+C5hyaZTo6L5vLovObZFk5YbNmtmmta4a52f/hvX5rqD7pot8Zj6pBcyMdBhc2MqTL8xfA4rEkTsQbhve0KofV4JPGJubJknIUBEZwMvyD9BlMxp1A8xENVC14Zd96P4Ns1aPq2bb/IYnWxoRxPcqCRHUq1aWMgFlxo5hGbgEdNP8ugFrdnvvNzgwkCG8PJDFpwllxQb3ChIFGzlLD8j6YZsL3jx/RvUZwzD/nwDbemr9VbJsYE/8yrNF1J8qHuB3Ls1/x+acciR/sjTd9pqiTIUYJx3HG7VSVvT4Z5X3keO2TQHugcaSes5oUYNfxeAXi1twWJJb0Y1KCbvADJD8+EOWTTlSZg0NeFIZYKa+BQ8lK3FHIEveH6zrbXve21J/RXWhQ4QHq33Hv/H/uJdG++gGnGKKfaCFd/0XymLuU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e348a-494f-417f-ed9a-08de05764609
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 07:51:07.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBsLQqw5EtUYAU+gYVRyWWBpzs1VtygRBREWg9s7VAb0yY5Z9ibSVps0p6VYZTzZcHEDFEqKywdZ2pus6ZMHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510070061
X-Authority-Analysis: v=2.4 cv=Rq/I7SmK c=1 sm=1 tr=0 ts=68e4c672 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8
 a=PnjOZqfEHmKmxObKkd4A:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: sa1sfj_zTPWYwsMBjDZGVLz70_TCpUHN
X-Proofpoint-GUID: sa1sfj_zTPWYwsMBjDZGVLz70_TCpUHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA2MSBTYWx0ZWRfX3jsX3NKTvGzF
 os1jiYtxKFI+4QiEzIz3LygcZfw6InFay9ZjFBAB9Wzl18rvZ9VTKiVbfItPQ2VFIsDAyg/TxB+
 TUrg8jIcHgV3VwdlCc8maIU4TBBQI8uZybdJ0ZfhSNxUww3ci4RtfMjAB5p9R/sVANXSj0Mbe1h
 nAU5Q6uYZGnB7xgESXmUwyDsQnSbZ7/vXyE4R7EDVQjnyJJxcXH3fyTVLMf8fVXgBAPbVKFyBwC
 XPny9zRrCADu1KxlVsX7CeiOa1bEvi41PR/rH1D444vpk9DlEImgqfhVW4fZq7NKFd/4OXtju9t
 dqzaCdzy8v+zmJFyjAaHnu70APPHrH/ICr9oLpBgSywkgFGuaSOZT+y0T+/LMfnLkgxB7pbAuZu
 Cx1XPvk+6Q07CJJkbrUoT97UpmhNLg==

On 28/09/2025 09:15, Shin'ichiro Kawasaki wrote:
> When a test case has test_device(), blktests prints the name of the test
> target device provided to test_device(). The commit 653ace845911
> ("check, new: introduce test_device_array()") introduced the support for
> test_device_array() which runs the test for multiple devices. However,
> when the test case has test_device_array(), blktests does not print the
> names of the test target devices.
> 
> Modify the check script to print the test target device names. For that
> purpose, factor out two _output_status() calls into a new helper
> function _output_test_name(). In that function, print TEST_DEV_ARRAY
> elements which are provided to test_dev_array() as the test target.
> 
> After this commit, md/003 run will look like as follows:
> 
>   md/003 => nvme1n1 nvme2n1 nvme3n1 nvme4n1 (test md atomic writes for NVMe drives) [passed]
>     runtime  18.678s  ...  18.446s
> 
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Tested-by: John Garry <john.g.garry@oracle.com>

thanks

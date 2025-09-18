Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BE27702A
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181472; cv=fail; b=hLhE0v+ZwEqlE3YAiEaXOmRZUP86CLjXrOCfE2EOpL66xmsO4IAEO812t2AcbLr20lekQt9f4h6+iwXhmJZl0PMwofbOZr9H2DA/4ZtkT8jhydQZEQWZ+OTR/U3nqbl7EqFDEbskiB8ngFTJ6GDqrsnAEWBTmTa4IXmRGuZrsgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181472; c=relaxed/simple;
	bh=6etU9oqLujHg5hE/RswU6DAXuAPLRHyaXCVnN6EhZuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+MqoZi5a1TrDmclivJKSexGsCgQ1daNkM6ebKT0M7ODyDwJcuKUYbTmUciefqbzHIz0nMxs+DCzGj+EZq8dLkFh8Xkbb6C81ThSfC0YA0h/1Ql3edS7RD4ECiJBlEdxZKoLP/8M5C4YFtK+w8Mf7t300sj+a5rYCHsvs5/SnX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjQYiP8w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dRMxJrUI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjQYiP8w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dRMxJrUI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fvP4025218;
	Thu, 18 Sep 2025 07:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iQUa8LrMTLcoNPi60jvU8ikFnDpaXHtp+boGLQYGT5k=; b=
	SjQYiP8wSXW/nupSlmMJ1KQoMxzGb/Y41oBtLxxJcAJa9+WNgAwi5Hs+7N8aCJo8
	W+l/SXB4pABcCInJeNeL+NX8LHTrkmc5tmtYb9E7L0jufRw0CaL1LUTIHEW/eNCS
	ZlycaTMPVspnfBIpDiWgGaQVTTLI4lSiaEEuiJjt+vaGHCHNDOYJ5mCJBpRmBcPt
	O5VJlZwivnG24Pp2g/Lcc6na4wMaJ0nLsbFVL7Gd6YjeRsCDoi8ZyWG5wTi/N2UX
	y/TUDb98zSEel4TOfgLQ9xzB4rXo9lsBVdLBM6OhG/4dZ0QxkLNy5RbgUQWufBF9
	5gAe00Z3Zxv8mzsp8AK4+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb2vx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:44:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6KOYe027207;
	Thu, 18 Sep 2025 07:44:28 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2n25q9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvs8JLjtDXvL51s0UcbrvvIvd3vH15HSCXvykvoZWulq0NTy6MRsdSdJnwpNE5Zdx1k8cweNAlFUCSCfnEkWOYuW/daki3jVCSZIdywc5COA9MhnMNgACs2u50V1wpxG5xGk6jFHTsCx9asBAEi7+55qqA/DZF3sRX4un4/BIvnDC6LE3V5s7ObQc35JhcuC/VJArAAU6AOjQK3YF+iQ7z38gazapF0MjWNEDQi3y5zdQwjQbliodWuHmB1nolUCs33Ef1g3H8U9bjFv/aVIkubvhyDBXfLctLQFNvhxBrG18x4BlHyfZmoy/RRGyDFBMPT991DFEzQAj6TzIfUH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQUa8LrMTLcoNPi60jvU8ikFnDpaXHtp+boGLQYGT5k=;
 b=HPjqCivUysb08RSYsDJ5XgjdQSnYAZ2Mssrr+nd1ujbdWt0UjJZd2ZEBuaPC6tJ1/inzX9gzLDR5RFQUP92cyvkV+Ljw16jmxqdauU8Lt2TFjgSwpZb2sSqOBNc9lghuQrsJUsE61JT1RI36ndZjjmv81l0Y/pLLzoj91P2NtBSOB+vn1ldjmjvzuRyQwbXkLpNPEhE9DEFPzCIx1F74HHascXBALsg/xQB4VnOk2bQUXUc+INaJ4l9a2UWBKtG12zg5atLNwmbFzLP42mU4UDzwDdikO+/Ki/8Q1XpdQoSRT22GqDOAuIp00wYDHBVCNZ+5r3QNwH+hB1OrBmtPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQUa8LrMTLcoNPi60jvU8ikFnDpaXHtp+boGLQYGT5k=;
 b=dRMxJrUInuYl1aPKIk0Tu6nl7jTCSSEFQvXTkmQQUOw2S8TzEgL/eZtBHPp3SzxSV3ZbeEZumg2yGpnEUfabfcZmFWw+mNHwGHk6fj2yEm/v9nI9jbYxqwJubWbSIfqLnMTQ95o4KwiRRNo4U5PdAF6pdisgowCKzLlctflpPGc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:44:24 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:44:19 +0000
Message-ID: <eaeacc53-c476-443b-b724-15b0067f771c@oracle.com>
Date: Thu, 18 Sep 2025 08:44:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 4/7] md/003: add NVMe atomic write tests for
 stacked devices
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-5-john.g.garry@oracle.com>
 <jp7exzjz55humms5qayfgvy6eu2eiu6kwpqs6la34cq76nu2ii@n5bgakd4ll2v>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <jp7exzjz55humms5qayfgvy6eu2eiu6kwpqs6la34cq76nu2ii@n5bgakd4ll2v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0262.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd9ddd7-394c-4a8f-cfd4-08ddf6872cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG1DWHQ4OEVVcmw4ZW1VN1AvYy95K2RhUDVSU05CWndScTlTL0NUNWNEdWk3?=
 =?utf-8?B?c0dXM0ZXdDJENTY0c1FMUHlhMFNFazdRdklUUkZ5bkVueEw5ZDlJOWh0K3lr?=
 =?utf-8?B?TWN0SlkvcXA0am5wdGVjd2NXYUhRMGxKVGhJd1ErZ1lOTEJINjl0Z2w4Vk44?=
 =?utf-8?B?UTJmQmF0cnhkNGUvOUVDNmZHejJJTEJFQnhCUWw1RExWNVYrczlhWk1rV3gz?=
 =?utf-8?B?MXVvSThGN0lJcDRKdUxZS1FjbUJndTJqNGlrSHhwcy9YSXN3TVQwRWlwTjdz?=
 =?utf-8?B?YnJnekNCY1AzaDFaWlNMMlZScDkrUko3V2xURmNRa1Rra0FKdmFFV3FqUlhW?=
 =?utf-8?B?RGN3dyt1cHVDaklwNHFvQjNOd3daY2JabkwyMnV6YkJEUEhpaXEwZmQ3ZnR4?=
 =?utf-8?B?VWROcGZnemQ2K2NEM2VHM0ZKR00zZCtDd0RQQXkwaGpZVmlmb0FmNWxDcWk1?=
 =?utf-8?B?aGh2a2RZN0Mvbzc0K3piQk9LQ2p4Q3RGaExWSU1oZXFrU2RQeXQ0RVRpenVa?=
 =?utf-8?B?WTlqbThhTmxSY1J6SVV5R1lFRXdvR1hOOWV2WWtHMzc1TEtSYjR1TTNzNThj?=
 =?utf-8?B?QlQ0S20yZzAwUnJQZktWWlRqdEh1RVl6L1gxZ0hrSUdEWHpqV1RNSW5FaGVZ?=
 =?utf-8?B?cWlwWnpqRjZBWWs2SUU1aWVhZTNvMzBCUWhJQjVlOVI3Z05nSmRXTFVucjNH?=
 =?utf-8?B?bTdhMVpYa3hNaSs5Qm5SSmdjazVKU0dhem83dWNPZXJqbWRLaGZGRGVXLzQ0?=
 =?utf-8?B?R2oveDdzbzN4YW5nQkZ1empibnhMemw3NDZxQmRsYnZ2cUhzYU4yQjVjZDM1?=
 =?utf-8?B?ZVo4WFdPOThhNnRPY3RmcjNlaFQ0M2YyZU5TWmVxSHNmYlNhd3JvR2tzY3kx?=
 =?utf-8?B?QTIyM01HNFJ4OWFCM1UwY2MxLzdMNDRNeUt1a3NxcCtSZnJmQXgvVXRWWG43?=
 =?utf-8?B?T0xUOEtlWkdURk9rY01rc2Fyb2s1UWRPU0hYNjJ5RHFXTVFiS0VvVVdUK0ZJ?=
 =?utf-8?B?a2ttL1VndnBmVlhwVURKbXZ6cVZ3N0RHREJLWlFQQVU4cVRXTE9wVW5Ud0Uw?=
 =?utf-8?B?MmpDdEZKV3R6aGY3MGtTVGYrK29EL1djSE9TaklZZkhORzFSRFVVRTdMb0Jn?=
 =?utf-8?B?cVdZb3JCSmM1UmNDZEFmdnhDdmN1eHdHYUhpNWtIV2xUYlZXSzhpVktzWDZm?=
 =?utf-8?B?R2U4b281S1BhNDNpNXVhcWhtWW5DY3F4RjcvVUpNRUZNcTd1UmIzLzBadjkx?=
 =?utf-8?B?ZDdnWmNMa2FTaWUyZVU0WHZ0VnpsaFUvLzBJMThqU0ZJS3RCYStqNkhEeTE3?=
 =?utf-8?B?c1RGcVdpamFzMlhqeE9abXB6N2dncThtMXZ6UHYzT0ZMOWIzVVhuZGdEMFVD?=
 =?utf-8?B?ZE1NS2hXWFhMeHNUNVNJQ3BaM2JmeEJHdHRjRkdNUk9aSVZ4Ylc4QklPdGhQ?=
 =?utf-8?B?c0VlRFdtZjdROHZmajJuMGt1RlZteWJZYjdTUXBmOVdPalJvUE9ING5hV0pG?=
 =?utf-8?B?cGdMRnA5M09QczgxL1l6YjhHNmN4QnpCVFUrVC90L0traVJCQWg4VVFad0Z3?=
 =?utf-8?B?eGhURURTRGdhYlExaXJsTEgzL1VMdTEyR3prTzlUMjNYRHJTZ2ZudHd6WS9O?=
 =?utf-8?B?Vmt2ZktKRUNPL1JqNDJIckNzS0p0K08reHVHM2crUWg0VG5SVHVQUXd0UXFj?=
 =?utf-8?B?anZJVnQ5bnpNam9tdVVHYjZnRU1NTkdxMVEyQTd3WFFabEU1WERLa0s4RFZw?=
 =?utf-8?B?YWtlNFZ4d1pQR3hGd2toNUlDNVZuSXVYVkt5UktDa2xpKzRUcHRLVTlQRU9I?=
 =?utf-8?B?dVZiT0VLbGsyQWs1ZHhsdzVBK2xEYzVHOTIyMkpPSGFicElld09aYUZQNjkv?=
 =?utf-8?B?VWJCSTRGYnI1SUYxcHRYRURWNlJwUnFDVzFJWlllZUhpNGNiYkxpV1pJd0tp?=
 =?utf-8?Q?yNzTwuZu3uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JPZEdZYm9PWXB3VUZONUJteTRsUmFCR3Q5Um1iSmxvN256QkphdFN1anZw?=
 =?utf-8?B?NUhKYzBVRHErNWxNYnAzNTliNEdMMVBieGl1dTJRYmxQYVU3SjUvSnFUQngw?=
 =?utf-8?B?Qm9VRFVWZG16TVg5ZEtNY0xjdVdsQWptVTNxQXJWc2hkaDRTZGY4SUlQcm5v?=
 =?utf-8?B?aE8wam9WRlNBVmxzQlhkWWNYSCtBR3VCT3duY0Rpcy9uMHgwM0t3clJZY2U5?=
 =?utf-8?B?b0w4cHJFRGxUbVlNNjh3WmhuTTNDa3FmQm5QVFlJQ2djNnpiTE5YbW9OSHJr?=
 =?utf-8?B?OUgra0t2dkNkTmhPM1lrdUEwV0ZQOG1sQWdLakw1TklscGhSZ1JBUDZobzB6?=
 =?utf-8?B?NllsMERPZ01uWXFxRmRKREI1MHJodm0vYU92VXM2YlJTS2pwb3JGSCtRM2Iv?=
 =?utf-8?B?aWFnT3NIZjhtR0dPb00xcDJ5QlEwV0V4K2x2NUFtK0NlMlc5OWpZZFZaQjlM?=
 =?utf-8?B?WnUzam9JUGhpdmRHTEFiU3Z1dlJrQ3lrMHl4TjgvODNjRURiL2Vhem5yRDhC?=
 =?utf-8?B?L2hyUmdBa2Vid0szUm1kWTBxWkx5WmhrMmd6TXFwbnhnUGVxMEsyOVhGVWFY?=
 =?utf-8?B?U0E0VnJwZWpLdHgxRG9hVm1wMlVKWWE0WXJQUm5sTTM0T3I2aTZhRFdENmZG?=
 =?utf-8?B?cVc4dXJla1ZOYjdtMk9NZ0Y5ZTJjM1JucmxkRXRsRG1VeFl4cHlkUHdDcmNV?=
 =?utf-8?B?WWRVczNjK2VaeHdxbW1DbnNxT0NXc0gzM3hzdlh2L1BUejEyaVhndDMvSTJ0?=
 =?utf-8?B?TS9uYjV4VlpZVlBabU0zMk8xSGJrbjZwMWVMbU04R3YyS3o2SWc1ckxtRzhu?=
 =?utf-8?B?cm1vWXI4VURxSzQyYjF5UW14MGwwSkdVQlJXQ24vUmxrRmVJeWxrTTRIK0ZD?=
 =?utf-8?B?MnczYTk4QkhIT2NWNGJMUkkwRFdvL0xSZExPYUdIR0JDcEh2VUtzN09ZNGFu?=
 =?utf-8?B?V1JvV01nTGl6SzI0WXNnT2dOY3JEbnprRU4zMG1ZTEVGS1lmN1BkLzhyeXlh?=
 =?utf-8?B?aENHc1J5aHlmMW1DUzJLTmZ6Z0oyVWN1R0ZSeHhyeTVGWVNYaXdNMFJobFZK?=
 =?utf-8?B?dHlvbGxOOFdZVXRWR0RFY1NWaVN0TllVSWZibW5tcHZvSk1nVkgzLzVwbGtZ?=
 =?utf-8?B?Wit6VjBIUXA1dmZnY0Y4UXgwN0JwTGV1cHVrNkt4ay9IdytkUWRiUDdoeU1Z?=
 =?utf-8?B?RWV1K3NnaFdvekQyYi81bHEzRkFKbXdGNk1yRER6YVRGOTE5MC9qQmxBVzJx?=
 =?utf-8?B?SDBRV0NYVmF4QURUWWJLYmsvdmlweE1XUUpicXBHOHVVb2l0TTJiV2M5NmUy?=
 =?utf-8?B?MUtMSG90M3VWOVZycDFwRFZ3THVlVFZIcDhad1RjTDBGanlta2p6Vmd4c3hi?=
 =?utf-8?B?VXV4NkVlandQbzIvdkx5OHh1NitDZllNUDN1WVh1bk40bUJDQjRoa3ppLzFp?=
 =?utf-8?B?YjExUTR3L2FxV0FxT0ZhQmkrbVo1R2UrSnl1cTN1RlpsNkVaR0xhV2hLUnJK?=
 =?utf-8?B?Z1FVd1FpbERkdHh2Y0h2bzJjUDcwVHNxKzFpNWhkQlkwTWM3QXpNRHZGaVBl?=
 =?utf-8?B?Vmhpbmd1QTExWmt0TDR5MkdnMHpSV2F6RXFLNnA0SEJwRW8xa0FIeWp6Wlhk?=
 =?utf-8?B?NHpsb0FLcTRQYkREbEloQmY2NFlOQ2hGT05YU0FpdWMwVkpIK0tXWkFTMUtP?=
 =?utf-8?B?dFFUc3lrdFNOM1N5dXV6TzNZbDNmNlh0c3ozVE1BNFBWQnVUMUZHemRhM2Zr?=
 =?utf-8?B?c2FSS0dXczk4OFhlOWo4MnpUR0h0RnFFZjRsZXZ0TFEzV21BejhzM3VuTFlt?=
 =?utf-8?B?MmpISmt1Z1FOdDFYM0JBYWZjVzhlMzZ0blcrODV0c1JJYXZrUkpKcThGWUFU?=
 =?utf-8?B?U0gwT216Q0lyQ2FpaGpsc281cHZjZ1BuRHhlUmJkN3hndTlLNXp2ZWxQbzRL?=
 =?utf-8?B?NTVYaXZITndCNzdPemZRUjEya0UzenpBcTVkK005N0lLZ2pLUi84bFlLMG5Q?=
 =?utf-8?B?M0JCWitBTitjWHdEUmZ3dUp0MVFkM2hvcGV0K1BDM2VuWmZ6dXJwWVNYaThE?=
 =?utf-8?B?Z1R3QkVReFhzUmNsOEkzNFJLOGJFUzBMcnRxb0xrYXVwcXBYS05ka05YZVFa?=
 =?utf-8?Q?bK0gK1IwZ8Pry5HDoESGKcKol?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QSPsu+AJOM6jyG+FOQLjUow3hoZgoI5xgC2SBbal2y5vIE75SPy7vFiu3T+xVH1+FZFGn8qeD3xuRZHflOVCGLtnhu5PNpCQlbyUzGXAoXTD5hZcRk/l0crgZ3dVLwCtRj3nMRBj5kfhGX1tUQBOEkSS71DzpcGJyYko4EGxcCGA/MTPZVeZrvhWdUcZ5P6Pe/5d18Nby7U5tEMoMIw4Wyby/Q+7cSdDrgiAz1DnUYntsL2kzLUYUKLZ17bUcVmncY6G7OY3YGX1JpLxuPOe+gxGWx3BaBxnM+wnMqZ5H22TbXcMmmdYH+A1ziA8hcAWsWNguo5ktMSjtMEFwIWr9hNft4hrpQATfBTCoZLfGQHtug+iCP9DG6F71Ma307qY7yy056aPFbZYu4vrmguHPTah2YK7vSg55C0TSlIktl4xKDqzVUHdB0NsK8miSfFlrCK7z43LCwbU//PNYALCGXlmTwyTPn371ccvgR3X7n9Gom6mYaeTit3o9LWCirybpqcvjDMNonyZfE16dK1N7iUgOWXJjik+T3Td936zLI+CYLhk/nqd2HOsm/LgCueoYgI5pasMvOzt+IiQ1JyE+Uar5Oi4Bf0Tll2Ns7q+O5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd9ddd7-394c-4a8f-cfd4-08ddf6872cec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:44:19.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdBrRIVfHuHj8VNcaR6iPYD60htvPe6qthN5c+t0tcO6lJquT+daHJcopRmRNp9nKI9JFtLeb8rx7un07O0wnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXza5FoXRPc0uM
 BQ954mKzps+NcH2chR9DlOP/k23uknVKGioqZEHBGIO9/OplZsOCIC71oUVTmnPbKSQb7icBrp+
 lqWbehFFi6ZHW/7S4Y+Kqe2AekBJyfJ2VU04Dxnu4eWA6qoH/Yfycw3UQZhXa05GIh5TvEYTgv1
 dWKFFFUvA5iPFl+vZKqfqS8TVMjuooasXsisbEJ3wmAuoagI75/0oXewV+nSism41PqhaKEDur5
 ObBly7ibesrGQoETD9aiAPK+yZNsNFARbKcuq/kphSZmYELkdgmeXQvbmBIpKDlulu3jkmVIEG2
 jQF6S7twWlWNedg46R/f4altXhU8p7t7o12f2kw1K637tpEKQUtaKy768UTTvuYTBWkZIJ5ZD6m
 YUVktpnPYcNsro2Y2uVvsD4dWMTvJQ==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cbb85e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7LIFzQ-hrmY-5WhogJAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: L6x8fUyV8tH-85022d8fY3c8KSyngQJk
X-Proofpoint-ORIG-GUID: L6x8fUyV8tH-85022d8fY3c8KSyngQJk

On 18/09/2025 05:27, Shinichiro Kawasaki wrote:
> On Sep 12, 2025 / 09:57, John Garry wrote:
>> md/002 only tests SCSI via scsi_debug.
>>
>> It is also useful to test NVMe, so add a specific test for that.
>>
>> The results for 002 and 003 should be the same, so link them.
>>
>> _md_atomics_test requires 4x devices with atomics support, so check for
>> that.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> [...]
>> diff --git a/tests/md/003 b/tests/md/003
>> new file mode 100755
>> index 0000000..8128f8d
>> --- /dev/null
>> +++ b/tests/md/003
>> @@ -0,0 +1,51 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Oracle and/or its affiliates
>> +#
>> +# Test NMVe Atomic Writes with MD devices
>> +
>> +. tests/nvme/rc
> 
> It is not recommended to introduce dependencies across tests/* groups. If you
> need some nvme related helper functions, they should be placed not in
> tests/nvme/rc but in common/nvme.
> 
> IIUC, tests/nvme/rc is required to call _nvme_requries() in requries(), but I
> think _nvme_requires() is too much for this test case. 

I thought that we would need _nvme_requries() for ensuring that we have 
the appropriate driver, i.e. the nvme core driver

> I gueess it is enough to
> call _require_test_dev_is_nvme() from device_requires() in md/003.
> To do that, I
> suggest to add another preparation patch which moves _require_test_dev_is_nvme()
> from tests/nvme/rc to common/nvme. (This comment assumes the test_device_array()
> support series.)

ok

> 
>> +. common/xfs
>> +
>> +DESCRIPTION="test md atomic writes for NVMe drives"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +}
>> +
>> +test() {
>> +	local ns
>> +	local testdev_count=0
>> +	declare -A NVME_TEST_DEVS
>> +	declare -A NVME_TEST_DEVS_NAME
>> +	declare -A NVME_TEST_DEVS_SYSFS
>> +
>> +	echo "Running md_atomics_test"
>> +
>> +	for i in "${!TEST_DEV_SYSFS_DIRS[@]}"; do
>> +		TEST_DEV=${TEST_DEV_SYSFS_DIRS[$i]}
>> +		if readlink -f "$TEST_DEV" | grep -q nvme; then
> 
> If _require_test_dev_is_nvme() is called from device_requires(), the check
> above will not be required.

ok, sure

thanks,
John

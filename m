Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444655C1A;
	Tue,  2 Jul 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907034; cv=fail; b=B+lIuZtY9s2p5chXPtK0cEmtJJYfm8EIDshrQvysPxpxJsXO1Dxma+m/QY9XHTF7DPTm0uhfKP7QCqq25TReQAqx+pAUy1QgFN/paD3snjwolGeSh3LF+0UFrzyiuOldOkXpoaMs9eOTYAPw+t0dPhM6xqTmKeB10W8s3K/6coI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907034; c=relaxed/simple;
	bh=fRXWARN3BvLkl23l87mWzPdwV1T5g7UHN8CrEnvSvss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRMgrBRHZSk+Lm96FXY2Q7nyBHolgcVS30PeWiJm2+yp/8I8Ou5tigVVhmWyl+lEAec/jlpZAHrVeigdUn3YBkAPkHdYCJ1J4+XJkKwjsHHhLLcQUq383VXnNlXYKtBAD0HHflM1BYQhaS/WVYCYZsg/73QKui6nw+gE4o6j78A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ELWsyCqv; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ELWsyCqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfhgMKHR+1SQNuLC6y7EQwAYASuGfARGr9xt5ew3Djh0YygqIEGfRM4zdTuxLQZIRiynNh6UnB9UIX2WdDuc5c8QyNDRnrGXwsxeQaEna4Ro7AO1h20mokB8v0Dz2BUNdkzI+Yky9WL9tsygf/NtimxzMWVP6dKYHjfJcxNHXx5Er+vuME0b71us4jgF8Jl4qY/aOhC96NftTINJnE8Kl90x2qjxxNemU/CBrNBMpwLehtuETYwa1+KehWVxKqBzJnGX1zuH3XhlCGyOSl+MR3bgK3ILUyxMJgqDFHD7YZ4zZc4iLzsYL3extH3JmfQBw9z6D8mXNNxzL3AI2422Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5mJbCrnQg9/iWKp6fr/zo47JVdegivnGZpPhwtePIs=;
 b=SA/io9Pa91Kv9DFQACpDBb9TwN6v5CowsN29yH1sXaSgbrA/azY5t8T9SdjYXVqGzqwjCzmH1dmx4/kQFHFN+pT7L2mKtHRrcxgr5VAb55shsGge+tHZ85hg/WBw+HRpJfV4Qve0v97q8qBZhUnDc04vSOhtxwH81yP/CWOm1OJAemecXz8Vs8iQa78W8zmGOKNesFGuAn7hlK9FZiYrC5/0bWB51fBECcuv7YXm9ZVdS1zy76Zkotmicd+92gKyzPqWeJYBieKK7UfYJZcIFqIEGBso2XmnS98qk3lIiYMmLDVeFBvO+w2MXHEO286A9wNRcsUEWSUOM9WzwdYRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5mJbCrnQg9/iWKp6fr/zo47JVdegivnGZpPhwtePIs=;
 b=ELWsyCqv3LY8C/WRXt+45k1e9kqk/pwtAXDzvv+ELDuKr0U42ZEbTNjQE31WZ/N6dNyzPXnvRv8p5JWG84GSfHWRRQCizXo7+HRB8ej5tuy5f2G9Os/Eeiyma0pJlR2dpt3JgHBeQClhMdXA1r1oo5DTEsabr6KT2C6EiTUVAi51MeOyR3i6Q4jbXpIv+pMaOgnyZJj8/y+7w9wfPGJ33FvX5PXeSdlZONm8TJ6cxa3MOE9+AAhFmPDv4iDH5jBnlhB5RXTCQiZsz+xKF5DNrO1BTH2w9TmxwR2dd06+Fom9y1nB8qiR2qqKtX/sJnfx2k4uxypXobj8uve+sqUSHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB6830.apcprd06.prod.outlook.com (2603:1096:101:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 07:57:04 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 07:57:03 +0000
Message-ID: <fceb1465-d1b3-42bc-ace9-60a93ff4666f@vivo.com>
Date: Tue, 2 Jul 2024 15:57:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240617024556.211451-1-yang.yang@vivo.com>
 <ZoN1NXSHap19qa+B@fedora>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <ZoN1NXSHap19qa+B@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d00b8c-4182-44ab-9b9a-08dc9a6c8f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVp6a25mTEpKUmhnMzRmNGdCT2NtNGI2VjhxeGF6S1djcG1QeHJTeDZacm1l?=
 =?utf-8?B?QWlJNG1mVjBsb3JZUm8wNzJ4WjNJUkhjMTZZWUFPWXF5Q2tRNUg5bVVGcFNm?=
 =?utf-8?B?OVdiaFlibVJjMi8veW1UKzdNanVjazJNM01UME94UFFUVEo4T29NZ1hWUEpE?=
 =?utf-8?B?ZUQyNkM3bFEzLy9TU3hObGJFZlRFN3hTT2lsSkhMMVFYdnB1ZHJTN3c1Z25l?=
 =?utf-8?B?VGJISkJGNmJ5cDcxTFFJSFNFMXZmeDA2WDlQdFFZNjJxOFdUczdFenQyRDAy?=
 =?utf-8?B?RHcrbU0xYVpuN3FQTjNXbHFUNWEvcFh1WXdaSDZhUitCUnluM1g5aWl4M3dH?=
 =?utf-8?B?a28zYk43YnQ1UG1iMTFhcWR3dHlPbFFpT3BiMHorZFppb2NWWHg3MytISnRC?=
 =?utf-8?B?eGdCaElFVlF0YWUwYUJjdy9ZM3FaWEY0M29zNFliMnFFZmI0a20xRXVpd09V?=
 =?utf-8?B?NGk0RWdJeXQ2ZzhqbzdEbnlndlg3clZ4SDM4NVZnV2g2UnFDb05RZzlCUEF4?=
 =?utf-8?B?ekxBT1V3TVNDTVJmSGw4TWxpZFpIbnpBR0hlSVZDeTN6dTJTbnBma0MrZ3Bq?=
 =?utf-8?B?N0ZEeWpjcDMvLzdldDIwVVVQdE5mRGhIU0ZjZjdjb0crU21ycTRwUEl4dVV5?=
 =?utf-8?B?UktaZ0pGbzd4MUR0VmhpUTIxWWNqYkVWMGxiVmpEMEZTbGxWZHJ1a0ovbjdX?=
 =?utf-8?B?NlRiR2oyT1hRTllmYXdxdG5vaVR1bWd4cnRuUVZnMUxmSlphRit4T1l3RW5M?=
 =?utf-8?B?WUhOL1lrR0ViRzVlMjNTTGk3NHJCblJNQU1rdEhmWEpnbEZnUXBUVzg2UUFP?=
 =?utf-8?B?UU0rOUZVRmpVQXQybHlJclhWcXVKZCtUNlEvWGw2RzR1RHE5QnBjQXBQV3RR?=
 =?utf-8?B?alhKMW9Zc09lMjhtQjRramhwaVlEaVlsMkR2am9QZ2hzTFFpaStuWnhDK1c3?=
 =?utf-8?B?MlY4RnRnODZIT0RyUWE1SmtVaTBiMkpuRFovNWFZVjFXL3BLK09aWDVPcVBW?=
 =?utf-8?B?eG1TbGtDMGhzSFQ3K25UTk93MU5xTHZuazg4YUFwYmVUTjdlS1RXZzFnVGpC?=
 =?utf-8?B?MWJKNVp0em81UVhUZzR0d0h1aFBCUlFWdDZESE1acVZ2UGxqd09mODRlMG1K?=
 =?utf-8?B?NVh2OWlUbFVpejBIVnlBSU9FdzRjYStCS3pBNTBYaFpNNFFSSkIwSkxPQUZO?=
 =?utf-8?B?aXNxdG5GTlBQODllWVpBVndrVWRmNUhKek1oVkx6L0h0enhrZDRjVmk2bjF4?=
 =?utf-8?B?Y0s4enliUm9iM1d5cFlHaHcxN0wrZDFZVUVIdmdUZC9IdkdyWXRSTTZmVUFQ?=
 =?utf-8?B?cFdiNUJseEFqRzJzSmcweFF2OUZuSE5vamFlbmpTMnhOdWxzZUFiVDdPS0Fp?=
 =?utf-8?B?Sm9sM09Xb3NYcng1UlYxSFJmL3RtWkJKd01ZY29QWFR3VXU4c2RUY2NFMTVa?=
 =?utf-8?B?OW04NEFxNGtZaVhIS0NWU2p3eWVmRjZpZm1obER6d205VnBFWlhrcjJzMThM?=
 =?utf-8?B?MFZXNHdlSExxYmhLM1ROUWhTSCt2TWpqSVltWFJKYms0NkY5UTlVTTlTbktw?=
 =?utf-8?B?ZkEyZmR5TWZKVW11UWJUTXh5V2dFM0k5VkpXR2RZcHVNU3BjbktMdWdHRW5Q?=
 =?utf-8?B?MTlpVmZ5QWhzTHJhWUh4OEVIRmZiRFJZWVJGbVVmaEExejF5Q3FIc0hNd01v?=
 =?utf-8?B?YjVmcGppRUNDc3A0NTQ5TmNBODByOXJLZE5QRE5HUTNwK1hjTWU4Ym5KZ25v?=
 =?utf-8?B?TngzcjQveXMwQmV2ZnB1andmdlFHcDIvWDFNbG9uTy91VGc1TFl0L1lXeGpp?=
 =?utf-8?B?SlRZY2xMbFZ1dyttbmxwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0h3NTFBL1J1c3RhL3VhK25wc1NOcUNuZDVXNHF4dDdodTdJbUwxQ3dBL0ZN?=
 =?utf-8?B?TzZ4M0xza1h3bzZsZmxHbURGeTlOcUU5SlZ0RTFSS3FXWThPeGU2YTRybXFP?=
 =?utf-8?B?Y0pyVFVPVWUzakNoOXZlWHI3amN0UWlyT092UHZiMGpHNHZQKzRtTFJMR21m?=
 =?utf-8?B?N1paTWlMUmFnb3Z1VkxTczRYbjU3cVEvU2V1MGxLS09ZKzVoaTBDRFRZaGlu?=
 =?utf-8?B?MDA5NVRFM2lBOW5ndktubDkvMzB1Syt6RWZzdzBtMGg4Y2FFaXpBQ3pSWlN1?=
 =?utf-8?B?RkNWVktET3k5bXZQZXFjS1hKeVlJb1U4TTVLbmhIenZmWTlYUVN0UW1wVmtj?=
 =?utf-8?B?VDNKa2NlK1BTemllRVEzQnFOaEdzNm1uVkYzdXUwcnJBaEVCc2JOREwvVExa?=
 =?utf-8?B?L3Myc2hEaDd3WjVBS2xNTlJ1aUpYSnA1WmVBR1Vxb2NHTjFwNy91RGJKUW5y?=
 =?utf-8?B?ZlUxRVEyblVxa2xiMXcraHRnNTdETEd4bHIyaWQ2eFJKek5LSC9BczhXeGor?=
 =?utf-8?B?NzJwaDl2WVB1K2lkblFDQWVSZkRWOWx3OGhJS3ptaDljUytyRU4zZkZ5L2M0?=
 =?utf-8?B?NW44MWRYYnhPS2FmM21oZEVWcElIZjk3VmhWK25GVHQyMXBhcGRQNnRZV0dv?=
 =?utf-8?B?d3I2L08wMk94UnZTb0hXclEwbzRTeXRiMW1SSmdNdTBFbHdFUVBGMW1KZXRK?=
 =?utf-8?B?ckM2MHkzQlkyTS9XdjJCUGFyeWVsQUgwcStSVDhLcy9jd2VRQitRZ2JxQnRv?=
 =?utf-8?B?TG52R1l6RUFoQXBIWklYb09qODRBck0vbFlPdVBVRFRjR09pejZTNXNucWtn?=
 =?utf-8?B?aUE0QTczRFU1MXZEZFE1NWdIS215elJSY1R6bEIwU21LdWh5WVZIMENQOVlp?=
 =?utf-8?B?MEZCeW1Na3owNmg4VjJITVUyRVVDUVRwekc1am9mSEFXcU5EQ09zSEJvelow?=
 =?utf-8?B?NlptbUpUcUlrblVXUGlHT1BVdjlEcVZRako5TWZoM0l1RllpaHN6S0Q3LzFi?=
 =?utf-8?B?Ym9Yei9EOWtrR2lKYnFLM1RiT25tS3dwdndhTFJhbWs0ZkxwbHBIZWZtc2hy?=
 =?utf-8?B?QnJVeXdXdk1saFdlOUlqc0lRK0FQN3AwUmZjaGRhakovWnVVLyt0bmt3RGhN?=
 =?utf-8?B?dTR4U29GMnFWM2VDYVZ5TS81Ylp1Vlh6USsvTXBRcE9rblhPYnpQYkphTms0?=
 =?utf-8?B?MFZpUWh1OXp6RUxKbEh6ZkpWNmVkZE1GQjJ0YVh1MVFRVnBJZVgvL05Uc2xH?=
 =?utf-8?B?RHArdlZPUTVRcnNtNHlZM0c4dGx6VDEzTG4xb2pQWUhVbWJBSjJYWWQvSWVy?=
 =?utf-8?B?bHA3SVkvZVd6eld1SVlGd0QvQmtCL1FOUHNtbllBUm9BRktOTTNDcUgvN3hS?=
 =?utf-8?B?MzhDWnRwVUZzU1ZVT1lEYU4xdTlQSVU2Q2pEUXltSjI2VjYzSmM0Q1RITklk?=
 =?utf-8?B?b3h4bDVGSVZCSUpEajFmeDNLWXhHeVp2NmRTN3pKTWpwK0hHL2dGZ3AwaTJ4?=
 =?utf-8?B?VG5lWXFXczFPVm1lRm9Sc0JqTFo0RkQ0S2MzUitzT2o2ZkdEWU9SZXJMSlBV?=
 =?utf-8?B?aDJaNTRIYzI5ekRkVzFwaWpxdzNOODZSbFc0MFcrakNVWXpVdTc2M29TN3lw?=
 =?utf-8?B?ckx5NDl3VzhDVEpkUTQ3UHJ3c2xwSjhjYnljTk9vQjNpWWRtS1E0TkREOUg5?=
 =?utf-8?B?NWIwZytUQ3F0Z200NWxyNDdJUWx2SmVqbVgxbHlwNFVoeHZzemt0aWV4eTFU?=
 =?utf-8?B?WFFNcHozUGtoSnEvdGhqaWdaQkJ6ZkJyaENWS1BobEd1ZHZ3ODZkclMyYW12?=
 =?utf-8?B?SHQrYVRVWEFEZXBnNU5aVDVyLy8rdUZaK3JuZ2FmREdlQ3BiQ00xQml5TElp?=
 =?utf-8?B?VGFEa2dVNXM0RS9JVDV6ci9ab2tGT1RiT2xRaDlqYlpzTExVNlFnTXhhdzRO?=
 =?utf-8?B?cGo5Mm94M04vcEhuOW5saEN0NGVKd29FOVE2QWRtK1l0T1hLVFY4bHllRXZy?=
 =?utf-8?B?ZVpwZlUxR2xvblRsdUlnb2NVQlgzbE90eHpia2c4MnhrVzB6Zlo5UGcvd0Ni?=
 =?utf-8?B?czlabDdveTBWNW9kS0JEYlNoUDRVdUpwT3FiYzhhSWRHUTByMlZTM2JQenNI?=
 =?utf-8?Q?Cv8b6YHS94SBAxtEBYCcetDy6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d00b8c-4182-44ab-9b9a-08dc9a6c8f68
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:57:03.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCLQol0qRrjB55YyHQ0NHcRQ/HttNnO3uMSGKoFKZSZq9N49aVbFei9LbQpO6BZ2kTpLuA1lcJFHLP8ZA1KQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6830

On 2024/7/2 11:34, Ming Lei wrote:
> On Mon, Jun 17, 2024 at 10:45:51AM +0800, Yang Yang wrote:
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> This patch achieves two purposes:
>> 1. Check on ->cleared and update on both ->cleared and ->word need to
>> be done atomically, and using spinlock could be the simplest solution.
>> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
>> may cause potential race.
>>
>> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
>> ->word has free bits.
>>
>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>>
>> ---
>> Changes from v3:
>>    - Add more arguments to sbitmap_deferred_clear(), for those who
>>      don't care about the return value, just pass 0
>>    - Consider the situation when using sbitmap_get_shallow()
>>    - Consider the situation when ->round_robin is true
>>    - Modify commit message
>> Changes from v2:
>>    - Modify commit message by suggestion
>>    - Add extra check in sbitmap_deferred_clear() by suggestion
>> Changes from v1:
>>    - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
>> ---
>>   include/linux/sbitmap.h |  5 +++++
>>   lib/sbitmap.c           | 45 ++++++++++++++++++++++++++++++++---------
>>   2 files changed, 41 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index d662cf136021..ec0b0e73c906 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -36,6 +36,11 @@ struct sbitmap_word {
>>   	 * @cleared: word holding cleared bits
>>   	 */
>>   	unsigned long cleared ____cacheline_aligned_in_smp;
>> +
>> +	/**
>> +	 * @swap_lock: Held while swapping word <-> cleared
>> +	 */
>> +	spinlock_t swap_lock;
>>   } ____cacheline_aligned_in_smp;
>>   
>>   /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 1e453f825c05..9bd85a9b74b9 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -60,12 +60,32 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>   /*
>>    * See if we have deferred clears that we can batch move
>>    */
>> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>> -{
>> -	unsigned long mask;
>> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
>> +		unsigned int depth, unsigned int alloc_hint, bool wrap)
>> +{
>> +	unsigned long mask, flags, word_mask;
>> +	bool ret = false;
>> +
>> +	spin_lock_irqsave(&map->swap_lock, flags);
>> +
>> +	if (!map->cleared) {
>> +		if (depth > 0) {
>> +#if BITS_PER_LONG == 64
>> +			word_mask = U64_MAX >> (BITS_PER_LONG - depth);
>> +#else
>> +			word_mask = U32_MAX >> (BITS_PER_LONG - depth);
>> +#endif
> 
> Can we avoid the above conditional compiling by the following way?
> 
> 	word_mask = (~0UL) >> (BITS_PER_LONG - depth);

Sure, this looks better.

> 
>> +			if (!wrap && alloc_hint)
>> +				word_mask &= ~((1UL << alloc_hint) - 1);
> 
> The current behavior is to always retry after moving ->cleared to
> word, and we change it to retry in case of any free bits. So here
> is it for avoiding dead loop by taking wrap & alloc_hint into
> account? If yes, this way looks fine, but I'd suggest to document
> this change.

Yes. Thank you for the suggestion. I will include the following
descriptions in the next version.
/*
  * The current behavior is to always retry after moving
  * ->cleared to word, and we change it to retry in case
  * of any free bits. To avoid dead loop, we need to take
  * wrap & alloc_hint into account. Without this, a soft
  * lockup was detected in our test environment.
  */

Thanks.

> 
> Thanks,
> Ming
> 
> 


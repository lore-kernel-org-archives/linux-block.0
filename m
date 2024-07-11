Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170713DDA8;
	Thu, 11 Jul 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691272; cv=fail; b=qARCdWveazqloop9P9yKvE6owkaNnA6MVkh/Ql6iwQ7aVgURDF8gs/WfLroR+fjQ+inkWbFvzIcj8eN9J0ToMhnL0FotXRe/Jyc2lVAVuaTfi7q3ncwJytLxgSe9bKoA+OMIYHxOQ/OtUY2ds3bI5ZAlSPVTW2zZeb4HC9KXtHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691272; c=relaxed/simple;
	bh=ufdINLAlR5TWXhlaENBV5FdqxpmSnclPH1IzcWC/zTk=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iV2vFbCWIBpDyXWrltrhv4vFSboHvMMYshNkNbK8wP9b+12hSJ/BABegOohanbQ5OZ3c7uRCvtFlSwPWKR51KrK3qOklv0D1UNR8pHzTjHnX5qFrhyUXQCftDork+mfJD0qsdb9cyAZKf3Fu3vk7mW2x3q20Yh2qR1q4wAdyogw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lTAiHtvh; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lTAiHtvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiB8QFftWAJGkkG+IZZkWiYsQUZ+fwlsC84cRTIQlIcDADMbFY0hjSEspv0Fz26+WrMW5QQOqYxmKLSIKL+r7qJ9cs33w6S/W2hi4Ait+pYgU8yoKipmWzpFJCgHFH7L3UbL5nJD1WoEPrPjMKaxn+LGNZLQT/OVeNZ6Z9ubSqU3NOldh6xHOiFignT2wG0p5rC/B9d2L4ZnVki8TD5yvE4yONegrcDMHpUIX7PKwAFPqJIWfr4Os54yslUlBZMuaZ0q+QDRdF4brlBdcLCeFJsnpdi9QtSy1DCf4MFH5reBQptdTnFiQyoIaZiVnPJvjKrOgsNir0H7zADFakH8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPPQiwCpNr0UymrJZGcyMwq5oJWGuQiilFgKeNRcOXc=;
 b=t8wQG9Jt/ZFAC6lH9aw8OvfGYOHr5kj1NucBqO+7EUGhyC1cUMsBEBIC0aDEHXXWiFCq1JHZW9yL55YQpOkC97AyD2ZfigBlw19GR8WaR755v7AMmN+WfmYZi9ClEfk5uYoT3GyR+CxRUlFDxAb/EQpDu5HpypoY403krPH5nti2ZB2rbdxlFgEut0qQ5TRh5Lam7AKkm/x4LF+ypl9gIZHG0ncZVdRt+uZ2cBFunB675nosZntiCq02jVq35mbl/SKbHs7Hyl8YCM9m8MADWsJ/HrrDraHb+iVT2W9qrmZ/IpSlM1ZJvrtU+tsDfUICwk2GTq5C5Gn7GEgFEwf/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPPQiwCpNr0UymrJZGcyMwq5oJWGuQiilFgKeNRcOXc=;
 b=lTAiHtvh9yaxlqXA4MHRoXcU2F9HRaxKuzAmSa1ELwCdL325j6+zIAD9lN6c0X5SF7xcaKYbNnz37vO+uOjvgUSRWyFa2iBIP+y9lt2rUv3QaZ/XuLu3OlfjO8CIwI12QRGxV8s7LX5CryiwRyIqrrvVHucB9J5MQTCoZuSinxsJSMiyFqsKmB6Afhhb36pB5fe5qPaTHxYTYZinEpEICOszrMX1XfBeBqhyyXI/e1xUmzTyqAlLrMr6HoltMya//ddgu3r5EDkLReRpjPoNttMHVW+NjDQI+EsMkda5BY5opcZPq6bU3KlfwQl6EplkUZVgJ88PvT7X1M9MAKm++g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB6529.apcprd06.prod.outlook.com (2603:1096:101:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 09:47:41 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 09:47:41 +0000
Message-ID: <591ba004-c28a-4956-ae13-c02cc8d235d3@vivo.com>
Date: Thu, 11 Jul 2024 17:47:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>
References: <20240710065616.1060803-1-yang.yang@vivo.com>
 <ff5cc2b2-bf8e-4a48-8422-cdaac4129043@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <ff5cc2b2-bf8e-4a48-8422-cdaac4129043@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:404:a6::26) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c413a3-c30c-4c3d-58cc-08dca18e8184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05YM1lQZTVtTGM0UldNQmY0bjhYbnNnOXkwZThLdXFHVTZTYXJEMlJrcCtx?=
 =?utf-8?B?cGFVQW1LbERzRldDVlk0VS9MUFlTNjdOWUVBWmhrcHZEems5ZFZUeTcrekFJ?=
 =?utf-8?B?QWFFeVhvdWlPczh3aUg5VURBTDRQZXhCU3hQM3pPNFZDOFc5MU84WlBDZ0FT?=
 =?utf-8?B?SGRVOFJSNDNZR0lBTURGdVFmMGhySFYzMHBiMDczNlFMNHVrcFFOVHFwVDF4?=
 =?utf-8?B?ZkNrS1h3STkyQjl4ald4KytTRHlCa1RHMFZOWlhzRWNzQ0gra1BCMzZVZWlG?=
 =?utf-8?B?U2kvaFIyVlNsazBleGVHZ0tobGw1aFEyOEF3NU1SMnJGQnpwRm9qbmd4c3Yw?=
 =?utf-8?B?SWdLWnNRV3Rtc0tSaFdLZ3VGWElXWVBpeDRJQkltWFh0Y3JsbDlpcUtUWU1L?=
 =?utf-8?B?U01KK05tbFk1QnRxaWQwbmt6OXd3Tlo3WGNtZkF6cDA0aTJ0SFIzdDQ3ZmVW?=
 =?utf-8?B?b2xZZ0I5YmQyQUE1V3oxWWgrMTZtRmtnSTBROTEyaWd5NkprZm1pUnNNTUJk?=
 =?utf-8?B?MnVxcGZnZU9QUzllU0VhM3VzZVZWamJKTWxlNmRLcUdiNVVoMkVoRkZkTjNL?=
 =?utf-8?B?TDhKeXRCK3B2M0tWT09MZUV4QVhQb1RheFJ4Z2ZhOUtOZXg5eHc3bFBINms0?=
 =?utf-8?B?Q0U1QkEzSGNJcm1PNkppemtqbm5oQjNTeVA4RGlaTjBOZk9HenpMMVp6M3N1?=
 =?utf-8?B?SW1CdExFcHIzRFJJUDNYL1laQ2VIMmxwVzg4OEFyL1hwQ2hQYWZoRDdpdGRL?=
 =?utf-8?B?dDV3bHlwQkZWRE1Tbm9HMzZDZUZZTUM4bTlqRk5rZ3J0aCs5K2FQWTI2eXhz?=
 =?utf-8?B?Rm9DdUl4ZVJEdjFUbFo3TFcvclRmQ2lJRUR6blZSb3E5ay94MzVPS29lUXhL?=
 =?utf-8?B?bEtDcWN0WmtEczYzUU4zd0g4VndDYWZuT1R0ZmRMY2luTFRhbVBRQTNQTVY2?=
 =?utf-8?B?YW8wSmZ2MlFsZ0VNNDJWWVBkbHFhTklmTDBDV2lmbHRmRlhkNWdOVGN1cGRM?=
 =?utf-8?B?ZFRhUzhkbHVmUkRBSWFzZERkdHg3Nk5NdmhLbVZGaGlnWVpTTnl3aXdvUktO?=
 =?utf-8?B?YnNSWHJTVDhhWSszY1pucmNoTTB6TzA1RFhVa2RmMGFtMW1uSTJTa0RtREJF?=
 =?utf-8?B?ZVdUWm00VjZIbHJWR3dqbXpKVVcvK0lyQWZIRmpsU3cvU2d6TVdxM2hHMnI5?=
 =?utf-8?B?d3l5M2MrbEJxL0hyT0xrMVA3OUUvM3Y1WWRuNUhrV2dDbFh0NE84OHRreVBl?=
 =?utf-8?B?dkhVUHl1bVlrYUc3TjYyWEl2YUZDTmJCTzUrWlh1dVlkVWRYT3hhQTJ3MFlq?=
 =?utf-8?B?TXAwc1FQQWlubURhUEdiQkRxWXJVSSs3VVk4VGdHck9Xb0NrVXJzdU9yTk11?=
 =?utf-8?B?eVVFODI3eWNNVXZpbU1DTEZWOWpWbDM4dnB2aVZRNVhSdXM5OC8yaHQ3eXZp?=
 =?utf-8?B?bjMzZFJRM3c1YnJXb3U2cVhNTndaMXlXZWErRG0xY0VOWUNadDVRTXlXSTBm?=
 =?utf-8?B?OWUyS0RGa3djczlieVd0SCt1OVJvMmgxa1lza3kzdnhUeUpjbUFVWW5KcjRS?=
 =?utf-8?B?SnVDUmpKSWErK2pMZzcvZHhhZlY5amNUZUVFVVVPemV0ZnZvTEVxTVFTN2tH?=
 =?utf-8?B?QnRZQWwyQ1pjRnlPcHptY1JINy9ZbnY1SmJUbEJFUlNYSnpMVW9YdnNQL3Jl?=
 =?utf-8?B?S2tnSlErQ0w3OHIvdGVtUWdhaUhNVjA1SkZwUDZrbXNjVXNLS1BRRFZ3Q3VM?=
 =?utf-8?B?WG9GQzVDdHZSazh6TnJZRW01bGJIMUZUbzNkMzlVeHQrZG4zdVU4QTEvUStz?=
 =?utf-8?B?bFMxQ2lxQXlxUEtoUkFVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHlqa2pveXpnRC8zRnlVbzJBbDNkNUo0amQ0YXIvMTU2T2QvOGtrRXhqcHJv?=
 =?utf-8?B?NVU3WkFVenhzRFIrLzkyYnZVNmVFaUpLckxXODlHMXRQcmtZeE1MV0tXdGdE?=
 =?utf-8?B?RXFxUDNrYWptK09iaUxKRyt5WUpEWGVZOHU4eDJHUVorRTljbEhwMVZZalA1?=
 =?utf-8?B?Tk1DZUk2UFJlb2l3Unp1aFVUS0JkZ2ZkcTMwUzNlRHlINWg1Qi9Ha0xIZVc3?=
 =?utf-8?B?T0pjKzljYzFmQTJCc1lqbXZRY3BRdjFPbWlsVy9iQ3VWek5uN3haRHhvWGFO?=
 =?utf-8?B?RXdRMXF4TGVwR1pOY1dGei8waEs3M2NrWVJJbDU0UWoyZTJTV1prNE5abFVH?=
 =?utf-8?B?UTRQZ01NRXphZ2QybDBaNVhhL3dTNVNMQSt4K0hKNkphbGkzZ2owcjVXRlZp?=
 =?utf-8?B?T2t4aFRVOEFxQ0pMdDdOYVlxbzJjSXRmUTI4a2VEajdKa2Y4N05TV2JkQWk5?=
 =?utf-8?B?bDVzU0lCaExDdml6Mm9KbHkxNlhKcFZEWkNLWVdpV3U4d2YxTU9remFKaHl1?=
 =?utf-8?B?L1JKSEFIVUROYm8vNXJTa2lmL2FZemJsWnpXYk9qRHNjWUluUEpuQk85YUt3?=
 =?utf-8?B?dE5iTFNYU3JYVHh4emhQbERhZ0YyNUR2M1B1bG1kcTRwOEJ4YUVOYVFmNHVa?=
 =?utf-8?B?OU0wblYyOUwxSGU1Zk5jcWtaZkViZzE0K3h2TFU1VWhMV3NzN1lJQW1kSkdI?=
 =?utf-8?B?blp1NXFSenVGVnRjZmNkcUlLN2kxVC9DN25KZThISkFiSzM2SDgyaDRoZ0w0?=
 =?utf-8?B?K3pHSzhpKzA4Qm5Gd29NNWVYbURBZ0c1WTcwODBwZVRFYmdqK3pvc1BiNThM?=
 =?utf-8?B?dm1Mam5FOTlBWFFsRzBReDZvak85YUVxdjRvSEg5TTJ6QUp0aUZObW9EejI1?=
 =?utf-8?B?cXBpWE0yMzVyZUJobVZreUNHYys5dHB0STFJMDMvQUZ4U1p6RGpEdzQwUy9L?=
 =?utf-8?B?T1lEWUtGL2NLRWtOWFNsQUtmeFFaaHVFUjNKSFRORlpSbDhodVRRR0MwSTZ4?=
 =?utf-8?B?eFFTTjlRTWFXa1ZtNXdEdmdJU2NUQ3BXc1Q3RzNJbW9wamJNSkpPbkk5TTN3?=
 =?utf-8?B?dGRBcUc2cHFmK214NGNPdURKYkRMcVRxb1F4SVZkUWZKTDcxRmhTd1cwR2x5?=
 =?utf-8?B?dXdQWEhhbFA4cFA1RFFLTE5LRmxDOGxyT0t0Nm4vWTduTjhETlB1NWN0Z01K?=
 =?utf-8?B?QWpvZTNYd1Bob3hEYnEzSUF6SkVHcGpmOFNDM0dValdOb1Z0eEl3a01adjI4?=
 =?utf-8?B?c0VzSGMyQ2kyQ29hR1dJc3hmK1R0UE1VSVRLdm9ib1g1TnUrTWlFVXVENzdi?=
 =?utf-8?B?WCtXOHNTVlpWRlViR041QmJhUGdNTXVyVmdyb2dXKy9qMTFqcjJzRVltTVNC?=
 =?utf-8?B?TFJ3YTBBYkZ6UiswVmVNYy9uK1Z3dTlJNWhCQi9yMHJ4aXh5eU9iUy9ISHpr?=
 =?utf-8?B?K0w1VUFSWUR0ODU1dmd3ZXErdG9iN1lYZ0VGSXVORE9tRlV5YjhzQ0pPd0R1?=
 =?utf-8?B?azEydEpid3lMUUtoTDBYVTVJWDFCYTJuNDJIUVZGY05LSDI1bEVLNGhIUFF5?=
 =?utf-8?B?bnk4MHBFNzF6dFVlN0NLUFF3ekFPTk1najV4bkIxSzZDZm1jejlUS00xSDNS?=
 =?utf-8?B?SHB6NVZWUGttN1RsNWlHalRadlpWOWJJdHBhNU9DSGRXWjNSdVBKeHJyQ1dq?=
 =?utf-8?B?aHhYaHZ0M0ZDRWFzZGFwZjJqRVJxamNiN0ZsNVJWKzFwOUJOQVB3M2tLa2R3?=
 =?utf-8?B?NjkxYVNWYUFNa2xoZUVVVUdmSUg5d1RPYUdVWXJvQUJhK0Z3S1hEV1RPYysx?=
 =?utf-8?B?elNvQ2RyUDhyNkRFQmduVVVXQVZmYVhQZGU2elgxSjRDQUNHUDAvdnpNc2ht?=
 =?utf-8?B?eDh4ZW9jMUUwR09aaWd4THZydU0vMVdoRWJCYkxBUHJBUHJLZTFYT3g0SjJ0?=
 =?utf-8?B?Skx3NVJ3c3QxQkVXMVREK09vdVMwU1hFTUtjSGloTG8vZER4MzY5eFA4MW5U?=
 =?utf-8?B?SjhOemhkYUxocEU5MTcrRUJYU1JDUi9Deno4RlNRQkZabjdKOVBlMHV2VHNO?=
 =?utf-8?B?R1gzNHZRaFhvb1liNzV5N1ZHOE5LbjA3WmJrSDNCUW5HT3hvM0IwL0hrYjJu?=
 =?utf-8?Q?C4ky1GE/SRlJ+/SezNDPi3Md0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c413a3-c30c-4c3d-58cc-08dca18e8184
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:47:41.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ4TNstD8WnN0oLk3J3CJlPu4DAYH1Z97Rx0Pms/nRPqXu4+rCsqe3T0BIwUIAKTxyh30iXtRPQ50doDnW4XGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6529

On 2024/7/11 0:41, Bart Van Assche wrote:
> On 7/9/24 11:56 PM, Yang Yang wrote:
>> +    spin_lock_irqsave(&map->swap_lock, flags);
> 
> Please use guard(spinlock_irqsave) in new code instead of spin_lock_irqsave() + goto out_unlock 
> + spin_unlock_irqrestore().
> That will make this function significantly easier to read and to
> maintain.

Got it.

> 
>> +
>> +    if (!map->cleared) {
>> +        if (depth > 0) {
>> +            word_mask = (~0UL) >> (BITS_PER_LONG - depth);
>> +            /*
>> +             * The current behavior is to always retry after moving
>> +             * ->cleared to word, and we change it to retry in case
>> +             * of any free bits. To avoid dead loop, we need to take
> 
> What is a "dead loop"? Did you perhaps want to write "infinite loop"?

Yeah. I suppose so.

> 
>> +             * wrap & alloc_hint into account. Without this, a soft
>> +             * lockup was detected in our test environment.
> 
> Source code comments should not refer to "our test environment". Code
> that is intended for upstream inclusion should work for all setups.

Got it.

> 
>> +             */
>> +            if (!wrap && alloc_hint)
>> +                word_mask &= ~((1UL << alloc_hint) - 1);
> 
> Above I see an open-coded __clear_bit() operation. Has it been
> considered to use __clear_bit() instead of open-coding it?

It is meant to reset multiple bits to zero, but __clear_bit() is only
capable of resetting one bit to zero.

Thanks.

> 
> Thanks,
> 
> Bart.


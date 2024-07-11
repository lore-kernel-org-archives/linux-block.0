Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2041.outbound.protection.outlook.com [40.107.117.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D581E892;
	Thu, 11 Jul 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702095; cv=fail; b=GgZ97dtl+5EQy0520wq8+Fb1RRokDGcuNX2JCejB2/ZEfuyTRxDJWAQrlvC1gqc1XOwXe4pBxRlBXrDFP7kz50fPbnwcbQHNBQklH5zwhItcaAkaoT4hl6CWMs7rD6J6vuAoztlrNZeQPFkChrZa2WxEOXUmLmj2nMhKPBzfry4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702095; c=relaxed/simple;
	bh=jf7UQeXkKcZc9FVRx0NQRxe2Q42zuE0EeHkWD5a9+VI=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HnHcncjHLCCKIEP7H+1p6S9iqxqD0XsINFQWLL0uQD3tH5eB3criFxn8g5iJ6Bc6mxPDn0COy2Nvi9z3iKKZGPM4Lx4d95BbB113hLNX4IkWFrheRfWv7kehPt4jXG/Sk7orRJ2luDKuzgL+1eT40IdbHP2W8EgTMj3ucIwrcHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MsaLrkC0; arc=fail smtp.client-ip=40.107.117.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MsaLrkC0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8BW7FdroPG9SLUOnGaez/Hfn4GGjl8Bo2sJB3chVFkRlIyJin/WpIF13ZqJGhBxwk4gJbPAOMG5tM4C+ncawaEHVQFdQ6dRuClLTK+3hgVUSW3NkGCygMd8Nae1tsOrcDaoVmECZjdQQZ87kry7CzhrlYQlK+grZQy55bE/TT2i66Kr2McnLDgiVKvtQLIrY4KLl2yMa0zfOz/5W/9fWdpVHjsX+fS7ahC+EKnb2UJdA3thwj4d8lnaKLhRxYnYRWcoqY2kDw5KtAHcGdi3U+14D8XFHOjFF1ElOYGOSXcJy6KqHgHPfrCunw3iz25H0/MirFVFawQ4S/yXDDpEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS76UhF1KYhuucozJtd96ZHQoaqhRDAd1KSi9vBd6zI=;
 b=qi3o+o73RmpNsemcdQtNFhXSgYgV8kVhYgc8GQHBAn5EGQbC8atSWBz97yqKYbfcjRF2PWczdWoZwOaZoXXjEs4bqnahZbm+sk8cYxdL9yVj08misml62M69dnfPmDpo3LHQnNtd8niNHPtSJDw6pLDHBz/RxNR3xWTYw7sj5AGgalIoCdZhEjGBfksBF/A7X5z5AVuGUOrSM5981WV8X0hadTj6tJRaKj0wjEHo81yTax4Y9IxxjY7tdi9qjmAtHaf5UHGQINXj6wpoaizc3za3K3fCO0Rd8sWARp5eKD78bxS9zM2G9vkBLwRW/O4NjdwpFHRLYx8kvdm0irC0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS76UhF1KYhuucozJtd96ZHQoaqhRDAd1KSi9vBd6zI=;
 b=MsaLrkC0psRspAOu8opxOA/wus5RZ6TmSJGz30F28v+jRdBy0YpFp65NMFfKoag2ofjMepM6MP8VCivZBFBnI6WgfjyBVRk12jNhKbFECItWy06oWnohdCY3CD/pQGS0vxYV+uE1metnlBPGF4XzAXB/ZZTceFwkRkC6RtDUPopJwHgqL7mNnqvCPCR8dyXlzlI7Hau9JGE72vCiKmhdhPYsE6UQJOmd+iOq8qndPQhUo6Sdg4EiFN7oysA/LiMaBPCaUVnU5+QdF/lDlch/qOBM4CUabAB6qYGprfKdXLE2EMot4xI6atAux6wBIx7LF2ktEoX4W6MfONHpsRvIpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB6841.apcprd06.prod.outlook.com (2603:1096:101:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 12:48:08 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 12:48:06 +0000
Message-ID: <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com>
Date: Thu, 11 Jul 2024 20:48:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>
References: <20240710065616.1060803-1-yang.yang@vivo.com>
 <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3126e5-834f-4cff-0d4f-08dca1a7b5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNObnB4TCtsb3ZzTG5PMFNHNEJCRDFKbGwzVUhOUUlTbnNRNWRtTk03NGt0?=
 =?utf-8?B?dXptc2JlbGxWY0syMVRINEhUSmdTeG80S1BtUlBpcjdKbm1FRHBxS1haS1pU?=
 =?utf-8?B?VjZyN2I3YkN4emdaRk5ORlBMdU9admtXaFdsZ3h4dXNNVVhDWkFVY1l1Vkx1?=
 =?utf-8?B?U3RJWlhQNFVkc0JCQmk4OEVUT1psL2lJU05QLy80OEord2RvMWN1RDF0TnVD?=
 =?utf-8?B?bWxPZzAzMXFEczVsSlhXRXhwbVNpcFA0dVhTS2NVTTJUa28zTnJvTy9GN2d4?=
 =?utf-8?B?M0NlSjExZ2lvTjA0S25IdlRHZS9sK0kvTlhWNEdiY2h3RlFKL01wQU9JZE84?=
 =?utf-8?B?c1pvWnRjb3o0ZW05eVcrNk91bXhiYUJZazQzVEE4SCtzb1VnTnBJeitkUVho?=
 =?utf-8?B?ZlgzS05SSXdVcGdFSU9aRDhHUjAzemwxSiszWnBMNEh0bkp6bUdnUEpQM0lJ?=
 =?utf-8?B?UlQ0eC9BYk10WWxvMk4wQldyaFpIR2pzcU9YOVBONnU0UWpTRkpNUFFGT3M0?=
 =?utf-8?B?WkZiakdyc0Y1Sm9jWHRTT0RjcXVuSytCVUtMN1dhWFJaNmU0OUttaHZXODcz?=
 =?utf-8?B?YlYzRnFyS0l0OERZSE5rOFVlQkF5YXZLTC85ZmcxTW9oYXdXdXhXOTlNc0Vp?=
 =?utf-8?B?d1JBbnhhKzhRdHorSXl5eEMxYnlicWdOOUlsU2RIczA5NWNNRzRPcHdVYjBZ?=
 =?utf-8?B?SkpNZHZ4bEdrZ3dLemVlTElEdzd3eVlNSkVGRHFRMnhHWkJyQWF5Ymp3NnV6?=
 =?utf-8?B?cHJacjl3eFdvZ0N0UmVKNjRYMGl1c3VvMkZYUDcxakRUTWg4a2lRZ0xQZnNj?=
 =?utf-8?B?UytpajBFaUlVdXJlQm5uRjNhTlFmVDdoeFFGODRuSWVVNy8xdEMrb2w1WEZj?=
 =?utf-8?B?RnBCNmEyTjEzVlcvaDBtWUZrZWRkcVpRbXZVSjRLYktUSmhId1M0Q0ozV3V2?=
 =?utf-8?B?MkVxbzhxQ0VXVVd5OWxEOUJhRlpIYmwrYkVyMmJ4dkhNRUFTSHkzYm9ORTFD?=
 =?utf-8?B?QTlzU0Q5VDIxZnRSRWo3ancvNEVRZ1h5YlJ0NTRJUEhNeStvOVJpMWwwa0c5?=
 =?utf-8?B?aEU5MGp1SlNKYktvL0IyQWZldlpHN3NtVnd6ZlpnMkNTYU9XdkVXY2JQWnRk?=
 =?utf-8?B?M09rTkw0RzI0QVZEV05DM0VmVm0rSjRhRS95NlhaQjk4T1p0ZXFKZnBkOHlD?=
 =?utf-8?B?VHhpRkFjUU9yVE1jN0VQTW93YXBzcE5qcUdoak52OXdvNHp2dHRwaEVDdkVW?=
 =?utf-8?B?QjZ6MmkvcFNzMnhIT1JsblFKSVIrbHlWSGJ6K1lxemVtMGZsNmlqb05LYXRH?=
 =?utf-8?B?dWs1NVlBdm9idXFFQ1E5YTBreUZLQjBxYUxIbXBrejNua1JNSnpVczFYaHh6?=
 =?utf-8?B?dUIzQ3NHQXpWSjZhRFBNNGIwK3c1M1NodFRzck1kQkFLb2RBVVVJYVpRSmRY?=
 =?utf-8?B?TUZhZHcxaXh2bjVBUjNMdXlUOFRQMjl1eWt5bXRSYnBUZjNGbUFhQlRyTCtF?=
 =?utf-8?B?QXYxQk4vUm1lQm9SQ0xFNCszRnZ0bHE1NTBjd3dFMTlVZlBpNlJnNU56TkZx?=
 =?utf-8?B?RmE4R050YlJBbmFnamFVaytxTUZ1TVBvZHBITmlsY2t5TXZhNHVJVU9ick9o?=
 =?utf-8?B?b0huSjBhWlZ0SDByVUtOU1lsZXdEczlLaXpvZElCU3JRL215WGpqTjh0QVpQ?=
 =?utf-8?B?NXBYTzd5anVFZGkxVDZRQWJ5ekV4WWVkUnNWaHVuRmR2UHFXWTU4TGdIeUxy?=
 =?utf-8?B?MnU4SC80NFEyZCt4TFJJL21sNkkydkRvNXJBWXQ0TGI1YlR0dnA0ek9tOWpY?=
 =?utf-8?B?NnpTVUdFdzh6L0lCRWRCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RCsyRlk2SCtqdEdqM24xcmdBVURZaVBNTG83YkY1ZXJ6L2wvNDEvbnlzNmFK?=
 =?utf-8?B?VzNOUFptUzhONDJ6RUlOMG4yTzUxR0NXVHFnUGlMYzFYMHZnWGdSTDNMbTVp?=
 =?utf-8?B?RFVWZDhFUzhqMlJqSGZmVHJsb0p3Y2laTk1PMWlkUGlWTEtKZmhWWTcxR0dZ?=
 =?utf-8?B?NDJTZmRKc0RUUzJRYXRUdmVBb09JcG5YL3ZVd2xSS3p6dEI4ZTc2Y2tVK2xx?=
 =?utf-8?B?SDAvRzZIeEtMcCtwMTI3eEpyb1BRRU5rNHA2UFNqdGJjdG1FczRXWXdHY2d2?=
 =?utf-8?B?UzZxSmUzWE1iVis2djE0VCtkT0dlb3ZrOWoyQXQxRWRrdUpPZk44azV0TjFm?=
 =?utf-8?B?SUZIcWxFZ1V6cWFYa3c2aDRoZWpxbkNjWW1NTFEzUWtYS011WVNUMUdja2xE?=
 =?utf-8?B?Ynd5TDAraGdHWjlTK3ZuakdTZFpYU0lBZVNTM1Z0V215dnJ2dFBKdUh2M2N5?=
 =?utf-8?B?L1NJMHVOcEpKUFk5UXhaVG52YVZJN1R6THdIODhhU3lQdE10ZHhWNTJXTVdr?=
 =?utf-8?B?MXFBbE8rZUl5L1NMa0g5dm9WQThqQU5zdWJVMzlYbGJoZmxDUWpkZExJL0F5?=
 =?utf-8?B?MWJnbk8zWHF0SHJKSCtka3BLS3MrT2FkTVZZMXBSU1RPSnJkODhFNW5uMXZY?=
 =?utf-8?B?NHFjcDZBbkhlZkgzdFdBT3p2YkFwQi81K2QxK29HQXJYaTJvMzdNMXI5SXh0?=
 =?utf-8?B?SldYL1VRRDY5RjhSeVVocHhxcytrRmtsU0pzTmRXSGtFbjFqdkhUM1EwQTJ5?=
 =?utf-8?B?MHg1eUNwNzg5aHQwUXdJREFVdHpIRkl4OTdCYlBNdHhHNEdvQUhRN0RnNThn?=
 =?utf-8?B?T2RWUXEvamozNG9LdlVFdnlCSExERk5UN0dlbFNUdklHSktGdDJmNjM5UWdP?=
 =?utf-8?B?bklXZXJNcjRSbHIxZDFlZ0VtT0FyOUFnZkR6YkJtNTdsbGtKL2ZtV0JvMXhP?=
 =?utf-8?B?OUtmQkpTZzN1U08wQURxeGFTWW1sRjAyNVZkaCtKWm9GMm42d0tGQnphcEY5?=
 =?utf-8?B?RVpaeDlpS0hEbmx0UXNrbTN5dWxVTzA4THVrUG1CM2NtQVJHTkRBL3ZaME1O?=
 =?utf-8?B?eWpFSG42d1NWZW52YmtiT3ZseDgrNjhuYlh1YzBmejJnWHJjY0M2d0tESkZh?=
 =?utf-8?B?T1pud1piblhDSkRuVUVtTmRuUkJEZ0xxMi9HeVlJTWlCUkVYRXNsK0pUOWg1?=
 =?utf-8?B?bEozZVltWkNmY204V0Nrd005V3l5OW5xOVZQSW9ySS9rVFhzTzRvQmlLdHIv?=
 =?utf-8?B?ZXpJNmMwQUhSVlVJRHRTTFllVkFZMjV3R2xObnRNYlRvT05ibnBtZ21iUXVU?=
 =?utf-8?B?R3NNSU0vS1YyKzIzN05NOWFjSGJsc2pWY0NhRWlnTENpN25KTHJRK294OEhZ?=
 =?utf-8?B?U1pCL3RtTlFueHd1eDN3Nk1PV3NXQjRBaytWZzZpYTJ4V3VESU8rcGpQTkJj?=
 =?utf-8?B?OFdkMitVTVpHdm4zN0N2QVhEN21ZZ0MvWnlwMUE3eE1tbnpyaDBNVnVSSU9k?=
 =?utf-8?B?S2RtUng5anBiSDl3Ukp5TnBvZi84QlF1Y1lyODFHWGZ0RGtSUkFCNHBRQURZ?=
 =?utf-8?B?eldvM3BKWUQxSDJFanY1SGtmcEF0MVh3L0JDdWxLT1kzc1o3TmgyQnYrTVkv?=
 =?utf-8?B?dW5mbWZnRkxuc1BUTDl3eDkrMDRtbDZMQzBrdERUQ2lzRmVzT1dRRUFkV1Fm?=
 =?utf-8?B?OEhhME5RajIxVHZnaUV1OU83cm5OZEJQSjlZSXhZTU5FYytBLzk0WXl4Mzlo?=
 =?utf-8?B?bkJLeldsTzBMa0lGTTVqVU5aVU1PVHJlRzFJb1BsWGN5YlN0VUdSOWFxbnpU?=
 =?utf-8?B?MkJpOTlqUHQwWlpvaGZEMnZYcFhUcUZCYTJaSms2WGx3VEVXRlZIdnVFQ0ND?=
 =?utf-8?B?OFF0R1J4b2ZPQkwzRHlhR3RaODVYYy84U0dub3hQaThUNHN4QU9TUGdxcGxV?=
 =?utf-8?B?V1BwemgrU05WYVFuNmFXMXNVc0xUVXFwRlRGVDVHenlNK1U4cllrN0gzWHo2?=
 =?utf-8?B?cjgzckJvUFo1R0Y2RGtUeENJTkdZSFdFbjJ2OGlZM1p1K2NYZzNBU1d0ZEhi?=
 =?utf-8?B?Z3lWSjlGTjRiNmRKa1Q1VVFMUHpSbXdPZ09VbWNzSTM4R2J6K0F2L3dvc2NG?=
 =?utf-8?Q?XRx/LqHQ0p4YQsjfiR+WjFMeM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3126e5-834f-4cff-0d4f-08dca1a7b5e5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 12:48:06.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMECcuW5gt9AduxssPazyiN8Ho008HnDbl1jb71lrecCF5XwBghyBnT5n4GJP5xjesxBZbXX/YH5QJ/JZM49Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6841

On 2024/7/11 3:54, Bart Van Assche wrote:
> On 7/9/24 11:56 PM, Yang Yang wrote:
>> +    /**
>> +     * @swap_lock: Held while swapping word <-> cleared
>> +     */
>> +    spinlock_t swap_lock;
> 
> Why is only swapping 'word' with 'cleared' protected by the spinlock?
> If all 'cleared' changes would be protected by this spinlock then
> that would allow to eliminate the expensive xchg() call from
> sbitmap_deferred_clear().

The spinlock was initially introduced in ea86ea2cdced ("sbitmap:
ammortize cost of clearing bits").
I think if all 'cleared' changes are protected by the spinlock, the
overhead of clearing tags would definitely increase.

Thanks.

> 
> Thanks,
> 
> Bart.


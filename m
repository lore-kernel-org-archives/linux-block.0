Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C51078B;
	Tue, 16 Jul 2024 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101696; cv=fail; b=bgMkaYBm3dAdn99JMJ3rTgaS2DRHG7RbEfh4DVQVK+pu7jK5HP7Apx9zXJGdB/PX8iVaj45D1fX5SH4bsTPx942byHpp07pkCwS3hK1YNzYZ+abf2P7ukDISmzR5u7wnFDP3T2LnBW8rPUAqs3nA8GZMKyk0yJYEpe7qD2c+XaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101696; c=relaxed/simple;
	bh=XjzLqt82OLWQkyy8BPFxI+pFAs44OUZ6amaqX5m/SQA=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frrmChPe256IUF/A6w0lH9JbbeaMFa5wNFZDoUN2Edss06K9MxyLPk93+ODw5AtkRgGEMj3evEZaBVQDdwX6byskVXNMlA8FYJzkB9EemiyyBY/E1eG0N/HBkezQGTdBCPdham5mEpG9nVSu8kWcWjcvYQKCEx6RaBveVDcBmwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d2VSHAC7; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d2VSHAC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j66ubbG6qGCzoVdKh5CSID/VyFe3Mnz586fjmFMPmY16lyC000kpsDcFFCP0XnAvHCjqoMZnUXQWOWyYWmEY6JN9cMrYuRAMnaLVdm8DvEz6sM3gO4d4pt9XlipxIgR4fKvYVc3uBuXr/kPh5rgJVYlZ3WaLNAeoNdOv3dfNK/bW0kjFODjCqBtZImCiQTYKtIObdXhY9Y+Wut36rmcaW9/QiZPsxk8MOByImx8J7Mu/oxKuv+3wJVtdhJ5UVtEJYEUPg9kAivJwd2lPjzP9z+06MdBTVd22x3tUa6i1YzgRittTJosOc/EhxkDEPodOKuWwaSBRKkEcm64jEs4saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuF0DTorf6q8rtUS7P4kNlMdnHURJEbh4VzjYpnWsT4=;
 b=wvUQeH0IlivLnj4MfSG9dAZYhlQu0fDsLzmFOvIkDeB3nmCc1qhBG74IN2NRd7pRw581u97hHCUV7F1apAl9yeSTtknqVMG1LlZVGullbf+Mn5mO3TaKiekZWmuoVcMRd2MNWyBSqH0/1kXGfyRnKPDZmauv9AmgVlAhcsnodGeLElinFSt0vq044ylzRFR7r+BHJQhtRDwZpZxUPsT5bmHfiDNXtIEBsheoWnTtnpTOQiUUNzF1nfe0CP2X2AOCYgiUZmBzm+RkQuTfbuy7tVe+FdgheF8q4qlvFPpn83sLex71oa8vuQ8P19plRaoqdV6iX9OTdSwIZQsN594j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuF0DTorf6q8rtUS7P4kNlMdnHURJEbh4VzjYpnWsT4=;
 b=d2VSHAC70W2onjSf8OHL0z3bUYq0rtDKhqrleq+uXKI2IwY8QiYENjiwcXEoEmKFr9VPznup9QxB7ojyBObUZI9laaO3k3XX1bD1DQfkbBpQJ3dIbZxuUPvdVIpnHmAMh26WuywzFAGSceld9DU1IzsJruK9LBkQ0SE2elfhqzShMRNDK0Hso15wui4IB+dvBnzRoc1FiLx3c6zbCG1bYbYynNj2FrJo2MZMVHguYY/jicAijgMwhFZjcTLRGC8XLB0i1KuW1KyxiJ30372W1JyD3B+jDnuZnOFBdUgLNBWy1Q635E6uhkPx4IrnCR55nzE9CL2aAF3UKQ/0lvqO8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB5365.apcprd06.prod.outlook.com (2603:1096:101:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 03:48:10 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 03:48:06 +0000
Message-ID: <37053ba7-68bb-4afc-88cd-8ceac30e2f85@vivo.com>
Date: Tue, 16 Jul 2024 11:48:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>
References: <20240715091125.36381-1-yang.yang@vivo.com>
 <263282cd-dadc-43f7-be8f-892248bc3318@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <263282cd-dadc-43f7-be8f-892248bc3318@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:405:2::21) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f29f1-d1d6-4337-1e35-08dca54a19d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGtBTHJCNmxDRkZvRE4zMUZZSlk1QVFZMzVjTFVodWhmYTNWLzFIZDBUL09o?=
 =?utf-8?B?R1hwYi9xSkt4QVNvdWpkUk1ydjMyT0Viam9VK1BUSFdKT05jRVZwQ1Yvcy96?=
 =?utf-8?B?VzNXcG95NDZJaTh6ak5FTURnS09XZ1VjbHNiYXhlejhwSk13UitzTjRwTkJr?=
 =?utf-8?B?OCtmQUhyZFB3NG8ybjBRajAxU3NXTmZBQk1pYkdxNmNOZ1JiS3VFUmhzcWdr?=
 =?utf-8?B?eFpUOVZkN0pUTDNRWVVKZVlld1dObXhFUG92ekh0dXcwcTBJZnhPQXV2M3g2?=
 =?utf-8?B?UU9qUFE3MVNFdU5NSGo2eUdTaVdwV2ttUVlxVnBzZ1JuY2p6YnpBVW5FRzZ1?=
 =?utf-8?B?Uzc5cnpQVFl4NFJrOWZrcEU1eEFLTkQyMXZndE9OWGs4bjIvV3UyTzRuRi9C?=
 =?utf-8?B?MTlKdWd5MVVyamNEall3Mkh1RmxzWFlldVM1RmtKSTVDdG1DVERvTnJ0ZDE3?=
 =?utf-8?B?eXJHTWR2ZUF1cGlUb0xRZm9vZ2RMb1hNdElkQlk0M3QwWkpkVUJoRkdWNnhO?=
 =?utf-8?B?UE5ESVhNTU5FU29IMGtRWXVaMUUwR0xORkZiSnF0ZC9ub0pMTmZlY3RPMWZF?=
 =?utf-8?B?VWY0N2hFQ05TZXRmRVk0WHpCTGlpaUFHZU1uT2FxbmhCSXlnbmFZT2MyUFpm?=
 =?utf-8?B?UWxSOUQ3NkgzY3BKcktQNjlhUmlPNGxKaG81Vk5nZjF2L3dPZ2FTb09tZlJI?=
 =?utf-8?B?WXp4R2hBYzdiQXFHSkEwM2ZXNkEyMVhvalM5TEJnYjZKa1BxWUlvQWpUZ1BK?=
 =?utf-8?B?ODJTQUVIbVBjaTcxTHVQRGFudHJHRGZLMk9oVEMwYzZqOWEvWFVJQjRBNGdn?=
 =?utf-8?B?MHFDMEx3L3JTbzFxYzdCMWNBbnpsWHRQS2pFRUdKZ2FkZm9hVDRrRUhIVVRW?=
 =?utf-8?B?aGVvWTBFaEtYL0N3QzdjWlZMeXYyRzBZWUQzRFFScW4rdEF6R3Y3OFJ1OC92?=
 =?utf-8?B?OXVBeXNxdmNnZU44QVpSVE5iMlVLZXlFendHT3duUU1tZHAyNWt5WGpjdU5w?=
 =?utf-8?B?bkN4ZnE4TlhNUWhMRWhVRDkrcEo0WWMreXc3ei9FTlNJdVZ5SndrZDgzaXBF?=
 =?utf-8?B?bDVsSjdLb2tuUXhMUVdRSnV4Y0RsaGJZUzJjcyt0aVJXYTRiTDVDN2lTMFNp?=
 =?utf-8?B?MVhLeGpBMWlJUkJmb25MNEtaWFYvUktjazBwZUt5QjdOWjlRSm5rVWEySXMx?=
 =?utf-8?B?SUdWcXBwK3AwOEprdVNoNzR6RjF0N2F4RjYrb1RTdkthTmxGVkErY2Qvakhs?=
 =?utf-8?B?SGRKVVZ0T3Z4bHhMUEwvYm1qcDM0NkhpemNBRXIrVnpVbVJuYjdHQ25JdDhL?=
 =?utf-8?B?RkdXQWxCUE9RMkt6bFQ5cmhaU2FwdGwrWWI5SDlkL1l2RXRhajEyMDhBWDZJ?=
 =?utf-8?B?RVFVN2VDMzFTMjcyZ3dyUU1zNC95TDdxVzYwek84eDBWY2hhdTl6V1F0NHhy?=
 =?utf-8?B?NnJ0MktKa1NXYXY1Y1JBY3NLaVgvbVcrNzQrckFBY3dFZFdjMzFQcGlYV0JY?=
 =?utf-8?B?QkFDbWRqVVA1WVNsU0ptZ0U3WmJ2SllENGd6NzQwaEtKazAwWmRWN29FTnBZ?=
 =?utf-8?B?TU91czdBTy8zbXZRTXhmN2JncmJQTXV3RnlXSlhZUXJjaXlKWTcvR1gzMUNI?=
 =?utf-8?B?MnNSb3NGNDRETXZXWG5xWHl3N2E5TkRUaWhSQzNpaE43QnM3cVQ2dUd3QkdC?=
 =?utf-8?B?d2JXOUlxNUlYUFhCUEVpT1ZIMmNQREQ2ZG9YRkVLWVVhbGc3TldYVGFhR1I2?=
 =?utf-8?B?TmxmWGJGTmRZWHNrVFF0eW9XY2k1WWl4alhHTlJ6QVFSbWQrcmU0WkxveG0w?=
 =?utf-8?B?L3lybWN2SjNaeEs5YU03UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTZKMHZyNk1MVVpOQmhQd1N4WGg0VWhKYXc4Skdna2VkMTVVODdmUzM0ZjNm?=
 =?utf-8?B?ZEdPVzc2dTVwblBLc2dvTEs4R21YUWhMeVJ6bkNTTGNpUzJsY3hSN3F5ZlAz?=
 =?utf-8?B?YWpLR3FOVzl5dUlpL3NXTGVVZE1FbnNsMXlQMTNGQ2p4eGh4U3Z1RWxRZWUz?=
 =?utf-8?B?UTNNUWYrNVpVOXd4MmV4MG44elpMZGdNYXFlQ2JaZWRuMXFjekxsekp2YlBJ?=
 =?utf-8?B?aXQ5TXhyVHM4V1VVMEV5SWNlZzdSYjZtbTdDUmpHcm1FVWlGUWhieTllcnUx?=
 =?utf-8?B?eU15YnorcFBwU0hSNE9WQzV2QktKdzhwNVI3YU02eGlraGI1bi9qcXZmVW9L?=
 =?utf-8?B?cHBubE1sL1llNWxHZzNKREo3cWs3QWQ4QlZsU1RZQVVOditIVm1KeDg2MzNz?=
 =?utf-8?B?UDkybm83MENETG9TeHVjR0NtZ294NUxTdjhvR0FYc0VSa0dRcmYzNVR1TGJD?=
 =?utf-8?B?b2xucEc2RlA4VnpXREVhNjhYL0QwUUY5M25tWjBVdlgyWWlIUWVvMGtUZzFQ?=
 =?utf-8?B?OEd5c3QvWVZWOHI0eW0wWm81S2FwamE0S3RzTUd6TjhtU1pSREdqOVRVQ1FE?=
 =?utf-8?B?cVhpODU2ZDdLUUJjbSsvelZGRzdxaVd6TXc4TmVjREpsZzJ2cjFUZWpnSUtM?=
 =?utf-8?B?MU1GTkJId0ZHSmtxUDZYM245c0MreDd1QURtK2NJc1FrQVRYWmtxOCtPazZF?=
 =?utf-8?B?WjNTNVVWTFhHL0k4ME9kQmNSL2srdUk5MVpTTHErY1Q1aGFOUjNYVzBiM3ZR?=
 =?utf-8?B?bmY4OWpJNUdybXhydlNmRzFITzFMWERNajBzckNTNW1CcTZtNk5OZVQ5emcz?=
 =?utf-8?B?YXd5OCtVeTZ2ZURMWHhlN0YxWVJrN2l5cFBvQnFsSzRnNHl5QTlCK0tSVzUx?=
 =?utf-8?B?SklGL2J6NXpJRzZQalAydytKZnF4S3NqYjB0RWVrUE9qQzd5K21yZmdFR0hT?=
 =?utf-8?B?TXFvZ212NW1namxna2kwWEVTenNrZytaQVdIRHI2a1dsSndPRm04ZXQxVnc4?=
 =?utf-8?B?Z29UU2FSSDVZZysxMVRvOEZlSU1LQmZwSzBDbU9WVU15Z3FqMWxwYTEzdnVw?=
 =?utf-8?B?WHZieHFpWlEwc3J0OEx3WEpueXdGUk52by9KdERWUG9yUURndjgyQm00cUNv?=
 =?utf-8?B?KzJweDljY3MwTDY2dmRKR25LSW8zQW9uOWZpNXd5VnZDbzkxaUR4eUdpaEdK?=
 =?utf-8?B?VEM1T3JuaENCb0xuWDVLNlhrTjNpMUxiZkVEKzZqNFFPVmlMTENUSmxRaFp3?=
 =?utf-8?B?WWEwWnZrTzhxSHc2dVJWL3pJSUo2b0NHTnhkeEFpb3FLRnFhdVZtWHpFdldp?=
 =?utf-8?B?d0hrWEJpNjBIK3dhWnNDelNvN0NURDBmQzFIYVRVZEVXV1VxSW4zWlR2eTRJ?=
 =?utf-8?B?MXo0ZVZBWGhyOW0xRXVhVVNxR3pneVBOUGxrV1N3cm5zUmo2U2p6eVVhb01X?=
 =?utf-8?B?MnFZWWZiV3A2MkUxUnduK3lQU2RqRnB2MHR6TTNvb0FxT2M5SFM2bmNZeW95?=
 =?utf-8?B?T3orYWVJZEptbTZTUnJienl0bjE1Mi85VVlETlBrSENERWhOakFjRzczUHdJ?=
 =?utf-8?B?Vm5VZkxsNW4zVUE5UmFNdWNmQ3JOdGJITXNEbU1EYVJ2RlYvV1hKUEY3REVv?=
 =?utf-8?B?cUorYmgxRTQ3NElITFNuQnlVdDNub2NBWHJDa1M1VjZ6QXR5bFVXQjErcUZr?=
 =?utf-8?B?dHVZL25yeXlBVEFrb1VHajFZS254OHJ4azdHSGo5RkJ0V1lYaHpjY1Npa2Vt?=
 =?utf-8?B?d3VOcTY5WGNEV1hjVGtvSjM0REMrcG5YVWlUQzBKdGx5S1BEWFR6UG1SL1hu?=
 =?utf-8?B?UlJ6MStpMXljMzFlWWpka0xUWGsrVzVpem94RWQ0YXVvalRFWGhrWTlkaGN2?=
 =?utf-8?B?dnJ0VVV4TmFvSVdyb1IzL1VOOWE3SlRpOGw3WVJHMmJFMmdjNHc0UUM2dDhE?=
 =?utf-8?B?ekR2eStINXpnZEhCWlFxR05PUkNBYWxzb2FNQWVXUldET0tnOVUvWmg4b3Bq?=
 =?utf-8?B?TkJkdFNBRFF1dlFidHRKREV6dC9rVFF6Q2Z4YXp6VUZTbm5Mc2ZOblZBTkhI?=
 =?utf-8?B?ZnJSbW1ZRVRKU2dFZnh4VmlDcFljREhMWUtTNzlOMmNHRENhL3Z5UDRtVVpU?=
 =?utf-8?Q?LCPgLPrTCchrsMR0lND1LVN9x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f29f1-d1d6-4337-1e35-08dca54a19d3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 03:48:06.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p4GnScQKvGNU/u2clJdKf/oFK49HjSdZbwDMXooAz/BuXi+8tQ981STritzp9D/krRotQFhRoE6PnKBGi3f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5365

On 2024/7/16 1:26, Bart Van Assche wrote:
> On 7/15/24 2:11 AM, Yang Yang wrote:
>> +
>> +    /**
>> +     * @swap_lock: serializes simultaneous updates of ->word and ->cleared
>> +     */
>> +    spinlock_t swap_lock;
>>   } ____cacheline_aligned_in_smp;
> 
> Thank you for having updated this comment.
> 
>> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
>> +        unsigned int depth, unsigned int alloc_hint, bool wrap)
>>   {
>> -    unsigned long mask;
>> +    unsigned long mask, word_mask;
>> +    bool ret = false;
>> -    if (!READ_ONCE(map->cleared))
>> -        return false;
>> +    guard(spinlock_irqsave)(&map->swap_lock);
>> +
>> +    if (!map->cleared) {
>> +        if (depth > 0) {
>> +            word_mask = (~0UL) >> (BITS_PER_LONG - depth);
>> +            /*
>> +             * The current behavior is to always retry after moving
>> +             * ->cleared to word, and we change it to retry in case
>> +             * of any free bits. To avoid an infinite loop, we need
>> +             * to take wrap & alloc_hint into account, otherwise a
>> +             * soft lockup may occur.
>> +             */
>> +            if (!wrap && alloc_hint)
>> +                word_mask &= ~((1UL << alloc_hint) - 1);
>> +
>> +            if ((READ_ONCE(map->word) & word_mask) == word_mask)
>> +                ret = false;
>> +            else
>> +                ret = true;
>> +        }
>> +
>> +        return ret;
>> +    }
> 
> Now that guard()() is being used, the local variable 'ret' can be eliminated. The if 
> (READ_ONCE() ...) statement can be changed into the
> following: return (READ_ONCE(map->word) & word_mask) != word_mask;
> and "return ret;" can be changed into "return false;". Additionally,
> the indentation depth can be reduced by changing "if (depth > 0) {" ...
> into "if (depth == 0) return false;".

This looks much better, I will make these changes in the next version.

Thanks.

> 
> Otherwise this patch looks good to me.
> 
> Thanks,
> 
> Bart.


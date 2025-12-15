Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012063.outbound.protection.outlook.com [52.103.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E615E97
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765779957; cv=fail; b=lbyuecp9ELJWla47Cpfi7GWFpPtqe5q1uQAMT4rpVcoSkdvN88/egB5bh2NO7zC+H3rvFjG/VXUKeoPQWNJFqpHVYqnc8s++DDqAgAPLHHScrN2fT3HRPJC25npckZewr93ssh/1gVbcPnEVLhY00HOkKVzLJO23coK+G2fkcFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765779957; c=relaxed/simple;
	bh=nCNdPoa/OwDr3VkFNT3NtmIRB80JLxfeAu60RGZeRfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yy89HICFNrJtBevqULn4KRltFrB+JMDXImdOHBqrNNK0QrQoJk3mYPObE55eIaYDFPArWAmys8yFZ7PjaYSO9PhwJHql2VrMpMuI+VHqBhT8891P/dBFX8Temoo1KvugXxrJLwcU9mruU+eqFPcd5jBC41IXzUlIivXhuM6InhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KeGdVaTU; arc=fail smtp.client-ip=52.103.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KeGdVaTU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyDz/GoZdJPmlWGbMMUlUhIk7qEB/yA03K7W60UgtRMDkgxm6KmmNp0WfgaxpeP/r1sYe4pcP0qGSmL31grPIsWh50I0ZWHYO0qMrMcqr3QV5GqJFbUQ5ee+HcoXOZpE9gT1nAwN/4GXGUTuQLnLgPNFMrSV/HsSF+cyFq3OxmPIiI/aQWqnz4Shl8UcldJ+H5/yTEiTZ29K1srY8Je7+dSXwPpS/IABkcnF9t1uPEhRMmIpKR6uQtHFYAtyld4dpB9YfEfZRHfOBHG6fF8r2GXp+9uGQj33+krusd1pA0JvOheqnYT25HyAtcG7pdSTjJei7DMA/Hk49iffSTHOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th7tqQM6JH2yz6JRcE9lHLa6divvNVVq4F9Ad5qG9/g=;
 b=J7zXNWeMRKxDIZMVQfzmO5zl4oyhecQY8EtSReruzWtfioeEeVwz/r8M+HPaoGiaZuKZLcM/KdzaKOptDleYJ5a4icxxNkQAJajXZjFji1j9uz7JYRBxu+z7VFHZ1NxPjQX4tT9Gcthra/O7wwHv5EStMpRbSlZ97giItK5l2i3QaWWHRGHY2KHy2KaRPlW5lSfTdbpjMEtKKAgvcHzWt3TmTI2O+8XBxPVP+AbWbz1H3HC4J9kKFrVTFnzFrS18tNbkPuXj8uyWSQOBYfrGSdx/zL6utDt05Ox51UYnB7/+6yBeMAYJrf4NARf+V9PSvQPTjVMPnfO+I2T3oK4FOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th7tqQM6JH2yz6JRcE9lHLa6divvNVVq4F9Ad5qG9/g=;
 b=KeGdVaTU5fkBhdtOwx6ETF/kVO28Qkk0/ckxt3bnQETqG6g/1dy0i1wFLco3/9xWsg+xnVwau65/9TIl9PWns9lWYjcc4njaeNutq7KoHs8FOwfitwqnqKb6YH6clM4y6DyEe/G6KCPlsfCFf6SXl4KVh6Nta6P6ckyC44XAZ/zRNB3yHmUd5a1m/WsoGNaO6xZIaOSnLVxsBNmt6cvY7MbidEIt6M0apovH3UquiBKEaqbCoqb8HoJYILDpN1ptLf8sA321tcw60WnVzV/mZVEBGgL4zRZmNVm8OXgDGDOk5GeQeuHR56DKFalVaDDmpoi3LfgZMajELbm2BljAgQ==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by TYSPR02MB7936.apcprd02.prod.outlook.com (2603:1096:405:88::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:25:52 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:25:51 +0000
Message-ID:
 <SEZPR02MB5520309542E70E11D878B81C99ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Mon, 15 Dec 2025 14:25:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] zloop: ensure atomicity of state checks in
 zloop_queue_rq
To: Christoph Hellwig <hch@lst.de>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251213134545.207014-3-yangyongpeng.storage@gmail.com>
 <20251215053153.GA30599@lst.de>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <20251215053153.GA30599@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <891656f5-596c-4069-be0f-b7ad3e94fa43@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|TYSPR02MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c714a9c-cca9-48ca-2acc-08de3ba2cb00
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799012|8060799015|15080799012|12121999013|23021999003|51005399006|461199028|9112599006|40105399003|440099028|3412199025|3430499032|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGdYZCt6SDFYY2pvZzlPYW9kNmJhekFBNnFCS1lhVHFOMTl1T1piNTZ3SUox?=
 =?utf-8?B?YTVPODU0cm1GMkFyV1Rkb2lISXZWSXI0ZXBLN1Q3bnAvYUwyU25ac2pqbllX?=
 =?utf-8?B?SjdLZlplT0MwYytXTkEzeUxuenpBYlRJMWlCMjNHWXBIc2R6SXhSbjhMdzdz?=
 =?utf-8?B?UUxsVnVjeFp2S3JOUm91N2VENkNVN2liSW01dWhBWGpOblFxTndjM25lTVkx?=
 =?utf-8?B?MFRROTlvQjg3bEpzK09jNGRLTHFlN1FWZStLY1JHNmZ1Y1pHMzVqOVBSdFNB?=
 =?utf-8?B?bE9WN20zR3hMYUk4MjBQcFVRZmt5eE9MTkRqcTJVdkV6dXhqd0JqTEc2RC9Y?=
 =?utf-8?B?VnFIV0duSWxMUm5IU0F5dmVoSDdzREExU3RSZEZtUlRscE1GV0MwMWoyWkdT?=
 =?utf-8?B?VjJkQWNkWUZXZC9kM3FkL1dmMFN2NlZEQ2MzeTFIb0hBZTVHZUJCc1hjd3hN?=
 =?utf-8?B?K2dTamFFMmNqUmVJVDFXVGJkYnZxRjRjOGU1R3I5aDMzeTZyejhUdUw3eWVO?=
 =?utf-8?B?YmhMVEV0ZkNhTTRnVTlvZGdhSm9IUWpMSUpVckhlQVRYbWVlK2RBN3hIbWlv?=
 =?utf-8?B?MWRoQjJvd2pVdHYwWFpoMHpMWVE0SkNsQkt2aW5OWHRtTmFoMnFBUjgxUkov?=
 =?utf-8?B?WmZjUFBrTkhjNE5iakwvNWxCNWdMYzhJTENrb2d3V3ZZbmlyTm5LaDgxQmZL?=
 =?utf-8?B?RDFkNnpjS01KYll4RHZLSFF0Q3FmeWw5MkZ0YnArR0lhSFhNSllMWWc0a1NC?=
 =?utf-8?B?TU5GTGd2aFhybXg3eGZYN0c5VWZtdlhHMUQrWEpTSmxiaWFUZzQ1bGdDUlhy?=
 =?utf-8?B?NW41Tld2Zm5mdFpXT0l1aStTL3pHbFhDTnVQN0NrVzdjamlxS1lLODc3Zkds?=
 =?utf-8?B?THFhc1FpMXpwUGNnOWM4Mmg3VTc4UjlQQThGL28wMEVrc3pCSW41S3VhUUJl?=
 =?utf-8?B?Y3l5OC96SGwyZ0FlK3JRRHdtOHdXMGJHNDhEZngvUTlUazBQMVA0THdyWUNM?=
 =?utf-8?B?dUptYlY0Ykw5V0kzejBieXBPdllna3ZXa09qbjJBUlh6dXRvbGoxc2s2M1dr?=
 =?utf-8?B?YVN6aDJIeStSVWxhY1Qzc3FINGhHdDk2ZUxPdndSelNQajZ6V2k2RmoyOG51?=
 =?utf-8?B?WUVFM0lGd05HRUJvRi9GVXE0NDRWVGNMREttR1B3UDdKY3B6dXB3T1Q2Y0xq?=
 =?utf-8?B?YTFaVXlOcC9nNzRXRDVHRW5HMkcxVHZSV2wwSFo0ODdTa0ExT2M2Q2hoMlpn?=
 =?utf-8?B?Y2JGNHlldlNxbVlhK2R3dWU0TFMyNGpqZFBoNFV6bzhLVTFwdS9CM0NxbzZL?=
 =?utf-8?B?cnR2c0llY2tyNXd0bngrckF0Z0c3bE1PTmRyT2pmY0R3ZTg1NHo2VlNSOWdI?=
 =?utf-8?B?UTNyaWMvcEVFeVQ1bWpsY3lWMERNUXNPN1piVi9jUk9INU9OaFlUWGdGdGRD?=
 =?utf-8?B?R0ZpbXJyRElUdkJaRlF4RXhma2ppaXdBZlh5VFRwbk5BTGQwUk5la25CWlk2?=
 =?utf-8?B?akt0UmxYc3RwanBjTGZneFZ2WWxaS3N0Rnc2K2dIdGtMbEQybHdSYTZiZEk3?=
 =?utf-8?B?eHRXU3Nsb2VSU1VGOHZzbC84SmFrZE1IUDBWL2NCckVKdUR2bFVrMC85WHRH?=
 =?utf-8?B?Lzl6QnRUSjRCeExab0wra3JBZnNiNGNaMmhTVWF6MkxucytPSElEekl5Z1FU?=
 =?utf-8?B?c0FoZjdJWi84M0VLVHhLdWFWeG9pMDlMTEszekcvT1puYzEySnBZV1RjM2tm?=
 =?utf-8?Q?8/w/OdRe0tLKR5IYzE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHlGSE1URjJtdzE2OTQySEtUU0dBVUdBcGd4UjYvTElZRDg4SURFMmxla3Zn?=
 =?utf-8?B?RThQblZYTlRnSHFMTUNBSUw4em80RFY1eVZ5bGdkbjFtV28wWVN1VGFjMm5x?=
 =?utf-8?B?ZjRReEtaNVJsaFlZa0hHS3hsY1J3cXZXZzY0bHhOZXUyK3JzVzhxaTgvVlRa?=
 =?utf-8?B?a3BZRGVKOW5JTFA1T1VRUzdvQ2pLQ0Zna2hZdEd0dytVOWE4d1Y1YXRYbTc4?=
 =?utf-8?B?SFQweG9rdUE2dnUvdW0xVkhMVXdaMDh6TU9YN1lCSEFxNVVqY3htdkxpRTIv?=
 =?utf-8?B?b3Z6ZDkyNVRubWpoMDdCQ3l0OHZQTHVqVXk5NVhQb0dyNGlCM2YzMlZLcWhn?=
 =?utf-8?B?R2VmV3NlZXorNjRQNjg0STZPeitEL2lUU0hZVy94RGNuVVZoNzcrQVlpeVNn?=
 =?utf-8?B?cGppSkxYWEJLU0k4cVYvb25SOFNJN2lUK2tZaXgyMlFkdTJtR3BndXQ0RWFr?=
 =?utf-8?B?Q2tjNjAvODBXQXJwOCs4ZFdzRmNuWXkzOVJEb2FjOGx0b3FER0hoeWRyZnMr?=
 =?utf-8?B?S1lVWS9USUl2SmZSL2gxcHg4L2syOWs3ZnJpSzBEM3NwVzZMQ1pPckViSmNn?=
 =?utf-8?B?QVhLU0ZYOG9BeE0rN2x3K1VuS0lJVzk0RFBPbTltblVzVzh2ZGFxYStHUVNW?=
 =?utf-8?B?SVdOY0ZOa1cyVnMrY2RSZUJUOHQ5N2daMldYR3ZhK0lFUXQ4RTJSTThSOXM5?=
 =?utf-8?B?OGhnQ1hSdGpsYnU4eVZ6aTY0alFDRjZoayswblBGVUIycmUwb2VOS2ozSWhS?=
 =?utf-8?B?dGFGeWN1cTY5UTgxbXpRTEU2TldIYTk3TnpLcXR0eGlvZHpGNDNoRGhBYzBU?=
 =?utf-8?B?ZGU5M3c3eWFIaFNPTFBsQjY4WHVEa3dHWUJOY1FRc2FZTW94Q3BSTmRMczhN?=
 =?utf-8?B?bWIyejVOWjloejcwVUdqS3pLbXh3RGNQU05MWXFOTG8xNFYxUGd0QlRUd0pP?=
 =?utf-8?B?NGRSUXRQczlUU2lVU2lCUlduUERLdTY1WExzY2NwVFRJTFcrMHFYNFVJOVBv?=
 =?utf-8?B?bVBCeDROWjRGTVZRU2FCTkM5eE5jam9VSzdKTGtBYWl4VGZCcStzckJ1NnRa?=
 =?utf-8?B?d3NTQ0swdW9mK1lCcThtM3JNckdDSlJKcEtmREdpbER0MkxLOWNpcW9nVGtv?=
 =?utf-8?B?djJmdjZNU3NLcjZmdXlrek5qWE9wNmVjbDNoM3lZVzdzUEJZRVd4OW5ZTytE?=
 =?utf-8?B?SldvS2hVTTVpT2I0K2FiQXVQb2dJeDhrMFNneUlFUG8ybmtFeUtuY01CZW5s?=
 =?utf-8?B?UnJvN2lEWWhPYTBWRXdBS0RveVhtVXNBeHUrRkk2aWFpZDZ6ZUFIMCt5cnd2?=
 =?utf-8?B?eE9zaTBtNXB5SklDQ01yeGRBN25COUxwRXFneHRUSllpVElpaWQ2T2ZNNnRq?=
 =?utf-8?B?T25qVWlldytFNWs4WWJOTmFENmloYnpIdVo1R1pZWFNvTmlGWDFvNnFSSmhv?=
 =?utf-8?B?M2hzakxCalE2YXA4OC9jYW5jWk9nVDllYkk5OFdBRG1CcmFLR0JpN2kvNWow?=
 =?utf-8?B?ZVoxS2paMW5JMkNYNXA1dkZseitjWjdRMW5xZjhybzVUTnlSZ0txWUw0Z2t3?=
 =?utf-8?B?MXpoM2dTeDkxSmF5MmZZMHRyblNzZE1DRldxZTZqZ3V3WjdjVytOVFlsR0Rh?=
 =?utf-8?B?bllxR2tic1F3Y1dKZ0NVQUM0UmRsZHB4cDBBZi8wZkV6SlNYa1JEQWp4S3Yr?=
 =?utf-8?B?eW01UjdaVmN2NnlqRVZTQmJFOGJlRzNqanBtZFNydHdkOUh6M20zWitBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c714a9c-cca9-48ca-2acc-08de3ba2cb00
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:25:51.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7936

On 12/15/25 13:31, Christoph Hellwig wrote:
> On Sat, Dec 13, 2025 at 09:45:46PM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> The state check of zlo->state in zloop_queue_rq() fails to guarantee
>> atomicity. This patch changes zlo->state to an atomic_t type variable,
>> avoiding the use of the zloop_ctl_mutex lock for protection.
> 
> Err, no.  atomic_t for states is rarely a good idea.  And unless I'm
> missing something this state check is just an optimization, so a
> data_race() should be enough.  Either way this should probably first
> be done and discussed for the loop code that has a lot more reviewers
> and then ported to zloop.
> 

Got it. I’ll send out the patch shortly.

Thanks
Yongpeng,

Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013079.outbound.protection.outlook.com [52.103.74.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC206227B95
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790765; cv=fail; b=jLLa/QxNl+NAl68CP2gJGznnBdAG9swGEaiNMmDEQ7Gj6QCT9TkYJS7YGB2QQ+mbxtVrrHjdB7NWkqZCcgpyxlkrlS8ZWhB9WXmWjn4yyEcHyGDq3e7unC7YRvQS6nHs49p7go3KCFGWhWFrPIFBkSCgrz9p6gKnFpwII5tJedY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790765; c=relaxed/simple;
	bh=Akmw+M31Fjkg8w2SMkCjYpHXU1YWqUsd0OVv2nI+s8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bAt80oodBXarusnzfxulupPP8PHt3OhE73YaMF7uTl9oindJdVcJbbWenZdGDTDX7B9xFdHBcj3Fc/1wqJ3mT0CLdAWmZTJrzOq2boawqESBkFmU9EtuPm0YPJ6IdLXNAVp9zutcinxDvpjeRqqtNpyzZc1kf29PIqBKIAZOKN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YhNlqs4Y; arc=fail smtp.client-ip=52.103.74.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YhNlqs4Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxR0QY0+1HrhYRT+u+ShfWpblNMeuNi/VW1sSxL2RyKSiNZQvN0i4KViRUAar09rTLyHigEn92Ie8ADps/rfwlWajrh9fkb8nITdQycfgn+klmHPzsiVp56eOWV2TJP3zMY4IZVdtY2WfUMQ7mvEiyGtyTMlBzfTWuY90G7AzkTls6RMTdFq2KWcjtq7FkbFtRYNwBC280+cizNTnfiLMp+KN2vjiyLOuRjnIGnI6LEzHpmAYdfkEk0YAedMLjolSp6XTcURohwTJVG9fjrrJiXb73NLVIOzP2HvM4/LRLum+o+9fgvUDn8URYttxeDKncZ6SJPmUGnSt/hlepDD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkEme+L7K/tuccHb85tr8++7oeGtorSUe1ym5STax0Y=;
 b=FmafcalCJUA8aVVFDoHOfrh+1hGs4DPu1z0BXYG4ytYBRhopHicsV5MrxQyvNYvJosp+A8vT9GUw/49cgIrZ990YcxdUZoo4R3JPpXaIkDerljMnpeEBaM8nVDUlweBmKSAeA1F+oGQhbvXPkFb3DjbVND6+MCy1GKJ6Z1eJNAy2+FW9M5bEd1Nmk3VbKnlVcDOv4lAdnW+QmVny/r3VP1OwFoKYGfivZZtH4TfbxYfps8QM3zYYJTEdBEmu6XFW1vMM4IGvj+NH3DVcDfWmCEr0oxEWHj/l7u2wLU7BaxpiuUa4uH4iU52nTxOkn++sOGAgy2U59iErgbmV8LmUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkEme+L7K/tuccHb85tr8++7oeGtorSUe1ym5STax0Y=;
 b=YhNlqs4Y/HMJMbsKVef9BPiUlszA0Ct9MSg3ZJLUuTYO9aBv1ibKCcI3HWXnSrWUrG9/U56YiChaKU4v3wHzBse5rsM9Zi7Wf0vVHYSCY7OvuafxgNvYiqwwqrQF08zIi7ePkFh+bAdfnuWQYgMuVX+l0o/uPRwe8fhZSqHQmOEmLR0+Mk4LcJCMkbdjLPkz8/phdDM7ktVsE8UUVxSf3ZQ40g0Rj3LMYtmS/13tFmG1e+OxQ3tQ39MkqsHfTQezhYqvmzhGtjaFnfK7BqpXovVYPac9HMAmbhS5Stc0FxSFNUEgYPTXAKUzwXJvoRuUTd/y19KhOIKrCj2ujmlEFw==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by TYZPR02MB6877.apcprd02.prod.outlook.com (2603:1096:405:28::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:25:59 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:25:58 +0000
Message-ID:
 <SEZPR02MB5520CC8A6B2748D4934D16E199ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Mon, 15 Dec 2025 17:25:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] loop: use READ_ONCE() to read lo->lo_state without
 locking
To: Damien Le Moal <dlemoal@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
 <867d692f-a0fe-4e6e-b635-66dead923535@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <867d692f-a0fe-4e6e-b635-66dead923535@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To SEZPR02MB5520.apcprd02.prod.outlook.com
 (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <ab23af76-3de0-49d9-afcd-f382f4185c77@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|TYZPR02MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: a549da06-66b3-4686-10bd-08de3bbbf47c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|15080799012|19110799012|41001999006|23021999003|51005399006|9112599006|5072599009|6090799003|3430499032|3420499032|40105399003|3412199025|440099028|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0NMcWowR1Z4TERpNStlSGd6ZnhXY2FwU2ozbSsveXI1ak5RTEJORk8yUXRi?=
 =?utf-8?B?c3V2OUlXUU5XWGt2U0pDYjhBRkFwNHpYWkZRdS9zY1k1R3Jrc1pnSHI1dHpM?=
 =?utf-8?B?OEltUko4QUZ1UWlyeVVSbmtWdEZtNHJyc0MwTW4relk2VnR6RzBsNC80WkZX?=
 =?utf-8?B?aGFPRzZoZlE5dk14Slo2VGR0LzFIV0g2RWVDU3lZMkdsa1RHUHBXODIxMHRU?=
 =?utf-8?B?MXplajduZHpheGJqOFNtdGVCa1NMUWdKY0JURjdLcmlVaFBjTC8rVW9hY1lu?=
 =?utf-8?B?OWpWakgxOXF0S0ZCQTFLcm80Yms1QUorZlhVZ3I0U1RCb2RDVGwwY21XRVd0?=
 =?utf-8?B?cHZCYmEzM0l4cmpyY1NaZnRWWGxtRFBOcWMvMVFvbGpGQm5CTk5DbFhta0NT?=
 =?utf-8?B?QUt5Z1pLSS9FWXR2amIwbmdWbWh6MUxGNE9xLzhPVGFuenF2dEtZMHlPM3ZU?=
 =?utf-8?B?cm5YSDZOckhlKzZMcDdpUGk5SnoydWhKdGJUOFpSZHVCbTRQUVVraFcyNXIv?=
 =?utf-8?B?REhsL1hrU3ZuVGduNE5PMDhlS3NNTW50TzBMdjV0UUFMeWV1NGJQSVFJTVBH?=
 =?utf-8?B?dVplWEhqclR4R0FZbjg5eXo0SEhLaEc1Mm5JZ2hJVWduc3BtMDhVWjl4QWxn?=
 =?utf-8?B?VStucGJySjNxckJxOGUxSjYrcFVOUE9hTFd3dG9mMzI0WlVBTTQ0VnhqY3NI?=
 =?utf-8?B?SEtnZGdZZ21XS1RLa0l3M3oxaWVSVGxBV0VsSDJxMVZJMFZRZGNoZDRaSXJo?=
 =?utf-8?B?b0pPU1JwZ2FUb0RyVEtvaGdNSnlJMEg5ZlRndi9yOUlIaFVrZGpUZy9KSHBq?=
 =?utf-8?B?SlBxVUloUXZMelFxQWVubzlaYlA4NVFGa05aMHZ3aUkwb04yN1N5RGtoRnhU?=
 =?utf-8?B?OHh0bk9MU3hoQUNDWmV0dXQ1ME1NdmJvayt1bnJPbDVMUFF6MmxFRHJqWjQ0?=
 =?utf-8?B?Mm95TGxlTHpLUDNTazlzOWxWY1o5STdxTlc5bWZDWlVUWElkdlJ6ZVhPSEdQ?=
 =?utf-8?B?MEx6YlZKYjkzdzFUcVZ0OHJLbGt6eURNYWh0OCt5S2VUMUFGa0dzZjhJRzVt?=
 =?utf-8?B?cVNRdWo5My80SnVlMHkzOXRQQkNPOXF0UTM1V2plNDkvZkxyeU9zaGFQZG1G?=
 =?utf-8?B?eExvbXRlcEhuL3ZCN0dxQkxBSjFqbWc1eDlVbEF1U0UvazA0Z2R2Vnp5YzVK?=
 =?utf-8?B?YkJ1NVA5WTdMb1Rka2NEZVJ3MlVKdVZjY3BoZjI3TGFoMHZNKzRBOUlvL25L?=
 =?utf-8?B?Q0s0TGZubFJZWUdMUkJxbTBUbnVCL0cwZFJveiswWHJCQXJuTHNuOEJGS1FR?=
 =?utf-8?B?UG41N0FLbXA1dnJ0dW1VMVgxTXY5NCtvRFF3K0VCU29OUHZmWDc3eGp2aWNz?=
 =?utf-8?B?N0taUldoTmFra3BWUkxyRDNHbnU2cy93TWR2WEhHd2xaTXdHayt3S0JuZ1Q0?=
 =?utf-8?B?S0NjbWM2cncvK00zNDF4TlNkRHVzV2dtcXNRRkJwaFlmMml3SnNNOGtZbDJD?=
 =?utf-8?B?QkpFaVNmMGdWdFV1R0JZQzkrOEJZQzh3T29HOXdxRUduSWZXbFJCQzhQdkVQ?=
 =?utf-8?B?QlBxL2hVbmhWb3J2bzlDV0xHL05RWWw0TUxCZjNmV05SYlJONUo1QlRDeVRz?=
 =?utf-8?B?Znc4L0ZkeXNiR3U0VlpDTU94dDRxRmNRRVh4SW5VMEJmbE1Yd0tPMU93OEFj?=
 =?utf-8?B?TVZCeFdSQlphZ3lEOERPcHhhSXVkY2d6T2k5QkxuUi9FK2JYU0t1K1ZFMXFp?=
 =?utf-8?B?RVZwVmRsT3VDNWhxZmxqR3YwSVZKbEpwbnFuSFAyTERkeklVVExkMW5sMnZi?=
 =?utf-8?B?STI3V2JaUFRlR0pWVGpSdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3dDM1ZYZVNLRWZtUFJ5NU1Ra0pQQ3VmQWE4a1ppbVYzcW5oL0xxUWtBeW5F?=
 =?utf-8?B?azJPMEkzaTVibUd0cVp3Y1hJL3ZoUzJFUHhmaldBQ2MxaWIwdHliNlpQWk1G?=
 =?utf-8?B?R210bk9DZTVXYWdkcng0VjhrcFBvankvWlAwWWR4VnNsN01zUkRBOWsyZ0Vp?=
 =?utf-8?B?dm8xUHN3NGhqMjlvenI0WWMzQ1NDY3MvNnRCd2UxNTJDdUg5NWxLa083dVMz?=
 =?utf-8?B?M0grL01ab2NqRVdydWVwR09WNU11WTZnNTlsRXRNY2ZrdmJSSE1seUI4TnVu?=
 =?utf-8?B?ZWtMUWhYeDkrdStMcEwrdThmTVFsNW92eEthOHZJN3VBdWJwbTNaSU0xeXFZ?=
 =?utf-8?B?b3FxTlFpZFVKQytLS3pTQ2NFclVuTytkRTN3aDZ0S2ZYR2g2VXhma3pXMU9V?=
 =?utf-8?B?ZzFqVWlzZTdtRlgwbjNhRng2MjRZYTRoUXdkRW9OKytGQVdvZHNjTmd0Uk1W?=
 =?utf-8?B?KzI2VTlHdGUwSkVjK2xKMnBDa285M09YVTV1SEFvRlVYN1dPQkc4VWV1RUx3?=
 =?utf-8?B?NGZjc0ZtNDhESHdIV1lLSWhHUHRXd0Q5aDNzSUhKb25oVlo5NGVFNWh2VU1m?=
 =?utf-8?B?VVd3bnpsWGtiQlNGSGpSOXMwc1haTWQ2OHBhRWp4bVZHamFBS1AwaW9icE5M?=
 =?utf-8?B?dFFac0dyZm5hcVhlc0tWeGRISGs3RkZmSFJNRndTVitzWjVGT2RHOGJpRm5j?=
 =?utf-8?B?aXZieUhocXFIQk9PdGlZYXhHb29RazFOUXozZlBGT3lXNXRab3dqZlJhTjRq?=
 =?utf-8?B?cXhCU0ZFc3FZbXIyMHhLR2MzL0tDQmhTeVZSbW4wYXkyM2RpNWk3cnNYQVlR?=
 =?utf-8?B?clBJZHRPNHBkcEgrMnRLbDlBeFZWVDR2YXFHS2dJUy9zZEhpVU9HM1ZZZzNm?=
 =?utf-8?B?LzZFYjFNYkJTRjh6SU1LcHRqU2xrcnNKWU1VZ1RMSEZCRnB4TmwyZmVnNUo5?=
 =?utf-8?B?RUJINzlzUzBjdXFZSENHM1h3K2djdy9xOG12eEFOakg4TGV3MUJxNExSZUtV?=
 =?utf-8?B?K0w2bkhKQms0Zng0ejZtRGF6Nk1XRFB6S3dKNGI1R0U0UnhpUHhhK2ZKUVVh?=
 =?utf-8?B?UExremNHZmJEZXIvaXNvblppZ0wzQ2FiWFRFK0V6WVlsbWlsOThLMVhrS3hh?=
 =?utf-8?B?VnJiaTRjWHRmTnd3dy95RlJjNmVmcUNvRm9hYWJjZkNFMWxLSWFWK1FNZ1Fp?=
 =?utf-8?B?bzZLNWJheXFyK3ZLeUxHM3V2Q0xPaCtOQklBWnU2dGQ1NmZTV01BeHh0UnJn?=
 =?utf-8?B?c25OMzJ6U1djTHl3UVRGekhXQ2paVmpPeFB0VHMxOXMyQ1R1a1p4NTErcGo5?=
 =?utf-8?B?c0Z0M0pTU0tRU1BKVnBRYUY5bll1dy9ldUN5ZmNPRGxLUnM4dHMxbTRJZEZZ?=
 =?utf-8?B?RXprRzgxWVNmRzJuMTBQWm10VTI0NUg3Y1NvemlJc01ncm82dzIrZTU1VGhZ?=
 =?utf-8?B?cklCT3E3ejQ4aU9MZ0EwT1ljWWpTOGJrUmVzd0Q0eFNyQ0dPWEdPYm1RODd6?=
 =?utf-8?B?Y05uYW5Yd1lWMkR1RmUzTmZpVFlVU3RDMFVsamZnSjJvK2RHc28zZFphUENI?=
 =?utf-8?B?MnBvVEh3aWp6TlBjMFZscE80NmZDNFZlVFQ0SFV5MUFIM2NlSkhObVVVYnht?=
 =?utf-8?B?dDNoYjJQdFdxeWJKMVhEWnc2eUVybTdpOVBrWkZSTDlvYkdnQ2NiaGdEWDZ2?=
 =?utf-8?B?UlZnMlppZmtTbnh0TWdUQmIzQ3BHVHJMV1ROdHVhS2tUM1FBekRBVHdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a549da06-66b3-4686-10bd-08de3bbbf47c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:25:58.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6877

On 12/15/25 17:03, Damien Le Moal wrote:
> On 12/15/25 17:55, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> When lo->lo_mutex is not held, direct access may read stale data. This
>> patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
>> code checkers.
>>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>> v2:
>> - Use READ_ONCE() instead of converting lo_state to atomic_t type.
>> ---
>>  drivers/block/loop.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 272bc608e528..f245715f5a90 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1858,7 +1858,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  
>>  	blk_mq_start_request(rq);
>>  
>> -	if (lo->lo_state != Lo_bound)
>> +	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
> 
> READ_ONCE() without a corresponding WRITE_ONCE() does not make much sense. You
> need to use WRITE_ONCE() wherever the device state is updated under the mutex lock.
> 

OK, I'll fix this in v3.

Thanks
Yongpeng,

>>  		return BLK_STS_IOERR;
>>  
>>  	switch (req_op(rq)) {
>> @@ -2198,7 +2198,7 @@ static int loop_control_get_free(int idx)
>>  		return ret;
>>  	idr_for_each_entry(&loop_index_idr, lo, id) {
>>  		/* Hitting a race results in creating a new loop device which is harmless. */
>> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
>> +		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
>>  			goto found;
>>  	}
>>  	mutex_unlock(&loop_ctl_mutex);
> 
> 


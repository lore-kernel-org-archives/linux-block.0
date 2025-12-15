Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012054.outbound.protection.outlook.com [52.103.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021051DEFE9
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786791; cv=fail; b=MkUHoO0stjUFL23BXWNQVBWP+ujOIDIe9IKUg+ZE5Btsuu7cfVO+PjLVHRbNFsdtJBb71od5l9rGvUVblWdwya/ZQ6Pcpe20Ri9rtW7Dz3SXkex4y5r5CPRfKZwjUlZj6XLiFAVcqddyHQN+NbVRHl1dvcfeJ6BcnYXApxgx4HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786791; c=relaxed/simple;
	bh=FOclS7lpJTUVpgQURh8/1yynZ/um5m9/gMxe/B4L3X8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnXb6y4WkMqtDYVrl/qmoCAILLfryqlG1oPVaVt4qTliL4fGI1QOO5uawQmEk3mTH02beeUQSgxo3v+NRdpUtZvP9m+bKAFlcjs47GYj4oxIaYWxBxahidNU+g7YW/5nMXNpD40UTdfJwbPVcJhOnFbQQAU7WU7UQIiRy8wRq4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TGK8PlXg; arc=fail smtp.client-ip=52.103.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TGK8PlXg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV5xVoDt4J+rtPlqxpmm/AzDo+Mr+DXvp5j9cE7b+3vLTd9ix8+4XTtGwf73ALbZt3KcuJ7HhA0PiO0p3FZ5M+/eGRFshAWalePH7DNKaC37SGB1gfkBMs0+D1n89QHXP/FcXYlp9LoJO/EAeQhQzqgcntI5zy/QP55MwJklHvVxEytN/gJIG8y2jOHJwRM10IgWWSdptuMcACjU6CPWrOTS2pRmTv09mGHYgfOoRrisRGSmdG4qWlQfKvEsSTTKHuXPw9IyCbYT6EbJC38JLVXi9xoprfeAydEwIJHLQoFKJuGt40NeZZ+yaXM4swQg5NKAoFsc8Dou0gJDqALYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2/78H79s7qP47uINF0pjrtWWMd5PsbYMj1dQwxXO0=;
 b=lE+8U031vLgcwKVh88Ltw+L1qQtENY5h1Joot4w0m4UAcyICYAWapVT0+SmgfpPfBUsZYEFRdTBER9Z2iiZuCKf/+Hmo3OQkd5tCfngYfSPrph5KAolDaNKrL31NJC2lXkp4EF3abh3r28qu1H6e0nsZGNxlNB3QGfLF1Ch9EAYvajUYcoKAVrRoKXcWSnRg8sdQXY8/lE7NdiPqOmFFKX11VYGdcI5KS4qqrykFST6RQcdt/KzTgdj0ZwLFHzsqgFaSoz0Wo1sKOFXOxrXLmP1DYNrIkuBAjn5OFddf0puriftDfO5KzFiz6qL2KnkwwmIzfM+tY7mPIXlTTud2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q2/78H79s7qP47uINF0pjrtWWMd5PsbYMj1dQwxXO0=;
 b=TGK8PlXg9nndTvCd4MddSEHHdO9wvFxASpEcJf3Vm7p1mtsk9/L8bBVVaTD8e5h7WAdb2az7CSBFuLlynJowIKCmoXaRfPh8QusXFBxfpQcosWwyeuQrClxX3Q4x1qXGs5YvrsDE6Gcsw+v26X7ba0Vk/FH+O7rrklCOl1fSm4aRiLThqWFrbnZx0jahTj8A7jno/YnAj/NITfRoNy0TavTqhTf3L8Xi6ujxdk4BxNH3qCb5fGUd+qdxkTZ59gLEqd2JhBaQx7mDZLhjFmkKL4BSFxfH7OlsrGRKvKpVUMhWpQWZlqHE+qfpnE4tnDqRKse1wjW6JDhDLHfyUMv/DA==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by SEZPR02MB7136.apcprd02.prod.outlook.com (2603:1096:101:194::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:19:46 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:19:45 +0000
Message-ID:
 <SEZPR02MB55200F0F34A7EA6CCCB2418099ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Mon, 15 Dec 2025 16:19:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] loop: convert lo_state to atomic_t type to ensure
 atomic state checks in queue_rq path
To: Damien Le Moal <dlemoal@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
 <66ae3b25-7d82-445c-b125-bc017d299c85@kernel.org>
 <SEZPR02MB55202AF5E15D574D7E157A9799ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
 <caa412f0-b4f4-4269-a584-288ad3fbbe3e@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <caa412f0-b4f4-4269-a584-288ad3fbbe3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To SEZPR02MB5520.apcprd02.prod.outlook.com
 (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <90763cfb-7eb0-42f8-8ce7-caffd65e80af@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|SEZPR02MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: b8884e28-377b-4ba7-c886-08de3bb2b483
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|9112599006|15080799012|12121999013|23021999003|461199028|19110799012|51005399006|5072599009|8060799015|6090799003|40105399003|440099028|3412199025|3430499032|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEFjVzVEZEVHYmthS1RFQlh5Umxzb0FBOW9seGxjWW5tbmpnYklwaEhTOElZ?=
 =?utf-8?B?Y3ZTNUtiS1BSNUhzWEE4dStkc2xsSGdQTUhNY3phSG5MSWt0aHd6WmJ1cGE3?=
 =?utf-8?B?L0IrRDJxTHhzc2MvL2dBTzVtdGNMcWdxZDl6WWhQVXVMd0ZUd0lqdzB6cVNP?=
 =?utf-8?B?VFlDdmNwRWtXRVIyZ1V2K0Q5SjcyWDd0em1IbmVPc0VXSWl1RHVUSHJtV1R2?=
 =?utf-8?B?ZThxWmdoVzY3VTJpWCtQejh6djRsQm9ZOFM3V0t4cklEakZhYXFXVUE3UTFq?=
 =?utf-8?B?YWhZVmtXc3BGTkRDd0tMK3k4dERoRGFOOGVTNU1uTUFPbyt2RWt2RExmTTh6?=
 =?utf-8?B?SUdjekY3WlVtaEMxWHByK0gvUjROWE1VTDJMeFdaWDRtdEQ4cS85bEtnbkUx?=
 =?utf-8?B?cUFscjQ4UUR4MUlnU0ZEeVZzLzQvOUIxTWNCeFBna00vblR1VGwxN0JKWXV4?=
 =?utf-8?B?NTh3N2ZCVXJKL3lueWNnVitMblNyRUVOQWtSbTQzTWhhVXpYNE45dm1DWU4y?=
 =?utf-8?B?RHpvemRIakVmZk5ZcE1aMVJ6cW5jWkpLWnRDamQ0V0xQQjlBRWhEQ3A5TmlR?=
 =?utf-8?B?em0rTG80TDZpQUM5M21JcXU4QStWakZiK1gyVDNUallBL2FiVmI5YWxOQkZI?=
 =?utf-8?B?d3hqU3J1NUd2c2VrbTNucnVWMG15RWp4Ykp3N0MyOVgzb2tESVdRT0xzMGNH?=
 =?utf-8?B?d0VFV01ZUmdWdVVDVGt3amdmYlowYUlLK1BUU2hiZXd2Szh0NjdjU3VML2ho?=
 =?utf-8?B?WWF2Q0I1clFOc1JySFFKaTBxNVVRbjNJa2F2RHcyTUFrTW4zQWZ6M0g5YWRB?=
 =?utf-8?B?TUViTDVTcFl4elNpdkFIRVJpOWhGMWJSSDR3bDJvOUx2ZDZkMTQxT3d1bWxC?=
 =?utf-8?B?bVBhV0dnZHZlM1dDMVh3SDBOc0tMVkpBczRzY2pSanFSWkh5dUZYMXpCTTd2?=
 =?utf-8?B?OEtxcEpTdHdKVWpWQXJsMDVhZlFrdDlhMTM4dWR3MjRTdHNQQlN3cTdOa0I4?=
 =?utf-8?B?Nk5oY2I2eFRURW84bGRRZUZHQjB6b0hxRG4waFlXSTZmSmNSRXNwTnZRTm1T?=
 =?utf-8?B?Zjk0dk4xYlF2dlN1SnI4d0NuOG1NS0ZDc2pSRUZVdittMENEMm9CblN1K2xq?=
 =?utf-8?B?VnJleGdrd2gwQm1IN05ZS0tITFhXTzhIZFM0ZmxkL3VpbGlKMjl2Y3FrYXVV?=
 =?utf-8?B?ZzdURzM5K0RYdDRNTUNwbkJSMm1sM0lWZ3ZTUysvbzlMKzdROThOR05WYmYr?=
 =?utf-8?B?dFhrMWNVeHRaYk9PNG9ZQjhkN0t6ekdhTld6WVJYUnZGZDlTTE0rdWYxb3pr?=
 =?utf-8?B?NjUvVVVKeTJlNVltQWV2QkFJNldOU3lyMkxucWVjTDhncTVXaUJkUWZQL0oy?=
 =?utf-8?B?ZjgzajYzYTNXNFV2MnNaWFVNMitwMG5RZWxzRFhWenpxQUsrNFc4R1pjUnNP?=
 =?utf-8?B?ckFSdWpkZkN6Lzh1QnNCTjE2amF0MU54NCtXbGtLTlNqWDBZS0pzM3QxakpC?=
 =?utf-8?B?dklSeGVtcHBhUTVUVmpsNEZOdi9NZ2k4dDA3RFc4SXYxQVNUYzk5aXlBNk83?=
 =?utf-8?B?Q3hCazRiSGhtTTRiRFNrRlhWNmROQUpoTE50djVGSmJuN2VVMzZId0JFZkpi?=
 =?utf-8?B?NnR5dUM0R1NqeUJGbXVWVFh6a0lXcGNEL0RWV2ZzdnBaU3JmU2lmQ1A2Z29v?=
 =?utf-8?B?OVVBUVhuTXJZZEtBdERzbnVzSTRVcmtxS1FobEtrUmlJM0FBOGs5aW8rL3oz?=
 =?utf-8?Q?KSqbTKDCDPtJS7XEPY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3dQTE1tNG1XZW5CU3ljUktaT05jdG5uRS81bDNtYnpqQlNUMC9ZUm1Yb1lZ?=
 =?utf-8?B?OWdYeW13TGh0bTRveUhDdVdqTmdEVGtXdlRWdWRYaTZDZjBKdlg1LzUva1RS?=
 =?utf-8?B?MTA1anR2bGVYc2IwMG5PVllZN3cxc0N5bVhkeU83OWx6Z2tvSlVnbksxV21r?=
 =?utf-8?B?YnVIL3cveUMzdkViTDBxSGFUWVU1VmZsTWcyTit5Zm1yNytRbm5YbEh1bWx4?=
 =?utf-8?B?YlM0RjdGTDBGdXM5dUQvVWwyKy9jdUhlZ3lpd3lCMDZ3VGVaQkFEZjdqZTkz?=
 =?utf-8?B?dHBQc00rZTluK0N3bkdDRmtLSnRST25wNzc0T3llWk5vak1tckM2eTNCdEZC?=
 =?utf-8?B?OGJWNDFndlZOZjFyZ2tPdWRudUIrNHNjRFZwUmVETWkxdmdvQm8zYmlkUEh0?=
 =?utf-8?B?L3dSbElNdC9uTUJXZGlod2lEbkgrR1o4UXU2WDMxU2VKeVFqOThLWUJuMWdX?=
 =?utf-8?B?VHR5VUdwRk1pTWQ2OW5teWdodlpIWEF5dytBa3pmY2xqUy9nVTc4VUFGMGc5?=
 =?utf-8?B?N2owSVpHanVRdzJiVDluL3V6blladVQ3M2lkREdRRlN6Ym9UZGNoNFNkNzdR?=
 =?utf-8?B?NElMcUJSUXhIb0tnc0ozMm9uNkgxZjJTUDlramtlYnVBcGFMTkpOVWR0VTZu?=
 =?utf-8?B?VkdVOEFiOTAxWmh4ODNoQk5yYVloOVVZaFZnQm1ISjlxZ3FTZ1gzUmQ2Q25t?=
 =?utf-8?B?YXBpTW1GRjRHanZCcXNYYjZnYVVrNjRkeGRzS0tiZEJrdEQwQStrNmIxaFFo?=
 =?utf-8?B?NkZHOVZwZkFFUlcyais1VHhGSTluK0c5SzJ5dUlpRldjYnkyWlpRZ0NxT002?=
 =?utf-8?B?Y3FaV1M1Wnk0MmxYQUlnRkhsaE1xd1hTSjBjZjlPR1JOQTBJMitVSUtnVEpZ?=
 =?utf-8?B?RjkyaStWMlZvUDdaalp1L2Y4M0NwNWlETndhcVQrelZ3K01pMlpkT0dHTVdU?=
 =?utf-8?B?TTg3NG93SHlyZlhad0RsU0thTnRDK21XZGlDbUdZeWhQaEJRemZoc1NXOUJw?=
 =?utf-8?B?ZTgzM2xla01rNUxIMnJqS0lCNk9NOUpRWUVMbjRPVEJqWW4rYmJueWhhOHV2?=
 =?utf-8?B?Wjc0R0YrVEpHVkI3OFNLZVpCRXZhWkRQb0FOc0xDWTRhZzVyV1h6OVVBQi9N?=
 =?utf-8?B?eTNTd1F2UEFHOVFGNWNXMmlhdG15emFnOFNhYXhmVDVNeTNmRXRYd3BBdjBt?=
 =?utf-8?B?dW9hZjVUSE9rd3J1NHl4S3MxQjVhMVd2N1FQMEt4RFV4YTZ6SjJwelE2Q25Y?=
 =?utf-8?B?bER5UGhjb1hyeDVXL0N2QWpYM05KZFY3QlVnQkt5UTFuc20wNDhta2ZwSnZW?=
 =?utf-8?B?MTFSRFNhU0Y2ZXVLNkoyQTBLN05Gd21FaHNBSUkwZzh2TmY3SlFGQXgvdzZm?=
 =?utf-8?B?RHNqWGZTWmtoK1FVRDhJU2llbUIvR0JWZk5JcktoelRhaDVyVWx2N2hrSUJG?=
 =?utf-8?B?ZjZUMWdQT05IYlNmYVltNWtSbnRGTHhqYWNNeU4yQ2NRajlUVFE4cjAwZzll?=
 =?utf-8?B?YkxLcHpzZ0sweG5sMnd3bmdUQzNJTjg3cmxSL29iUGZLd1ZpSWZmczBaVm82?=
 =?utf-8?B?c3Q1dmcyUnNDdStueUhUWUVFODAwdkdCa0NGeFVrZE5FZkZhU1l4NFVweXhl?=
 =?utf-8?B?SUJ1ZWcwN1FkUU5hZ3hDVVBiTExWUGY5ZVFURU9XdEU0MFlhQU5CajQ3a0Yr?=
 =?utf-8?B?WE1qeUV5KzVRRXQ4bXAyVkU3dTBXdWU3bE1FUCszOVIrM09ZVXRDTU5RPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8884e28-377b-4ba7-c886-08de3bb2b483
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:19:45.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7136

On 12/15/25 15:44, Damien Le Moal wrote:
> On 12/15/25 16:34, Yongpeng Yang wrote:
>>
>> On 12/15/25 15:12, Damien Le Moal wrote:
>>> On 12/15/25 15:54, Yongpeng Yang wrote:
>>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>
>>>> lo_state is currently defined as an int, which does not guarantee
>>>> atomicity for state checks. In the queue_rq path, ensuring correct state
>>>> checks requires holding lo->lo_mutex, which may increase I/O submission
>>>> latency. This patch converts lo_state to atomic_t type. The main changes
>>>> are:
>>>> 1. Updates to lo_state still require holding lo->lo_mutex, since the
>>>> state must be validated before modification, and the lock ensures that
>>>> no concurrent operation can change the state.
>>>> 2. Read-only accesses to lo_state no longer require holding lo->lo_mutex.
>>>>
>>>> This allows atomic state checks in the queue_rq fast path while avoiding
>>>> unnecessary locking overhead.
>>>
>>> Code like:
>>>
>>> if (loop_device_get_state(lo) != Lo_bound)
>>>
>>> is absolutely *not* atomic, since the state can change in between the atomic
>>> read and the comparison instruction. So this is not about atomicity, it is about
>>> not reading garbage from the state field if there is a load and a store
>>> concurrently executed on different CPUs (that happening depends on the CPU
>>> architecture though).
>>
>> Yes, I hadn’t considered that before.
>>
>>>
>>> As Christoph suggested, using "data_race()" may be enough to silence code
>>> checkers. Or use READ_ONCE() WRITE_ONCE() for the state.
>>
>> Considering the earlier point that the queue_rq check of lo->lo_state is
>> just an optimization, using READ_ONCE() seems more appropriate. As noted
>> in the comment for data_race(), for accesses without locking, would
>> data_race(READ_ONCE(lo->lo_state)) make more sense here?
> 
> Yes, I think it is OK.
> 
> 

I’ll send out the loop and zloop patches shortly.

Thanks
Yongpeng,

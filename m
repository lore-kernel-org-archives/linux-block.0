Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013078.outbound.protection.outlook.com [52.103.43.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4433ADA5
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811294; cv=fail; b=XNkQgoOcY3biT1znJNUWyHS207AOB2CYdv+nG2Xyy8fFDNlzW1dN1KaNzfdrqc1mED39yw529NkYW36+u0PPRPyo4NVTf6ubiQT/qWE0X1jRHsPsK65ZbwpDuDokPJkjdZEOS7TX2kJCldmG44ybAAV74uWvlWX5ACkEBQLTMro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811294; c=relaxed/simple;
	bh=AbAkVhPyORjOOCwFhv608XgY8ldetGRLgGQCd9tzYO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h86k2sBdEwgicYqZjL4fLz67R7orB0wLxSGw/jCRktveMzxJJ2mfKa1kWXrEH0zC0pb+nbP2k9jfytimUctm3eNCdKfJY6AhtQCxwrQ6LdZIofl07CyWjjKA0iArql60jQgX2qsMF8CTKtXVi4o5x2dPliU31+nZPTdvGPVY6yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YxNxNYKz; arc=fail smtp.client-ip=52.103.43.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YxNxNYKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZg1y824Td47tuAwq4PuzvMsOuXChDcHEIhFf5RNYY/rkuFBRShekD8hXLVboqmnt8xe8NVp0+1jHTTLMzwnOen03Fbz3vnwc6T5bX6pfk37FjXsuwuW2c4AEeXF3wQvMaYDjGTA5/1RxdG6cZIP+Qxk/LeZDD+87iDWsiUeykOy2U+P16H66j2SqVuSZA6iiuVtuILvCRkGAmuw/+TLAiVymI7lTkIZ1MK4c6sEZsIXdl9zG4AZUvsDOvLPzt+EI3K50A1x2HpVlHf1JcFMkZaple6EkvmzZa9EWn4uW+9JzAYvl5qtrGDiyGzJDFBwd8W2lu6dvrcZQvcOyXnjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8XIekLa2aaRgbl6mH7gRvGQxJ6acoHomTtHV8k7BY0=;
 b=QHsCf6fpfAkLc7fhSbnOH4a3+h2gmBKiNeI3FDya8h6bUph86MWK8QBCuDi7yBSrlN/FcdFu0iQ9PuDIHYTaE8QirV65xfpQjCyC62uKvR1p0EpLr5YPFYHnxghb9uC9UwhWMFB4Pnv0B+UN+mRKII7f0lzny/mxf4y3q06FKs/VQetMXhjlajQhwgKW/SgcLKmZ//5JDqWf/FVb0Sur84rzE+ZhdWO0dwL5obtTPo1jErnDT9+B1l+OV/UdmfmKSrWz7O7nuuVncrTy077BmxXbcmv8QUZeVb8isJXZJnxd0L1THa32wEpbgVxP7D0Mqe64gAe46Csc8AxeESUkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8XIekLa2aaRgbl6mH7gRvGQxJ6acoHomTtHV8k7BY0=;
 b=YxNxNYKzBSXUnXeMLy+TTKY85XdvIkc0V3+9q5CYwB+ZIdc03s2jXioH+MRkmG4icdB8bntYyrlnNnBlEiJRRNzpRhxmEVAxJy8NVU+i2rFLpgxkY6K109fQCB4FdtI8glHv4/ypglaMXg13akSMKtCUXc5oSLMiRuYcvLfXpcf39bYY+d9EtquEiEks6UcxCcSGrzjFh7Cox5lPR93Nj5n2ofOFZQlAcqXDIsKwY/ccj2rJmVdJkoRUccBsnu5XhXUMswqI0r0qctdSwzswuf0WHHE2jUgO7ASA4loQflvXcwWl5hHS1U6IHNj/W47XybCr9oMXJrwEb/8hVqEooA==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by JH0PR02MB7404.apcprd02.prod.outlook.com (2603:1096:990:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:08:08 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:08:08 +0000
Message-ID:
 <SEZPR02MB5520C63DC0EA3FBE5BAD49E099ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Mon, 15 Dec 2025 23:07:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] loop: use READ_ONCE() to read lo->lo_state without
 locking
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
 <20251215143815.GA30633@lst.de>
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <20251215143815.GA30633@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0120.KORP216.PROD.OUTLOOK.COM (2603:1096:101::17)
 To SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <68a2684c-2e01-41c1-8ab6-925540d58c75@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|JH0PR02MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4570c5-7e6d-49d2-cab8-08de3bebc139
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|9112599006|461199028|5072599009|6090799003|51005399006|8060799015|19110799012|23021999003|3412199025|440099028|40105399003|3430499032|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THJlTlcyM0l6eUhlUEU1dW1lQy95QkdyS0RDWDJHZjhXWlg1cDcvNEJJVFla?=
 =?utf-8?B?eHVnK2FrcTVNZVlRU0pZeTZraXMyTVJSSi8ydDJhUlJmRklDQit3dS9BVkhM?=
 =?utf-8?B?QTZjWSs0aGY1dXYyRkhCVm5ERGtha3JjNnFTcEE5SnRVRmk5ZDFXTGZ4VUdj?=
 =?utf-8?B?Sk5KNWZsMDkwSnBMd2psWG9wZEFkMEFoekVwaXJkd0gyS3drREdUME1IU3gy?=
 =?utf-8?B?TWo0eUY5TXg0aDNSUGp2MEJZOW84bEdIdllwYi90Nkt4b2NLeGl4cHNMSWRp?=
 =?utf-8?B?cGtvTEFVWGxRbVVyOE5jYzhXNWJ3RXJOSnRJUTRMMGJ2a25objRUcGxFbWs4?=
 =?utf-8?B?anE4cnd0UDlKY2FQL3lNMWNLUWV2NUFBcXkxQUtOM2VITC9yZWprcVNyWWF5?=
 =?utf-8?B?RC9XNXMvSEl1MVhHZVdQSnY5MzUwTkdRQzVOVUN3VnVua0lyVHNML2U1VG5W?=
 =?utf-8?B?VWtCZ0tsbjV2eUV1RFhuZURXT01udTNhNnc4RVhDYVdqY0xCclg5Y1B6RHM5?=
 =?utf-8?B?UkhDaGQ0bktTZEs3RWtDY3Jla0E5SHMwZldhNEdnYmU1MGVWWEMxV2FJUWF0?=
 =?utf-8?B?dWdMQS8wOU41dUFxdDBNY1lkbnNteGlRK2puU1ovaXpWL3R5TUdyNHEzOXZt?=
 =?utf-8?B?QXRHNE44MHpZY1ZJUW5ud0EyV3ZhaW9JaUJrckszaXhwd3FPajVYUWRlMkFq?=
 =?utf-8?B?V3grcWVrdm5odDg2ZVVUK1JFcTh0VG5qazdmcDQybFo0SmUwZUh0c0MrdjM2?=
 =?utf-8?B?aWNVb0EvdVZjb1l2eE9McGh0ODlYZEVlb08wM3I4RVhhdjdQQzB5WkdGMWdh?=
 =?utf-8?B?K2d5ZFVBUjY3dG1PQXAzU09UWDJrOXpqaFREYWNJQi9KS21aSXdKeTY3Qi9Q?=
 =?utf-8?B?dzFHQkM1RC9jdGpnSHdONmRRR1loTjRpUmFnWkZTb080WGdmZTBBLzd2Mnla?=
 =?utf-8?B?NlNGMmlwOTJ4eHBETFpyb005S0lweG56Nm03eVN2V1hRdSsrc1Nmb3FFelRt?=
 =?utf-8?B?TGY4N2VaZHJmbTRPSnJLSjVaVTV1VSs5ejNTOHd6UGpYN0VWSHlQVkxaVXNR?=
 =?utf-8?B?dkc3NVdrVG4vMjF6YU8ySEFZYmZIY0pmSVdPRTBISzZiWis0RnlUdG1jbGRR?=
 =?utf-8?B?SHVVTCsxN3FRRE5CcnVFektFamc1bU1UWjljNUlkaWFzN0hqdFdvVkZ6MXV5?=
 =?utf-8?B?cXhMUkg1NjNxRkpOQU0rVEV5L1hyLzJUNzZjblZGL0JGaVAxVlZrSXFaTHNW?=
 =?utf-8?B?WEthQWlha0FZbytCSytNN2p5clpIUUhMTW9JWFBoc3Y2aGN5MXhKdFZGSzJk?=
 =?utf-8?B?SnFPOEpWQUw4OWR3TjJJQzFOVnhhU2hOeWgxa2xEbGxZTkpDNjJKUjR2bzl0?=
 =?utf-8?B?ODNDakN6RjBuWDhJR2dMSlZZUWowT2o5OTczbCsrcTlDVXRQeEtnUlZFNXNs?=
 =?utf-8?B?aEN3b04yYlk4cFVhV0V2bmZHYmh1MVpoRHBmV01DdW5ScGpWVkJTOHArQ29V?=
 =?utf-8?B?T0o5NjF0N2pnb0NMWVJxdmw1azJXdHhtOFJHVDNCWllvNFl0Qk0zVUpwMnRR?=
 =?utf-8?B?UHNxd1M5VkJNbmVFSW05VHk4ekhGeFlySEozeDJ5MkQ4SFluc01IQmNpTWU0?=
 =?utf-8?B?NTA5US9vb2IrQTlFUDBtRWpYZmlzSVkrZ1lHTzFZTEMvQ1dSb3ZJQnpYSVBa?=
 =?utf-8?B?dC8rdWpuL1JBUnBNemlCTzdmc3FoOE95VUNaTTJJRlE5WGhQQjg4b1hnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25WRGdCcmViUEZTdkFKN1RicVRjaG4xd0JYbjRHdnhqTzQvK3Q5Qk1sRUds?=
 =?utf-8?B?TDhwTlYvTnQrR2pOd0pkRVIzdnloQi90UTh5VFlTakJncVU0M050UXJYMnRM?=
 =?utf-8?B?RkZQTkx3MVBYNnBENWNVQVl3MW9BYitrdlgvM3ZkeVFySjltTWJURGliZmtB?=
 =?utf-8?B?YXBZSU95WEVhaUU5MkVPajIwOElQTkErVXpoZ0lLRzVSZU5yWXVOa1hsUkVp?=
 =?utf-8?B?NlJ0MFBuT2RDUzBzaTlwSUdRVUtLMEhDRURBODVyUnEveWZzVTNOUUJKTXl5?=
 =?utf-8?B?RXV0bG1zN1J6TUFGdlZ3ZVdDWUlWcm5QMWEwQTBxeHlPUEFuL2xqUUdxdnRV?=
 =?utf-8?B?QVlKcW1hN2dtWVpsTkttd0NlWVFlMllFemVKUGsvZmxQUk04QnY0YklockJt?=
 =?utf-8?B?QXFnb2l4SDVKMkJtdWZRU3hieXhsbTZWTFhKdGYvL3RuaHJNTzhWbVlscFl5?=
 =?utf-8?B?RFNqd3RGZTFqNCt5eC9JMlZrZS9jaENPVGtad011RDhjYWh1cWJkamlWZEtM?=
 =?utf-8?B?REtSWGVlNGp0MjFFRnA0VGdrZnBSYk8zT1hFOEFIbFFyZnFzSklxQUJtUVNT?=
 =?utf-8?B?endBQzczVWlUK2pTRVJ2bnU5QmhxTDhGTlYyNXNkaFZHVExNemNFbjNCamR1?=
 =?utf-8?B?OUExU0xRT0dna253SG5YYy9TbENhUEVYNlBsMlNaQTM0ZUZDdVBiOUdzWC9J?=
 =?utf-8?B?cDBRKy9HbEJXckxhSUdISDhYY0J2UnVXSUlpSVpuRnhCS1lVTU9FZGViVUZj?=
 =?utf-8?B?Umx1aUlpWXRHbVlVbVVRa1JKaVltM1pDU0xSSnRMWkkrR3V4d2hEQ3Flb2Q2?=
 =?utf-8?B?Z2R0SUxKU2JBRDVKRTQvUHNqYjBYNFhWdWxZR0FHVzUxSGU4bklVRGZXbGdw?=
 =?utf-8?B?SjNVL2VBSURYQ1hPZHhVUkE1N2hRYy9IQTZQVmc0OUNYWFRsei92Vkx6Vmgx?=
 =?utf-8?B?VWd6UklNYU0zbjlXaXBYUnZOWGFrRDJJbC82V1p5eFpvS2JDMUQ4L3AvRE54?=
 =?utf-8?B?VG51aFRGSHhDQU1JRU15WFhyN09ZV3JQOUdOMExlQUNxS1k4MnBlUjZVQ29Z?=
 =?utf-8?B?NE95YndXcHgxZ3NMalhRcy9jaTlrUXFQRlZwRVY3U3RiVzFmeXdNTUFuN0RG?=
 =?utf-8?B?NVBOVk5oTE44b3pwSGRDbWUydlltZjNzRmhud3pMQ3VJc3drM283SHlJTmpi?=
 =?utf-8?B?UGFCcER4cU1iYnlyVXZHZzNPNmtCL25VNnM4c2hESTFxZkVTbzJ1b0JaN3I2?=
 =?utf-8?B?TGxJUjlLYXh4MGhzc3BEaWZKYk5Ca2hTZU1mTnZoZUpIMENoUk94TFVDaXdv?=
 =?utf-8?B?Z3hray9hTkg4QTA2NHltQTU0SDNuODY2ZlpiekcrZEJQNm5pQUcvd2xRWTNS?=
 =?utf-8?B?WWliUEhXdHBHT3FEaW5DdEpzZEs3aXJpQnNwWDY4VkRjTWtkS2pEL1ZuVlZT?=
 =?utf-8?B?aE1OMko5YkExS3NIUGpmeHYxNEo2cldHZDdmc0dyTnd1NmVXRUtDc09CMVNh?=
 =?utf-8?B?aGdSTnJJQjQwZWZudjVrOXBXK1M5SXB6RGNmcndzdktIeUUrUzdVS2RnZ2di?=
 =?utf-8?B?Vk5BcVA4QVBBNWxoTEUyNWpPUW9zSUQ1blVIcTFmYnNzL1RHbVlUeUJSdTkv?=
 =?utf-8?B?ajV0WDlIaG5ib0xlUXcwTVFpenl3MWs0bWlhVUp3YlNCRktiOXJFNFJLNmJB?=
 =?utf-8?B?bzVlbklJOU01aVYyb2w1SkE1N3JGN1pGTnMvaitoOWJtY00wOFlzYWlrbHU3?=
 =?utf-8?B?OHZTUkw0MXhXTHZpdXAvcTk0bDNNLzd5TWVpTGJSL3hkYmNFYlRDVmxqUDlF?=
 =?utf-8?B?QXVWU3hyUXIrVktaUWMyUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4570c5-7e6d-49d2-cab8-08de3bebc139
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:08:08.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7404

On 12/15/25 10:38 PM, Christoph Hellwig wrote:
> On Mon, Dec 15, 2025 at 05:45:22PM +0800, Yongpeng Yang wrote:
>>   	idr_for_each_entry(&loop_index_idr, lo, id) {
>>   		/* Hitting a race results in creating a new loop device which is harmless. */
>> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
>> +		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
> 
> Please avoid the overly long line here (and maybe fix the one above).
> 

OK, I'll fix this in v4.

Thanks
Yongpeng,

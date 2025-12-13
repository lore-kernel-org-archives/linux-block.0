Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013083.outbound.protection.outlook.com [52.103.43.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D013C3F2
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633221; cv=fail; b=hZTy5E86Nx+R3vcFQy9bU61OwJhXeOXRQY5P9CCEBS/8bY/Rcns6w/HIKSTwOEiQnt53KvgxhROWhUeEbf1yfD7NAznktkpogck5Qaxq6a0PQWIi7UDks6aqePZOex9oKu2F9jOEttcYoSvnmCRP3FBcH9BlL6Yzzea1k8THuRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633221; c=relaxed/simple;
	bh=dWW8BZ4ylUklTVyn0eHsdNlTds7tGF5rOyV0nb5nFW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLovYvcmsffffTLsLOIWrKFBsG/Wos/KL1tX0E8qLp8ctn1Nn5cov0weYVybYtCNjVqrMgaOXn1Ddoa6mkuUzREwMhFXcZMdd9YmKLF+6f9ire1Jf517TPt1SomK7AF8VkiI1Y4Kb1GIzPj+Wq3FXtt/EmDCr8MCVp1utgJweNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QB3OQRGB; arc=fail smtp.client-ip=52.103.43.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QB3OQRGB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIEPoUY8evMcJ3CV7o5Bhe58C1Hb/nxQwVVE0qRYyq4q4NCNtWwG5tEG9HTABtlvUP+sXTjUv5YjkaAJDP+cMpmJVfsT3PeIwImqYhQNnbkAQCbFXJSt9Of+TRuAjp5tWDZZL0YFigZ6J54KnL72A8AaoZ4Drn2FNTLkJR2hOpM9FDBcH5mfKZHthY4WJufIl9rlt/3qGuREVqVtcYIwa6H7QfkvD5m7jZYmwIbeoI21UVG+Jw/WjGWCovkfnIiF7XWmgAtxvL/m2ZXueDWP4J2jQ89Oa+ghHp06QCt//OTtt7hlrZ+BP+UpkgviPaDDllw3AXyEWHCoFNIqH+qLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYiEUdeRIy8KhNqFZK0RwONYUbZUVj1rHdfWtfSZEqo=;
 b=oQK/ArGt/UrOSBh6OpTulHnvzUNNi8Q8ug29owsalBJhls2xr93UjsS0GcsIYRKo89UBf60AytWqxoNEpy0iRNHpfrAsfaxAPl+pKihZBoE8YAfWKBJtxwDgLtMLxWKmyEUFOCtjpf2tCMSaFgvU6HOOyVuR/668y2rUJSnKaqH0W1sByTK4nYfsHXs+aiKCcCNFXqZKe9f11IinRV4xPiNhzpO5xwPNy72PwxshczkFANWuzzpmQysrsgoY24jP3WgEuS267NJe0yj2mcM1dHcKk7w3Nm21WO+mh9sAJB7p19Z3MaQAIJS197wk6CyLsIxVgoRP8uJ1FNAjgU5ZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYiEUdeRIy8KhNqFZK0RwONYUbZUVj1rHdfWtfSZEqo=;
 b=QB3OQRGBZDlcJIVfuxh3eqFITyheqynGRx5FipAhzlKchAevlvGki2b+8py5eADZArE5Knu4X+B3QNEBJcDGPpvtBdF0JNNhlFcMfpVwOrS/Q2L7HwAZO8potRaqcS3tH+ETG8PIDrWXhcLQnXJyUeuSITtSgvuS6m9flf+PQ5K2yMIFsa56VBK+Eff3jBphNmJCsCVF6CyXdNE2o8Fwhz0/sCCsjroei5XdMa9F0Ewfmpx6m8RickOkGGq69Fj6N++OOdr/ZcE836/lQ/8Tun9EToIq/AAZeYhwo50VbEZORkhkQhZJ/z8w51p2zQeX3i0PvHD2LvI+RUj2775Scw==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by SEZPR02MB6435.apcprd02.prod.outlook.com (2603:1096:101:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sat, 13 Dec
 2025 13:40:16 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 13:40:16 +0000
Message-ID:
 <SEZPR02MB5520A617226DCCAA0770B49299AFA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Sat, 13 Dec 2025 21:40:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] zloop: protect state check with zloop_ctl_mutex
 locked in zloop_queue_rq
To: Damien Le Moal <dlemoal@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 yangyongpeng.storage@gmail.com
References: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
 <77d57ec3-134f-4667-b260-f8f5ca593339@kernel.dk>
 <JH0PR02MB86885D86B2A34028A160A0F099AFA@JH0PR02MB8688.apcprd02.prod.outlook.com>
 <2cc746e6-4a69-4f56-af99-5dc871fce0ad@kernel.org>
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <2cc746e6-4a69-4f56-af99-5dc871fce0ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0110.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::7) To SEZPR02MB5520.apcprd02.prod.outlook.com
 (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <cdd7339a-6b73-4ef3-87c4-3e3ae581f47d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|SEZPR02MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: a438950b-4cd3-42da-0def-08de3a4d2618
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|9112599006|15080799012|23021999003|12121999013|461199028|41001999006|19110799012|51005399006|8060799015|5072599009|6090799003|40105399003|440099028|3412199025|3420499032|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm8ya1gyeEV6TXR6ekNGN0o3Q1dsUWE3VmlZZHZXMlJzRkk1ZkZmQ3FMYVNx?=
 =?utf-8?B?cXRNZk9qcHNqeE1kVVNVV3VGcVpmTjNhcFFLYW1KSndzYnBmZ0xaNElPY091?=
 =?utf-8?B?RlNKSkNEMEt5ZmVCT214eVJjUGVCQzg2Nmo3MCtid25UMmNLWmYrbnVVYTQr?=
 =?utf-8?B?THVPTlFTV3NhOUJFVGU4QjRGK1NCK29IZzEyKzNwdHNMTkNkeDR3ei9RWm50?=
 =?utf-8?B?THU2UnBETlNvM09uQ2FVcHNsbmVsNE90MzUzQkp2cjBOdy9Pc0lTWDBabEhl?=
 =?utf-8?B?STVOcldlR3NRUkdCck51T1ZiUmtRY1NwWGlBTW9TNk83YXJYRDJNVUh4UmRz?=
 =?utf-8?B?SVloM3VLalUzTFZhRThUNTdvbXJwczk0OE1wREhlK25SRUpkNXpJTEVMVk1q?=
 =?utf-8?B?QmExdmxJYTBTNFRXdk5FdFgycytZeGlRSGRVQU9rSGI5Wmx6Vm0yeE0rbERK?=
 =?utf-8?B?SkJGNWo4d29GaXZMSnBxY1MvZUlBOUJobXo1dEhpQU9ZRTM3clZqWGJyYk91?=
 =?utf-8?B?MFdOZW9Jby9wajM0eXV6Rm1qNnh0dUxLek9aTnp6Zmc4c1pMTjRaMkVaNU8y?=
 =?utf-8?B?OXdDK1I3MzdLcDJuZ3JKMkxXTkV5cTBUQ2FtZjZTQlpheHgzQmNFOVdNcFZV?=
 =?utf-8?B?YW1jUUM2c0tnWlJ1WWlFcFIyT2pWT1gxWmFNbW1UTFpTbmhyQVN6UE0rc2dK?=
 =?utf-8?B?bWw2TldmcnVKVTRHQ1pGZi9XdGd1YjhxM3VSNVlXRjVFSHY0OTdmeFhhVzJY?=
 =?utf-8?B?NlZyR3NBY2VWcU1VUmJCank1ZS8yWDRGTGtLSnJOVnk0em4wOU5va3FQSGdr?=
 =?utf-8?B?ZjNYQmJ5bzJzbU0vOXQyd1lKMlRhTGVhWHVkbXZadEp1dUdFSEl6RUFkUm1G?=
 =?utf-8?B?R1lpdXZ2RW5tZjVhWFk4RzQxQlYwdWxaOE9ZVDlKTUNUSzBRbi9iV2VmdG94?=
 =?utf-8?B?bEFCKzQ3NUl4VUdOalBUN0JXZ2NEWTB6SjhSUkcyRGxHVFNGMjBKRk5kSExj?=
 =?utf-8?B?TDZIYVkwVWZrTmc5MHlaNERycXhOSEFWY2I2cFk1RVlSWU44dC9lVEllbnky?=
 =?utf-8?B?K01DeGoxK0lnakh3RUNYN3BsVjhUT2RhN1BzMFlRK3ZBd252WHlLQlVCQjRM?=
 =?utf-8?B?VFRwRWVCeHdORGZNeWJPUTduRlJVRkNrTGJxQ1RwWFhCY2ZlTWRRM2hqVGRk?=
 =?utf-8?B?VDBJSXJ0NnVIU0tYVU45RUdxUmJSTndGdnJlbW5XTTVkaXh4ZXRabEIzQ0N3?=
 =?utf-8?B?K0tXQVh3cEh6eU9mL2RHc1Q3MG9uOHd6eHJCdVMybjZZOWJDM3h1VVJ3T1Bw?=
 =?utf-8?B?RnljelNUTURVR01rbVd0WFNBVjM2N3dJQnRSbEZFNmxBSU1OdTVrVE5rc0Fw?=
 =?utf-8?B?d0JvQ3I0eGc4em5sRXEyYTFrSnVvVVg0eFZIeTRMK0ZsN0c5c1VtazE2NEVm?=
 =?utf-8?B?VTJ1YlVJUWNRTE83dEhSaUVTam9hZW51V0RUaWk0OE04aWYzdEZ5emJNNmhT?=
 =?utf-8?B?OFViK2x3OHZHSEdSY1VlL2JkNnZJQTBwb0Y3SWRkM0FmOXcrQnBGQmRBMG0x?=
 =?utf-8?B?VkxqR2VIOFdmNXZGOEx2cWswZ0JiTy9aT1Q2a3o2bmNsMTJ2VkhkWThYQXhj?=
 =?utf-8?B?K2xjd0ord1E5OHI2MHNibEJkNG1WSTVDVXF1R3cvdVcvVjFVUGx0VDUwaHdK?=
 =?utf-8?B?UDdIeXpFNUxlR3VhVFZBN01iRG9jclVtQnF5NFFRTm1BYlJqd1JYYjRkT3Rn?=
 =?utf-8?B?YkIxWlRDTGJGRWpkWnJKdm4yV2YrK0psYWpuYlJ5SjlJbHU0cUJpaWhDQ3Y2?=
 =?utf-8?B?ejg0QXI2dS9hUXFweFo1QT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWM4QUxINkVYRnpjU2Qvenorckg3TkMvUXQrU3pSUUt3bHJVdzExUEFGV0Na?=
 =?utf-8?B?RW9Vc055VWRVeEo3Y1R5YmJNb0RJRmRhYVIyVkpqYnlJL3dCekFtNDd0ZWN2?=
 =?utf-8?B?SUgvZWFxMlVjenRmQUV1WjBWK3lWSm1KN01QdU1aNkpWVElqNVBxbVFvUWVh?=
 =?utf-8?B?RG0yOEowTk1vMVZ3SXhaT2FldmxDQkxJVVdPTnRLWXFEOEU3L3RJbDg1WkJp?=
 =?utf-8?B?YmNVWVJ6ZkUvYjEyWFFPRTJCeHBaNWNkRC8yMmpReTdCMHV4OXYvdFNpeVJO?=
 =?utf-8?B?K091a2dCOHJ6MGNiOGVFemVneGNJczZWZzl1YzJvUWtSYUJabmtJcGVOelFE?=
 =?utf-8?B?R2huUURnS0FNanBWNnJyeGEwMW1WY1kvbk9nckdTWGI0ZXUrUXhydm04dzJ6?=
 =?utf-8?B?TGdISTkzZklabktTTGZ4UFlROGp1aHBPbDRxeUQ4RXJCTDFHY2U3bHVRTnho?=
 =?utf-8?B?c1pyS05FWTZHZmFYdE9ZYzNMdVRkc2dTUzNoSTNCZWtQdHUyU3RUeStkczA5?=
 =?utf-8?B?dHdtZWs5R1gyc1NRSnpnYlp5dTI0bkhEMEFJOTF6MFREWVRmaEJLREJpaEtY?=
 =?utf-8?B?TlJvSC9YOVczRjhRNldQME9wZFY5czF1YUljZTNYWkY4UG1ITXRnck1acVVM?=
 =?utf-8?B?a3dkcFc2b2ZocExNNi9GKzdPcVkvbUJSallOdDRreHJGK0ZnM043aDBwVUh4?=
 =?utf-8?B?clRkS0ZwNjhTUTJEN0xxdTQwdnZVRmVrYm5VQWtEUFJrN3dFM2Y1S2lrOGwy?=
 =?utf-8?B?R0lZUUVqRUZ4bWVFUEhYblF2Z2VjRVVyYUVMNDRScWZpQ0NiMlpCUW13RWI5?=
 =?utf-8?B?VERXNFVvR3granNKUU9DK3hzdWV0V2prUzZxb3N0QXhjdWVMVWRmYk1nVmV4?=
 =?utf-8?B?QkRiNmdjTWNaYXNqbTY3cG1PUmNzZ0ZkWk1BMk92WkhiZ0JMd0cvaUR0eGx5?=
 =?utf-8?B?dUMwVFBUbVZUVVFyd001anp5QW9Wem1uWkRqdnhsS0FJSmE1Z2ZkWnBNYjJQ?=
 =?utf-8?B?VkRDTmMreVk1b2RrVTVHVmNPOUI3c1RZR1ArUS8yci9DNTNZbGdYaUMzNm4v?=
 =?utf-8?B?MmNWQnZ6Sm9MdW1WaFVYMEplZ2ptN1hoM0xqbGdyU3RqbUdRS2NCbUZMaUN0?=
 =?utf-8?B?Wk9LSUVPd25jUUVJcmJ1WjRvSHp4RG1Vdnh1NFRCaGRNdFJpWmNqQ0Z6VTBu?=
 =?utf-8?B?MHZzNC9Ja0xCdWRRNG1GL2c2anpNeFRLcXNWT3VXWTlla3E0Tlp1TWVFendo?=
 =?utf-8?B?TmV3Q2FqWGNyTXpMYXl5T3lxU2FUOU9iSWdNdzVzTUt6U041VFVYb2lwNERN?=
 =?utf-8?B?Z3JBNDFFWWZlaTBlTUVseU9aSkxSWVI3SlhIRnBVL3RHaWZQL3JHV0hhaERQ?=
 =?utf-8?B?QVRRbi9uWGtubDF6MDhySytrdWwyZGgxNGhWc09vYkhEM25DcWdPZzExUEFu?=
 =?utf-8?B?dVhOQVFvTWo1eFV1NTVnNlJ6cmNwelIxOWZjcWNEQ1JwVWYwcGVuVnZrd2FE?=
 =?utf-8?B?SjUwU1NYWVgxUi9BaExISzJrT0NSZjVHWjR4SE51MVMyZ3JpUUx4ZGRDVGRs?=
 =?utf-8?B?dVF4YXVvSjdyUFpGN3hQSE5DeXRMdHkrRWJseERoalJ0VGtyUVNhSGtYaHF0?=
 =?utf-8?B?aUZHS2hhUkIyYjV0QjNtWFVoUlE0bDhCaFYxNjFqVlV3L1NLTEorbE1lQWtx?=
 =?utf-8?B?engvTkoyd013VTdoelJEdEJpQnpvVkYvc1IxUE90V1BzLzhPRW00TWhoKzEy?=
 =?utf-8?B?SmdiaUVBL0tnaE1qLzNaRWVwb1dESkxCbzVNaG5jU3dERFcvNU1ERXYrNStu?=
 =?utf-8?B?SGMvRC9sSVNWNnlXSzMyZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a438950b-4cd3-42da-0def-08de3a4d2618
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 13:40:16.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6435

On 12/13/25 11:18 AM, Damien Le Moal wrote:
> On 2025/12/13 11:59, Yongpeng Yang wrote:
>> On 12/13/25 3:52 AM, Jens Axboe wrote:
>>> On 12/12/25 7:46 AM, Yongpeng Yang wrote:
>>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>
>>>> zlo->state is not an atomic variable, so checking
>>>> 'zlo->state == Zlo_deleting' must be done under zloop_ctl_mutex.
>>>>
>>>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>> ---
>>>>    drivers/block/zloop.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
>>>> index 77bd6081b244..0f29e419d8e9 100644
>>>> --- a/drivers/block/zloop.c
>>>> +++ b/drivers/block/zloop.c
>>>> @@ -697,9 +697,12 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>    	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>>>>    	struct zloop_device *zlo = rq->q->queuedata;
>>>>    
>>>> -	if (zlo->state == Zlo_deleting)
>>>> +	mutex_lock(&zloop_ctl_mutex);
>>>> +	if (zlo->state == Zlo_deleting) {
>>>> +		mutex_unlock(&zloop_ctl_mutex);
>>>>    		return BLK_STS_IOERR;
>>>> -
>>>> +	}
>>>> +	mutex_unlock(&zloop_ctl_mutex);
>>>
>>> Probably a better idea to make the state checking atomic, and avoid the
>>> mutex in the queue_rq path.
>>>
>>
>> It is more reasonable, I'll fix this in v2.
> 
> Either what Jens proposed, or move the check to zloop_handle_cmd(), since that
> is run in work item context, we can block there.

Yes, both approaches are fine. The zloop driver has only 3 states, using
an atomic variable seems more concise.

> 
> Of note, is that the loop driver does the same thing in loop_queue_rq(): the
> device state is checked without the loop device mutex held. So a similar fix
> there may also be nice to have.

Yes, the loop driver has a similar issue, and I will attempt to fix it
as well.

Thanks
Yongpeng,

> 
>>
>> Thanks
>> Yongpeng,
> 
> 


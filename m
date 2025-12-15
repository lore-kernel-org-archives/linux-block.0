Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013087.outbound.protection.outlook.com [52.103.74.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6F3314AC
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784081; cv=fail; b=oo8OG9SZsh9/xEcyX93wDi/vpigsBNnu/Ux8m4N73Vk1NQ/nBw4YGrsoBsgu0hqNcTtn2AxC9oJ7XjZV236jVjM7YHOVZ+YgnCcvARBrRrhD5EvhPjgyj2eSzCDVNAvql6NmLMYVcJXDIaaKl+Aea4wA0sSFE462nucwVBlJjN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784081; c=relaxed/simple;
	bh=nah29I/Mg6hTq6RgaS4jF/oXj5AAR9EndwDozxxh688=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxqeG/qUwJPf+pBiXi4TFHd6Ye813vWjF5opIU/tGTIEKTNlLq7wtdQCCRVV67zHqKo2dSvW8wi7Jff2wNePP3PRO2EL/rbC1fgXb4mDq5S+J1337+D4IfLwlWxQDur4/JDzrYMrXQkUa5XdoQdvHQA1poZTWKBWI3JKgqfNrcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kNZoGDvS; arc=fail smtp.client-ip=52.103.74.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kNZoGDvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+3+rJ56ZLany5pJJOXkDRoscpzUMTE2kDnKM9ZSkgHuoWaKS662l6TQph1mlcpkBVOO4ktOWOOR+s3TsJyZk74PpyoN17WLceXac5hbZXAI6W9vT0KhYuU39Bp9rAazwsRhPsoRc3HbKGGUR+Hxw7mLFmg6p/PfFfhEObiWAV1GKEMJN6Qs9JtALVbYn0zV+KjFmPTR/NpBD1f/2ZutXQFScOGzlA7++wMEZXXjukjZoMd8/uj5YiQlUtoKRCUX5IPCrn9T3aXDUkVMU0ix3vAeCuibALqlmbTYhcjnuvbmmp4iLY7DRjRxOhcoIcUkq1cLPYZ95HayRDpZNSsf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIc6PWv9hW6BMgIqKf0jgtH1qqFUOAAIKMOihDWISlg=;
 b=DPi5v4GroPw+OS8UZs88fUW6lx92KhP3jTAJ0M8D85MfUsAgmC6WQQdlnBnECAwYcySHEdMREry4/4OfD2Juia0GDK2t2vCCXpcYD9pEiMIR4GLK5HTSF8MklOUHRLvC29k2jscos28afoTiBfI2ckopWZpa8ZgLRNajRK9WXSESM5BD8OT6tmbbQQZDEzOK45r6Ku09naS5yQAhUogLViPRFEXe+Hk7TXRkvCRFxgMt39DxbDs88FbGn8ZJgXQkS7omd1y/r0/6EtrhofCYHHEyUbWtSxLP2SuK2rf6sTz0BjEvgtuUp3Vhy+7gfUMo+wMeE+huHVl4YNOCSw7RmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIc6PWv9hW6BMgIqKf0jgtH1qqFUOAAIKMOihDWISlg=;
 b=kNZoGDvSNzwLA4zDQSFlgozOFP00q6UZgUHvVNdm3B0ItALbPHJrUvVbPR97KRsrCrOLdfP/+gQU9shp7495PVM71k9oZb2ViwBqGs+UKDR25yItA3/m/yk4FwO4PIprcKsUYicHxLeKv+fGl6c2MMIfTb1LFXCU2MxbnMuClSnrBwMdtX7wG7v80BM6rtBtel0LEGtyo/TIUZYNmATU2BjcSxCEFWCU0LnL/P0oWn9OnFatH+7pm/cp3FDMRtYANS27sUzS9uaCgQe9ZIxAQeUEt+i6iyIUDMLLGxbKw/YBYIpiHs/LNuRknmEkg05S/y8n/41RORlExCqm6ZFnJQ==
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com (2603:1096:101:47::14)
 by OSNPR02MB9023.apcprd02.prod.outlook.com (2603:1096:604:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:34:34 +0000
Received: from SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120]) by SEZPR02MB5520.apcprd02.prod.outlook.com
 ([fe80::ebcf:d79b:73ca:4120%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:34:34 +0000
Message-ID:
 <SEZPR02MB55202AF5E15D574D7E157A9799ADA@SEZPR02MB5520.apcprd02.prod.outlook.com>
Date: Mon, 15 Dec 2025 15:34:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] loop: convert lo_state to atomic_t type to ensure
 atomic state checks in queue_rq path
To: Damien Le Moal <dlemoal@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
 <66ae3b25-7d82-445c-b125-bc017d299c85@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <66ae3b25-7d82-445c-b125-bc017d299c85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To SEZPR02MB5520.apcprd02.prod.outlook.com
 (2603:1096:101:47::14)
X-Microsoft-Original-Message-ID:
 <24f7be23-493f-4e0f-b02c-9e0fe7e17e00@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5520:EE_|OSNPR02MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e8df75-e711-471b-7b42-08de3bac645b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|9112599006|12121999013|23021999003|15080799012|461199028|41001999006|19110799012|51005399006|8060799015|5072599009|6090799003|40105399003|440099028|3412199025|3430499032|3420499032|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGtqUUVqM0Y1M1o5VlFLWlR0R0ZkTjFzVjhDZUNadzQxSjExQkl0YnJyS2wy?=
 =?utf-8?B?YTlxbnlJTU1sUnI3eFQvVHB1STZvb1hocTF3ZlBtMmt5WTJ6VVFld2RwMFJp?=
 =?utf-8?B?L3UvNGdlaTEzNi9ybmY4RGtOTkJManczKzBPa1lUUXhwc05aQlRtQ2lYNmth?=
 =?utf-8?B?MmZKc1FxNGdQUnBTMytaOHIvNStGMFpnbklZcWM4alFZUlRjM0N6Yzc5TXFH?=
 =?utf-8?B?YWhndjZpNjJHSnBHMCs2dXBPWmYzbG9oNTJnZUxmaG1mRjJBbEhmSUMxcDB6?=
 =?utf-8?B?a0dYNTMrM2FvVGZyTFhKYlpQUjZCK2lIZU5TYUVJRFpvZTgxL01sQkZCaXkx?=
 =?utf-8?B?NmlxU0dINm40ZERFZE5xdmZEcE9MNkpVYVdRVEJGTVk0b0ZQR0Y0Y1kvS3h5?=
 =?utf-8?B?aWl1VTBYQ2dIL0Vrb0c1b21jZTJXSy85WnY3c2krbDAzVnVlcnIwdEpEWHV5?=
 =?utf-8?B?b0M1YXc2aWc3SEVhb2N3TmRPcUVJYm4vc3h3SEpQTnR1TkNJUmlRM0NXVm40?=
 =?utf-8?B?N0oyVis4aDQ1TlJIb0dlWkR1dHNxbEJVQS9OOFhOUnNiTzI4Zzg3cStXR2ow?=
 =?utf-8?B?TDFGVG9obk5NNXZFY3VSYU9qMUJxaXBrY3ZqREVidDh4NVg0TkZOVzd3ZWMy?=
 =?utf-8?B?cXpKRW4yZnl5ZUpLUzJtdmZINU9pc0hQN0NlMk5xZm9Wd0J4MWhyZFhVOHhG?=
 =?utf-8?B?MS9MTENYQll2clNER1ZVWlZadi9wdTdaa2w3VzlGR2REekg0MVNsRXdOVGZT?=
 =?utf-8?B?Z3N1STYyc09UVWNrRVhEZk1xV0pGQkJ5TENDRldLRFNQOHRLZTdhTmQ5ZHF3?=
 =?utf-8?B?d2FLMHlnUTNDaGZzOVI1ZHJiQlNTd0RkZE1KUGZHdkUyeWtEelJES2tZMVQv?=
 =?utf-8?B?WStrUFMzT1dZeTRWVFJjbG9xTWE0N24vSzBzTnVHZkhmbktSeHBBRSs2b09r?=
 =?utf-8?B?TzBrUzhGbDRIdHhudzBRQWVOWWlYaUIvYWo2OEs3OHNFbzhBWUsvL2FhVjlF?=
 =?utf-8?B?OExnVmtPaFVldXp3dTYvVG82aVFXaWpmWE95Q2ZNVmxkcVFyeXVFNmpHaUd4?=
 =?utf-8?B?T0ZCaXJvcC9Ld0tuQmllRks2V2xqRnh3SEZYb2FQOTFqS3dndHZHQ1JqRFo2?=
 =?utf-8?B?RURTdFJtSEwrdW5XdnJGWkZvVWVQVjgrZGVwaFYrMnhSOWJZSFRBd0pyOVBJ?=
 =?utf-8?B?bmZNVjVDTGhCWkp0Rm5LZzZTRnFvbEo2d2R0eXZBSW1STFBjQlVkSXBRY3R3?=
 =?utf-8?B?aGhuckQzV1hZT0tzVlZZd2JEUEY2SDgydUN6cmcvc1pGbTFSOVFzZEdLeDAz?=
 =?utf-8?B?cGQwa1FtQXlka3V5Q0ZrT3FLaUNpWmJmYUpaNHJIZFd0cWtXUldlOGUrV1k5?=
 =?utf-8?B?TVYzRkF2U084NXQ2ZVNtWTNZbUg4Y0c4ay8rTXhlMjhzWjRsOEdMMmtpK25o?=
 =?utf-8?B?YzN6SXlsQ2xsaURETU42S3Z5NzJIVno1RFd3R09wbUFzMmsybi80R1owUGRl?=
 =?utf-8?B?RlFxcjVIWjYwNHZNZ2M3QklnZzhnUEdxd3dwMlJsZmtZU3gvVVlPNlM1SVA5?=
 =?utf-8?B?YmlJUlBTbG96TENjRlorQVIxMkp0cUN5aEl0SklXYzRoOGQwRTlDcm92c1Zm?=
 =?utf-8?B?Z3krVDcrbDdPL2V1UUxZS0NXVGdwc3lyNy9STnY1amI3d0dnYWtESTR2Ymky?=
 =?utf-8?B?UUc5djRmeERucEVhblMzUkUyZmVBNmV5WGNOa2s2L0ZmQURHcjdiTUQ5SHor?=
 =?utf-8?B?VU5hRDhwaElzVFFtOE94QUx6REI5THBDK1BER3czdjJUNUZRVWtuZ2EwUkM4?=
 =?utf-8?Q?8dxuCFcrloNOZ3qyvTvLpUvBVAE1bJ+rKc3ho=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnA1TXBheTM2Zldldk45bmdVME93NldybUZ1RVd3S09kUGhkcmRkempVSHdz?=
 =?utf-8?B?TXExWVhZUVV3ajd5N1FldnEydlFDYS9YT3lNcGJYRmJHSGx2aklqb3NYc2E2?=
 =?utf-8?B?RytmWHNTYjIxMWJPU3VGbitKa1JZaFVXZWdBR2tEWHBEcW9NT2YvT3RWb0p3?=
 =?utf-8?B?RWJaL1BoRmk5d3VTeHBDR3ZDQStiakptVW9pZTVyK3gwUFFRalQ3TXVjcW1h?=
 =?utf-8?B?a0JTVkhRRFkybjRVM1JReUNxZUc4b2hJMmFCaS9kQzBkWlFMaXFDWmdDQzE3?=
 =?utf-8?B?b0Z5eERETTRJbXZsbFo1c1lJT0YwS0ZXM1U5citEMHQwVEI2cHBKaDBnb3ZB?=
 =?utf-8?B?N2t2a0JCS2tXdFp6SDdSMDJEcXl5WmxSMmRYRXVEemxaKytUMkFOTmxRbk9S?=
 =?utf-8?B?RFNlV0lsUUpCR0wvdXdMOEwvSUFoVFZtd0hXZVIrMW5GTnFwcG9JOS9FUmov?=
 =?utf-8?B?UHNiSUdBVFhOQ0tSaGx1L0VQbjkveFZ3bVlBMXIvTTl5Sk5WNjJ4NEI4cnl0?=
 =?utf-8?B?N08xbHl5VzdKVW1uWWh0V05YSWh1WmxacXpuNVRSVmZJbEVud2QwWG1IMlVv?=
 =?utf-8?B?REFILzZUdnRVMW1pNEF5QlU5VnNMeWhoc2RxalhCU1BwMktlZ3pZNlZtQVk2?=
 =?utf-8?B?QXpBaUNFNUFURC9rOW5CMVh4SFp2OEY1TS9waDZ6cVRsVzhBVVhZOVpFdmNG?=
 =?utf-8?B?b3Z5WmpwNEhsTEhlcDNSVitxeXh3akZrVEROalNVYmJPRG9HK0UvUzRnTEw0?=
 =?utf-8?B?SlU0Q2JrYmV1Mng2QVA2M0NHTjFLYURwOVJHYUo2RnZWR0pNaEh6WUdObWQy?=
 =?utf-8?B?MTlaajNTYUU2RmtjNWdCZXUvZHR0bUU3WWtZeUVpSkpwUUFMWjJRQzYxTjIv?=
 =?utf-8?B?cURoQ3FxYWtIWElsNmxkdUFWQ05rSm83cXFrVzBiZWYyQ0NvbkJ1dHVRMGFp?=
 =?utf-8?B?dk9Nc3BwUFJuMnAyT0luajdqWWNMYmhUMmtUS3piUSswZUxocExaUUFzcWJ5?=
 =?utf-8?B?NEszMk5IeXVHSVhvR1JwOU1UT2c3VUE0Zi91Y2hMQ2UxNCtpZVRocU5lV2lu?=
 =?utf-8?B?RkI3cmRFbVFyL3MxUUtxNjJWTkh6ZVpLK0tnTGJORTNuZG9XdTZRbm8rcmJv?=
 =?utf-8?B?eEFyS0FFTTROVEFFUEZqUzkvcVdKYmJ1QnpmRy9jQkRESGt2YzBNbVVUMlRk?=
 =?utf-8?B?US9XL2hTSkI1c1VlRG5KSWsrUDhXd2FBTGZBNi9hR1IwSlJTMkhuK2dGWFJi?=
 =?utf-8?B?ZXQvWVBCZ21RM1FTK2dUVit0WGlIOTRkbldISDRlMk91QVdvTTRrang5V3A1?=
 =?utf-8?B?NW9DdlcwbXg2ckZxREQ0Z0RIYVVoNi9UYStFZHRMT1lDNmt4Wm5sZXpLYWN2?=
 =?utf-8?B?MlpqTHIyNEpTb1BJRkhQVjlSY3ltdldZWUZ4M21Xd0dGalU3WHpqTFlTZ2V2?=
 =?utf-8?B?WFV0OFZsVTRYUlZkamJnUG9GUjUxWjhxZ0h3TG9sbWtlcE5IU0lNREJ4c3RX?=
 =?utf-8?B?MmtxTlJNTGErZUVkbFppbWVHTEFiM05QeGltQnYySjNxV2VLTWxmUUZzcGxs?=
 =?utf-8?B?eEZpMDRZejFsbWdPd1dYbFBURTByK1ZqeS82SFhIckQ4SnI1V0trTHdJWU4x?=
 =?utf-8?B?cC8ydTZOalE4UUtiMlovWnhMV0pwNndDTXhUSWJqYUx0RVR5K2RkbTYwQlE4?=
 =?utf-8?B?dk0wS3FvZ2FGSWM1LzFBL2tsZFJBR0dxWm5ZTGFEM3dyZU05YTNkc0pRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e8df75-e711-471b-7b42-08de3bac645b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5520.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:34:33.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB9023


On 12/15/25 15:12, Damien Le Moal wrote:
> On 12/15/25 15:54, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> lo_state is currently defined as an int, which does not guarantee
>> atomicity for state checks. In the queue_rq path, ensuring correct state
>> checks requires holding lo->lo_mutex, which may increase I/O submission
>> latency. This patch converts lo_state to atomic_t type. The main changes
>> are:
>> 1. Updates to lo_state still require holding lo->lo_mutex, since the
>> state must be validated before modification, and the lock ensures that
>> no concurrent operation can change the state.
>> 2. Read-only accesses to lo_state no longer require holding lo->lo_mutex.
>>
>> This allows atomic state checks in the queue_rq fast path while avoiding
>> unnecessary locking overhead.
> 
> Code like:
> 
> if (loop_device_get_state(lo) != Lo_bound)
> 
> is absolutely *not* atomic, since the state can change in between the atomic
> read and the comparison instruction. So this is not about atomicity, it is about
> not reading garbage from the state field if there is a load and a store
> concurrently executed on different CPUs (that happening depends on the CPU
> architecture though).

Yes, I hadn’t considered that before.

> 
> As Christoph suggested, using "data_race()" may be enough to silence code
> checkers. Or use READ_ONCE() WRITE_ONCE() for the state.

Considering the earlier point that the queue_rq check of lo->lo_state is
just an optimization, using READ_ONCE() seems more appropriate. As noted
in the comment for data_race(), for accesses without locking, would
data_race(READ_ONCE(lo->lo_state)) make more sense here?

/*
 *...If the access must
 * be atomic *and* KCSAN should ignore the access, use both data_race()
 * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
 */

Thanks
Yongpeng,

> 
>>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>  drivers/block/loop.c | 67 ++++++++++++++++++++++++--------------------
>>  1 file changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 272bc608e528..bc661ecb449a 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -59,7 +59,7 @@ struct loop_device {
>>  	gfp_t		old_gfp_mask;
>>  
>>  	spinlock_t		lo_lock;
>> -	int			lo_state;
>> +	atomic_t		lo_state;
>>  	spinlock_t              lo_work_lock;
>>  	struct workqueue_struct *workqueue;
>>  	struct work_struct      rootcg_work;
>> @@ -94,6 +94,16 @@ static DEFINE_IDR(loop_index_idr);
>>  static DEFINE_MUTEX(loop_ctl_mutex);
>>  static DEFINE_MUTEX(loop_validate_mutex);
>>  
>> +static inline int loop_device_get_state(struct loop_device *lo)
>> +{
>> +	return atomic_read(&lo->lo_state);
>> +}
>> +
>> +static inline void loop_device_set_state(struct loop_device *lo, int state)
>> +{
>> +	atomic_set(&lo->lo_state, state);
>> +}
>> +
>>  /**
>>   * loop_global_lock_killable() - take locks for safe loop_validate_file() test
>>   *
>> @@ -200,7 +210,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
>>  static inline void loop_update_dio(struct loop_device *lo)
>>  {
>>  	lockdep_assert_held(&lo->lo_mutex);
>> -	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
>> +	WARN_ON_ONCE(loop_device_get_state(lo) == Lo_bound &&
>>  		     lo->lo_queue->mq_freeze_depth == 0);
>>  
>>  	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
>> @@ -495,7 +505,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>>  			return -EBADF;
>>  
>>  		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
>> -		if (l->lo_state != Lo_bound)
>> +		if (loop_device_get_state(l) != Lo_bound)
>>  			return -EINVAL;
>>  		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
>>  		rmb();
>> @@ -563,7 +573,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>>  	if (error)
>>  		goto out_putf;
>>  	error = -ENXIO;
>> -	if (lo->lo_state != Lo_bound)
>> +	if (loop_device_get_state(lo) != Lo_bound)
>>  		goto out_err;
>>  
>>  	/* the loop device has to be read-only */
>> @@ -1019,7 +1029,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>>  		goto out_bdev;
>>  
>>  	error = -EBUSY;
>> -	if (lo->lo_state != Lo_unbound)
>> +	if (loop_device_get_state(lo) != Lo_unbound)
>>  		goto out_unlock;
>>  
>>  	error = loop_validate_file(file, bdev);
>> @@ -1082,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>>  	/* Order wrt reading lo_state in loop_validate_file(). */
>>  	wmb();
>>  
>> -	lo->lo_state = Lo_bound;
>> +	loop_device_set_state(lo, Lo_bound);
>>  	if (part_shift)
>>  		lo->lo_flags |= LO_FLAGS_PARTSCAN;
>>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
>> @@ -1179,7 +1189,7 @@ static void __loop_clr_fd(struct loop_device *lo)
>>  	if (!part_shift)
>>  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>>  	mutex_lock(&lo->lo_mutex);
>> -	lo->lo_state = Lo_unbound;
>> +	loop_device_set_state(lo, Lo_unbound);
>>  	mutex_unlock(&lo->lo_mutex);
>>  
>>  	/*
>> @@ -1206,7 +1216,7 @@ static int loop_clr_fd(struct loop_device *lo)
>>  	err = loop_global_lock_killable(lo, true);
>>  	if (err)
>>  		return err;
>> -	if (lo->lo_state != Lo_bound) {
>> +	if (loop_device_get_state(lo) != Lo_bound) {
>>  		loop_global_unlock(lo, true);
>>  		return -ENXIO;
>>  	}
>> @@ -1218,7 +1228,7 @@ static int loop_clr_fd(struct loop_device *lo)
>>  
>>  	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>>  	if (disk_openers(lo->lo_disk) == 1)
>> -		lo->lo_state = Lo_rundown;
>> +		loop_device_set_state(lo, Lo_rundown);
>>  	loop_global_unlock(lo, true);
>>  
>>  	return 0;
>> @@ -1235,7 +1245,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>>  	err = mutex_lock_killable(&lo->lo_mutex);
>>  	if (err)
>>  		return err;
>> -	if (lo->lo_state != Lo_bound) {
>> +	if (loop_device_get_state(lo) != Lo_bound) {
>>  		err = -ENXIO;
>>  		goto out_unlock;
>>  	}
>> @@ -1289,7 +1299,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>>  	ret = mutex_lock_killable(&lo->lo_mutex);
>>  	if (ret)
>>  		return ret;
>> -	if (lo->lo_state != Lo_bound) {
>> +	if (loop_device_get_state(lo) != Lo_bound) {
>>  		mutex_unlock(&lo->lo_mutex);
>>  		return -ENXIO;
>>  	}
>> @@ -1408,7 +1418,7 @@ static int loop_set_capacity(struct loop_device *lo)
>>  {
>>  	loff_t size;
>>  
>> -	if (unlikely(lo->lo_state != Lo_bound))
>> +	if (unlikely(loop_device_get_state(lo) != Lo_bound))
>>  		return -ENXIO;
>>  
>>  	size = lo_calculate_size(lo, lo->lo_backing_file);
>> @@ -1422,7 +1432,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>>  	bool use_dio = !!arg;
>>  	unsigned int memflags;
>>  
>> -	if (lo->lo_state != Lo_bound)
>> +	if (loop_device_get_state(lo) != Lo_bound)
>>  		return -ENXIO;
>>  	if (use_dio == !!(lo->lo_flags & LO_FLAGS_DIRECT_IO))
>>  		return 0;
>> @@ -1464,7 +1474,7 @@ static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
>>  	if (err)
>>  		goto abort_claim;
>>  
>> -	if (lo->lo_state != Lo_bound) {
>> +	if (loop_device_get_state(lo) != Lo_bound) {
>>  		err = -ENXIO;
>>  		goto unlock;
>>  	}
>> @@ -1716,16 +1726,11 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>>  static int lo_open(struct gendisk *disk, blk_mode_t mode)
>>  {
>>  	struct loop_device *lo = disk->private_data;
>> -	int err;
>> -
>> -	err = mutex_lock_killable(&lo->lo_mutex);
>> -	if (err)
>> -		return err;
>> +	int state = loop_device_get_state(lo);
>>  
>> -	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
>> -		err = -ENXIO;
>> -	mutex_unlock(&lo->lo_mutex);
>> -	return err;
>> +	if (state == Lo_deleting || state == Lo_rundown)
>> +		return -ENXIO;
>> +	return 0;
>>  }
>>  
>>  static void lo_release(struct gendisk *disk)
>> @@ -1742,10 +1747,10 @@ static void lo_release(struct gendisk *disk)
>>  	 */
>>  
>>  	mutex_lock(&lo->lo_mutex);
>> -	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
>> -		lo->lo_state = Lo_rundown;
>> +	if (loop_device_get_state(lo) == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
>> +		loop_device_set_state(lo, Lo_rundown);
>>  
>> -	need_clear = (lo->lo_state == Lo_rundown);
>> +	need_clear = (loop_device_get_state(lo) == Lo_rundown);
>>  	mutex_unlock(&lo->lo_mutex);
>>  
>>  	if (need_clear)
>> @@ -1858,7 +1863,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  
>>  	blk_mq_start_request(rq);
>>  
>> -	if (lo->lo_state != Lo_bound)
>> +	if (loop_device_get_state(lo) != Lo_bound)
>>  		return BLK_STS_IOERR;
>>  
>>  	switch (req_op(rq)) {
>> @@ -2016,7 +2021,7 @@ static int loop_add(int i)
>>  	lo->worker_tree = RB_ROOT;
>>  	INIT_LIST_HEAD(&lo->idle_worker_list);
>>  	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
>> -	lo->lo_state = Lo_unbound;
>> +	loop_device_set_state(lo, Lo_unbound);
>>  
>>  	err = mutex_lock_killable(&loop_ctl_mutex);
>>  	if (err)
>> @@ -2168,13 +2173,13 @@ static int loop_control_remove(int idx)
>>  	ret = mutex_lock_killable(&lo->lo_mutex);
>>  	if (ret)
>>  		goto mark_visible;
>> -	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
>> +	if (loop_device_get_state(lo) != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
>>  		mutex_unlock(&lo->lo_mutex);
>>  		ret = -EBUSY;
>>  		goto mark_visible;
>>  	}
>>  	/* Mark this loop device as no more bound, but not quite unbound yet */
>> -	lo->lo_state = Lo_deleting;
>> +	loop_device_set_state(lo, Lo_deleting);
>>  	mutex_unlock(&lo->lo_mutex);
>>  
>>  	loop_remove(lo);
>> @@ -2198,7 +2203,7 @@ static int loop_control_get_free(int idx)
>>  		return ret;
>>  	idr_for_each_entry(&loop_index_idr, lo, id) {
>>  		/* Hitting a race results in creating a new loop device which is harmless. */
>> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
>> +		if (lo->idr_visible && loop_device_get_state(lo) == Lo_unbound)
>>  			goto found;
>>  	}
>>  	mutex_unlock(&loop_ctl_mutex);
> 
> 


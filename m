Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64B16F84E;
	Wed,  3 Jul 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009698; cv=fail; b=Y4IeFAamSEGNnsKVzjaAtgwgcB5cuHzokzQD5AD5/kgwjUqK2i2fHqSvvqP063aLadKFE0ErGRu7ukcjLrVCDsu/ehnUm0Mf3HeuzNVztwXR5+jW23CiFmD28hM+2PM0lNHMyk0OU32uhA0S5CwMvauwCg+3CGlbRuRMc9nBGI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009698; c=relaxed/simple;
	bh=c4hIm//aoM7/8wwwiXNuKkuk+c4wQeueYGI6iVaPBeo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lhstpTjuIIKN68mtOEsM/zQctvetNrspC0E2h3FNsBaB1BsdnHeFBCQsTl62DmZKNybbaIRrTmbRhfvISICsGeNrftKpNzcU8wxrsi2yeIeP/u3qkxqHUagPMbSVGHKXkCSImpCFo34fAx1tO3Z7KPlp6uxF1wLKwd89WGVstlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KfoHhz5M; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KfoHhz5M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e67U6nhPiqIvMxNaZS0UHyZAMjDqOT/pg5pYnknM5EyMFNtCBDUzVIRLAJbd8H1l/SiFTawRe/GeI67o+PSRbkfc67Im2Yv3YhIdjhjceM1o6kG/F9rso4OyhuYOprvQsvaRmM0a63f01/O8o/zoSxT3IxwuLBY9jPkkI5ekYfL4vK3h9UJ4wPZ5J8c4J0sJM6r8b2rx4h5Sdr9rCxEk058NdGQfeJuP4xf3rcKAPZT3R9b0Pw4bIkKWmlo1k8Ywqp0OpvsQO+o7tFvW8e67vhVAQRNY1k2RFgHNX4hzq0w2xWwFjREWGaz869y4Jc9h6IBXS8gPJElsLTFcOhjn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok5tNCCtD7bDwZt6ixMLotcJE272UV9+YSCW6TfXEFM=;
 b=P8hTIuVWWhl6fxJNsVALEEY+aYZmzB8pehP+v5Brl9pOsBhdwKR/KEJMGqMVJ4hY7Ug7RITxfYsrcDEJJShUdplUhM1hORwkpISUrhm6dWqsfn03QPWR1ArMika5lF+4XEKGTG+96Npugwo8+v48ce234RSCEJJeNkK05FIoCnKAe5Gnm+evpI9OCi5uCrl7TKVyvpFn3q9+m7gj4Br/VqTroT/KUWUDxt9otr8KheHyU3xIa/jpGUgjYmi1va41rVKBzVXNemh2TbyS2cByNbfol9+cregfeUvjk+WGY5R4P6TssR6Wrnrh5FshdlPKo0Rbq/Ft7rBlBgIIMz+u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok5tNCCtD7bDwZt6ixMLotcJE272UV9+YSCW6TfXEFM=;
 b=KfoHhz5MeOChMFFblN9zTch+3xHryCYjefGuGKvJ4qJTw4jgYs0BFLl1+F/BbN/B9MaHhqLKcrxJaxMi6FoJ9ZHo2SeY0qgb7+DxS0f/3SqUaKWCh1gQj0fumu1/d4c4PA9AqZQURgSXbwxXYhUNr4d+RR2aXYGW3mDbxfW7x/EJ4kDent7XuH/bw4JS+3s6epp9a1eLvLlFoHsagVwp6brglepxdcv3x6iBhE/PrcGPhOXEeWdWTOTmrPToj+WP1YE6D7t5N5EdAtBhnBb9u0JFQWyDqiYFwRrtzERgvnPci4/Ad7KZaP/Aaq1rIbEtdh34U9uqHg6bdTdgRmN+0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5308.apcprd06.prod.outlook.com (2603:1096:400:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 12:28:11 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 12:28:10 +0000
Message-ID: <59c125f5-ff40-4a36-b095-b0dbf1a0a3fd@vivo.com>
Date: Wed, 3 Jul 2024 20:28:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240703022807.642115-1-yang.yang@vivo.com>
 <fbd3bebc-db09-4224-bdf9-b44304bf55b8@gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <fbd3bebc-db09-4224-bdf9-b44304bf55b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8c6221-07ec-4ca6-608c-08dc9b5b99bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFQ5S3pTNHZuNmFWaDNWdHdoMldYVUZqMzJsbkJwQ2Nha0xuTXRRWFllYmRZ?=
 =?utf-8?B?bWVCa2U5ZHl2eGFLbWJNRXlVbEg3VHpKRitDODBXalRFV3ZrcFVXS1BjOFlz?=
 =?utf-8?B?a2VhR2NjckxiUWVjaTZRQUhEazVZNlBaY2pFQ050MUtSRXhYU0dKc0RSdTlW?=
 =?utf-8?B?cndTZ0RreTF5VHRzbUl3S0xCbHd3OGNtQzRtRTBYRWVvb0RBYU9sbnhsdHRQ?=
 =?utf-8?B?TXRrd0MzV05acjFndkxlL3ozWUZqLzFra0ZLVURscXlDbFgzajYzcWdrZVIw?=
 =?utf-8?B?OEp3M2VxeVFxRUlVNGZ2VWdvTlg1VFBiNS9BN3dsTXoxWGZtSDVZcE9lTzNE?=
 =?utf-8?B?eHNLK3E3RUtwTGpxVnozUDVxbnNpVGdwRG0wSlZRRHlCa0JGN3U3eXNhUmdm?=
 =?utf-8?B?ejhZQ0tmZUtaeTBzSkhtREs0RitINjlONWEzejExdUJqcVVBSmRNZE5HMEth?=
 =?utf-8?B?ZFJzWVRKdDQxVnVJN3J0TnVOTFhId3JUbGRuUWxlRXBUOHFqNHZ0VSs3WFYy?=
 =?utf-8?B?aEcvZ05HKzJxTUh2QnR4VHloTTc1cWIrNzJGTGZ6WUJjTWZJSkNLYUV0SW9G?=
 =?utf-8?B?S1M4dDNOMzcxNzVhUzlYUjl3YklkQjBnZ2x5UGgvV0pTYURnZUMxVUxHd2JQ?=
 =?utf-8?B?TWw3M3pmdzI2U3hPV3ZhOXd3OENSUDhpY1pjM0hwb0pjbjhTVnZzMXJNejk4?=
 =?utf-8?B?dW01d3Vxa1VlNEpHKzN3bW1jbmV0anJYdUdhY2dyNWR2UGkzREZaYkhpMUF6?=
 =?utf-8?B?eTZuRmVzazlkRGNoYUhsTmtvN3FCZFFNRVFER1lzTWVxRE0vTGQ0ZmN3ayts?=
 =?utf-8?B?aWxBT1F2alprQWp1Y01XdzcvZmIrZ3FWTE04QmNVQ0JTdkFza3A0aGlNcldu?=
 =?utf-8?B?bXNkSkJabStEWHZMRldYM0p1OUY1OWhuNGZpSktxM3lDTzNZZHhIdGlwc25i?=
 =?utf-8?B?bEJOWmNQVmtrWU50KzJaaWdzWS9nMk9VU0I2dXlSejU1YlovdXYwYXUzemtF?=
 =?utf-8?B?dmdvOGRwWmY3Um02a01ZbHVlTXdveU9LK2p5QzJRWTZjbmhpVHJCMGIySkxl?=
 =?utf-8?B?N1FqUmxtMTYvMXRaekhJdndIM1RTMER3RFFyYVAzcDc0VldpSVV1Z3ZVR2NL?=
 =?utf-8?B?RUhmcCswakV3RXk2VHlDTzhVWEJDTk01RytSaW1ZYXdyUlY5T0VrNC9ISVI0?=
 =?utf-8?B?bDkvYzk4VDZmR0VJUkN1dlRIcmxoeWtVZURuVTQyTWh5WjByc0IxKzEra2xa?=
 =?utf-8?B?dkVXU2VqVGxFdzBFMStiT1RiL3RwRyswVDRaVHhWSUdDaG1WcUJjRjlCZWpz?=
 =?utf-8?B?VnlHbU04ZW1xbjZQUFhqSGhlcVRRMEJTd0txRkZ3SjZObXg0M1lQeVpQSzUr?=
 =?utf-8?B?TzZkcC9kYW9BRDE3N2U5dFkvR3lxQWp2NjlqRk9HOHduUjFmRW4wTndlNVlh?=
 =?utf-8?B?eVhzMXNEaDhIbFhMeWtGZVhYbkRRbGhHV1ZqaG85L2VVWWptQnNBRnRtYk9i?=
 =?utf-8?B?dld6LzNNSjNpbzNkaUhNczlWWUxtNDM1eURHV2JIK3JoNVNIYjA2MXl3a1Rw?=
 =?utf-8?B?U1ZFc21uOTNJVHYzYnMrUHZaR2RXQ1dRa01zMU5wcis5Tm1SeWcvSVVSRlg3?=
 =?utf-8?B?ZSs4RkpJSlJmd1hsNGpiN1pkbk55SElucFpmYjVpSlNyVmxYVUx5c2lUbEtC?=
 =?utf-8?B?Ulk2aUhFZmc3U1NaelI4cjBRSzgyeGk0QmhpQmxnSHpITDhEWENNL1lRbXM2?=
 =?utf-8?B?TUhpUk95WUNDQ2Q2dGxWTURzeTZFMVIyeGlPMHdaMEtiZG9RMzM1alJhOVVl?=
 =?utf-8?B?MzUrMlhpNThGUzFPcHJlZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlSUm93QkhjbTNncEUyZE11OVRUSlA3MWwvd3dOeDBkYTBPa3hsUHRyMzRM?=
 =?utf-8?B?WFhrMW4xdmtDQkswZloxdVY1WGJuVy9JL1A3RXlsMzdKRDZKbFl3bkp4YVQv?=
 =?utf-8?B?K24rU1pzUjZnWFBXaFBXeWhWVHNaajA3MXpnM0lMTVZzUm9yQzN5NGFjUS85?=
 =?utf-8?B?bkVDaTRoL2lVT21kZFpwL01qbGNMZWlzZ0tFWVBKK1BzL2MxbGxUaU9nYXN2?=
 =?utf-8?B?eElDalhPWStTVklNZjEwSnB2bzQ3WHI4Ykc0K09pOTUyQUExSGZaWGQ1bTF6?=
 =?utf-8?B?WkhST1FPQWovc2E2bzFNdzVYOGFFdFVYY1hGcUZMQ3hWUWthSUFsWllOUUlO?=
 =?utf-8?B?RHpqZkV4UFIxaVJRVStQS1R1bDBwOTZEcHJnMkhJVmN5cVlsTTE3YXNCclZt?=
 =?utf-8?B?TEhNbTNsT0l3QmM3NDZUNitUV0p2ZERGZXdueFEyZEZEUThuYmloeHhHSTZG?=
 =?utf-8?B?amhOUStFUjhXdk5vVFJrcTlHR05hMzdVQXJuRHdUZ3dJYStvOHJ2aEtqNnNG?=
 =?utf-8?B?cXdmWmE0ZEI2eXJxNTVKVTRzbDlSb2Ftb3VZMjE4bXJKM2h0dFB5YWNsaXRw?=
 =?utf-8?B?MUtocXo3UjF6SWk3RWVRWE1ZbDJxTTZvUWxNRFdIdVh0SWlVVlRaK2xyZ0Vz?=
 =?utf-8?B?ZUo5dGxYVkFTYVlCVmVRWU5BeVhlTVdVZU80Ny8waUJJMUphaEJ6RDlsbDU1?=
 =?utf-8?B?K3NVU3JQTkFSN1hwZjFoRmd0Qm14VHpQaEZ2bzNqaEhtRDhiU2d6ekNNcnhX?=
 =?utf-8?B?MjlZbmpTRTlRY1dBVVJWNFpjR2xWcjVtYUNOc0x6TkljREwrb0UxQ2NrcmYv?=
 =?utf-8?B?Rlg1dzRVOWJXNDhxb29weUY0TGVhRXdJZHRqaDRKUnkrR0M2K3hlV3d2ekd2?=
 =?utf-8?B?SkJqci8yRTd3Vnc0bWFFTEJnSTZ4WEVubHJBaG9lbW1EdkZwNTBDYWswaXVY?=
 =?utf-8?B?T2Q5WkNzWHZ2d0w0MDBRYy9sVG9KMEduTkZWNUIwZ0MwejR3d21tYk0xNkRD?=
 =?utf-8?B?MUkrWXdiNlNoc0krYytFNFJxYjFnWFEvZEJqajFseHRwa0pvS0FidEdqcmNU?=
 =?utf-8?B?NG9jTVVBN0haUDgyMHY5Y0Znb1lBcDZHbTVNOCtRYU9Sa2pFK0VRaFpHMm1z?=
 =?utf-8?B?SnVlb255VXFHSkpIMVVGd0NGbDNoNnY3bWRFSTBjOXRLSVloU25jSnQzNGh5?=
 =?utf-8?B?Z2NJVTBnTWtrdG5TQ2t2bDl6dll3UUQwc1ZvNFlGWDhFb1RaYWJwTkx4VmQ2?=
 =?utf-8?B?RmpEL0hYa2lnL1M1SSt3TzZkVlphMHJSRWVjNVF3TW1wNGRMUHFQRFAxWXRx?=
 =?utf-8?B?QzlrVTZmaHJRakNjajFib0oxdk50MXJuMkdsOFNHZUdITGgrUFNieGY1MENp?=
 =?utf-8?B?OFRLbFVZaGVlL240WXh2NmdhMForQTloVGFTalNjNXFTcFp6VldxNUcya1pk?=
 =?utf-8?B?bjZjSGRYVEd4NjB5bkxkTXN0UjFCalUxQytPRVNhUzZLR002Y0Z6RTFFeHdm?=
 =?utf-8?B?T2pPdFBWQUF2dllmVUpqVDlnSHIyNUtheXBXZ3hncEV6MXYzOThsODdELzgy?=
 =?utf-8?B?Yjl6dWNmTFFlaTJINGErd3N4SlFOOWhET1JVY3Z6WjBVM1NCS241L0kzUXBr?=
 =?utf-8?B?TFZWRndxazcxd1hjR24zcG5kR21kM3N6aXU0NDJ3VWxrZ3UvTkp3STVCYktL?=
 =?utf-8?B?YXRSWXM1dGVjK0xMbExWa0dXdTNPS3hrV3FhdUsyaDIyZlcyUWlVbW5jdDRX?=
 =?utf-8?B?NVZZS1Q5dFdTREJkQjJiYythN3J6anNyTUJVT1ZOV1Y3QmRTUm92RitBR2U4?=
 =?utf-8?B?WVBMM3JPaHNjRWlwMW0wRGpMbG4rWDV0Zit3R09NVi9raTdaWWdBcS9TcVM1?=
 =?utf-8?B?M3ptUXF3ZFhjTEkwT1BqcTFxQWVmLzg5TFNrQ09URWZrR0wzSDJtSmJlY29z?=
 =?utf-8?B?bXk1L1JNQzhNVXRRa1B3WmJiNzBlRmxlZ01GMlp3T1F1bm1menhLdTNpbktn?=
 =?utf-8?B?YlRzLzFuQTBNSENrU2tiKzk1RmI5czRYdStURjdTd0ZiNWVBUGcxSUhNRUZO?=
 =?utf-8?B?b2IvZ0ZWbWdJL1ZSNUNWanZVZytPZGJrR3BKTkFhVDhCMlN4K09TTUVNS1BD?=
 =?utf-8?Q?RKhaElARmOzj0e9FcZw37d5X6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c6221-07ec-4ca6-608c-08dc9b5b99bb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:28:10.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BgaNTKTBkNS2/zKV2wKqQ5XHnIw9TIlvfIw06gDgGr16fkyg2Jqabfi+abeR4RcsBDaMVQnVdiKpQ+AKcKr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5308

On 2024/7/3 19:55, Pavel Begunkov wrote:
> On 7/3/24 03:28, Yang Yang wrote:
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
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
> 
> Is it blamed right? Considering that the revert alone doesn't fix
> the problem, it sounds like the 2nd step might need to be ported
> to kernels even without the blamed commit.
> 

Got it. How would you feel about removing
"Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")" and modifying
the commit message as follows?

This patch achieves two purposes:
1. Check on ->cleared and update on both ->cleared and ->word need to
be done atomically, and using spinlock could be the simplest solution.
2. Add extra check in sbitmap_deferred_clear(), to identify whether
->word has free bits.

Thanks.

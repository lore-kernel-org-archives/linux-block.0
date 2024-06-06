Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788143BB59;
	Thu,  6 Jun 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658511; cv=fail; b=ia7kyykE0NaEHRm9SWYQjbcD/7YODd9NT5Fsi5bRePKxNYjUk+VvRLhisppeeGJ0H584z9qTpZLa/AeA8CVw2SZS0/z7M6VSwJavRFrowZ2t2ubKg7kARuty6SFeyR7VvCHJ0cslZEVsVvLh+CCX1iPARxeAuNKXtV7CDscofKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658511; c=relaxed/simple;
	bh=nEmkXwidkj7Kan1tDQQF7TtfbfiXOEe1hNW7Lp+HxtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNCOxfOnLsFsWGsSBZfbSHznYdfpK7+thxKwmO7PO+aWgw1a5Otg2wt5GpSvMaxwsFg63GavaZRlwSUWhxLpawccgkBb/W7KO/kSRxjPNJyH0+Euj3i9T9HmNkU8g6oMJfvjaYqgV+de3FBGCILgUkJDeL6q/acNK4AYt1xtXaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KQBX9XHR; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KQBX9XHR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFA+PZ70PfVXShvip8lsb9exZwew+yw+s/3n3jzZXhumiewA3GILvv+ANQCDPpihzMtnb7gOAt8bo2Hg3dyb9tbHxsZWpsNlBwwfL6qve/MMlm/OADuznDGa1yhLDhqYZPABtOV11XQFkwr/4G9WGpTdDJ/HOu2bO7/fytlVwc/fpasqhU4iTXimiFmitJSNXShVIiwyJJpe8hGJ2Uh8EZbWtTv5LPxEOY2CKeyRsZHV6lNPzjgNc/b0pz5AYv3nJuTPy8EN5BwXLao6gPtpiAizm1Mn6HfyJpkHJvMvTnSONZVIQjW7L3eP1xDA5+lGG1gXh0BCINvx7O1IjBxG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgDXFrdqJ5YP+iWw9OCZwshGbhYMneitzjdUMEDtczY=;
 b=kicrJNU9U25sINGLTNC1MgEuYVZ64gHXElkRtQAkWsnCK+6eaPk2N9MqClUb11KSqauhzisdA3xzQRbba5+yTpYLNJE/4nf0pox6PPNJ4bt7FMCaNuTX9PZOHi06zgcpKPKAjAZCVgYKb8dc13QOc6IPAjY0fcZlFLJ9YZLfiuutvHSeKhsxn9712zg8pplbyOCoxD3HK3VJsd4C2zcUOBCE0hKLp0tzm8q4RC4yGpR3gzo5Wtr5iaGVa8TuN/TIkIJrkeLQ7b+6N180dE29MNzAjRxQG5i2Nlkg7p4v41w9JwrvthaGYFgUDrYpoZbIYkI1b6nHVlux1k6r15MJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgDXFrdqJ5YP+iWw9OCZwshGbhYMneitzjdUMEDtczY=;
 b=KQBX9XHRiQSRYIk0uK6CRdIi3MOvgynsxekFAQczDXy/nfmn1bKiCxucIKt2bmgvAg3oueirKNtlCXkq6igOVVK540B+KuBWb1XWcv0le0FOxdTTVuCuK12ru/7wg7f5iH/uOjpeX7hdvRcU7D9XaFzIJBU0KO02YxgWpT6ywNdxTwtERElIce8Cr54bPqrpiSg2aeb78aqxcyY6GtCQiwbHT/9UO9Ab3kaanUqSCTDdkgWhxJctYAMdVpEwPdSXZfIYSfjESMagwA1IffNC0q5E524hjEYGMKkJppHlOB5gbHOEh8SbacLUM+GPIkFj3cEOQ4kRgtVGjpEyvvklFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYSPR06MB6504.apcprd06.prod.outlook.com (2603:1096:400:477::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 07:21:44 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 07:21:43 +0000
Message-ID: <bebf237c-1223-43e9-93f1-10a32c4923af@vivo.com>
Date: Thu, 6 Jun 2024 15:21:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <ZmEpIBL2Ot5cwRyv@fedora>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <ZmEpIBL2Ot5cwRyv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::21) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYSPR06MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e486e2-e029-4cc3-b087-08dc85f9512c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdhSEluc2tJelZPY01JWjFod1BwbTJOcWJvV3RlSU9XQmxaaGZ5cVkzTm9o?=
 =?utf-8?B?KzNpbmpRODEvaU5kVWJLZE5MbHNrNmRvc0ZhWDNERjkrV09BMXFPdHA4YVM2?=
 =?utf-8?B?Z3RyTHhJSXF4WG8rNi96ZUtxaWF5VGxlTTlKaEI3S2s1d0FLUGcrbjlibFFP?=
 =?utf-8?B?S2VJZURXb3AwVzh2amNDcW4yR1lPaHdLVFRZVVlTYzVEc1B3TnRmN0RRN1Iy?=
 =?utf-8?B?YS9pV1RUbTVucUNJa3k2R0xMbEJwMG9DelV1cTFJMUR4dDNjSjF0Zkk1cjE0?=
 =?utf-8?B?dmQ3WUtxNFA4NUcrVlExMENSdnJleG5aRDc5YTRFWHZjZlhqUzQrVENaTkhF?=
 =?utf-8?B?SXJGRmtOVnZocjYzK05MMklYSU5GeG44STBlK1A4RTFHY1hQQzRSQ3ZScTZ3?=
 =?utf-8?B?Ny8remg0RFplMC9ySGVNSDVSdWt6SU1xdVhoMk92WmJqdndJaEkyYWNwTDRn?=
 =?utf-8?B?VHJWbjZNeVlVLzZDdGR2UWs1dnE2NEU2bXJSbnFHVGcxVFRyUG9tbytxTTdh?=
 =?utf-8?B?WGN6T3FCbndUMEdzS0k2MzFlbk44Vjd2Z2hteUhDOTNHU0krR0RhcTFKZGwx?=
 =?utf-8?B?OFd0cVhRT3RRQUJDZklsclRqZUhPTDk0QTRhelRGcGVKaUUwRjFSSTBSK2k3?=
 =?utf-8?B?WmtPTXMvK0c1TGQzSzNMdWxFb3dmNEhYdy9xQnR3TFQvUVNHUnc5QjVMaStM?=
 =?utf-8?B?WUZBRSsxK0VJNUcyamd6VWM0eU5oY3ZRVUdCd0hNQjJITTlCTXgyRGZNREhN?=
 =?utf-8?B?RUNtMVJ0NG5PQ3I2SWFCeTE3ZjNmdUUzTFFhWkJicTNNZW5KMUY4b2tJaGF6?=
 =?utf-8?B?S3hRdGo5UCtrZGx2SkpRdXZLaHVDczJkYWc0OGNVaE1OcGJZN3M4cnRFaEx3?=
 =?utf-8?B?UmpjdU9PbHg0NnZXN21wcTBRNUUzajhSdTVEWFpzVmMwWDlDMnhoRnVPR1dp?=
 =?utf-8?B?NDlkVExkdUVTU3plRTU2QVhvR1NnSjJpSTNCdS83aVVHUUN5MFNYbmZjemFO?=
 =?utf-8?B?TnBlbkd5Q2tIaGlCTVNWT3EycmVVS2grTnUvVnh5dWNBdis3TTZWc0pmYmlv?=
 =?utf-8?B?bmI3QnNuWkFDMTJUY1EzNXM1c21vdXU5VUtUS0U4Skt1T01TRGN5TkxmazNn?=
 =?utf-8?B?RUdtMXpEWUhNNUoxcDREWGl3d1ZnNE14STFxcXFVTDIyZFZZSVhiZDVNbDU1?=
 =?utf-8?B?K2o1dFh0K1FaOHF5ZUwrWEdCQUZkdU9QME5vMk43L0xOc0tSSCtxOVQ4cC9j?=
 =?utf-8?B?dU4zM1pOWStZbUVJZVpTUGxNY2c4VWNlclVVUEwySk1jUGVjQlBPWEdyU0g1?=
 =?utf-8?B?NFlremxNMXZUcndDOFY4SjVLNUtSaUxraFhKNzQ4aVI2S1Nod21QbkNWcTc5?=
 =?utf-8?B?bThOZnY1YWhmY0U1czJrUU0xS2x2VjlnZUN0UEhnU2tLWENmSjdzSThwSXVI?=
 =?utf-8?B?Y0kvZTd6Uk1JV2NZMEhQS2R1Q0VhOE1zMXlOTExWcDVCYnkzd3VxSjFEM29R?=
 =?utf-8?B?VlM1b2d0dU95bzBGa1pIMFpENzRkaEhRem1TcWJadzdtRWlldG9lMlhNR3VI?=
 =?utf-8?B?dXRRS2txMHQ1RlJDSWJFS1RDN1ZXN0tZZHA3a2pwekRXQUtCbmlPQ1cwSEJy?=
 =?utf-8?B?bmJHNXpKQlBaZUU4SWhKRFZNdVEvcUlERm1WcDg2NjdQR3QxUEdzZm5mbWh5?=
 =?utf-8?B?anBDNDJ5U3QrYk14bk9RMmpHblRqM2JyekFXK0dsVzl5VitmMkYyZTR3OEFi?=
 =?utf-8?Q?nkH1RvbaZAR7YOE62IiZni/JraAjns/9alcXX1p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJrQVRYd2FKd1hPTnoxZzlUdDAwcUczbitaUmRMNWo3UWluL2EvOGFFMWox?=
 =?utf-8?B?bkpPWHc4d3g5c0I2eHJnakd4bFo2c3FkS1JudXl1VWNablF2M2R6dmh0dkpR?=
 =?utf-8?B?bVM2alFRZmw1TUl6RWxNeFVadmlGM2cyUXp6cldCTXozSkI1SFhtcXpkVmNv?=
 =?utf-8?B?bG95eG81bEl2ckRCeVQwSnIzM1ZwR1h1dExyRWVQSm84OGVsZ2JwVVNzMEFJ?=
 =?utf-8?B?Ny83OGpDcnpVYkxxMnJ5QjFJeXZ4QnFWUExuU0RycVhwNXdIeE42Y0VEMytU?=
 =?utf-8?B?a3prRUc4RnJHcUNXRTRqTUhXOFdQK0xHNDdIT3FGUG1XT3pBL2NHdTF5aGxn?=
 =?utf-8?B?QWZweWlvaWd6SjNxSnNwa0d2TlJTaDhJWnZqdURTK2ZUcnN3ekJEVHZING83?=
 =?utf-8?B?Wk4yemtkbkRFVlNPRit4aTJpVjREZURvaHdJcHZiV3RtdnFOMm1SenpONzU1?=
 =?utf-8?B?aUh3WktzZFcyemQwVTdDVWhmejNLVEtlWjBEMVNRcml4WEpNVDd3bWR6MVdU?=
 =?utf-8?B?bkJXVDZxVUhjdWJzMm11NUYrcGFiS1VrZlZBTE9vWnF6dDVudSt5dk1pd3hs?=
 =?utf-8?B?S08zK25Hc0p6NlhKQWxFdW5vZG01NDdkYStSMXNSUXMycTA5NGZiK3hIZjdp?=
 =?utf-8?B?bFdpWUM3WVZqKy9wa21oTWs1UlY2b0Z0YU5aeVJJc2VvVitRV3ZveDdPSlpx?=
 =?utf-8?B?cmxKaVNSL3kyY0E0VXVYOU1ha0pVcEx0NFhOdGt6Q2dQQUNWNjNweVJ1c0pX?=
 =?utf-8?B?Z3FrVHpDaEZwZ0lwNEZYcHhUOURHTC9nUTQxOHo5WnhWSEFsdDFRWGRneGM3?=
 =?utf-8?B?K1hweWVaejJEQXhKRFNwU3JYUEZBT1M3OGRQa01od1lqN2E5YVgyRzhDMHBa?=
 =?utf-8?B?UmlqMWJEbjVYeWJCSG4xSDZkT1Q3YmE1TEp0NXZ3bjk0bUdRa1lqMzRFQ3lt?=
 =?utf-8?B?Y0RJZFkzT3VvMTdNcGRBTTgrQVBhaFA4WmtmSytnSVFVeG0ySW1lTVpiQ1E1?=
 =?utf-8?B?SnBhMTJTMVJKMkpqTDZjN2xwUitmT1NpQ1Q0QmVqaVZMRlR5VXlZVFJHOTYr?=
 =?utf-8?B?TGh6akF0dExacjRkYnJuc25kT05tTU1HSVlKU3p1cTlDYUNGQkhIaTVPNkt1?=
 =?utf-8?B?dDR1elFKbGRqeGJnQmNmeEE4dThkSnVpc1VTMUFuY0xUdGJoZ1Nwb0lOY3lW?=
 =?utf-8?B?S0lEbExKY2ZIUWlPZkE1TXFOUHJ2Yll3NFoxQjc2a2licmpCZVVqNGVNWlNI?=
 =?utf-8?B?RTNycW9ZYU5pWElRVFdrMzVMUW1pWFVSanlqM0VrRXByVUhQVVo0K3dWNEUv?=
 =?utf-8?B?Y3N6TXFFZHJWeUlrbnFmbEoxbWlFRjRzV2hhcG9IclBaNlErRjNBTlRpS1lw?=
 =?utf-8?B?bzNVTU9CTCtCUGhnZHNPckxWaUpQaXZWb1ZWa1RqMmtSZmpsb0ZJUURiVmtL?=
 =?utf-8?B?ZHR4QnNSQWx1S241cG1EbkxwZkhneTJKQXl5UjBBTVFnQnhFYk9TZmQrWlJK?=
 =?utf-8?B?d1M2elFmdCtRSS9aYjdmdkh3Sk92VHpSZ0VDVGl4V2p0bTJzNEFRd0J6N29l?=
 =?utf-8?B?S3ZWVHZJWDBNNU9OTEtSazkreUFuSFAxZDkxc2h3M1V3cFRDYndkcTdSZmdp?=
 =?utf-8?B?QlVac1QrTmtDZU1sOS9idUdMd1hic0drUElJdVh4VThRdGgxTHVKUFEzR2oz?=
 =?utf-8?B?dGxNVUNKek5aVER1elRDS2xLZlBoTVVya3ZoU2poYTZCL3g0WkJkYVNwMXd6?=
 =?utf-8?B?QjlEY01rN2NnZjFIVHVtTTdvMllDWlo3NVVIc3JFMzZBRXNNektXcTRXZjMx?=
 =?utf-8?B?N2NlQkNNckwyaEJUMGN3TDU4WElFd29CQitWb1Y2N3JCdm5PTndUSy9tMVVu?=
 =?utf-8?B?RVU3TTAwZ0hPUGtLeXZLSkxlcXpGeC94YldHWWRCRzRKdTBZVVNRd3JxN2Jv?=
 =?utf-8?B?ZzdJN2Z2VE5CbEdQV0N3NmE5a2xvMm1WczJpalFxdnM1ZThyd2I2bXUzSmVz?=
 =?utf-8?B?UHlod3NtMk5wU1huZ0s2T2hiY1NrQ1NSMi8vODJUMG1Hc2NpTUFmSXQ1QXY2?=
 =?utf-8?B?MVRyeTJFWExDbEhOM0Eydm9NbVV1K3hwdUFtSVRTS0lNYnY1bGNJZ3M2eEZT?=
 =?utf-8?Q?jjtPI3rsDJCGjruE+f2HVZ2gA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e486e2-e029-4cc3-b087-08dc85f9512c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 07:21:43.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HklFFXkwknK0Ef5I7K/Psa0PS8NAf376kyIqM82+NATWZSTjczs+29yFtCBcEEz7+vHrvRu9ZJxXN+DsBYyR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6504

On 2024/6/6 11:12, Ming Lei wrote:
> On Tue, Jun 04, 2024 at 02:12:22PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/06/04 11:25, Ming Lei 写道:
>>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>>
>>>> Configuration for sbq:
>>>>     depth=64, wake_batch=6, shift=6, map_nr=1
>>>>
>>>> 1. There are 64 requests in progress:
>>>>     map->word = 0xFFFFFFFFFFFFFFFF
>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>     map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>> 3. Now two tasks try to allocate requests:
>>>>     T1:                                       T2:
>>>>     __blk_mq_get_tag                          .
>>>>     __sbitmap_queue_get                       .
>>>>     sbitmap_get                               .
>>>>     sbitmap_find_bit                          .
>>>>     sbitmap_find_bit_in_word                  .
>>>>     __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>     sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>     /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>       if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>         return false;                         __sbitmap_get_word -> nr=-1
>>>>       mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>       atomic_long_andnot()                    /* map->cleared=0 */
>>>>                                                 if (!(map->cleared))
>>>>                                                   return false;
>>>>                                        /*
>>>>                                         * map->cleared is cleared by T1
>>>>                                         * T2 fail to acquire the tag
>>>>                                         */
>>>>
>>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>>> will wait here indefinitely.
>>>>
>>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>>> remove swap_lock"), which causes this issue.
>>>
>>> I'd suggest to add the following words in commit log:
>>>
>>> Check on ->cleared and update on both ->cleared and ->word need to be
>>> done atomically, and using spinlock could be the simplest solution.
>>>
>>> Otherwise, the patch looks fine for me.
>>
>> Maybe I'm noob, but I'm confused how can this fix the problem, looks
>> like the race condition doesn't change.
>>
>> In sbitmap_find_bit_in_word:
>>
>> 1) __sbitmap_get_word read word;
>> 2) sbitmap_deferred_clear clear cleared;
>> 3) sbitmap_deferred_clear update word;
>>
>> 2) and 3) are done atomically while 1) can still concurrent with 3):
> 
> After 1) fails, sbitmap_deferred_clear() is called with spinlock,
> then it is pretty easy to solve the race, such as, the following patch
> against the revert patch.
> 
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index dee02a0266a6..c015ecd8e10e 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -63,13 +63,15 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   {
>   	unsigned long mask;
> -	bool ret = false;
>   	unsigned long flags;
> +	bool ret;
>   
>   	spin_lock_irqsave(&map->swap_lock, flags);
>   
> -	if (!map->cleared)
> +	if (!map->cleared) {
> +		ret = !!map->word;

After atomic_long_andnot(mask, (atomic_long_t *)&map->word), map->word
may be 0 if all requests have completed, or not 0 if some requests are
still in flight. Therefore, using !!map->word to determine the
availability of free tags is inaccurate.

Thanks

>   		goto out_unlock;
> +	}
>   
>   	/*
>   	 * First get a stable cleared mask, setting the old mask to 0.
> 
> 
> Thanks,
> Ming
> 


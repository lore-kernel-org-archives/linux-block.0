Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD91494D8
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249112; cv=fail; b=JzCQfFyDCn5fHn4TfzOC8AS8KQSGfrjKPT/VtG64V9JNBBq41xQ5mr/qSskx5z99Hm8fqbEEdnLgs8/jeB2Q5Q2WZaurWVPQkxqZOuCiBLLIC5MfuWBykA7L3Ots+y3VBMWrcAExblFvyI9L8PYd9HFfK6eKdvP6vsNcVw8IcfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249112; c=relaxed/simple;
	bh=ib9/VvP90OfZTUbjKsqhyRalNeWJ4S1sZCWE2CC4qJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6IsyemiyBL5IUHaBGvkgfIDGKWHS2XX0xn8PfKEljQ1zoWzOicO5zI8uyNuRht0YfNjKK7dWJlusZpIMtw4Bfp+52ZPd84P3YhsnVzCxwk1HGvLmsg/3saRZk4ctYuUKDrRIYJ2KhAbXwcMR3oZ+bblbFPVPZEmaDmyvA2sOIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MynO7qYe; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MynO7qYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azpjLHmWqIir+8MC0AvFDqi7HeQhmTtvEGaa0phphX/xhDfwlWtN+7Xvp3K3kn/1GcQBrzTgOwEg5MhKgd0BpaVMQhzPuzsBflNtz/JmKenWaup5RwsETHm26bXWdX/fpzT499I13BksbKbxe1Pi6vD6cvj1LJDW+RSomjgsASVF8mQtwapZYWmMKTgEzHHYMrHvAzLPkXrHALSmNqk+7M4oL8ZNUSSbLHh5yaV4fLiD3gcaug3NZRtn/1nDM2U6Ztrl/iLVG/+7y/u6S3G8s2A790YgT1H0I1PDFRU5ZIjPOoEIobrEYgN+1RRpNoE/6U8/yZDue13wk7okEenYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W92D4mXcelz7R6L/IB5lL+YgPOTZoH6fTlhjmhWxmvI=;
 b=CidruGAkdnZLVg6nO+VK905iCetSkiGKJQH82ZoUAuHS1hPrHURZ7bvzrwbpF4B+BFqEwDPH+or/u1402YQLcasm5kOpnUhHdUz8xdPAphqijVACskXy8FZH0pCOGgRypsAbxwXy0/9c20cBdUphW1cHqZPbJmjdjY23UO7IS9Jzp4FCNjw+tKJ8PmVPAfDlA9eFlPCeKKEGspc5DkuIn5cRHWcNFIdbq1r0Gtv8g48xNWCU+AqRGgWXPM1VXb4cI3pjPymapmmQkEv6JK/n2DYt2qR1caCtzDvxjhPw5sDtI+zmnH6tAQXo2h4scZwDBAEULtd6gZRen11ygpYK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W92D4mXcelz7R6L/IB5lL+YgPOTZoH6fTlhjmhWxmvI=;
 b=MynO7qYegsE1TvC88H886+UFIS3YOsqcUKO8nATGLniZSovMySoI1v85nfWBGqoghi7jtM13fSmCjgaeyXfJFrGDyhn8X5gL49GzpKnOf3txlt3+MBJLI37PDhuw3hh4GKSp2T5meayv9TY0TE2K6Mo2f7UdH+zBXxGxWKI2b2z5FL6pMZnmkUTtMQlbjsiaf2S3+2295rTFWOko/tnmSfw04wgvMP1tajLHsyiuvQzNGAe98Fc7BLKYD9ymDZQ0Qx+iIL8qtridBamjtPYHSQiURaBcAiT2hEGdR90rFjACEwlos5HYAq7ULweFszdRtLaHEMAJrCNx0BsLdogCBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:25:08 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 15:25:08 +0000
Message-ID: <2edafaa5-a74a-4577-8e71-37abad23c53b@nvidia.com>
Date: Mon, 21 Apr 2025 18:25:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <20250421105708.512852-1-jholzman@nvidia.com>
 <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com> <aAY2y7-XRAnOcKIi@fedora>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <aAY2y7-XRAnOcKIi@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec1c2f7-50e4-49c2-6bd3-08dd80e8b2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTI3c0xpTmlKc1NBYU1PbXNGUkZkWm5GaU5GdDlnMHRmZ09wQ3BFK0FzSFdK?=
 =?utf-8?B?ekxIcmp0SS80Y3VtV0sycjE2N0laUFBUMFFKMlpLSlFubDFVN0ZSTUpGSHlR?=
 =?utf-8?B?WnFWYzRQVU43alBPZEVTNmlJSzdZSTRWR1kraTRGb1hRT2dxRDBNUUNOVlRl?=
 =?utf-8?B?bWNCb09pL0tzYmd4RkM5RDJQakxOQ0FuVXJvUzFGejNLc2ZnN1BoTGhaSnpm?=
 =?utf-8?B?elRzN3ZmR1hCMVBzOC9vM0liaVV1WVFadnlCOFBNRWQzaFZncGpON3BlS3dq?=
 =?utf-8?B?UEZUWm9JNDh1V3F1L3ZJWDc4TXllNi9hNzc2bWtZNVRQR1d2U0dyZitXREt0?=
 =?utf-8?B?N0pURDZwQ2NNVmErUS9VSnVqVVhLMG5iMzlVelQ2bEZObGFFdlRvNmZDL2NK?=
 =?utf-8?B?dXF2K3o2UkFRQVJ3NUJhMTNmd2E5V1c0RW85YmVIMyt5d1l3Q2JRbWQwYVBk?=
 =?utf-8?B?bUtvazFER05leXgvc1BXV0pqS0E5MGdQWGVVQk1raUZhUDVKR0tUN1FWck9v?=
 =?utf-8?B?VVR2U2Nua1YxY1BJendxcE1pWWcwR05ld2VTU1pKZkdRZDJ5Z01RWmE0c0NW?=
 =?utf-8?B?TkdqWkZRYUJDQXBJN2pRRUpFeDJZOTM4MHhOZ1djaGRuamZFSVQ0L0pMZ1JZ?=
 =?utf-8?B?NDlkbmxJM24wakNLTVJSY2N0OWZBUTVPek9HOGpnb3RkNWhHaUlNQUVHVVox?=
 =?utf-8?B?RVYwNkc0K1VOSFdGTEtLbXd6NEVoam1BdFVpSElYZGJaYlpLVDJmc3pCKzFp?=
 =?utf-8?B?Z0tyOWROMks1RzQvQWFocmYyejdyWmlVWG14b3BNT3lneDdSbURsWVkyQU1x?=
 =?utf-8?B?aTd4ZEQrRVdzUUlMRkVjMDJtM0g0Nk5waEE1ZVNJUkxHaGk1bjIwN29rem82?=
 =?utf-8?B?M2VXUWpEU2ZYODZQeU1ueVR1cW5jc096MmJ5VjEvRVAwRGpKQnBCSEJieTJl?=
 =?utf-8?B?Nm05dzczbWdTN21GcmtzbTBJUTNxWXdoVGRJTWRXaGFVOERWem1mdjhJQXJN?=
 =?utf-8?B?bnlOb1NrakhtL0ZKMkNaTkxQWFF2M2U0ZkFXd05rQzFqWVBMRGwxc1ZtTzJ3?=
 =?utf-8?B?Zkxlc2lOM0p5OHFzbStCRDFBZjdyUWFqcGIxQkgrWFlGZDlmVE12NCt5OTNG?=
 =?utf-8?B?VzVEUDhEUzF3TmlBQjBxUUxNME5XUHFtRmZvWkdwc2ZXN3hpRDFrQTZBSzFC?=
 =?utf-8?B?QXUyQnlPdHZyOTBkVUM1OTZuSEd1cDlvV0I2d0lmcitRK2hLb3A0S3lrN2Zp?=
 =?utf-8?B?Sm9KbmZDazd3Uy91SjNTZVBWWWcxK0lQUnFJUDdpNFhLMThWWVdNK3ZBa2VE?=
 =?utf-8?B?YXljYzB5QlUwY1JvV0FwVVZwZWFXWk56UjZOYVJtSEpjMVNCUmQ5c2dGU3VK?=
 =?utf-8?B?RWoreFJRaDhRZWZWcE1XVFdkeC9nR0hDUlczZDlQa29oUVRiU3JtZVQ1Yzhp?=
 =?utf-8?B?a2c3ZHl3bzc1akl1QlBMdzlTZGs1L3htS1VMMlRac2R1WW9KbC9ZOGVKTndX?=
 =?utf-8?B?Ym5EMjRGdUxVb281UEhvbUZEaWZTTTJMMmRNOEM5QXBzUVQ0bERwblRLTE1W?=
 =?utf-8?B?UUFxWjJRUGhMVUVqWndsYVRkUWk4UERTN3BVVWxqeVFhOGQ2RTF1VDVmb0gw?=
 =?utf-8?B?emg0OXFIRTAxZkdpUFBLVEJqQjFEWUtUK1BkUmpHQng5OFBOck5sbVVhQ2FM?=
 =?utf-8?B?c3BKRll3TVA3T0RlbkhlazlTdkFpU0hYSVNNcGloeTEwUWxyWUIwOVNxdkRY?=
 =?utf-8?B?ZGozbHlPc1RUUVlhNzRWNVpPTDNmWWwwdDBRYWFYVjlJZDl3cVVHVStlcUx4?=
 =?utf-8?B?c25oWmJpdm5GZkFIMTFEaFQ2SmUxZ1NsZ010MWFibTZ5bU43YXdwWmlwYnpl?=
 =?utf-8?B?T2IxSmJWR2FqamEyUGcwdnpRT1hRUk5TSlNTZlFweHJyUUl2S0JIZHVITFBn?=
 =?utf-8?Q?xLfXqUbYETE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJvNjEyUWVhZ2JaY0dKRVEwc0JaZm4vRnU1elF4RVlwa0RnMjljRlhwbFVO?=
 =?utf-8?B?Ymdoajl6ZGFEd0NEc0tHYWRCVm5xbXo5NU5qTjIxcFBCd1BKbTBWMWk2Sit5?=
 =?utf-8?B?aWhlK3dSNnJBZEtXbHNNMnJDaXZHWUFLUE5vUnJjbGdFSWVudWNJUlFmOEJE?=
 =?utf-8?B?OHZZSm1xbFBjdHY3VzIzY0kzTVkzREFCZ2lzdktiOHRWdmR5Wkgxa1ZJWUpP?=
 =?utf-8?B?TGtPZHlFelRZUk82Q2dzS2hIdlFlMkRPRnBUdzJaYzVuR1dnQ3lsZ0o1bCtk?=
 =?utf-8?B?S05kVXhwVFF4R3dJSk9kV2VMemNhaGdJbXd2a3R5YjFmYUNxRWRYcURxcmJy?=
 =?utf-8?B?WGlNQXRPdml5TnJiK2UyRDlKVkxidzVZTE13U1V0QUIxWWJNM1lLK1Noa2Mw?=
 =?utf-8?B?MmZHM1NvaW1OanVpcWt5TEdGcUkvQXhnK3l3MnJESEpIRnVHYjBEakdOMmNL?=
 =?utf-8?B?T3o1MnI1SHB4eit0SXorSjlGSkEwT0pyTVNCY1Z0bWhBUjk2YVVheTBHUVZ3?=
 =?utf-8?B?dW9RQlBwb0ZqcXFTY3krQ2ZBQlFFSmFOb1JOMWhxV0FHcmozOXJ5dGdTb2hz?=
 =?utf-8?B?NGp4ZUozbjBZSlF6MmVpRGhuQlhvZ3B2dzRZNUlKL2VmanJrcDVzeHlWWG83?=
 =?utf-8?B?Q0U1TVN0RUwzU3h5RmZiUlJrYVlubEZPVXhybUF2R09MK01sUGhuelVEcHhS?=
 =?utf-8?B?aHpObW9kV1UwVW0zNlRPVTZWSktwTm82OWVEUjRnMDVSRHlnOW5wdmwzTnhw?=
 =?utf-8?B?bVE1WUU1QllwYnhpcWh4SlM4emRoWW9IUlpudTdzeC9YZU1Xd2VnTUhZNmpX?=
 =?utf-8?B?STZOS1hsRmRTTVJkV3F3WFpFTlVWeDQ1T3RvU3JKVnlpOERKSXR1bzZpb1M2?=
 =?utf-8?B?MzU0d0VKanc0YU1yK1VsdUFqa3NFaWJCcTYrcm1uVkZsZ3ROcFFDc2FDWXpJ?=
 =?utf-8?B?YjNtMjJ3UmNkZlZyYlBvTU5NZzVueC9oWDY0b1p0YjFSWk9Yd3dNWU9GQUNY?=
 =?utf-8?B?T21Pa2ExOEVvWUNoY09vRHM4NVFTM3Z6M2dRY1diMkQ4N1ZaUEtNTDRtT2Ny?=
 =?utf-8?B?MURRVUQwQjNraThmWExsc0dEVld6V2ZVUHB4YWVSMVpyR09MNUU5VWlIcHll?=
 =?utf-8?B?STJONk1GemhvRGNmK29Xckt1eDdPcE8vQUdNWDlGblh6aUFIeDFudFIvcEJQ?=
 =?utf-8?B?UXR2NkFrL09CNjVmWDFwTUw0ejI4Z0dFMEtVbkFsRjRBV090L242U3NYQUdK?=
 =?utf-8?B?T0VBQWVNNHFqN2ljUjZFUjdnSHF1QjIzRHh2Q09ZK3RQU1piM1Rqa2Fqbmdk?=
 =?utf-8?B?RWtLUHNkUldhWTlTS28zdTZyL3VtNVVTcWVLeXNiNkZoYVB2b0c1WWoxSk81?=
 =?utf-8?B?dnV5WDhaM2FCVkZSRnlJRW9rRkZFNm43LzVMZGxmbU1GL01PYzczaDJuQVJG?=
 =?utf-8?B?Ny9Dc2dVWHFMaHRZc1FrYjNWNzFOWlNQNGlGQTgzSVhWRU9wWElJQkROUE9z?=
 =?utf-8?B?ZXFXUjNRcjhXeHdaU010VEo1Z0Qwa2g5OW5Mcy9WVzJNQi93VldRU2pDcTFj?=
 =?utf-8?B?czVTWTVHOC9aeW9ZcjhmdzhHdlMrb1pjNGtOdzJxam0xUndPZHNlY290NzRl?=
 =?utf-8?B?SFU5V2Y3WlZld3A5dmVwT3NDUEhjNlhxWEpHVlQySVlTaDN6Q0NiQzlFR3VK?=
 =?utf-8?B?dEpPOUplWFdyZm5UYTZ3L2k3VzJHdWR4MWtGbTJnRkliTzV0SFVGbzJFcmlF?=
 =?utf-8?B?V2diK3RNTEcvNUpCN2xoSHgxMm9xWXl0OEZYamR5eTl6L0dzZWFZclRnNko5?=
 =?utf-8?B?ZlA3cWdFN2xOaW9OU1ZiL3hiWmVhdG1BL01meFVWL1Z6OEZHQkVYWTBsUldo?=
 =?utf-8?B?RHNDbi8rQkpHbE9kRHpZODVPdFFkais1eWtZL1gyWmJqZnVCQkRhdzAwRUQz?=
 =?utf-8?B?QXQ2YjZTY2tVUXJPS01PeWx2MFB0VWZTdWlyTTJRa0RKYi82YkM1bVRabVJN?=
 =?utf-8?B?WWkydHZDUXlzU3Y2QTJRTlFnUVVyczJMdWg3NEZRSUVFVDR4WGV1dUVLd1I2?=
 =?utf-8?B?YXRnWkVyRnZ6K2tCQjNkb0xKakZ2aCt3bnBHSnAyeWxVN3pRTSt3VUkzeEsw?=
 =?utf-8?Q?YN0BPnracsQPbplfrs+/PK08J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1c2f7-50e4-49c2-6bd3-08dd80e8b2fc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:25:08.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: astDHTkzrmA4OMbN0xWfznIfwfmYxEF1GQp2X67VAKvT1auXr0G+7yEUrTkNUeyfFhb/eDxVjO54zbQuRCyBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

On 21/04/2025 15:15, Ming Lei wrote:
> On Mon, Apr 21, 2025 at 01:59:50PM +0300, Jared Holzman wrote:
>>
>> From: Omri Mann <omri@nvidia.com>
>>
>> Currently ublk only allows the size of the ublkb block device to be
>> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>>
>> This does not provide support for extendable user-space block devices
>> without having to stop and restart the underlying ublkb block device
>> causing IO interruption.
>>
>> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
>> ublk block device to be resized on-the-fly.
>>
>> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support.
>>
>> Signed-off-by: Omri Mann <omri@nvidia.com>
> 
> Looks good,
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> 
> Thanks,
> Ming
> 

Great. Anything more to do from my side? Can I expect to see it in 6.16?

Thanks,

Jared

Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DA22157B
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798078; cv=fail; b=SSUqTn4aviLfzcd2alxarLJbCYFKyamOjKuKdgnzNAvH6pHFt3/RrgtysKOZkpGdm/gKUVf4QWPrCZbvFrWG8EiKoH8xVIMxNIkYBwFtA95JVcBWl75w9mYBjDqhasNB9iRJmS2s5ROyEPq2JFItQA9l7mOCwMsy9bX9mLgvgSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798078; c=relaxed/simple;
	bh=nHuabSWzRERxKMbdcFxjp3+svn8BumXKy8DE+zhal44=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=PNEnuTJKlGTL+lQLzizNmEvVN91S/6ISvEKZDvUdpkIHFrP2y1Y/V2NIhueIntPLBGUlEcxwn8GvGrWriUrT2VHkcaKfZVYL0e91M548rh8eXGt03ZXscL6N8z8+/j3USZTR01hCJANQ2rYitUFOP3hcJK6BtKfkVuc3y3sXme8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YE3r3yMV; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YE3r3yMV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaAzQND2Ugc9XIP5ia0SeH5m9YaBi+aMrMJrgMgP7fUyoYPEKtyItR/0Ybrx/fjuPhqbSFu3vZVtQsWDQtLaaMaTGnUaxIv28uMk+/QgaKbsIEaIE++XcxfyMlq0KWnmndwgekDG33pFG0yVqxd8iOBEQhmG/xOsWCL9e153VxYMXHLGj1Jrzrr6chqGlXKI6TOO5aj3fj871cf40ZpTjY9FooQIia/SSxATNZJZBISiKjVCeBOFNjH3zYKD3Qw/OXOEWzZcNLQKcxK0aJa1eYeGs3sqFOKHu8/OPyi20Pt4nyxFAwEZ4KNu6r2JS7dekjv1WgslKPEwNDCXVTrE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/0iFk6LsGFHZ3kxnsjr6n4OSwUFKgfMwETfRtfqqCI=;
 b=ySEvzl3i9NXZTCIsuKWJV8dxKwzoSKdw7s3rtf10HAtANiRgkVn1vq6PRB+IwdHslwRdEqvNFhV6hZ858L6+TntJT1oUuRuUXWbubcvC9ueKPXXNMdRn9KNJ20aQDqkd3i6At84gDwZS69PfqpKKsuWDeJIlrMpFLSf4s8mETVy4lrj+KHGnBiAzb+PHYl7HpOCGvuSGjoKyuLsG8IQymqjDxvex+lyeW5wptyrYmYMCZzgLGaQip2LNXZ+tweJIy/XNOwgnlz9YLm9dibjjfAKotrP7FzZABbuAjWP/FsDA+UMxs5++WUPu+DvHMoWFY+SPeloPwQkcXDgTxDqALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/0iFk6LsGFHZ3kxnsjr6n4OSwUFKgfMwETfRtfqqCI=;
 b=YE3r3yMV+WCOxnwAsKl0PiD2y8yv4D2LhNMrWPvhXFAcvjMjAmhnqPRUQhY/KHWHjXKzkNPaEHcVLcC8uiBIYuIpeetZ5SPH7ZEBWFofM5wXJiyB9vrsCXlk/hY1RxBv/a/6q/kDWXaJYdRgquS/0KyWHlVLmb9DOM/GclPu0AOuJ16MbbBRgwWFKoT51/9cflwT0Ltndfot1tLIoLs6Rf31OgFRKQYsNby2FT/svZOg8fPgUnde6p6ve8hSu2EbZyidfgcrdDRt/GH4Zfd1bJZIGLoHAdYmrzelO0Q/k65OIglT+PdAgppx1Z5Ae1CYYzxKtwWeBNXIxs704q8sCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 10:07:52 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 10:07:52 +0000
Message-ID: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
Date: Wed, 16 Apr 2025 13:07:47 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 csander@purestorage.com
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
Organization: NVIDIA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 25558d55-69be-4a6d-07fd-08dd7cce8c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REpRNCt1bjVzaWhnOUJPSUZWbFFLSXFWZzg2U2JxTEFSU1B3cjB3V25Uc0tE?=
 =?utf-8?B?M2VleTdURkEvWVVGSEw4STd4WkdFNkxaSXpYTEZTbmVLeTY5aUd3S0Q1N0tX?=
 =?utf-8?B?L0NyeS81RC9tYms4VkI5Y3RrRU5OOXc5OEtPR0dzMS9MMENnczRKK2R6WUtp?=
 =?utf-8?B?KzBHNnIrcmhMNmJCNXAvMk9uZEprVzNOY3JsWUdFOHlZZ2NCamZWNlBXdk9K?=
 =?utf-8?B?VWl4U0M3b0lrZFE2NUprbktoeTBvRTE3NG05N2hOenpXZm0za2QyeHVjNGY0?=
 =?utf-8?B?TklPaHNIOGxIUGYwRER4N29GVTVDSHNsOU5kUzJrN0x3UksxZ2lVQ0lMaU56?=
 =?utf-8?B?bWZ6Y21MdmdkazhEUzdESDVtbDVaMTBsSVZvb2t6N01VQWpmMlZoQ0w4NVIz?=
 =?utf-8?B?VFRCaFFxNGJKS0dWbWpZeWU3T2lRRkh0TVBGOFF1cFEzNmV6ZUNORXphQU1B?=
 =?utf-8?B?WW5Bd09sWFRJbmRVUXlnY2lHZmpXNUx3bGZSclVXZVhLc00raXhOaXM4R3k3?=
 =?utf-8?B?MjJFUGRjeHQ3eTl4cjdiaFE0eXgxb3BTSk5hQk42WURVcTU2MjhXVTNoc2xO?=
 =?utf-8?B?UklzRXlUSlJuTmxhd2llQm5udDhiOFY1NUhvMWxMdS8vUnVZMHRDTmFsSDZJ?=
 =?utf-8?B?YzArWGh2TWxXY2t4cnU1ZHlqUVlKdEFIWmJOV09ESlkyaERLeFVUVWNYemph?=
 =?utf-8?B?UXY5VEVrRStBUU9vNDZqZjVDaFcrRDRENTVVallrRW1VWTlIK2U5eEwxMzM2?=
 =?utf-8?B?clFITzI2UThmRFFJU2lLUklWaURTeUMraVIxUUJsb3Z5eFhuK2Y5SzczQ3Rl?=
 =?utf-8?B?c1ROZENjaUdWZFJyUi8xZ01YdXRGaWNlSmd3M3FlS1BuWEpJM3RzR3pFRFpY?=
 =?utf-8?B?bFJNZlZKbitvT2lRNlJUU1lROVg4RFVzcUdyNmMxMXBWcTE3N0pSMjFjb0xW?=
 =?utf-8?B?RWQ0Z3Y5YUZhVTZtMi9lOEtaeitldkpKd3o4eTcyR3ZsTHY4eitSRUFhNHIw?=
 =?utf-8?B?OWpLNG51aEY5cGp4TUZDYm4yRDA5KzgrZkNyUUZMaDk2OHhXbE0vWFp1ZFBR?=
 =?utf-8?B?c0dVMFN4emVnaDczVjZ6K1AreDJPMVgyNlBXU0JTbVRSWE1RUHU5MXZUOUJL?=
 =?utf-8?B?cXE0WTNzdEZwenhjSUNvRlMyTFRsWkxBYWZRRHFSa2FkSE5lalFvT0YvWEVs?=
 =?utf-8?B?cXVNT2tJQVdtampZWkp1Q0Y4MTVZeXlVZHRja2dTVHFRb1Z4Nk40SFBOWFBn?=
 =?utf-8?B?ZmlCaWRnKzJQUWsySVNOcXhMSkJtWXNwU2V1ZEh2MEFzVUx6TUppOFJEQVF6?=
 =?utf-8?B?K2hvVW5qanpDSUlJNzQyalVFWnIzOHhXM2dCUEg2dHJiYncrZERyZ0QyTEw4?=
 =?utf-8?B?UWFPcXV6TnFrblZ5aHFhNjdOTzFtb21RMUhvOFJUMTVVd1AyamxUeGQ3bzhL?=
 =?utf-8?B?NnBpUkdVQ3gya09qMUhJYVgyTWhEWEZGL0VGZkhBMWlCNGxja3pXMkNHb01L?=
 =?utf-8?B?bk9wTSsvWDNGVnNUMUwwLzl6TGVVTXAvVi9SRS9RcUtOeENpMXlicFV2TzZ0?=
 =?utf-8?B?QW8va2IrbCtaUHl6UlA1aHkzeVVlU2tmU2dHWXd0b1dwaEZKOHNvMmpLOHA2?=
 =?utf-8?B?WU1nclRKNXdidGQzVFJRcUI2UFpzcDV0ZlEvbVg3dHBLeFZxcWU2bERJUWNv?=
 =?utf-8?B?VlVuZlE3a0RWajZEUHU3Zm81UWV3bmFwaFhieklhUXVLazh3TkpGaVlCcnpl?=
 =?utf-8?B?RTNUVUVBbVJBa1VIZ3hCZmxJM2M1Vm94MXpoaGhERUNwbFppWW5maE8zYjFV?=
 =?utf-8?B?ZGxiNTNYOWp2ckI5WWVtUkFnMlF5ZGprK3J5QXBtL2RsS1VyVlVneFpHdXVN?=
 =?utf-8?B?SGt3RTBnTkFocitqL3ZhYyt0bVJvdmlieVpkSUpReGpsbU9XcnczZ3E0c21U?=
 =?utf-8?Q?Hb6X+VQag5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENNOHBmTmV4K3hKa1RRdmp1dDdQMStPaGFpdUozMmhrY1UrVHNsYTZtcmpM?=
 =?utf-8?B?NjNmVWpFL1dFRE85cTE4aVpuNVhQZUhnNmV1bkF3UVBQTVA2SngyWGZNa1Er?=
 =?utf-8?B?YzRObGlMMk5GYUM0UjA0YmJvYmRTTjhiZUNyTXhTWjhHc01zYmp1ZFlzMWpt?=
 =?utf-8?B?WkUvYjJLMlZiY1VVT1BLQ3RTTTVzTmczVi9Wam5JRERwbjFUWTlwckVQbDZU?=
 =?utf-8?B?b2QzL3RLQ2pkNUoyU0IyRWJITExlQnBLaDh0YnBqNEFNL3ZpcFhxdFgrRHZr?=
 =?utf-8?B?RUxXTmJhM1ZjM2Y2QXZEaFBZZmFicDlDU2FRMXU2a25ibjdyN0poZmdibFY4?=
 =?utf-8?B?Sy9QNU1aN3BIQmRJVUJwSmlXejNmeHpod0NyTlFMS3hOWHFFMCtLRmlydFhT?=
 =?utf-8?B?OTFhdCsrNCsxU0MwRFJBUUEzcmdIZUpWanRuQnFkbzYwb3cxS2x0cU1ZT3dJ?=
 =?utf-8?B?RDVNeUFIVTRsWmVyNS9YRGhWYUsweXV0a0pTTzBsVGVDUGdZckpDRzY4Nmtq?=
 =?utf-8?B?ZzFQUUZtUGJNSlIzQ1V6Z1g3TXFUd3VuMmkwcTZqKzdxS0cvNlhxOGNPSmUv?=
 =?utf-8?B?YkhHUW4yTE4yTnRtd2RCOWV1c3Q4djZFMEVVajE0NUF4OGRTamFNWjRhaDdU?=
 =?utf-8?B?VjUzWHZ4NElOalk4SnovaW5YWXVKQis1SVVHYTFMQkFweS9JUkcwNDNucTQz?=
 =?utf-8?B?WnR3Z1BzUEtFd0hNR21TOGJFeVJLSE1NYS82WklMY29HdzFIYXAzbGNncTUv?=
 =?utf-8?B?OGFPQ2xISU9tTVJPWC9JRUk1NzQ2VC9LYXRlVWVISHZvcW9oeFRUVG9RcmVk?=
 =?utf-8?B?WllyTnZ2cUVnZlQ1ampPenI4YUZzQXJQVGZRbE5ka1RjUFl1WXE3Ynl6Nmp4?=
 =?utf-8?B?bDZGMGJuN292cDB2TENCa3VOMVhCT0diSEUyTEY0UnhRRG9JM0NXTzNtejlR?=
 =?utf-8?B?NUU0WWRNQmpmd0ZweDk0Qk9sTFV3K0lQd1pyYXZkcG5Fd1NjNXhvR3Mybll1?=
 =?utf-8?B?TzVscXFoZm1CWENtOElFY2l0SEFlaDl2a2lrbmpKZkg3Q1grNW00dzcwS2hJ?=
 =?utf-8?B?anVpcGVaRTFKNG14amhNTmx3ekl3V0RnM0VJMW1zZGsxdWs2ZnRiQWJJSWxz?=
 =?utf-8?B?dWxaZzhucU9SeHpzUEhqaWtTZnEzUW1tNXdGNzZiSGNOMnFsSU1YRk5OVFRE?=
 =?utf-8?B?b0N6My9UejlaSDM5bFNMbUZna1pGaTNzQks2eFFrNkM2eEE4V0JaaGYxSzlX?=
 =?utf-8?B?Z25KY1owY3IvQlZIaWEyY0tZUms1T0xuSEg0L2NVZkNkU0ExbmdlOG50amdL?=
 =?utf-8?B?WVVPa1FNSFE3b3N2VUp0dFZNb0N0YmgrS1VtMndla21aL3RhSGJ2Y2w0ZE8w?=
 =?utf-8?B?TVFSTTFCMG9VR1didjRjZlRjdElTaXhTMk5KMHI5UE52bWZvcU5lK21oSElt?=
 =?utf-8?B?Yk8wcENpZUM2QmtLNUpOVExqeGZBTEMzQmVyRTZHdENRZmJaa2RLY2tGMjdy?=
 =?utf-8?B?UjIyMFhKd1pIQnYybjRJZXVtOGk2ckdtNExROHJMNDRHYno4aGJVSFJteHg1?=
 =?utf-8?B?amNPS2FJdkV1eTMvcUpHYTl1dEp1b3JiTVFzcGFvcFUvSmk4MzJXRE0ydDZX?=
 =?utf-8?B?Um9CQXNjaGJkQ1M1OWc3NUg0VHpwWWRiczNkWGI1by9DelZVTkhDK2RaTXBi?=
 =?utf-8?B?Yk9CSUY0MWRwM0VOYktLK1IzR3BtV0tndlJ0clJ2bnN5QUVrcCtyYzYwQ2xQ?=
 =?utf-8?B?K3g4by81YUo2M1dUV2FPYTl0bnNLczArbzgxaGo0K2pUcXprUmw5Z1dSYTAr?=
 =?utf-8?B?dDlXcEtkZzhBVkYrRkNnR2dpMFNmNXBwbHdYUG9VTDgzNU03Z2ZEbEpEMW5o?=
 =?utf-8?B?RjlzRTU1Z0ZpcmZsVU9RS3lyMjdwS3NMQ09HZEdNY1ZsL3RiSU1TV0JCc0k0?=
 =?utf-8?B?YkFGYXlVb2lWbDJFOTJPV010OXpkZ1FkZ3RPNks1ZEhYUWYxKzlXZXpNK0Zn?=
 =?utf-8?B?c3psSE92WWkwbkhIQ2RPTG5IZUdPbDJKUmNnK3dtbnMwSW1YM1hVUGo1WStG?=
 =?utf-8?B?ZG9sN1dxVnJmUFZrelJUYjkvb0N3ZkNWUUNJKzY3cUxMSFQ4MzVWVEs5T0dJ?=
 =?utf-8?Q?Rf4SXd/Vy5+/TMOjyc2WACHjK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25558d55-69be-4a6d-07fd-08dd7cce8c8b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 10:07:52.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n96e9gngxoCh9ksI1rS9Qr2ZOAKZJyZAGi7+5Ub6PKbI451kjCr0uqZp7VbCdMaSdmTsBmA0HXCvtvIQh7BTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Currently ublk only allows the size of the ublkb block device to be
set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.

This does not provide support for extendable user-space block devices
without having to stop and restart the underlying ublkb block device
causing IO interruption.

This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
ublk block device to be resized on-the-fly.

Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for 
this command.

Signed-off-by: Omri Mann <omri@nvidia.com>
---
  drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
  include/uapi/linux/ublk_cmd.h |  7 +++++++
  2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9..128f094efbad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -64,7 +64,8 @@
          | UBLK_F_CMD_IOCTL_ENCODE \
          | UBLK_F_USER_COPY \
          | UBLK_F_ZONED \
-        | UBLK_F_USER_RECOVERY_FAIL_IO)
+        | UBLK_F_USER_RECOVERY_FAIL_IO \
+        | UBLK_F_UPDATE_SIZE)

  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
          | UBLK_F_USER_RECOVERY_REISSUE \
@@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct 
ublksrv_ctrl_cmd *header)
      return 0;
  }

+static void ublk_ctrl_set_size(struct ublk_device *ub, const struct 
ublksrv_ctrl_cmd *header)
+{
+    struct ublk_param_basic *p = &ub->params.basic;
+    u64 new_size = header->data[0];
+
+    mutex_lock(&ub->mutex);
+    p->dev_sectors = new_size;
+    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+    mutex_unlock(&ub->mutex);
+}
  /*
   * All control commands are sent via /dev/ublk-control, so we have to 
check
   * the destination device's permission
@@ -3152,6 +3163,7 @@ static int ublk_ctrl_uring_cmd_permission(struct 
ublk_device *ub,
      case UBLK_CMD_SET_PARAMS:
      case UBLK_CMD_START_USER_RECOVERY:
      case UBLK_CMD_END_USER_RECOVERY:
+    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
          mask = MAY_READ | MAY_WRITE;
          break;
      default:
@@ -3243,6 +3255,10 @@ static int ublk_ctrl_uring_cmd(struct 
io_uring_cmd *cmd,
      case UBLK_CMD_END_USER_RECOVERY:
          ret = ublk_ctrl_end_recovery(ub, header);
          break;
+    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
+        ublk_ctrl_set_size(ub, header);
+        ret = 0;
+        break;
      default:
          ret = -EOPNOTSUPP;
          break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..587a54b3cfe1 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -51,6 +51,8 @@
      _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
  #define UBLK_U_CMD_DEL_DEV_ASYNC    \
      _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_UPDATE_SIZE        \
+    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)

  /*
   * 64bits are enough now, and it should be easy to extend in case of
@@ -211,6 +213,11 @@
   */
  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)

+/*
+ * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
+ */
+#define UBLK_F_UPDATE_SIZE         (1ULL << 10)
+
  /* device state */
  #define UBLK_S_DEV_DEAD    0
  #define UBLK_S_DEV_LIVE    1
-- 
2.43.0



Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19112620C4
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232678; cv=fail; b=aW/r/h/3ap3dt+ISBUwphJL+7vT7EROpqUIUqgbl/zq1jTnkVQmlPVi5yR800j41haHJDd0z08EV+YY3SRsq5Iv54yIz/exJrafdZ/kw3JwbmwcGwBFpvsBL4hgPUpNRDuqKJVMsFrytnADiNTL3eFZKlYq760cWkPxoxCxAuFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232678; c=relaxed/simple;
	bh=OtLf0eVEdhI4xnMVz7I1GjjGxv9ohv3V3O2blcKhzn0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1Wy2o/e+NYkjK0mzTTuOXRsnXCJx9pJoGXElUkZAH38aL0DXwNlHhu4sj8DlsbwxQaesORJHt9Z4uJy9WWtEG2l+ToWXEQP1knP9a5TLANzdLiUdvc95Fr5aq+vJu4VKwTFUxVm0dQrMv/QRGK1F3HHH+QzVNF5PTgY3MxGcHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZ2E9hKv; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZ2E9hKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxfC4WlMpM+s3qPrMLVOpJ5r/wD8VjvC1BotfwvT8PLzrSECpT6QABxLK6EB5zEAK3Vmq4lvH3YtWG53JVx034zohCRI9HiDA0FeHlF0QwoMzvBJc7ypG/JxEaaE73S1wsaf3KBceo4AYB5VOwIteD4n8GP2ZFodV8Gr7iRK5SRpyfnqWV653cb44RqmOucWYcaMhF3cvWZV6VzPMDQqoEGkGNaT69SmIkSHPz4IsqL3vyFreKTeSKXZxoN3pbNnw9r9iQiMCXzvq2mBfrYzEymgKTpuQh2wdH0mQRE/kl4jmv6Y4dgq1iWlxfgU4PYadR08qWID3VhHY0ErcDtueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj0ZhamlBCHGAH/p3zL/RATt75i4PUYi/VN3oKoMv58=;
 b=mYoH5hmGj+rSuAM4irR9shDbmw9X0SbA/AeCVBroWz4uqavU5sUJNEk64MHA7y2Ih5Y+jOytiB3Ag0VHRMBxCjBUe1IrTgotH1zDzEWMWPYVlFpn/3Orh5ihFMC4VEyRLrDLdUxF/J/fZNnvdEpvPhh3Tj1HUxdq9uP23j6iqeMKW98ggDtvo7PqHcLkHbkj/aTNbZACVZSIFSZN8FRZajbpSXgDXFCOK9yRY7WD8smvLY+uS2MhdCF6BC02tcis4DENOOjiPaH4sqYylPh8vKmVlNtpOtrAAbj7hNGI9/bAYQHaUlMCueAn85k6UTrDqQQ8lsBMUWusF2O2vebZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj0ZhamlBCHGAH/p3zL/RATt75i4PUYi/VN3oKoMv58=;
 b=KZ2E9hKvr7ra4GK1fgYZ3xmpyt7wAQBmD6zRThQBSTqxdNqe6r1OX1kU3GZoxnuskiui9Kb/KKBaoJR7PLCoKAdjDFiTaXETFKkQzHHPEDJ9Om5sm2bUOZGn4JcL6WSgh1XF3cRjbzSAckokP8GIyS+lii3tPbeaY0ZH+5kflyMVLb4P3wV5IxqBse1VjGzR/pJmNpDPMY+auyMYaOxS1sn5R72YA+WY2Grz2kf0LfKv5fqllPH8pvwmgpLmPMjBNaoXDN44Q3HSzYkMZ212ZjBMq1iCB+cHG3RBnBqKcMgQ+0EyDeZJnTXslwOhbSCGLixmOWMqEgZf+R9EqVGm5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 10:51:11 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 10:51:11 +0000
Message-ID: <5881311d-d506-48a8-a0c0-dd292d150726@nvidia.com>
Date: Mon, 21 Apr 2025 13:51:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ublk: Add UBLK_U_CMD_UPDATE_SIZE
From: Jared Holzman <jholzman@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Reply-To: Jared Holzman <jholzman@nvidia.com>
References: <20250420083612.247622-1-jholzman@nvidia.com>
 <54c01128-1536-4919-be86-9c655dd7adf9@nvidia.com>
Content-Language: en-US
Organization: NVIDIA
In-Reply-To: <54c01128-1536-4919-be86-9c655dd7adf9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a37119-34b4-4bd0-5210-08dd80c26e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnRBeFdRMi9BWmtRTjBvaXVmVXJGOFdnQjhOdHVPdmdKeStjTG1KdnBTRjF0?=
 =?utf-8?B?b1NJMlZ0S014TE1qNUlGLzB3Si81RzFtV0krK01ZazJTVnRkbldaNkI5NDk0?=
 =?utf-8?B?Ui9rY29KdTRmN2RVQTl3YXpaQkxTUnJDTDFCUFl3OXBLRGJmL0M2K0tES1p1?=
 =?utf-8?B?YUo3dmREcGRneldKekx0bVJBbFJLdHN2WUJQcHYzZ2J5YzkxY2NQakQ0eGs4?=
 =?utf-8?B?MDMrejBidUZXWldKRlIxaHl1RHBDZEVZVWlIbEh3SDRNM3NMT3Q3YWM4N3JU?=
 =?utf-8?B?SWNEZ05JQ0RmMkNJTnp2R29lVGo1b3lLUzI3WFIwOFhWZFovYS83NGtzZjY5?=
 =?utf-8?B?cFYwcFRoTjhTQytsOEcxZmV3RWRoMEZYUk9BanZKRzJTR3VCL0NHSmRKVDVJ?=
 =?utf-8?B?eHUyMjQ2Sk5VREsrdUlQZ3htZlFkQ1RaRGRQMDR1VlQ4Mmo1YkFrZHBBZ0dk?=
 =?utf-8?B?S2RkZHJlWnVOWi9tZmgrMUdaN21sVUlJSnRRRVNjT2ZOTkdxOHJFaW1Bc2ZQ?=
 =?utf-8?B?akVMZFBxS1c0NFdiVCtNNTNsa1Z1UVdNRC83M25kTnZwdVBYK3hEMkxhcUN0?=
 =?utf-8?B?MnRyVjZ0QVNrMGUwdXBoUlR0MUV4UURNRlB2bXAvWjhRa2tFUDd0RG1NMjJX?=
 =?utf-8?B?SVZ4VzJDRWlWek8vUjlibUFBdnVJcnFzNVF3QXFsTWZxeVVJNkhtNjhkK0Vs?=
 =?utf-8?B?dGlHcEpNeG5OK2xUckJUZFI1L25HK3YyNG5KV2tBWm9NOUNxQ25aa3g0QXRO?=
 =?utf-8?B?dXdQTENqWHB2b2U5elpReFpOUSt6STFqME1iQllDZUVrKzM3L21RYUJXQzhk?=
 =?utf-8?B?cnltMTBvZmhvQ0N6R21mY09TWjJ3NVE5OGV3K0RLRVFhdzduVTduSnVSRDBZ?=
 =?utf-8?B?OWtwd3J3MlBJaDkzd2gyNDdPeVZtWG9yam91Ty9tRm01QXNDdjAvbDExNWRm?=
 =?utf-8?B?QlR3dThjN0dqakdCeVk2akI3bkxLV2hBWEtqbUN1QTZYZGRKV1A5d3VFVVFy?=
 =?utf-8?B?Z0pNMlZoc21lcTk0UnlyWUdId1ZRU2k1NDZ6cXI0NjNtR3FSYjlqV04xUVFq?=
 =?utf-8?B?YjB0L09IVFczTXpNQm5pWnljQXRPSjNGbTgyaTd1TmZiUmtWMmpVMngzODBM?=
 =?utf-8?B?a0hNZTRCbW5KYi9WYzlDQkoyL2tOdURIR09RZk82NzJwU2RNa0FuZHRGNUI3?=
 =?utf-8?B?STh0S1I1akdhQ1FGRWVpV0lDcFhESGR3eTYybUV0SlJickUySU9DSGlmWGh3?=
 =?utf-8?B?Ry9hYnBWK1FIOWppTThYU1lSVWpkdDd5SWJHOUxsMGJFMjZGbzhDQ1pLMHZz?=
 =?utf-8?B?K200a041NnBManpaeUxOakJWejZGb003TlVCaUZSZE9PQWZxWTVzTEZ6L0cv?=
 =?utf-8?B?TGhML0VwMjdYbjZwSjBkQ3FJT2xlNi95N0lBZTJlQ2lmR1pzNHRDYnJUOFpN?=
 =?utf-8?B?MHlSVHp3dGFMd1FwUVRJajBFdEZKV0xBZTRNcW40VjFmZ3EvdXJwVUh5RkFa?=
 =?utf-8?B?NkZScmxENFZ1dU1iUm0xY2UyQTU0bVVpZEVQeXMrbDdyaHJCcW1IV1g4RGJQ?=
 =?utf-8?B?NUV6bGtabXBHbEpBSlJoa2I2ZlN4ZmRWUFVZelpCRkNvV3dlcVF3YnYzcG9N?=
 =?utf-8?B?OEFxa2NDVEt4bzJNbVFyRGFtZTRTd3ZvbkRkQkRsaTk2VVdnSVVEY1ZVMGYv?=
 =?utf-8?B?UDhIeW5BMWYwUVVCWjRuK1kwNTVqdTZ1dGlDQXJQVVBoWEtCWW9sWDlITWtB?=
 =?utf-8?B?U0dOeTZxUmlJL2l1SG9adnJ1S2tacWEwbk1GbUlJM0lpMTE2NWtqVlJHRmNO?=
 =?utf-8?B?VVN0T3dzWjZRN1JtdklJZ3UzS0hERGdLUWVvV0svQUF1dC9WZkQ3UFJwWEs0?=
 =?utf-8?B?aGtRdVphMzZ0Y09oTlNBL1Zra1NGdTJhOFZzNVRCREFINnJ1TFFsVnQwakJt?=
 =?utf-8?Q?lJ74dYTBlsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW85aXZzVnpuMHFLOUJBazRIdWRENXNMRm5FRkhMVFhjcFd0cEhwYlRqQ2Uv?=
 =?utf-8?B?V3NGUW5MUGdNMkhncFQ5SERIQUZLeTRmMVovYzRwREpSVy8vVllTdCtId3pC?=
 =?utf-8?B?T1d4MjhPYUo2RERla2JnL0VlTjYydkEwZ0RxcVNscG9RTFdib3hOaTBITitS?=
 =?utf-8?B?YUsrWlExc09KNWhoaFpJeCtkL3laOXkwZTg4SmhadkxHYUg4ZU9uUURWN3RE?=
 =?utf-8?B?Q0JpMXF6WlZmMHREeDcwcjF6L2dMU1pXbjF1ZzlZZng2a2Zyc2p3THlBWUZj?=
 =?utf-8?B?bzhWaTJrWnBmc0NhbXcycUlSSmx3TndhN1RKWjk4ZnF4RWtFMmlLSzlKZ3Fo?=
 =?utf-8?B?UFdZK1BCNEpOd2lycmRWRHhPaHBxTjQwalFIQkpHNFFXNSt5bnNWei8wRnZr?=
 =?utf-8?B?bk16YVFpdVFlcXhLeFgzQmFuTmhEdGNsUWFRZXNUbXdqcGowQnlwa1ZSSFIr?=
 =?utf-8?B?MjB0WU9ha2tLaGg5UFBRY0xCTkVhZ282ZVF4RHk5OUhiOGNuRnNPNFVlTTVj?=
 =?utf-8?B?VWtLYjRLNE02MHRna1ZwalZDTXdacFJFWFJRVUFQMU5aOGxEQ2kybE9wbVVR?=
 =?utf-8?B?RThxQm93T1B0QllRSW9iOCtFVzZBR1d2YXBzVUdGQlkrN09nODA1VFNqeldO?=
 =?utf-8?B?UVJPQkdPRmZVMmNUVXlSRmFCcFcveXFpK3FacW1VRTN4dnpCRGNsdjZNS091?=
 =?utf-8?B?VExRdTBqZWRaZmRURUhWMFVnNHkydEpLamNFbjZjZzF0THkrWTZheVNVWFc4?=
 =?utf-8?B?MExRYTBEY0IyREN0blRGMGZFTzlaRG5kOWtFcDhVamxtL1BZdkxZN2JZd3JM?=
 =?utf-8?B?V0VIbHVSdVVpMFZ3amJUK3hlajcwVWdCU1M1S200bG5lUVFVemhKdyt3Y1Fs?=
 =?utf-8?B?Z1Bia0pNSGt2Uzg0RmVGeXNVYkFQdWtGRjl0eW9SbTZHcnJ0M244cm1adHZ4?=
 =?utf-8?B?OUhXY0Y5K01keVBvSU9UQlJRQlZSWjZRQlJDNENPbzN5dGJmdVRHejNuSXRW?=
 =?utf-8?B?WVdCOXpSOFpnWXZVTmxXN2FUNGdxZTZJWkEzZFBwS1ZZRmVDRlJWR2F3RjBY?=
 =?utf-8?B?U1o1NDZBcUorS0I2Y0xFTjZ6UTRlbGtKQk9kZmtmd0F5ejhjT3hKTGdDTHJq?=
 =?utf-8?B?KzZBWTYrU1pTSHFXbXE5bGdkM05XKzN3US9jdnhOSG55TG0zM2M2bm1tMDhq?=
 =?utf-8?B?NVl5ajNwdnhXLytROTMyK25sY2wvbXFMRWNKbFhjcmt1WHpFaE5UVzA5TXJO?=
 =?utf-8?B?bTJTdWdJai9ocldpakpPN0RYWWtSajhudHpMK0hUQm43VW5ZeURNZ1ZCdm9N?=
 =?utf-8?B?dU9MUVBwcGptRUhkcEJIeFE4M3pxNVd1N1V1a3p1MUFLNWJuYXZzRWd0d210?=
 =?utf-8?B?eG1CemVRdmsxTEZZTFpMSnZpQUNwTnRMcktKVEw5MzZOZ0twNUVrZzJ0SjZv?=
 =?utf-8?B?VG1ZNEo2MmEwZmRUWCtMZzNURzhKVkh4OUdaYkZyVTBPVUs1VUdSMDdXOGUy?=
 =?utf-8?B?RnBFNmx1OGlwQytGdEtlU2RuUzd4anlXdVFwL1Y4Z201VjExVjlVMms0dG5K?=
 =?utf-8?B?NVF5TmpnV0JwTHpXSWF0Tm9qQ2pETkdxQXJMc1I4a0tXZ0NDa2kxVGI1Z05j?=
 =?utf-8?B?aHdUUjVCSFFkQ2tPMm9nRk9jVUdzajJzRXpXN2lCWnVPS0hxbFM2Znh5VEdO?=
 =?utf-8?B?RlZIYUdodGtlVnQ3K2pDOVRTNkF5R2pPUENkeG9yVkd0NitEc3pQR0wyY2Nt?=
 =?utf-8?B?Y1AzeU5rTE1VQjVuR252ZXZLVFA3SVJUVzNUd0FiQjBaS0Z0bFhLOW5Qcklp?=
 =?utf-8?B?YmRHRklGY0hyMmxOaGs2RU9aVnQrbmVUZC9VbWVCZlVRVEIzRUxvU3ZibzZB?=
 =?utf-8?B?aGlSN0FpOTJPazZaZjRHVi9Lc1hIRUlYNnMwY3NyTEJoMDUwblVYblpEck5k?=
 =?utf-8?B?RDRnUlh4R1RyVlNvU1lKKzNwYnl2dERBTEJnRWdPbmhBTTVOaTlRZkxFcjBG?=
 =?utf-8?B?NTlJaStKSnVXVjVDaGJzYjlQeGorZHFNUm1GSXBOTk1rRVNjY1NvbS9jT0N4?=
 =?utf-8?B?ZHRCUWcvQW5CU0dwMUllcXU3U1BOTUpqTkc5cUFhbTlzS1hYVS9sY29EV2hv?=
 =?utf-8?Q?rFY5eispl9HC+EiGbwKui3iDz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a37119-34b4-4bd0-5210-08dd80c26e1b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:51:11.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG2+2l+WTnx5TZeATYtZevBSbdR0+g3z5KIpmYqwe7ppWR6ijfi/IaPOlVn9+mi35Gtaj4J6RjmFTUgbbtX7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571

On 20/04/2025 11:41, Jared Holzman wrote:
> 
> From: Omri Mann <omri@nvidia.com>
> 
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
> 
> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> ublk block device to be resized on-the-fly.
> 
> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support.
> 
> Signed-off-by: Omri Mann <omri@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 19 ++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  8 ++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2de7b2bd409d..03653bd7a1df 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -50,6 +50,7 @@
>   /* private ioctl command mirror */
>  #define UBLK_CMD_DEL_DEV_ASYNC    _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> +#define UBLK_CMD_UPDATE_SIZE    _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
>   #define UBLK_IO_REGISTER_IO_BUF        _IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF    _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> @@ -64,7 +65,8 @@
>          | UBLK_F_CMD_IOCTL_ENCODE \
>          | UBLK_F_USER_COPY \
>          | UBLK_F_ZONED \
> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
> +        | UBLK_F_UPDATE_SIZE)
>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>          | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -3075,6 +3077,16 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
>      return 0;
>  }
>  +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
> +{
> +    struct ublk_param_basic *p = &ub->params.basic;
> +    u64 new_size = header->data[0];
> +
> +    mutex_lock(&ub->mutex);
> +    p->dev_sectors = new_size;
> +    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +    mutex_unlock(&ub->mutex);
> +}
>  /*
>   * All control commands are sent via /dev/ublk-control, so we have to check
>   * the destination device's permission
> @@ -3160,6 +3172,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>      case UBLK_CMD_SET_PARAMS:
>      case UBLK_CMD_START_USER_RECOVERY:
>      case UBLK_CMD_END_USER_RECOVERY:
> +    case UBLK_CMD_UPDATE_SIZE:
>          mask = MAY_READ | MAY_WRITE;
>          break;
>      default:
> @@ -3251,6 +3264,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>      case UBLK_CMD_END_USER_RECOVERY:
>          ret = ublk_ctrl_end_recovery(ub, header);
>          break;
> +    case UBLK_CMD_UPDATE_SIZE:
> +        ublk_ctrl_set_size(ub, header);
> +        ret = 0;
> +        break;
>      default:
>          ret = -EOPNOTSUPP;
>          break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 583b86681c93..be5c6c6b16e0 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -51,6 +51,8 @@
>      _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_DEL_DEV_ASYNC    \
>      _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_UPDATE_SIZE        \
> +    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>   /*
>   * 64bits are enough now, and it should be easy to extend in case of
> @@ -211,6 +213,12 @@
>   */
>  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
>  +/*
> + * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
> + * New size is passed in cmd->data[0] and is in units of sectors
> + */
> +#define UBLK_F_UPDATE_SIZE         (1ULL << 10)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD    0
>  #define UBLK_S_DEV_LIVE    1

Please ignore, patch has been broken by mail client. Will resend.

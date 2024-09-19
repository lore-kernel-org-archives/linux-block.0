Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED4194C8D
	for <linux-block@vger.kernel.org>; Thu, 19 Sep 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736672; cv=fail; b=NRNqEZPOjRWbvfG6bHY973rJ3ewQ8CWL6bkjLDWqrf1jTlJrwRk2xxs+y6FV5iYmJjqALEvFfr0giaZWExO51AgZl0uGSwU6GoxapliW28JIQc/HYzRKAKr/Lg7ERFMhfITZbEK5ghJni7vWQIi1AjpDEwUFSpg0rKFNMHB9/QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736672; c=relaxed/simple;
	bh=B7j2zcy6/MaaPpGt/0roQoaOJqEmB8HsS/w/P2T1UiM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOVEkTffCjkiqHhg/ZAyPKC4v2gv9U0ycheSm3VYg07DSLYAuC5rV+9VVYk8tBxj2Dn9hnAwMTQc4wQm5ZoLPwVUvB6ae4hbnkhDpYv7Bz88zBEvTwk+C9bOi5P1RsSNheYILPia8Ix7BfGgbdyNJ7uB/L0VxOC4zalKDJ6fF/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cAuIg0tI; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cAuIg0tI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxDoe4LJ4umCpzCi02qa/edV9K6yiNR6rVv2sYJFCJarKYVdX3sT/PM8z4/e+YKJOnqJgoKXpYYDlb1B1sKEJFgoAlaYF+fhNRELRqwjPRAI3iH5quRwLVFREeQWoNMC/HDeu6O5IuLJDcll3xyP51sZBr4iwR110Ug+03rys02yU/BrhhJC3x7kmvQMLG1fG/ffPntFIHXuLsMaEhlRIqs4GfKDuuobgMuNP2CZMBca5gMVyXmvVafB7wTUTXpRDxFgUoGKwtUPJBm7TEbcBABZoGs6i7B1sxCvdWwrUBYyzRDQN2hbKHP4EFlazr0p4fTcn9czO9d/FRUjvf9pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbLnmd1wavg10HytTObNuTsK0ZAw4NMskV5zjxPjNIU=;
 b=wlilqBNJedNy3aQgzJ5/wxt5nk4wzuvoCSzzE5FGwQSQ6e5dWX9x8Jenp1LA5cWfQW8Od7/+02cxTfLvlFHkwvp2THQgrWj59a14Vf7s/wWHJrreUJ2Ush76LwVwwBCTIrwuCKgw+qpXBYqd/n4IFKIMqyW/D0jSQE6xyzL/qenJrowWkB2cty6Yh48Aq7As6g1MZx0rWmy46geMXRhNfzW797XysmIPsHUFELkPH40cjzBX9/u98V+1fKx3MxLdxmeA1Py6gtVMQxRGgphDhWIaScKI4rD/5QW1XC6urUVIDdFl/AwDyI9+pkELQTQ1kS7iP1sm06Olmlba8oD7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbLnmd1wavg10HytTObNuTsK0ZAw4NMskV5zjxPjNIU=;
 b=cAuIg0tIgxTcNCbxGI6BiEIIr6u5SmS6KAKaRja5jByBB9ijsK9STUGAjye6QptbXQrjB4BqtLH4BJ/JV6/RBVaHlAMXgOET7sZQdrRH2WjgL7wk7EPTtw7oArbhTfe9E9w/tEtw92dRGJ6GZD+eSoby+zbwjwzA1IDHWEVjUpQsW2hWDAO9pdH9J4tKFSRWhXso8YN/0xXXVhJqo8XEy1efKyNxI/SX4jrhA/qyWCnvLz46UlLzyPo1BtGThQfO2s4nSHb/NHFLpMO+jGo/RvwPcnXHF+j7ylFyFCHQ9H+oCF1FZ56bWWapAAyuBLH7C6dwFnzeSZu24b9lQK5Z+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by JH0PR06MB6653.apcprd06.prod.outlook.com (2603:1096:990:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 09:04:26 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 09:04:25 +0000
Message-ID: <30b52438-9589-40f2-a0c0-550ab35c3de9@vivo.com>
Date: Thu, 19 Sep 2024 17:04:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/sbitmap: define swap_lock as raw_spinlock_t
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240919021709.511329-1-ming.lei@redhat.com>
Content-Language: en-US
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <20240919021709.511329-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::18) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|JH0PR06MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: a5800d85-a59d-4d52-2d10-08dcd88a0f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpIcHlwNXRBdUptZ3g2aTZKN1VOSkp1VTBIVUlMQWpmU1FjWml0VjVlcHJR?=
 =?utf-8?B?cHpzZzFDQXNYT0F1RG1Ca0c4NjRKdkw5ZDJHZFBjb3Q0T0VDZHFpNEhJQ2tF?=
 =?utf-8?B?SmZCMzRhVTQyZEpMRUNqUUd0bThQZjM0RkMrQTZKTkNaT0FMdXQzdmNDT0d6?=
 =?utf-8?B?SU1CeVZaclJXZmorTld0ajNkaFY5cVFSUWlXbzMrbGJpOFdlbWhRNUhRbWly?=
 =?utf-8?B?VldHbWIvTk0wUnB1RnZ3blM3ZndBdmNKZy90dW5qTHhLSXlwWUdoNCtNdGcw?=
 =?utf-8?B?TzNkcUpreHk2M2xNV0tXOFlBNTJMeE1ucjNORFo2KzFwWW1PNnpiTjdZNTdm?=
 =?utf-8?B?Wmk4bE5VWHhMNmxFUDROSkxSamg5STNaSXdSQjNGRXhBandKaE51elZnTWdx?=
 =?utf-8?B?bDdpbUprRWkwd2ZaMmcvYW5QNE5OUmhHTnl2dERDMlJwd3NMVk1TY1kzcEsy?=
 =?utf-8?B?ZlRYdnJWL1pwUTAzNjRvWnlLM0FvS0QwU0ZZNnFDeVRNMHRHQU9Bbm9pTXhZ?=
 =?utf-8?B?VGt4dzZGWGRhSDlYcDFVWmhwVDJkUHVrSm9pVmZUUm9LOEhUNEhGdVlxZDFu?=
 =?utf-8?B?dnFTL2RGK1dIenhJaFBUWTQxOGJMZ2licnVXZWx0K2ZvQVFuRVlqQitBaGo2?=
 =?utf-8?B?d2VhT0FiSktPOWczS1dKOUs2aHhIMVhqdWF6TWRLeXFuQzJrT2JlNi90OFVn?=
 =?utf-8?B?SW9IUFB4M1BIbDN1VTNDYkNXM3ViNVVQcENUTGJmU3FLdmJNMHNCMUQ4U0lr?=
 =?utf-8?B?SGNXbjlUU2ROY0lGQnphVHhQTzlKcWJmQUkzVW9LT2VRenNRNkw3OHBGQklq?=
 =?utf-8?B?NTlrclU3VlVRMXZYOWhRdzRTZjRQZEVQRDQvSHZQVlNET09QTWJhUzFGMGhz?=
 =?utf-8?B?Nld5TkQ5a3orOE5YRDlNYVVhd1Z4eW5WZFRHenplMHVmMGdVdkNUK1pRU24y?=
 =?utf-8?B?QVV3eXA1M052ZmtVVEpUSTRMc3YydTY4TzVuV2FFSTRZeWppeFNlRVRESUli?=
 =?utf-8?B?SGpjR2xpclF0dWFkaFB6RFBUb1ErcDhNNzJadXJFWnlwZitRSUx3bytwWjR4?=
 =?utf-8?B?M3JQK1BZNCt6Ui9EZk5BMUJEZEpvaWxpRkxMendIeVdHZllXdjB2NWlWNUZx?=
 =?utf-8?B?NmtVZy9rb1laWXB2WElTNjRucm4zbG95V1N6RE9rRTJNa0dRaHh4OEhOSnBR?=
 =?utf-8?B?N1h6YThDS3BLdkh5Y1g2bzVlTS9PYUluTWN3QldKQ2hCN2xtQ3oyMTdzSnhq?=
 =?utf-8?B?ZUhuUkZRdEtDek50QStoOWlkNWtmRFNTOGtXMVM0cisxdnZsQ3d1amhwM210?=
 =?utf-8?B?cVNYOTM5WElHdW5mMG5IdzZvZXlBMzJDY3Y0UTlqbWI4cExSK3BFdEhsU0lB?=
 =?utf-8?B?UXdOYUkvcXpPc1QxejVmZThvMDRuK1g0UDB1TFZ3K1g1YUNDbHJaVDlRQVpI?=
 =?utf-8?B?ZFZvQW1OMTI5VjJmYk0wbnFNbHZkODdLSHM2Nklsc0liOE1tSWtNSTdtNzg2?=
 =?utf-8?B?M3RsSFg0dzMwcUEzQjBWcUdyWm5HV0dZNkFtbjBXV250SDhBc0dzWUtWd1Zh?=
 =?utf-8?B?T2tnMkl3YWlUU25Vbm8vRGNDSzR3L0JQdjlKTllCb3NSZ2lxNDlENkgvRS9s?=
 =?utf-8?B?bHc3UXRwazBHUjZnRGt2MytwVVFybVdpOGUxeURBSzRIOHlZT2s2MjJVL1pt?=
 =?utf-8?B?RWNlS2ZEMmtpRnEraVVOOWo0QjA1SUZodkJabVlzZWJkOWRIRXByS3Z0RkpE?=
 =?utf-8?B?YldOdTJMZFVLMTNER3dqY25aQ0UzbitFaEd2WjNLdEsrZ01rQWlCMTF1QTh0?=
 =?utf-8?B?RHBveEhuRkpGajNPdldnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdYZzVGSWM0a2FOYklDUVc3MWQwakQ5ZlNINXYyYmJDNkZ3ZE5rbHFHQkpM?=
 =?utf-8?B?b0NOVEhtOXNNQVpnRGRGZXd2TjdJTjN2RDNzdFBoSUtGUU1RS2x6cnBxSWhw?=
 =?utf-8?B?bmtQVTJtbmtqZ3dkSDRvcmN4b0tLT1hKNUNJSDUwYkZqS05qemRJQXkzVXBG?=
 =?utf-8?B?RGhycEZZUXRlOTVnVzVqWnp5Q3RJM0lUL1k2czJqZ3FqRENzRG05RXI4NjFM?=
 =?utf-8?B?aW9nMWFhTDJPdDdxTGFLQUNZZFNOdnJXRHFlclMzK2JxbStYU1NrQjU0WmVO?=
 =?utf-8?B?dWd2QmxUL3BmZkZoZzk5WDRpbVBaZi9uMHBvS1J1L2c4Q2tibURzbkFoMzR1?=
 =?utf-8?B?OXM2aGlpdHhzV0M5Qlo4enNwaFhYOUVmR2Z5UE1XclZ3V0VUZnljUGYrU09k?=
 =?utf-8?B?WkFUYVlpWlg5eE8zS3hnbGYxbUdVd3lRWXpKRWUzcWhSVWYybWQ5SUsrRDFp?=
 =?utf-8?B?aEF4ZjlIYmVLeklFeHc4TVZVV1dTVG50eExYT2N2eXJjSUwvajhheEVoaTUr?=
 =?utf-8?B?dUp4d2xxNExlTFBtU3FrbW1KNzhVekdjZThqZGl3eUVxc2VucHZac3hQNDli?=
 =?utf-8?B?dG41Y0o3cDRXS29BVlRFd3d3YVRuZzFERkh0V0J5Q1ZtbmFsbmpENG43RmJC?=
 =?utf-8?B?L09Oa3ErNW0vUXRseWNjM0FVdU5jRE9VanVsZ0QyZm1MS1dzZnNrZDVxNnNZ?=
 =?utf-8?B?VTdIWDV2SnRVSDhDT1o0SzE2ZGg1VzFDUC9JYnFBV3ZsYXJXNy9abkRsVjN4?=
 =?utf-8?B?U21EeVdjYnRaSzdzeGQ2S3BlaFdMb1NhNk8rb1lKT1hXTFl5bytiVTg2ZmNt?=
 =?utf-8?B?cWtjNm9kdU1GZFlvOHBXbVVoVlNVZWFvYjBPclVDSTRHZkU4em1NWGRFZmZa?=
 =?utf-8?B?RW1QMlVSeFZ4QzJnN3pjVStzOUN0bnNFSU1YS2g0UXhYTXFoTjBrZUw3UmFw?=
 =?utf-8?B?U1RFYkgvU0l4UnhvckhHYzRrSXkvSmFqUW9Ta2IxbWJBWnVRUmROaXk5cE5L?=
 =?utf-8?B?RGcvNmo1V2Q3emNxbXFNQlN0UllDT1hONG5iSU0wd1BXSTFyaGNrd3o5dkpn?=
 =?utf-8?B?S25SN0pwdUdHU2h6MjJUVXVxeEJ4UE5qdkg2RWJZZFJZcDRyZStYb3JsOHFQ?=
 =?utf-8?B?RXV2TnkxTy9XVUpNT1laRHRXa1NuRmhHWDhkY09SRUhRVHY5c3BZUzgzemFs?=
 =?utf-8?B?aC9TZE9ZQjA5WXR6TWJHbHhDWXNHcStwbW1FNkdmN0dyUVB3bENlbmY4WEc1?=
 =?utf-8?B?aXhTcm4vRmFkRVVxczZMeHlEemxDTzdIaVVmWWJscGEvUERRNUZYUHQ2L09E?=
 =?utf-8?B?OE85Wnd5K1lZN3FlZVNXRStZNmU0MDc1VDBkVGp3bXFORWt5M1VkcnJVTUVC?=
 =?utf-8?B?MGd4dXJuQTU4VklLNlY5SEgwTE1ZZUUyNXUrM1haYnIxcXIybFFzVGk4WGVl?=
 =?utf-8?B?czZEczJXZ3hlcVJiMDg5MWFSbjBGVWxVQ1NvYmxsd1lncVBIYmd4dUt6WFRE?=
 =?utf-8?B?ZVVteC82ZFJzaDFjZ3ZIalJpajNtTWdBbC9JTVFNQ1owYTkxVSsxWXlsN01i?=
 =?utf-8?B?MXliVVdTcnlaYjR2MHA5QkVBS0RmN1dvV3lCUWpRNCtzSXk2TDJwMHpuRGpT?=
 =?utf-8?B?ODZ6M0tQOTU1K0RXQnJHZDJyVy9ESWpTK3RoS0tuMEZINjVyVys4UXRmME5k?=
 =?utf-8?B?MC8zUTRZRTljTVdQSmsvNndHeFppbGl5c0VyTUlBNGlLelBQSGtNV1N3ZndO?=
 =?utf-8?B?eFk5aFBVSk9ZejVqM3VPeFhOZlVoSk9veGwrZ3kyK05yRnJRTjVWc0VFWmlM?=
 =?utf-8?B?MmtNcG1uTWtRU1dpT1RpclVkTW5FK2N6Sy9DeEgyQktlUDRhaWhNcDk0ampk?=
 =?utf-8?B?OWtOM0dSL3plVHp2eDJjUmd6TDFmeGlYR1FPaFE5azZCUm94ZTZpbUFqdzAx?=
 =?utf-8?B?cG1SQmZDTDlqaUFadnZGRGJOaXZmQzZIM2s5amhFeHJ1VTVXSGx2bmVkVWhW?=
 =?utf-8?B?bWppVUVhTjVSdzAvRjlpWm81aVQzN2JPbDltZGxhNHpiZS8xbHVwSmpJQ1hH?=
 =?utf-8?B?QzZUeUs2SDZaUmwyN1R5d3hQbHFkZ1VQS2NrRjd6M1pvTVNnVTBwc3kwbXNa?=
 =?utf-8?Q?ALiqqup06XrEQlW2Z7FQBtujh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5800d85-a59d-4d52-2d10-08dcd88a0f3d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:04:25.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYQeP4df/3b6/9hx/qvl8uEmp6P8Q6iCCXRFyrSxsXIQ3aR7zdUX8RoX0PbtZwCQJXMgMjerHprT24SnEqNf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6653

On 2024/9/19 10:17, Ming Lei wrote:
> When called from sbitmap_queue_get(), sbitmap_deferred_clear() may be run
> with preempt disabled. In RT kernel, spin_lock() can sleep, then warning
> of "BUG: sleeping function called from invalid context" can be triggered.
> 
> Fix it by replacing it with raw_spin_lock.
> 
> Cc: Yang Yang <yang.yang@vivo.com>
> Fixes: 72d04bdcf3f7 ("sbitmap: fix io hung due to race on sbitmap_word::cleared")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/sbitmap.h | 2 +-
>   lib/sbitmap.c           | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index c09cdcc99471..189140bf11fc 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -40,7 +40,7 @@ struct sbitmap_word {
>   	/**
>   	 * @swap_lock: serializes simultaneous updates of ->word and ->cleared
>   	 */
> -	spinlock_t swap_lock;
> +	raw_spinlock_t swap_lock;
>   } ____cacheline_aligned_in_smp;
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 5e2e93307f0d..d3412984170c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -65,7 +65,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
>   {
>   	unsigned long mask, word_mask;
>   
> -	guard(spinlock_irqsave)(&map->swap_lock);
> +	guard(raw_spinlock_irqsave)(&map->swap_lock);
>   
>   	if (!map->cleared) {
>   		if (depth == 0)
> @@ -136,7 +136,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   	}
>   
>   	for (i = 0; i < sb->map_nr; i++)
> -		spin_lock_init(&sb->map[i].swap_lock);
> +		raw_spin_lock_init(&sb->map[i].swap_lock);
>   
>   	return 0;
>   }

Looks good. Feel free to add:

Reviewed-by: Yang Yang <yang.yang@vivo.com>

Thanks.

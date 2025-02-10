Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226061957FF;
	Mon, 10 Feb 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187289; cv=fail; b=sU2iFZ2FhCUXQj53KdDdvrNxPWcsyriaZYAcuPQQ41vZz4l9Ot9eD3b71iayjFGc3bLzAQ3Dwb/dy29TvOsECStoMXVFzepjRG3aLYaL5nA6hJ/JNiZ8yvBA/pXkBjNTLcS9cFa5nVAF2CVPj8mnDgKDnesY3eQexzIAO2aOsow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187289; c=relaxed/simple;
	bh=QCdILBPcKhqNW/5HhexLmfNEHHE4LNLWu/KgI8xLHUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nCQfV9OgngXs/HY+WB3f7FDv0S8+RcUeEHR6BP4Fx+HFSVHz3AEhPlgabQ1iVv9MxxJoR74g6W9/MgjFmT6idrqcewRINX8eZmLn3EB92xuZtSOFNLUFsVAIllMCWi5b3iJZmYG0FLbhKyVGFV6UgzMtpz14+FTu4TqzClKvwIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cP2yb1BC; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cP2yb1BC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vknKnJbmB6eVmNq2rvvmNm1MfIxG9+1H4HRda46caaNhyQgajLg19srhBZ7DBZ7Tbhh8rjhd2AgIM/OhoUzF6icwdYFGyGB4KfEfk0wIcv3uQEvOZX3rDceP/daYwu4oCos8Pdb+xxCErAZaUAgqYTFESFwxyE5XzLPnIbuP9LqNBoeL6/K9+iCJEZZrxQ/KkZuZuhW7YGqg32G96Zhb09jJqfI4zZjkzKNQcnhz39UsepQGNwRlLGt4bfJRW9dzHhTOz0LoYt1RYja5GLuFHdF/inJJWTxm+/U/xrWQYjW4K/bXc6PY8rgL1/otvJUKwlb/Z4oEWmsjjw88Ou8lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SctFNPkpmMmdCh6G+YK8LV5MjGoRv9Pnvl64Q3VnO8=;
 b=b49ihCWdGlH6ZSg8OuNfB9dI4EhwvWq8f218RrPB6zT2L+Q82iN96piU1UMIctJjQnx7tEqW7IK1Wib2LyahI89+70a47R4u9Swvv0qVjiEHpuGav4KVfBciJL7XnOjNJmObsUyCxqi0T/tl2B7yKH5jO1qADzDYLMtSRzAjiJsVnyip9OEAqAqPdV2WBmeatMsZxFBrVRGuo7+dJzGjS9nudkI713knV9uxwjJtwrG8tMwiAhUKma2jevYK9o1TliBTo5bTi9JU8oLfYV5CkRpuU4iQjilSMDnDjepn2O52wlEPj37gm4usJfZJwT3Pnj82zlot7dYuJj5984uwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SctFNPkpmMmdCh6G+YK8LV5MjGoRv9Pnvl64Q3VnO8=;
 b=cP2yb1BCDA7h6LvTGNklWg5Ml9YP35r+L539k2MVmyZfeNIljRQ6YW9sZB222TU72zdyevKE35EwDrrlAyad3xLIFxBqkqkprX7R2BSGUPKau1foyxbj5/s23VdGu0Wv+0juY5UOelyVeJbV3TlE/DYPS1ovGAeqfGrh7Pr3QlwHNgiUmAx4PDUa9fXvpOeiWqBxV4cMeQzfRh7aPmNSGYuYPwDOFF8z/eXKQayV9AkO3sIGHHX+0beVLqfjfqoP7/jHXtUEgP2D/mg91WPupEgInXAGSJ7+j6Ul2PxqDDcwFLLJ6ON6Keswexbs7++RQyxR7JslJx/D0IN1u5oxrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 11:34:45 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:34:45 +0000
Message-ID: <95d1a1ad-95f9-4fb0-973b-7a256528d4d5@nvidia.com>
Date: Mon, 10 Feb 2025 13:34:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>,
 Maurizio Lombardi <mlombard@bsdbackstore.eu>, sagi <sagi@grimberg.me>,
 kbusch <kbusch@kernel.org>, sashal <sashal@kernel.org>,
 "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <2025021019163296203221@cestc.cn>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <2025021019163296203221@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a715e9-e228-4c97-1079-08dd49c6eabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0wvWXFHaFozNHBFV0E1Y3FpZUJROGZuYjk4MFJ0RHhSMWZOcG9WL3UwS3FN?=
 =?utf-8?B?cjcyVVFPa1VHemp4RUhPU25lQ3duNE5qNFZ0UVJiQ2NCNEhSNS8zZ01wNGRK?=
 =?utf-8?B?S0hnM25zckFKYVBnS09zODc4TlBrZnJENFArY2tqNlZvbEJ5aHphdFhiNnpa?=
 =?utf-8?B?ZnVOZ0lrL0dvT1BCZkJrMmtrdU5CK2dFM1hRNWZucXR0akFJdUxGenNXZXFi?=
 =?utf-8?B?aXhtM1puUXYrUkd3cG5TTzBlUmNNU2JwU1BlWUROMkRQUy8rVjRnU1ZpVjNs?=
 =?utf-8?B?OVZrVTQrZlFITVlaK1g5TFNHbnhNZ051L1ovZzZjaStaM1Zpb0gwY0tqeWxJ?=
 =?utf-8?B?akhNTStnSjA0SCt0a0dDTFpwYUZZYUd1REs4UENBQzZxdWx6Qng3Wjc5UE51?=
 =?utf-8?B?MmtrOVQ5UjAwbGpSUU1CaG1CSzJzaFlEUmpacEp4Q1kvbTlNV05jOUpLTkUw?=
 =?utf-8?B?WTVlN0g2ME4yQWZQNUNRcFV4UUxkc2taUG10NFFUQjBLQzR5ZFpXOW1NRFYy?=
 =?utf-8?B?MUxNSU94amRsa1hPM0VRRHdSek5lQlorRXlJZXpSQmdKYzA1RDU5VEVWaEo0?=
 =?utf-8?B?UkFZa00wSS9abTRVaWhkL0prZ29Ec0RMc25jVDNsc2MzZy93VFBFRmlBRXFy?=
 =?utf-8?B?eDFIN29CZm5SN1l5b1JHOCs0MEk5UVJoRldZdDdCZUZ1T1VTaXFSK0pLazZz?=
 =?utf-8?B?NnJUZ3hqYmIrQnRINHhTMzNnN3BvWVpwQ1U5TlpxVEpNZ3l3UE4rV214L1FE?=
 =?utf-8?B?eVJha1NHRERCVEoyY1JaZXFVZTVKK0pHSVNEU1UvQU93bU8xRU1ORzJPWnY2?=
 =?utf-8?B?eHc3YWtSSzI3NFhBM0hrK2FMbTJkRTlaa05tdUlqQkpwRlJoUm5JNWdUTFNo?=
 =?utf-8?B?blpjbk9xcks4MnIxNVZ4elZMN3F2UWVHbDNVcUJYaWFkTDlQOC9UUEVNSjQx?=
 =?utf-8?B?Ti8zaWdjNlI4cTQxelVnelh1cGp2bFZ5dm1kRjgrR0pUa2RXNjhzZmg1eDQ5?=
 =?utf-8?B?Y2xxSEFvdUpZTXEyRFBUTndWOU04WmRIRStYQjNmTVNFZ1U3M3JpcHlMdEU2?=
 =?utf-8?B?TG1XaXQwelZQaUxaTXpFdHFxYXRHQUFuSGh1Q3BlYis4ODM5Nm1BRlM5cVhz?=
 =?utf-8?B?QkIyWkxrNkw5UmNzdlpUeTQwUHB3OFVLcVJUSUpzU1M2dGZndm14eG0vc0VJ?=
 =?utf-8?B?NHpVRnkzUm4zMVUrZi9OR2pXazNCUXhUdUlMa2w1STJ0dEE3Ny9TazJUUUR0?=
 =?utf-8?B?S05rZ0J1Ung4cC9YOWRmNjdZK1I1dW5sZWZzSnlQMXFjcFd5THJUdHZEbHl1?=
 =?utf-8?B?YytKaGFjNFlXV2RhS01xdkEwZVA5RzJ3eWVkaXJ0S0FGenp5Q0dra1dwdXVo?=
 =?utf-8?B?WFpuVlNleVNTMjZaS21ZVVlLQkU5TmlKQXlDQmtObElvbXdiTWR3Ky9FcWQw?=
 =?utf-8?B?Rjkreng3eWdPYU1HMUVkd0MxV2RtNlVIaHNEcGhCL0s4bDU3emtBRWNPT0JS?=
 =?utf-8?B?ZGRWdlVKZ1g0LzJqSzdySWZVMUtiWGUzOTRJWWdsa3M2dGFPOGZIek9rbUxi?=
 =?utf-8?B?RG1sOS9PZ05VTlNaS08zVWVhTHlaQW1yb2JrWlBwVlJrL3RpWUxKUlBWaDZv?=
 =?utf-8?B?UTZYVmtXdHd1Q0I0QW0wUzNtQ1AzLyt3ZlhEMFFPeXQxTlN3aFFobGd5dkFT?=
 =?utf-8?B?blBFNi9VMnN3ajBMRE9uRVVMaUtNcGU0TlBsaU5Qc2lHdWh0WUg4YmQ4Lzdq?=
 =?utf-8?B?cW5KYlVmUmtlMEZqb3pnZ1JqeUZidmVMQUFiR1I2OXdUdDc1RGxMT0JmSFZz?=
 =?utf-8?B?ckNRckd5d3hvS2FFUmw2NG12SUZyWXpoS01ZS3NPOXU5dmovMHA5bXYwb2Ex?=
 =?utf-8?Q?BpalQxVqfjNVN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THg5ekt4RzY5UUJZMDZWaWIxSzJkNW1mRzZHTmRrTWdWU1lQYnNGcDZLNk0x?=
 =?utf-8?B?aCtHLzZVTEwrV01qeUw4TEdNVUF5MUZQdTM4RktYajZqcWdCL3p3SDhTeElE?=
 =?utf-8?B?ZWpLSVowZWdrdjhyVHo4NVdXK1VHSUUyaUcwYVkrTHJDb2RkOU1FYlVNNm1U?=
 =?utf-8?B?L3hOcnNUMld5Vmp2Z0prZFRZZE45anVZVE5GTFJsRWZydm5xSU0xcVRXUjFn?=
 =?utf-8?B?cHRuOHBITVlxcndidDlJbW93cVhvYXJuYTFqZ0ZqOXpXd0J0emZvbC9hUnBJ?=
 =?utf-8?B?V2Zldks5aFhKWGhCRW15bmZ3UGcrZmRXMlVtWFVWWWVoVEk4UERIYm95TENP?=
 =?utf-8?B?eHYva0ZRcng1b2ZZVXpuVHd5Z3A3cnlPanVyR2YrY21ncGZjbGhDbmVtb2Ry?=
 =?utf-8?B?MTc5ZGJwTmdXYXNmclQrVXRsS2l2WW9pcWdYTTJnaVQvNkswcUhiWDhldC8w?=
 =?utf-8?B?eDhxUlFwblA0UVY3MDlUaGIzU0dxZDNPY2J6by8zbUJZdlc4VXRnalQvT2dw?=
 =?utf-8?B?Ujg3VkxQdkxRcnZwT0VWSm4vSEZqdGE0UjV4WGtxdUxKKzYwdkdsenBTM2I4?=
 =?utf-8?B?M3pPUzZ3YzdhUWhwVlkwL0pCWDdGeDNsTDZSTWJSK3g3NVN0LzlKb090TkZB?=
 =?utf-8?B?cFpRQnlBYmUvUysrK3VsWDQ5ZlNyVENUV09tMFM2WHZ3YmttTmczd0w4ZmhK?=
 =?utf-8?B?cGUzNmhJTklJdXZDaDh2ZWE3UXJwSUFPY0ZYbGZkTnJ6U294VEIvNTBjUGFa?=
 =?utf-8?B?Z1plajNVa3YwWVZIQUpSZGFoNmNlaVRHZms5R3plb3Z5RkxwRCsvVGRWTWlQ?=
 =?utf-8?B?QzZkWEJXZTh4enkvRnZiTEpHRHZKd3NtWlhEaGtkMHc5TUNKaWZXc21kNDAw?=
 =?utf-8?B?bDk4TFh0c2c3azdOYTdFVWcwSVlmREFMSnlzcEF0UmhMcm1IcTNUUUVVWWdR?=
 =?utf-8?B?a3JwY0hXWGFZbjBqWmU2S0NUTFl2K0JpdU1uS0dzMTc5OWUxaW5kbUYzWnlF?=
 =?utf-8?B?dnlQbWVEMTNYMWRMMW1FOWRKQU5SbGRBM3RFem92WmxUVjN0c08ybDVFbDBD?=
 =?utf-8?B?MnZlSTNXVXBrYzhqVDYvVWo5dHkwOCtBVDc1d0tGM3ZkWTdkMXJWZVppeS9u?=
 =?utf-8?B?RjZrYTFmcDI3TlFONnhQREcxVVowVHVzQjhmYjVBcEFsS3Z4bzFaVnp0RHZs?=
 =?utf-8?B?M1NybmFTeDhvNXRrQnpyN1BhbGNSREpiNTBKOG9iQXBVRGNpUzdHaFpIMDJ6?=
 =?utf-8?B?ZklmR3U2ZnR4Vk5SbDFmTDVoczc2bVBobFlvWVIxbjRZWEhydyswZUFSUUNx?=
 =?utf-8?B?Q0N2ZitjS2d2aUtsMmNERXF1Q1dwNU9leUdKZldnaWFkdTE3OWVpejEzbm1v?=
 =?utf-8?B?UHpyTk43SDVYN0x0ZldkOE5qN3plRXVTUWcxdmlSck1QY0Vya0twTCtVOHNo?=
 =?utf-8?B?TlNPeHZwTmV4TnpkNVZQak8wcFlTREVSZzhDcjhyMEQrR0JQYnN3d0Qwd0Vt?=
 =?utf-8?B?aFg4ajBGL1M5VHlOY3U3ekt1YWJ4bHFKMm1PVnlZMlVrL2lHem01VHIybTBm?=
 =?utf-8?B?bWZNMWJ0T1AvUlJrVFpJbEdGNThydnpXa2FPZTlqQ2NSamF3SHZGbGllRnUz?=
 =?utf-8?B?S3RMUFZnV0NqdE5MSkRLbWhDc0RwdW9wdE5Yb2ZCTFFKemduakJUeWpVZUNj?=
 =?utf-8?B?dGRTYzJhSG1lRmgrWEcyV1pqZEtYZkNyZGFuOXdDRXlNL2d0ZTAzaGMvM1po?=
 =?utf-8?B?Rm5VNk9nUVM5eGRrRGVNdEY3TWR0aFFveFh1VVVGOHp0OU15UFhnZlE4SmJh?=
 =?utf-8?B?dzFKUFMvWjlHQ2s0RGFzcjBSWEMrVllieENOOVRBQVdTNVMxM3hCdHBLZ2Zo?=
 =?utf-8?B?aGh4ZUJXWFYwSUk0WHRoajlic2Fpb2hwNk91cmlsVEpTN0NSSmluRjZSVUdS?=
 =?utf-8?B?Y082Y0NxaUl0ZU15WXBoVFViMDJHdkEwTlMvSzhpYUZPOU8yRmV1dnJLNCtT?=
 =?utf-8?B?bzl2bWwrMGNTQWN5a3pPQithUWJrWlh1R2JxRHhJUS85TmgzRVZPTVZ5blkw?=
 =?utf-8?B?cGZRckJ0M0k5dzVrY1JIVmVGaDcraHl5VUx1M0FFVWkwQzJMTVlCam1BeExX?=
 =?utf-8?B?WHlUaTBFbm9iR2xwVEp1Wm9iZ2xTaGRkRTVkT2owempHUkczN0NMelo1MzBQ?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a715e9-e228-4c97-1079-08dd49c6eabd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:34:44.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaovCGNEWmX8zv3+H/aof3/8dJtACNP8HnPBLQBj2EI8fB8HyqAzQxs/fEDKb9I28kXVlphxRz9qQKWpXvVQ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

hi

On 10/02/2025 13:16, zhang.guanghui@cestc.cn wrote:
> Hi，
>
>
>
>       Thank you for your reply.
>
>
>       In nvme-rdma we use nvme_host_path_error(rq) ,   the prerequisites are -EIO,  ignore this condition?
>   in nvme-tcp this judgment condition is different,  use the function nvme_host_path_error ,
> it should be possible to go to nvme_complete_rq ->  nvme_retry_req -- request->mq_hctx have been freed, is NULL.

did you try the proposal or are you assuming it will be NULL ?


>
>
>
>
> zhang.guanghui@cestc.cn
>
>
>
>   
>
>
>
> From: Max Gurtovoy
>
>
>
> Date: 2025-02-10 18:24
>
>
>
> To: Maurizio Lombardi; zhang.guanghui@cestc.cn; sagi; kbusch; sashal; chunguang.xu
>
>
>
> CC: linux-kernel; linux-nvme; linux-block
>
>
>
> Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
>
>
>
>   
>
>
>
> On 10/02/2025 12:01, Maurizio Lombardi wrote:
>
>
>
>> On Mon Feb 10, 2025 at 8:41 AM CET, zhang.guanghui@cestc.cn wrote:
>
>
>>> Hello
>
>
>
>
>
>
>> I guess you have to fix your mail client.
>
>
>
>
>>>        When using the nvme-tcp driver in a storage cluster, the driver may trigger a null pointer causing the host to crash several times.
>
>
>>> By analyzing the vmcore, we know the direct cause is that  the request->mq_hctx was used after free.
>
>
>
>
>
>
>>> CPU1                                                                   CPU2
>
>
>
>
>>> nvme_tcp_poll                                                          nvme_tcp_try_send  --failed to send reqrest 13
>
>
>> This simply looks like a race condition between nvme_tcp_poll() and nvme_tcp_try_send()
>
>
>> Personally, I would try to fix it inside the nvme-tcp driver without
>
>
>> touching the core functions.
>
>
>
>
>> Maybe nvme_tcp_poll should just ensure that io_work completes before
>
>
>> calling nvme_tcp_try_recv(), the POLLING flag should then prevent io_work
>
>
>> from getting rescheduled by the nvme_tcp_data_ready() callback.
>
>
>
>
>
>
>> Maurizio
>
>
>   
>
>
>
> It seems to me that the HOST_PATH_ERROR handling can be improved in
>
>
>
> nvme-tcp.
>
>
>
>   
>
>
>
> In nvme-rdma we use nvme_host_path_error(rq) and nvme_cleanup_cmd(rq) in
>
>
>
> case we fail to submit a command..
>
>
>
>   
>
>
>
> can you try to replacing nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
>
>
>
> NVME_SC_HOST_PATH_ERROR); call with the similar logic we use in
>
>
>
> nvme-rdma for host path error handling ?
>
>
>
>   
>
>
>
>   
>
>
>
>   
>
>
>
>   
>
>

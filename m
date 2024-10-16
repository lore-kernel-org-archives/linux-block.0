Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011021.outbound.protection.outlook.com [52.101.129.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AC15C139
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052100; cv=fail; b=WjDzLnk5waHChCHnZXFUV/qAxo+XfrylVcA/mYTO0EjHk/6aTGwV51E85RvrATA9To8vpDkq0KtyoYTSjegz+ghaGImgk1jzDAlffuAkztsl0bgsMMIHzDl9JY1z1wkWkRVmHpyH5XTSgL89obrczbIAC13SqQx1hY6z5d1AiFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052100; c=relaxed/simple;
	bh=L5HdpNhm4W3WLPXwgRyQgn/gV+1QMZpmNNx/P/KsU8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrTQW6gvcXx5dePIsEuCBWg/lMn1wU656GCkoGFo2blliSgOqQreCL2jgl5FSRbOTM9dHiTkUOwKvl1dke52+ld5HREhnU3tBVTovwlodjo5iHw2c6rrbvnSr8bxpzpLaeaeXJcWhH2Y48GzewoqR4WZ4Cep3MalcWcqq48l5gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y0N19bKR; arc=fail smtp.client-ip=52.101.129.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y0N19bKR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiSPBowW50XGpzg2tdeF7d5Ez54/Iis10ZIowTAYX7/JiQ0EyA3L40vK1zQe/T4VNTsXZtS3/ooLanubq8bv9/VUdmJEJz7GRhfmIrLkm15fFuwdIQ9l3LscKYrLihvxmW++2kkwIu9ZFA6WjKOhUcwTPJOwE81VFfPIoyQWKs/uW0mxMvdfQFpUappV8EXLtJciq8hIYqYZ81waO5h8U7HUoXN5Ko88B1srTVUO60CZjw2wUm2E1+AKbA/A7K+elAKcKY6sjM573XKXAV1pRVUUbITDYsouvv6XKemJLt99kYKHogiO1HAUjKTW5TwJM8OwFa4Cb6uJpGHySy1ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjshKVdykvt3ngavWfkf7gaWxQipFPNKo7VgYg/3g8s=;
 b=jFzHUF17vplWg1XNhb5vgCQRBzxwoDSMfUgRN5flQJk4EJgDgUNs/cvlQSkKaNtJt4Ll80rI571j+U0n4ERIqKiYcxU9It6uZdvNJiH4hjO4zzx7xgHsZ5JLoUN5mvVKlrPoDBPdSN9YtDxr3Anu2BghCWQDgW0J2FJSg+f2BdbCe6Ms4WaX5Zw4yd2H+Z4h2i7lmYnYUsheotN8/FTxrx4YF2THmwy/0VjjECi5rXHvse6xu251wgeJHXsQfLLL6JLn88i6fe5qCqdAPG5B01YT+r1pXmiiDufSwROtkkUgT5nuzxjLQof7lNAedcDsrCDfn69iAevT29fZ+/3xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjshKVdykvt3ngavWfkf7gaWxQipFPNKo7VgYg/3g8s=;
 b=Y0N19bKRR5JXae3Hl9TMjEbvvDVXBe3EssHt4On4vnUoL/cPZibpZ035eWLjzSSj0IQSQn/tB1/hkVK5c/lNHy+cfcP+fGmSSJmmeI75Mbh79bFdZLpI5eFdQMgWcmPM2NySkd1JXYy/wbS0cw6zXtT42yKJLb1IX/dQrisFnT8JCrr9xFDqBFkIu8Vz1xZTiCcHDMyILeCwRnSSDYTzexohw+7W/8LbVUMN8JwREi7iBwz5OuAoYdcuqEuwHAMjfFpRRm4b5hff/wtWpPvkorSYevj6XdjQHwA3FU8L4iF+GFW02reOGYW8xw5VoJeORELNWXXQfQwXuLIAIBG5OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB6546.apcprd06.prod.outlook.com (2603:1096:400:458::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 04:14:53 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:14:53 +0000
Message-ID: <dffba8b5-f5fa-4e0e-8d37-4ae1b064fe07@vivo.com>
Date: Wed, 16 Oct 2024 12:14:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <20241009113831.557606-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: d761b444-43dd-47aa-476a-08dced9915c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3V4SThqOFBsV0FhYitZWHRkcWpXRFYvdGFkaTRoK2FTVmdnREUwMTUvVVFs?=
 =?utf-8?B?RVBKU29uZnRyTGxxeEVyR1ZDVTVzdFlnY1RsYnJmVkRaazRvaHd3VWpsbTl1?=
 =?utf-8?B?eWNSVWpvWGlGVzErMFRtL3ZGZENuN0xOdjZQSEo5MldENTM0SDBaVGZNYW01?=
 =?utf-8?B?eVF6Q0xqWFJYRktlaG53dGF1WitBeFh1RVMyODRDU2R1eGJtN2ZLM29KSmNr?=
 =?utf-8?B?dDZQeTl1N0MzQkZHSVEzUG44L1pUdTA5VjdxaFI1OGJHNjVhUVNZcmhSQ0Z5?=
 =?utf-8?B?M0xEUkE5YzdHci8weFR5S0laZGlsNkwvV0pJL0VNYU9iTEg1R0F4aW8yQmRt?=
 =?utf-8?B?MmxNeHA2d2hLeXlaOVc4VHJrU3RiNGdjQnRhc3E3VXE1N0t3eVZTeEVGSzRB?=
 =?utf-8?B?QmJaMGYwVmhHckZrRG02aWRuaFJMRHd1cFJjb3JEWFBWMGM2REFVVk5mZVRE?=
 =?utf-8?B?M3RrYzVjWTA2OTJxN01aSGsxbS9pZDUwYjh6VzhITU1vaVdYQkpRbSsyd1RG?=
 =?utf-8?B?YlgwZ3gvWWExUHFEdHQ5ajE5NXdpRy9icEFvbDFMSWJuLytpRFk5OWhBREpV?=
 =?utf-8?B?dkdGdE53Zy9FZVJnd1VGVDVjOHBCa0VkeW5JWXM4d2FrdjVWNmdmRDB5SnZm?=
 =?utf-8?B?Nk5JQTBuOXBmTHVDb3NSd0Fpc0E3cVAxQnpLazhoenlRZ1F2dHVUMjhZYllN?=
 =?utf-8?B?MFI0Sjh4TlUwUzRsdmlkb0JuYzZMM3IrNWVIRXl0b2IwR0Q0VUI2WHV6NjR1?=
 =?utf-8?B?UnlqYXlXMklsNWNmaGtCVVJGOC9mMjJNdzFwZTZ0UWlYa3gyNWxLWFBJYjZU?=
 =?utf-8?B?bWlLRG1pWW5YMklZaTNjU0VkUDNSQS9uNGgyOGswZ3FjbitnTWZyWFR5UUVL?=
 =?utf-8?B?RWFjK050bEFaREMxK2doV0JBTTlTclpULzJqd05RYzl0T3FBMUxFeGVOUW5H?=
 =?utf-8?B?M0xjZFJMbUxQN0xjTGFXZGF1Ry9ROHEySzh5bE5kSnBTNGRTQUZmU044Umtn?=
 =?utf-8?B?cTR1Y0FKNFcxNC9PeXVMZDVJd1ZaM1JqNS9BaFhnRk02N3lUajQ4cnVwRk1Q?=
 =?utf-8?B?Zk02UmhiSFZvdzFFRFIwdC9HK01pSWdJMVI1Ujduc0JKTm85K2lPbHd5aW4y?=
 =?utf-8?B?bGZEZ1ZENmVRU3ZtMGg0c2UzSHNXdmJjRjQ1QUdxUDcraHNHQkJWZXROQUVZ?=
 =?utf-8?B?c296Wi96U3NyZWhrWG1Gb2ZueFoxMUFOZHMvMVowUDc5VEwwNnJ1T3dzcldy?=
 =?utf-8?B?SFNKaDBRRXZacmJRaUQ3SWt3NUFXNUlQN0dFQmIyZkRJeG9xbktjRGZDZmly?=
 =?utf-8?B?aTZIbnFBb1BtbWJQcHM0SCtsZkFCYTg1MWxLRFdEcXBXQmxLMmphR3FrVDU1?=
 =?utf-8?B?Z2NXNmdvZ2F4c3FJTFppZmhoVjdyTUwva0NyMXBWRFNhdGRWUFRsZFh5VXRr?=
 =?utf-8?B?SUxPZlQrQ2hFaHZwMjdvVUYwTm9zbXhlZEp0ajhpVW8vOURZTnpnU3ppNUU0?=
 =?utf-8?B?NEJOT25DRC9aeEZUVGRadC8zalIzYnY4V2YrL2tBT0xHbFFDWXhwcFdkcEdl?=
 =?utf-8?B?OHZ0dzVmM3JYZVZFUXRpT1hUMU5SZS8xS3lWNlMrMzA4ZmpQMlNvN0U5TFVG?=
 =?utf-8?B?U205SkVXblFUaXhlZmZ2SmswUTdlbjRnRVdrbUY4aFFJZ0k4WHEzeVovUHNj?=
 =?utf-8?B?MHBKMXY4YlJzVUM4YVhXTUdaRzBxZkl4OHgrL0Q1RXpzSGZmWW0vUmZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R21KNXdoZlJnVWV1WlRIRW5sOGZmRVQxTFE2RkpKOHFXNmgxejhJQkQwb2ZW?=
 =?utf-8?B?aXZocWVLZFc3Nnd0OVFKLzBLMVh5MTI2WXNaeEphaktFY2FjWDhHQitIWWxS?=
 =?utf-8?B?NXVSQnhnb0U0Mm1JSVpuNWdUbTRHTDJJcWRWRXllN0UzWC9meGNiVmpuTHZO?=
 =?utf-8?B?MERlakNKSjMwbXRHS3JKREpqSy93NlY4Wk9qcDZwaGxCMTZsNWRENlErZEFL?=
 =?utf-8?B?WUZvd1NBRU9FbFFGTHlZaEdqU0lpbUJydFRGY28zY21lMTZQbEZMSnNhV1Bj?=
 =?utf-8?B?NnFsaWhGLzY0ZlFBQ2dMZEsxZUhOKzdaNjVIWGhZVEIxeVlPeU8zN050Y3FW?=
 =?utf-8?B?U3lQdUM4SU5qVVdLZ3p4eFI0VDMyZUFqdUVxYmNCYnVGWVdVLzRsYWFLdWhZ?=
 =?utf-8?B?M2JVV1JTZ3pyckZNR0JPb0s4VzlYQ21RbzRKNGh3SEhMd2FPanpFVWR6MGxE?=
 =?utf-8?B?MW1ldE9HVTRYVGNRNHo5MDJiUkFJblM1WkpXLzExdDNmeFM3UWM5dGQ0T1J3?=
 =?utf-8?B?OXpGRG9HWmNSZnlvb0Rsc3pWRVQzTVd6NEdabk5JOG1SREdaMXFGTFdXNDJX?=
 =?utf-8?B?dnhPUU80MEM2ajJQMEFhVVAvdk52elE4MFU1dFk0eFkvUmw3MlBJa2ZwNkJE?=
 =?utf-8?B?MWdrZmJrZklqV28wU0Raelk2czFRdzlUSVhlUG9HbkNkODZXZ1hDSHhDMWRR?=
 =?utf-8?B?b2JPcFpoU2EyQ3VqVWFGYVk0WEd0dUNOaFg3OFBaVi96ZzdDOFFhR1lnaFZp?=
 =?utf-8?B?U3FGU3kranMxZzJVR25PSk11bmpiYjFLQm52dU1uZXdTUjc1T0EwQ2YxekRw?=
 =?utf-8?B?Y2tTbTE4b1JScnhHd2tDNkdxN2IrYjZmQ1o5S3RiNXg4Q0tPTTJZSml0R00v?=
 =?utf-8?B?VkhnbHlKb2hCWXR3alRJTUJ3RkpZMFZSQ092cWd1Z0RYZ2RHQnRwNnhJVDdI?=
 =?utf-8?B?VVdONWswbW8vNmRkRG9zbGZtU2d1VW5Bb1pZQkdkMEpTMEE5cmxEQjJ5TUlO?=
 =?utf-8?B?ODM5YlArcFRQVHJJY3RJU1RHNGk5cWlwallpR2RnSkJQT1U5eFQycHpJVERZ?=
 =?utf-8?B?Nkl3N3J0clN1clNaY2FsS3ZpcVY0VyswWithSWl5TlU4R2YxcGJjbWRGVURN?=
 =?utf-8?B?ODlIcjNjazg0T1ZRV3g0aTVPVjZJa2dUZG5YUlZJRWZqaysrOXRSOVZDTWJI?=
 =?utf-8?B?TDBhMU5rYzh1TlpqKy8rVm5VZGlkV3c5MExYV3FNSGpyeWJFK3ZTSUdQcmpN?=
 =?utf-8?B?OS80TUVOZ1ZKRHprRmwzb0lnTGpXbUw2TktCU05pbmhCdS9uMzVueGY4MkNK?=
 =?utf-8?B?RlJ4VmE5dlJHQ0JqVzZRWGR2cHJMZDJkVW85RWt4U1dmdDA1aFJxWTVuK1lu?=
 =?utf-8?B?WVRxTUJvbTVjclQ0TXNwRS9oZ1Z4Qm1iNXZlSGx6bmVwREFUYWtnZURtZndN?=
 =?utf-8?B?UFl0OUhwd2pEZHlFeEFYRkZzYzJPL1Y5UU1QVnY3R1BsL1kwTXdMMUhIaVo0?=
 =?utf-8?B?cWFrM3NQdk5OcE94N3BpZEpaWS8xSHpEQnZzWmtMbFQ4NWt3TlVpbjNxWFNz?=
 =?utf-8?B?a045b3hKejlBZlppSVdFaHlvcHBzK2JLdFd6VEVOK1NmMlNXb3NwRDJDSzBz?=
 =?utf-8?B?OGlBOUtnNW1BTlA5WG1ScTdhWnV0RmNpWk5PN3BWQ0dyRWx5Y2hCTXgwdWRh?=
 =?utf-8?B?c09QRHJudjE3L1FGRmZ3OG5tMlg1WWxkbkNCVFpSRGxFTVJoNnRIZDFMODZx?=
 =?utf-8?B?S2g2dmI0eXVUU1BBSS9yM0hCSFdWWXR6eVhIYldRVkRBdmZ1cDgra25YaHFS?=
 =?utf-8?B?U0xTV1pVaE9FSjJRc2tQNlh3SDVHSndybVArMUhEMXVEc0NqSjl0anJoQm9L?=
 =?utf-8?B?SEZsdkJtNThsLytyR1hxMjgyaUZBb3NVc1YxSU5aZVVkR2M4QVVUZEtJU3JM?=
 =?utf-8?B?RytkdUQvVE14b2pOMk5odGp5V3J6aGpMSDhFakdQN2p3SVNVUTBwbldHRzlT?=
 =?utf-8?B?d3A1RjFGYUNGaVNrQUdXaU03QTNvMDZiWlV1VEt0Qm80S25KVHZQSE1XL0lE?=
 =?utf-8?B?Ym0rWGtEdlM3NzB1cDRLbGFjbE5MbC9YMmkvMUpta0M0S1RxNHpKUDdVWUFZ?=
 =?utf-8?Q?i2yugUyihxb6L5EfQP+0m4zMa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d761b444-43dd-47aa-476a-08dced9915c3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:14:53.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfOKf4LawV3P/Nk63GaCSaqi5G9fC3KJNs37uu3ziDON/N7e3UnCdam2vlCJy0dqKpHa3w0+YL2rvnqxc25hKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6546

On 2024/10/9 19:38, Christoph Hellwig wrote:
> When del_gendisk shuts down access to a gendisk, it could lead to a
> deadlock with sd or, which try to submit passthrough SCSI commands from
> their ->release method under open_mutex.  The submission can be blocked
> in blk_enter_queue while del_gendisk can't get to actually telling them
> top stop and wake them up.
> 
> As the disk is going away there is no real point in sending these
> commands, but we have no really good way to distinguish between the
> cases.  For now mark even standalone (aka SCSI queues) as dying in
> del_gendisk to avoid this deadlock, but the real fix will be to split
> freeing a disk from freezing a queue for not disk associated requests.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   block/genhd.c          | 16 ++++++++++++++--
>   include/linux/blkdev.h |  1 +
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1c05dd4c6980b5..7026569fa8a0be 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -589,8 +589,16 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
>   	if (test_and_set_bit(GD_DEAD, &disk->state))
>   		return;
>   
> -	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> -		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> +	/*
> +	 * Also mark the disk dead if it is not owned by the gendisk.  This
> +	 * means we can't allow /dev/sg passthrough or SCSI internal commands
> +	 * while unbinding a ULP.  That is more than just a bit ugly, but until
> +	 * we untangle q_usage_counter into one owned by the disk and one owned
> +	 * by the queue this is as good as it gets.  The flag will be cleared
> +	 * at the end of del_gendisk if it wasn't set before.
> +	 */
> +	if (!test_and_set_bit(QUEUE_FLAG_DYING, &disk->queue->queue_flags))
> +		set_bit(QUEUE_FLAG_RESURRECT, &disk->queue->queue_flags);
>   
>   	/*
>   	 * Stop buffered writers from dirtying pages that can't be written out.
> @@ -719,6 +727,10 @@ void del_gendisk(struct gendisk *disk)
>   	 * again.  Else leave the queue frozen to fail all I/O.
>   	 */
>   	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags)) {
> +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
> +			clear_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags);
> +		}
>   		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
>   		__blk_mq_unfreeze_queue(q, true);
>   	} else {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50c3b959da2816..391e3eb3bb5e61 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -590,6 +590,7 @@ struct request_queue {
>   /* Keep blk_queue_flag_name[] in sync with the definitions below */
>   enum {
>   	QUEUE_FLAG_DYING,		/* queue being torn down */
> +	QUEUE_FLAG_RESURRECT,		/* temporarily dying */
>   	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
>   	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
>   	QUEUE_FLAG_FAIL_IO,		/* fake timeout */


Looks good. Feel free to add:

Reviewed-by: Yang Yang <yang.yang@vivo.com>

Thanks.

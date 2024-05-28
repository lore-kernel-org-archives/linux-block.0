Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62282563
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917424; cv=fail; b=KoG8cCIKXlVdeHdNj+T4moua/iJojt93iFACHZ9ygiCJqMPN/M6y82R2zo+za9oT1tq5B1BPP750J0MIiPcQJhZfCHKYbPPJsp4R3WLoYYkGKmhbq6a29vREfOiCnjZr2lii3ELhcmgDkoJvbYyoxU5mMM2puI5TW7P3msljg5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917424; c=relaxed/simple;
	bh=XOrbcc79NTkd1gUvQWS0irlJCyMMPPqrVtHo7CkpvYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFJWuZ3UjphtbuWvu6yyIhnGd/vhTW1WOca4AUcEFnFxA/YduhszA8e+1DhPEX1Wu1M/slrLUh1Fco91JNn1gA+hGZUh2W6YTndkuSd7w3kTffEvm51npK1dLuiuNHkX65McK/ZkKAJGAw3UHdhQsSX3aF1enIN/wKqCAKWiFCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mQe9+QG0; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mQe9+QG0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JODSdpdKCfNZ+ME0gMv7q6M6sckgRhY3P5HV2h2ETBYsNct/hAmovgg4Idmf3BZljFG7UEEvkrJJdEnK7Ab7Uf/6Zj3gT8bR9sTKqKiMML/pB0FysNYDMydR8R+Vlt4lHxbGFHY6kB6c8IyVPJmajlkzKsl3f969OtWy+PJ7c9jrgcA2vC2rhr3M8GFaK+yGQVRvN6VDvpJMLIrkZiGsjLjiHJYt6sO7gW/LIMGzaich5lzOyM8wSghNSyI5+8RD82s6IpAFFfLpxdcs3d/6BcCbbYDvXJZMmaOWPaIYlfET6UCvTKF00M+J26Gj+4I7WiieKj8zB4/GnuGgCQvrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUWh8yp9egLDKW4P2a3u3lsO3ur2AApDvvj6xtFPL0k=;
 b=e92ZoI95WLVXJcZZ/ahCNGt50vSJIoTemgg973MVzSikT2Nyb6JrsRwUSnxi+DK6zQQStq/sPTUlk+cUfcaMFHsL0aVvRgxfa+3UCeKAu36JT4+E5VU+CRVv1g0ZHzrCGQxPpNdKXcNDW47Q1QHqF5z9Fui7rEkYlB+u4D000nM3nw2rrfzGeKYRHEeWf7TscmdtTLTEfqKCmgkjNL/WYK0yZ9DVVt9W/wY5Vvp6YX8xQHYA/D4TYu7fMmAYlCgZhGmJBhuzUCUxcOqO7D52+yHdrXl/4kv3+n6nenmUqQsUWzsBcg42jq7USU4Gr6NMxGtK3MLJTBuvJbnBL2CZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUWh8yp9egLDKW4P2a3u3lsO3ur2AApDvvj6xtFPL0k=;
 b=mQe9+QG0agECK3SAQqb38UdKjfgKuw+EzBaCULsQxe2pTFbFSlA5tgwINs/7DhOv9bYqVmTaRT8cXNYekVCufujjqWtoCa4H9aRA5ht9bDPdi+GPYEi3C1eO0bCwLe4xtFNkriax3lRs9YcInD/CL4C3ODlM+/zE7hozPyu5P68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 17:30:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 17:30:19 +0000
Message-ID: <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
Date: Tue, 28 May 2024 23:00:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
To: Joerg Roedel <joro@8bytes.org>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, iommu@lists.linux.dev,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 suravee.suthikulpanit@amd.com
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZlVk95sNtdkzZ8bE@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e71d50-17d2-4ad3-1e4a-08dc7f3bd870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3psNmppVG5pSXphVTVLRldDaVorR0pseS9qeTFlWXFUVXE3amNOdDZOR1Y3?=
 =?utf-8?B?Z0YzQjdGR0daUnlGYkxnSTZRSGZmNFB2bnJBVXlnZkE2QzVXeUphVFZQdFdJ?=
 =?utf-8?B?Vm4zTXVoVVRWMFlEbGxXRlpGeXBzWDdyTmszSGNnTUt4ZGJvNXF5dDZKTkFV?=
 =?utf-8?B?MkhHMi90RzRFQmw5V2dKdFo2bVFSZWxLbVg0Wk5BQ2phUEFqVEsvMjl1T0Va?=
 =?utf-8?B?Y3d4dmpTNjU4KytEYjFQbWRrNWZoYmM1V0lyYkQwTkEvWjhwVlhrZk15cTAv?=
 =?utf-8?B?aW13YnFWcjF3OWVmM1g3RTFONUhidHFMYXhPSWxLeUxPRExWdW1yY0hMQzdk?=
 =?utf-8?B?TnRTVmZsZU9PK2ViYXd5L0dXWFpGMzVNR1ZwalBqa0x3RFVMVDBoVHgvK0sr?=
 =?utf-8?B?SnRqWHBpRTZFcmVQaEpTbE01cko3SmJMbUNrTFlZVXZPN3dtL2x3QVAxRDhG?=
 =?utf-8?B?TmROb0dVZ2xKL3pxL2xuelhvSE5kS0VMMk9oRy9xSHI4K2lmWlhiVlBTdEEw?=
 =?utf-8?B?cGM2Q05IZ0tzRGU0YldqVkYzTVJVU0JKcU1Tck9yTWVlL2piNlN0T01xeW5t?=
 =?utf-8?B?QU96UFFFajk0OEFhVStNdTZGZm9pck1YWnBGQXdzdU01bkh5dFQyOGtTTk5J?=
 =?utf-8?B?MEEvZ1gxdGFpM08vSzNIdVIvRytrYVFOOFpkU0tBQnA4NTlRcDUrUiswRCtz?=
 =?utf-8?B?YVk5VHc3WHF3bGxDcmhDQzMyc0Z5eDZXK1I0Y0FxRmROVDh1N2RVaGFNM0tW?=
 =?utf-8?B?cVZ2QkdmdzZ2SzdIa1VyRXFDRkE0b0QzQUVnaXpEbC9OMDEvSy93cmlzdFQ5?=
 =?utf-8?B?WE9qbzhRdS9NZ3ZuOUgyOFBndVAxS2RVaExVVzJVN1ZjcEpLbjArdmY2aDlj?=
 =?utf-8?B?cGVocmlPMUVIS0puNVUrYXhWTUxuazlRRVp5RGdZSjA5N0FqNHlsbHhTYTJW?=
 =?utf-8?B?aHFWS0xpaThyVFl4QWVFdUR5RURTQ2JpYTF2OWJvazBuRmFaTVFBTS9NTExZ?=
 =?utf-8?B?eW9Bd0lKNTdEY0ZqMVFHS0k2bDVmRGlGRzZnTE9xa000cHlOb0Fyc1NoZGpQ?=
 =?utf-8?B?TGtvUllxV3JNeVdZd3Ywa3o4S1M5L09Qby9BYkJJT01DcFpzQXVBZjE0elR6?=
 =?utf-8?B?QVh6M2lCOFJKSFFudG03RFFxYmpWRGtJU0l4WVQ1RldtNy90SFNjRzZFUGpI?=
 =?utf-8?B?YzJCWmxaYlZNUzlFUFNxSlJXelhZaFVBbktYNytOOSt1aVU3dkhlbEJpWFpS?=
 =?utf-8?B?ZHJ6WEdSaHZDcDRoRVpsUExzMWVvZ25rZzlXWkRHTmNoSlRyOXNnTTZmSkxw?=
 =?utf-8?B?c0sxR25nVTVSRVYvMGpzOGxXVUJha3ppZXRzVDV1eHJiVTFKeisyN1JDOU9I?=
 =?utf-8?B?UXB4UzhtaDFmTUlwRjVENDEzc1hKdUN1dit0YkdDd2hBYnIzSy9UaS9UZkhz?=
 =?utf-8?B?S3EzUmVGRDVENVpMZUFoNXhBUnYxSFg0OGx5QWp0bGpabXNReTlJaEZ5Ynlq?=
 =?utf-8?B?MjVLMWVTdEQ2ZzB3dFg2L0Vad2tZTFhiYXRCTjU1QXcrc3VuMkxPWnJxeThH?=
 =?utf-8?B?WDVyOFE1RUtaTW5TSGpOOVdFZGQvdllQUWhTN1M4S0NqY1RhQzhhNXh6Y2Jn?=
 =?utf-8?B?UWRuc1VsOFp2WjhCNmJyZWt2d0h6Sk9yaGJ3NDZLSXZsZGZGMXR6ekk1bUNR?=
 =?utf-8?B?bDdzMjhtbDM2bE95bVJyT09HaFZCTkNHdnpMWEVBcEErQmxPckNrWUJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dklDc1FVN1hSY1RDdVZiTTlneG9BRVRsdWJuTlVablZoUWRMb2ZndXJEY1Vx?=
 =?utf-8?B?Y0tKUm1DdkJ4R21QWjFtNlkyK2VZYnM5eVJnOE5ZeGx6Y2I0WlVYQVVETzBp?=
 =?utf-8?B?cVhQVW5nSlI5SjJjRTk1NWlCZTlsNzYwM2gvMjZDVXduWEl5cEVtQ2c2VVVF?=
 =?utf-8?B?VWJQbjhxZnNreUpQaXpHM3MyYmZoYVFWT2pJTlB4MnZDZllDdHY1KzYzaS9Z?=
 =?utf-8?B?b3ZjOS9PcVBFanNvMEI0NkFxTXI5MFc5MjdWaVpsV0llNHhsL1NzZ2VJKzV3?=
 =?utf-8?B?U2czM2NVL09KNmxxRC9wbDVPMlR5a2x5clRjMDBFU1JOQW5UM0RwSmc2Kys0?=
 =?utf-8?B?Q3cyNnI4Z1FBc08zNHB0dXI5WGhRbTZXbmdUZ0JLMnVWc05UOXNWR0M0MnJG?=
 =?utf-8?B?eGNJcFZCYUxTdWd0R0VLVjYxMUh5WWM4Qkt0a2RZNjVqRkR2alVUZ1lhWFdw?=
 =?utf-8?B?YUxoNU0wMU9MTVY1dEJ1N1U3YXJGekdrdTdhZkpwYnpNS05LaEswY3hxVGxv?=
 =?utf-8?B?T04yTUtNK3ZGZEtNYlk5TEFrMURPUkNrYS9FZlI4azVYay8xSW0wc0VEM2RP?=
 =?utf-8?B?cVdkbTJpRUljQ213a0RYYUZqWjVjbjc2aUdybml6Y0dZb00vY3JhZ0tmaWpR?=
 =?utf-8?B?djl6dE94Qmg0L24vRmFMalhkRWsvcjROZDNYS1d5WURQUmt0R2FBc1pRUVlY?=
 =?utf-8?B?N05aZzh5SnQ3TUVZeU4xamZnMnRMZ3NQZ1RROXRjZ1IzVlJnaC90UmxKdURJ?=
 =?utf-8?B?MjBSTm5namRMc0xtWkE4bjlYWDNCU1BaVnpHaXYxdjFjOGdVbFIyeVdWQmQ3?=
 =?utf-8?B?TnZNOUhPOHFVNkdpd2o3cTZXTkpoT3ZZTzV6UW8rc01PZEl6ZGhrRzBVUUM5?=
 =?utf-8?B?bFluNXp5L2hMay9NWmtYbjJ1SDRTT1RpT1NIVFpHVFVBL2YyY0NaUmNETG51?=
 =?utf-8?B?bTZsdjI1ZXhKd3N0THg5dFZWN2NoNzBsa2o4MTNNamlnWG1CdW1uNm15ZmVv?=
 =?utf-8?B?NDN4ZEQzd2ZXaitSWTdWWXE4Q0NmWGE2ZTN1TUlTWEtXM3EyeStWNzNQcGhj?=
 =?utf-8?B?Wkw3YWNVQWdJK2NlZ0ovRFdFTCt0ZlJrVzFrWmtUcFdmVkhFY3RQYUNyVnBt?=
 =?utf-8?B?VjFFMkpkV09kT1ZVWjJobVhDY1FRVzE1N0xFV0YwZ0hTOHlDaHUxNmNFKzBL?=
 =?utf-8?B?Vnp5d3VBb1E1SkxtLzFtdUd6RmFYdlhjdU9qZzlZaWswc1ZvUFNiTXN1UEhJ?=
 =?utf-8?B?UDV2c2hvbUs4aGZkQUwyd1hmMUJ5OS9RQXRZendFTWh5MUxDbEsvVnJyRHRQ?=
 =?utf-8?B?Y01WcG82eWpIdlJvc3lkVXpHd0dJeGs3Q0FZRDhhNmZkNW1wck5wUXpCbEpz?=
 =?utf-8?B?RVdkT0lFZHNTS05XeFZCSEtwQTY5NERkM3E3SytkSmlCR0RSRE1OdVVlSk5z?=
 =?utf-8?B?eVdXQkVJelk3UU80NS9qejY5czlnaTZ3eFFNWlRPSUpYSUxGQTZRU3dZYSs5?=
 =?utf-8?B?ZmFVelQ1WExvWWFBcFRTSEtVTGJEdXNPSDZMYjBsWmhkVkdVd3V0ak5nUGQz?=
 =?utf-8?B?UE5WcjZhMjM2TDBHMWk0dVZGdVdKM1lIcXJUSm4xM2VXaVk5S0ZKaDYwOEMz?=
 =?utf-8?B?TUdXVlQ3TGx3eVNzY3NvMmw0OEhaV3pNU3JaRVozRGxmblladXYrMlJ6S0p3?=
 =?utf-8?B?NXl3ZTVseU1RV2dVeUE2ZmZ6N2FsNGhjZU91T0krSlRhRGt1b05mRlJkcTd2?=
 =?utf-8?B?Znc4SmR1d2o1T2Q5dkQwU0ZTZC9DRHpxZTlOb3VidVEvVEQvZDhrU00xMkZF?=
 =?utf-8?B?MzlhSXB3T2NldUZxTTkxaG1OdEdubWh4cCtCMVN0NDJpaUtjVmEvK0tNWDJW?=
 =?utf-8?B?Rm5sZW9pNHlnem1TVjFFUmk0dUsvSG1oV3hLRDh5cjBINU1uVFA2RmdNTm5h?=
 =?utf-8?B?ZzZzSU5JSkEzQ2ZtU0pwVTdNNVZjT0Q3eHA1N2U0Wjh4ZWJFcmRocnlJVjdR?=
 =?utf-8?B?R3duTzRseG5TZ3B3SVM5N3pUUjl3c2tCWjNjaGtUZzRLWnZoSjNRQU5BcE1T?=
 =?utf-8?B?TERqMHU5OWNkWmd5NVZmdmgwTDFYaWFnK05jNnM2S0tJejNmMnVqLy8vQjNP?=
 =?utf-8?Q?GGpYWS04ik7syxRVfZX5QlKqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e71d50-17d2-4ad3-1e4a-08dc7f3bd870
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:30:19.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gryk8JSPgzYuPyUTcmqIvTku7UYhaOZtqDsT+3iS0Xq+9yprg7GlwsdqYddcovOAn9ZE9R9Lx9GhkFX5U+kjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

Hi Yi,


On 5/28/2024 10:30 AM, Joerg Roedel wrote:
> Adding Vasant.
> 
> On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
>> Hello
>> I found this regression panic issue on the latest 6.10-rc1 and it
>> cannot be reproduced on 6.9, please help check and let me know if you
>> need any info/testing for it, thanks.

I have tried to reproduce this issue on my system. So far I am not able to
reproduce it.

Will you be able to bisect the kernel?

>>
>> reproducer
>> # cat config
>> TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1)
>> # ./check block/008
>> block/008 => nvme0n1 (do IO while hotplugging CPUs)
>>     read iops  131813   ...
>>     runtime    32.097s  ...
>>
>> [  973.823246] run blktests block/008 at 2024-05-27 22:11:38
>> [  977.485983] kernel tried to execute NX-protected page - exploit
>> attempt? (uid: 0)
>> [  977.493463] BUG: unable to handle page fault for address: ffffffffb3d5e310
>> [  977.500334] #PF: supervisor instruction fetch in kernel mode
>> [  977.505992] #PF: error_code(0x0011) - permissions violation
>> [  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff063
>> PTE 8000000719d5e163
>> [  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
>> [  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
>> 6.10.0-0.rc1.17.eln136.x86_64 #1
>> [  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
>> 2.13.3 09/12/2023
>> [  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10

amd_iommu_enable_faulting() just returns zero.

-Vasant


>> [  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>> 00 00
>> [  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>> [  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>> [  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>> [  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>> [  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>> [  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>> [  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>> knlGS:0000000000000000
>> [  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>> [  977.625927] Call Trace:
>> [  977.628376]  <TASK>
>> [  977.630480]  ? srso_return_thunk+0x5/0x5f
>> [  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
>> [  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
>> [  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
>> [  977.647830]  ? __die_body.cold+0x8/0x12
>> [  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>> [  977.656979]  ? page_fault_oops+0x146/0x160
>> [  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>> [  977.666392]  ? exc_page_fault+0x152/0x160
>> [  977.670405]  ? asm_exc_page_fault+0x26/0x30
>> [  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>> [  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>> [  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>> [  977.690527]  cpuhp_invoke_callback+0x122/0x410
>> [  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>> [  977.699593]  cpuhp_thread_fun+0x98/0x140
>> [  977.703521]  smpboot_thread_fn+0xdd/0x1d0
>> [  977.707533]  kthread+0xd2/0x100
>> [  977.710677]  ? __pfx_kthread+0x10/0x10
>> [  977.714431]  ret_from_fork+0x34/0x50
>> [  977.718009]  ? __pfx_kthread+0x10/0x10
>> [  977.721763]  ret_from_fork_asm+0x1a/0x30
>> [  977.725692]  </TASK>
>> [  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
>> dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
>> ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
>> edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
>> dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
>> acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
>> ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahci
>> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
>> ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
>> t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
>> dm_log dm_mod
>> [  977.786224] CR2: ffffffffb3d5e310
>> [  977.789544] ---[ end trace 0000000000000000 ]---
>> [  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
>> [  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>> 00 00
>> [  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>> [  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>> [  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>> [  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>> [  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>> [  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>> [  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>> knlGS:0000000000000000
>> [  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>> [  977.969129] Kernel panic - not syncing: Fatal exception
>> [  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> -- 
>> Best Regards,
>>   Yi Zhang
>>

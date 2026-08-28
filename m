Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA615346E59;
	Fri, 28 Aug 2026 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931483; cv=fail; b=lyzwTG9mX/j3jXhYh6C8dyBk7oEsWAysVidssoJbfrQHe64/OcdGnh//K3unbqsBr1IaUMw2a2ut9R5krmnM+VOSKHbMFh3gph9Jcp+OcqEGZfrhX9JLKGbg9ZghPNJrDIVR7N9U+PPZzWtV3G9QW+fye2usr0sV0QrA5ARKEDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931483; c=relaxed/simple;
	bh=Nv5aMr+pVGrfVLppKW3B6CBobhA0JMCX3bBjc8ggY3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FOPoPUlUxl30EFs9fqu7JsReRs0iKAKK5E2qESNso8G1HZt1Wq3dCtGDtCcy/xvGzVZQP/3rpnt52MsjryzZoeNlAZIc3aa1/6MTNPX71pEKB7OL736/J709NgdIiOFTcKFrjPHfDNxBoUO0Duppf7fobASS/YCMbKiIKWtLjW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KtBoO4WC; arc=fail smtp.client-ip=52.101.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KtBoO4WC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuaRh0KlkEndH88gvYlRKJsnQCuQvkiBHCllp8gg7wU8LMMRi8cLWDA+/l6ZsDPvlm0nyYQmqxjuoVaJam0XZQ7/hDnZUmGvD+ySnwmCoya7BFRiJ784jG2eStJMFykfr6ZYnsOxzZXWxHbyzR9ivRSz/2DnlUitiOaSLemEYQgfvmicRgl7IHpnLD43NwCOatJ8TMaUBn1sYm28AASit+CRByRMN+LLTsqz2dU4o+qxvGT0nLDaFbvD/pUxBoZTBKiW3d1V6wn/zzxGYbF0gflFBv3rT2Z0mW/SrzWBV2Y3DdoNIO2fLJStEmugrvxXsH8Es222oDy2WchP6hpdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nPGBwP4xyUc989/xZOZTIlhLjHH9M3T3cQIU0EhhsI=;
 b=sDMzr3/8ZxDYNPlofyHu9X3fjrxOXDPXuvz1upv/0YMRcr2MNKHlFjEXmG1L9yg39lj6Uo22iHAopHZVLko9Ek6UfJK5PZAvfl2baiKbfjDEgMbGbaj9XDZE7WzgrQq4DpksvaPG8S+lPzKr+yRhdHPdtJQWcsykySEHInKznC66YZlqKoYaHAsB8Xvdft9QFRd5+LnDjN/bvS/2DpSPfAc5DK9IGVDAzg+A+eaa4XzWcdnAn9gbc/q841BVAlD4Uj0ipmgILwdPk0YeFrb17bCTUecvLvbyJx9+8jqC9x7sOEz54jRClY0Gvbp5E+VbSuGxb9XyaVi1cNUrhPT1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nPGBwP4xyUc989/xZOZTIlhLjHH9M3T3cQIU0EhhsI=;
 b=KtBoO4WCTXLwC5jKxh3L7uQyZB1HdARPuGEkYd+RAKq9SoXTQTlpnZThSn7rU7KoJK0Pxsb80oSaLckyiYKaMflN3EmF+WgB7L3h85vRyL5LljfelZ2rMI45Do4z9WLDq42d4po+NjpPyj3dRMVFbq7gnzfvkPWh3IYZVjgVj+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:37:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Fri, 28 Aug 2026
 15:37:54 +0000
Message-ID: <d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com>
Date: Fri, 28 Aug 2026 10:37:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Content-Language: en-US
To: Mikael Etienne <mikael1022bzh@gmail.com>, vasant.hegde@amd.com,
 iommu@lists.linux.dev, linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc: regressions@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
References: <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
 <178793069172.1699234.13635367891277204598@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <178793069172.1699234.13635367891277204598@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: f4191a83-cab4-44aa-b334-08df051a5363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gmXqv9fg94/6DUtqKpDkMPR3bFkvmWHkhiBVfIUzIngE6jjYy3RwTw6vaMOfIMYRjiyctqv/AzwqO1VzjaLMZ3f9AJiG1oUYPQd01U18ngOPRJNLx0uMpyp7wkedn3EhzE6AQTXP8TWZNdOyHzu1JvK+jjsWiyQNa40dFa4kIA8c26yt9HWhocnqrFw5M76FS7696lT6MEeDCGAXcPzZY1br4mqTYrC1pv4a+ugf2lumQW3vOt8SYsG3r/borKL7lMvyoV3ddNLNfAzK7KfcLE0CUL2L/yf8UpYraHIP8Cb8Hx6f/Nn0/5B9FIMTDTVi7FcD8gJ2HlttS5eFYjuChaGKmx5kwp2IZGWtq7xOfiFpvEJ4DhfldikJCqq1MXE1aIlGG4VpLO921PdyKFW4cAlNZZhNssmFUZ9z8ehEB/oERyeOrZoGwDWrNdoXRwJBTS3XV8zs1sQtfUzsY7Fvo1zwf1fooljEwpaC8nssrAwKS/JLGAQbgeL0M7fyFAHQ8cu+YmmQtT0E3KiYqCn5wB52ZCeIVF5+yTUy4v4beqtv1tiDKK9A36nyddln9WR208oGP2WWA+6ISss28YbTX/DphBx/pvfLOdU0wbOB9V8PqeMDuWGzlvoAOybKzrMmd5NY4VMLeRqlp+GPLuuHTfal73aqc7jAUQ/jUg0MAWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dNSjM2dTFEcWhZTE05N3RIeUVkTGpVYTBuTlhQRERxRC9oRU1xdWoyMzQ3?=
 =?utf-8?B?NS9kcFhPaitUZE1GY0UwNVg3cDI1NG56U24yUkdTSExMUFFQRW4zT3VLa2xO?=
 =?utf-8?B?LzY1UEdhRXNhQ2FuOVpyN1F3c3doUWxhRDVLNnYycFZFdVk5Vmw2endBeWpr?=
 =?utf-8?B?TmRlT1FXelhvS2tQMFNFbmp1QVRnRXRjakJ4dXBJUkJXVnY3eHh5a0xRWitD?=
 =?utf-8?B?QnAwOWV4Q3JDTit6S0NuRnM4VDdPYTNzSEROWXFXSlkvZmVqTDNPQ1hiVGtK?=
 =?utf-8?B?NHJxK21rY1BiRUtGZ0U5bUNKYm1TOFVmUWZPak1hVmtSeTc3QU91NzRFb3Ew?=
 =?utf-8?B?amlkenZuWmhkT2pKQk05Ky82Z2hCVmV4NW53aFZkdEQrMnlUdmRJRnBvOFgx?=
 =?utf-8?B?N052ZzJkWXZnaXRTWGFLb0dTWEdLNlZBT1FpWHZkT0pJcThvUTlxVE5DYTZx?=
 =?utf-8?B?SDE5K2V5ZnJURmpOQkI5cWR5U2dlbFBQSFkveTdadUc3VmxVeitPbjBmN0hu?=
 =?utf-8?B?RVNuUnJRUUdIVTJobitSamRHNWhTWWVZNVZCeVlMTG9VdFBVVWI5a0Nab1lF?=
 =?utf-8?B?UGd1dGgrV0RZMnRsK1I4anRMS3I2WXNkK0hZMnRvbE5QMlVqa29JbUFTQlIw?=
 =?utf-8?B?TkVHcE43L2UyUGhBcFJYb1E1YitoSVk4MmR6aytTdEtHUVNiZStVNjJFQWZG?=
 =?utf-8?B?cU5uV0h0aHNIVGNDd21TTDBmNXF1UVNNMzdOMXJYMHBWcm5TVWxyUjBwb0Rx?=
 =?utf-8?B?UXBwYlRQSzNvTVR4UWpCdWxhTzhNb0VuVklDTkZLUGRjMWpsc3NTckc1NTJt?=
 =?utf-8?B?UlZoS1BqTVpIWXYzSHNmdkZ6ZnYvdkxEd1dqNmRrNitMV2lkbUlSUEFDOFRw?=
 =?utf-8?B?aG1VQU43ekVNN2oyYnhsWkNxbEduRWw1WTdWOEJkbk5YNmIxeS9kRFFtQ0tT?=
 =?utf-8?B?SFF3Qy9xU0phbzBIdFBGeGFnQ1VHSEN5NHhuUEgvYlNGNzFPQm55TVpienha?=
 =?utf-8?B?UXZTWHd1WUpTVkRCVGJkd3VBSWtYcVNmSHRPbERQaFhsUmwyNWZ1MmY1bUdp?=
 =?utf-8?B?OFltZ28velI2aWRnU0tBL25JRWZLWUlYYnVZK3pIVkp3b3JjZmZoSEYzNDNO?=
 =?utf-8?B?NnNveVpOTVBTZ09LU0Z6QWdLNFNLTW5QblZOanBUbXdlenk2cXRwRWdUMHBF?=
 =?utf-8?B?SnplemxDbWZEOW1mQ3RDY25wZmdEUEZ1ZG1QeGczbk9MRHdvcTc0VCttRFlJ?=
 =?utf-8?B?eTFsWlJZKzU4OWptVnVOYTdkeXcxU2NmVGxCVDJ6cFkvcGpLS0tTTFhPaVJV?=
 =?utf-8?B?VjB6VDh1RWMvUXJIdkxtZWFqdVgzTjJ5Q0swajFKd0F1QnZLL2dLT1NQNyts?=
 =?utf-8?B?bVUzc2IxOWNzUmlVVU5YUlhNNy9iV092a0x6d3lzTW1JNndBTlNtUXVIdXo0?=
 =?utf-8?B?cHhsa0RLV0pIeEFZTFREQmhpaE1nN0daWVRMWXJROU1jb01teUdoUzFHRVlr?=
 =?utf-8?B?SXpaL2txclFKeHJGYkczMGlOQWY4OHZZSnZuY0ZTdHRXdE1UZGpQWDZFM3Bj?=
 =?utf-8?B?WEI2azBhN3lINUpNU1RSaTdQbmpHMmlZSC9yWDFRZDFld3dZZThZSU1BYVlw?=
 =?utf-8?B?T0xVRnZiMUpzVDI2TjRCbkhJSXJQdXV1aEZFVkFYVkUwY0lzTEhmeUdaQ2c0?=
 =?utf-8?B?WC9rUGFuU0J4Vms0NUlPdC9VeHRyM2FLc0lWN3RjRDBjN29JcFA1NVJwZWRq?=
 =?utf-8?B?NHVkQ3hLcHFKZ0hZbVdVdytON1U4UDg0MTdLSFpuQ1Z3cGtlb1NlOTlXUTVs?=
 =?utf-8?B?U3I5WVlLOXlZMW5YWk4yMlFMejAwWktJU2tkRnFnd3pobVp6K0JMcmd0Wm1D?=
 =?utf-8?B?SGJmZTJiVGNvd3hiUW0vclNjbnpKYUsrd1ZyWFdkUG5mcW9TQXR5VVEyS2lS?=
 =?utf-8?B?OUJnMVpLVDVhd3FIdzhhWFFOb2J2NmlZc3lLemtJajJXOXRuR0tIUFBBY00r?=
 =?utf-8?B?SmhmQ08xRWhMdVQ1S0M1a1F0blVJNDFOby9ubXh2UXpsSHdsN0xlOWRZRHI5?=
 =?utf-8?B?d2ViemMxcU5tS3NHd1JqeGROcTVyS09HdGtidkwyZG1mWW45NWlubE1MUzc3?=
 =?utf-8?B?U2dYamZjVEJyL1N3UmJOVkhKOEVHWWxBdjhYMlRoeXR1NHpKczdKeHdUU3FE?=
 =?utf-8?B?WklIRGdjSXZKcXhEdGQ0QldKUXY4WVBGOXBZYURaTlFGMnVScWp3R29hUFhS?=
 =?utf-8?B?VkFjdEFQSTNYOTVrWUxFNWc2M2xyUlFyZktjdkUydnZHSlVMRVVoT21CNXhV?=
 =?utf-8?B?akFDUk5VNE9FOE5ET2xITTRBVnhSVnQ4ZnhjSnpPaGRPa1V6bDUwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4191a83-cab4-44aa-b334-08df051a5363
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:37:53.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ff/HMqPmb5s3TSktmUfXxnm6MR3dfRVFRX7P5eZH4MciuFtmKyy1Vgu9UkZnxcjFU3NuFQPyRQBzJoj7KaN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072



On 8/28/26 10:24, Mikael Etienne wrote:
> On 8/28/2026 6:22 PM, Limonciello, Mario wrote:
>> BUT the issue internally does show the issue is specificially once the
>> 32-bit IOVA space is exhausted.
>>
>> Unfortunately; the solution is currently a BIOS change in how the type
>> bytes of the IOVA is handled.
> 
> Hi Mario,
> 
> Thanks -- the 32-bit IOVA exhaustion detail is the first thing that explains
> the timing I see. My failure takes 3h25m of sustained reads to appear, and a
> reboot clears it completely with the same kernel and the same on-disk data.
> "Low IOVA space works, high IOVA space does not, and a reboot starts from an
> empty low space again" fits that exactly.
> 
> The ASM1166 write-up you linked is also a very close match: a controller that
> advertises CAP.S64A but cannot actually reach above 4 GB. My SATA controller is
> the AMD 600-series chipset one (1022:43f6), which is Promontory/ASMedia silicon,
> and it likewise advertises 64bit in its AHCI flags.
> 
> Firmware, since you mention a BIOS fix: I am already on the latest available for
> this board.
> 
>    Gigabyte X870I AORUS PRO ICE
>    BIOS FB1c, 2026-07-21, AMI, platform firmware revision 5.41
>    AGESA!V9 ComboAm5PI 1.3.0.1c
>    CPU microcode 0x0a70520a
> 
> So whatever BIOS-side change you have internally is either not in AGESA
> 1.3.0.1c, or not sufficient on this board.

It's not in any AGESA release yet.  This is very fresh information I am 
sharing that we have root caused the issue and have a proposed 
modification.  It will take a while to make it through the process 
machinery.
> 
> On the bisection: before committing to two weeks, I would like to try making the
> reproducer fast. If the trigger really is 32-bit IOVA exhaustion, then booting
> with iommu.forcedac=1 alone should hand out high IOVAs immediately and fail in
> minutes rather than after 3h25m. If that works, a v6.19..v7.0 bisection becomes
> an evening rather than a fortnight, and you would also have a reproducer that is
> practical to run in a lab.

We do have a reproducer in our lab environment that will rapidly 
allocate and trip this issue which is how we could analyze it and root 
cause it.

> 
> I will try that tonight, with all services stopped, then the
> amd_iommu=pgtbl_v2 iommu.forcedac=1 combination Vasant asked for. I will report
> bytes re-read, wall time and workload rather than a verdict.
> 
> If you already know that forcedac alone will not behave that way, please tell me
> and I will not waste the evening on it.
> 
> And to be straight about the rest: this is a production home server, so a
> two-week bisection is a real cost for me. The reproducer is three lines of fio.
> If you can run it on comparable hardware in your lab, that would very likely be
> faster than me doing it here -- and I am happy to run any specific kernel or
> debug patch you want in the meantime.

I don't yet have any confirmation we can patch this at runtime.  If I do 
come up with a way to do that which works will let you know.

By chance did this issue coincide with you switching from something 
different to the Ryzen 7 8700G?  For example switching from Raphael or 
Granite Ridge parts to that Phoenix part.

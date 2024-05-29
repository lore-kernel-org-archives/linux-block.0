Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0C2F56
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963989; cv=fail; b=IAfBKNkvHYixTEO2DPXXMQ6ExXd2pckt4nVckVZi7XEGUh2bpqDITNjiFkcIhWggQbWNr3TZKgUO3o/RQATxOnKWP4tKTV4QLPhqdA06oFdsaQXF6uQ6B3IWmdAzTQIlJUl9Drj4QxY185oOPhwbIqwGjg1nhyWP2C1r1ci9Qww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963989; c=relaxed/simple;
	bh=7hE13DlxiEd/pMlUY663+kmwgIUojzJEKmYQMWm0NY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2nnPtjiVbF9S5SYhiHEDoO49IW4Jw/tZHlHOgG/RVrZyL2omxQsP3OxA6aBzVckEthN+dXe8D8vXcXUTw9/IVpZ+jw7qksqk4X842jesnVeixDsm1q7GnjbgtmkqPo/utFnArmBt/PZOZ98poDXMTer9ZOfx0npBvgHwYYSB+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXKTsrks; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXKTsrks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l71SOmAGEwoIrbTUrGb3dPEBwi619luleV5v6dd7TZuolVDZR5phRdl8Mw4dEIcjJYabbgw85cGSFtXoCxPGzN0CU3+5vnLtBkNIcCh/ViLpoNd2Lw8UMXmQ6Cz2+hLufQ8R2UT5q+wvJ5Pq0mimOoB1qy+C9IQahnR33gAzdEtg9wLiRSBdzO1pUZQ4dLHmiNF/8j/q8+ZNmSDMf81gugF72sx6mH9Ca4mvL4pb654LvWwlE75VhoF0ZZbVUClARptH7hoXqnHk+l+orGUpn515rXyDHa8RBM3QOfUtDWnf8fqVUDQUtraKrNyoNXY3B4sD25RgpW83hFnyoLoxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6yCLjT5RHxioQQ+VPetIPglRE6F6/i8hYQQYPmbRxE=;
 b=kBSZ9+DPHC/n9rwXA2CYN/iLu5gOQQpchb3tviCoKp3PhMR4Z2TwAl2iTcCez+cAv7isb9Ic6zRRBu1weKf19KdOLAjHBITEZJCHpRqJU7Dr+5HlEaRXI2FsWaxrJKApqLDBZSkjrrPmxoEHbCakMqsaBEi36klvtc9ZJQw2XuMA8TPCnLwEbSjFQDr574X13UU7zmUX8N+YhzYuM+xFqI7yAbeTzL0LGqT/xA5ntarKUL2M6FFtEEApB39QOY4tLuaAiDpkw4QWXC9+f/Aemmk+B8dswfvL6kmLTzpulOVEzdlh4XpdcC3ExkQBCZuyLo/B+kfFVDlt7SEDhxNDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6yCLjT5RHxioQQ+VPetIPglRE6F6/i8hYQQYPmbRxE=;
 b=BXKTsrksCL4uMTvX4anWaY9+8eAhFzzDr7bC6/6JYGZcjV2ojGGMsgDq1CKYZYErErkS5DxUCEkruXlca1IUK14wFrakIPgUmdZbBs5n2zN6MmYOGutqI0YApB1hUBB+ih/It4USLxb6n9F1QHZylx/MDgWFw/LRn7k4Op3ZlgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Wed, 29 May 2024 06:26:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 06:26:25 +0000
Message-ID: <f9252410-a295-4ad5-9925-228119011539@amd.com>
Date: Wed, 29 May 2024 11:56:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
To: Yi Zhang <yi.zhang@redhat.com>, sivanich@hpe.com, kevin.tian@intel.com,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-block
 <linux-block@vger.kernel.org>, iommu@lists.linux.dev,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 suravee.suthikulpanit@amd.com
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org> <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
 <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
 <CAHj4cs9W=OEZTPqi6jx4Hinebz8VCJBpngHnr5LO-+xqWMrG2g@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CAHj4cs9W=OEZTPqi6jx4Hinebz8VCJBpngHnr5LO-+xqWMrG2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: e5826d9f-1afa-4ef7-273d-08dc7fa843c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDBxNW9VNDd4V2RDZnFpVlVMSWtWSjVZMUY0UXpFVjdpWTdUQmFJbG8rYm9m?=
 =?utf-8?B?ajFtZ1V5Zk9kSEFsaEFxZDZWaHZ4R1RlOGFwNEExNGlJVVQ1VitjaUlJbVo3?=
 =?utf-8?B?VUpZQTFRSDhJNG5EZkc2UTJNU1dvclcyQUx1YlVnUy9VT2NrQ1grZmZPV2dk?=
 =?utf-8?B?MW1WOC9jTlpFUHM4MVVKSU00T1JNM1c2c2dQbXYwM1lCRFUwNTVWbi9TZStp?=
 =?utf-8?B?SjgvOHl0NE00Y1VtVjdSVHM4Rm1lTnZPM2hzU0hBS3IxbXUxNFlaekpSbWdu?=
 =?utf-8?B?Yk9NQU5UWVI4V1NtY0pmMnNPWWRtY1ZaYlVLeG9ZeFVReWpqU2xTTWFyRktk?=
 =?utf-8?B?TUk2ckhzWGhoSjZNQmF3V1JmWThtemZETHdCelNkWStIZkN5SEJWRnRoWjlX?=
 =?utf-8?B?bzhlR0t6ZWZvQ2I4bFhuZDQvek9WUy9HemljOHRnR1d2TEpoNVNUeE9JcDd4?=
 =?utf-8?B?Q0dOTURKK2JTNDE4Nkx5OG8waS9OWXZLdW5oVFpyb29qVVRyVERLQWdyVXNr?=
 =?utf-8?B?SUtPN3NGd3ZYZ1I1Y0c3QkdPZnlUa1Rzb2tBWG80eFRMZTdoRkgyZnBqNElW?=
 =?utf-8?B?YlBrRkNkMVkweHNaYkRBODNvTXd3Y09tSzBTWDZYaTVuTEZ4N3czMk1tWEN5?=
 =?utf-8?B?NUlLK2VCdG1RN05SRWhET001V1dydTJyVFF3YkVWTThnbktSSE8zNHhZbW55?=
 =?utf-8?B?T1B1VDhhVWRYTTFpTmdBUGR0NHBNUkF3U3JJbTRINUFjRk1Zc2IyMGx3eDVL?=
 =?utf-8?B?RGZRUHpmeUNPcTZSdzdzWHFVeDZaVTFMcEc4UmZsRXllWm5oZVNCdWs0cERP?=
 =?utf-8?B?T212T1Q1NkRzSm5acllpRkNBNWdIZlpwaUl6K3dKWUdvM2wrWTRLZ0hwMXFD?=
 =?utf-8?B?bU1qZzkyWS8rcmM5N1FvS0RCbHp3RFk2c3R2UU5pbC85cXl4ZGVrTjJVQXFG?=
 =?utf-8?B?c2hXWm1kRHF5N09HSHo0dEdIbVE0QUFZNm1HYjMyWGl2U0Z4bHdBNCtSQjEw?=
 =?utf-8?B?R0hrUWNydUprUHl6MC92YUtPUmNPTnV3blZ6N2tlazhiSUR1SUxmLytnRytX?=
 =?utf-8?B?ejgyYnVUc095Z1IxZDBaNTYvYmZVVkFpY3hoV21OSmlwMW1TZHNBdGMyRDlh?=
 =?utf-8?B?WUJ6d2d5a09sVFNGekJYQ0s4aTlPQjJTQlV3dFJCaDJENTArN1ZTODBhaXIw?=
 =?utf-8?B?c25VNE5jM3Y1SHBrc1RraDNMaHhPNWFBNE10bUFGbzFLazdTSDZCTzlkMzJp?=
 =?utf-8?B?UFozVTZnMkZCYms3cGtYMlFveGZBMDRRcFhlZWZPWUxzbEt0OVdaTFNqSnBN?=
 =?utf-8?B?RmlYT2VtV3lsWVlrRE9LdVhZcFVvRE0reU1xUGtVSEI1Q0Q2L0V0VlJqUHUw?=
 =?utf-8?B?VXloTjZiMi83QTV5a3ZibkJrN2ZZVmNwb2dsdk1RMUlBSDFLME82bHRYWlVH?=
 =?utf-8?B?MEtVNDMxK0RiRGNBaW9qRkUrMkVQbjV1UXhmcVJpV1laNWMwYm42ajFwbjA5?=
 =?utf-8?B?djdNUDhkcU5aTWk4WCtldVl4VGUxbVczWGpoYXlqVTVmSG5GR2dwSkpFeFVL?=
 =?utf-8?B?Yyt0M0Jmc0JmK3hXTVhKRTVlTm9jYktCMVpxOUhSSzlKV0dsVm9lNFl5aGph?=
 =?utf-8?B?WkJKU09EVXo1UjZtb01HQ0l4ZmxTcllWS25mNnAyYm1BaHRPSzFGZzlnRmlv?=
 =?utf-8?B?RUJ2M25vZTBXdDBFQ2QyWGdEMTFjWTZFWnd2dFRsRisxVm00Y0FuTkRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHhMbnZMUUNDSjZXNjhweFhZTXI2YkM0d2VhVEdCbGZ2aENsS3prRFJNTWRm?=
 =?utf-8?B?dFNpaTl0U2c3ZHlMcFpyTkZ5RU5jNjEreFZUZGU1TXNFNEhvaEdTQStJbkJk?=
 =?utf-8?B?QktBR1U2VnkydFc5dVFKM3k5WUpJWjdZRUxxeG8rK3B4WDYxY1dYcWNJSVU3?=
 =?utf-8?B?aVRsWU8xTXh0OEtHUzFMQ0ZVNG00bjRvRVBGc3ZsZVhMZ1EwTlNFL3h5SFMy?=
 =?utf-8?B?ZWdMdk00Mm96VnJTQWhrN1VOSVBYOG1nUVZJMUF4WC9sbVh1Vjlxdm1xdzVs?=
 =?utf-8?B?ZG0rcW5OQ04vc05qV1RiUWhlTDZSTG43ZUtCdjVHcVplRE1MMHk1U0hKU0Rx?=
 =?utf-8?B?RDFoUWp5a1p5V1pLcXBuOEpDOGpncC94aDZwS1ZIOG5kMlU4NFJubU42TGJh?=
 =?utf-8?B?YUYweGdldWMvb2VtZVNGamF6aVlJMW1nUndoNi9NSHc5R1lYODBiQmZaZ0Zn?=
 =?utf-8?B?cHJLMlBFVGFvVzVsN1FPdjRYT28xT1A0L3U0OXQ2ZFM1bXpoaXZSVm5qTkpp?=
 =?utf-8?B?WDZBNzBjeHRHV1E4WXczS0NpOWFQQWtSSlhjR1ZtWjBEYmhzN3hLMGJRSGNJ?=
 =?utf-8?B?aFI2dkhGWFMrVG81UFVIeUxDcytWTEFzaDJ6aGVLYkRGS0ZheU9jL0xFYUxy?=
 =?utf-8?B?alFZOTI5OGxTeVFheWREYXJMMXFvT1N2NUFBWGJybjBsUnUzcDhjc1FEVFhM?=
 =?utf-8?B?R2hZR29Ia2w2b0FwWEc4blBQVENrOGMrL2tLSWIzMXB6ZTk3b3RLcVNONVhO?=
 =?utf-8?B?TzdDNTBRNC9neDlDRkhaTjZTUXVCRGFGQTRMSE4zRTF0S3doNmMrUkQwdHdD?=
 =?utf-8?B?RHpwby91SWFZQ3dMc1M2Wk1FMkFKVngwNkxqOHdjNUQyZExTMmx1anFlTWZj?=
 =?utf-8?B?NC9wYUIrUWNUK1BxMHJjLytibHQzTGFZK1VJdGdldk9LKzl2ZDA3VVJYWnRx?=
 =?utf-8?B?T0JscVJIVTVmaSt6bVJJMGhpUXZoZG9ZbDFSMVlEMWtkODdGZFhCd1l0OWhs?=
 =?utf-8?B?THEzMGZsSjAzV0h6aWMwWDRvV3k2NDJjNnprYzE5TXEvQm5TUlZGS05EWHRM?=
 =?utf-8?B?c1N3dmUrZ0s3ak85aUdWZ1EvaEltUGIxSVFsRFFMOTZVUWkvdjNacVFBVGo4?=
 =?utf-8?B?Snl2dWJ4eXBWNjU5OCs1QUhsT2pBRXZ6d1RnUXFNT1Z3My9Pa0NwK05DY3ZW?=
 =?utf-8?B?dW10cllMWFJKUWR4QlM5YjJ0NXlGaVNHYmN0T3ZRaXU0cEFEOEhOcWtkWVRa?=
 =?utf-8?B?TVZUQk5kR25PZHdmUWxkbDg4ejExV1pIUUJCWG5nOVAvWTJHYVR4bDc4MTlE?=
 =?utf-8?B?YTI5akp4cy9mSURUeGNTTTNXMGMyTmVtdVM4TnRBaVJBSTZLeEJHalFTT0Z0?=
 =?utf-8?B?UWZCWWhkeWlQOHdXY0NVaGZKNnpkak9jWmZDT1NKQnZNSTl3YTd0dXlWZ05r?=
 =?utf-8?B?TWV1MlgxMVRTQ0F1Sm4rWExNbkNUdXNhcVJDQkdKczhrTWUvVE5JN21uSjlx?=
 =?utf-8?B?Sysvbk5ZcFQwWi9UcWtIZEhHNFJQcEJnVGx1K1U0Y1BPcERwcEhBOTdMWFBH?=
 =?utf-8?B?WWdsWjg0YlJrOWZPbk9mcTNPaTNybWpnOHZMZkxWczFKR0Y3ZG9rT3hsL2xz?=
 =?utf-8?B?UWtMQ3VuRnNsQThXQmo5N1FaTjdsRXNzWmU5K0tPSjY5ekhEQ2dhaFVHUEFE?=
 =?utf-8?B?WHM1QnhzT2lSL1hGYjBPblZpWFpnaSszVFJ0d0hIa1VySFE4ZXF2SlFLbzF5?=
 =?utf-8?B?dUVNSXpQUkVNU2pRKzBSZkpFVmNRZ2F2RUROMElVZjV6L1JBMlNpQlpwYW1Q?=
 =?utf-8?B?NVYvM2s3d25ic3hJTy9HSWJ4b2tJRGhaSi9nc29xUmZDVnRZUHNqRlV0Q3d3?=
 =?utf-8?B?UjF1eDFpZmNtc3FaSXBVVEhnSnZ6NERKMkE5ejUzNEMzSWNhZUN3bjdreS9M?=
 =?utf-8?B?SEc1M1JrU21Rd0pYZ1NnUE9pZjlHSTUvOVZMNHRSVDlPRFBDY0FhSUh2Tjl2?=
 =?utf-8?B?ZDhFRnc4L29oRjhPUm5kY29ML2Y0UVVmS2tuL1R0Qmp1NDFqV24zZFJYOGFD?=
 =?utf-8?B?V1FSSjVqTGVEbTJjWUtMK2VLZTNuRHNLOUhGQ0VyTHlNQWtUbjFiNWRHbkRW?=
 =?utf-8?Q?KHWG1gwOXAHQau8IYVM7CsZ13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5826d9f-1afa-4ef7-273d-08dc7fa843c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:26:25.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6oMnNgbkbxEX/+kAoGKVZvn1HDjSmHi9LTem+2XdJMOfaR4LqRjosbKFCRxCFBSfN5wwyfNt6Aw0kJl19Mguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

Hi Yi,

+Dimitri, Lu, Tian.


On 5/29/2024 11:46 AM, Yi Zhang wrote:
> On Wed, May 29, 2024 at 1:40 AM Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>> Hi Yi,
>>
>>
>> On 5/28/2024 11:00 PM, Vasant Hegde wrote:
>>> Hi Yi,
>>>
>>>
>>> On 5/28/2024 10:30 AM, Joerg Roedel wrote:
>>>> Adding Vasant.
>>>>
>>>> On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
>>>>> Hello
>>>>> I found this regression panic issue on the latest 6.10-rc1 and it
>>>>> cannot be reproduced on 6.9, please help check and let me know if you
>>>>> need any info/testing for it, thanks.
>>>
>>> I have tried to reproduce this issue on my system. So far I am not able to
>>> reproduce it.
>>>
>>> Will you be able to bisect the kernel?
>>
>> I see that below patch touched this code path. Can you revert below patch and
>> test it again?
> 
> Yes, the panic cannot be reproduced now after revert this patch.

Thanks for verifying. AMD code path (amd_iommu_enable_faulting()) just return
zero. It doesn't do anything else. I am not familiar with cpuhp_setup_state()
code path.

@Dimitri, Can you look into this issue?

-Vasant

> 
>>
>> commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
>> Author: Dimitri Sivanich <sivanich@hpe.com>
>> Date:   Wed Apr 24 15:16:29 2024 +0800
>>
>>     iommu/vt-d: Allocate DMAR fault interrupts locally
>>
>> -Vasant
>>
>>>
>>>>>
>>>>> reproducer
>>>>> # cat config
>>>>> TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1)
>>>>> # ./check block/008
>>>>> block/008 => nvme0n1 (do IO while hotplugging CPUs)
>>>>>     read iops  131813   ...
>>>>>     runtime    32.097s  ...
>>>>>
>>>>> [  973.823246] run blktests block/008 at 2024-05-27 22:11:38
>>>>> [  977.485983] kernel tried to execute NX-protected page - exploit
>>>>> attempt? (uid: 0)
>>>>> [  977.493463] BUG: unable to handle page fault for address: ffffffffb3d5e310
>>>>> [  977.500334] #PF: supervisor instruction fetch in kernel mode
>>>>> [  977.505992] #PF: error_code(0x0011) - permissions violation
>>>>> [  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff063
>>>>> PTE 8000000719d5e163
>>>>> [  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
>>>>> [  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
>>>>> 6.10.0-0.rc1.17.eln136.x86_64 #1
>>>>> [  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
>>>>> 2.13.3 09/12/2023
>>>>> [  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
>>>
>>> amd_iommu_enable_faulting() just returns zero.
>>>
>>> -Vasant
>>>
>>>
>>>>> [  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>>>>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>>>>> 00 00
>>>>> [  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>>>>> [  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>>>>> [  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>>>>> [  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>>>>> [  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>>>>> [  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>>>>> [  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>>>>> knlGS:0000000000000000
>>>>> [  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>>>>> [  977.625927] Call Trace:
>>>>> [  977.628376]  <TASK>
>>>>> [  977.630480]  ? srso_return_thunk+0x5/0x5f
>>>>> [  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
>>>>> [  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
>>>>> [  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
>>>>> [  977.647830]  ? __die_body.cold+0x8/0x12
>>>>> [  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>>>> [  977.656979]  ? page_fault_oops+0x146/0x160
>>>>> [  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>>>> [  977.666392]  ? exc_page_fault+0x152/0x160
>>>>> [  977.670405]  ? asm_exc_page_fault+0x26/0x30
>>>>> [  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>>>> [  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>>>> [  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
>>>>> [  977.690527]  cpuhp_invoke_callback+0x122/0x410
>>>>> [  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>>>> [  977.699593]  cpuhp_thread_fun+0x98/0x140
>>>>> [  977.703521]  smpboot_thread_fn+0xdd/0x1d0
>>>>> [  977.707533]  kthread+0xd2/0x100
>>>>> [  977.710677]  ? __pfx_kthread+0x10/0x10
>>>>> [  977.714431]  ret_from_fork+0x34/0x50
>>>>> [  977.718009]  ? __pfx_kthread+0x10/0x10
>>>>> [  977.721763]  ret_from_fork_asm+0x1a/0x30
>>>>> [  977.725692]  </TASK>
>>>>> [  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
>>>>> dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
>>>>> ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
>>>>> edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
>>>>> dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
>>>>> acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
>>>>> ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahci
>>>>> crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
>>>>> ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
>>>>> t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
>>>>> dm_log dm_mod
>>>>> [  977.786224] CR2: ffffffffb3d5e310
>>>>> [  977.789544] ---[ end trace 0000000000000000 ]---
>>>>> [  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
>>>>> [  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
>>>>> 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
>>>>> 00 00
>>>>> [  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
>>>>> [  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
>>>>> [  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
>>>>> [  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
>>>>> [  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
>>>>> [  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
>>>>> [  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
>>>>> knlGS:0000000000000000
>>>>> [  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
>>>>> [  977.969129] Kernel panic - not syncing: Fatal exception
>>>>> [  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
>>>>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>> [  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>>   Yi Zhang
>>>>>
>>
> 
> 

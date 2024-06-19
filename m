Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2109.outbound.protection.outlook.com [40.107.249.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557880BFF
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794627; cv=fail; b=Lba9oZmOvZaTYa8UPw9vDsFg5T1c18MnNgCDSPHotLuf9vJ+0IdTcUu0xgLxJFe6STUXgR8TTHIClWVg8HD1FxDAKPa4i0u6bCwM/Df6+c2oNoHhkuk9Y2AmZ1ZOD8t+hX0YMjjqZsxpiY4VL3RmB1shOUzEOnKSio3SEewCv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794627; c=relaxed/simple;
	bh=DkDfnOvz+AVQnzH4d/l5IN/mH4Ori7wl1PeybD7tiLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxWkRKRwxtafC752lY1hKOC+4whEzsLSD2YlWHQHs+h0Ctucc2EtVw1ZG7L2+4mHHlXob8pxc6EwwHEwQbvSXkde/SuidnzC+ASeMOBYnzpkbaYzrfZmIq7MSZxWXbp97c0/m3L/6NQV5kgrfyr6PBR/qU+TqRytt6l+dM55qGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=Rx8PMdri; arc=fail smtp.client-ip=40.107.249.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="Rx8PMdri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPV8/IBSsLvMcLc4DerAohfB5hcj6cKSkygsEG/6iib8aUmZ1/GiwTWwBHg+KI65XJFeioJsLXVpFQ3m5gmEFUZe8DSO1UHXaHxFMBjnxkrTdqsPLLenGyk2Xxo4fFk80U76/C7rdWj7JTsSnfCkUAvm6jMV5Nr9tYi/5LaMMXHTaCg8cFtlhJx9p8pWyput4tFmY7U9AGpRIB+vGKOiGZhjjmRVwTsPWtqNv6EecrGglPS54QRdkIivU0M0aHlOEP+W39pkyr86dMJUP87+Iv3L7NROiZgZfc0TSqpP7ecapHuufJqHcd9wCBPEeYSYoWT39iJZ6Dgvu+FeUwwN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkDfnOvz+AVQnzH4d/l5IN/mH4Ori7wl1PeybD7tiLs=;
 b=P1wMphL4b7PD6guwElg/ggmqL94eidOxjcch1X4XDwpop99YHkZo+SJIoq1U8VURiaOu7sdun17WZUrk3wqlk8goC/QBd6J70kJ7sgrEM3LfwkOEDUzYVqP5tjtNusxBhz/mfbpMufjm63bAKGi1KAd7+QG5PbMg51zLBW9kQFVDpZVo6HgR/CoOcDOyDAXzC1klci0keBixcvdZDXSXMzZx6eY56M2HR6zrRK32ywZGh4PQR9GLSjhhiwEo+IUHdJM/gO3SqN96GD7eBbQR1qOwU54sgJRqMOF1cYOJ0djy37SPCFFsnUR48ltqYUhdIz5xL0N7NYJEAjH4F/8M6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkDfnOvz+AVQnzH4d/l5IN/mH4Ori7wl1PeybD7tiLs=;
 b=Rx8PMdri+wll0GufCwxlzTlg5ARtUpIbc5FMmpUHmUQZWkI4Eg7AwFQvQ/jo37KHwJIMjkiN+ULHjYrl9JnLfU/lhEIaHflj4Bnn2rz92Slp1InG0/xR0ESLbbhvc43htZpY/csJHiX74GdbA/4dpByTvBTGEpQpseKqQz1a6RVTP/gUb59ScaXKArvn1BEDC24BL05qfk+K7vtKwdSJWeZA4upCnhwtBJI++2A5dzio8heQzmjuyWyA6jGKw1UO5Q0eQObiNRGfLbaU9mnQJ3rW00qAJa8oVnXy7cKcxP+sddrfSTVfDk0rlOxcS/LuqeeFbsGSItMYArPq8OpWcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AS8PR04MB8819.eurprd04.prod.outlook.com (2603:10a6:20b:42e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 10:57:02 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 10:57:02 +0000
Message-ID: <d551af19-494b-4f6b-8226-a0a65bf5e7ce@volumez.com>
Date: Wed, 19 Jun 2024 13:56:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
 <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
 <8c121c1a-a100-4cda-98fe-393c593e2f9c@volumez.com>
 <edemct7jaeuhy6qugbpuilmdzdyy6xvj3diqdliw7z2tie2vgw@ccrxm4cvlr6h>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <edemct7jaeuhy6qugbpuilmdzdyy6xvj3diqdliw7z2tie2vgw@ccrxm4cvlr6h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AS8PR04MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc82110-f302-45a4-7e9d-08dc904e8c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3o3UWxWMFRYVk1pQStCOWlxNG95U2ZKUnd0QkQ0QUlmMnlOQ00wMXZyMVZ4?=
 =?utf-8?B?cy9KZ3B5QzhYSDBFQW0yMlJTS1ZCbm1tMEpaLzk1cTZFVnkzZWo2Mm5rdGVS?=
 =?utf-8?B?RHF2VlFCL0ppUUlkdnFraHFhU1VKNVRRcCtRdHFUeWdaSzBLOUFUeVMyYUtw?=
 =?utf-8?B?MUQ4ZVg2ZENRY1lVWWlIUjhSdjVWVVJTNW1ub0dDZG5nbWMzR3BuZUtEL3N5?=
 =?utf-8?B?VGRBbXJIRFJGZUQxTlY5bWVhVzdjZjI4U24xVk5yZGF0bm0wdGxyNDJnMEhY?=
 =?utf-8?B?a0NmNzBQUVZ1Nkkyb1pORWNKb1IyaFB5SUZrNnp0Z3ZGUnozY0tDOUpMc0lI?=
 =?utf-8?B?MlRGUWMxbnBjYnVKSEZYZzZzYTNoaWNXV2JmWnBhS2cyWllHMUUxZFIxbGhu?=
 =?utf-8?B?UjJtcmkvQ2doeTFoYVgzSmxMazdVZmVMYTV4eERuQmxjaDBLc3FjWDhuZFQ3?=
 =?utf-8?B?V1hLS2o5ZGc0bWNWWUhWOVFjQ0tvZ2NoanNYV0p3azZqV3YxUDcxZ0NHV0NO?=
 =?utf-8?B?a0xBUEgzdys3SnpSSWFGS0xHNlVkQm5Va2dVakQzY0hTZE1sRk0vMGhVYTd3?=
 =?utf-8?B?RTVVbGhZSlhoazRQcHY1eG03d3V4RHhiVWlZRTAwVitZMm9TeHNJM3JsU0Nj?=
 =?utf-8?B?dTJYb0hYaFNSeVhCM3NpK0c4aWNiOFkvNDBpZU41ZkQzRVYvMUZ4SmRCb1Q5?=
 =?utf-8?B?WjJHQk5qRm9oWUxONXdzeHBDUFRLTXI4Z3hJODRuT3JpaWt1MVZmNlJOaVB2?=
 =?utf-8?B?YmF5czVXczFaSExRaWxyc016UlRLRiszendxaEJiVXViQ1lkWEJ2QU5nQmVt?=
 =?utf-8?B?UUpXbGxGQUpOMHN6UHRiODNkaWdXRnRrOTd5cHhNVmhpWFVmMTN0eFJsNDlB?=
 =?utf-8?B?WVhpakZ6V0pZL0N3Tm5ZcE9TRHNpcjVkZUdEalY1cE54a3VMSE5FbDU4Y29w?=
 =?utf-8?B?djhmRW9CTVNIMTh3eEhVMTUxL2FYRDFXRzRwTlJXeHVuK1pGRS9mclNCc3lW?=
 =?utf-8?B?Z1dOMytQR0NtbGRVWFBQNWcyUkhoR2NYdHU5NTlXaW5LZHlnVnJNMHV3eDZC?=
 =?utf-8?B?allrOUZRNWdpVzBWYjR2TVhjMTh1Y0ViRmtnWE5SNm5haWh4M3VBOGZwQmtx?=
 =?utf-8?B?N2c4ZnNoOEFuNW92SjVlOWpsZUJ2dHdsdG9ObjZQVDNRSitQTlhRdmlyNFZz?=
 =?utf-8?B?eldPVHhDbTd2NHhRaFJoeXVGb2l0Ynl2ajJhZ0g0N0h0elI1R3QzblFQeUJy?=
 =?utf-8?B?a0xxQTBOOTFiYnBFcFpFMVNFSFVhMEFSdG5EN3hqc0l3SW5RdnpXRmtabUls?=
 =?utf-8?B?QjRLN0l2UHFQeHYzL2lMY2tQSlgrbmh6dkRibFpJMnk4S3gwUVRjTE1Fczdn?=
 =?utf-8?B?cEpIeTgvVHFzcFB3WU9xSkFITFNDRW4wck1HMmJtdHdCVC9KcitMRDJBQjRI?=
 =?utf-8?B?Qnl4VDA1RzBNalhXbjdhQ3Z6Q3pZT2dVSHpDcUU1L2NGK1ZZUFBWL1ROU1li?=
 =?utf-8?B?RmY0SEY1LzAvUDlLeThuSmFBTldLbjh6ak51d3JmNzNRK2VMUCs5WmtCeXRY?=
 =?utf-8?B?YWZlTFBEN0JVSWRIS3JhMXV2Rzl6RDJjeVIzbGZ0NzcwQnRPZVFMYmNBNDFk?=
 =?utf-8?B?UGp6emlzdDJtZm9BTC9iWnZvSjNCcVMxWEZmb2FlS2x0ZWcvS0JON1BlekdR?=
 =?utf-8?B?ODdscUFlSXpiMXo2L1g1bEtKL3d6akIrZ1RkQkRCcWl3aGROUk93c3p6Q0tr?=
 =?utf-8?Q?3RgVeJ7atR84tjEktfwEJpkCd2RKF2YkywXv4Yl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdROE9BRTlJZjBxYy9zU1EwTTdNYjZScDIxa3k1VzJxdUJKd0dEZ1l6MmZw?=
 =?utf-8?B?aXMvZ3lIRTVYYWppSk1hNUcxNXNnR1UvL0FxRDQ3WlZYUzhjN0tlb1hnWFNM?=
 =?utf-8?B?b2ZDVFVZcndtdHNTTXJqK2JzZTFwUzhmY2NocXp0U3dMTUVtQVp1cmFqREdm?=
 =?utf-8?B?aUkweEtTbHpWSWozQmcyblFFblgvNHNCenRVUVl1cTFCNlpRT0RxenFxcU1t?=
 =?utf-8?B?bGJwQyt5T3haYW84Ny90dzNyWThiWGxpdHlnN0FZYlJPdHdtY1huSjdDNlhj?=
 =?utf-8?B?ckdNdzZWNXdhWThSMU1INk5GaEVUcm5oUkJCYVBSbnZieU5jR2NpdWU1amRZ?=
 =?utf-8?B?TDFGcCtBTGgrMVJicXdtOEE1YnNBTURyVSs4UFFxczJsTVJvOWFzOFBibFpi?=
 =?utf-8?B?WTh6bUc0a0Y2QTM4eFhFSURnTUQra0lSVkxTV0VtWTgzblViYUI5M3JjQmR3?=
 =?utf-8?B?YmRQSWFHWDNCYkNmZGNIcDdkV3dweVhYTkJRRi9IQTBHNmpiZFVrR1NlNnpr?=
 =?utf-8?B?RDJ6bGlBUTI2SlNRd0dvZ2NzZG4xaW5pc2UrdVhocWpvdTNkWGJlWWQwRVdp?=
 =?utf-8?B?MmpLUHM3RXRXMElPd2lZbUFwZTg5dzk5OUJjV21YM3M2bXFHbm9uWk8wZVNq?=
 =?utf-8?B?NVBQcm5XaDhkdytUeEZVNnEwZ2ZGVXF3SzZ4SjZNWDloOW1NMjM5YXQwQ3Fi?=
 =?utf-8?B?MmZUbWQzaGJRSFlmQzJTTnZSVW9hZUNMR2s4VXJ2ZFpHM21HVHpXVkVaZmZh?=
 =?utf-8?B?NmcydEFZWkpGWFZXeVBlNzhYTFU5VXVhN0xsQmh5SVgwTjJqN29xZHY3d1d6?=
 =?utf-8?B?MXRWOUV1WGY2ZnpxQ1gyN0hUNEp0UndSb2pFdnd5V1FQL0tKcTBQYnc1aVpx?=
 =?utf-8?B?L3hobUs4K1VzaWJQSmpuYUdXUVZGZFBXNHpWbkZMa3BidVlFaFFiRjNZRkYy?=
 =?utf-8?B?RnJsTGRoTWFPcW1GWHk1VUdMRFl1b2hnV3dKSGdWeG9yMXhzZEdsaUc2TGxm?=
 =?utf-8?B?algvMEJsM3V2R09vK1RmK256SUJwR05qWjQzSENrN3owRVR4bFZrWmdhNTlJ?=
 =?utf-8?B?WFc1NCtZRzlBYU11aHF3S2Zvb2ZWVjdJV25OL2pnM0REaGpRVzNKZDJDZlVv?=
 =?utf-8?B?eFVhODVuRXVGbHhLRVV3UjhoaDhvbndrZXM0a3h3dlNaZER1ZVVHeVk1Tyts?=
 =?utf-8?B?ejVuTzA1dHI3dm1BeVRsVjAvZ09TNGhoL0JTOWtLYUUzSitHU1VNTWdScW5H?=
 =?utf-8?B?NnFsek1lSHB4NERzaVp0c29UMHRjZFUzclhFOG0xWlBsRzVqZnY4QWhoeWpG?=
 =?utf-8?B?MmxuQ3pWbk0wRnB4d0FPOFJZZ3I5ZUdaOVkyb2VsVnBtUVh0U1pOcHhxOGhP?=
 =?utf-8?B?T3pFalNGUG0yeG9LMjgyZzNWZUQ4Z2lEd1p0N2NnUGRGZnZmQ2xzSy9IbXha?=
 =?utf-8?B?M2dVZ1BoMmxZaVNPZzhaU28vUllDNi9uaFdhOHJJeElnRFB0NmxTVUppZGNR?=
 =?utf-8?B?UTh3TmhsSHEzQVZYRGlaUFE5VVM1MUlEbStBNUljNXFzUlNQdXdnVGl3RFRY?=
 =?utf-8?B?VUJTOTJScVp3a1puWXRJYk5ybXlQTHJ1QUFZdUpUamRsTnNucU1MVm12M3Rn?=
 =?utf-8?B?TE1nSlZwbGYwcm5qY1RSejZaakZUMFE5NUpuMTh4YkR3YWpBUHUwVi9TRy96?=
 =?utf-8?B?cktKalFIdHlxam52UEZpcGcvb3FJUklUQTEvbjhoMjFSeWowUlB3L2NacFRR?=
 =?utf-8?B?c3ZaYnpFVXVzSDNyMmtsZjRZd3EzNlF4eEFTQlFhRFV1VmxzN0V0UDJpSDNR?=
 =?utf-8?B?VC9saDVDY0I1aE1nVk1HcGY2MjViaGRNV3gzSFRkb3JGdURVK3U2K2IrMDho?=
 =?utf-8?B?cmhwMUR3T0w0OHhwbGdhUm02TlIyUU5LZGloWUNlRms5Q3Q2MW9YMjlmNlNK?=
 =?utf-8?B?WmlLSVBicndFeGw5ZzFBNXZDb005U25NT2puR3J1ZnQ3SnFyRlFhcDNObXRa?=
 =?utf-8?B?TzFYRnEyem56TWo3L25ORWtNVkYxNkhzWXFUcXd6bTQ2SGpudE1KV3hQNzdz?=
 =?utf-8?B?eUlHYXNqTkpJNks2aFdkNW9SYVRoZjFHNndwSWg3ODBpOTZqZkhUNlNZMW9Q?=
 =?utf-8?Q?SK8CkSMDEw1+JKxWPA/RPnjri?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc82110-f302-45a4-7e9d-08dc904e8c76
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 10:57:02.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzrkH0Y2wQZJ45k/vk3hwjuskp+EZFiS1DKdt8g6p9jasfLnRgunPEwXOFqOyVhuQDoq82mMp4kNLha0OixHkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8819



On 18/06/2024 11:38, Shinichiro Kawasaki wrote:
> On Jun 18, 2024 / 10:45, Ofir Gal wrote:
>>
>> On 18/06/2024 4:24, Shinichiro Kawasaki wrote:
>>> CC+: linux-nvme, Daniel, Chaitanya,
>>>
>>> On Jun 17, 2024 / 19:05, Ofir Gal wrote:
> [...]
>>>> nvme-tcp is used as the network device, I'm not sure it's related to
>>>> the nvme test group. What do you think?
>>> I see... The bug is in md sub-system, then it's the better to have the new test
>>> case in the new md test group. To avoid the cross reference, the nvmet related
>>> helper functions should move from tests/nvme/rc to common/nvmet, so that this
>>> test/md/001 can refer them. This will be another separated, preparation patch.
>> Ok, should it be a patch set or two completely separated patches?
> I suggest to make them a patch set: the 1st patch moves the nvmet functions from
> tests/nvme/rc to common/nvmet, and the 2nd patch adds tests/md/001.
Will do, thanks!

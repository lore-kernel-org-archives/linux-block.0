Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2B6FC2;
	Wed, 24 Jul 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813397; cv=fail; b=BqQwlVeBbgBcf1kzQ6sz0jDeMHf1eivYWqe2NHZZ3d8jV9CFTilygvmT3wtRu1E+rjIeFp6mHqhSegQtlmMZO+BmNAHJndXQp6f1zW4+QiVNqQqhuKGMLyKlGQ96C2uyQKZ7/vKnVBP++0T6xXRTfXfJyTQ4dPCO4HsOJLBLJcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813397; c=relaxed/simple;
	bh=MgM9wd/pw4j5V4RP8r/x7xyvWHzM2gAOeTEy/AAXvvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MExb9b8uv+zijRDTIafK+qjx4L2Fbu6R8RLmOmlpKIng17JrXdO8HIZYV8iucU2VnsaX2OcvYpOSaeZm8vLXu9pXAebqKt7htk7wMN44Texxl4F42RugXwux22MCyOkpVdO0qhgFn2/xQm7hwYauN9PQyVNFFlhfXovClDtEsfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KI0nst3Z; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KI0nst3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMMAqFGY2Gv+Tczl8+eeSPRlDRKh9sMxBnAI7x+2GZzfmbFw/lGabRMGtYpn79hvUCIflah01eNwDpKn3py3ZNYkDJdm5X3Msdjx4nzMvPWoMa9ynXXD0pIveXonDt/yMCDE0VK2bxweZ+ITz2SMXRnfUgpUi4yXL5AnT4XVTZmM+b/twWFU0jIKE+Fody3QYgc64T0cgzUFeoUQIef5wR5SGeMFXTseOmo6W4sru9Da0Pc7qKC+gta7v0ftjH7rG4Mx/uYybiCYLGVilWxV7qjwAL1yjxpnpIxW1+wKNWESmelZkDcmsf6VwzogCGVQUsvwrMmvJ29OsjFVPqVnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY6TY+xB7Eh4WerPFzAbdQmO1hUEYZ/JujZB4UOWgGA=;
 b=hl+MOkl4hKO6bEM8DA5X8FEqCGNMo3MULxflAJcg+PhSFzREtlTIKWn7s+B9Xo+VD0+i73+3Q811xY2317SjZM++t/RS1cbvSLdwXj0jOH8jHVuTLuP2DVQyW7H67dO4hMOdu/KwJvDMUTRbCopOlbKKC3BAoIj334TJXGqQ613ciseyV7bIRq8+yZaWjmCuJj+CEECaftWuC80YDRxHDF3SqhHD8KeKgc+kRxewTOtWE+O+5/sRlWJYJtqCdofx/rI2QKvrrw6c4WGf3uUCJkIxCfIhTTaNGFbhjdNqbkhwLycZ46CJrIXh+M7jUgfbmXj7dEAaJ5FdeF9SLjR+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY6TY+xB7Eh4WerPFzAbdQmO1hUEYZ/JujZB4UOWgGA=;
 b=KI0nst3Z/L7gBQX01Eh1iBSwbembjfrdcfKhNcjYqsbBN2o4imPN2/pW6ACSRrzfRIio0BwCscG3JM/iqaG1udbpDr5w1y1x+pxC9Xdh/NhufhGaUmGja0aR2XUORAixryYczPerIFXq22c+XH7bUaH92lQmYYuEe1wmaWjzowacl+mAIUcKCQKUrmczpO0y3WK5mOw4Qejux8BTnYMmL/HWDO60IE3dl6sWUqYLi3DAFaOEeTHs0xwWjvE9uchEGlfAOOm6ICAvCI3zVPUOkG08snhjlDg0URRnrfyYEtTGSjwXzvLBxNWJRilA1ZmmlLSkWMx9cfwGuzQJvy331Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5442.apcprd06.prod.outlook.com (2603:1096:400:31e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 09:29:45 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 09:29:45 +0000
Message-ID: <a32c39f1-ff9d-4a57-9d6b-063adf53602c@vivo.com>
Date: Wed, 24 Jul 2024 17:29:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bvanassche:block-for-next] [sbitmap] e992c326a3:
 BUG:workqueue_lockup-pool
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <202407241556.b0171c94-lkp@intel.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <202407241556.b0171c94-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::34) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 527d9f9c-13df-42d3-aede-08dcabc3279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WSs3cUluY3ZBNjFMY0tGNzB2NkNaRExhaEV2REtoVXVBekxHTU9XeTR0ZDZJ?=
 =?utf-8?B?ZENhdGt6OE1COXVLS2ZXM0dwbEhKcUNTMXZXOVF3cStYcDRFL01rZ0l3OGR0?=
 =?utf-8?B?bEVraHE3OVAyOG9aTjl3cXV5NFJodXErSVBaSjBxZmh2aGRQV0xVSGJha1hx?=
 =?utf-8?B?WWhOYzNyMVcwc2hXOXBzdXVLdnB0ck5ERG5MRG00QW9QakpIMVVMMmlLZDZP?=
 =?utf-8?B?S1Y4UG1YWGxYVTJnWTFEWmpubkZ6Q0VFS1E1Sy9ZZGQ5MDhqN3c2TmF6WDhs?=
 =?utf-8?B?NHVzMlFWVnd1STE2NTE1N1Z5N0NTMjUxNXhUNDNIbFM5Qm9ZN1FST0JyQjVC?=
 =?utf-8?B?Z0ZQYTFmT3MrdXlVZUs5UTNwc0xVK2F3aXZITHVEa1FqRG0vUCtqNlpYWGdj?=
 =?utf-8?B?SG1CcDZFTnBrWnU3NXdLKys3Tk1ndjQzSFRkRTB3a04ydzBCZ2NWb0pyYVh3?=
 =?utf-8?B?cENuNk5ySUYxOXUrNXFuWlhUZmJJREMzL3Q0OUt1ZEFzSjhxZGVFNHJWY09J?=
 =?utf-8?B?bmFJZVc3RnJFR1VCYU9ldDI2cnB5QUF1aUVwbWVqdjVuTElCdnRTeU9oNTBT?=
 =?utf-8?B?OHk4ZGx0b1dOSkdBb3lBR0ZEUS9zdW55REUwV1hPTVBDRnFGZTlsM3VYNDJa?=
 =?utf-8?B?L3dqbUR2SU1pandheS82TUd1RXloR1hncjRMYko4UUFYNHAwUzBwWFk2MURq?=
 =?utf-8?B?TUFQSmIrT050M2k1Ri8zWnFIWWoxMGxST1lIRm5Qb21nRDU5WWc2ZFNxd1Iw?=
 =?utf-8?B?Nk5qL0V5Z2lHTzI3MmpqVy8wQWhhM3VLRUdJR2RZcmF2TGd4SE5jTHdiNG8w?=
 =?utf-8?B?WEcremZGNWhkR1FIU25WUHBDTzVBd0FGWG5iN3FnZHJWZFFsSWIvaHpKczNW?=
 =?utf-8?B?dThJMm12UGloM2NiMjEweC9zYkNVWTNRbVlCRUZrWDVBVTJ2eHJQYjE2Ujgy?=
 =?utf-8?B?eWVaQVJ0YWp6VGVnYmdhSEhxc2tidlllUnRTN0NodnRRTkp3bnVNaTJyM1Vp?=
 =?utf-8?B?TWV2ZC9na2ZKUDBLbDlIZCtyOVg1Y0NFbUdadXdCVGpQQkQ5aWQ2aGhNbk5t?=
 =?utf-8?B?ZDQxWFpXK3ZmVjllUndMUlNCL0diL2xaTDhHelBBZXFKYkJsN3kzRnlYQytT?=
 =?utf-8?B?ZkY1Y0xFNlh5TkQ2NlJqRytvUWJhQlpNa1BpSGZRUkgyZlBGTWhGYXkzc3lV?=
 =?utf-8?B?K2JLMkF2UWV4M2ZiNFdPUDJsMG1LTS9UNW5CeDRvY09HS3lLdmpRdnRuUStt?=
 =?utf-8?B?cUdLSzdOUlRVcC9PS2dLL0RBNG1aeWJweFYzUTFJM3N1NFpMdzJUbWsxNnFP?=
 =?utf-8?B?SDhZNktGamJEelYwTDdjbjg5cUJqSDBTV1F5ZTRlS0ZZbFNCZGI5bTJYU29V?=
 =?utf-8?B?K2crZUVoU2c3MWpNNm5FSlFJeHd5ME1JMWFRcEc2eThqTUFtRGh2ZFptdXBD?=
 =?utf-8?B?L1pmcDR5WGFxNFl0SmdqZ1FtZ3lQS2FsUUxHTGdXQU1aRU5GbmFJaVpCNHRZ?=
 =?utf-8?B?L21PRzJQNFEwazFMdnRPT1M5dlk4VUNYTFNuUmd3aG1YQlZVdnZhbEhaQTdW?=
 =?utf-8?B?azlqOE1KWGNpWXA2SFN2NEdIK05sQU1sWkc4TXMxekZHUWo5Z0NDenA5UkhO?=
 =?utf-8?B?aUx0eldTM2NtbXN3dlRsYktSZVkwQ3FzZDVJbk9wSHhXb1F5MnNWVjVESkY0?=
 =?utf-8?B?R3c3Z2Y4b0ljeEdzdE1CdzQ1UGxTVkxFcm1KalZpa0liRzNTb25tUktaa2cy?=
 =?utf-8?Q?oY6wLOxCIyfWwzrf7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWk5V3ZBK2NGeFlxcGFlV25VNGpNcUdNbWtCUGtDRWcrK1VzQ1JnVk82YVZW?=
 =?utf-8?B?eGdrb203SzBSNFNlNFdCdVZvalpvRjFzZHBJMFJXZTZEdXlzNzU0bUF3aGcw?=
 =?utf-8?B?WXVMSUhuSUxMaU95cGFvVGtMTmNIUGRCcHNqUnR4U0xRTzdvZ0VSWEVBeDdJ?=
 =?utf-8?B?anNaSWhLV0E1QlBkR0ZjcHduYUs3Q0Q1VjdvTGdrY29aTG52TDZoRWU2YUhQ?=
 =?utf-8?B?bEJIYTc0WGs4TWhOb1plejVnaXBZVnBCVUVmNE1BOXJDM05FR05ud0pFOWhi?=
 =?utf-8?B?Q0UzZ1EyQ1F3dHlUamFIVFliMmVDSHQ5SlBWL2RBbFBBUFlqZnNPRzB5Tzk4?=
 =?utf-8?B?eHNLZENIakhjTmxoSFpxTTRqY2tRdnlQUmFHanE5WHVTcnU2TjlOazUwN3hQ?=
 =?utf-8?B?U1BvSnFGeWdESkpQUHE5SGdhRlhJSGZoQnppRmhzTkRjeDFYUGJxNDNId1B6?=
 =?utf-8?B?eTB6WVY1d2ZjLzd3MjlCZlQ3TXl6UW5DNG1JTVY0Ykx1UWtWVi9LRlhFWXAv?=
 =?utf-8?B?RUdQZG1jWENWaTFpMEw3eEFqby9jZXFGVm13SXdUZlFZdGgycmtuaStRWVIr?=
 =?utf-8?B?RjB6MTRKZDZEd25rSUIzVmdhMVgxQXFXRHcrYmJEbUp6NS9Oems1UjR1OFJT?=
 =?utf-8?B?aGV1aVVkQ0pheGUwemp5eGxLZXVLbC9Dem1GYnhkcW1XVC9wSmxSVW03anE2?=
 =?utf-8?B?eGNIZ0wyQWFTaHFhTStIWkF6WDhxekR5MWl3T2hqa1dFWFc4VC8vSXFKQzNG?=
 =?utf-8?B?dS9zcE16S1pEd2dXWGhDZklUR0VRK2FPMnVVbEV3Z0lMS1V5aUpNVzc0SGJZ?=
 =?utf-8?B?Q1BGUVdDdjFRcTBxZWZLNmhpcGhNYWFxbnd3Sk1HUzA5U0lqL3VZWXB4NGtj?=
 =?utf-8?B?ZWwxYmxhNU90SDYxZ3dlNFo1a2l4THZ5OHV1ZWVCK2xOVE5lSnV5NW9rTyt5?=
 =?utf-8?B?ZDhobHJjd2h2ajlsQ2pTWS9IdGdWTjAwSHZ2RE5uWFRjNkU5VFlWS01KSExK?=
 =?utf-8?B?T3dMN2hnb0pVK1U1TzFaTTVVVENYcml5d3ZydzcxTWZZejc1Rm5mL1hxREhn?=
 =?utf-8?B?cVF6bE1HOVFQMXQwUHBvYUdYaU9ybm9YcnpyL2o3VVV2eHFxNEJxcHhOZEgr?=
 =?utf-8?B?eTVjRzkram1SbS8xTDF5ZHF5aTY1T25KTVVTQldiQVpEWE9XRHlycVMyb0J5?=
 =?utf-8?B?TEpoRzE2MmVCNTBNbTFodDB3Sml1d0tNaHMvOVNBV2tYU2s0T0MzZ1daOGl0?=
 =?utf-8?B?eEJwajNEMUc1cGR5OVgyU0dOL2lVcjhNWW9MNFdzM2lGZEdvVFVNQWcxQU9P?=
 =?utf-8?B?MDdjRk1lbDE3UEY4Zk1tMGtRUmFyem1tamgxYm1Ia3B4QmNwRUFadkJ3eXVF?=
 =?utf-8?B?NzZJb0pQTVlLMTNIU1RYNDVFTE1OUTlJUXRVci9STDNaK2tRaFI2eFpGRDYz?=
 =?utf-8?B?TFZvMlNXRlJUM0dJOUxCNlkxeUR6VnY3N0IvU25KdzdjQ0JxYnJ3THJIZmJ1?=
 =?utf-8?B?YUR0L2R1RExnMFdzTDRNNWtKeEdJUDloV0R5WVlZcGhiS1p1bDFBSWhoSGxj?=
 =?utf-8?B?L2dDWXFOWENiRlRFTVRsd3dtSG0yTDhveFBVbGVxQlU5QUJLSzFyQ0k0RDdw?=
 =?utf-8?B?d2V4NW1OblYybi9TVDBFTWk2N081OEM3bmIySVpOakxvUEZsc2xzSWZMUHlv?=
 =?utf-8?B?SzV5TjlnbVBzeFNZZ3ZQNk54YmVFQStoVVlnd200L056Ym03d1N4MHlJT29u?=
 =?utf-8?B?VWFBVjkzR2ZyckpyRkZEWGZMNjRvVURNWG9aVWptY2gxU0M0RmFCNldCYXlk?=
 =?utf-8?B?MEdTSzZGZ0JpU2RQVkVUb0JiTlU4NnBQcEMxRGZFTHVQTS9RSGlOOEZpYXJ3?=
 =?utf-8?B?NWxpMjJDT25hR2xITHh2cW1kVEVxNDhVbTRXV2hrSzJPZjNCUnB1OG9PcWht?=
 =?utf-8?B?RW9CS2t4SEc4Ry9pZUkvT2hLRmNJU3dXMFo1NS9CU2t3N1BnYkNuMjM2c1Uv?=
 =?utf-8?B?bHJsSWdJa3VQYnN6ck1ZWTNncEtZM2lUMk90c3lxdUdHMDA0VmhhZ3hWaUlQ?=
 =?utf-8?B?VjI5d09qU2tXdTcyaC9ESFdWRjgreDZqTDZ1STczRzVKZWx4QjlRTnJVckdP?=
 =?utf-8?Q?tApKRYoa1nqA0SphZSta5RfuF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527d9f9c-13df-42d3-aede-08dcabc3279e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 09:29:45.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gt+BxcTdfxHtnMir9ke+8LWl37PAaXdF01Ye9+3fwohWIfkeWEwh/gK+U/EguAeyDpzFDFxf68AmfCaknq/HWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5442

On 2024/7/24 16:15, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:workqueue_lockup-pool" on:
> 
> commit: e992c326a36a35afe13a4c16094e2a76a90ed5eb ("sbitmap: fix io hung due to race on sbitmap_word::cleared")
> https://github.com/bvanassche/linux block-for-next

The patch in above branch is different from:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=72d04bdcf3f7d7e07d82f9757946f68802a7270a

return (READ_ONCE(map->word) & word_mask) == word_mask;
should be
return (READ_ONCE(map->word) & word_mask) != word_mask;

Thanks.

> 
> in testcase: boot
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +---------------------------------------------+------------+------------+
> |                                             | b0c61a9e6a | e992c326a3 |
> +---------------------------------------------+------------+------------+
> | BUG:workqueue_lockup-pool                   | 0          | 10         |
> +---------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407241556.b0171c94-lkp@intel.com
> 
> 
> [   64.765231][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 43s!
> [   64.766333][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 43s!
> [   64.767306][    C0] Showing busy workqueues and worker pools:
> [   64.767861][    C0] workqueue events: flags=0x0
> [   64.768319][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
> [   64.768335][    C0]     pending: e1000_watchdog, kfree_rcu_monitor
> [   64.768392][    C0] workqueue events_power_efficient: flags=0x80
> [   64.770225][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   64.770228][    C0]     pending: do_cache_clean
> [   64.770249][    C0] workqueue events_freezable_pwr_efficient: flags=0x84
> [   64.771967][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   64.771976][    C0]     in-flight: 26:disk_events_workfn
> [   64.772005][    C0] workqueue mm_percpu_wq: flags=0x8
> [   64.773657][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   64.773660][    C0]     pending: vmstat_update
> [   64.773697][    C0] workqueue kblockd: flags=0x18
> [   64.775275][    C0]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=2 refcnt=3
> [   64.775278][    C0]     in-flight: 27:blk_mq_timeout_work
> [   64.775293][    C0]     pending: blk_mq_timeout_work
> [   64.775376][    C0] pool 6: cpus=1 node=0 flags=0x0 nice=0 hung=43s workers=3 idle: 40 1001
> [   64.775391][    C0] pool 7: cpus=1 node=0 flags=0x0 nice=-20 hung=43s workers=2 idle: 859
> [   64.775400][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
> [   64.779459][    C0] pool 7:
> [   64.779465][    C0] task:kworker/1:0H    state:R  running task     stack:0     pid:27    tgid:27    ppid:2      flags:0x00004000
> [   64.779480][    C0] Workqueue: kblockd blk_mq_timeout_work
> [   64.779493][    C0] Call Trace:
> [   64.779504][    C0]  <TASK>
> [ 64.779541][ C0] __schedule (kernel/sched/core.c:5411)
> [ 64.779563][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543)
> [ 64.779571][ C0] schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6823 kernel/sched/core.c:6837)
> [ 64.779573][ C0] schedule_timeout (kernel/time/timer.c:?)
> [ 64.779580][ C0] ? get_page_from_freelist (mm/page_alloc.c:3431)
> [ 64.779588][ C0] __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116)
> [ 64.779591][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543)
> [ 64.779593][ C0] wait_for_completion_state (kernel/sched/completion.c:266)
> [ 64.779595][ C0] __wait_rcu_gp (kernel/rcu/update.c:435)
> [ 64.779607][ C0] synchronize_rcu_normal (kernel/rcu/tree.c:3935)
> [ 64.779614][ C0] ? __pfx_call_rcu_hurry (include/linux/rcupdate.h:113)
> [ 64.779617][ C0] ? rcu_blocking_is_gp (include/linux/kernel.h:? kernel/rcu/tree.c:3894)
> [ 64.779618][ C0] ? synchronize_rcu (kernel/rcu/tree.c:3985)
> [ 64.779620][ C0] blk_mq_timeout_work (block/blk-mq.c:?)
> [ 64.779629][ C0] process_scheduled_works (kernel/workqueue.c:3253)
> [ 64.779647][ C0] worker_thread (include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410)
> [ 64.779652][ C0] ? __pfx_worker_thread (kernel/workqueue.c:3356)
> [ 64.779655][ C0] kthread (kernel/kthread.c:391)
> [ 64.779668][ C0] ? __pfx_kthread (kernel/kthread.c:342)
> [ 64.779671][ C0] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 64.779688][ C0] ? __pfx_kthread (kernel/kthread.c:342)
> [ 64.779691][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> [   64.779704][    C0]  </TASK>
> [   95.485253][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 74s!
> [   95.486737][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 73s!
> [   95.487606][    C0] Showing busy workqueues and worker pools:
> [   95.488179][    C0] workqueue events: flags=0x0
> [   95.488650][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
> [   95.488679][    C0]     pending: e1000_watchdog, kfree_rcu_monitor
> [   95.488820][    C0] workqueue events_power_efficient: flags=0x80
> [   95.490632][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   95.490635][    C0]     pending: do_cache_clean
> [   95.490669][    C0] workqueue events_freezable_pwr_efficient: flags=0x84
> [   95.492426][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   95.492429][    C0]     in-flight: 26:disk_events_workfn
> [   95.492527][    C0] workqueue mm_percpu_wq: flags=0x8
> [   95.494193][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
> [   95.494196][    C0]     pending: vmstat_update
> [   95.494265][    C0] workqueue kblockd: flags=0x18
> [   95.495840][    C0]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=2 refcnt=3
> [   95.495843][    C0]     in-flight: 27:blk_mq_timeout_work
> [   95.495858][    C0]     pending: blk_mq_timeout_work
> [   95.495950][    C0] pool 6: cpus=1 node=0 flags=0x0 nice=0 hung=74s workers=3 idle: 40 1001
> [   95.495977][    C0] pool 7: cpus=1 node=0 flags=0x0 nice=-20 hung=73s workers=2 idle: 859
> [   95.495983][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
> [   95.500089][    C0] pool 7:
> [   95.500106][    C0] task:kworker/1:0H    state:R  running task     stack:0     pid:27    tgid:27    ppid:2      flags:0x00004000
> [   95.500132][    C0] Workqueue: kblockd blk_mq_timeout_work
> [   95.500169][    C0] Call Trace:
> [   95.500195][    C0]  <TASK>
> [ 95.500259][ C0] __schedule (kernel/sched/core.c:5411)
> [ 95.500304][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543)
> [ 95.500320][ C0] schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6823 kernel/sched/core.c:6837)
> [ 95.500322][ C0] schedule_timeout (kernel/time/timer.c:?)
> [ 95.500341][ C0] ? get_page_from_freelist (mm/page_alloc.c:3431)
> [ 95.500363][ C0] __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116)
> [ 95.500365][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543)
> [ 95.500367][ C0] wait_for_completion_state (kernel/sched/completion.c:266)
> [ 95.500369][ C0] __wait_rcu_gp (kernel/rcu/update.c:435)
> [ 95.500399][ C0] synchronize_rcu_normal (kernel/rcu/tree.c:3935)
> [ 95.500420][ C0] ? __pfx_call_rcu_hurry (include/linux/rcupdate.h:113)
> [ 95.500432][ C0] ? rcu_blocking_is_gp (include/linux/kernel.h:? kernel/rcu/tree.c:3894)
> [ 95.500434][ C0] ? synchronize_rcu (kernel/rcu/tree.c:3985)
> [ 95.500435][ C0] blk_mq_timeout_work (block/blk-mq.c:?)
> [ 95.500464][ C0] process_scheduled_works (kernel/workqueue.c:3253)
> [ 95.500516][ C0] worker_thread (include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410)
> [ 95.500527][ C0] ? __pfx_worker_thread (kernel/workqueue.c:3356)
> [ 95.500530][ C0] kthread (kernel/kthread.c:391)
> [ 95.500585][ C0] ? __pfx_kthread (kernel/kthread.c:342)
> [ 95.500589][ C0] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 95.500636][ C0] ? __pfx_kthread (kernel/kthread.c:342)
> [ 95.500640][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> [   95.500679][    C0]  </TASK>
> [  120.705227][    C1] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  120.706866][    C1] rcu: 	1-....: (25000 ticks this GP) idle=71dc/1/0x4000000000000000 softirq=2935/2935 fqs=12477
> [  120.712272][    C1] rcu: 	(t=25002 jiffies g=2261 q=805 ncpus=2)
> [  120.713520][    C1] CPU: 1 PID: 1601 Comm: (udev-worker) Not tainted 6.10.0-rc6-00303-ge992c326a36a #1
> [  120.715344][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 120.717321][ C1] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152)
> [ 120.718629][ C1] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f ba e6 09 73 01 fb 65 ff 0d ce bc 10 7e <74> 06 c3 cc cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc cc 0f 1f 00
> All code
> ========
>     0:	90                   	nop
>     1:	90                   	nop
>     2:	90                   	nop
>     3:	90                   	nop
>     4:	90                   	nop
>     5:	90                   	nop
>     6:	90                   	nop
>     7:	90                   	nop
>     8:	90                   	nop
>     9:	90                   	nop
>     a:	90                   	nop
>     b:	90                   	nop
>     c:	90                   	nop
>     d:	90                   	nop
>     e:	90                   	nop
>     f:	90                   	nop
>    10:	f3 0f 1e fa          	endbr64
>    14:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    19:	c6 07 00             	movb   $0x0,(%rdi)
>    1c:	0f ba e6 09          	bt     $0x9,%esi
>    20:	73 01                	jae    0x23
>    22:	fb                   	sti
>    23:	65 ff 0d ce bc 10 7e 	decl   %gs:0x7e10bcce(%rip)        # 0x7e10bcf8
>    2a:*	74 06                	je     0x32		<-- trapping instruction
>    2c:	c3                   	ret
>    2d:	cc                   	int3
>    2e:	cc                   	int3
>    2f:	cc                   	int3
>    30:	cc                   	int3
>    31:	cc                   	int3
>    32:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    37:	c3                   	ret
>    38:	cc                   	int3
>    39:	cc                   	int3
>    3a:	cc                   	int3
>    3b:	cc                   	int3
>    3c:	cc                   	int3
>    3d:	0f 1f 00             	nopl   (%rax)
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	74 06                	je     0x8
>     2:	c3                   	ret
>     3:	cc                   	int3
>     4:	cc                   	int3
>     5:	cc                   	int3
>     6:	cc                   	int3
>     7:	cc                   	int3
>     8:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>     d:	c3                   	ret
>     e:	cc                   	int3
>     f:	cc                   	int3
>    10:	cc                   	int3
>    11:	cc                   	int3
>    12:	cc                   	int3
>    13:	0f 1f 00             	nopl   (%rax)
> [  120.722091][    C1] RSP: 0018:ffffc9000027fa60 EFLAGS: 00000247
> [  120.723180][    C1] RAX: 0000000000000286 RBX: ffff8881335dc4c8 RCX: 0000000000000000
> [  120.724696][    C1] RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff8881335dc4c8
> [  120.726162][    C1] RBP: ffff8881335dc480 R08: 0000000000000001 R09: ffffffffffffffff
> [  120.727782][    C1] R10: 0000000000000000 R11: ffffffff817cf120 R12: 0000000000000000
> [  120.729356][    C1] R13: 0000000000000001 R14: 0000000000000000 R15: fffffffffffffffe
> [  120.730936][    C1] FS:  00007f213215b8c0(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
> [  120.732680][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  120.733960][    C1] CR2: 000055c76ff83708 CR3: 00000001482fe000 CR4: 00000000000406f0
> [  120.735559][    C1] Call Trace:
> [  120.736328][    C1]  <IRQ>
> [ 120.737025][ C1] ? rcu_dump_cpu_stacks (include/linux/cpumask.h:231 kernel/rcu/tree_stall.h:374)
> [ 120.738036][ C1] ? print_cpu_stall (kernel/rcu/tree_stall.h:702)
> [ 120.739012][ C1] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:?)
> [ 120.740040][ C1] ? update_process_times (arch/x86/include/asm/preempt.h:26 kernel/time/timer.c:2487)
> [ 120.741048][ C1] ? tick_nohz_handler (kernel/time/tick-sched.c:187 kernel/time/tick-sched.c:306)
> [ 120.742044][ C1] ? __pfx_tick_nohz_handler (kernel/time/tick-sched.c:285)
> [ 120.743092][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1689)
> [ 120.744101][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1818)
> [  120.745084][    C1
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240724/202407241556.b0171c94-lkp@intel.com
> 
> 
> 


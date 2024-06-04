Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D62801;
	Tue,  4 Jun 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483093; cv=fail; b=uzNdR3P7aAEtXQN+rtNyvlkY1h2OdixkZTEE1usI1FWDxU0btvfNZbxd8k1M7VpOF/geGXRI3BOn6EGr8oYZ4Azp4U8AbEboVSrdl/7R3FqkhwGVoMoYMHDT3pVDWdSOQ97RAT43g2XTIuiHPRzE98g7ybLVXE+/dr8zFCitDsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483093; c=relaxed/simple;
	bh=XMVk2A7tHhYzBxkRxJJ3S94rB9NxrdG2AI4CbHyIp6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5FnELNBtz0sEdXG/wwj7VyQ7NC+LH1yq3v9fmfpvACXLokL8q3ply5GVGP1mX2zjW7juPBtwIW5cY50TXTghRjSm3M233RWsaaHRDQqp/8zceNw8ZzXAChw+bLoWncDdjCn+ci/0aVonKl3laXQC6Ws4OhSyormmqQzpcSgIso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MIeIE+0S; arc=fail smtp.client-ip=40.107.117.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MIeIE+0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUK4/TjoUErfQsBvLCF+B1FaAIHGQtHdo7h0ahuvZaxDEFZATKGcRVQ/8AjTxdjOyRm62s+19BaWIiX24VMejm8cJsgrF3kzYbgG2XmfXTlmA0nW251Nh16VqIYqXaCEdXF0DCqAYaQFYzwmQnQsbF/6+R3GF3wfB9M7mOra69LlfVsa1n3dETX5rdit0wEbSeK47HnICOLfnj7kQJtdZcEvtC2velu5DiTSN2b8TB2XsQPxX71gCYxwZ7nDrXVuBYSIpPWSSYVHOuCrro0L4vmE12Sf4s7vK/8apUHFKFHJE+I7FX6d/3kDXpE7XpF2NQ9kCuD5eg0OAFEWwMvcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eSjZtNTNu3cbJS1qGEWpqkygfKF4cQ7U7vDBteUoU0=;
 b=c/KtDy0HGn+4knfA/zDeKnaqY+FA8EK9k0QUjsMlJky77r+wmArD+LBRNfY6vobLHY0A7YLBbnhkYTrM62e4ZZoUkAIINYSykh5RTGl+x48IQNXPNBTtbSCePeZzzvxkHhfu6i1DVn4svf4+/119ceyh30mpj47wHYSVPumxURtxHU1lp+tZ12xWKgdubz8Y8LpqDw0dfDRWByL685Yjz5e1Q6NlHCnG6EvGSU3J26xxPYXJdUmVm5ELvLQbJ3e3FcW0b+dG4acxilcjsj8oiLKDShLa9+zWplPntrj/VNce9ojykvHtAs8LKgu2piwEh9Qj0i/H1JzZYixi4UuIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eSjZtNTNu3cbJS1qGEWpqkygfKF4cQ7U7vDBteUoU0=;
 b=MIeIE+0S0ZH/ojWDK0xKhzcCijQQScfjDwKNQ5G0EcHhcGXgX2aw5kr4JQIv17hT40MQD5foD6oOaU/lH0quZwPsDNKUVBrSacwGMyoJkqOuJvtb5fprMAMmEDw9HTgUmmDwNAMfjZIhtL32iaZQqLd5EcpRNSyCYBM/uCxfIXHbNVSzUskawWHAC0/BZmyONmbBjNDSwHOzOORkRQr/lHQK5Zj9LFpQWVhKLg/fjiegcVhKoCu9Cb8jOMeWAdmTrS9qZNEwPkI+1OL1CmLnhthKS8grrI5JcqhaTpQO1nx8xOw40U2M+BaQbez62IX/HyasDudzKE7GKTKrc7w8HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB6741.apcprd06.prod.outlook.com (2603:1096:101:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 4 Jun
 2024 06:38:05 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:38:04 +0000
Message-ID: <be478487-8509-4bfe-9354-c1c3f6246489@vivo.com>
Date: Tue, 4 Jun 2024 14:38:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: d98840df-e6bf-494a-8f84-08dc8460e34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDEvbWp1YWxsZE42YXg0SkJtSkNnSThQb0pGZGhUT2Fab3Q0QW1vajdaZ3I4?=
 =?utf-8?B?ODBVT3NNNVJ4R3FXWG01UXdmamxXNE5sNndqcmJSK0lwUWFISitRSE1RdnUv?=
 =?utf-8?B?UDNWR0pjc1R5RTN3ZDFzVnRWRGF2eFBwUTFwTkR5STNOTkhlbDM0YTBmbjY2?=
 =?utf-8?B?NlRUM1lxNDBqeVNxWWtPaENVRTVhRGh3QUdFdExyUzdwNmcreFJ3QmVwR2U1?=
 =?utf-8?B?YmIyV3dGZENzcE9yRnl5SmxHc1cvR1R6NktYeVZkVG9CdFBlU1A1dXUzRyti?=
 =?utf-8?B?Q2l0T05ETkk4TGlpVzhLKzY0OHhheUdPZWZncjVaOGpZeW5OaTNVVnRPbXNB?=
 =?utf-8?B?NWdQUDRGK2NBN0J3TlVuMFlZWTdtSitDeW11WDNsbVZSdDc3cW1hcnkraEhM?=
 =?utf-8?B?NlFuSnVEVzFTSFhxcTV0OE1pdE9EQUViQWFVMEJCSEZWbWxJdHQ3SnZEMk8r?=
 =?utf-8?B?eXlUd1FTdFdxWmpybzZSdk5GNTJkSmdSZk9tSlFudTNpQUlYcTh4T2pSV2Y5?=
 =?utf-8?B?b1Zqd05MVHZ4YkxFQnY3K2dRTW1RV1lndVZwdjRCZmcxRFFwOTVOTzY3VVBy?=
 =?utf-8?B?dzV3SXVoTkNhU0ZBcDlyZXgxa3NxNEQreXE4ck42WHJzUGRVb0hFVDJDRHpN?=
 =?utf-8?B?aDdtbnFPYlBtMExHcHV5a2oybHdTOGRyaGZRb0dJUTBwSytvVW44YzB2d01s?=
 =?utf-8?B?b1lCQzJaN0RJQmFSdmtzYnZHSFNhVmtZQzZ0ZDdLM0JXMkhuV21Pb0VhWlZS?=
 =?utf-8?B?cTBjNTlNQllRd1BEdm5OS0NEVkJ6N0YzQ0lMWnlOR1h2azMyS0tzekh0TkFE?=
 =?utf-8?B?enlvVmFXRVVTVGZJMlRZdnJTYkJlYzdXQW04Tm4rNkIwTjQ2THJud1NBNXVa?=
 =?utf-8?B?Wjk4S2lOUTJRU083QTFKc3hKazNYamRnWWVFc21yUUtqdzdQQk5zUlZXeEsz?=
 =?utf-8?B?M1dSdndRNkU5Vm40M1IyQzRlNVMrU09KR0c1K1ZRQ3NCR3FJcG5HT0NjWk5u?=
 =?utf-8?B?ZVZLcDB2Nm1IWHhHY0dvalJoL0k1VHppZDNOd3N4NzZxZkpod1ZMdy9tWm9j?=
 =?utf-8?B?VlBwMW5MWUViUis2ZEhPUE9QMVhaTVdON1hRWnN1ajc2SmhqTUFnbExWS1ZM?=
 =?utf-8?B?ODVNeTY3L1hGdGtRdEdLWFhUaDZ4SEJCVnMyVDh3OVVIN1FFTWtPUm5YWm5T?=
 =?utf-8?B?anNSRFZWYVB4R1ZkSmVQaTlGKy9TSTE3NDdLamdvb0N6ZnU4QkN0RXlUenNF?=
 =?utf-8?B?UXE5R0cyOXpPU0U5K1lpcjRFdE43ME9wTEZOQnJJaUxMWW8wbURrSGh5cnM4?=
 =?utf-8?B?aHU0M3RlNnFrSmV4MG03UiswV2N4QkZmUEo2dXQ2eUJCakljWUp0QmRRSUtX?=
 =?utf-8?B?TkxiNUxPTGZhOVQva1RnV215c3FPYUlKYUhWV2VmUWFrYTk2eHB2VTQyZlk5?=
 =?utf-8?B?ZTFoZUtIcWpTYjMyQWpMRDZ4VkhnTkJvUUF2S0VwSGFnS2ZCeUpDSEdLdnB5?=
 =?utf-8?B?WG5WOEcyelN2dnhuMFFwM3YwREE1TnZmeFJuT3gwYUh6MlhqTW9SUkVzanZn?=
 =?utf-8?B?MndTdFhRanRLaWxCVGo1TUN0SFJtUjNpdFJWTVNnanRGeU4rT3JjTCtuRE9O?=
 =?utf-8?B?dWNPeHdlNU5xMUZPeWtXK3NXYkt4UkdqTDN6TGVjejBKSHB5QXMrdlE5anhL?=
 =?utf-8?B?T1VuYVA0WjhqV2JHMUVpTUJFWXUxVjFZbzdqUXVNNGpFOGpIcHphbVpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCt5RVc2dWlYNCtOQkwwSTJVaGduYUoxejJuZlNtQ0Z0TE81Q1VCa1Q3S0Jv?=
 =?utf-8?B?OGFLVGdKb0hJRnFYUlhDU2ROWFNqTHNtdFBzZ1FLVXgxVkd3b1lPTTlRUmd3?=
 =?utf-8?B?QThtclVibXNGclVpOGprUUJRV2NubGczekF4RVpIVEM1aFpQVmw5NGw3alkx?=
 =?utf-8?B?dEJJNWhOSEVwVWFZTnFUd25LQ3NxekVLTDJTZlJSSWJXZTJFQlIvRmZoRDlR?=
 =?utf-8?B?dWc2dElFOWx2M05kajJ3THIvRkRhYVYwOWFLSTJVL3BIRWFUNUxOeUJwQUlZ?=
 =?utf-8?B?M3dXT2pNWURKWEo2b0xPZW1veXFhNEFFK1RJREZkQUUzY001OEIyVW5oYXlG?=
 =?utf-8?B?TE8wKzZIRHpjemtwMEJ3V3B2VldaZzRmcmtkZWpNdlJwSGRJQTJ5MVRjS2Ro?=
 =?utf-8?B?RXZsS0dqSjFxQzBOS04rWWlZeUV5MzVqcmkxaXRMKzhVRVBrUWdLdG1zWXdk?=
 =?utf-8?B?TjNydk0zSmpEUXZlMVc2YmNxVzVsTG9HbUFPVVlLbW1BMjBDdTB6OVlZRFBJ?=
 =?utf-8?B?Z3ljZWF3d3hTY1QxajF2bDZMZ0hEM0U0OFV5dmJ2cVNKdU5SemxVd3pEU2o1?=
 =?utf-8?B?QXRuQmM1a08vMGoxTGVLVzhnM0F0VzQyWkdTSTQvN0dVc1RUQkRFUU1ibVdR?=
 =?utf-8?B?cGE4dkRmcGpzUmxNUU5SVTFHd3dTRnNpTTIxVmM0N2lBdnVXdW9xTU5BYjV4?=
 =?utf-8?B?TGlURkM4QTd3NGkyK2Y2Z3hBaGk5V3VQUlJxKzNjRGF1OEdub3ZvMUVRZ0NH?=
 =?utf-8?B?KzYxenRZNjZLS1ZKQSs1cnl5RFM2dnZuOFA0VUJ1UXdPUytOdFY0ZUplZzFM?=
 =?utf-8?B?Ym9kV3RYWklxVmF6enBSbDZ6NElzeGpSQlZ3U0l1Y084b2JBVkpyck1KNWU1?=
 =?utf-8?B?MlpEdEFSaHZJcTlJNUY1QU9mREx6TTJJRUtqNkZWV2M1ellCVGZzbkVTMk5L?=
 =?utf-8?B?a1l4eEtDOEFkTGdpWkJlL1gzSGVYbzlBMlpUa2dkK1Y1dmVKeCsyOGJzMzJt?=
 =?utf-8?B?N3UvbEZWTFNRdXpvZmpJMnQwSVFLemRpcDJIam5kaTljT002b056UVR1ZDV0?=
 =?utf-8?B?MkVLMnNwekwxek53RWoyN204VVZyd1pvTFMzcTZUZjdoc1IvWVVaVjRiemNm?=
 =?utf-8?B?VHBsVi9tRHJaOHdoYjZKbVVvYkZVcG1aR3gxZ1daQnBJQ2puWWpVVHNpQ3Nq?=
 =?utf-8?B?SHlDdzBUYWlDOGU0V0x1QWJKR2p6cmYxV0lHcEwzcS84WVdiUVZVenk4d0hq?=
 =?utf-8?B?bG9aZDZSSHpZL2Z4Z1FnblAyYW0xVUY2VkpybWFyN0EvOHFMN0dFZWZ1VVAv?=
 =?utf-8?B?SkxVb0o2bDU0QmJzQW1NbDg1c3VMVVlzMnpKNUhieUd5aEJBMmtxN2NTNlY1?=
 =?utf-8?B?QXpXSnhOQzBmSjZBVGhOZVQyNzV5Ykpha2tIVjZOUVNncSt3bnlCcm9OdEF0?=
 =?utf-8?B?MTJramhEMGVjSzMyQVRLd3BxZmtUQ0VEWENiVzZrUXdDc2dFOWxwY3ZCZEpK?=
 =?utf-8?B?SzRmSENrTXozYkIvSmd1Y3R2T0dZalFyM3FPQU5acW9vNWttN2VUdlNmN1k0?=
 =?utf-8?B?RHI5VnlCbi83eXUzSGtCZTI2bFlieXpvdSs5SUtFNDRhQlhSWGEvVEZwb2V5?=
 =?utf-8?B?WXd1SU1ZTDB4MnkzUjRVZ1RlVVd3dW12dWI3RjFaMU5sWUxySEJTeFlzd05K?=
 =?utf-8?B?cVVoV0l6QjhqVEN4OTJpbzN5NmlZY1JuYWtwZzRYTnA5aE9qL2hnbUprYTlu?=
 =?utf-8?B?bi9WcEIxbGZKcjFNcW5KSVJMa2NmNmVOdGlla1d4cDI4YmhiNElPaDhMVXFP?=
 =?utf-8?B?K05tWC9rY0I5N3dmRndNYUs5VGxPZDBvNTE2VlA0OGlSY2JtemlOUStkVUQ4?=
 =?utf-8?B?bHNlcElaakxON0lZakJrKzVkdGpHMGdoOCsrYTFyRjFwUnJIUGVtVDNnajdR?=
 =?utf-8?B?d290N29EVVRVKzN4RDRZVTl6NFA0N3ZjMkZnMTdWQmU0dlRwSUlGVXBRMzZh?=
 =?utf-8?B?UTZhcUlSa2VFSnUvR1R1Vy9SOXowbktxTmluVmo0dWdJbWVBVG9RTWZmenY4?=
 =?utf-8?B?YkJ5eFVvTlBqZ05xVXpEU01Lbm5hdEFNSXlXMnQrbHNtSDhialJCQTFhbUFt?=
 =?utf-8?Q?9BQ3aOYVLY5O+WUZWZ0PN89so?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98840df-e6bf-494a-8f84-08dc8460e34c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 06:38:04.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arSq7abAfUMOgZ4Dfjzd9xd98QOrbIsSHzwbDbjaL9cIQ64j+e6orH0GP0xKaRP8Z9Z6rS4hW4t9Yg4M5CGI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6741

On 2024/6/4 11:25, Ming Lei wrote:
> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>> remove swap_lock"), which causes this issue.
> 
> I'd suggest to add the following words in commit log:
> 
> Check on ->cleared and update on both ->cleared and ->word need to be
> done atomically, and using spinlock could be the simplest solution.

Thank you. I will handle this in V3.

> 
> Otherwise, the patch looks fine for me.
> 
> Thanks,
> 


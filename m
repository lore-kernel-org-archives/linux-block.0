Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423275;
	b=gDBXu0AAY9raM5M7udQMfdQt8fn757g6w0m9Nr7e+Kld8U+vbo9yF/GZpMClNzqAaTrY
	 hxNXQRzTffiHP/SVDEHaty3u04MBNAR4kzZ9vMSKrIUGuEd6hxUzSLvgX1x5x5CXZziBH
	 EpVhYVSIFs4S4B3Tq9cZUhBlAhDmPg6P1EJs9wbdcT6L6lc2Q65Li9a7fk0x5aE32f+bW
	 JI+FYy4hcMLDYDqjjVMuP4QndK7d0NUhMlfUllR3fKQsRZodo6IRwh1WxBnIEOtosR5Dj
	 pvhVqOJ3X22Yt8qk5NqC3jZk09iKtl08Gk7OfTenjKQdH2uqgs0k6pUVGv50uaJem1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423275;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5Qj0xtD9Mp018R3Ds+40QpFJxSgKqX8iGF1SoCqmO2s=;
	b=TYQ3JGZYXU3wjlsfpmmxfkyTWojjIfOZiD5lzJVoFT+WQ5uiPHBtoBaNbl8HcDohL0XA
	 xdUKG+ghEZmDeGPokfum0aPLqOlt/2OsLTMamhchn14YfB/IF2pHgtFRSn1kWxLPXf/1I
	 6uH8o3KztVAgeUACWoGWNobEKUbTQbyGd9IqOMx33oVcFgOmfCsfE8x9cHOjZ4O9dgbB6
	 pyDQPFpYby1A3FcDrQbuVnDuNZidlYcvKyAPjIazl6IPxe2PVDLNvvPfplIEe6xplXg5t
	 cbS2Qijuq6DZuPFZToTrS8yU3ISno5ZJUP8DmQ1J5OVPghWfSpECaklMZ68Q9xPfv4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SMYezTKV;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=sLpFptWs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2560A7E7E
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 15:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F2560A7E7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SMYezTKV;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=sLpFptWs
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792423274; x=1823959274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2l05Tqw4mDLun+YD/XBddpY4eba5usBGFzghc333BUY=;
  b=SMYezTKVjAa3u3bJ8GRbpAasrM8csGvtWKCVqLoW4hxrIOZjxwqtAcwW
   wdT3XCoiTKuJKdb3edeezrQyXqHwG/SFaJBho7IrWgQhLPcQQHlpj8myV
   KKbGfReiy2AhzDLTxtuEG9hlFM93uXLWbdSuxxzn4/0Eodij4rWmpV53y
   +7Dd+VtYV+kiIfwVonzCxO+VxhZSCni3lNCH00/vywZhiyReOF1GINn13
   ViAybAPSRBCa0y8dvFWuJIYjDMmQSECqcDnxn8Z78uXVxfVYEVk+r758O
   ZdS21TsrAepKDwaysAjsS+ot66kHgzDwbqKXlUEBffpF6JrWPFR7us4dH
   Q==;
X-CSE-ConnectionGUID: E7JT+Z2KRjOc0LJlDC3GWQ==
X-CSE-MsgGUID: C6873GlkTzOpBAIFy/ZrOQ==
X-IronPort-AV: E=Sophos;i="6.27,167,1786982400"; 
   d="scan'208";a="156853029"
Received: from mail-eastus2azon11010000.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.0])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2026 23:21:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avEkt3Tgc2A1HnC1sTTLEmB2q2YJJOK9QZHzF73hQr0/Vzx50+yMTAt4O4Tiz5Ufcs4HGLZ9qzpOlpi8ZR5b74PSSfPKI80stv/VSFFyz6UbkrPkCsk7VByrcn/pTaJ1d/KfR64WXkLg30b3bBYH+0Qyns7DvlaR5FVaotEAN3vgXnQqNpJZbRec4L5KRxt7H3X2mnM+03bxgdJzox1+COIrKZ0G6VkrtCTqKNhc7VwMfvyOF/2AKcQ9AKjlzVz1+RiwRmk3RdKox77FrwGQqBzx8rghgj+Vjweh5D5B17aVkPPkO9SxGtBezRPFf7G+dvtDASpltT4odp0YB1iPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qj0xtD9Mp018R3Ds+40QpFJxSgKqX8iGF1SoCqmO2s=;
 b=Vis+yl0fj2frvJm1CEG9Tchxbk3rUtoVbpoKqbeHMnwSGulrsqA97QhY3sorP6UNu9ItLwp8DMwWwk6CBJK2XYIM50p9E8FDJL1bIxRjYgTduBuf1kEvOjDV7j6PWYZAYyn2PwO1aHDt66wI7YWi1nfIEvFd7IKWmPqXW2onr8qhQrBTCfeNQIWCSzxcnNao0ZY0pNjPzxlHnfdxTaKyF+483cQrKuqbWFgugv87PA1P4ZLNaG4F8egjCT75ED3npJaM4nhZkFw58Y2Wq0w/PU2RBK8RccHpeWkgfejuk9G63ewEJfnzKmRe8g2up31UntteSI1sO87T/RefJVL6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qj0xtD9Mp018R3Ds+40QpFJxSgKqX8iGF1SoCqmO2s=;
 b=sLpFptWsrLI2bsHqlBixdIt5mWrjj0PW3+tc3fgDeDidPTAb0v9AnDZAE4jaq18vqMc2kz0gtpyExiVqCKoYsOWH43ptHk+92cqXbCIuPgrc8cJ1C5uRi1QZeRn6A1bYaGG9cKeNhAcJ12aet4Vaf/F8+ayAlwJCbHPm9nEUHw8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by SA6PR04MB9400.namprd04.prod.outlook.com (2603:10b6:806:43a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:21:04 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:21:04 +0000
Message-ID: <18edcb8e-0ca6-4855-88f7-ea4da0a986f0@wdc.com>
Date: Mon, 19 Oct 2026 17:20:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zloop: print device that had errors
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
 <98713429-e513-4648-8834-71d6b2ab1d5b@kernel.org>
Content-Language: en-GB
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <98713429-e513-4648-8834-71d6b2ab1d5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|SA6PR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9edd18-631e-442f-1a07-08df2df496e3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|10070799003|366016|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Apv56ymiAQ9EFtqaTNFIXzzpsMawMLIEtQBUYbWd0QDTweqIIdh2//+YjHIT1neaHE2rv9xrIam65Kbjo032wRsnurgqBkUzdUTm12W+IsV1577Fsjq1jyaHKPtrySC/PKDSpIPXWYZYAyTeyjgyboZDd7ByWiQipDKAgGmhQB9qhBzQ3ESl2x7jAgH9XFVpA1PI2blV2KaXJX+91NL+42EeN3EWZpxuMvPlCeDqPvSMBOBcw85Ef2rbWNDoZezOeYktZzJlu6BHe4Dd5C1j49ZVaeYBwL4Z0E6IyKjIDIqODF00ORk3tmK88641kaNqmcgb7QDcbS3BmEzkmp2XFkxzzP46e5GnT6q1SCQAcPgh5fLLExMeDNxdyFFvnRXF/YoCbCsorKiQlUtH6Uxq7NT640VXDzHU1O4Rm3t086LRx7XI6vLaPLLCoNzuEredCxTbbipiWsvugwgNcXrZHM1UkX6/dy4atDkudb+Ci2qI1ZG5+Wf4pDfjbz35Mr2kMrETSXg5mbUt4jDrggA1RqPgr/FvzWqUfEf9X32Fz5oqm1zuW4D2vTw6NbE+OappyQBndK/zvXNX6Nxr+rgJzAsX3jRv3aNA7S/jrrbNlIX2Q8caGzA2TyTQOrgqedd9EeS3lLi6ZIv9a5CE43q1SXkSKLyFEKYFUYl0bvqwprw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(10070799003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9qblVOdnBZWFZKYnUvSXRTdk5nSnpDVklCMlFjaEJ2VUZZTkc0MDZLd3Jn?=
 =?utf-8?B?UzgxT3lFc2JvUkU4bWIwUUZBZmduMGp6UUUxUHl2aVkybHlsMEdibU5PaTRV?=
 =?utf-8?B?YU1NWmZXaXhZcGtaS0NiRm9ZeWFYdmFrZXVIUTgwU2ZDS1lHUlEvTUhpVVRm?=
 =?utf-8?B?aVlFc1k1QnM2OTN2dW5kbU05WWRqWjU5UCtQdlFnRGdteEo0Yk9PNTlGdnla?=
 =?utf-8?B?Q1g4dlloTTdHUldDY1JwWjZKVjg3andDY1VQN09hQ3hMRXowOXdyNmxxNlJm?=
 =?utf-8?B?SDRxVWs4MnFNa2xjZTRmakhpYUxmZy9jVnBHQ2d4ZU41TmZteVZyRzlkS3pS?=
 =?utf-8?B?aEloTzc5SWNtNS9zeHFrUm9ITTZpNzJyallXRlNzWWVXaFpocmF0TVFJc0dL?=
 =?utf-8?B?QTFYdVU4OFdPYW9pSC9FWnNZQ1draFZPOXhOQktHd0RMUU03cG9DNjB5Qm02?=
 =?utf-8?B?OXJUTEhiZkdiWVdPc3gwOUJ4RTdMVnNnNTQvYnFqTzJmQ0h2QVhhUkJ2R3Ew?=
 =?utf-8?B?ZFdRMUJwWExKS2hDQ2Rod0FnckxDK2p3bVQ3RWx5WldqUTFpZk5RM3ZNdmRM?=
 =?utf-8?B?NkZXcktJNzJvV1dKazZRclorWGUxeWlaVE9ZRm5zb05YbUxaSXJZYWNla29k?=
 =?utf-8?B?WTJwVk1jU1JISUpVcEZLbzZpTFZxLzZVcFhGZW1pSDFQNUdTcHQ0NTZ6bzgw?=
 =?utf-8?B?V3JpeXN6NzcrMWJsdy9BdkExN3hMcHBGV0FJK0k2NlNFUTdTSEluL1hKMS9W?=
 =?utf-8?B?MVlEbFNVMmkvZTBFVUkxNGljU3dOREpQSzl2cnhzaEJGOXRKUUhjWi9LZXNH?=
 =?utf-8?B?Y2d1RTlDYkJ4ME1JMnBRRVQ4RElwclNEVk41VjJneHpxblQxRnFkc21PWWdU?=
 =?utf-8?B?U3o4dS8zSDM3cE9QRXFJeXVETU1CNENLN1ZuVVgwak9YYmVSQy9aMmltaU12?=
 =?utf-8?B?Y0F5RTlQMk5KQkVnd1NoT2xMWlVMY3VBZnNIMnh0ckhtSGhCSXZHUFdsV3M2?=
 =?utf-8?B?NTFrNldZbFRjNTR4YzhveGNqamNIMFJKcm05K3JOK3diYjJPWlJ1WnVIMmUv?=
 =?utf-8?B?VTBmTGtpRHVrMUFHQi9neW9tMWRDeU8rQjJlTnhvV29PSW14Rm5qcXpIVVY4?=
 =?utf-8?B?YjVxSHdFd3RBMmdydjlmUUhVWmc4RHZiM0VTOU5vQ0hBbjFNZGs0YkNIelpk?=
 =?utf-8?B?dG9VSEFVMWp4TFY0dkhhTE01Q3luRjJQZlovM2kxMGJyaXROQmpyWGF1OFNO?=
 =?utf-8?B?bi9IOUF4SlY3UGNKUGVheWcrM1A1QXM0ckYxVmg5dWl6N0tGMi8zUzdWK25E?=
 =?utf-8?B?SzhxUjBPbnFYRTZCb1dxTzEzQW9TQ3VQcXdibXp1QkplckZCcEcxZVhwWFJq?=
 =?utf-8?B?aHBMVzdlM3h2aks2WjJvWWp1ZEtFN2wwR1BXejBFNnlhSVF2MkJqakwxaHdT?=
 =?utf-8?B?N2JuaDhuQ0R0WEF6VE5pR3dnMDFOOWRRK0FNdnBIR1c4d3F3MTNFUGljc2hm?=
 =?utf-8?B?SGNyT2VGTmlJY2k0amNudWxnUFlBLzczZlVUTUNtSkJsQldxajFiUDF6bmZX?=
 =?utf-8?B?aUt3RVZ6bklaczJUUytlWlFySzh6TEZhR3dCUU51SDlHMDZNdnNLbVdqN0ZI?=
 =?utf-8?B?cXZkdDVCb3VvMlgwWjlqRmM5S1doN2R5MkZKVkx6ZW5nM0xPSGZkb1JEMVE4?=
 =?utf-8?B?dzNuSlR6TVhpQTBkZjBCMDk2bzJOSmJkM0c4RjFUeVdTNlM3MzVRSzFjMjF3?=
 =?utf-8?B?S2F0eGMxZU1iLzZmN3ZIdUU0L1lZRVY4OHA0Z2E5Y1BiRE5peUhTZmJlOHh1?=
 =?utf-8?B?QmJWV3RON3pXNmd0clhpcmlrSXN6aVlhaExhMzl6alNBYjNOT1EzeDY1Wi9H?=
 =?utf-8?B?amV1dDl5ZlJjcXVmZUNaZ2puWWIwWnlDWk9YaTVMUERVdm1kRGRhTWh5anY1?=
 =?utf-8?B?N2tHL1E0elh3STBaeWZPdTUvOWgyZjM0ZWFqc1EzUGNzeUNuMDNzazFMQmJJ?=
 =?utf-8?B?bzBhbnFEZm1lYjBwNjZLK0d4STc5S2I5T2VEeEpIbWVabFRteHlobXplbWJU?=
 =?utf-8?B?K0FQMmc4MHF6YXlaR3ZCblFlZmo2akpScnlIMTZRUm9valpxckhBVk5WUWVy?=
 =?utf-8?B?cVYzVkt1WlozRkRTWUpBcm1oRVFGUmw0WTJhck1KY3hTeUdjMlhTQU1YVU92?=
 =?utf-8?B?Y2FYYk9qdmp1ZG9kSlhLVXFxUjljQWNHbXJDNk9NTlpFL1JSZHFHRDVYS01X?=
 =?utf-8?B?VWdsamd0aWRkYnhUZnNQMG9MUzBLb3NjbjFGMXlaWDd1Ym42Rnd1Mm5hKzQy?=
 =?utf-8?B?NVl6Z2Z1aGhvRFp1aVJLQWtLNUlvNzJkemZNRFp4RERHRHVrUnhDWFp5OFBN?=
 =?utf-8?Q?ayLzEg8Yp/emrdl5ODMxSQl51IK8hkLxGinGIx0W1WHLI?=
X-MS-Exchange-AntiSpam-MessageData-1: 3aRGdLdKYSDOFTaqq73lXjCGYaNl1MuijKI=
X-Exchange-RoutingPolicyChecked:
	xZGICTVBX8R+ZS3/cYeuBmerSobcTOcB2i7NQQggfFb9lSqPQ5g0a5PpiSJDvk0w0XrhKG/xu+ySGDTXeF4MWOx/Agn7IuenjFl9ugyMbvbujKyJ80TsvXf9E2QoFKIij5rpXX8Hd9HdZuQqcVytUu/b844KpGpoaKprOTnt1cVdjtpNhaYxCUvlNtXwbk7hHHOK3ma4s386tlRMNfkqwMYsB1l4nbzUiS1cMhHG/EREDh5B23RTsR2j46fwXv8f1yqF/2xevb7KuMTf2oBQNlJtNboEMLE/byHetDV8BtEIE5NGrJCuh7/M/HBsP3rWbbPA3vZYzjptxoV9B19qmA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	01cP5Zslbi2CCnXnB8wMxbT7TzchxnkYbcmGVvWT7Wb76Vc93UvgdoIxdxEpW09wHvWfiJy/ZcEPqtSUiARsMNHj2fo8GlV1saSDAcNtW9MU5+ep8B9KNCKKNDBnZtaOFTaEJQ91kJNY+zFB6OM6ScjJvH87L6ivlZPuO3zAX9jaIfue9iuV06h82sJdg+ClwZ0K37BcFu8jds8rABG4uJi7kYRMbWNzkBqPKuvlX3DmRjFjNvH4G5J1Ruzq1yPApCygMsjFECz7axqG6UsIawiaKE7KKjQ+J4xPFuOdLd5BnLbVJBTGdYrNOOQqJtVzW+ao+JFSxuyJ7lwTJjHp7qmMcgEazCxHl+7eceaFwK8Y1qSn6qBGJZJqrGNBdlThSsbyivsEClAzrTYMi0yi3bp+Tvf9Fdq9q6XoLlsbl8YXnAalFbJLasUQstA55N5Fz+LXnkDI8x/SwagcxaE8RfOFacdTwLMztG2vhxhFPUIUwPo297SIt0JeFWte+CZFCa9E96LRCq71nJItuOq1EI1QF8J4iGyP0UiCwAPIUpZL/SCMdGFr34k0BDNIP8zFHUwfC6K71NaaW2AhbbVjxLmLZViEXU4SpZqwgIGiNzkCxYKdF37+PdxmSRf+KQgi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9edd18-631e-442f-1a07-08df2df496e3
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:21:03.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFt7jv+urlK3y4l/KRWSEsxYMUuMSOi9FF1rfHSB1OvGvv4BBD0qzI0vmxdlvroFMb/vZgBlxmk7pukVxYiXAlN7V6ztC0ukKILYODAqh2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9400

On 19.10.26 17:19, Damien Le Moal wrote:
> On 2026/10/19 17:09, Johannes Thumshirn wrote:
>> When testing zoned filesystems that span multiple zloop drives it can be
>> difficult to figure out which devices access caused an error.
>>
>> Prefix the error messages where we have the disk available with the disk
>> name.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> A single Reviewed-by tag is enough :)
Ah crap the joy of copy paste. Jens can you fix it up or should I resend?

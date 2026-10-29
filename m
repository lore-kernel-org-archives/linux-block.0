Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257808;
	b=es0sRka6pi3ry5e9EfWyNcAa0rMV1Q9dEGki7eyeMhFBrdBzOPNOWOv0pKq809LJZIi1
	 w1/78wXdFNiScZlwacdRQ0UlQX2AfmhyB8PSWhytnSlaF7ZoRTDZ80p1P6uvNMsLUC63A
	 M1kQfIuCjp0nvvb21Ofczvhki3KhYv7Zvh8ZrJqoIGQkt3qmoiuMoBjD+T+2NUsh90G4m
	 whJkSGwqN+z5ck7E7VFHpNQAcn1gRDdUwGfTM0FbChyNEIXTfTr7YLs1D4tUhTFWkqTGG
	 Mz/ciMfrLT77ixXSOy9HLVjMWi2LsZu7N/TUCETlnePIf383zisVo7URLinVmwAbt1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257808;
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
	bh=jDB3DnhhwwVEJi9euJCHVYrNABR5B7gC+icKxd63kIQ=;
	b=vJa/lG309NFX4NzLrGTMR424LzLsURkIpQv35aOg0zVnHn9Ro4Imlssv2FS3OZ6HFQA0
	 cu5jqdNS1+nBcLlXfpCKWHO/HFMp9eqeniROM+tkOzJXFmEv18yc8vli6HK0p0XrRDFlL
	 PFhkrzJSlttMFx8u2Zclky2eIwgUXppu2NrOtUXO8kZA3mibmq9TjSqrk7Sz/QkPcDtIz
	 Sc6A/MDrOoQcIu1ZjwNduGLBHVaLmEkeV2w9VTG/xWvrFH6axlZeH+85AxChit1lMwLB9
	 VAzWaR+5clpM1c24yTPcRl3X4mMKo0YAl0QAu8wi5EpvHUh0CGrvejht3wR5/mr7xNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YjnmVWWm;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=O03Kc5E5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CD606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YjnmVWWm;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=O03Kc5E5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793257808; x=1824793808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QesE83HWNgtGcSNhDLa/cEzKssAwkweg9bZ4sx+QNPQ=;
  b=YjnmVWWmWPl8tyIKzpTIMrqY7RcWwhP4SlLEg5r/6hmVfW+CpkkaLwcE
   BWbdmsAE8pMoeIfUAXbL1jHXAwUY09JY5cCv22vYjPQJyFxWbnQ/ZwKKF
   5sFZGzsLPgAFP2DEMDFGchJFxg3lDdig8Bu4NEglLMenHISlxIIT4Jnfk
   qhIWx8klojyLOdMbDZpOLnfq0xZdnaL8oathkqgIxfQ3s3ANRFrYSnOkh
   OcHdtbpPaoQaM9kPbk4jVXWYikGyGPQqj3RGSpj0MUxFrxdxhS97S787r
   1LCwoULNVEqt90TF49/HpwEwaKCdlQ4rsFZCIczHtbuN1+FXfwnxh82Nz
   A==;
X-CSE-ConnectionGUID: zLV6g4YNSa2f5/swSnMOEA==
X-CSE-MsgGUID: HTIEBw2USGCxvzJXnG0BFg==
X-IronPort-AV: E=Sophos;i="6.27,184,1786982400"; 
   d="scan'208";a="157670621"
Received: from mail-westus3azon11011063.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2026 15:10:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHMasZlWyXpnvG+Usnfh6uEjRaEITPFkVe/3ecKlOdftgNfpweORRhb3V6+58N0NZEneVSWvpi2SPhBRqVFjo/gBDEIVo5L9OnxQomkmry+BiCPog2H7KBe5f0KikZpG74g1oytJMnNX1xPa/fcHVWmTLpayV48zYnexnm2D4i2KIJAYISVBBK843YDOEzMj4gWSTj554RUF/W8fq63LLlNzu0PlDAg6dNASXbdcFONzw5vdT/bH3Vwt4tvh8eHn8t7sQOhUkI22QVS5LioJVtO8f6BHtUIwzn9VGXk51XO8zWWTfi9spNWZQm16Up/gbFV1iLnxJHBvsoNRg4XhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDB3DnhhwwVEJi9euJCHVYrNABR5B7gC+icKxd63kIQ=;
 b=ntyhKN2KAIYIWkCowbJnRZaVu8K5jAxB6eKMVIzq2qKD2J5fqqth9uB/ZShkWslTd9lJFP1V9KJsK8XPDDr0ZkF/2LuRXVYMxfJAO5XcdyXGHMVosPkjKabPSulgSO74sO5LN+6bbwXCJtb0EjIQ2sNw3/PvCjZGfJQMCCN3fdESIN4YKBPtt1Citr/rLrRqPHfr6HvdjNC3ktb5Hn60IyAj35E0pkPc0DRj8WSIMS99hnp2bCfOIozWHtQT9DM0D6gHvb4yw+fyIL8pwVwiu3vTuQybAZ4bqHhUvTb9RZUnyr72p88Bt8RAj2/SaVEpcuxaPXXQq/bKZurf+XM4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDB3DnhhwwVEJi9euJCHVYrNABR5B7gC+icKxd63kIQ=;
 b=O03Kc5E588jtbKQ27SUT0of4QYhPu83eeUREAEoIH/SFgko1ZBDZpwg9gnUDeX9wx7UfgopBm4jEqQLP75hoUcgsKaDlcSN1CCXPK4lDKbk0IJMQrMGBw/Vm4+mUvT9ZpgqAPQ24JtJjXCA5/LXiqWddTyRIM2G+TZKudLSiQx8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL3PR04MB8153.namprd04.prod.outlook.com (2603:10b6:208:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 07:10:04 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 07:09:25 +0000
Message-ID: <0764f46d-a360-47ee-ad7f-ac861d3dc229@wdc.com>
Date: Thu, 29 Oct 2026 08:09:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/98] zloop: refuse zone files without read/write_iter
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-16-axboe@kernel.dk>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20261028164415.1262013-16-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To SA6PR04MB9447.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BL3PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: f83f41f8-91cb-4ee6-5a35-08df358b9053
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|10070799003|18002099003|22082099003|56012099006|4143699003|11063799006|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	6dBO8uXMw4Ks2dr0ZgqrkV48TBKvblFnC6lzVxeh2+64uggpMpNQZSpRRAqhk/Udp5xBDElmwPOJlrUvraAKKFO6DGysNYql/S9ADjCbkJOhKY95xCShfolFJCBgF8RYzMEWDkHIOJBH0jc1WLybLnCGNx1XKhJhoaj9j3tT15a32LRmJL3WioXg7KKkLu3wv3b6b8g62NjJDUSRU5iksOLtQl8YsCQt6Wj75IWcLfA516svdNosFcPibvFTQ3dNVvKVrfwlTmnQrFiLU2SFUyVGFmXeYMf/V9KlasyYFp9tku9QMdmhKDbD79nWXyweYqKJSSbvI6HOL6rAK88HjYUTcPYS26q22szYwt8+s11lPHnwzjdOJAMblvrKSuv+CGz9SyrEiZT9q7v/L+YpYN4XXL9FpdoTdGFRKwNp4SQvnHhNRrZrAHnMV1hFh/vFz0uSNghiIRMqRI94vfYruO++1Rinx1tybQ06Q0bXvA6lAjGE0GAERtNSMo66kl52QqVQkj5YOqjFKdqyn5Au4JzeHvh/BF4XK5Z/dV+K3Y/z+Qfq8YBJHlYjq1cQAxP8eN4w3ZHLfNLABYvbtJNalvFWHkzoKxebdUj/uc0bd+zmM1HFE+wu6yjDlrfhDuSpSH93heZ6K5KiBvXtQVlNScFpBfr14azUXkvNPJYy+VM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktFdWtsWjRzRi9WRk90RStSNWJXVldqemJ5R3UyQXlZSGdCaGxCLzVnTFpa?=
 =?utf-8?B?YVRyWWpZbnBTUm85QVV1RXpwZlc2N1JMdm96TUJtRHlQZm1IZzQxcklHcU5s?=
 =?utf-8?B?cGE0ck90OXA1L2M1S1FTeEpPWGMrNStWYUNoczIzaUhFSEVoNFBGTnBiRFgr?=
 =?utf-8?B?LzdDa1JXZ09VclZ2OXByT0dnQWUyc2tGcVFQMVgxV3ZtMzBaRStlTkRzNkkr?=
 =?utf-8?B?Q2hFWWUya1p4anBaOU54bWd0N3p0c2E1OFZVWVJ0aTFHYjd1SHVtVTZCNEhw?=
 =?utf-8?B?UXdUQ3hUQUQ1dElxOTJvektrQUZsdFVJcG9NT3Y4NWpPcXl3eHhxeXNuaHBm?=
 =?utf-8?B?Rzg4eFFMOTl3dUtiUXVGQkcrckpDdG1Ndy8rOHkxbzFwaUJOMi9JNzRsM1NF?=
 =?utf-8?B?cWNhbnlNWXMyeGljclpwbFc5V3F0Tm9VcytTSTJ3anhFOGIxRnEzNlhrN29U?=
 =?utf-8?B?WGJLL3c3Y0Q0NDZ2ZGxZZXBkYi91cU9YdDRxcHRrZllnVVNZWkhyenIwNEMv?=
 =?utf-8?B?MHYwNDJaRVRSVWlIM1JOcHVsKzh1UmNtOVlHMkNrM1JocXdldk1xc3BEV0xZ?=
 =?utf-8?B?VncvK0F5WGRZQkxYOUpvU1JVMGdzdDMzb3NtdGJmK2dBVUVrMTUyUytrYWtW?=
 =?utf-8?B?QjhFTVAraTY3YlVHWUFWakJuOFFIeTRDYUNvSDBBbXUyaHV1cWpoRXlHYjhJ?=
 =?utf-8?B?L0s3ektwQ2ZyYnFOQTN3RHBnb3laSlM4SWtEc2lRNzJ6NDNwVUpOSUtzYlRj?=
 =?utf-8?B?bDRNdnFQc1NtbmdsR2lta05HczBHYUEyM0FMenE1cG9LZm9seFhaMnNuQXo4?=
 =?utf-8?B?WngxSnlNbitnMVRtQkhsMUhleWFtMTNSQnlIRnluOTBHVFE3UEQ0T1IxbGNG?=
 =?utf-8?B?SFpUVldkK1Ivb1VSVHlYVnNJZXoxYUZpaWw0ZTJOUVZCM25WSzM4MSswUTQ3?=
 =?utf-8?B?QUgyM0xGSnJRR0JpdTdqNXFuYVdKZXI5V2Z6M3ZSOS9tSGpOVDJMYjlKbWNT?=
 =?utf-8?B?MjVReENOV0taZEcwT0hOSFRRYWNaN2YwQmNyVlEvalNielkvNC9iUjdFU05S?=
 =?utf-8?B?VVVOTXBIMXBKZ1hjVlU1amhDOU1NTTNaNE5OUERnc1hLbHVHYmkyV3lwQW5X?=
 =?utf-8?B?dUk5ZHJ4Tm8zNU5WQjNxM0FzNmcxS3FZSVNadWNZeXNoN0RLV0RnUUJZRDJS?=
 =?utf-8?B?VHlrbzErWGVYakVZMUlPdkNxVG94QUJvQmJCdHR1SUY4dDJ4TDB5Qmp4Z2hE?=
 =?utf-8?B?MzRxc21McW1uWTl4Q3lrK3NSemhnbFNUQktYWk9lVEdid2Nsamo4YlZ1M3VT?=
 =?utf-8?B?MUhlSWZuaGlwbnFlbDRnVDdBQ0FaV2Q4cTdMR3BJbDNoVVp3dUFqbVJ3MmRL?=
 =?utf-8?B?WDArTHdkeUc5QXBHTEtIR2VnU1FsTlBoeUVrZk9oaWVvWlFyOXRJemVyNVpV?=
 =?utf-8?B?R0ZBZ1c4MjRqWmlWWTViN0dRM3ErV3pRTE8vSzg1SnVhZnlsQlZwb29BaVQx?=
 =?utf-8?B?VDB2aUR5aHI5K2hSc05Sd25EeEFqUEVsVVNFV2JjbUtNT04vem12eHpnbFdw?=
 =?utf-8?B?T2tlREhhbUk4d0dDRU40UVBXUTBEUEFQMzdSQzBNQ1hFZUxzUFAxcE5xUVFl?=
 =?utf-8?B?MmhycldqUGpURkFDU0NwUnlVR0l4OUNBakhBbXNVMG9rVFpVT1FZaE9ZUU9n?=
 =?utf-8?B?ZWJYRlMydzRXQjZxdEZOKzFjcEk0S0JaSVVScmxvNkZrL1VUS0hFUitSMWVk?=
 =?utf-8?B?elF4dHNJOHNkUzVjdWpDaDZkTzVRUC9jRkpDcGpLTVdibWxXZTc4aDFEQ2lX?=
 =?utf-8?B?R2xGbXB1Nlp0T200SFNnTVJlU0dsbmtYQjNCUmh6akRadEJYaXpKZWI4TlFp?=
 =?utf-8?B?S3B0Tkc5c0Iwb1AzYnJRV3VFVmlzYjJnRDBlMWcrZFN1YSt2ZExNL1VXZ1VG?=
 =?utf-8?B?RGhpbTlORmdvU2hIOXZXZU9zQ2VKSU9kc3ZNMUpBQ2VyVkNOQ05aR0pwdTdN?=
 =?utf-8?B?bHVJZW1PdWJET1oyOVduL01PVE1JNUVFQ0JOUDNSM0xkd0VuM3BWclVweFN3?=
 =?utf-8?B?KzRGdGQ0c1RSME85RjM4SlVwRTkrdndwUXF4MDhOL2FELys0bEpWenMrNWFm?=
 =?utf-8?B?VFdDa21LbmRPdjF6U21rN1JnWncwdTFMNTAzWGNLRVZzTHo5eUFOR2lwVmp3?=
 =?utf-8?B?VFQrcHUvOWtsVGV1VlE3WWxZN3lmUHBBeDVqU1BFWmNqM3JOL0hsK1VCbXJR?=
 =?utf-8?B?cExOOVF2RUdHcEh6ZDhGV1Y3Q2t3NTJ3Qy9lOVV0Q0xKM1FabnV0OFJVOEdS?=
 =?utf-8?B?aTVoZEhQd2s1RnU1NWFqdjBrYlpaVnUzenBrcEhmcFRwVVlWd2FsUjkwaGRF?=
 =?utf-8?Q?SnVLhrWrK8OJegMuJAD4OSmmWqyjEK0JhamdjKhDywISA?=
X-MS-Exchange-AntiSpam-MessageData-1: JPxC6RTynbUOjIYjhS9LUhlixMM+Yh5dAG0=
X-Exchange-RoutingPolicyChecked:
	1KxtQ2WtnSPITismg2HW9+oIjkanOpMgCrAMIB2tjfcfi0BraVmsG7/0zY79ESDhfJgrSWmMJuVvQPfHw4x0YHu5pp86qOzlHfOaBQF3zbik5lzHWfBJCYynlPOMFeWdmZs4OOj4G8SiImuQZLYAUEW+8lKOvRjR3nVDfEW2hQ2s7AEGsQg6nDDSvkkz9ELf1fSljzN7jYSqFDutdjupgTXB35KWcGpgnUegrwh+TNflaba0oIMkyvetIqTx0NVgD8KGYO6CTYKRYoSfa9bVPbwolUkXGdjkHLNjQNFHh/3188LJ6NJZPapjQnq2D4SPI2Fbu5qp5DYryo9Rh2DS2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kN5xZ71tOaa2I8yQY6NUTsIuOwRCyT3cqTNH5T3IdzVZwz/+HrU7Zpr7Oqy27qtQuO5n8nPjtfSR7Nh8gAcEEvLaXIw8rnSlK+qNJwlaov0bAzcia161Xm6IIQBxC02iPV0sq1dFX0mOi/bXZHr0DGUQR0NPKtsUgcgM+snOebuOG6Q6M1PJkA2nS4p69W2c6vYLL6b36mI37Vi/7axtdI+s98zP3H9NLazPa6xgP1elakjuHWM58SC5DMqi0ntqzfDju2LaHlEEI4eQVtuZTi+W3P9B1CKmR/PaY9zMog3Ll9C1coNRI5V5OiO5Ik1jPMZrKOMGqwY1FYiWn++EoSYAaOEboGm/9sbrm3Uri/57yAZrWMu/CS1kZ2Ev3K77kAhcObPToftOBi4t99yLrxE8ArHJXVvInb++7zlUjUKDU5PL50jDbv7EKStwqIg3XhE2OLtbSCcdlL2MmQzRYhQtvLBEmK7VkcSo4etU2we3OMQUk1yJLYK40kN0CRCZn2fs5kkVdfm4Dd/2n3cJf3aW1NwEITlDGs8JtVY8re6AXNVZVc/BoPD5tV4rSvzxUAiDn1m5pOtW+oov3CpS1XcYJmZYYuN3TwvbjJcq/SVYh8J6Ly8/2jayJ+VMbj7p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83f41f8-91cb-4ee6-5a35-08df358b9053
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:09:25.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8VgxCmC27q33zXDYE7h6qvwF9D950779zwT2MztSGeSTnOQemDnrIY8A+SlY1D6M8hT665zpTEEHWWMNxSSMtrN5w0Hl7zHxKQofsVcx/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8153

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> zloop_do_rw() calls ->read_iter() and ->write_iter() on the zone files
> without checking that they exist. A base_dir on hugetlbfs, or zone files
> that are links into procfs, create a device just fine and the first IO
> jumps to NULL. Check for both when a zone file is opened, like loop does
> for its backing file.

Not particularly against the patch, but I don't think you can have a zloop

zone file be a link into procfs. Well you can if you create the zloop, 
tear it

down again, then rm a zone file and re-create it as a link into proc. So 
I guess:

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/block/zloop.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 9145e0f98d56..b4076940ae7f 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1056,6 +1056,16 @@ static struct file *zloop_filp_open_fmt(int oflags, umode_t mode,
>   		return ERR_PTR(-ENOMEM);
>   	file = filp_open(p, oflags, mode);
>   	kfree(p);
> +	if (IS_ERR(file))
> +		return file;
> +
> +	/* Zone files are accessed with ->read_iter() and ->write_iter(). */
> +	if ((oflags & O_ACCMODE) == O_RDWR &&

I think you can drop the O_RDWR check, the zone files are always opened 
O_RDWR,

only zloop_dev_exists() passes O_RDONLY to zloop_filp_open_fmt() but 
that is just to

check if the files exist and they're fput() right after it.


> +	    (!file->f_op->read_iter || !file->f_op->write_iter)) {
> +		fput(file);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	return file;
>   }
>   



Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393231;
	b=2wBQTTBOwzm6q4eg6vP/plrL+m3Pc9hfhipCHVex+FQymyVO2C1+asmEPaDIuH/SOyGl
	 f/hiqAiVqeVgH8GgvRyoXBQVkSy1FSZHGim0KqZjS9EZQFMr/huiBMqRxiKuuHO5SB0AC
	 bfwwL+wTMZfwPI4TPuGoSaH6nWIZ5/lpTF7oXVLOpIwdXiP55WvgntqAkCKVksWgATsBy
	 cfFk/1sHMa79z1xqfe4fdoTjPHAJiw/fuAS38jhUmfWyI4CeOOvrgZBdbad2uw719UCd7
	 zh2qlWBV/RNh5BL78IHaCYNRb2KW7H6QDDRHaKCOCgmM1Ul/dZIyhkpC/BPNfFDgFaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=;
	b=hT17qz84Fnr2tvrlHLll0OXRwr7x8/7kMtL1jTmd2r1KAATN/FW0o7aPO04ATzGlSRxu
	 w3s10djPdt7CpTXzJMzk9lTk868X6k9sVaA7oBJlmvSPdUbH2Y+yPDoT0/hKnP4pNpFQh
	 Ug5rI45XLHwjymeM1+vTulwQWVj00lawdmWW540VJnAFRlRms+uWGF9s2GGZj7VesGVxG
	 97+1K8pJbdNaZ9/zlRnCnlkyaaA7EXR2FviCH9chMVWQjGyhW/clJEk72VyvdCPP+xRvq
	 grJqUpWEYjWwK4JGdd2fko6rtOGM6T5mDvhYFrJe1/bWReMf9kuW6AmMSxXnRn8x7cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=eMzEzRj+;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="dscKJk/G";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE4606A326
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 10:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3CE4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=eMzEzRj+;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dscKJk/G
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794393230; x=1825929230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lcGUmSJdUk/oR/q1txC7cWLqeqZSy8AGOlD87NHJb98=;
  b=eMzEzRj+s/KYuCjPuWTaUmGREIDietF4w2xSy3Sj223/n9LIFTxbqjZ4
   FW+cSqNyKTEvR8+eXw1FA7GEeJArxSQ/SiCHXAmkw4VRrm6Osx1rQmyTz
   A8mP0KHzyeHE+pEVI5NLxucFNUasjBWvyZOBOO6f0g98AFNhrHoepx8ME
   pfyQdIbzt7qYomh54dF3UiY+gHBXmebZaG2DMcB4Zl7033ZI1eekdh1hg
   ulx2frOvcaljGgGyDMVAdyaUD8rIloS1AGkiUkuyOHM43Y3/HcjkuiekI
   2zpkqNwzsJQUK233eZwaltfxXim1ptf8t++GzSZEiSsjKDE8RNAPQwKi6
   w==;
X-CSE-ConnectionGUID: lLgjS/OOTtWJo+hrmqisaQ==
X-CSE-MsgGUID: Tl+50SlKTRSXo0OIewSM1g==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="159663173"
Received: from mail-southcentralusazon11011062.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 18:33:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVongUiRPFoTPKPsgV6YyTYNyvh27c7WmzMBMsOwdFHN5zDn2TS892Q5FuCqj0+RwXcgQTkm4LM4xKdvp/AKfkPjh7PkhtGVPNHMuQ//hIumBK0Ss7RjgyWd733FuANTXdLTvA2fky/WCNj22hJ6JW28iMsN/Hi11AEPmUEBppGr8m9cpCst/JdyzFcPL8Vqy4Pd4fMVYl1rbqTpwNYbepDSPAovYVLm6fSPywpyOht0EosJVpjs0BaerM8gVxfpARqHWU3LQZjJB/fzuzXLPVP9KgdCAz32LA0khgHp8eCsWmZJxN7ozpyB4cR7pMrH+yL7T+Xqvae3GSdCQ/jf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=;
 b=Hc/7D5nCtvY2kygMjUAaMXpyANcoUSaO9gk2N/Y9Vxoc6ii34/2LxmhkzG2JScNBEn2b2eZk9ISL66sPap+sblmfPoQpD1YSvWRiVAYFfi1yUgKdSTsP1xuZa7UThRBwyBZ/ufsThfQ5048Dm0ULAchA61ghmcbA+4fJ/KVee8bT/DpzNGy4Im6BJsLSTN57KzktlJezVVf8qSRXweLM2g5WwtRVfSdLUNTvskCLyWMWURUZrkFG/ps+dOileJZJ2O3H5L0V+GZ/RJBU6qvDrUSW8qHb17S/EyQCbbfcUyL9TfSvAEY54RRa6oofqoEJiqgSxEVUtqibPUH7ifhRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reJWFZl57s+l/nohwuJ7UicZz+C+pzhcjFCSFHmjJeM=;
 b=dscKJk/GlGHvckktVxXV9Kd2uAtdIb9nAby+4HSBBQ1GwxB32xmTY9QvS4+mCt+fRa+odbA7eff97XeAbsxFxhAog2rpelgeMPYeMnKZ/p2W4iYNEMDCZAx/IfUpiou+hPEMa4794xAQy707LLujnplojcYcEeS1gL47hhaOXAw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7517.namprd04.prod.outlook.com
 (2603:10b6:a03:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:33:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:33:41 +0000
Date: Wed, 11 Nov 2026 19:33:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 09/10] nvme: skip the tests which need a feature
 the remote target lacks
Message-ID: <avRD23enUQ1UfQpj@shinmob>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9584b63a-1d41-4e0d-b748-08df3fdf4103
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/ugJu//CuV/nhroLTC9CaAfcVhKc1BSsbhFDD8yZQOK/y/LM/Xbo9DD6pkeBIbHNNda4k7wkNONEO7bzyJi9/EUUXSclmFQqchzyvh/f0Rg/a1BpdzK2e0avQ6gV49GhPJR6NAvgd1wylhmnORrHyCFMdBjqiatfTv1h04d/yoBYwTl1UMJxMxaZo2Oh14ebIpdmtauYPzRqlOK++sWoxmfRvQav4j74fEnZwa9mJK/iwoplTp5BJ57h1SiorCKje3TMfqzxo24bFpzP39h2hO2LRR2wWm6ecUaRhGHD2KhKjLep3dmxD9RHGb3WaBmmnn/dlxjGjQMXaR1SuV86XUQdr7aH2gl/61Ak9rOqI8KovcTseLvspD86HYwfxPGIVYFAa+gboHbw2EBdzQGMd4KwLYLOQJVSWiiQcAqnFywdnBYFj7K+STnxH8lHNyM25use74oO8O7kzx1PnFXyIIe694P2dHIXlOKPVsoMjp8d9ucHVcvDw3pdbuu8bnKtSHBESwF+3pB1HtSBrqaV0s9g36GvSeRIuh5jbrJ1KhKZcZCz96OLDKVPpBuLVKiPGPa/BznJq6a8L5rKnQA2L5E/avA5+R7we3w09Vwwgh4fzbbDFmwDjojwNVeVIQSBYYI/HMuz3mxUTciySdyosKCgxhCfTrW69PCPziFc3WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooT6hIsHnrW8a6yFnqgkihyY5pdom2fwVPfarudQWjQpWBb+SGQ3XwB9AwYl?=
 =?us-ascii?Q?M+0oEzDD7dlTP2uNDbpTEwNtFbSWTO1GPl7iRvxK2mJi4Ye0rItPdFp0Z8UM?=
 =?us-ascii?Q?+VC9ntKqmtgC+d0zGVZl4zMFMy//9a1cE3xS+05Hu4KwbNUnCrmXbOFJtFnJ?=
 =?us-ascii?Q?4bN0Qj/nxK6PQxekW2xJBQEQxQZQi5jmgXxS8u3gxkcAIC7adCeYNpRJ1GDJ?=
 =?us-ascii?Q?aioXRbley5oeZMZeAwxxk08kp+elpAoSXaRwH9NqkYXf18i8CLUmXzq+hf34?=
 =?us-ascii?Q?HxQV6iiBgMjmefIXfXYSkHw20+s1+w8+q+17oNfL78WjzWuAnWXbqT+Rufc6?=
 =?us-ascii?Q?AeuTUURJsbuA7PI+vqxES0Oh7gqFYirvbhrZshhrcJ7cO6PMP6smf1YjVBzk?=
 =?us-ascii?Q?hPVAWkozX2B1/fhpXQJBlQ6rlAmz9wEY0XqxAIuT2c4+WuH7Gark9hTpY8Mu?=
 =?us-ascii?Q?HkrJyJOMd738/ZdloP7x1Wd0K6eKIgnLvNk5+ABVmoy0d7VyjuDH0ngIfl5l?=
 =?us-ascii?Q?mjBDTv5v443NAMGyhOHRlMB9IYFS4liZf5sG8CWlH179AAio3tphCl13UIe9?=
 =?us-ascii?Q?uV/ukZw6BTxFqYF7SS91ZRomndehKSJUGn4tmhOT6SpGOGj6DTocdwLo+RPY?=
 =?us-ascii?Q?N4PSvNY9MWSNnHXjBTQvU3lGecjR3cempd6Ih0fXg6Q1e+sUXQPW6V4rthJe?=
 =?us-ascii?Q?2lP68qXpBv145kOLYwrytwTvEhySwgR1MGOlHeZQ6W2i7Hu1x96Nq1VYcDpe?=
 =?us-ascii?Q?D99BmmCY59BJnOpoIsveq/wua1w9Avo2MiHkZS59lt5soAR0sUjusLBUAOib?=
 =?us-ascii?Q?btrZ4HVOXWfj+Z7uA6q920G29KhRc3+/kLk7bVXCLbnZUTsyEr0OfVU3R/Vr?=
 =?us-ascii?Q?l4sMRC1bvv7Fiiwqhg3ZqiFO5dW9h1QltJEDeJvPVUmfjX+y0hd7KrYM4BtB?=
 =?us-ascii?Q?tOGy0ehw5XMEIXvA3V1HmAiyTVee7G2WBOlj5qIv6AWN28VZCMYekLCnCCMa?=
 =?us-ascii?Q?uOkHiL71ud4O7CPycz60BAAwUsLBWfGvkMpSM3uadq7NZClfA2dX0Q1TN3PR?=
 =?us-ascii?Q?Ie4cPm/JqzI8y5C+7lJfuGIc173WLnxQCq3H/V8Z6Yizy3zVMK8BN/DhDtFL?=
 =?us-ascii?Q?CZfijP+AC8KEe0uOV8XbCbbBp01xEGxWxuuj1FA9w9GBRu5SpruQVS5K2/Zn?=
 =?us-ascii?Q?LP8jorGeT/C/KcUOXZyyM4HjRrdlJjRSwAAYuvtAqFUvrXpnLjMZhfAQfqJT?=
 =?us-ascii?Q?XRCz5UNsFoRNbeY2uDs6s3KmZPozT9KzhJAQt+JRQE25hM65+2TX8x9jn0vo?=
 =?us-ascii?Q?dA8vjBHB9Ds4JuL6HAX4f1y2mVYTz5FLMAAr3ZIaDaFiE3UUVGentoKL7CdY?=
 =?us-ascii?Q?xqF0qxWhxdQ002g/nALhF1tJfyK/0PyCFBPrY5R5kGFklYZLgqVa1Zb7z5pI?=
 =?us-ascii?Q?jfXWb6FJlRnvh9CHReDNICHGJ6uYQQX1D5aEXDCmJ8G6N/3dRFzN8EOj7Fj4?=
 =?us-ascii?Q?swg/l1R5rcnD61KxkYPBFOtIBhy4eYVPnea7b10eFBbY5nbg1MelaG3Zvr6C?=
 =?us-ascii?Q?W1ZkxkJFn5yHiIWykDnkXJzhaGRXnLWUFaZl1T43zOhaSqpfTeAIpQvnfOBG?=
 =?us-ascii?Q?8KsKjlScBuPWqc09n1Pw0NCu2HX06gzl+WMjV/d+GmawdTfqbC8nEtNcI+ou?=
 =?us-ascii?Q?lEvAcLPhGet7DZCB4KsMiNH16oYnr9WuihoQsiP/8XZGTmilXhZwA7CyNShy?=
 =?us-ascii?Q?rI7iJTdSHZnwc6eL4z+CuIYJfjj15Bc=3D?=
X-Exchange-RoutingPolicyChecked:
	XyyB2wbXRWxkBqWaAf7Na7wNu9Rwel1/5qfL9UYkyu7sqgTWBNS6aVD+x65FO1llZNNrgmcjIZM1OSDEv6E5vbL4kShhjxdabBR7xdgQUPxYG8+jVS1Yla4/HPna6K3gMbTtWG1ZbTY1jquC1pDB5LZTwrE2f1+Q1XHGZaA/WW7JtkNBpJQ1VW3BSNw6d6cZW43hKjc+2i9NGGjJOuLD/0mz3SokyenJF9kABIoSKERR2kSo+y9QuRADA1AiQO4iIGGv2MJZ5iDVB3KZ2KTPrlly/9pI6ugaWjeDdP6YW5CEmcndRAPOgIkLNJT5MCUCw0a5gIB3JWQtsRCB7gTuQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DzKtvJizHYgT09mvps7aKaH3GcAumnUjEKq+CzWotGTq5WyFlFuGD/wg7DnFH4RaPmeVh6fKkxZqUHuZdWr6/5/ne8j1Z4XVLAFokLjdNjDt5bXZFSganyh7VnbniFHoeaZa2QsYChGs8fB3nEDGYS0GPxBGYnHNxUKrtnX8Iug2kpk84mgT8/ul0pIUe+UbdQ+BpvMNWkDYU9VyWzC2TQtIR8EYhoRHzUtnId9TjL+RJwh0wGis1PksLfKPoQ/1hOK9TH1Hmy0f8KPAoUduoWsZIxgxssOa7/ZR7iSOhs+UmRRccU5NvM2W90pb4ciJFQ+C3Y1r2Gamjs0+5FS1aXQDz8HNMOUD09nyUdKN/ibIflLDw2c+uUmv3AKsPVLGmjnwtHrL5iaE7CrGoSFC7IOPeEn2IUCe1WvPG9qHFbFRN5xDJO2E03jmjCEXTP4KQet6Qmkwn7Lmnn5niqpvkeMoNY9pUmkuoEfNyewbUjaBQCIlXt7QnAyN4mLxYDjG9r4NqbjrnNuO8lJMnc1OPlszQK/74iyJxxc3hyHcc0bzSfkiKYr6Bev7jxcbRSD0q/IRO+COiokB5f0k3MJJ2dsTVGHUburDFlJ0WCL1YT4KD0AvJMBH097r0fIc198a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9584b63a-1d41-4e0d-b748-08df3fdf4103
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:33:41.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOUSvyfTrlbjbOI1k6sw/+Glsp3Y1ni2OXDNI3kPaEO7PkVRN6uLDaEa1Puuf5pIGQcyoOfJ7XfePCw3Y2XuIyn03OfdhhS1uzcxjNZ+Eus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7517

On Nov 04, 2026 / 17:44, Daniel Wagner wrote:
> An NVME_TARGET_CONTROL target need not implement the optional commands.
> A storage array, for example, has fixed ports, manages the ANA states
> itself and may not take host keys or a TLS key from blktests. The tests
> which use a missing command then fail, e.g. nvme/057 on set-ana.
> 
> Add _require_nvme_target_control_feature, which checks the features
> config --show-features lists. Use it in the tests which add and remove
> ports (nvme/031), set ANA states (nvme/057), change host keys (nvme/042
> to nvme/045, nvme/063) or set up TLS (nvme/062, nvme/063). No target
> lists tls yet: blktests doesn't pass the TLS key to the script.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
[...]
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 3c3ed680e416..6bdd4058586a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -155,6 +155,24 @@ _require_remote_nvme_target() {
>  	return 0
>  }
>  
> +# Skip the test if the NVME_TARGET_CONTROL target lacks one of the features,
> +# the optional commands and e.g. tls, see Documentation/running-tests.md.
> +_require_nvme_target_control_feature() {
> +	local features feature
> +
> +	if [[ -z "${nvme_target_control}" ]]; then
> +		return 0
> +	fi
> +	features=" $("${nvme_target_control}" config --show-features) "
> +	for feature in "$@"; do
> +		if [[ "${features}" != *" ${feature} "* ]]; then

The line above is a bit confusing for me. I guess the line can be simpler as
follows:

		if [[ "${features}" =~ " ${feature} " ]]; then

May I ask you to confirm it?

> +			SKIP_REASONS+=("NVME_TARGET_CONTROL target does not support ${feature}")
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
>  _test_dev_nvme_ctrl() {
>  	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
>  }
> 
> -- 
> 2.56.0
> 

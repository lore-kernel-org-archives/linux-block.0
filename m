Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086595;
	b=4ZCPSfdxZMpPrlKl/ddpTZ6bh+oODU5WllPaRcO7Fwulye1GCp8AHHgp75KEBjP/r1Gw
	 TmAMLoSvVgfiB8+t5+HzrgmKBsN2v3I9s0N1gNY05tDZOUGCGFmW2fJYowhGSpuIkKJL3
	 CFrs4J45BYHel1l9KIm3e303Xf8P1rVsEpmvcyXr10U/Y7n6yiHtHUYhzgR272Tlph9yk
	 5gT61KCFuvJ2KKZaSP+lD4PkHvB6/4laXbZUK5TyP/Dd/Yk/sjvs93p7bVg5WEkinPstA
	 fNNJphruBS0IGxj6vYU66h1IMiEPJYTvaLgSOvS4MsVBvukpOWXcfMm2Vv5Bf9j4zTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086595;
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
	bh=U9H52WF8elEVhTCddWadP3GkWr6cK4jCntvk9JHVeVQ=;
	b=Wno810SUbxvCuDTkUO0v50ZNkJTk6Y7HK2ah74WJewhdgbFz3qxoB8DNIpfGH+PvgD7m
	 ZKmSgsIDOGbNFJqzxq6gGgIB6llrPvJ5PEFARsLGrsCY9htmEljkASGFX5ZmYHmB6X7hC
	 YnHitw+twYJRu2aJ+3pR/P4kC4d0O8kLQAUzPrBOEH5oslIMQOjjEHowwZZdnSw6AbNYw
	 X+Rxce15NLPYpbOvCUDba7JZIqF9b5szFp4fXlBx9SZrye7TtQo7QjKz5KKnnGW+FbySk
	 lboMZwF9mRcwzeRVNqPZOglK/9AW0ghQ9alNH+8Hi+C0WpPJaeZmffmZVJl1WM4v/1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=hhMoMTOw;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=M5DhWV3n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1160A5BC7
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 07:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB1160A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=hhMoMTOw;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=M5DhWV3n
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793086594; x=1824622594;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QNBj34v/hjp07OVGNuY95vBBisEF8++xeM7HfwhNTH0=;
  b=hhMoMTOw/irSc0y4M/efgS3LjobGHxbS30sKjFmovN7qc26S2ZP3aPZj
   43KdExPLFLKyq6piCcWtvA/wqM+BFYRaJZoIhLYcd3pN7RUMWHa5sDgrx
   GK7T8d9a6w8cAZ3EQkoRKJJO7lQdF+DHjUJY/vEohu1zSzl8dqoympznj
   C2uIqw208EQ2Lyvh3bYsTfBokaZ1LQpDX/DgpcnwlVyMehTe81JJ0E1GN
   /EeBxRvS9Wih5rPUX+0dqP0YdImf5YHeuO43sXMZXOBK5jkLVOg5/gxug
   eTXWZtgO1u7UFFmPo1yg8TL9oAPuyGpQmqUbVLS598FDrpzbzdN+z8QZ2
   w==;
X-CSE-ConnectionGUID: rph9mNAPQxiHJiTBRzMXnw==
X-CSE-MsgGUID: cv0hv1G9R3ej0czm513FRw==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; 
   d="scan'208";a="158991019"
Received: from mail-westus3azon11010029.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 15:36:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFKGFp3XR8Jykfp0nqmw6Rye9sGUof1FK+F/GPKRhdDUMjukyF0FVjmEKvLg4ueuCBc0v2oe23bFAiBgwnJEJeJqz5N6gvisTkFM02fpE7oWUmBkxdeyvRDJkQuXlu8Rx1iFwww+h/0ULHzUL3+60Wk1r9h9xMrqk00tsaj1MKqVdLacim5LJ611H9YBVDq9Y3Qj0GTARnVdQhwW4GzzqsvUYNYRujJEnIKFuToW9xnDvW1mU5G7KBmapQMrFM+GqQIRf/tK8UE49vkzyLOtytsPuWl7qV5iSaHF1dRCThqqKca1WQbrtvgQ0UiR/V16FekqET9W5jEYAH1Q8+Y3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9H52WF8elEVhTCddWadP3GkWr6cK4jCntvk9JHVeVQ=;
 b=qgh4byu2T5zH+oqSxc4DDMVfHloS9mN4/5uDyb72iCwsWbQvw1sNOKwnZuaLy2IDHUciOIlUnv3rxJkMJicim4XWCar4pE8wXpH9voit+bjbr+GCMzuhjrccZ1P9OOL9o5+bPSrHCFMUvZMfQgTiG/mFPipzNl4iSxjZalRc/kcaHv3XSnr0MCRoWyaMJGXILOO9trF1W7qCWojLAzQ/kk3ak16pryFfCEva8oguZ6IUCkIMBR363WRRIm/HK3ozhXoKVxcaWci7rbpORPg+yeSTJ+70qEr1ue5c1j02nWvZfURP8QfIkM377+3jXmGfFM+RZNJ8RwKLygEeUBkv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9H52WF8elEVhTCddWadP3GkWr6cK4jCntvk9JHVeVQ=;
 b=M5DhWV3n3qmkdttZTAQNjmG6apT7QKExYkURTmV3lIYLeZYO9rUGpNrQGQY/YNTjGCRG46Nt/pP+CJJ9qV1oCS0rrqsUHe01D+R0g+4stYllN3ESh+f6VLBat2+rVtMLdGaoiexz5IAT31YBHqRyMTUXKYxQIvzSjDIbC5SdCBs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SAWPR04MB993677.namprd04.prod.outlook.com
 (2603:10b6:806:55d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:32 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:32 +0000
Date: Tue, 27 Oct 2026 16:36:26 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhenxian Ma <mzx199711@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de, 
	syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com, Tal Zussman <tz2294@columbia.edu>, 
	Julian Sun <sunjunchao@bytedance.com>, bvanassche@acm.org
Subject: Re: [PATCH v2] block: fix recursive i_rwsem locking in
 blkdev_write_iter()
Message-ID: <auBUXicd46xCKiL7@shinmob>
References: <20261021093332.17334-1-mzx199711@gmail.com>
 <20261022062513.77372-1-mzx199711@gmail.com>
 <5c7b9f30-893e-4127-8ffa-3d5b7224674f@acm.org>
 <CAAth02B6UyRLaU+eKmLNueeh1N5Ecu_+Tsz-GaXj=AWZ2bQkbA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAth02B6UyRLaU+eKmLNueeh1N5Ecu_+Tsz-GaXj=AWZ2bQkbA@mail.gmail.com>
X-ClientProxiedBy: TY4PR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:405:370::12) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SAWPR04MB993677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c318084-2a23-456c-e550-08df33fd0578
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|1800799024|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261009221227099003|10067099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	qYEqJ4pfHw56JpxkFa83MVnOLciiy7wGaX8OdnKsTgGYZLVZLEzY/XyMF115KFQmazGHZDUhwlqsNC9vzmcDCqwWlw0DNWySptkmHSvg5ZPD6kYAzmiSupJBTr73QiGJY4ucj7hnZJQWVh9cHFrHMEnn2sjinZQgj8emQVPd0/QAQx3o77QOLugjrhM/eTDvQRemcBMvFfUxsy8IqqSBKBb2Xt2Y2/60UKUMuM+PJ4+71Qdoh6fqkbv3Qy/qbFsSlLZ1faea3Z5EgGKOlMCE9dj5CZUdtuXhmg5Yp9ardEDAWyjlo2gy6TXQeyA1zJrP0WVAa8OymcJrlHozxPUMSA4XRA61712u6t2XfeaLaVoOzmpqvMlQVaILndiH0w9gj38o3lcmgwHvErEbACqQjLouq5xYuN7YUpwn4/6zTN2QgdwU1EGPqDzuX060sRlerVmcyYrSq0jSBJgIdoUaTGCNWFjoS8JWcPQudojkEANl3BVDkqbUYAE0qXJu+e8/JHwFkXuzQsHlV+r6QfAqq6aBJcF5oRio8ewy8x6M1QUpBg8cUkDMfmcUgJ7UNMHjlsbQ/i0gumv5gBglrRyzHqslEslI3cKThHw6eGM/4doSaNioArcb6gg1TvoxiV8E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/7bIGCgbbEYinuTnAubWQHylg385N7Sa5mTGzMy8MeLbDSGnVJOwrkhrxb2K?=
 =?us-ascii?Q?WqT35saWr75pC5ngt+lFrnF9gVPM9iPZaPPlNOvgEtd6vvB47jQivAPjTMmT?=
 =?us-ascii?Q?2s37k2BVoQQDtjYnYZfXdKYNGR47F9DfhfU6Hav3JYgTe//T7Lz2zwBhCttn?=
 =?us-ascii?Q?QRy4wmW6btIbS3gT+iKxagdw1/9WQA/FsE6xlRAOoDnX1Z9X8z4wIb6oIGKF?=
 =?us-ascii?Q?uDnpf9wrV6Bh6EMqneJmDCn/dBZpdZu88Hub8EsOIEZcrH4LxGnmgjMWZqjA?=
 =?us-ascii?Q?EyQ4xS6B1iOF5Fszw9eMnuXaZC1wFzZ7Pbn6tnbAkkmFeqxxrG0H6O5obRSB?=
 =?us-ascii?Q?43WiPEBmPOkr5cnQKnmckNPuxsYG5BsOcxe0Zr4zX1BbA2Uoc8R1njSWKfPH?=
 =?us-ascii?Q?ZwVurzNLvO4UtPJtqW+lg3VFhZC+kU1FYPrieckG6p3rKyttrwhhVVJJD80A?=
 =?us-ascii?Q?JzMq+e5oqYnSf7wPXEu2+fqjnM4fE71tIhFpr/VTaU4tUvZHgntnCalwa39O?=
 =?us-ascii?Q?b1hgwB3bTW/5cWclqhX4V8Qq/y1nGKVMW21cgdRGpfVOLNodAAJL4JNQy7/y?=
 =?us-ascii?Q?0DGT+P4U1I5X5DrsALy06r1iVFrR4iQ0QDjbkTpihWKsTxCkibOM2KtD3luN?=
 =?us-ascii?Q?rI/hX8quXX/JLpo5isvytCywEFakCP4UMf9ulSynXsC6QluIO2ZHXM5GfeWv?=
 =?us-ascii?Q?5HMMIO2nr9b7l2nW6fqR1U7sBp5z0WCmJm7BN1ESEq6mL+RGyx0JDBYKqQnk?=
 =?us-ascii?Q?oEPEJFQ8Pt++zcRMymEdZY4kGfUeGqKg6NEld8Zskvo3BtHlVxDNGV8t3Hpb?=
 =?us-ascii?Q?d8YJTabN1FRPyAqAuTVsMz/l2TgkmKiq28P6NrXi7YVpPOUCIxmpLfkvziQB?=
 =?us-ascii?Q?YvzYayMjU/vsafLUUZRLuBh+GaALR8UBH+lV4nSZLrm6m8PPiu8L/GEXCZpe?=
 =?us-ascii?Q?qP/vqIwO8DFs/GvTYVnDtPzmndF+DmOMmHeePJoGpZVWbTD3QH2iZEDneCu8?=
 =?us-ascii?Q?la/9pIj6Q+P0Thms5kMMlZ9foe8sQ2byPhPioOBHrx5CGkbKMld9gkt0OtlS?=
 =?us-ascii?Q?s6IOP0EOgWXlRR6D27gb/dxEaxRnHbCUB8tw/JHoWFHN47fWgEihOSIhVHLg?=
 =?us-ascii?Q?381eghpKpc7FcuAmg4IGnWPis8+eOJNolLIE7Bjx/HafGkMrD07Rq2xQWkFT?=
 =?us-ascii?Q?89LLqI5dvCa1m1EagTyTSLRAWyDPgXI8fzPP2rHy3jDj3romYHgmuwbCk62i?=
 =?us-ascii?Q?dWEPD5j6yblhvkDkRLpW3uz+D4+yMEsg/UQTt2Y626TdSX3mRNLhORksSpuG?=
 =?us-ascii?Q?pcD7A670agamR6J27qJEObefGb5d2Q2II0WwGwoaMxOx6HMiqF4PqcT74eNE?=
 =?us-ascii?Q?LUjZKH+4hzOfNVLoUXdRkHTUwjjBGHiv558wyJpNBYuAh6mLhSXhqY/+K4J2?=
 =?us-ascii?Q?cEAxS9Yetcnh7EjLiWeE1u+MlabZZQmIOKsfLIwe98qsOdLc3607Iczr4aCU?=
 =?us-ascii?Q?7nXH+2Cgy3P+bu/2hrNljhsi2jKOyvAjq4WR+dbzsOI1mcVM/MjIzT5V3C+P?=
 =?us-ascii?Q?Td1fmaMzhDB0/sTrFOOEK6Ro0uCdo4LEu9E30NQpoS7mJsYptuySHRLMvphq?=
 =?us-ascii?Q?XQhkd9nzZ9YyoHfnMDs1VGOKEGn0aB/A3qzitjnG9/AILk1EcZa5Bml4yAAh?=
 =?us-ascii?Q?pUQPCf30qegqhQ0FPP0Bc0aaoSGbq3ImkT1c9hUW3IU4nQpbS3R0kGlmPhyg?=
 =?us-ascii?Q?/oTIcH6gVlJ2IeOa40cbTSRbmp91RUA=3D?=
X-Exchange-RoutingPolicyChecked:
	cSr2u8E4QTm4oXyBSgYLGVjoLhwRTzOLee1XWEiCwwb79hTPFe1nmXF3MMwmsvF0f407bcxGgE/8PQ3WCpx1qt/ow64VCtU8oWXeKUtwhIZ7KOljI68rjIStybBjLRlEI1puW/92DjOoP0FfPQolEHTzHRm+Rrg4Eo8ovMEwORtlp/yMp/71T9mSVXEqDNBiXgyC+B67ZlQsWlEzOr/7+oT1HRjWKLCwEDyL9s/T6k4kaFP4s0+mxR7/wDYTEt2hz50c2OelCA9G2hUTovWIXgBpZ+38AaEmNRHc9K3bfPT30iWAZbcCXISvNSHrRxqB0lchkB/IqaYAnXPT/YUg8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IKm8eB0dYcgqQeQg2cxV7O2L5C9pazTAv0LktcsbJRyYsDIpcHhWYLmc/Q6Agi5T5/hMYI5po/nuR4b9EAZ/Ztpx+sCzMP7mA5SqMG7vf4F8YIXxUx12jsubzcDP0I81j/ynwwAoMAYsnQRTtWSKElYyoPtlmDeCf+mcBE326HSRW7hEyeiILnv8m5AVVU/NDS+OBn4zeHqvdYesiujsK2LAgLlZPdRwhPUc7IlXp2a6LWBaXN2KiBIljMczhx3b05W+aen/81gDF+6/m8OOh2F4mpPtRKVEaHuMmxE1SzFA4LUtL1YX8uJK45Ed6E6bXKW4W8bMjh+kbqmsOzGuI77AO2/R0MIQbv3MAALRt5VcC5DL6HDYSNpdlAlGw1yoa+xseLpdNjW+d72Pqh5zrV2ZYtWWjqzgLPTFyyN7EWm73NMmMPvAPyWSDUOVbwjxprUkBm6SNQrlb1fwgDmL4InIPMbqE5zoDP47/4g2MjhY0rvf11f67ncfQBRLzSy0PlNba4Q2ELjCPbhUv0Z95UPrJXjituuQFfI8qF1NCkjTA+Q7vwdceUCiAp3m33rQoFegb+k4tOE5gmoT8kj7fiLvsiy4DadyPXAbNwscvTRiulR+TPwU1zb10FCVKF5w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c318084-2a23-456c-e550-08df33fd0578
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:32.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N84GEEhgb5CQCKssSR7Smk5g4NlK3NAA0cwGtg2xaI8PEPSRmq3ib29Efx4r1xnhFJx76Ck5Tr+8MuBeak5Ss3vHgNZTQXgm6P8ZrlCLmnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB993677

On Oct 27, 2026 / 14:14, Zhenxian Ma wrote:
>   Hi Shin'ichiro,
> 
>   As you mentioned in another series, this is a known issue with this
>   patch and has already been fixed by:
>    https://lore.kernel.org/linux-block/20261022062513.77372-1-mzx199711@gmail.com/

Hi Ma, thanks. I confirmed that the fix works.

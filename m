Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478463;
	b=HBzHouTadL8xpN4uhF4xb5iPzct/1EsKuUxQ19h7zxTe4MCUZi6UMFsyY4/jeYK9TkgR
	 NP7VkKswfefRPM0aKMDESALtcPvAkWx89eH93j5a1reZNxgbytcjBwT2VBp9wFgCskHKf
	 3o1v52OPeLMd2ekzslZNp6TCNS6BldlEwE2T+Z4tepx8QZ+NHp5lGyLahmmF20u5tmqCr
	 r1N2OJLZNApqU5MDw7hyhffuaLLqOkpMYiWBkJ3xQcd/pxrE75V0UVPJDaWIqzO5H/UC2
	 1nQeeXJl+67kBw0zqKKgagPDmuzIa5TJCKRy+MQZZY3ZOcN3EDoPB1jStox3r3X/S1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478463;
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
	bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=;
	b=Gxw9GPyn8BW/E8bs9Dg5quvS3zwzgstGZusjGyjtTd/1OrQ4gX6cxbWbS3B1hFMjELGC
	 qPFB0uaBpQo7DK6WY5MSbRJWHf8AgTQysCLr+DWY8Vsj8vbmJZX7miJpr/58zahV7yibP
	 dvwQ7dKunHJT/MBQReks9hvnwn7bJvrealLar/6m2qgCL7tJyfoQLa8UEEeOmUSkR2ASJ
	 I+7M2pfRFFgeXNtiL20MCxtHvKFFxC1XwsnZfyJ8BdoY8k0ElyukzPyAJthfQ9E1omBS6
	 wgONlkATTXtppFZvRqFmOY0H96pludURoHc2IGsK2qZr15/cSvLDc/W+xURoV2igzfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=lRE0P24N;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qF4p5nPb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FA606A319
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 06:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED2FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=lRE0P24N;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qF4p5nPb
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792478462; x=1824014462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUMYzfVxh23Th3UWPJni2wSGosPycEIPvD7v1CG9Ivc=;
  b=lRE0P24NyYScGVLowLM0rQTUvXJ+2qPGG6GoA8RzB4s/4cD0DP/OI9QM
   67lSejk3TgGdvEEpS5l90Xp285mxIeYHPAtyekXtHy5EpWv49rcuegOJw
   yAzV3ve7hP+ZR7o/Z6tXzUOE/6M+xhKzaOaKFnySyUvYPy9R6m9D86tW5
   /e8sgjMYD/2wN0sNfLgwgSGRsIba3QDBqfUkEy2cUM0yKLdCZPyBLf9hP
   KWz8uJlCqx8ISns4gSLAvLZU/kXJCYxWi5C8DjZ1+u2+v7gN1bUARsQ68
   BbB1RKmsugSwoh98Lrflz43E+I3hhbmezqPFa/Ms0hrAlsdot+w4n/tYU
   g==;
X-CSE-ConnectionGUID: /+PEtLBmRYCsQFWwXhN/vw==
X-CSE-MsgGUID: ShKWkuoJSsmmouWI55nDzA==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="159474338"
Received: from mail-eastusazon11012029.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 14:41:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vULJK6VFxJYbUnyOrZUjaVI3knY3WyQNrkY8/q/Rm1U51NMma2unKQ0iXP3yrIUIvUaCuMuPiPsaPHLxKmuuC2VLt0X3DkCzqduNQuRxg9LGuWAz6xyQs7fqZKqor+xSqOzx+luPgCZ4a9YiZPRlH7tt0s7tM1XcXLJRTbfQx9IJMSY7XjRU6iQ1B2MKQcwDVXZoDERUoOr14Eri/QDbT6g4wm82WaySydKmZqvGj10nNVZd/OGYO4BYltg4s3zvpxp6mPGNq5tDoWteVgT9j+UJdjUYn6URTw2DqtUVHkiculuJiJbFZSoppgYvUcb0OfgkTaF1OgOMBZmTfp/LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=;
 b=MxEdRobhMppBTWNWs1UU6e8JpPkyzb56hi1nMOtzFpcuJjnXLcyXWp5W89MpLS9xpG8TorWKd3Yx0h8KtvmDjuNHv7dOfLv0bt6OHlRm6Ph8sbKIp0+jX8vN7XkChZdu7XZUplWIL4PRFM2Nn6Hua04dv1I5sqVTEqEJVBxpRO3ACAI+gjs8gqFCns1myK7XUa2vcNB2yUyxBA7IvJS6uabL7QP3ZBjryd24AjGboz9T4GD2Ornvz5Po44/4JqrbWIwqH6+PCCpR8UYPkWIOkYjcP2u3yKi4Bk6ewtqWqVrKQXczEID11DlX9ddiixtLEP6BmJkJy2SpAto0+xVqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=;
 b=qF4p5nPbeitdrlrrx5Mr9FH9dTX3+Hpy6NrvEtiLg5amAQZ5SAXyHEl1Ea0gHzD8qZU7xLXJpNlM/8LoP1PqExjbMFgtJj/h4AGezweEcMoIHne1H1S7brBfjRGu5bpJi0PtBjMDrJzcEHJV6Q+sL8IExI8+GKk0DwY7ueTeaQ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB7966.namprd04.prod.outlook.com
 (2603:10b6:408:155::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 06:40:59 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:40:58 +0000
Date: Tue, 20 Oct 2026 15:40:53 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH blktests 0/5] nvme: tests for isolated CPUs and fabrics
 queue mapping
Message-ID: <atcLN4XXfNF1YSZa@shinmob>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
X-ClientProxiedBy: TY6P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::8) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c17c301-3ba8-4a5f-044d-08df2e7519bb
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XCxl6tVoo+4gggKTLhVTZdyjoOIDR7jbO8ig6VXADAM4hctM+8Hj+z0/5yp/aw+7uKpoNcbWp6tbfVcyq71yX1mQcpRC7xTqxtPVkJ8jLD2u/e8H5h4u6EDfuJsbOo2E9M57gDkGSF36vUGIfREDeWYSxp/oUSovPpsCyCDz8GzYuSDOh3begKSeWrtz9vB3Zrtryo/c154qt7CD6bDvzljkmzdqGaAri1HNAQBTF+iQvkoT4Rqb+2AAoJmD9SEads0+YqOMxCBz2jaxyhcY9vCM5P3EzrSCFtXJxwlAsKAJAW2SYmptlT9uKfHr8rBkQkhKlWMSjx//o4IxLKzNfN9FkbDj269xGGbsdutDxpI2a14zsSJQn8/5Asi+ZWQ5M7h6SuwKYCxXlLedQqzxOG4siEAd2oi8PuzUouxBzU49l54u96Q3r9lz2c/xdQeh/Er/lS9O+55FG1mMDdWvmqfR/fu072b142qF4ZJHL/tmVpgGpT0P9qYzSGt9LPoQfhaGHClj01Fq3sDFo8Then1plLS9RInnZeuZWZbrBxFPonWCpiqyThJiIFblM2O1Vqmqsb1aWR0RkgAytC4pxgz1NYpEkM30z//8yv7FKqKYmoyddLex6GenMmIfTPAR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEzkvzKkcqNsF+DICmMPEydzUvnJ/gVc+dbePywnmVnNm0KCGqhDYiDK7fmI?=
 =?us-ascii?Q?4hRIQuD8+7MkTFnP7WJc0cFyfk7FwJkyLOSQgI1kJv9XgRvktM3xEXb1vBFd?=
 =?us-ascii?Q?733S5BCYI2ZzcoTe8+gcXfgms6/B0mdktTT4MdkTPQcK3m95UL2HSf57uL5c?=
 =?us-ascii?Q?hgiSWBvos/eqSyi4p+uGE4RwVgrGzNs5zp9Rp/fuj61HohaU14gSgqsGvaa+?=
 =?us-ascii?Q?96h5A4GQO2AlUqwEDO96lbT+U+OCcd2cEhnQ1k+M6b9mommIguccmhibxtEB?=
 =?us-ascii?Q?OpTGpnKOy6N/jMkWiXlztEqdfY10j3Iwvtwtj23hxJqw3z/iObnILF8QOH9Y?=
 =?us-ascii?Q?e5Y8S9oGeZI259KBwLIyh3IVd5muxrpHiODIHAKilTpLWoQshmdyrGAjw2Vk?=
 =?us-ascii?Q?4C9Y6HFMPW+O7ramgAdt/aTeGSldg+jyqqLqXHZQ/NGAHO2coyePqXOWqEUj?=
 =?us-ascii?Q?J4xXc3WEOPPpRpAQSkovjJHyGNW0Rtq9ad8Cch8QTJX4e/JPOHrXoyTHDJRn?=
 =?us-ascii?Q?xr2BJmONyHmgSpTuk660W+dAe5bzuTtS03Ppnj9ouBJvXidDE/O7BDV9VH3f?=
 =?us-ascii?Q?s1esI0k/tUQfJxNC2biX7op0emQII9PlgHxXaUkBl5KcMUSKF28HUIJrt8Ma?=
 =?us-ascii?Q?sdxRLDH9FnYEjAnYSyq0q7w9C1TQ5HHty4CdZEuxTYX3ErlD7v3wUMnJj4tP?=
 =?us-ascii?Q?N96o8p5iDzuQ2SA5wgndNyHwZN9tR1JK0x8jU/Z8txB8EftBdKjl67oUCr2o?=
 =?us-ascii?Q?Le+o2C4lJPrQ0sdzcxh/twM7QLWVTyF+x2XJiWrtKJJcHobxB0bcF0h05MIP?=
 =?us-ascii?Q?bNiBD6GvmSKQIfC5h91mDHVfdIZvQ97OtMHyqFBgGT2KGD+DmUbXQWQeAinw?=
 =?us-ascii?Q?XJioryKfAJCEuGriCtB5EFmHYG3hs0IO06Kjzt3F6/bKxaYogPtUC+7uxzLZ?=
 =?us-ascii?Q?7bDnjAv/sMGgRDU3RRt1hdUFjIDjzPKgx4ET56wh+yPEaDtKGlf4wUV2xCH2?=
 =?us-ascii?Q?iwxDkASN+5Zvb6rdtzlKgIB1T28IrAzpZTXOEfnvcTIlmU6NGTu6OHuyT1YE?=
 =?us-ascii?Q?Sf3xeElsONNVMtofND2/LOS4PsCzYfN5E7jkhh8tLsMpJ4aLGYAvq6YA003G?=
 =?us-ascii?Q?0sorWoTgeJV+EWwzYyq6Q3kGwEVC6FT2xhaScT3memCxgwZZIndLeaBooDVT?=
 =?us-ascii?Q?2ECagzF3n5XDc0o0rgtHPeVJ76g2rlsM10NfEjDSTvunlhW5UR80r9U2G4Qh?=
 =?us-ascii?Q?cU0D7svEqaC8aZtyQm4Zkna/pmvZa2waMjW+ZQRmfxHnlDf6+3ov6HAO8C70?=
 =?us-ascii?Q?R+oNIeUzxwEJxaDVHCDEJft2AGDDf1hAV3RGKzW3WA2W9i4UZw0iqNptxvJr?=
 =?us-ascii?Q?zICpk1qMv/8DbIsSnzNb333OYuzQSFjFnmcZObSxQJRu3PwBlgugxMmMOyLE?=
 =?us-ascii?Q?t5QIrC8JFd3v7ROaPeBAFbRd8yI9yutI89GHhz8Da61j9eNzCursroIrzCrq?=
 =?us-ascii?Q?LOJN33TfZA7pv3UZgLbKzZW7M/PG/yoQmjDjSLWv6QuU/q0EpIpOvLHoKNz7?=
 =?us-ascii?Q?NuUPK56FAoqYU5dmywi3HMB5qhIn2eI6UklLfQpohKNz/UWaCLtBPnW+/ejN?=
 =?us-ascii?Q?KDWjw47lzrbbXYbnB/wRo66VYogJ+Wh/zQyzw+QfQZzIfctJ5u2WVpcwr1OZ?=
 =?us-ascii?Q?ISlXMpQwSLEVDMCArmIbdjKwnQO/XSLr3BtTaq8mVhSkG0oWk3yWup7OuwWF?=
 =?us-ascii?Q?wnWQre6wiLKMDbhjz0UjN6Cuea30Yb4=3D?=
X-Exchange-RoutingPolicyChecked:
	4nslIqcM81FpCMedtNdLXumDmVz7vhxe9DfzQCS6KSmFfgb0jwCrKJK7EQMXRpzQo2f3YATWJDNP4bzdhyvT8FPKOLvkqtqu4zyla7qTi8X8uxbxvBkiLwXZ63RHalR/KuOseC0hVIii0HrXpf4dUArCHBlmSpHp61fPPaNNwfR8vjZaVFLQ5gi6yOu+4z36W9ynVn/xzOAAAHxp276xQPFN+wY/Iq/6iSNz6T4xewFK4SVVrHGQKmok+rJv9xdFhmOHu2xdiRoaRq2Jyys6AIBKkT7HHPa4dlAjOKUct9yV0PpPevH4dN22c1TADUT7oJzocfRxNBqotXJiFRIziw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GOqmL4ruU1PnVuF+emmmK6QqbxdYXdHQGN7l9rR1CdwDk494iqq4e+GRVvUAwCdav54VzhZ7W4GjkT9RIDl/iJEmjhhE9hfC2UQJLfWEtX7kmLoucDjx/Elr5c48gMjBCtgI8h2nwU8jVZ2aMeg68/96C3OdrUYl4wdqTglOpdZgAbssxE/Qb8gxaJSV05izEQabDnxuYfFlrpo7FXeXjJ34SejPSJh+dEVt3g+4AVgEWvn+GNxp9hViPVFJJqI6pYnkrCDvNwau3aHb2oc1rgN63xrud8Io29Wi4ckC8DZQzGGwnBcwn46lJrWAz9en6U+f2HPjwkmzXYvkF7ZDdcFMA/WCQdRTZIt/qGGGBestnumNDSeNQeklI7c4S+RMme79pCiXgJpd8MgsGksTES0k6xYVibjMMBK3NWB1ktt+UpmSGgHgqfT4h00bBIK6U11iPJrAZzyekFVR7pxoK9HfyNO2mJ8GsZ+QTfRktaglYnyazpNrgtWwnBAYQTZ6WF5wppaulPYQTPIYc3ny0hZnfVsOWPKbs1l/lOeh0nEwXSEp5aIsz4RmrlSvadCgqUBVwJS1LJmM9zjC6g0d/GEzkQ7DD23C3A3mytpwAc/760RcW44SJoaOOGipvY3d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c17c301-3ba8-4a5f-044d-08df2e7519bb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:40:58.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D33WFGFONIz2EvI7ykgee1jNY8UZc6r3+yXAMCq5beK1CwwzKhSrBexZolgQV6n6cMjMYgvWVebpM4QbEAmH3E8btjwmKUW3gO79eClzCQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7966

On Oct 14, 2026 / 09:51, Daniel Wagner wrote:
> New tests for the bugs fixed by the kernel series "nvme-fabrics: fix
> connects with isolated CPUs and queue mapping bugs":
> 
> https://lore.kernel.org/linux-nvme/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org/
> 
>   nvme/070  connect with an isolated CPU (cpuset partition), verified
>             I/O from a housekeeping and from the isolated CPU, traced on
>             the queue of the isolated CPU
>   nvme/071  more write and poll queues than online CPUs
>   nvme/072  no queues left for polling
>   nvme/073  reconnect with fewer I/O queues
> 
> nvme/071-073 need write and poll queues and only run for tcp and rdma.
> Without the kernel series all four fail and nvme/073 crashes the kernel,
> with the series they pass. Tested with loop and tcp.
> 
> Patch 1 stops _nvme_disconnect_ctrl() and _nvme_disconnect_subsys() from
> truncating $FULL, which dropped everything logged before the disconnect,
> e.g. the fio command lines.

Daniel, thank you for the series. I ran the added test cases, and they work as
expected. With 7.3-rc7 kernel, they failed or hanged. With the kernel fix
series, they all passed.

The first patch in this series is not required because the blktests commit
64cce9a87099 already fixed the problem. Other than that, the patches overall
look good to me. I think left works for this series are as follows:

 1) wait for the kernel side fixes applied,
 2) modify blktests side commit messages and test script comments to reflect
    the kernel side git hashes, and,
 3) renumber the test cases

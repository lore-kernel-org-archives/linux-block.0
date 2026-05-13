Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F353FA5C0
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671349; cv=fail; b=jdqRhJxVAzfCowFmfdKmenChLHDGbTU7TpIuB/m1fYtbdetgxnFcuJ9ikmqrda6x4xjEFW7BzD/KmRdKjxI8BsxeL+8HR/4LuV1ZA69NYf0xyj3K6HDRSbMxNWguVTIWGWpmNL8UYozrxKRIgYtv4zaN54mbe47APyQU+nkLKu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671349; c=relaxed/simple;
	bh=+E63an21jBhjrzXjxcbtVkOf7QFypM5j0hJ0BMSRSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XdGRQ9qqbTB+YLuh1WQEg7z3adPkdy8T+DXyTZeuGjkOeAXNG0D5AVw2BvxqxJ8LPtMHrOP5Pljjmrb12guidhq9mVn3fWzX1UCBnldA1b0OVWdPXEKreQzM9kirSYc2hQjL/f+/TJNpXerUpeacWwtp+QWOVzSDuCtjJ51jaOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=URtdNAIZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BbwFeIqf; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="URtdNAIZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BbwFeIqf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778671333; x=1810207333;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+E63an21jBhjrzXjxcbtVkOf7QFypM5j0hJ0BMSRSlo=;
  b=URtdNAIZChdME2AeTZTjvTaw44YZBVe6wE4QMVBgbcQKuZfL+YZTKAA3
   NcQlTz4cPnStrdqSWSkfTJHdPiQ3IpomM2dJjse4izor6PvxZMqruocb5
   xHGNf6Vybcqk51bnhoKduAQDmGyFRNAckQD0mzk87cJIq2LlazkfTEqBl
   roWnxMMfBuxtj3+FMRyQ63y9cjzuxXaFS7SDQoLCDPf0080FgICFN0vQX
   X065boFHCnJ4dJhzNhtQKR7iXufHOvonZ3Rk0TllAHJ5hkiPe06pd1KvJ
   5Vyaa2/fuKRE18tlg3WvaEdhFGJVAt+RgJ9AtBA8dkW7WuRYntaw+hpvC
   w==;
X-CSE-ConnectionGUID: BAgmPZy7QHWS5cqbmbQaMA==
X-CSE-MsgGUID: Wxbg5rp8TN+m7ly04kXlxg==
X-IronPort-AV: E=Sophos;i="6.23,232,1770566400"; 
   d="scan'208";a="146475577"
Received: from mail-northcentralusazon11013004.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.4])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2026 19:22:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU/fN+IcD2NEh8uhDMc9FgjwkA2PIqo3EpAZLRv+jyXK1h0j3TveCPaye+6meVmn6kZNlHG4I11R5LY8M6hBrhsfnfOteDKqQiGm/BFuVm7YruQ+0YQTUKEm1ycPMOFuzDhV0hAz64OCh6xceOzTA4mIC1T920SBINqe97ashtXRP2DfEZOcTHjdo8u8acbOF5ehBJIGvdFUh0Dua3xtztnc8ExP7mJ/cWOoXDoQRhsHpNXie66zogHJXTOmGEtXPU5dYmYalyQMdMrsqidH9qCWULZqaffCICgN+q06XiqH6KHzHvXd4E1cIzz/qnM+harObONtjVe5j5dXk06AmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E63an21jBhjrzXjxcbtVkOf7QFypM5j0hJ0BMSRSlo=;
 b=yBcVCxDRJh356z0J8f50phTI4y3kO2ApFsKJTMBVm8V00ybObvvpZ1oW/EWP/uksF0uzVNQasJDV+k0hfhM7rJ560jPedXgT5OLR559SlKa39lGiNFgVwb5EcLKgKt0OH61iKTrMtL9BShkBI1VtNH3VCaQVUd3jIB2CG2wNXeooStxmaqLXSo1t2JS8nLuA6CyeIpyx9leViN/m26kJPcPBZaPbvG5QOgCD3rARNrulawL9dJSn3cxvNVsG/qY8J10mEFuPCOPG5AH5rMAgRzBud+ihoZULII4MIZ2qiz0aruoMhhGKCmv+HSLjH1yUY5mbk+LfTy34D29/9H4Zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E63an21jBhjrzXjxcbtVkOf7QFypM5j0hJ0BMSRSlo=;
 b=BbwFeIqfv/9YdmjxWKSjPkMnQk7yXyb8jaPCiSllS97mXZ4nDbSJ55qLdviXR+y37xnRDpjbFl+5hTdYDXWFP6vpBY6qZcsNC1ecp9KrcH/W2mOGY/CWhwRQkW6XL0kkigcwOn4Lea/jJ3xXE/onbGaWhFxYelBcdTxzSnA7kWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DSWPR04MB10022.namprd04.prod.outlook.com (2603:10b6:8:361::10)
 by IA0PR04MB8785.namprd04.prod.outlook.com (2603:10b6:208:491::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:11 +0000
Received: from DSWPR04MB10022.namprd04.prod.outlook.com
 ([fe80::69dc:e3d3:5e76:4b3a]) by DSWPR04MB10022.namprd04.prod.outlook.com
 ([fe80::69dc:e3d3:5e76:4b3a%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:22:11 +0000
Date: Wed, 13 May 2026 20:22:04 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix handling of dead zone write plugs
Message-ID: <agRebpCstsStx7WV@shinmob>
References: <20260513111129.108809-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513111129.108809-1-dlemoal@kernel.org>
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSWPR04MB10022:EE_|IA0PR04MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf60417-f4a4-4fa9-aca9-08deb0e1df59
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	WRO7VttgqqCKct5+tqTz2HLpcGex5ieSr1PflTJrvc5q5vVAEY+q+IJV8MWfjojRKFf/Qsczw6P2Fhyfu4sxCXFiF29IwG5iTxdAE1h+47YBCIGu2+2nEC05shhYOuaVg/Zom8eeqESsFTVoxdazNDD0uXHZRzmMfHdZ2HJ2HMkoSBi3R0QSLPgRBayiWy31Xs5spuy0mhtSijegq1s0/zoH9hS/eOT5nGnh+mOx5X1YLtX5HOtMySaAjroWHf92NhpPl7S450KxwVNO9hfZIBA1CTX/M+4RKzir5/Q14M+6YYk2PKJwl5iIZQIG1Gu2qqIqVZ1eNngtMfrWuLDbLYB720LAJRsgsKoTx7CQSTOFLLEMCKusgCBEpmJZsq/AOgCow4fq3q696LKvLMYmfXd64JT21LAcjFU3TzhMtTS/lclSTjES6BoHUdq4e1nSWooJrOPNiElavpq8uXMSal0mn+01RdRbT3jGu/iIXvPwJzdcnOM/UWJ2BlXS5XVff4s0TMMetBO5M3blIrpDzp1ImcsQ5Z4DGc+0l1gbfbZ/x1H/vQT4NwsFVWMOkU40d3fQ+R+dtY7LMwd26YpOHpm81+SfJpdSrvC7/2lher4O0vU1rQsnBlK/VnY+6iPLfA2UHKb2Cu1FLDYnBcvgYMltwWMzm2bDm3AGAeg4I7tVXr8zcVjnl7l5J/G8qwbr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR04MB10022.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MllJ15MggDZXnBaL8646oWM/kS2X5QvhBxyLDHHgQsaHK53UXHFxzkR4N00H?=
 =?us-ascii?Q?vAd/YbaBZ2RqNCHvekBtU284Ux6zNZnAYvsEu67HUSmUYeZjvqFfO1WNf4ud?=
 =?us-ascii?Q?3LTtevU96cLYm8KDUi2393gZHqP8s/V+3ZCIrFx0aAODcNt9iNxZ8Gqr5EuN?=
 =?us-ascii?Q?bQlQwnZkM6F0F97Rx+Xtu7YcTVTaobYJE2FfKUiO4eg5R2a+TxTCgVM7L68a?=
 =?us-ascii?Q?aIaIZe3j47WuBl6Bc+t/ws6gH8KsU+5jcaFfFivO0f9xtOWJRcAaxMI7FiUM?=
 =?us-ascii?Q?BdQJZWFTFxII16s6+EDgFoooLsNCrmoEsdNddpWjh0Qc3kb90j/r/sqLCnmv?=
 =?us-ascii?Q?xzQNnVnLh9pmZd6bOWiRuWkN/zF9k7QHrHFRmpwaZL3sdLSnAHpYBgbqPVZL?=
 =?us-ascii?Q?QwNIQm8AnZ6rfB5Znd54Yb2oYq5z/J3koH63gx/POD1WQph9Xpff6G67JbEb?=
 =?us-ascii?Q?pImUrukCzW+sjnUv5BiXhR1wX+eDzDBnIMH1fUGX4nLaZ/IZrwe8GG6xrBTU?=
 =?us-ascii?Q?JsLlHtzrN3nk/tNG2wQO9uugzkLQhIsmhGIY1cNFISzeMt/x7pPJVBVauRIx?=
 =?us-ascii?Q?gXjHdVAH2LL7Up1L0C2cdsqB3U/l4HlLaeggiNmsw1gs/XfSbaY3J9F0Z3RC?=
 =?us-ascii?Q?QXHcHE6rPPuBwuw6S3mRT4MPX3WLdgDarFMsNGCdyQSRYdVj9ENNIeAS2x10?=
 =?us-ascii?Q?UPtWWsYaxph0XlmTpHodpi8bfEoypgFnHYSudXR8xWLNuOEWaMpJ6BA+71r+?=
 =?us-ascii?Q?LjfbDzJJrQISAwoA7qw6tpNL0mJHu1tPE8ZVDAyT4Dc1yuGHd+mhmW4ViEO5?=
 =?us-ascii?Q?O55cY55XQ4Wf1bbo8E5ewGyR5OGP1/kq3XwsubinThI4DuivSo7J28JwG7Wq?=
 =?us-ascii?Q?WmRdVHWVBztZlb7bKokbGD0X5F1i+bQtMdqAr4FrYCMqyvpYY+XuDAFaxRfq?=
 =?us-ascii?Q?s7CpTpk4YyyDhNGqb7ezsdXzQLtFKxAAkqziUvb+0vwA1iFivi/SZLl7p5nV?=
 =?us-ascii?Q?ihIEHvtg/gxpgit8c+v/r03myxCmv3xov82jlO+v4hpctJt+2MyRXjGaEFkY?=
 =?us-ascii?Q?rT76RhD750iYb4f4hi8hjCA92g9BZMkxMg+xu+E2HM24SpASu90M6WPMJRBt?=
 =?us-ascii?Q?IDVzGfIjgQei0LK0dIRIKZOOeWY7m16pD6VqbY1qQkTBNbd+vIN5SAhBdXMl?=
 =?us-ascii?Q?+62o4sBDquWYh7ZXiKAaMCrtOgCrrahYV4GAO93O/YMkkUIGK0w42WBevMhE?=
 =?us-ascii?Q?UHvBpOt6IkJzH9Fak6LpcvQpl8eIPsPmuRmKa1bfwQoJtZf2YQu05ZfeSSHv?=
 =?us-ascii?Q?BTQ6aq7Y0HD1Acl87jAmeGGSBFjw9gtO43SghJxBOPQXfTBo+ZfEDsVrstdn?=
 =?us-ascii?Q?L9q9bsiQSGcNQIfGaglMOqs5FGZfCtFJTemEoFM8gs+JRqfTdvwexX1OL1tB?=
 =?us-ascii?Q?RXvbzvMD5hUP+NcCBVQ9dKw8VLezjWQsTZPWVDNoQIrzifeTs+DVvHkXoX9D?=
 =?us-ascii?Q?ZHl2j8BZeQwuZhg1q0jY/53Vjo3p4/A7sSbbkOszvksu3Ht1yMwr5xyFqGnY?=
 =?us-ascii?Q?/IIF4NSlZYo3vcEDhTmefXkJ25quZhWHzoDXYdkyQZVhfrsPa0J8pdNL/VH7?=
 =?us-ascii?Q?bByrZXL7zNzT6PwHZxnu2e9wpEcxNyN/KbMeqvkh/mPnWNxOoWkYckxglFhC?=
 =?us-ascii?Q?sL6Qt5DiBkRIs9otBXkpbGoFlYnroiy2yIuK3RixBL49eHwL9CSnrNeefJ2j?=
 =?us-ascii?Q?wsiQQ7lh1J72YUxJIUxjInt04CJSg0E=3D?=
X-Exchange-RoutingPolicyChecked:
	rbwqon37NqMXTgERGN9ZiKAj6wm0CiEiRCw7e/qndk1xeYlfZAKrBtQhPHYN7VdNibVzNs2Dhz1JVzXjN5w8soj1WZTO4Zvtjcui5+jhhotySpT/evCKSzjnzPzx5td3xMWMHgUFAzR06Q9inV2qjV/jlVmrAfM+DFJGV9j7bc04W5QxMPoFNZD93RW34VnWp6Hl9QBeL+KttjOQktligWfFQkx72xjx1nx8dgmD+OO3zk3G/IAgh9EY61QM8fG7Q4vKYE+4IU9GGkBl+zhr5jDCRLCVyR0ms69BtTDGuwb3EfpzJOzb8q2GAvA+/V4g+e+SB/J84cFkPEXg84jjCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+/gw5POerFJet9tfwd8eIHucAzz2TVTJJFmcKNgTeGS41wbDOuWMTVAo2ppZW9y3O34ORUaD+yQ4I+3UfNYm3rcG+zzLdDcNIz6snmj4xYovPP/jCqgZIhxX71LUte8J+hDnCt0TuAUjYMV5NKnzliI1M2hgjLzZMgvbF3M/jiCn1RzdaprMNnV8pxvROE0nSru3nLUo4j1YafiOST29ptVuuKCs6P2j01xVISxt6wk5kL+kSy12Pey/c5YzBunhObCIhZkvumXiPVBuhM5vfqQmJwMV3wc9UNP3+llqH3gr0fC2eL0ZsYytPzTr2F3Ag+mwTyHNb4Fq3fuw8eiObYcN0HBeYsHCmJq4EvMyhwEAcIZXubN/gDXSP5bQmpzEx5J2rKYBs1THCZ2RZB9PVcm1m5Atcmjfl7baOVM9RihH1/Wl2XspB8/6CwzkFtGfIoZC9RrweSvcRLSjh8xWxKVXYi7iHKpJUp3NElHhFrGWvFWJwMG9MrTD10RAfGiwqNDljwxCMdRdmMws+d86T+Z1oVzoPeUUDL3pQkQwmyntX4+Glc9+lVVHEk2rk/vCXXacQ+fO7sVpEcQiUzGeN4ubLNN2UtQSEGKnZ0pG+gF6ISc8ad+g7HajzdViv8HC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf60417-f4a4-4fa9-aca9-08deb0e1df59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:11.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +njveeVFmm6GKXBhikvhnHl4zn/7ybwTaX4hQKqg/fXyeOn4IwH/+7BPXnqNpmNdAOjpVOLpgQ94FLJePE0abhm1To4QfyiIySnAtuPAHvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8785

On May 13, 2026 / 20:11, Damien Le Moal wrote:
> Shin'ichiro reported hard to reproduce unaligned write errors with zoned
> block devices. Under normal operation conditions (e.g. running XFS on an
> SMR disk), these errors are nearly impossible to trigger. But using a
> "slow" kernel with many debug options enables and some specific use cases
> (e.g. fio zbd test case 46), the errors can be reproduced fairly easily.

...

> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: b7d4ffb51037 ("block: fix zone write plug removal")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Thanks for the fix. I applied this patch on top of the v7.1-rc3 kernel and
confirmed that the fio zbd test case 46 failure goes away.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

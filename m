Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADD492193
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811787; cv=fail; b=EZVb5BIiOP1lTAZz86OZol480aRTeld8iFj/gGn9JwrejCt7zGVSGG6pTCPZolgZKCtlG2BTZ+uvsvSG9R0TjiOHAEnF+ansDCUxGCj6uJr0WkHvx1VOvIxIl8Z/Vyv+Pri3diOeJ652dCVIhZUfH+MwzGzENQXNT9dLsSfp4VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811787; c=relaxed/simple;
	bh=VibUstMrL7hgTjaQwZnOYm5JU74FyShLHjfwri9z8tQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhar1+uBdhlzrgwvhaNi0mO7x6DlmCV6gMTJvzO/5PDTtRykFs35pS3OYKi83nWEeoYdu/po8axwfy5Qq58TQuynzufAjK2Y0LwVLQlHVXPnBFze7c4o1Koxm+76yz4IckC1fILHIz0cmDDkUOoqcrmxBP3c2PwDxJKC8uUDZpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dq69/j+n; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AeYEutsK; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dq69/j+n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AeYEutsK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784811785; x=1816347785;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=VibUstMrL7hgTjaQwZnOYm5JU74FyShLHjfwri9z8tQ=;
  b=dq69/j+n7MhnoDeNuRuXcm88uvuiNui6CzbMamrKv5pRbCqQ1cuBJgIR
   9xUbzB02T2bk7sOAXZgm8TUnt+HqHqFYi+/FM88BkddgZKC0BOik3ZdrI
   hVfoKJcK++ub+zvM0aGvyzxAvwvGZU6KgeLGY1HPRFH5i+dawsmlQSEik
   z4bHbwYbYhGmrWVD7K6qUqFn0f7bPEjFikpyyTqMkaDJQXL0axeWj1MDH
   aRTS5J9HKjvHxKCd82wW/tyaQrGy1NriQof7qKebakXClceMiWtYja20V
   umGDeGZcsftOpcgnur8VYDKLLVxtg226DmqCUoZLKNwlM5ZFz5pLyJ+O+
   A==;
X-CSE-ConnectionGUID: XsOpU1b8SPy1tp7zx1Yjyg==
X-CSE-MsgGUID: 0NzvDh6XQeWkpKmPwXUvOA==
X-IronPort-AV: E=Sophos;i="6.25,180,1779120000"; 
   d="scan'208";a="147467676"
Received: from mail-eastusazon11011005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2026 21:02:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9I0tqQ/zQHs6g7iRwXhoaWRwFr5KctFWHptG0o/A+6GMSq2dvhned9o64r/c2uA7OYW/ixVtNQlG8f9bG6OqmlQ9NMCF3sj7fmSC56DpTqdvYJRCLYad6sW+zYe/dk9sv7tLFP8PZizqd0mBCEJ+c8psxdZU4be8GuZz+teyKVuBDXf0yYUCcwglvXylPzk+fhsjhxmPfm2Nh646A1hwvurVOnd11K6lfhc0kG3ePevM7So4fPREyPt5ZkMT93+1yrIM7zZHGhNJqMt/e+ttOpGoyZ5m57VZ/BnvTfZPIWH3h80EZHSy26sfV/3uDgq5Qh+Id3k27MnQlvrUwdpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IL236rOv8hGnE/eA5YWHRIsxXglvYVz56qppVvXGGo=;
 b=x42bvLcYctzU3eIhGNN3mIvIIL2H7VBOG1MThTjCi7ddMhVaLvnazYs1JwSgEH2X1U+vqoA4GrIk8JEtRRkJT91i3TcVRkcy24CFCq4IZ4fbjnd15L/jntbbrs4kTK8cuXFoxJqYcnZxhCM1pIok2UOFtnnsNIzPqDFp2HDBwHrS/mNp0IwAEBzFfZ/Q2wSp/PvieQF+wCpGoC5a0T39NX6c/4xzi6zBovUNCsrDTbE00SFmFkgL5twkO8C7G5yELVojH1wIFIwAH/aUzKSJ8QRVUTfOhuBsrUghzMnNfI+W4acIdvEC0yqmyDrHiBv2b2W4VNJ7LC2okLxOow/nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IL236rOv8hGnE/eA5YWHRIsxXglvYVz56qppVvXGGo=;
 b=AeYEutsKazygxcXjTIFZXF7SjZxgN0SPh94KPrCEwhlpdj/7qVCc8g0LCAh5Rgx0K+XA81hBPmnULKy6CfVw+n/dfzj2qehSOUjKJ6gpRo+tArq7gmDOKJb3sWd2vSWCNcNpqyvrqSs4ghdO8ovkxWiMGAvvliJtKojDBIOQcuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS6PR04MB9939.namprd04.prod.outlook.com
 (2603:10b6:8:368::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:02:56 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:02:56 +0000
Date: Thu, 23 Jul 2026 22:02:52 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] misc fixes
Message-ID: <amIQ7WZEkPR3msQJ@shinhome>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS6PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 814fdf19-adb7-4097-1351-08dee8bab733
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JbkwGJU4E8LjSyb699PG8ZiXW29Ga8NlqBvpzxLsI7BIMSCAGQd+PHYSzup0xfTJpXJNAAty591dOjkxLMw9hUIA2SGHM/COt69WXWsALMLytEat9A5aUJBtwVxZoPcaG3kurUKchu8aHIBAaRTeu4k3pBe0mebKUSPvvQE3MpYyWVIiXgAcwrKMwF6Dg7V6FgPCxAWYgfArlzVWISiSLdmDSR5ZcIEnr/TFCu2YisAjyxj/+wdkXqHXgckSIqqpdjmcpAIYiPreFAnnmRzsqW44/7zfQOsC2GF45/t/HL6FrOTkTASsD8K0cHp16F045HVWhCE2un2pFldrfm2lafL+aT/yjpeb/ySQL+ydVWY+TGGwkXyeXdHZtQJEAZFX+yc3BPxHu41xrOhw20/iC2LGeo52rI7Aib7qenOgRYZI3O0Oja2+/Hu+LHoiZaBRyKYTjqNvjA5OeAOmxiNwLYFc9fS9N84iSfo/zjNQ1IdG4wFLdhX8PyAAue/p57izWFih5wsOXjUqsqdio8AsoxmE/vfi2OZayOBAcV4JKJ83nvGblpzJRcXVrJtlqU6GnjdDfrDDK2YC+6Z/k5WyCizgJxd2K8/tf+8pZUp4dfMQHWabqto+hXjbriyF3zjp/lvOynkHgBeMvB1cuQw6KXo30zbyG+7ED+haPIR9zQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eblDrChVfDgh2fB5HXHliJQyZfe34Rege9oi8mDu/bZvEHBWlWJEFmeSrewa?=
 =?us-ascii?Q?hrmsEcMX6Wrzf/DJDEP2NnafZtqQlqQLBk+o1awn0cC8ILoqcDXJAPA5dcDM?=
 =?us-ascii?Q?BJyvMbv7mwVuzVAItGwmegdZmF536Ypr8WXtQQhEAr0U7gUAc1ttmqHm4b2y?=
 =?us-ascii?Q?JZx4SXXodLGKu+Nnooke3TncQXWQbV5821s27MrF+/qXUPX9zOYogVp7z7PI?=
 =?us-ascii?Q?eT6XNIjBVJt8/sBqIrEVkSOBwW0MuPrKMMs/3qruRlgC5P+L4Z6RwNLa9mTw?=
 =?us-ascii?Q?i2jZMRIdMtaI32PMO8EQyoW4hTebUBnIvy9AZvHpWSrnYr2kLNUvnK26Njw0?=
 =?us-ascii?Q?Nw2SlUBFNRjLYU/4inUmCxKDRAqgpmk4280o55bAOY890aEq2M0+AXUFXKKI?=
 =?us-ascii?Q?uTLHfoN+KLolNDe+ONW9hbBBxjDuFExf4hTBlPagKjziPuueoImmacdSke24?=
 =?us-ascii?Q?EQQlzwPe+9TG3p17iR8epxHvDvHwyxnAJfy3G8vFBUn8kRwwZhFjA1irC8SZ?=
 =?us-ascii?Q?vhFF6Qtxnxu/pH5yj9D6wWAHp7M86+6JfJxErnm37Tcl3qq73Lp0Wm0YPV7N?=
 =?us-ascii?Q?kJMgSl2AJp3ehPFHNRXc8wARqHF+PNdtbtJLqksfNlBM6elwyKIQHQxiRkry?=
 =?us-ascii?Q?/FqLtFeJYPG7l/ath+kmgqeHwKIsF7n/yGeeQaOxjjNlJQnbea2YGelwr7kr?=
 =?us-ascii?Q?rF27/FtL1wLBxWoLaik9rmqAe+NUyBhTgS29yEkJ11Lfd44Gm0Uf5+Knn91n?=
 =?us-ascii?Q?8MVuUgM1oBuoL+bjtB0EBx/aJIZgw7MKe9yQCzLouB4kR0w5OPtnbLayTem3?=
 =?us-ascii?Q?Q1rql2X0Roh7xf/7Ot3mGHPdCs3ZMVeG9B/bDmYGqYq4PneZbGGWzg1fD02z?=
 =?us-ascii?Q?LWC6DVEb7wru8w8hELxiRDLJRupNNFIX7CIzPTGDp+k2U/3j1vNDXwiLPRJ2?=
 =?us-ascii?Q?bxk40J5tFfZbTWKmqCPOwDs6T5rBjY4YiG1URFgnDG7DaGTfrVKXRd5z1cfq?=
 =?us-ascii?Q?pSBFW8tQxgMG8iz6rmynUCp6O5Iw2UR3sHG9Ycjr/vuuz1l6xR4jnHETOmHn?=
 =?us-ascii?Q?2wyI6dg7cWs31AcqvOq9h0GvhW9gw23hNn0uSp/WyCsgKFEQYYLse3ugShsA?=
 =?us-ascii?Q?wm/R+jDcc/84lhdOOCzgVx8+Q8RxyVYr7gsVGHLrIRTY/48l4TdfWZ22PNTa?=
 =?us-ascii?Q?WdcL4/dgj2+QnZ4QoTsYHmBXvjxoIdgpRYt69xBGG96yB+p792ij7osqIU8R?=
 =?us-ascii?Q?xiCmEV811Zl2XMlFNXDVph8f8dyjLYefODkLNrsr1YzSAiGIKZz46mk+6+UZ?=
 =?us-ascii?Q?fMW0Fa3JWVEnkUYGIgIGnrdBVQ8t2ol0nScS9SinIjd5BOtjTPeCgsntSFI9?=
 =?us-ascii?Q?DIcMZUbeohI99gFv0bTw/6wrWa6+lh7fN4YrssRif5pBIMj6FHjCtxv1gBPf?=
 =?us-ascii?Q?8EE1h6Bl1zIat7Y2AJId69BYJ3+TE3Qr/5J9oXTSTyfOsPiEiBqYB4Gjm81P?=
 =?us-ascii?Q?HQfoNwv0lCrL4UvZfbcqBzr1NR1Dw6L/BwHWUMuVjy7gyAbDLCG9s8GXqitj?=
 =?us-ascii?Q?FO1b+YMzuK4hU/ruXz/RhRh5XWLVM/UJ0TZjiUpaBPM68UL+edlX9U+j5SNn?=
 =?us-ascii?Q?teo/sD7CNiHx4gFhWeuAeyu/ur8Kvo/Yi19zgFj3NVM7XV8c1xg/c58JpS7K?=
 =?us-ascii?Q?+/FMS6slgc75l8obWxH013+XysV4qIGgrAKniX541yyIn2LfBMn3hGciB6v/?=
 =?us-ascii?Q?puNoCsG3amz7eH26DuLqkExEKBPXOdI=3D?=
X-Exchange-RoutingPolicyChecked:
	nsZ5t5vzaXbYUGRwYTPZGh0Zji+Eqd+ozZi9PKtI7ryfhdd+rw/EXTB9Mu6fxjKN9VUuMi3KTKy61buR5NoI9x6It87Ed8O3c231GW6+j+FZV1oi4coW1KCNNhVVP/MNyNsFMYqTqqw0pAnXVitdBO86O3mLJfy8Z9Zmg0uIwRSKWcNXV1ykUTjN1C1EX1EpXYaEsmZNjvv2WCSHwsynmc8Ea7uAaMWCgXyzdMEPLAbUlXxAVzfVYp0ax+27GGkWZ/8QJvvZQZ2GaCHT1HW4XWZZoWwUYi/UdL8RA6HgM4WCspZHa12jE0KNk8oOk/FXhnuSOIVYo2+qqQ3i1AOzmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iGkj0wamqD3w9o7YtSs7fvOZPjK/nSaXSkDF2XqvPQfXQAUrAVGq3ZYYVDypNYTdAiE70kbf7pmfz9zkuymGrV0MJaOBVLeNpZdTs15vgeM8+t6gnkWXshf1u28e5ISsyiQwIdGiAkjjQSHhDInq1xXErjrI8r6YrUfLyCKNKnEyV2cmvWTEab0llPZ6iaRCVAb9DFygo0M57PGd/B2xHUabKtFd5CebidyK10tZNM/SKG/J4TNJFwFvxKQi/YPTXVFLIZh2Y1mppzFXqO2ihe59mWHBd9mbO+eK4sS6X80ogjSRQmkXVgFccwg8gogLdp6Kkd2l+43+mjfodDNli+6eKB/0VNp7xfPqaPwRTeLtisoxujy2ujmfVur9Tu3WqswMz0cqwLjqDngWApN6xeA6oHXe6FnKB1OAMzm0jPfaib/fYFlkLQIbkqmqR0KNAc7FsBBo9HmITbFLvuK6a5L1g6Jox76FzB7eOGtvnLA2GSiY3X8XEGSVGiJ0c0aW3tWaXUL4wXo7N3KbMEyCf9dSUhPoQLrQRqLYCP/2c01key1YdlQxp4NHRaLKFctsRyt4gLvpDZOFesyuwGtTAy07iy+J76h1o+n3bHIbqSvit5qyxCqiyD29FFD/RLbB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814fdf19-adb7-4097-1351-08dee8bab733
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:02:56.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGWw1H6SZ/fMa1tMWrY7ggARZDdQKomSpie1edEAj5RvjInrcmAbrBm6nGfEhPW5MUOR+IG4DEgkskY9xqw3dT0EOQx1AsVRl/Fw0u2RO0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB9939

On Jul 13, 2026 / 09:39, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They do not affect test results, but worth
> fixing.
> 
> Shin'ichiro Kawasaki (4):
>   check: fix exit status code handling
>   nvme/rc: use _set_attr() in _create_nvmet_passthru()
>   CONTRIBUTING: clarify that GPL-2.0 is not applicable
>   new: guide long command options

FYI, I applied this series.

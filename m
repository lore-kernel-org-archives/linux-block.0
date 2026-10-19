Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF349B456
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407713; cv=fail; b=LGQiPecqjUCVyM19GXDxOll0eW/8+vrT7LOKpxEdnP+JBjv+QAZp+emjskvxLyaKKi7rbJR/+wtBbF0TkuLXUdiKw4ePlLOttQ5JrUTG9Wc2svY5kofWBeBF6x2rfZ6fHla6zwFdFuKFyKLTt+2Ixl2Da2ltWqRXde3drEBUsoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407713; c=relaxed/simple;
	bh=rT75ULYuZ2N6KtifgismPs9ZudsDAS00PRK51U/miZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rRt+OY4yEoR2MeVe9SzYQ6q/Nnw5RNR4SYKLsZ5+o10lgFE1g0rUdl3EY8eSRHqUNH8Lagw/SmqJjsDwc+eUa9asjTZN8I2GDa1gQXk7GEpvsKVyTtuxP4Cl5b7uCyYH9PPw4SFZtgSIEMwG7rbqIyc9gQVTAe0EOtFjSBvvoNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mH7oAsHT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wZOfqagJ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mH7oAsHT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wZOfqagJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792407718; x=1823943718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rT75ULYuZ2N6KtifgismPs9ZudsDAS00PRK51U/miZM=;
  b=mH7oAsHTDMjYJe31M1/BJlKZw1AyVVjOI296F0gttlJn8z28TIPOqhgW
   CDhE+L/tNrVur6VSbjIAhfgQOPehsicmhWeCBp6NRBtX6FDbnDjw5jMVh
   GzgZgfze9jIGfbn+IKWPm7GNvHnJFYo9itCYNawoSCrZyilWs32KZZBQt
   qktAdVOlJzSHrFwifDqJ2LVATfgoxVdqDkfE4TNw6sh4LAl9+kqf5/6sj
   liJBCakXsx36pNJY5KGyqZhjn7hi54IqQTlGZ5a2rUg6zWQdrUxHv6dup
   /A9UPX18avb/CJBFdYiOKIKyBXkXUSRF8bk3PsyBDf/5gfUmxzQO59aye
   g==;
X-CSE-ConnectionGUID: oI6q6jWyRoyedrVepJgdAA==
X-CSE-MsgGUID: U3RTGr9dRbawRBh+4UM1+Q==
X-IronPort-AV: E=Sophos;i="6.27,167,1786982400"; 
   d="scan'208";a="156836811"
Received: from mail-eastus2azon11011066.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2026 19:01:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWlvUapUD5Xll8yeNtIQ6LF/D8Q9lmdGmROMSIEpHd2ZHCWTQS1YPwaNmmkpEmZum1lzJQj8BzckfuUJ3eYm2Py7KH8ntjaUTMYJiJilmwZiMZQJZYHaiAqhWmQyAwATbDdQTVOcfXcoRO2LcKaLa2FSn0WgNWxh5+GPUnALVAdLVcgnFSK0KKxcgaj5SfyRpEgugg6mR4UG9wO6bos6dRAXZzoM/CsJ0QGT2jQCPE8mHqBz1mixSkcSY6PzgodsHJk+7zBCogm/zueyhxUa1G2HxWCQe9waMXLTogIbg/jD/OfiiF/p3WaGcjZdgJ4q8iKg56EjI133wp8h91G8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6R3RuiUsFKe3DT0cKUfoiFEpSdUALaU7Mau+cuAS+s=;
 b=GLTlEvq3EgMKGSVazqVupz9n+pwqq7q1u6oYWeE/deSlFTdvNoAdnOvnQ6Cx7tosAzRBgKWZe4UKGHcFXKjZq6Sp+afdnZ/v5KGu/z3ViLJvo0XXrYoXrXMqPjOy/peeTByEObUq51XDMV1fXR3L5rwxUkFIt2Kpism2Obmz0HjmoqG5pfTV/bl0NLJ2Yd4g4c6nU0driadBqrZFXlsm+FBz4WQ54Ucv9DaPoJ+popfY1NLoOdHb4fWZVXNLdLB7WyreYontY54L0mVGzpY8hWjpZwdCLxanirLI8JiOVJ0DfzBDGOogyScoj7df2XtbZ/+TfZnakf6X99kWhLcJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6R3RuiUsFKe3DT0cKUfoiFEpSdUALaU7Mau+cuAS+s=;
 b=wZOfqagJE3W/iNuW/fODa87DTZmFsN+cVh/qrUFE95FvtinL4K0R3heWP22rfQG0K7zEJEco7Mn1A1JCOOlVNgCk70j/2nScVkv9zyr8AUIHtrnW/7VtWS4SvI0se9QMuuqN0yekzmv2yxpcYCatw+6r9F6wqT6ap0ZKIJRLD0U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6838.namprd04.prod.outlook.com
 (2603:10b6:610:a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:01:42 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:01:42 +0000
Date: Mon, 19 Oct 2026 20:01:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, blktests-ci-bot@kernel.org
Subject: Re: [PATCH v7 00/10] Add support for storage element depopulation
Message-ID: <atX3_T-5osUcVDPh@shinmob>
References: <20261014053337.2328544-1-dlemoal@kernel.org>
 <2c91db255fa527e76f5aa74f020d439a33e89142dc397211579876d34b3db51d@mailrelay.wdc.com>
 <286f96be-9ddd-4378-a28f-67d736237f64@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286f96be-9ddd-4378-a28f-67d736237f64@kernel.org>
X-ClientProxiedBy: TYCPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3449d8-bfbe-4531-c1a5-08df2dd05b92
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|376014|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lIZGopEsXb0NA1L8CEb7Pg/AaIm8J+DROj1L6Osmtw3O/QBMD+Yr+OqMr3Gw4KcX+L+lSS/AXkeXQB0mDxxu9zLn1Xe52mx9oxW9a611Vq8BirLMwf283XFFlFf1JcYK0NYpBJest3Mz/BkMmtl+2zJDhjFYWr2onoWQBuk+otVUEEOYTWO7bHbiWaIrI7tS7Yz8/G9/Anoft0aGJgBVDeH6OcikoTWtO1VdFtQigjjNxz8slAr/zB87HCY8HFvY+xjm1ctZ1WT+Z5QvuWYFHo9MhIL4AsbRW9p38SJYmc5rdICnM6iPScVRf8AR8KE4YWj7Z6PuOHGHUxOZUS/BxoiQ0FgmcrJl2984PRCDVfO9G2MvggDx8EBPvHCuK4UJQVRdxEaCn38CnxBDjGQ/USgIKxVhQWOmxxMwvFV3XBMR8qwNdYwcPMFz05F5qFrc7AIWC4R5OvNZgIAcnKgZMEpCev8spCmj0ha+PBZhznTUt7zOzaK2ipK0rhYdYx6f+om8ad4s5V5WvWJuvtNk1YklgEQ9YlSvMxAJ83QctvwW53xId0bfMwJmwriu3mMPrxfyJmYp9BtUVt4gJq8AUWIEwbdtTdsZhCgn9JXfe0jfihVJvVaDmYbAqrFbC0Mf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfUBzuFHHcXimAj65lf3b/qvOYdZ+yD9sZmekpbmVBK/V6Ft5TqyotjtI/0V?=
 =?us-ascii?Q?eG/0FMCFU0gdQpa37COKB3XSxE3hMDzStkRew3VA6It6di/Of+F3oaWiRalG?=
 =?us-ascii?Q?1CjHbVuM9WYMbAno7SevDtLaeAnBmKrj3t2RAghSXT2ZWV0eWu0FFFtC5Q2W?=
 =?us-ascii?Q?nVYjxD2c6+pBOrxqW0M2VWjf4POjtMi9h6AsikIe/lwzR4V0C4/kSpUu37wD?=
 =?us-ascii?Q?69IOFVsCek+SxmuaUXLdhdk1Xad5Ev2dNLOkRM0h6Y5FOgf3fTxOSGwn5afL?=
 =?us-ascii?Q?FTMi72OiDDcHdrV5B9A0jKX9owhQ7oF0OR+nV8UetyxH6z1LoKjaDhuSmAwF?=
 =?us-ascii?Q?rB9EX+fycUEiIW3GMx19NZLoDLXX+Yv0cjmLJfpX/L1dDIvnDji6RuODZdc8?=
 =?us-ascii?Q?6wTTHisR8FljITWBPta9E8sRz3TsE4p/QsUY5KFkOCR/ErJ2Lk5E2shXg2Z6?=
 =?us-ascii?Q?UNofiilFOmr1h3kfbt7B2z8bUzu7sZjwtJ4PiCYjnk5zYAz70+ZD/H4BB5pd?=
 =?us-ascii?Q?E02DltvtC5wKmOPFbT+D4jmfiYkqEvYMC4MuFKF+aOylEDKpHJMXHMHXi6Hy?=
 =?us-ascii?Q?D1TQ1g4+O61YcjqTcnzJmuDZG6sORbNTKNivQtEAi3kLyfXDrN0wJ2B5AHAm?=
 =?us-ascii?Q?s5AJrlcBhI2hLHdVjhPA34UIsqeb81tYph3hHoL4Py85Xh3GI2j1S4rm03m/?=
 =?us-ascii?Q?fyUjUgYh8/HJ6+G/wxfaXhXYfakmo9KvyqunQbuqJxhXub2mZLLaGe04xbgM?=
 =?us-ascii?Q?cyJjlwCVcA06cOjgh+m2S/3kbPH7FIq3nwtVyY5nzPdoeo0hHwLbvOcGkpTW?=
 =?us-ascii?Q?v/XOFITH3E/ppxZ/jMumJlUMUOyk386bhCyvYpBOLn0AA/TIsyazeBbkTDpq?=
 =?us-ascii?Q?in7KGfZtBzGFjcP5QMlgFoSa7hBikpy/v6JFk3Ey0mCmifsI9rgGMu2MOHO7?=
 =?us-ascii?Q?gGGFG76E51EvL/0xrMWYvIW35LRfa+mldj1G5y48qcpZzcmZ9oXjK46pZ3Ab?=
 =?us-ascii?Q?gupHnb9e0Tu9KhAKKVqZ8vb86Oi2nGYpFzpnMYww6nnagjmS7LCBJFp8I37k?=
 =?us-ascii?Q?Lm8FmNrEVymgdVjrJo8zVWL8tRyCCc8h96uzLEIvYeYxVZfVQQxA7elXtrin?=
 =?us-ascii?Q?VptOEa6aXsGsgkxbXvVBVL0QEgmI/pQXEd5Ev4UCP3Yu+vifMi1JQATOpAhL?=
 =?us-ascii?Q?tVyurRU+klAJ2GeHnnAPjXUtWpqIybvDspvW813K7SpglJt75rV00//mto6H?=
 =?us-ascii?Q?zBOujMVUiPtqGzNkXyhkX3GGd4eKNaRPag64SfAw01jg1YRrovFraf9VWwfM?=
 =?us-ascii?Q?yOnF+RDHGwC6qa9wMcYLYeh5+NiEcSGFyxXSG8JFDj8V50EWssIZTur7cSNV?=
 =?us-ascii?Q?b3AL2H/UwMMql82SCGSmII1ozJvfXDoo5YQQbqyBa+ObaiSdqqsJmKsyoNWY?=
 =?us-ascii?Q?rJ1+Bvg4bt1rfaMzMGRC6Pd+9GfFHO3/wG/QaaBRr1cNojB43DLEoVjA78Dh?=
 =?us-ascii?Q?vl6mU800/f3NagFMp6mc+iejUxAkny2qLXDolEDeAMM3C8bdDbsrG3Hndc1y?=
 =?us-ascii?Q?lzj6IVbAJku/ok0l8IPDB3czdtcwMEwJ49MvPKXGDwLmUBUSLrYu6TABIpev?=
 =?us-ascii?Q?dsSw72ZLOfoQ3wFkpC4jXrqKc6K6mFlDw3tQaLdAqEH9Rec3SK7ZS6eFvjER?=
 =?us-ascii?Q?7PC/dnlFLB2fbIJ2wFQPFZfmxE+kCywR2tlVWYB+72+DOJKHso4LnqBAyRGI?=
 =?us-ascii?Q?vnE8va2YjcEui+BUL+bjbowH7v1DTn0=3D?=
X-Exchange-RoutingPolicyChecked:
	EJ5D6nFY3x7e92B5w39k31x4vsKDllGUM2LCezT001PCThfHSl6UO54Ikpr/fluGmVhHSNHEIqY/QgRpy+MCePu42eFmGmhXyxLQ3oG98jc7Ssn3iQApqlgip80KZEloXMMlJ+sRxGHHSAmWWRAwDStMSIUPQs95XszZYXZJLTOA9R26TKXP2/vMr6yPMjQJYf5IAof0+Vy879KTRNsw+LWnXPML6DKWzQ4/Tx9rEohmKDy5ghNtvoQL/fdFpR6/JDjFAgvxG8FaJC1L4WB//mJJ/teGsS8cz28Ykuh5En7/IMfQjrwLDmgzJ0DTLomj8+CzIOXsxa3G5GM0XG7vUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7qJsnBtWOqlvW+GCAEU7MHiAjwrK3S+Y6lfuQNC+gJT2B8CXIjBo6glnAo0Jei2eDf6d1hFHatPU2u4USkcbLv0ih96xnXLVQjLQhI0B2Sp0PnOIE+60JJ6taKtHtIFHMIBeBE+xX0CgvjkwMvsehWd0x+yzCCAuOF0qKTUlCpogGYnCHjBxKjsBy/JxXKQrv0PdS4aHnAGOGEME4f4RwvqxF0raCx8r2Ff+Z+Aoynd6XnUFh1KxIAbh65Z0PX0uyW4S0eVlv8iVJJH3AYdaKcnjpZxvZRk+Hyq8xdC11itzSV2EMOqYr4bCJAnQXBgog+p+4IpB2j6zgjpFFG85qUJAiy5JeiyhSy1RB4EU17TYV/bDeGbQ8lfu9hQOYq8VKJ1irWq3jZAJgdj5eCLEUrKjX0CRlpD457eUJc7J/flMUB2oNAsOMjpIbIUx30dzx32K71LMo0xoYE3Dhf2IcxvZbR7czxjr9rEXtvEoiw1GTwLWExGAWXww1iHA1zL4ZwwCw9SMM5U3sD+6JYu1hht7YFwaPe9hL0SKfTmhszTaErGDe2k155kyyhHiGhnJbDSlHWEQF4gXX93HuwUPo7UwrG5IzKbcJTdf0rBMiEff6U5k2Kcj85goRIzSUbi8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3449d8-bfbe-4531-c1a5-08df2dd05b92
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:01:42.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guyZhJU8xUdY56MDYaVNzCA4zYxFUTyO2jlGqxRIbrIQqPa0BWz6r3EE/PD7xjkxbN7XKNYHlP2phMB7WAjsCmioiXzt1LH/EAkakfCFV3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6838

On Oct 19, 2026 / 12:41, Damien Le Moal wrote:
> On 2026/10/14 9:18, shinichiro.kawasaki@wdc.com wrote:
> > Dear patch submitter,
> > 
> > Blktests CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [v7,00/10] Add support for storage element depopulation
> > Patchwork:  https://patchwork.kernel.org/series/1185265/&state=*
> > Run record: https://github.com/linux-blktests/linux-block/actions/runs/38517856454
> > 
> > 
> > Failed test cases: loop/006
> 
> I tracked the failure to:
> 
> ioctl(ctl, LOOP_CTL_GET_FREE)
> 
> failing in util-linux losetup lib.
> No idea why. Running losetup -f works.
> 
> Note that I see the failure in block/for-next too without my patches, so this
> seems unrelated to my patch series.

Sorry for this false-positive report. I believe the failure cause is another
change in the loop driver "loop: remove support for swapping loop fds" [*].

[*] https://lore.kernel.org/linux-block/as8-8rDJmUb1FxbP@shinmob/

I have disabled loop/006 for the future blktests CI runs, so I expect no more
failure report for loop/006.

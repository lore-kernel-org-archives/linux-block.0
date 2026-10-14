Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0894DDB35
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979245; cv=fail; b=qnIXoFSUDCS92HyTnX/MzE+ufP2pklOPnLIm3NY7Yf1M9t61m5DFmIcTfjiwaXK7bmmGUZ7Tiq29RSp8nTSYdCijRuVW+oJXjYvZXeg90ywz3tDqcMrSYwy3Fl/RBVgX7cVVPn++XufUmqEfLVLcBcxUD+TQU8uUeR+QC3q+Bjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979245; c=relaxed/simple;
	bh=7FuaRBtpuEj8jpp99wvrxS9D2ZZm4T1WqH6KBcbzKVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HHTmFf5jxNETvl4ZU0e00xXX+F/Jq8omQwEXHq+XN6Y6cQll0w9YPQ6fxO9lVJbKvxhFyRTXA2UsZPRoN/naJ8+AdEKsXQylOdI/lzb/+Rvuuq2usb70Bl4LahzGLeYoZ4OKZ0ZCoFpYPxatHHB1eV5SFHV492BIJ8WgJHL+jaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rh1MEOiq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RQREhiuN; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rh1MEOiq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RQREhiuN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791979243; x=1823515243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7FuaRBtpuEj8jpp99wvrxS9D2ZZm4T1WqH6KBcbzKVo=;
  b=Rh1MEOiqGdgU3FbX+Yu3KU7M7XUUOukYZ4XhzT7dKycEieRN6PqppK2E
   lbtBcF62C8Vp5AZ+Qi6DpgdPefDt7B410mxcEFXtBtwrfbxwUrIbZh7QM
   gfIwkx0EC/106NNw/9IeZcZ3w2RGtXLq8LudwwBiG3ZbvcNR9ajW2El03
   4OuWKKHBoBW3BcIBCDkFTRhDRhlerIOXB6OEi/s4+KdjWHefzyW6LNVU0
   Ujm1kZibYz6LQugSoFZx2/E73hEtxt9b+ahz2UsWtjFy94YxPCoelKorA
   qOuf9zVSc/0FfmMKK4ZGn6IMdcw2WOQ3GaYX+bfbW+Afu5Y2zPrzhLYEv
   w==;
X-CSE-ConnectionGUID: ZVoBRejMR1mxN62ebP8rWw==
X-CSE-MsgGUID: bxdRJVf2S6CKiL+jQfjg9A==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; 
   d="scan'208";a="157961217"
Received: from mail-westus3azon11010054.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 20:00:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdkYstcP6uSmzlaKqaixtvMcVns54+Q/0lavN48BV/ohOhpiHCGRyT3MBOwR3fWiB/xkNQFE3FVaxTKDLJobJiCdmSc7kQVN4lNZ3m4E2qKidTztXTqbADbqiZdRdAqySuRDGKSfI3yqXxRzSBMuI41p+srIcma4nfCGHcirdrWsBCvIjZyHGgJQ30ndc3JmUiufXSnMzJm5xenRAFqwoeEZ2pFCMYg/p5WGpHXsbxAqVM7ugOl3aRYnn2CJyRBCnc+UyKxStvwPpj2fOI3B0Pup26Hx1vDaqL5zmxjWS90NpmvU1ejgTrH8yn+jLxgcmuV6cvsFRvmReILGhhuCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB8CDDlIoreY4ldrxGlrQubCYMtfcRnKH0TLjng7ZEo=;
 b=YvFZBxAtcdTuW96t7T/ZfpwT2bggQwuWraZ+ER1RRkUpaPwhyA3iFudwm6ASrSS8r/QvVqc0X1S0qk7TFyaXH0NBSNRQXOXQESfbUPUc1s/1WvOn6D3q1uc/gHlSV27oX623qGRhHB7T7FRM0EOAjbEQj5mr3dRx/3nn0wNfuGex9rjg96tPvuHGPWMm8oZwRIovfxO4imCxebD6HybijgKLamVs7YSD8exoQLa73vy9WG/VqAFDNnlsKb4BXuVFVctWqU/L+LFe+W9PIWquDyiUG0kzJiSj9wdq8zqsOE52fLDJHwwyWYESvo0QDCpzxoQpU+xrjBfSENXayW07Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB8CDDlIoreY4ldrxGlrQubCYMtfcRnKH0TLjng7ZEo=;
 b=RQREhiuNp67VSew5NU5LmwrF3JwqQlgDh2oHKuQ/lj3VFRt9YQjNV7B9F/4kQUVoXWiVy2A4MNlEiVFjX7JYynnSIoS/B+YHWhhaYJ1C+B4TQVeYOdnkZws3xR2GNuwd5sargxsLBVhpFbIiyNLH4E6nhmte4wCdpfkgkdW7jRY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7693.namprd04.prod.outlook.com
 (2603:10b6:a03:32b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 12:00:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 12:00:41 +0000
Date: Wed, 14 Oct 2026 21:00:35 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [blktests v3 0/2] Test multipath and marginal ports
Message-ID: <as9uktniam6a8cLO@shinmob>
References: <20260828153029.853768-1-jtaubepe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828153029.853768-1-jtaubepe@redhat.com>
X-ClientProxiedBy: TYCPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b6f102-bb21-443f-13bf-08df29eac4b1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9vGB2XnyQEsO4dWlWjyEfRjaPOPF/F5A4dFH1+Lx5axzTnVeIIVv5dar8M86XK2IIc8bsyHrFgiwBWxc1ZAXyM7do22xx7XAuNpFH4k6TCngD0Qjhm7sE0ts1k6M1pRncYSb88KqqzDGVRKeLrDevdBOMJad/h6lVfGXXfASJ3dCP+YkDjVJT+Jr8UlCHEbkM7r+SKaYo+w22nJnHT0byqvCnzgrTIsnvHMgaxpUavIprlmxZGodfWLB6UsT1TxSfklZV7KtfE39lc9h7fKpACbm10hvRT9qFKSM/53GXj1JaCvFR+Hn4YY8FadzWsQZCmBwYJ/2lOIcaB3zi1tWjtrTQt1Bs3TOQOjn5AsaY7EYymn7q3CkbWhV2zXZZJB0CEXEiNw4hZUmm+MV6w2T7fOE3/NJvlJDCISVH/qOOn4MHIgEatS5RUHI8QIwplwJQe5ZRlSXQODQSpj4StWzkktLJyD/PYm/n0oWsqAG76MeKY3gw1dgEMAfHi7aj1HtIsBG80zV8m6R3b2L36iMhxlNqR9z7x9mBD0+uW5GUQyICM9IYy9FoovR9cAcDuhswvttcO2LkRnVyGdYw+aW8DFdsMZOaKiUYf2J522o8rtRzn70/EN5iWdvAlnLJ6pyC26sG+nQnU5F+W9ZWJKwyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7kazgRR5D3wBaUdG7hiaTIF4FwxCsPIuUbAoCoNn87xQOXY4hJ5O1g+zrp+?=
 =?us-ascii?Q?46wIoBX5J9FpLCDdoxIuxZguDrALEOAA1o3CBARInL4U9Z/09s5v/1vN0Xi6?=
 =?us-ascii?Q?ux82qXR0UgEMDKf55h7tkty8OQSusI7p4voLd9iFp/vx/cc6sv8vv1gJZRl/?=
 =?us-ascii?Q?0xahiHBo1RViSc3NM0JIa5bJh7hdjM5WHJ2kwzR2ZqAuxTKe0wM2n8K5GDNf?=
 =?us-ascii?Q?hXOmQr/cvbG9d4alT0xTtMu9dA57x+/9hFykK9xvcA4nCXwb+vK5a13zX1Qn?=
 =?us-ascii?Q?mkI9ZgGs+AfvC6Lcgp35wknfOSeJXKCP5Gk8oI43uO9zOnODrZZUYLefmeeP?=
 =?us-ascii?Q?hEHGi+XsIfhrrWalpST3EjJLmT4b07bbdDE+il6M4czojEyb54T631500cn9?=
 =?us-ascii?Q?BxvarWSzhCkTMmt2S6EJzRPyoc9jOxbFZQfhIslQibFSdkkZybffVXd4S6gE?=
 =?us-ascii?Q?Ax+zQRZ6USPQTjrZDdtrfeTdD9Yfdjv0FvlUqvbfqjNX99MycBPoiuIveUtn?=
 =?us-ascii?Q?MokY1vQyoNFAoPE7+v/T+2Vpi05jvHKaFNQ7ipes61e0bqhXR2w3mOOv76dK?=
 =?us-ascii?Q?ZIVyODApVbl1tnKA9MaZ/0gFkyaAzmidATMoQu7Fogo6rCd2kuWmgdBioIlj?=
 =?us-ascii?Q?C9qeTotPAm0KZfsK27GP+DpTU/l+TsbpoBJd1q7ck1YOW4QiJ/aDfEYkT9tX?=
 =?us-ascii?Q?5TJ/1gp69aCsUVABmX2od3xGCPxSMZvONwmD0SvGpXRQnw8V7RcYueC/q4Ky?=
 =?us-ascii?Q?dr8eqI9IKKF+1pVs1vhef0gIH2KW9oyUOuyhgfHes71JK5/5uODU/1GbF1G9?=
 =?us-ascii?Q?tYd1h7nuCohem+TjPjLVn+yzsCnKOlnYO2A2El++KYy3PajLuZKeMSStUVWB?=
 =?us-ascii?Q?YGq5y1GCkEyXPWKzS/j5XFVF4zxIy5ySbLqPKIWz2o4XLV3ap94Lvtsn7nAs?=
 =?us-ascii?Q?zjmYd0B4sJja9nu3d4abYgJTFoDPkudmoxR1xU26kSHnpPnUfBRhaEDHgYvQ?=
 =?us-ascii?Q?HRJKBmg6wMN0OWZ7MccsALnc+TLPuRTvH6six5yt3CNouMRjwhmbP4sUmCK3?=
 =?us-ascii?Q?eFpY39HpSURgGWjM1edX3rqEPshTmfhSuoWo2a9ahxb7DfzmWq7uu18grbnH?=
 =?us-ascii?Q?/O+TUmC9phFzRZSaiOC8cWRyXsjYMexN7XRlNpjHUrrnG9QBV8qFcWe4tyKq?=
 =?us-ascii?Q?hiYacb7SfRQQKdrtLVIfSFuSbG/BrXaqvJyI1XBKccYj70KEw8oiEE6ax/uj?=
 =?us-ascii?Q?tkfrh07sVsT7qrjGgshJBV7sE12Bn9uzo8J+tGiRQxrmwfbdV7IQAAvt2wsj?=
 =?us-ascii?Q?uhALKWzejCUym68nMT3B8q8LdPSc0wu8KAdaJZ+XzXk/jHpB/Lr1lyVq4Yt5?=
 =?us-ascii?Q?ks24Zcgum53sEa68ITY4BkHTbUdoMLuYa7BfcQWmO/9Opap53ZmUIm17x0B3?=
 =?us-ascii?Q?TB2DzAtM4u7kMbphkoDgQh5apd3xm+5BRiWum2iOmydVxuoSufu1ujynFEzu?=
 =?us-ascii?Q?dPu/ASVkOc9jxFUNIT0KYpxPRyuEVFH+0WP/+6bQE4EYokgQy7OEL7DPTI1r?=
 =?us-ascii?Q?nFF4VaG1XkQ3TtDTW+LHW5CPiTView7oslGuKWqmPeqrXflmGf4Om4U6KVjF?=
 =?us-ascii?Q?UWCZTjEgM1HtIRhbw66F0oHzpBKpPirvOuRIJFgBFNvw/aVI7uJ6UIpiNVkG?=
 =?us-ascii?Q?R2IQy3YEJG8JaJGz92NT0ws3jo/8W1YtINSlSFqHLBTFcFj6kQUMMbnimlj+?=
 =?us-ascii?Q?gnDqFshvMeFMWFoPXABpjCT8XFTC4mU=3D?=
X-Exchange-RoutingPolicyChecked:
	OFJZ1F7oEmvp2oqyWa0DyWqe/QgM/dtjJuXYTJQYRoWB3yExEo/VrEHAZUaIuOCp/R4XK40LR6dgO64WI8CNDNuZbEbcQzpsiPBvaJlnJ7byIQ2kv9NLhd2L5ezwwWn7Ewu7zdOzVcdyltlb0F62Dx+qX8sCfSfs0vr4ZycBO1pjTTrIWVBH5wEs+Ap7MZCvBX9J1OYHJ6XqfiNx3Mpr7UV2O7r+h7tRb8szti5g2PdePVdbw3qHbjIZPrvELtvG5ii8XKfkkve71IZ3SZMgMi7EPZ5hIczdkpgfjeqxGj8MhwpGdtL6hbHxJ+1qeBXlwKMSoD1Si7+TTY5cshoNjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cFOPansb9WCcQB4yKiINUInckqyl14LDHrw398kLfYsJBPpV4ErK84JLdL3bbTzpsPiH1g4YBZGjybG5IOBc2YfR04yyV4c1Vj0RpJwIx2vBm/XdvAfNtZsS+Wru5DsGbffMdBsAC5pHM0E7UDq+YBnYIik34CuVvbC4zjyyPGUzxMU8HVAoUKSmilEUqbMKBd5M/yrp/4u/i1fwtz0KxrotzyVDcM34X/TStQ5cLKyXDKucHio6+ZBcq91rHpxDlfZpxEFiHBlLzyeQzzUsdoFcC7SEws6Iw0LsRUlQxH8aoDKMMgTLDXjmNMYRKL3AbQ4mKuUIXtRxvX8OWEy/xaMU5Dm6psgPGfbSXp1u/kWEjzqke5JYhM7N0PBMpOahNH1cMdJHzoxPUGkeYMrnjrYGRFEbLRezp1VYfG+0ExrEdXUDvfyNIAz0G6o0yLDbQY62K2CU6invHd5103MAyJiW6mK5BTYjEGvHu30xf3PFhQzxNI0ErdO/E//unIiUMDW9EgOYxU2Te4coJI38ueW+UwS2i+GQMRuwWFEVmbe/DJdORR2vF0y0GPLG1CmyGil1ep/jOpWGXCCf9cPsoQLuFqhHHsXrj4dnVl/o+d4z45pdV0velURB8W6KTPe5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6f102-bb21-443f-13bf-08df29eac4b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:00:40.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afjW8I8TA4RhjLGB4zCFice1B2BipEYfjtNY4t2fiDxFJViu68WiiQPINypjWeEKOXWWwLBT6gS/yhjAm5kKVF05NEhyOtzNICIO0c6pc74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693

On Aug 28, 2026 / 11:30, Jesse Taube wrote:
> Tests for the upcoming nvme-fc: FPIN link integrity handling set.
> It tests for various multipath and marginal port
> scenarios, while confirming the port usage and state. The test is
> intended to emulate receiving an FPIN event in a multipath environment.
> 
> In V3 various generic link checking code was move to common/nvme.
> This is so that it can be used by other tests to check if multipath
> working correctly, even on kernels that dont support marginal paths.

Thanks for the v3 patch. I applied it. Please note that I renumbered the test
case from 070 to 071.

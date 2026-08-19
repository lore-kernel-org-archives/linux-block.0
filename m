Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A36372071
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127692; cv=fail; b=Mh31IexkJsIkbLNoiuOVOEHmhXph32BxlGaSKEy52qnJ2ZgzkgrShKrA1IjdzJtCFbB41ZeOVWNR6BPNnmpP07wifLG3EE3e046s3nsTGt7irg1XdsHjr3HbgRnQk7o+4ocduq+rZUGhDD0Al5vGYPcdSByWEA0e/JUBZHW8J2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127692; c=relaxed/simple;
	bh=WbJt49bCxGkYEDMg9j3fX48ldGj20PhXjvJqH2T7n3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eg2Rx5T1hUuFemwbuErBCltzX94d/RRaN1OI+ax0uyFfBhs6DT2970I4ki7dhQcSlcgDy2ZeveH542ovtK8SDxtOSnlr9CpCw7DF9NejJuNAXdi2PE+ngN2WKFItfGqnolpLDZc/48t46QdCQLOAVVx7SUqgLuTOBiJL9IS2CVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YKBa7Rib; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HjwfVzyi; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YKBa7Rib";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HjwfVzyi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787127688; x=1818663688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WbJt49bCxGkYEDMg9j3fX48ldGj20PhXjvJqH2T7n3s=;
  b=YKBa7RibLfpiA/tb3H1N/Srtx3yUvNX0ZJRJ6E1zo8tSVagJIZmTm4WA
   0Sxapnpdbx6D+PJ60NVh27QsqBd9yrzA3js8/8kjmzX50GKBBHwMZVp83
   nr2KvqjwiC1ZPfIyt0BV0x80grcWdv1QkawB7/h1Tk6sRjfe9nD3bPnJI
   QPYTuOEBpA+yxFVlCJYsXZIXrBOZ/flaz54tt/lmhOnuQt1yzFCvxelW/
   OZ1+6nq8z4X6w4MSR/z600QNqIzjCyVtD3csAnsaU+VxRNtpvPtjdmrHf
   9Odw0G/HdcQxYgu3AVbnI0hhJB7+L8aKsJBxz8IxymzyEPm3+TtKcp3xm
   w==;
X-CSE-ConnectionGUID: qyz7df4RReeMiSHFcYbedA==
X-CSE-MsgGUID: CX5f2Ts/Q6qrvMkrieKP2Q==
X-IronPort-AV: E=Sophos;i="6.25,231,1779120000"; 
   d="scan'208";a="152260878"
Received: from mail-westusazon11012071.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2026 16:21:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv1zH4ctd+beA+NoeQl62T1CnjOQ93klSLQrKJJ38pOP4JwcsUe1rOBCWot/Vw4k7hfBKIZFjp6BO6cLZHux+foUNbLnMT9RBeGZuTGBtVFzAnFV/y7enOqIRlCIqgQ0OqZIDEPUwnoNxTzJ8eJIsdeVMqXLdMlt4v9BMFEntJlHquznR+WJf+7Ve8bTMjz8kKPl+Ud+Yz/Qswyst4XQyF00WhRyuaOV0rdaR5mfsRsKT2zGBbOERq+u7jUbBTyJ2DAvQOQE419LD+uUv2fEUQcFD8X+AwkKbVyhGS7ZbciQTefkPJCDCMOgZtszElXGtf/R9k/XoqAexibULG0CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onD0mSe7EFOw6Rhj0/JdU1H/e7X101bm7S642OM02LI=;
 b=lOnKLhBV9JojkBJNm0316Ts2RDbzdXNwMo1qhaECVSFB+1uawJc+h5jSJZeirbGCvXp3NzJTsNq1Vz7Xz3TWMtPC6K1fQy2dpCsBpQBpheE7lpBcWhDoP3z1HKX1Makssov8QT0MQmpKcALAMSGciHUWP6xEerHxujFenfTkYUJ4ft8i+h4aPw8jRVuOnOsIoiWQBiiiBvQpQdb7ImkHB8j7p9B4gpymsu6vwK7kuuBByqav/pEuChjMpZyFySxsc9iwVVLH0K2VnQVa/4RPBh3XYeaptECdNO/ZS2XP8Avm/hbGcw7pc+FGbzD6ygvsbPU7rDh8PUrgJgs6h7oTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onD0mSe7EFOw6Rhj0/JdU1H/e7X101bm7S642OM02LI=;
 b=HjwfVzyiLGhW87Z4kQkRxHsYAiPRWimXYx0ircGiSutL4o02HVP1p2KiHK6TL/bVZAjw2dG0zWvbZqsvWppVTtfqajn493O1bMNYe9yf5ExrTK9PqClwNdlQaLRMpZxO1Q+HyLsgvhIm15NZagnGbvUCKjeEOy7rLex68tXpzL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB8094.namprd04.prod.outlook.com
 (2603:10b6:408:15d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 08:21:25 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:21:25 +0000
Date: Wed, 19 Aug 2026 17:21:19 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-block@vger.kernel.org, dwagner@suse.de
Subject: Re: [PATCH blktests] nvme/070: add multipath command effects log
 lifetime test
Message-ID: <aoVkX-G5f4WNiU8e@shinhome>
References: <20260814070019.3860097-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814070019.3860097-1-sangyao@kylinos.cn>
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb3a6b2-dc2c-4aec-2ca8-08defdcadbdd
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EZDL98c37aO8Ic2y+WqvMsObKV72Of1OoLlUC9BeLbH2MVLprAu0imNKU3HLFbJacmdwGmvwAUbPqYh8tlLNhZvuHPDEZTCqZirgnG4CySs5afeChfSJzZwCvSWJwDzVjyp9M63Wz/8v7x2uPWPfR81TS1XcWe9aVoAEQ8+O1oYILXp9HMc+BIFVSIop/cQYE28ejx03c+d4/eZ6800nZJVyD1gpe8vFwWps146IDHVpGmvj+1t3U1+Y95DAzfAIOCT0JI63qd/Ai8PAMIRqK8N+jVB3ADpF5Mk3ENIXhvHNlBK/rbnbtvOhuUN4L8dvae94bLr0obwhkq7dmje37cGlwg9qchgkCYOWeCuetssxNMg9uWvp/mDZ+IWJMhYRLUZ5GcL/DtVVU6a17/PoGrIImhXfttXrDREYBlhlXgXh9VDmy9LrmPwHmMuk3g4ZBeMe8lMzT84ERNt30/p1fdDL7dq1qcZWL5Z57GQ+nZLbYmypFHOJ/Lo5/ZnXHfRK90GW0X0Ex70V2aAVwS/dF9PRPMrhXHUyBqbT1qaOWrgLsOsoT05Wkt+mC5kMzWv+kJewjIplueg7Oq+zYQunbIMeogu9qct/jzutf4BnHj3t3zHTXpXLKLMDgrwWsVK4VJ0xTjZ4roTF98zrZKJhLhZLCjVPuFAaDzvh3rBWwks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IwyC/cbWFtcW1qZngong7UtoigCQZ9dRtUbzTgd61GVoqF8AUOLkMFPFckkj?=
 =?us-ascii?Q?NGChc5M1ZnLEVqSELdF1vanrMVVjJpxyfpeQz7LcACoVe89iLUvHPXGYjh9O?=
 =?us-ascii?Q?tRvHov23rx/2FIp+DKGR0qpjp1VR+7xeQVH6sO2O1/ff5I86wBA3PZP0ikfD?=
 =?us-ascii?Q?HQFdGkXsJC9++YGiXOIIzJQFYZjZObszvueXeo8AD4TMyujtkfHBMrgVevcH?=
 =?us-ascii?Q?4ClecLQertQ3E7EPXEmMgZA3RElA49o5hTS3rb3sHay4Qao11Js9IA77Rtpz?=
 =?us-ascii?Q?KeXlI900/Yi1Zy8ZxchktvgLpNqrJLdmjm2DKG9iPxo5i0adLmHOZODFmQ10?=
 =?us-ascii?Q?YiODXY5uOzEQGCcz72YE5o284ZQTjUQ8WXbJ6QvGKAictLNorWPkzWYqcfyV?=
 =?us-ascii?Q?xu4jnSw6m3+4dHqMHYSDJ7ql53zVPOlRn3BKwFe1Dpof2jAI5O2R/HBk2Ser?=
 =?us-ascii?Q?gTbllNU3AvywDa67CFWZH38i3+D+yelbR5yihEaAeOUWKNwBNGX6w5udBosl?=
 =?us-ascii?Q?iWhQxMdglZdZwIaCeGdJa7Yo+clInQFAxDm6tWwYUuxPGaKL1qDbVpodfxIa?=
 =?us-ascii?Q?JtDfFed7oW41oz0t35VM4mwTotDwcqNHOEfphQaDB42fS9lLE1kNtUKvzLVp?=
 =?us-ascii?Q?J+kgyU6U7/zYW2RVj+ox+nhkqWiisvt8diz0hQdjv2knh7p8aJ3tNxgshrkL?=
 =?us-ascii?Q?BPOV8582UbTrCVNW3idpZMtQ0G2UmaCkdzX/awbCuL19ZR+Hh3oYgQC3DgoO?=
 =?us-ascii?Q?gPB/erc9L+EC3dvXfKKoWLlDqX/HQaFzQ+8HHx2Ny8MldYCD7iwRHki2FSfp?=
 =?us-ascii?Q?EYVPPE80BqTv0IpJL9Plxk18hraT0lry4pKCh9MbDjj7Xk7RZuBAiBEypem6?=
 =?us-ascii?Q?aMWN2VByWlstVdL7zMwNKnFi7L3laKgMfiy5Ch1SetrDcwrm3D3YC0Bt05Y7?=
 =?us-ascii?Q?qn5BU5iMhxhGlb5lklturb0zY5PKPgnloCfOODdKDPOOlUswPjBVHdbe69fK?=
 =?us-ascii?Q?PuJl9Zs+BjyT62wRdXQUW4GlVzXzoFASoEoyQUjIMn7x5feC/U0w52eaatLp?=
 =?us-ascii?Q?8NhXFslznMATF+ivWQvGjv4CQAFlnuiNC0ajl2b03N6IPAjYk0s07IPyaoXY?=
 =?us-ascii?Q?Ae+Eg5Oa5TMvcoOjo4zwbtzOlYzShVr2qY4BSoxAPL/MwM4+I86oOG70SiVJ?=
 =?us-ascii?Q?tXFmZy4lxfrfjCdIVqpm9dTluI+235mM9X6q1dPbjYBEI97k0LcXEe/pogjH?=
 =?us-ascii?Q?jiBAzzrqkj4ByH0H9tUsykHu9+8AjRnjWyvyQLD9oJG4Prk5JFT005oX+Ubz?=
 =?us-ascii?Q?1MYcOrtNQRlFCxB+sStc96FwPCi1Sx0Uh1l4u55rC1hX3XpB7mP36iz8MGJH?=
 =?us-ascii?Q?QtbJ/cN3wHwy6hb2QcEZBBH5hZh3c+ngF3ZJtZxfPUGNfkjMtZTbubIFNqE4?=
 =?us-ascii?Q?cr179mKUpc9QgzEg0oMDEyYx1/YfbNAhOkv3x7B7j2fWkkE7H3XEVcwRLgCi?=
 =?us-ascii?Q?ovP5B0uB4q6p3RtRZqfPb1NXI4uUC40wYLncN4iyNx0pi4ak19ke+oXJEuOE?=
 =?us-ascii?Q?WBYXzT6+ICL38EN5JUJRpJNrgBUYqLDDyBVEGTSBoO2oXk+BOB/YXiJ2tlIF?=
 =?us-ascii?Q?C94c90xoLXKUK+Ge3e5YHlheCP07quKazxxMACKbFAp7ZH5dxTy3g+aIurTd?=
 =?us-ascii?Q?ubV6WYgelUh0NJjfSIKD2d/XgbHctjD7P+B6BWwR2hqVeNFXgovUkidANMCp?=
 =?us-ascii?Q?UH6R1KbMzJNSMLffbX+6MJ3AX04dbFA=3D?=
X-Exchange-RoutingPolicyChecked:
	Ld7ppAlWT4O6rFCdIR9kzjRm3GWGhec9VYGYgDORsU/+vyfQUFE3FER80DQutRGLTw7/VCZyDynbGBDbRMM2XcrKT7xCw9RddohCIkRArmAVoQRhN3UVi2WBWJQ1TUVPv3Buo2LEUmQ2nl8bZCCD3RIMVqPZWjJ0X2lBF7IGTfnv8eeddWdbCPfeT/nJ/g0eZcfIfNVaL1ksJT0BF3purqKQhcbXKIWLbz2dctMX3DHLylr652Xg/HHJ8SwpxowB+LDCGO9KqcV3YoUNk2iHf/6SJyJyUu0jIy9Y3EsPVGVDDD2S0lOoAnfA9f6SozR0yMc044yXTJJnMLqYiWZ4Eg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oCcrq7e5Oow02yOblBkr8HAHbmN70R1x/N7rOUq8/oz5gwEmJilK5A+f1IcC27eUShkq0JEYTf8axuiQQz7cGPWsnk9ozeV+I0qVWeN2jj68ck38WpLsGfKslX4GJ44UOMErHpug14bB2iTuGGGKoLzQChRGRMD5ljXnkY5UMfxAVfgYkBRcPYe5nrw+w8WTQDrTQKLS4zK8nXcpgx7X7Q6OG6KdPrfi1Ii49hpT2Z7kR5eCTVFctJ1XbOZRair+W0hlfYbZx/zTm7iEYU1iWMne0697Jx9sOPsQ6y1bWCoTtPQgUU02+JnM0Tbq4EdknR7o/eDvz98iGPAKD+xOH9/2lsVlDSjDhV9HOPxxoCQPA/3cnTFHYajW3IUkRqR6h3bc/236ApH7V9nfbbLZlioeVG2ZpZMbmacLdPUfy6BDvk+O5NkRCEoOaleXRJh02GTwJSadZydLbGJNq5uW8MQJWKQr/NJP1WenbUbNYEk2bQXFnZDGX1ao8woPwYzhYCxh/MF7xcuhnQnTiHAL3Y4D9xCeqCNt7gPieKphUeAjPJFCL8SfXBkwDmYWSrsLw6rIDM/8EPY+jL3Hj+kGgDar9vJySWQBomRYTo2n/KGZQ4BahRg+n7+lMGLdnv0h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb3a6b2-dc2c-4aec-2ca8-08defdcadbdd
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:21:25.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2USOIrlg3NvEdcr8T3/wT+7UiaOYVIBD5oiELUvIKfcuZEEsZuRwYlhu2IKGcpc1E9dq1jYsgnLe3POo2oskm8IhOoVWR78oMYwrqnG/OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8094

On Aug 14, 2026 / 15:00, Yao Sang wrote:
> Add a regression test for namespace head command effects log lifetime.
> 
> Create a two-path loop subsystem, remove the first controller, and issue
> an I/O passthrough command through the namespace-head character device.
> Kernels that keep the command effects log pointer in the shared namespace
> head report the stale access through KASAN.
> 
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>

Thanks for the patch. I ran the test case, and confirmed it recreates the KASAN
slab-use-after-free that was mentioned in your kernel side fix patch [*]. I also
confirmed that the kernel fix avoids the KASAN. The test case looks valuable :)

[*] https://lore.kernel.org/linux-nvme/20260814070651.3973067-1-sangyao@kylinos.cn/

It's the better to mention the kernel side fix in the commit log above and the
test case script header comment. Let's wait until the kernel patch gets
applied before making the changes, so that we can note the git hash of the
kernel fix commit.

Also please find in-line comments.

> ---
>  tests/nvme/070     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/070.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/nvme/070
>  create mode 100644 tests/nvme/070.out
> 
> diff --git a/tests/nvme/070 b/tests/nvme/070
> new file mode 100755
> index 0000000..39195be
> --- /dev/null
> +++ b/tests/nvme/070
> @@ -0,0 +1,57 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Yao Sang <sangyao@kylinos.cn>
> +#
> +# Test NVMe multipath command effects log lifetime.
> +
> +. tests/nvme/rc
> +
> +nvme_trtype=loop

Is there any reason to run this test only for loop transport type?
If not, I suggest to drop the line above and add set_conditions() to
run this test case for all transport types.

  set_conditions() {
          _set_nvme_trtype "$@"
  }

> +
> +DESCRIPTION="test NVMe multipath command effects log lifetime"
> +QUICK=1
> +CHECK_DMESG=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_module_param_value nvme_core multipath Y
> +	_require_nvme_trtype_is_loop

If this case is not restricted to loop transport, the line above will not be
required.

> +	_have_kernel_options KASAN

Certain amount of blktests users do not enable KASAN. I think this test case
is still worth running under such conditions, so suggest to drop the line above.

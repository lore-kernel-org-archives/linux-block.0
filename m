Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12C339363
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487916; cv=fail; b=sVCJkxL1mCO7UrY3yqknwyrGjg45h97M2i59NVucjw9/g8mP3A8BP5gas1sWL0ltSzU7BNURSf5oi5UtRN7CKATp1prsAb5qfXbjigVp05tlRsp2HjHLvuYMjeJ/ImV0DkcNoPU75ZKtoGkXeH6n2blW6MMrDAqLDHlK79OT34w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487916; c=relaxed/simple;
	bh=MfaNou+R/JKiCBHPX4MCmSXwL9Gas7QYC4nHlhQ2giA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVENHH8s4Fmmts77cl1vWoXtvXcpQTTDZaKmeVsrCKfk9A8VLN27Ghr6mSqjarpoFnXUyzM2w1oBZENGU75BDJTArinl4sQQYSgeXa3N1xdmPU7Ji/0HY+VlXNrI69Q00242vzpKTXBGfawJ2bAu+BVqKCYvi7dReNr0o6qPK84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bM/HMcIk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XLlbm7jq; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bM/HMcIk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XLlbm7jq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787487914; x=1819023914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MfaNou+R/JKiCBHPX4MCmSXwL9Gas7QYC4nHlhQ2giA=;
  b=bM/HMcIkKb8l4sWE4jPCwsBJvj8PQRfxV8xAL5kc0xyCsQaoBGX2jgRk
   IBmhWYUrQb1T0aqT00HWnGuX1RQqZBGY/J+3BNb6PY7kOMW/v1/06mOpI
   EzWpIau6OFXDsnQ1DbZX4Q3xUyFTZbof7Him0RSQhnKxD+2I99nN6eeh0
   sBaBYOjkcoxwExlhy3IBBC6WQ+LHOy5/3YQ7JVr02H3+TjFM2ZL6Ulb7I
   mA7/AxJdnwTKJTq2Ak5ApGsBRQeSRQtDBHHCcea97Zxq+HOlFH2/LsiUS
   ikpK7PBLVojlD7ynXw3uE2oaZkXOpSzj8SDkpPj++hQt4KowfqvLOSjgh
   g==;
X-CSE-ConnectionGUID: RsWZbcb1TSKngWvf+BgEYA==
X-CSE-MsgGUID: /leYNcekRw62zWcqeNbY7A==
X-IronPort-AV: E=Sophos;i="6.25,238,1779120000"; 
   d="scan'208";a="152522237"
Received: from mail-eastusazon11012001.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Aug 2026 20:25:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMor05qqOqJMonn0+6cFTJ8Id4yJceqCChgYJJWJ6LKQZ35zn1F8Qn2pS4IARPRLCIhgEBMIplb5T2zUpMV5rszpk/eQMu8fYjm3mtfr9AkDPjGjdT1hIvtLwnY+jIFqN2kBPGQTxxcY4mVtJZgadH8OzOedayACFLJANsXG5WEUMxxVuInriBKcsfeXZ+4qVV4rYtuPqu/RrK33PVZHnQRgZ0GJLzVelxBbST0p9XiScuH4Gok61MPZ0UoVf96s5+qh9x4V4nc1M9hURxa45emENjaG9rIKg7yKStbMwCYG8YodsCmEjeDS+P4FUHT5lCmJePUc2XLgqSmDFAkcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddm+zVnUj8q9yCBEROwNy5uJPy/o8rQ2ZZQxDAqnxv0=;
 b=EpwPjOtBJwB6CznMtDmU77SpJhDTRU/HUEZMzMae8vlWApK5P2zPmz/RZef9eW7KBV87l/jLCj78X0QFczuQaKsruIsfdy2EbCfuzhpU5xkqW4MVtXZOTPdtYf+HKN6PLQGv1B3Ttfikkl2gnvnI4RjW3spRY/4Qyl12xZuDXVYdogWvPDqRrB9Inc8CXRL1N9iZAiozRtPeO38gBjaMq8W3Z2/sFVHEw/urY+PXatpDM46tF61plQtHLCsTm6T9NDKy1ABFzQweFSsY+aUE3t5vtPXxioX9lnN6rMFzz790BzVW6ISBG9zUp1PYiFNUDgMRT8ZnP4xY5Xou1e+9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddm+zVnUj8q9yCBEROwNy5uJPy/o8rQ2ZZQxDAqnxv0=;
 b=XLlbm7jqIPi6MafabGlsdqaRA3pHg5sXwT4IyLjwVn0NxGmQcYcm+a8hQGJ4Mf41Y5ukVROsygbCc6F/myPjCuU268PXL2dKlzcj2kpKCt5M0PF6b1VkVBRNkJPrijExvzHX0jfN3Ld1k2eQ8tq1sN4LUxS1JU43rsl8IQPCc4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by MW4PR04MB7395.namprd04.prod.outlook.com
 (2603:10b6:303:77::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 12:25:04 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 12:25:03 +0000
Date: Sun, 23 Aug 2026 21:24:57 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Jesse Taube <jtaubepe@redhat.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 0/2] Test multipath and marginal ports
Message-ID: <aorlybK-WA8TEVUP@shinhome>
References: <20260819200425.194743-1-jtaubepe@redhat.com>
 <0d3cb83e-a4b6-414d-8756-fafd4a8238bc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3cb83e-a4b6-414d-8756-fafd4a8238bc@redhat.com>
X-ClientProxiedBy: TY4P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|MW4PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: d3583916-286e-4fb1-afb0-08df01118ee6
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|1800799024|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qQJDR4SswBhsxe+r9L2utATGfNIhlobC9BNejMGfFsu/eDFUn8RP85qXrxjvM1lXusBHJ7Lbm0NeDmUqx1DQeMmDYua6uiV2RDwYklHux8EGYvE9BIm1k1lEYp6LVVNgxjHJL9SvV3WPGrP26psyPWj/9l5t5ZN5n0WlQCaapb2TMnyzePewsx3cgPRVICrNwXYnLj68SoXF/OLHKdmQpcwisj1r/WFYMdrFLomNAANlwwTjbell9eTkxXOvB2tifmyTosm9Vv9zofBCD66BO8zln3f7DdLftlMAQMve8DAHxf75M3NZOx3I1WYPWIRlvmnKKWw8kXKTVe3TpAjWQl5G84psTYOhZnEkAvex5SDQawi9FkXe/8whwleLyP+DRQ11rZw8NC6CrRrsXbejCV/7aMAHklHOJHXb95p1CYToY5A+DIJJfCJM2JDiswI6R8P/CdlNz2h6TZNcc8Abg6Np5vPCtAtXPOXG1cOZZvIrvEqcD61kNk0BbwxnsxMJOi5TNwJOzyc52PNC6SvuwCRzch5DedDGSeZlmk3uP8wVbmmk3L+SE7d999yR2bOzyTzqU5rs4bOn62dlX/ks2cyMt5e/CG8PryFU/toGLWi/OZPBZ5AqYov1zmSDKMeS9hWmuhmzIPySXY2YXxcR88W1Tjk7VJtLi2ttK6aveao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YAWCJmWtV8OV/VMYhYYK6Q/uBl4ffpaR3haTchR0BwAsP1qJES5cNHKpiav?=
 =?us-ascii?Q?OVEifLuOonLM56xdfGQjsyrktiLX8gSX3CSdQcYVmkdmwkiWc8oBIXTf6xfP?=
 =?us-ascii?Q?Vt4rEAoRM45jg/evy314OOZQVb7OzHECedA9/CeF2KRP3Sl5/2BfJQ2MwIDe?=
 =?us-ascii?Q?dbHRfC9k0I1gaBiAacaDJCbwRcbXcE3GM4lQ4KZV5BbnrZRRaIK4JnVTKUJ9?=
 =?us-ascii?Q?FAsrLTVaPcV63nH13Op8O2wPHuMcPzF+CckDEQ6bsuY9OhjGKkHQhvU9rHDs?=
 =?us-ascii?Q?tUTQy4tPE6e9+lXMhvXIOCVidv4t00I7Ru2B+SPSDwrA199TbbRhGAw88nZO?=
 =?us-ascii?Q?gjkxZ/HVXm8c7kwj7iES4lkFwKCO3gij08S26JbxL8Pn26hu+08A/TAJewYB?=
 =?us-ascii?Q?2bSRNXkCLQHLZALujZNcJlJbAkntWTrhHKgAitvBVBlWoagjnoMTOkn4SbvU?=
 =?us-ascii?Q?B436d7O2icOIFNvEewrJPbeBHqCHYFak2BcYu5ryx5pWMwTqOuh1nDCuC7oD?=
 =?us-ascii?Q?8TMeiHmaKjwgMxzFtc4PPubQR4Ai8ogpNoK6ra66b3xyG0c8t9yOriRvHQzG?=
 =?us-ascii?Q?e/z5fxRFDiie2gEi3oE2yeUf+aqm/9EEyXN3HKF9RKdeGS3xWzI4jrdkteLT?=
 =?us-ascii?Q?i7SaU3CaY1YJg05TL2jWqr9KQRdFe7Qc+aFZWVap9wBKWKIn1DjQ7Z7J6SBc?=
 =?us-ascii?Q?tKJOeAHy2l7QGsI8I+4Ds4O3cUaFuFHRvg2YDTLlQYWeJvEWSvxAo0ad27WB?=
 =?us-ascii?Q?yKKo95a+MP3vd1t4T9Ft38eotGBSN7PS2BxBKScsKOONAM7MhrFpcZXG7dHX?=
 =?us-ascii?Q?RknSgYloswtz1VBqNfLmsdke/8a9nKl/xJCME0hAKiskqYqGwp2jr13UlJc9?=
 =?us-ascii?Q?+U00XD4Rom9hsUp+r8HHTLL7Vs0KRCftEAEVTnd0OQTWPNMMu7AcecyyP9Ek?=
 =?us-ascii?Q?pkc+25ookGFhCcxyQkfBSWdPZe+9NXF8c69qDTeu+tLhOxlXfNiPv7f1vmAd?=
 =?us-ascii?Q?DUaqJWP4urGOeAlxmH5yy/92f21m/u6wV0FmQ9oax1PNfBtL+q7+wqJRKDOX?=
 =?us-ascii?Q?OxKrYl6ganul1dRm07/hEujb+j6KtIt7R+gfjQeIfRxrGAiYMqvxCl1GKDDa?=
 =?us-ascii?Q?16My3g/tt32OMy1erWL3LmjCsnuNaUNnsLWuDLB5I5OQH1RgbsDgrK5NZqGW?=
 =?us-ascii?Q?iELYW63uux1vRc3/97mAcK/UF0YuTzmDarERn0xQ37ZDAlf8V/tazv3l05Cc?=
 =?us-ascii?Q?DUcZPguPXEIk5LIV9Vb/34iDX6RCH/gQAqaawIEADUxMe58nHQcWgmkeZJjm?=
 =?us-ascii?Q?NsKcJyLaQTWtePvU5Gx9gya8PumtnN8c8QpQT1VkSOL/ik9pJpbeQdpkmBlz?=
 =?us-ascii?Q?qOTtlrIrcVDzCkAQQ8C4jbKYl2jjlcQCPfNsr6LBwLFAc9lEnyzCx2CsDtSi?=
 =?us-ascii?Q?UdH4DAxHhuzC2LMlE+gSelYjfGpF08sYkkfCFeNjrKwW9o1ZE9ebXMyqtsab?=
 =?us-ascii?Q?ab9hMes0AbAtMS5ATkR96KkrpWxRdIERncgWmKAldlgj1IDwyCKCDPVDkV+D?=
 =?us-ascii?Q?SjwcrV0k/OXY1eTiv6MA9V5NI8NIKzc04w1Nm6oRK4dxSYjBAVFdvbsa6B5T?=
 =?us-ascii?Q?3GN0PZAmWNpJ/EMEHWfHW3vjBLxUGS1B/kE1/HZXjfEgEWDOmqrd//MjBlFB?=
 =?us-ascii?Q?Ufgm+4g0g2U3FVxPUNrg72mR9wR5/L5rMrJ0j51iHsWNF9UTw/He1IG03Txx?=
 =?us-ascii?Q?YcBt3OBBe3jzcA1ybCA5wgzlc2Fd/bc=3D?=
X-Exchange-RoutingPolicyChecked:
	xWzEWAJuaz2LkTRd2A44WW+CV6HfnowbA6hhXYD9EIY9BKmaIOSs6hFJRQQWKwDtcV6KDVzkkae/84K129f5unGkqTP4IwQdkUnw8PatdkEdZLAFzGPRLpLhZGX2rW1XARMLBzukzgGXuwajG7DKSsr/IX71/UDrmqlLMSqEvs+s3iQan9BqhOZqKgK5m/OSB4nvUNxVzLkgzEEHuD/YlV52YX3o9NtwcMW+8aXla4OiZsnT1cjFDBwiqxJzRZMRBR/NeQtWtF5VL9zaUKc2I7tgE44MDkSR2efIL81EaeU3FfHLmDFmRrXnQe5uyc1E0YQ0Z47NYQuJILM9DG2o3w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sn+U/QYDPw3AjR8aMY08KB2BoZCVjgJ5hKIRTcWOnGW38fnGaq+9shWHqFB1T8VHvL9j39RxHT+xbvGx3vZRUcstoJMe+KmvbRlTwXuO4b1i6CRpDTKvmUmcd15IKm03DXWpbrlnH0JcShbkBj22SNbKm/yRpIiXHMsPmYj0gUD12VsWpqvnmCdhAMQlMw+w0bHwO3NpF+UggvgQYsxa6fYjAHM1dHGuklpdAywGVWmtDwWqM1t+bNl3GY2Xd444DH0sHJdmFvd5M3Z07EHh3EtdOvITRZSJwu1ALiEzosEyhX9VC7DSNXOI4jLRuEih6w/64M+r7H8C1yscjKIHd6bJQ4eogaGMqp/d5gOIsShsdevYcZhqSq2XJToItdM0Bi49m8/GwyWgqUJ1KgjGW7ZNHdvmg8AfeI3bg9XtkN8CO+1zLu9yKV40DjXkvWP4N9jVQr9zhGaXLqDzakban7Yg4gH4ENoU54R2WoVAEHKDwh7t9LrrbhNCR+qB3MHY25OaQeR2fiKt7APcu+m3Qfc54uRhba4w9Mh0wmo16i0uJ/Zdr9c5U7KnZ+zazSbr9iPbhJLQa/CMiFQBGD15HYw3thzCbcKvHUvAZ0Rb9TuCsM4rDDf4laBjehZEDTsb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3583916-286e-4fb1-afb0-08df01118ee6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 12:25:03.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPlGEK24Yi4lWxiod8j8rRmtsvjLNcKJQLsggu6PTJ0YgPQhWTljsQpmOvs3Z3DKLMRkS1jh3UrPUMCJ4MOztw70OmLOm7AGGCq9/etkwug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7395

On Aug 19, 2026 / 17:49, John Meneghini wrote:
[...]
> So I can recommend that Shinichiro test these patches with the current upstream kernel patches:
> 
>   https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@redhat.com/
> But there will be another version of Kernel patches and a V3 of this patch set will be forth coming.

Jesse, thanks for this v2 series. The blktests side patches look good to me.
Also I ran the new test case with the kernel side patches on top of v7.2 kernel,
and the test case passed. Good. I think the last piece is the kernel side
patches. I will wait the series get settled.

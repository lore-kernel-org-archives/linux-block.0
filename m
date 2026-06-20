Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD89175A7E
	for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781918814; cv=fail; b=OXdZ1+e0zCmLhN68qo2SE5EosyPxmLLxaKe6AfA7KPqp9zL030lZoZQWtC15dd8prvz0UUgpmzmvJBZ0FHa6lsuiDfu9kjcJTae/WCdj21eqCNRr4PgvBeg+T047fsGo0nUNjeuFJdN8SYP63RX8xMnEO7nczUU6eejjF2l6xNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781918814; c=relaxed/simple;
	bh=zm47rCjWm/cqZJ3BIlidZbXXlNJO/7wIo0DlSEEtFIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKE2N5b9TP4CD5aHQDBHBrXvAmhtGju8eKLZZYHypiRjL1b6zWJ4t7cs3AF/DcSgZ5FMob1oPdyIdd5A734n6vOuIySy+dGge/w0qkTHKjbENtN17Gwe5MWGtb7LfrA90JlrPKiTYqP/23h/Gg7IDBMeosepqN27MnUZcy9VADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V6F612ss; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=L5GWwPd3; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V6F612ss";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L5GWwPd3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781918812; x=1813454812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zm47rCjWm/cqZJ3BIlidZbXXlNJO/7wIo0DlSEEtFIw=;
  b=V6F612ssGXPVaXWPFdr5NqJYtgnO4PaqhKION5+9BSEtkRCF++2DW9pd
   ED/LXmB7sJWiKeMaAuAA6mQgHy4hiklc1TRhN3qOYoPV4U0qDT/5pag8M
   0ZzVY1tqfQ1qpadfiDgdLpOcBs5TOJZgrHe+Vhchf/htjYgBCxGPTBGO4
   r+R6E7o9PiqDIcvHtIyTe69gz4jBjPhakEjROVFYGi4yx6FNCi6FZWsQm
   rYFQmKB4kI193ph692vzsO4rBTwY078Hm9H4jW8kiZ83rmqyAZPhLCddS
   ZR8HcpELxq57BBpRHj+O0xw6rjcEZBbcG5SyRchfVz0DdMYWYcC+sp8lc
   w==;
X-CSE-ConnectionGUID: 6wqlrYslRiG8fHy45Waw5g==
X-CSE-MsgGUID: iLc97fE3TH6oEFEasLB4Xw==
X-IronPort-AV: E=Sophos;i="6.24,214,1774281600"; 
   d="scan'208";a="150386090"
Received: from mail-westusazon11012055.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2026 09:26:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga5Ukloc5OgXH9O3bwjq3KqqRdgfYQ3ZBQEgS9ZMIuC/+EVI45McBclbDwFSfOI7uzGlH162T22fuAG2qv8xX/5Oetf59bqjOUpDJ1zbaedKH2HmTCFHoBcHXWFhQiTVFAxwxtUmg/BwUhFQ99WeYU8PrLL+m5fqn4Ev1VEadvU+pEYFXOmH2l06nT5C8cbOnhL/fB0czBViLkLr3/i1YiNvcr/M+C3l3SxH3OUM0GouoGeT+0LVGFosAF4NdCA86rNp7rFbPbgy7x6shN4oKRc8pJ0wfTboSxAJlSfv1JD/Ic77Mxm2rWGAueRReyIc3tZsEfcJ6tg9iBa1W3hoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6umjs/e/bs78zur8CHwLY1MLYbNcp8YT8qB04zglgA=;
 b=abnVOgMGNQ8K7PlvUCAWEPdmYf9OQlOyiaEOxyP8Hk709iPAssYVuQv82BKUax+qTQ9QnvCgVdKVCkDjcKPdDBdy598qi4yHeFQ0UxjBHUG846L1wZrHrUq0okR9YXJUMNw266VGm+H2nR0cVtD1CsmCYA+Xn72jBP69hkJpJuFe8jDNqjr/BjIrlHPrffz7NfuGsaBkmBcboW0gYxBtS9XOWpezoIC0mLg4Hs0oaNAmmI31LChlgkJsj4M8dZIxU/D3jm3p+9v6nC8uHibEaxQ9x2Wa6tqKLaA8gtIdWTfLhSZ/LlQFqWTGe37skB7R5w2PR447wlB8eNOXmA2JJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6umjs/e/bs78zur8CHwLY1MLYbNcp8YT8qB04zglgA=;
 b=L5GWwPd3k35ZjDa+8uOQUVqdYoVoNL1exG1BOpogfrd6g7UPf3OEKmtBWBXEXBdrVH3HFXzJv0NyrZy7DsURjrBt8hB3/g0crPAeSI5V+0CgFzM1Ob69iaVc/5TOmRLNSc6jTMQcupiOnEmZBk29E3qRBBoiws8zx5IrqbTWpE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB7047.namprd04.prod.outlook.com
 (2603:10b6:610:9f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 01:26:42 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 01:26:42 +0000
Date: Sat, 20 Jun 2026 10:26:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-block@vger.kernel.org, osandov@osandov.com, kch@nvidia.com
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <ajXmBu9lDZwgMG7_@shinmob>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5fb7de-f67e-4d67-db86-08dece6afbc1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Aq8fRizdbG2SPMG0z03feV8XWHOtp8M4XylkgBkDaSBbZIqTNKCjTAvAif86ecBK7nRoHoo/z1mnj4BHq86cwhvFq8q80XPt/OG5W+4vjwe9zqAkdilEEEYVVcf8UOidFz//0jz+MkY6QCqJORD5EOC6oOj3dTFXltfnKN39KCFg+dTFE0Fwhe0ycB0ulUFwhYVv3UzuESC5j22v+lUnNxp7upLS4z9rZ6Lql1BvJmPoFikQT9678ApkxFG9roVPEqmLTsdI366YQcC+IHF2LAWMEXRIMMvCyZc/idY05ApY2sLQv9IlYhqJAXL2y+fs00nv5qTLFcpxr1Lo6HGrEb4sRM/llpuaNrlCOchVvk3ug7b3Qb0WELW8aMHe70Ke661qwTEtFt1nOy+jvdVqdEN1SBt7MDHoigC35e7RtAVMFrA+hdV6eLm8jyusUq04Zp8S+6gmzmhSdM+mAtf99LDZYiQ81Mq1+/kSBt/pUhqicanpcO/ucUqtKvmap1ocBKh5Nz7OPG7dVZSHnNe+DScJtMi2cuWI0GcehcPFIUwCa5dlMN+DIMmh28XUTYcGBbRU7swOo8AMXvGPx2fJBrtxmQyA+orUrZkGRuXlGWujWd7vf0hbMhOl7eiTimqtSq8kCNC4zUauA4eueNq9oAwAk9Y3AqOr9rglAqk3egE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNDT0BUlZIiOrAZDdDmVeY0WrehlvjKX0oVSKVkm7Pjv7t6zSzai+kISxWpT?=
 =?us-ascii?Q?msPNJX749aT1JNYEvZNkhz5ybtxjqXBcPeEzkzVobLr/wLrPI2gOEyaEWlCR?=
 =?us-ascii?Q?9jE/uFnsNoqFqfmi/bhmf+DjuC5xUyltW+5laj4EYbp9tg+aIi8nXYlOBAFJ?=
 =?us-ascii?Q?Xyx2/xtaLGn8HC4mHZwXkNrOm0gKu6fpWposNgbMbQhTK6K67davRksd8OBJ?=
 =?us-ascii?Q?/RVUEZLDtLcEdhKd79iEumE7wFpc5n3RQngRVQaBP9eW9XDv9CL+jbdukBeA?=
 =?us-ascii?Q?fzJCbMdgr0TMT5MNEavv50FCWrYD5L3EQ+KEku5s4pdN5zPp5hLRUToSc1TE?=
 =?us-ascii?Q?2bEOWOpmZvvY9s5zTllULMvax5Y0M7lZ21jJrXts7oBTnUlYLqI8Fg9M0ACX?=
 =?us-ascii?Q?QuQPYs8qhmfF71iU4JPEcOky+76u4D1mt40Nq6gYXGvf4bLzvPAIA2Tmov8S?=
 =?us-ascii?Q?5AzXNXM3qzpMrSaWUJeQlC2PNzF8VuKRILfXtR4+jJXHsz6DY8p4nMEMduin?=
 =?us-ascii?Q?isA4A4ujzz1RfibH1SOWAAO/aVvGF9d9u9aDIrm8ZgBm0/ga8wijZh7sgUqI?=
 =?us-ascii?Q?RaqJc3ZbXbb9W/dGRyuHWiLRc5aPfnDZvO1Y4o/wL/pUhtnb+LBgME6CY6z6?=
 =?us-ascii?Q?K2swI5/zBpUQM8agYwgkQYjirbCnP5jZYjRBLJ5M2Z8/ZEMWyBVa163X/VzL?=
 =?us-ascii?Q?/g8UGtSxnQtfpfbKKmsn6DVjWKzFJ7veEiilHdCyCPGbbCyQ/wLW0M/gyHNl?=
 =?us-ascii?Q?SInF9Cg/TqVTPYtZymnzsWgAfKl0Wi5mPr2ot/0WlriPm+5pdp11i27JG3+Z?=
 =?us-ascii?Q?V55/j1n93uoPpWkm1uLN+zguZ0c9kNliNblq1dwRcyDf8f4i/2pSt3EOeMTH?=
 =?us-ascii?Q?19NykrQILXlzKuvH9/J7tNb2AXfZasgpIyD1j3NsYbASim3Dl6tQCMMYKWDU?=
 =?us-ascii?Q?umHAFlmxvH9a8tjXI19XcnStGHqs0l3/TQNi1pRwAAWqDqgVnAtPup4e60qt?=
 =?us-ascii?Q?pmNegt5LVxcc9TgzxCTZEHserD6HPbvtGBQCN+p99sjdfJ8lQdf1MjHv03sz?=
 =?us-ascii?Q?DkQ/39pqK5tVW4dHOQIuIY94mwtjLlSEZljy0ghyiFyzM3uANr4iLFRmAY5S?=
 =?us-ascii?Q?vx9jx/Fh8q1bZy/HpGwGbDk+6NI8xeCgEHbaSsKWxn8gCrVxSRQhHmybdV1V?=
 =?us-ascii?Q?szwCIth8PNN31WcK1qH9NXjb8tkIkuv5GJPwxPXCdNlcc0R6ZAjqIODPYqu0?=
 =?us-ascii?Q?58iUqE23XXMS9rWMtXjJCFHTbVn28MR3y46rANCYcWwnQhImtjCDk7egpFBo?=
 =?us-ascii?Q?S9TmnB8h6SXvPEh8C+JWgmvi5AMCjMuGYP51knH9gze3vvYdb1yX0fiG+kcl?=
 =?us-ascii?Q?/+77ZU/0uOI7zNThgwywGU9VwRw9QCnocLBsc247dB2KVrAOe/gH+DJ+zkVM?=
 =?us-ascii?Q?51YQGNDBKFrOCeVVAtiXYzey3Wn1sx7WjRSzJell7j92dkd/lJorXAHGcy2M?=
 =?us-ascii?Q?Xw7wR6UCZlB03e4uTLtL7sad4vz/E2qFYNNYyg1o/RBaL/xuBk8rBupCYc2P?=
 =?us-ascii?Q?xAnjvDROLhT43dkVsLJ7dkuNURvTUGGTg2lQgMH82z3aanNtOzay9uP1uVcX?=
 =?us-ascii?Q?jCOdoh6TdkHbwbSiEH1ag+VFh9L0e4woNmTClKq0GiQxILe3sJ+Nq5Yhr2C8?=
 =?us-ascii?Q?JufzefIVJY6pZnpZ3IL+J05zFXhGJUNyoTxNsyENu+ANwIzxU4wP5x4crQ5x?=
 =?us-ascii?Q?MZX7V49WKPaU0WqhJO3SW1BDCaNm3zc=3D?=
X-Exchange-RoutingPolicyChecked:
	dhSEf9a+QuFa8mCCP+dDHUtagm2FHxVvwhM7ir7DdRxDzLZB1HPOd2Vox8pZH11BKdWbUtmRzDxivNzWE3GCFxsc+hmlHnJ14d3U6Et5F3w+L7uEN8Ols5MPwztt/Q1ezyP45TP6yt4VRAL8nnR1eXZADCJMHjQ5n3hXgpl6/iKkmYJ0HqN9aqrqBUmOBq4hma0q3wpwJFMV+znjkmEE0K5l1+PIMb1g9dFG1GfV38yiYg2mrKsMCBOxkFHbyWYfuicERmkZMxA/3uamkThyIU1Y1spK03f8OKF3IjlkdQCnYsDNGGvuTKV4m0jstlkZgu9fMv61OT0VfWtsdfzyVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QXqIMD41Goh2FDqhP1rWxz4zlAYDL0QOxwTd0GEZJlfDxBZw2YGCk+tuvy91sSlA8jhvSpTebxflIENiwdMips4HUvI8od19wGBDnSLvH+9Vdr/OrZPl6Lnrr2Ds4kC0nY7bQdRDfvQe8diEt2kzPG532VjoXHyg8ymAILDPXZKLVzRiEpZm6fII9eeVb7/HoVBQE92H3TdOLP+XokFCAoHZK6GO2se00E+cuLU08N+NlBub9oUUne6CmGEcDKZH6xgDyp6HT7EiWutp1QuWB0vPx8GKX0+NC9Xiczg7VFjgm0l4NNdeFd+t9hsFzugA0bdnyL4BFQm/1HzgK8ndZbjrpdweFrI33hm/Bth7va3eqx8r0gC3M4JwxArTacshpSBcKL7wE1njzyZbOJ17YHIEd3qLdqzyNrqgRO6kpaf5IIaozYnogEvwe2o/wFsTAnO3jebSSlHuwZNqkIWSNTxRKHwe7sZv949D1YNoeGv1XP1piOdVnCHmLcY5j7R5rtno9f2y642NeB28QIXu17PxlC3CFYcvlFymFvB1/zAEdkZz2+aZEgN3Uh8RqXuTS62QPsPY4XiMd1Z+Wyi+Whm7yyfmOGhzMNNmMg8cEFYHmCe9Jv/1TDKJYBMoic+r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5fb7de-f67e-4d67-db86-08dece6afbc1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 01:26:41.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oom3NgnLz3M5Q+3wBdhllU5ZbYXIYUIEGatIsg13HiGusIki0oeute3buuX7TaownUi55nZlmfdVegiiEaqmJ2sSllByclhBKPdMlNQgK90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7047

CC+: Omar, Chaitanya,

On Jun 18, 2026 / 10:41, Jeff Moyer wrote:
> There is no CONFIG_PAGE_SHIFT stored in /boot/config-`uname -r` on RHEL
> systems (maybe all systems?).  As a result, tests that make use of
> _get_page_size() were doing the wrong thing.  For example, throtl/002
> used it to calculate I/O sizes for direct IO.  Those sizes ended up not
> being a multiple of the logical block size, and hence throtl/002 was
> failing.
> 
> Fixes: 8eca9fa ("common/rc, scsi/011, zbd/010: introduce _page_size_equals() helper")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

Thanks for finding this out. When I applied the commit in the Fixes tag, I had
checked my Fedora system's /boot/config-* files and had found CONFIG_PAGE_SHIFT
defined. I wanted to avoid the dependency to getconf, and chose the way to rely
on CONFIG_PAGE_SHIFT. But that is not an option for other distros. Today I
checked my Debian system, and CONFIG_PAGE_SHIFT was not defined either. Now I
see that we should not use CONFIG_PAGE_SHIFT.

> 
> diff --git a/common/rc b/common/rc
> index 20f7c7a..d60a125 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -562,13 +562,8 @@ _have_systemctl_unit() {
>  	return 0
>  }
>  
> -# Get system page size from kernel conguration
>  _get_page_size() {
> -	local page_shift
> -
> -	page_shift=$(_get_kernel_option PAGE_SHIFT)
> -
> -	echo $((1<< page_shift))
> +	getconf PAGE_SIZE
>  }
>  
>  # Check if the system page size matches the required size (in bytes).
> 

The patch above should work, but it creates a new dependeny on the tool getconf.
There are 6 test cases that require page size and getconf. Then, we need to
check that getconf command is available for the test cases.

  $ git grep _page_size
  common/rc:_get_page_size() {
  common/rc:# Example: _page_size_equals 4096
  common/rc:_page_size_equals() {
  common/rc:      current_size=$(_get_page_size)
  tests/scsi/011: _page_size_equals 4096
  tests/throtl/002:       page_size=$(_get_page_size)
  tests/throtl/003:       page_size=$(_get_page_size)
  tests/throtl/007:       page_size=$(_get_page_size)
  tests/zbd/010:  _page_size_equals 4096
  tests/zbd/014:  page_size=$(_get_page_size)

Havind said that, I think now Linux eco-system is in the phase to add variety
of page sizes, and I expect more test cases that depend on page sizes will be
added in near future. So, this could be the good timing to add getconf to the
blktests minimal requirement list described in README.md. This means that
blktests users will need to install glibc-common package for Fedora, or
libc-bin package for Debian.

This is a rather fundamental change, so I would like to ask opinions from
other blktests users, especially Omar and Chaitanya. What do you think about
the idea to add getconf to the requirement list?

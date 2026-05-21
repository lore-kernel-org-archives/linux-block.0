Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DC3672A7
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335701; cv=fail; b=ooKlawyrEN9LPg4Gw4afjoXsc7zggbZO19ToM2RrscPvPliLMAcu/xp+KVeGEdq+xYHiF00HDYfICf0oVsB8KW5BMnuIMaL07Xqdey+Mb7/jfMDmCjKcgdbHGX/A7z1rdwPuY79tDbSJZFNonDAbz3/wX1kPrgRbjSt5Q2I3q1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335701; c=relaxed/simple;
	bh=1W/Jk95DFboYQ6UcpHqO/EoeyE8Nnr4UNXtq2XHqgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QI5I9Dms9fxEoC/4KA5hxeISNitqTICl6d9k0bF+ZCKXLJ9F2QZfidm0D7YmMlV8D0ApS6Y73VZz1f6mJO2bn3SWiHIA/wTvFXLiZw2wXco+oVIcox6xxRC75X+Q3bRe+lEnLJtKlNOF7o+xMESCINUtEl6i4VbRzphNyDhaU/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UhnHPahZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YFeNogXT; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UhnHPahZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YFeNogXT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779335699; x=1810871699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1W/Jk95DFboYQ6UcpHqO/EoeyE8Nnr4UNXtq2XHqgiQ=;
  b=UhnHPahZjUqwDZcd8Olqf5hQ2rH9AKKUy1GdFWOIQiqNapvYBxqckTeg
   7skEE2tDuQIjG1r3w3LxeQwCnhIq80tT+aRHIilsN8ccJ1AgpLpx5trpE
   hwiBVa7x2XQExUthu910GDQkEiOgF+RUkPZZTZFEoEMgm0KppD+D5C7rQ
   EvFHn4HeHeb+slGjB/DGfaVBharGy1x6LrP4wdp+2Z72AHDNvag5l7//a
   LhFdAaqeVG/l7krN49DfE6donQRYakxCZBCi7y03T8NsZP6IOjI2+SIe/
   2LL7z2dCY2wZDHjt72gg2BExGj1uoiVsyICYG5uMxvUOLwrgcO1gXAx+h
   g==;
X-CSE-ConnectionGUID: Fl8tIXHLR6yIG+NnLI9DIA==
X-CSE-MsgGUID: czEC2uiaQ+yPMJYi0iPkAg==
X-IronPort-AV: E=Sophos;i="6.23,245,1770566400"; 
   d="scan'208";a="148203173"
Received: from mail-westus3azon11011039.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2026 11:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeWXtL6EOyhIfEvhjQNiPrGhgKmixMr9l37uQaLKZt9eBHoOqOOPgQUqso91OlD2kHQ98vDT20GL5/UsVVQe8pIwJCgZkEAMhphT6k9pwQO0/PYckme6UpiL1jVf0gzL2cvS8fANbFKMmFkV9kBoRLUvaRS8UQ9sidpuaEAfElA7wI5AL+DEyEZVH//io3vtMP4hMYtBQjorn8sPl//3G3LE5NlufOhpLcDDeXs9EaDJxOLBWydv3rRZ7xhIO1l3PQ/2o9C37T3qzTkdUooIOCcDfEvS+KlJdmFj47cd1V69BK+1XjnkQ+mxS2AKI13KHdwT7pdGU2Cz/wn1XKh5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGOE4E0me01tur/iFnfAOtd1lF5B/X7VQBeNOX87R5o=;
 b=RPdDU25MpSs9I0w933IfLlIv6CRu6hqVS6DO67wJzwA0+R0c+ukKqrFtIn/fDDNfMY6Z8bwcm3DPWWUKwgahAT5hzLItic0Re7MXGEFuPSRy8em5LRqUGtyXwaQcNJNIh/RdQsNAkDFn/TBuFHu42uFbDM/T9ml3alBALhbXVIDonTi5LVGkCapjoQZg4AarRj56xBcT2eKoQ4ReIa1b3RfVotvPrnl662yhNYiDnkyKjk9P1rgEpgWIOns5IFkpiXcJ6m5betgVcMvjB7zrQDfQRr2p4GzDfeqYPEv6EDmaclwwntAE61x0LSn46Iu1RiwquBnzv482WZ1aB5PCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOE4E0me01tur/iFnfAOtd1lF5B/X7VQBeNOX87R5o=;
 b=YFeNogXTYbPEGiLXjW8kf5ddPBWjFE1m9CKmYpKqdmEtllGuQ2fY+vRCzmV+I8wGP/fn8vslpqK3mpGAU5W9k/h4T+18c+JnwTMwP4/okADm5VS/dZ1J4/td7OOv+4VwOwytiNBKh5X83zhg6s+AWEAYAIIKJCpGaOmjLTcB5R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB10177.namprd04.prod.outlook.com
 (2603:10b6:806:4f1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 03:54:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 03:54:50 +0000
Date: Thu, 21 May 2026 12:54:43 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: stack zoned resource limits
Message-ID: <ag6A5lhWXK5ztXKt@shinmob>
References: <20260520091237.392802-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520091237.392802-1-sangyao@kylinos.cn>
X-ClientProxiedBy: TY4PR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:405:379::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB10177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b78495f-eb8d-46d7-8f75-08deb6ecb532
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	eYNPSg7Vmrcfl1EfaEPEBygSHN3dBFvLbV0MRSeFqzf2ir3BKQt9Z3m1c98okCM3vgGo1JAA4VQzYAN37DRDwfoFXwM/Pumz6Jxm8LRDP1cSlje/LQEXSMdPQrBtYvF8hysVoRC7MG9cAijiB0CxBihnU6esbJRzjOzZGtTKhoA0Q3CIu44hQntQpv+sLo30Ix+ylcG6AhBt94hxXamgioh5jfR0dEe+5SptJKK5nC6TNjO0p+xMt0lBXls8xCtwPsWHtODy2JOnc5MBviTAkimfP7QOeAjZI+HFdj8NqCFdXAsiuAsxHiv0JuKLmLIyiUvwoFkCExjF6NSRQ84XplvqVkF05EC9NbMC7O7AH53tBqA/SEZroIl+7bgYHMdsN3iZhTr+PK5ku+EDwWcugHU4qYhaPXaEbgfzdZK4wQaGJbskdu2ltwq8/Fjil3gjaY/RORaNvUtzxJvpzPndp+XAz1LaqCyuO9l1bOpjTOattNes3/8ardCegwZiIeuHTM1/zfNQgT+FiiH1xCl4vniq10dgQC+l+YYWnDi7yUiRPfdDagWJ2FfY6jKACG87oBm8+HQPSuuZH5LGGrlWXI8QdP/sea1uT2OpvHkyzHRefXKOCRs/Z4sGpub2R+FSR7A6FB1p1S974xbtmK5fpEsuUWNUNiJeHeW5Qe1VeJgqhUERy94itwRJ8FWNvMTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?td01AzUGgH+PsIWC1bw+v72d6S0j3HXJx6NPCXh11Vh6qhWMA+pdQNPxlJ//?=
 =?us-ascii?Q?H0yd6VW4tHVK9MppmzNq15ghXLh45o1lWpMFSa10L05pglk/Nc0a0cHxm8oI?=
 =?us-ascii?Q?SWZVgXlDEiPfYDCdIM93V00nCP2H23gvG8Xze7JppQJ0IsBxh9REtdhzAGSQ?=
 =?us-ascii?Q?DwjLANLb2c6a9On8CWyboM74vwPorzc3uR05H97KelC0d8R/i3s+/wvAL1QC?=
 =?us-ascii?Q?0Yf2ArJiRCXi7nHAT+2RxavkRuoWek/MJqNICF66InKYgAypjUwLNV2Q41xm?=
 =?us-ascii?Q?NVfKX7DWluT9Xh1duSOjdpiSlVgJdRkFFF84z1eGvRIjUeHLUXZOTsWUcsDB?=
 =?us-ascii?Q?cskdXUVQeq+XlUVpLIi3y2XNlv18tpQ21WIB10k4XUZRmyjdS7+iq1yUp1LP?=
 =?us-ascii?Q?qgl0WoOfTkXxE8vnmYwOajkpSn38zoxXb6rYpplRb3f3ZrP1nJNFgCUfikta?=
 =?us-ascii?Q?WfV2yy8wr1MvkM0w0Xc2T5yNRkLwOk0pzhyOAdU15fy1R75+I8ojGkLNZFL6?=
 =?us-ascii?Q?/Gm01+hqiGiJ7LaZeKERWSdPctOMRl0LpJeUGHBLtJCRLIeuBaV4kLBGqRgv?=
 =?us-ascii?Q?TZ5kRkcYuer5keWfcC3zBDXwi66rlq/uNV3FAvaq/YC844Z1KtkxgWl45RvH?=
 =?us-ascii?Q?grW6vZDnYOK6ZH8d/G22Gmw/qhpNAbWtNaybmH5dyrVwgv3wJ+ILzObSodBE?=
 =?us-ascii?Q?yhi9D7NrocYHKGg3y3JhllQcqzhPg9/euW6AmO/6+hFenw6+MAXon4oN2lxN?=
 =?us-ascii?Q?9yyxzLu+qCEWFZBrw2CgIBa3wFU08KwtgwYrhhDxGi+m8OaJiUp5OSIMc4i9?=
 =?us-ascii?Q?BSYJQd5N6DjGOoDHt/BAUqSyiGaGl49+Jw+0HD2y2TkGbCnwhdHj2Cu82NWu?=
 =?us-ascii?Q?UCyqzizZoPc18vVCppxcDQQiqXESNNA/sOiYAbEWHLPPTdSfKrRjHbJMGK5T?=
 =?us-ascii?Q?JNYHciN2YXifPyNgG2zA0rz8tcP0+yiZy3XxImp13JLch6IlpwpRPzxvV8UF?=
 =?us-ascii?Q?MwYq5DRaG2zQVCCy1NR03mM9IN/LfDENSYvzclGly5et7gAAH9DBVXhi8m7j?=
 =?us-ascii?Q?ngu2hWl2yqdcaQncnoXGq/k+/yE7bLckTA1NctlhEM/GZw1bCN87gNpnx0he?=
 =?us-ascii?Q?b1Ts4eSwkXnMA5JgTt9aVTBdnf2C2XzSjR07BfL9YXv2SRpjQYMe6n5jtcu9?=
 =?us-ascii?Q?NOE/p2mHgEl/oe3zHkiBiiEW/9dfBtSXiUtJWoWGFGB6xp4qCfuJr9PZveSu?=
 =?us-ascii?Q?sW/whxAtWAE80cGyY7ZbwAWyKglogvz4YMjqIRjQsJf+xqNidl+RKqoPPiwT?=
 =?us-ascii?Q?1Mx0JQzgfJUNpbMKsvndBOSL3cQD1INmZ0DpDcbJm8qKuoKXn6nr6R5VLFIv?=
 =?us-ascii?Q?PH4Z0Bpd+ulBdDChSdraG2Tpr9pQ6svo1V15znSS9CjANw8o8OQSVzP/VUSY?=
 =?us-ascii?Q?e9I3b9RJ9bVV20NV5IzZOAWz3C+rWkPQlgpoejAHjfzQBTxxdk/m9A6OCc4/?=
 =?us-ascii?Q?E79QHxqKG0JYECtw5L/gYX00+93l/N7fwGbN7RcEDuJ1SuF/B4Jp6BvQi9fO?=
 =?us-ascii?Q?cm/Q7nArLnCyLEBi/C4tjSeoGk/Xg4TIGawDrsVRBOzUD8rXeEZeMwRAYpPV?=
 =?us-ascii?Q?k6pFzLsAW2iBHwtPNc7rO0DGdJyhaayacHH4eGoNeqW3Y4PhbjBIQHuMndFY?=
 =?us-ascii?Q?/q3Z3NdOm55FK6wC95W/DBRwtTdc+lHK6X1uy5+C7pGEm8gVZr7PrIl6KAE9?=
 =?us-ascii?Q?7FgBfiHzAOeZyMjAalVRVYBZ4nbsI+g=3D?=
X-Exchange-RoutingPolicyChecked:
	gtS3rR8yymulk1nAO7w91Ypesp8VByb9f+gIuAQndfHXFtZZAhHuBWbzF57vMvIPJQZIgiDRGi569sqHYYYAvQRjpcWUlHOeLsdkz0dUqMmZ9ZmLfTbMoFaZdrAfRXQv4k5vSbykJAmCq6WOYZ9LE0IzgBEwjEY3jH+NJR8bedcbwqcB6FKDFBfnu+cOxqLk6neISQRTSYT7IzL7Qor/c3jF//14orWufk3rt+/eeHYnMcfYFSVs1a/e/0+od28vWPZb2MHMtD0Q+6/IJHOhV3DtPniZyfCmBiFQOtw8vc1QQR+V8A6oXq6RT9AI4OFWBgH2OS4JU56QrI03zavPzQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d6ax/6hD6kqoUW8qy47EFsgwxN5sfJTxYf/B+2sPU8n6J1SlSZUpNQssb/4KgJZ1nOok3A5UKIMB4etLMF7G4g9qNSlg8KUleNUe2r2PGmdDcWz9SR3va7utD+ksJsg8VKgyBaK4onlUeNwtUrifYoc3r/a03XLuh0S8m/afI63LSZZ/EgeWe1P7fd2EJbmVUdYNBG9j7wfjPWB64ZVfZPN/tQwGa8yI64O3gks01SF/0RBmx3XkwJRcKAtGEZqnLldZjryufrSM6JjvZ21UOl4JCEBQAusExXelCBXK+hrCiY5tmvwI+TnispkAfTvOPrGS6DoFlWGQvEC0SeAczrR7/ULtHhnOY4dYRH/3oxNrI9lAQKf6DkScumX+JOzXcsC3uetGqoll5GwzjQ/YlsGBddF36Vbi/TVRJezfeKAWPfo+eySdFewtl3WRpQD7pJ4j7iVLRIU+iScObRVKWevOx7VZui9ytxTt/gPcUcmdeFi696TOnZAujjmzbZwSPLMtknRpLDZrWqKCjg/xAA2AA3Yp8+KH2iAMOSrkRADCfPFw29gWMsWbEk2Hjc08zad/Jv1p5WcDw8t1KEdNldxFuiEXicgkXOBCU+BWa0wEmis91ObFydSGb567yFzO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b78495f-eb8d-46d7-8f75-08deb6ecb532
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:54:50.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RPEMEWJDC8kuMw11Ovog/x6KCQDMZsuJcluI3sCBVfnGFs2Y8krz7yQWtoArvhVahfFH3BVYDOqQXQWdsByloG8IloVxuFOkbWkpqbyABQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB10177

On May 20, 2026 / 17:12, Yao Sang wrote:
> This was found while debugging a zoned NVMe multipath setup, where the
> namespace head reported 0/0 for max_open_zones and max_active_zones
> while the live path still reported finite limits.
> 
> blk_stack_limits() already combines several zoned queue limits, but it
> leaves max_open_zones and max_active_zones unchanged. Since 0 means "no
> limit" for both values, stacked zoned devices can preserve bogus 0/0
> limits even when the underlying queue advertises finite values.
> 
> Stack max_open_zones and max_active_zones with min_not_zero(), and
> clear them when the resulting queue is not zoned.
> 
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>

Hello Yao,

Blktest CI system found that this patch makes the test case zbd/011 fail [1].
The header comment of the test case explains how max_open_zones and
max_active_zones should be handled [2]. You may also want to check the
corresponding kernel side commit 73a74af0c72b ("dm: Improve zone resource
limits handling").

[1]

$ sudo ./check zbd/011
Memory leak detected before test run start. See '/home/shin/Blktests/blktests/results/start.kmemleak'.
zbd/011 (DM zone resource limits stacking)                   [failed]
    runtime  9.791s  ...  10.764s
    --- tests/zbd/011.out       2025-04-22 13:13:27.805873155 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/zbd/011.out.bad      2026-05-21 12:49:44.398000000 +0900
    @@ -1,2 +1,13 @@
     Running zbd/011
    +Invalid max active zones limit: 64 should be 0
    +Test 9 failed: Map 32 CNV zones of the 1st nullb and all SWR zones of the 2nd nullb
    +Invalid max active zones limit: 64 should be 0
    +Test 11 failed: Map 32 SWR zones of the 1st nullb and all SWR zones of the 2nd nullb
    +Invalid max open zones limit: 48 should be 64
    +Test 12 failed: Map 128 SWR zones of the 1st nullb and 16 SWR zones of the 2nd nullb
    ...
    (Run 'diff -u tests/zbd/011.out /home/shin/Blktests/blktests/results/nodev/zbd/011.out.bad' to see the entire diff)

[2] https://github.com/linux-blktests/blktests/blob/master/tests/zbd/011

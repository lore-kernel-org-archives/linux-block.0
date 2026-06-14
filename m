Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939803770B
	for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781418667; cv=fail; b=T21/JNmFon2ehURlWUZLih80yl2dmdQulei7H3TtJ1r2jccDx4h1XYgMzzvQq3oXy1WKxXqYAdhqxemToCM1BTRk1RlEhzfPuAkPuTucXE6pQPNdqU3NolGDf3E66UYBUnMGk834fK9lzS9NAIXMP1Hqu7GwB6n26GQqSj8yneg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781418667; c=relaxed/simple;
	bh=fwg7NSU1UM+9lFFJ+gL8CLih0N9mt5BDRX8oNSjdN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MIOwvf7hAIICwErL4Iq/gCJSCVtSkEaZfa3xL7Toc+YKGP0gM/9SOlYtpWPVUkwKtxFMDuGbyUpoSGLMdASXlNaA2KPevwXYjpAFJN/52WEzf7nYodF3+44i+Z5D/QlrpEDDDK5oEnWQkYDtFoSUZ7h3mDgCIFFZz/e3sUepdPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lNE4EDcC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t4Ylexmi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lNE4EDcC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t4Ylexmi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781418667; x=1812954667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fwg7NSU1UM+9lFFJ+gL8CLih0N9mt5BDRX8oNSjdN0Y=;
  b=lNE4EDcC5RhDCMBwmCiBl51pgrGytnqYmt9plkOrJrEXCRJpZm928Gy6
   j6JyRCyeOiT+nq5MfMHkCmj0nmYNFMNmTij5ykLq9uFfE1thx1acrBAmP
   JuPP8DILERrTX2uZ+yh7toy0M/QW/5MxyfyWx9XJbxO9k9Qg4Z10JGQhO
   0vIVCcUBVyrdsrGNOUxcugXi6fX+ta5XugyXlr1T78SkSIUw3OjFaDdha
   s1zIM42CS3S/oYdzdlBpGQGkY4l8KLsSFebhvSdmDu8JG+IVPWmpIB6ke
   qf9NVdBCWYByhyGsS13Q/IADzPepO0tB/O4RZyfqZfth13i89w7W8fDeR
   g==;
X-CSE-ConnectionGUID: sbket2TnSsaUDkVsd2PkMg==
X-CSE-MsgGUID: rALhtnnHSH2gL/8SM5iKGw==
X-IronPort-AV: E=Sophos;i="6.24,204,1774281600"; 
   d="scan'208";a="148129974"
Received: from mail-westus2azon11010008.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2026 14:31:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvyrSfaSqKt+5SpbFxPjvVbes+m/Rz6McM0IvqTQs8tUyl/sRDCxUrgbJqKUba6aEoEblKJXr2XWOgafsVnBgq65tjihvVyYyiGEO+mrH/sciqd4+gVlHBH091RixCKKX386WWtrf0EgJsQg0bm/3FzazuHmNcq38gqH/LMIDNMLkklfbj7JdbK8+sAs5E+cTxBi+6XulOG5EJ9ehVHBDfjXgeHTHaSiZXJGlCjUtypjAVN/K7f0OFD2uDCi9RPGfMetS5bxlEMS3PRZJpLaLcs0iQTpta+Dbm47rXI1AZ7yt0jCSClpsDigXPeGLXkwF7VRhHvm++vmE7Mh/bQqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXzD5e+2QTaGCI8P+XIb15gGBt0wHOEOR1vL9qvDlv4=;
 b=lKO5B+Itq3h5UvIO9hCUNJsFGxLJoaf54qAAXnxbtRMBfAMiHrPwcx0jm8y8A9DzmpL+XoySjF2HO1oVgWwUAcapFhSGPZmdiHHtWFm6igVrOlgJS9+9IjJhMYkrnbjHciVifABBKafsqUxYra/dTKfGN+Y2qN+Fi2bxIk1/o04arkEvUnz++yF2sMfI5RcPu+tOP19usx1msy6l0NLzVOcalIicRRtC69ZQQF1Za/0xMGENII9ebY4SAtrlk1uUnR7g06cop/F9nZuaeUYpzXcBnB/VyeRl3ngvLGohqiXTrSELY8EmCxOjFNRIEM3BiB3z6v3uRqLNh6FtmlkUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXzD5e+2QTaGCI8P+XIb15gGBt0wHOEOR1vL9qvDlv4=;
 b=t4YlexmiPqdqcJE6lsnpvNuM6vL1IQlcpgATBaQOo8EalgLnpdYiBUConUnEbAyqDdZEiHPpE7R4l5ZPlJyZL+cLUMa38sUkOh43HSYKPPA+A52frbqKUw3h7UdQgZ6sMnhA/+hmD6oJmFtXwO2JbpWLyVzP7pOPy7ApKNAbq2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6504.namprd04.prod.outlook.com
 (2603:10b6:a03:1d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 06:30:57 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0113.013; Sun, 14 Jun 2026
 06:30:57 +0000
Date: Sun, 14 Jun 2026 15:30:51 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2] throtl/008: Add a test for the iocost cgroup
 controller
Message-ID: <ai5KEX6V2Ho4cbGl@shinmob>
References: <20260604175423.3809638-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604175423.3809638-1-bvanassche@acm.org>
X-ClientProxiedBy: TY6P301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fef5757-a9f0-480f-7d74-08dec9de7e68
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xOnDtZZYabjl+cb9YlBZK+i4RYODCmkNDdeifOU01ZvHv7cGxFpPVvtL38AWJAie4HzsOOOH1eewqwqefsY4suSddObadACBKEqvaqTZDpJNEwpWhTa1R/qGL16Ib+7GIEH/in/9NZ37IdmUnGEwhOGKWpX3Nvl+HB/IOfA0oHf9PP3MXdYLLwOePeVKzdipgQ5pAht5BUgk3N2bxCVhXLiBPbNPsMz6+zU+Lm4FNBZi/oODN6O8/bXT7Kv/S1x1RXWoqntGRpBFLgLu4zZE7c11Vp9X1fBBlv5wMTo/IE6R4fmcYeh3IGDUXUQz5omR//3SdAXnp7m7WL2A1p8UbXOGEZGqAJLAF+QKMNsd7JL/dM5lkML4o7Tq+VJjf6NA7Z6ZNGZmqkyccYqUgAUQUnw+9ljboUoZnT/BkkS+dfBv4C/TQ25FHEnVzL7yEPyv0en6sB3Dkj/bfVsDvxVQ1lKeLN0z/e+o8zX1/MI8cmpMpWuODUbAeWCT/WATwBrsEXXDayTB5nwd5Ji0h4M85tOnt++zM9dg2btjfhMy1T9xLexC2PhzwN0H8T5VGVTgkRmKELk3cPSbYHBdNNLw8CTQOWez+ywMdPmiSPMjhoA3YL/DZTBOWbDa0hB4PBkDTYZitUZ53zEB4sL5WJduyOQ7Rhr/bFf5UZpJMz6w/W+w6qJ9y45mGYwPUy+ab4ig
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?URIMZGljTbeDBp9pUM1rE+Kw3evKQD1fp69+ahBA6HO29zqqqLLPzdzyv+78?=
 =?us-ascii?Q?+J8MO7MeVZ10uE2D509O4+qUojizH1IcNA7cRFQk3uVlSd7yZNf5YBkv8oSJ?=
 =?us-ascii?Q?jMrajpFzQ8mygzlfudyC4CnBYRjyD/6PRWj81UsMxzdXDG6crDrOzRs3LPNP?=
 =?us-ascii?Q?sLqgugMbsXPvDilb0YPM8bBRoffWOM6QkTidJVvRjUrQgP/XDUIDYzxJsd19?=
 =?us-ascii?Q?lr3wwP+RL2CwDtNm4r43/fjKji10fO/frg9UKgdAfNVhVPQ83+rH5gFAhVZr?=
 =?us-ascii?Q?L34MJkXm7/h7gOvxHRVffBOqOhbTKf6b0os2HCt7GKx9WuBvKuVMfokjihUK?=
 =?us-ascii?Q?pWjSVR0qT9Q2EteTlkjGlJFHrNh8PfDlvObmrvOXNM5UizJ0lNIcq+gNRNv3?=
 =?us-ascii?Q?BDyWID4j8+IEGr7KyKOK7fJ3EW9ahDXcLejYEqlQnphDGQ/PLDwvbyD95dkU?=
 =?us-ascii?Q?7lG7Ot8m0jQx9N151zSyz3a4mMstXRDwDwZy2w64VCbqqJICLnJw4HPUzCG2?=
 =?us-ascii?Q?woHT6aidgM7Sm25I9RXgyVxRVdQ5S0zkpCO6bUvbzMhOf40dUFd3elMqUwQp?=
 =?us-ascii?Q?NQPEdco9gGS6RfgP993L5YfTWDEqKVX+zulcELigqhcg4fSsRqWYNJHWKAsP?=
 =?us-ascii?Q?2iyJX0xzj3eEiK9bQErYFKFAK0oxiwo+Or30LJmUwwlA8nXc0YWlmmBZ0U/M?=
 =?us-ascii?Q?P6yxiRxsodYMZ/jGwsqFLntXTkS0ILESpQf2RbnMXW3Cegae4+0h8ewL+Fa9?=
 =?us-ascii?Q?SWKxGZsI7OF1YOfpwv5zpgCCAAvce4VH8/jiyy5zc8mlm5ObynQtXzMpDZiy?=
 =?us-ascii?Q?m4zsGUBumHJU4DGkZChjYPKni7pqZMf6qnEezwGFny+89GJXZUch81cOc5S0?=
 =?us-ascii?Q?gYogixH7iUFWVqtcVzKu8zzsombGiz/pPCTCDiOWdnr7ir9v5gQIn8smxbFS?=
 =?us-ascii?Q?GQSFB1pWMua30xMIBplSW744RUjhLaefsZiENSskT4cKMN/FDL2keuOGYrv8?=
 =?us-ascii?Q?pmulcfpcKLXplqXjjab7W0B1VfOw3U2dMWdk5QYX5kKUkWX8phS/mjokyBG5?=
 =?us-ascii?Q?WMVghiClXzqwXpdkgGTYqBCxMlWutR4/oy4LwEN3fZyrVnkSCMC3pmX8w47j?=
 =?us-ascii?Q?RQm3K4bLn4y0eZnWW2sVnaD/klHz6ANh5J00Y/3VqwrOcCjdYWan4NtBrjOb?=
 =?us-ascii?Q?IoWP70Ep0BJDRtnB+VAQ8zU1GgEXhpidlyFLprNiUJp22keYyJxLv7OpFOse?=
 =?us-ascii?Q?87ylIUzQrtW6nKzQR++Grp778OO8+hhdHgn5xKQE9blvKDs+5uduWvyPwLF/?=
 =?us-ascii?Q?sq5kZhL4LNGzBu4nXrvM6l9LVWkmtKbTvEjliWOkxftMBlvBuL3SUNBsCNDO?=
 =?us-ascii?Q?Wu5CTdHbEs0B5JdSHjptQd0CRv641IW60ykwelzlp8W9hZxtWqup/z2Ofp8c?=
 =?us-ascii?Q?8amiZFxe9CwhxYiE2Yme8X9fpM/mhI+/szWd9IizraDRMA55hcrUL10VHL3t?=
 =?us-ascii?Q?G8kdk6daiLvU+ydAIXkgFkd+BZy2pipzb4sC/eN7deXxwaX73zKML+4R3AGE?=
 =?us-ascii?Q?k+0iKmcOrRW/HRMQY6zbAWLEh4dR9/4C5cPJwKDnug5BK0aYgWeRXSrgrVvd?=
 =?us-ascii?Q?tqUsWaQJkFskWsto0eYtjDRBrhqRjy5WMwt5Cj5FM+bN1KuXFjaho5bGCvpK?=
 =?us-ascii?Q?cAge1d4Wfi2pS5xeSVm5HS50TGMmQsBcdcnMp2c2W31MOp2YKh8tMwgxe8RF?=
 =?us-ascii?Q?XKgLttIFnYcopNR2QyAcKTTsUap9bbo=3D?=
X-Exchange-RoutingPolicyChecked:
	iI2uSPx3YBEGCjKYP7rlJDouiofWSoN+BZXaRVOG3yDt5AMVruqJIF45yrWJAx1EUNruGkss0IrVTpKrEyiAIgbedOHjCJJM2jJflhh/qFkpi787H5p54DwPC1pdigu735inrdQa+qywdS/OrtKf5x0cctlKmXDsQ3AazW2n961AMrTL77osrfRijmaeHf9ASBanP6wdCPb0bfJ/JdLOcqF9HahqsnURM+jSEfXpaBDDqATKGq1pKdqyVwRYDd7/ScfN7buWTiSstinrmQh9Pe01MJ7lLdxRx3E1Hz//E+AJeY4Gbfyx2qfdrI/nBUzgAXYFFGdwh4u+1aWF+GpSCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xZ1aOjP5+szbrJbbk+dn3bim+mTBkRC1UTLMy1q4JYM1kCz3SdwQAS5F+u+zK4AuT6DbmTDmVy0Fh9knISqXlGZLdZfZBWahMU0Qn5tDN4FS05M9MV87tGcL3H+dXJmXB/Y/eutJhTLYMXE/dUkKbpw54kGQbD6jTiU8I2BcswqvHgoCaqQJRoHRaLYhweUJ9fOXAbtPqdUtMvL2VHZol1ik5aTxswHDOgSXqaQvhd62hXNY5ii+kuXmv3aqa6YyA2wkXskJe6RwyrB+tWYG/aAeJVzVkzGJ7m4zyOYLDSXNQwng0OBpdGZ6gYXdfcLLF4BNDrvddJp381mLmriC/h4NOCrMOE0VNuU0xuQdIDs14oXIngcFmMA6xll1nLfTmMRuiW/ZRL9Uny8lAqAaVMd/jIKgE/LFkTzGqqitkcj4RMivUw5l+NeLNWx/NnGz8TEX7cuJ3mP2cLUOGq0a+SzTLb/xqrip7XqsLo/ey8T9sGH+YdT3D/T4wZG6wr6pfOyGmU9AZvKOD7yVfQoJdwgNwC6sT5rCxlaXgDoWg9rSH2Kz1oTvWGGLu8qZnq3DAosR6a0tOJ/78vTwMdGB8mnFXoWZbEDft5lmuU2H9b93uHFcAFLYRN7/9yBW/xab
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef5757-a9f0-480f-7d74-08dec9de7e68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 06:30:57.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTllM3+BforYUOt0c3cKU/4zu5uYeSYWEDXChv6EU3e0XG+3RKz8ll3BegzufB+BYZ8cTpt4Yws/Fibl5MhQqd4XPOElF0t5MfWLg2/F/Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6504

On Jun 04, 2026 / 10:54, Bart Van Assche wrote:
> Add a test for read and write IOPS throttling.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks for this v2 patch. I applied it with two minor changes below.

> diff --git a/tests/throtl/008 b/tests/throtl/008
> new file mode 100755
> index 000000000000..f4d3b080797a
> --- /dev/null
> +++ b/tests/throtl/008
> @@ -0,0 +1,104 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Google LLC
> +#
> +# Test cgroup iocost IOPS limiting.
> +
> +. tests/throtl/rc
> +. common/fio
> +
> +DESCRIPTION="test cgroup iocost controller limits"
> +
> +requires() {
> +	_have_fio
> +	_have_program bc

This check above is in group_requires(), so I dropped it.

> +	_have_kernel_option BLK_CGROUP_IOCOST
> +}

I added set_conditions() here, so that this test can be run for both
null_blk and scsi_debug. It also makes this test case consistent with
other test cases in this group.

> +
> +run_test() {
> +	# dev_t is global to make it available in the caller.
> +	dev_t=$(<"/sys/block/${THROTL_DEV}/dev")

...

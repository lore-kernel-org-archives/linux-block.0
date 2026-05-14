Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E32D780E
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751971; cv=fail; b=nzdU3L62SqbbqVTo8pZCchLB4Sw1onwOAq8cDNN5J2frXndRvEkrxNq3u7lS85518v05GBrjKuA1/eflVje+Ylmut/yxQm5xfBBtrutNOzE7wtrfQRWAnRho1FZ1VB2dgN0X7oeD1D2FKQYEAr4BmbxXIDTrnv9bSr/QaykJhV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751971; c=relaxed/simple;
	bh=ezWo7iLJbmTYZmqNhQPsZq/McL0o5H2WEQheuTpCjUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVwrLD92sKjGOi+u0CT2dCl5fD/uA7K+E96ln8gNkpllANsbfBZ7pCBxo5vh/X1zTFg7inYtRzbLhzOIN5rnfUSXcvu6cWdrW17gLohI5UeydiHym7wulWYhgxwtHTsXNqPKYBJPALIY3jtdWKozETex/QoaKiKRHEuHij4Tsk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BEwR1AWw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZtMtu37/; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BEwR1AWw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZtMtu37/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778751969; x=1810287969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ezWo7iLJbmTYZmqNhQPsZq/McL0o5H2WEQheuTpCjUA=;
  b=BEwR1AWwbk49tOtHASEQ3YQhbZAQVd9+2iwjZ2Iz07TfwOgsqJ5hC7Y2
   cfq5tIhczST5vVzp/rtL6jvBCYnbs5VfcenWaVDvwx8UTFePJYj3U1ynB
   rLbNj3JbOlMrz5VJvkm8lVduIPLmLo7FeNEVzoRH+QzWU8Nupy7tzzUs4
   4D+RaVYud9JaDUQO54CV3RR7CCqlnc1hJdsp4zbdJx1qTSlSrEFKoQcbd
   m9+wTCUCJtEhozzUL2H+QlrCnzH0lGYAEUKnCllevKvoESN3T89uipUwu
   xVM1fVQIpCIcbhWmPPGoju6F8yixp4gRFGqBqJ9EExC2PRDjFwMwrBlRB
   Q==;
X-CSE-ConnectionGUID: FVu7OvV/TOiMHeyTZ9Gpzg==
X-CSE-MsgGUID: ODRHJlIRQNKn4qwewDW+pQ==
X-IronPort-AV: E=Sophos;i="6.23,234,1770566400"; 
   d="scan'208";a="142789348"
Received: from mail-eastus2azon11010053.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.53])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 17:46:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoZuvASq4EAbJs6FMV90VUtIYpz7Fu+1yQ8RkJ2t+aUPp0/1yP9IMvU07RbA/MehXVbh1bQxUnUnZeADOlgRpq9ed/5pClahkZpTZf0vr6nZPp7byd1xAlOT8R2+tSLIacVFXK991ZLgzPTqvJvYF+ShlUXEEVa+BK/AhlE4cQ3fhaJb0YUdLu+YrGAfxTec0LzyBWVFrNcVeh//0+1HYt6gmlJ1yjxSwSmZ3LskDWhlcCq6sAbrY4R2ARbr6wz2k80D2opmHFwpGGPHQfFZ/vjaR2Y+pecHKx5VhilAxr3Ic3DLCvmdx11vOnn1/zK9S4wweqBgWCO1VWtxynlzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibg8Dm1IxiKe+C8jRXW1U6CMvOhgRbHIBlkvnpyI/L4=;
 b=ZQPhq4vB0Mwgb8NPzl7/ZKHuL2vjRjT9+drit5HQeo7oGdT+6HIZCVFupvfngsmkX+v4QS9uUoW9s0iFnbSKD+jwN/JitceUXp8twqrojS0CTqlq3vab0onONv2KVRQVCNq9Hxeprn02vdGdYw6khIxhLa9WfesA/lN/LXFBNyEG3AukvLV5Rr7XRNvTPdvGCKez9cNKSoz676WEwwgu4fPGkZ7EsGIFNoebscsWrZT5eFGN12uxmm2c8cYVl9fRT0Y7bFexH0ZZWroUgQIRBDxKXApRMAFhgBwCiMEuATgIX7MUVy93OPEJRjvNqKvQ/SSI/1AYZb9md+niu9TmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibg8Dm1IxiKe+C8jRXW1U6CMvOhgRbHIBlkvnpyI/L4=;
 b=ZtMtu37/FLiWyELeB/GfDm5OLdAkswoyRQLfOf2E5kZXLdBE0TOvWa9z7fitrb/id5p8mzH6oy1eg2j+Cf//ifyx4mF3ts6LjcsIJSJ2lDDC5jdFc60b/nfXC+7sJa8HikrGlReCP9vEafL/m+H/kJEOua6l9A43wXWx2ieDSso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24) by CH4PR04MB9082.namprd04.prod.outlook.com
 (2603:10b6:610:227::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 09:46:00 +0000
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f]) by PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:46:00 +0000
Date: Thu, 14 May 2026 18:45:55 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
Message-ID: <agWZZkwOhiSoAvh6@shinmob>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <472b55a1-cef3-4473-b8b2-08b501efcd77@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472b55a1-cef3-4473-b8b2-08b501efcd77@acm.org>
X-ClientProxiedBy: TY4P286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::9) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR04MB10005:EE_|CH4PR04MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ccc2dd-271e-4d20-4028-08deb19d9b08
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	rNDYfB91IMdzjQjGp5GNVDPz+yDt7L4iM32LRFJVbfUGVJbGkyK5Y2Jns4IdiQv4Ft7cWMzrsPqPgLlV5Vcrrcf7bqb9IQvfNpIZqMeJ70BGNWHPUPnqm5fGNCsWsYO7D/i1EP/pKWAYxbqWH98ja0liPkknEokNglaHPlJ1C26sdgTk3Uq6ctTBmrqNEY7aH1jso6sSPGhcP1KwF3gfN1mxKcHHqXlYz5IDp+gETJ7zC5e3TBSzBnVCYbb+K0o816U9q9pnWl3WEROILwwItPZhQOXJXUq3XECCEPEjYmB8TEwZ832vMBL2YR+EeJXc4z377SKXkyTgdijpyrseD9TIlUB6EplVGO0qj1aok8KveoivxXY2cZH5SfRoYnpJW/UkhS8oGwAXgVIyqK6YjevppY/FqK8ZXPk2dRC6IZJiic3q93EWSRLsO0gvp1kAloC7z7L6/UyvUykWzMQ6YJ+1LcLw63UDb/2ht8FRVBZtcucrlm0WlS7Wkm0iJ7KkwraBdWRO2Y9lrkWGwf55sjQFazcyudOuGZkdYD5lVDM7JOQFOpGsTh0ADvnDSMjfabr06IWU2mFnkm3RbzZZ1WuD5YGAWhwsGK4tPmkeWxX5BSUat9bQkhWxVqVQmwCJu1WRDTZNAwJhOrFi7Xt/F8fikPdKk4WXFzTEDrVS8UjPTFE8B+dyjbVEQIlq4H79
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR04MB10005.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/EAVzy+JlZzu3iegdBxCkQcse+Mt2TWbylSqE0zvNc88EOlNWkw4IWI9+Bi?=
 =?us-ascii?Q?WbIPZmsVbW1xJOGdZZ40hIWiWIH2TZ+4q9JxGrJZf6sKO+xiVge7AKPIKHxZ?=
 =?us-ascii?Q?2FkipABJSAG/BH3PNM72vee7Z7iLlKde65PMydkaImLFp7cJBU4Ml/TUQXVL?=
 =?us-ascii?Q?mVtmqKhW1EYvBbTUf7YpFMf+YTCcYeYwF2zS65bC6/B/MQ4QYdUjO4XRmgSU?=
 =?us-ascii?Q?WP3fNNUktCOLsy8mI8GpUmFf0TlRicL4Vwc/qIOO9vnTJE/TGuqZMyBjItiy?=
 =?us-ascii?Q?ZCpcrjMdcMDcR6bDgvp6tRUlHGho3kM6UX32ZfSPaR+YMKpTXmPRtWYqGhYA?=
 =?us-ascii?Q?sCw83X4nnyuVoItg5vV6kiJOHxFneWHBFjDO5sjU+P2J/+lN3+WnIExnj8H0?=
 =?us-ascii?Q?bTb8D/r1H5C9HtzmjvQma87enG17z75yauaa6qQAZjqlFNFRiljNYXAqo8rj?=
 =?us-ascii?Q?nSkuZeK7rPToHhdremtOaqpVmgMkq3frL69W+E1zOjZq9L3biaVTfB5CvpFT?=
 =?us-ascii?Q?7gBNGXxIJvtmemy6Cx9TL1mGDPG3vpWt29XJV1n/x/twHXuyHb8W8YYCPj1T?=
 =?us-ascii?Q?52u0t8bErP6C/Jg0puAsZbLdx8VUyrAxQK47+LH2HAzHE4/vv2WzDd/hsZCx?=
 =?us-ascii?Q?t04BIOWfodBcEE6VHElGVzyD1fYEkVayxCyksiv0O5bw0BP+XhK8Xq5Br7m5?=
 =?us-ascii?Q?9cUvZoFfLh2vlFbRf6//7YUSvK7Yfu0vrGv2BexgBJIpM6QIepK74Q9/3NT3?=
 =?us-ascii?Q?veU+QUL17zMIzFZEK6f9pXU28UjU9aQZntu9nJthx/qxyG/JOvzm/baHPQMw?=
 =?us-ascii?Q?Is/6DnRE2jZE5juHHNqu9g02Nxf6FwTzt3RkWY3Z59sqfvDwqzzAPQUxAVWZ?=
 =?us-ascii?Q?JJGtxZ3Wx5Mm9T1iViG6oyCmd3Zwc9/r4Ij1NGRHrOovHMY6bsXzpaPxeZlX?=
 =?us-ascii?Q?yFtCEbXJFQ1+RFsV7jYXy0ADec/sLkS9SGuFa2sIWVb0nke1RW8iUNDBRHU9?=
 =?us-ascii?Q?nJ2Y0aEJbviObLTGTLC42cmCL3Qp+0RfvGkYTq/6nDHDQvxCDWNOxxG9ePrm?=
 =?us-ascii?Q?4vh4U2shRjmtBI+p+lx2izDyHNq8+dTOwcSiaw86FXQ31JUde96//zDthBqu?=
 =?us-ascii?Q?bsyupiCI+4svFjDPiqEFXau9zp8oijMh1OPlL0/5xD6h0yjqtIRns6IT3Jmu?=
 =?us-ascii?Q?kEUY/ubbWN+xnBC708vjofgw7Y6oGXAau0vibSnEjrls1SOQ2J1mKeqYDneh?=
 =?us-ascii?Q?f1Ji4dTpYoe2dVRWx5Krn232kWTX2GUAeHHw3GrIZytyQyFHjZ/BJCr7zUap?=
 =?us-ascii?Q?gJJCvKrHD0Snx8KC4MIJ+Ul291GhIc05sma5rt0YltiHnAScMnuCjJheQxp2?=
 =?us-ascii?Q?98ToHPYAGasP4uPPhoTEf8OP2APkWMnG3TWwfs9aN7SJWwyiWjNEyRz+hFqB?=
 =?us-ascii?Q?QumYgIp6i9q4Gh8KhRe7q9pRDzKzf0Jc62tB9COTVUGLNwRuffJrs266s2PC?=
 =?us-ascii?Q?9DwV5R5dtMeS/CThzjOJYYOOP+9X0sC5u2PUWadh8d+y1x9XtI7GW8ldgaFf?=
 =?us-ascii?Q?yfIeMaq5/Kz84azOHWl/KnO67ojGikhQevbIOvxGrcmh8uXF8Wg8qknR2nOf?=
 =?us-ascii?Q?Oi930Rudw1/bOPAmjJrJhZ33i9DoNF3ogZ1zk5f6J/fvooQTzEeyldm4PiBS?=
 =?us-ascii?Q?dKxuulp5JBNdJ7Eg1RmLc9W5WoCSrTR/k1NTrOBTxWaXXlL/fF/5SsRCn+5V?=
 =?us-ascii?Q?BLilIAt7sC5jDbY61cL+3uuL8rBM0vw=3D?=
X-Exchange-RoutingPolicyChecked:
	Nd34Ie8LSzL8WKlihbv9P7Z3//V6EGmxycLutQ6Epkg8ULDr9Zg54026qTJ8yOzSq01kTylpPXO0esfJna4Ko4ZVq7HdXvGXpdbiedHE89I+FI2QXz0+cOKdNZTYQGheINqCaEpdp95+kMNcfscmcxD8zt13oEqo1bXtDDt4qp2W+dgYRlmrGKbPCNLyt6YGunyppWo2tXgIUa97euhGSljNAIv3V+Ruuek4VnDYTn+js06g/e79/9MkvvxPmsi7K1tgmGtrWDjeY7QC58vi0X0SBH6xx4bPvpXCEfXa4PHc/DfpDbwOS7W8sWzP1qtmH3ItwN9hX0nm2oTkh68UBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NE8hWs17+C/uOZqJ6ows8JOwDXRn8/ocKY9b9IyYBYNtTFsO72RgT1SFSpeVt6lZd346yg2oA7C6kJP4oCTkiZVxyQtianHL5pdLs+AieyuqRr455LMvWo/jX3BBlaRzhohK7rI8fyyV9dhiMLldwYU0To3lEz8M3oWmeUeOe1dCHdJLsp/9yrrSLJaoHBb4JOmNxY7rFnVilKz7Lh+k0RljM2yeq4kOJk+gDlyA0tP22OEEn2Re2QLx50Qp85tIWuLdsrxsVKpd5zlp7bvYnQdjkQnfq96E2vp2lCmGHY7yhRJ+G+8kGWMz38YXG2WZEEv8zBA9OzfQ1FUzUWK874GOdyATyaoubUMcXMPA6xXbsOY5ueBepqr3JGWXYBCO0Kl7H5wZjNdr4qWXW7mzLJO0+AYMPUsIbN5panXUqKj5R3Z0hMmyyNhODBgSrGiSou706bPac+YaDdr6GjSQH0JDEA9x7WPJqUiCR/5UmQKYTsmYKC2+LeOUFc3okC+eLSoKDkT0dm44HKCPmFGUxEuN6USGXHZQ6GnHYXSOsRY1niZLjN/sjRcWGTB2xe/l7Tdp5GnLAnFOY2ZUn2I+Ragrvjixftc7rUm+mL3PsG/HRBoR4ARi1rdQA/yutjrd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ccc2dd-271e-4d20-4028-08deb19d9b08
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:46:00.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4pDQPe25KPtGPcSKjdtyQwBkrr3PrzYoSrkEU+q7ImjwUariAlHPPVAEJ/360WJh16J43SQLd/8rjtqL9TQJs3aKOkyUbX74qK+L+XaV6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9082

On May 13, 2026 / 10:17, Bart Van Assche wrote:
> On 5/13/26 4:23 AM, Shin'ichiro Kawasaki wrote:
> > +# Echo a value to a file. This wrapper is used to trace sysfs attribute writes
> 
> Echo -> Write
> file -> sysfs/debugfs/configfs attribute
> sysfs -> sysfs/debugfs/configfs

Thanks, these descriptions are more accurate.

> > +# when the --cmd-trace option is enabled.
> > +_echo() {
> > +	echo "$1" > "$2"
> > +}
> 
> If this is only used to write into sysfs/debugfs/configfs, there are
> probably better names for this function than _echo, e.g. _set_attr(),
> _write_attr() or _write_sys_attr().

Agreed, _set_attr() sounds good to me.

> 
> Should "echo" or "echo -n" be used in the above shell function?

I couldn't catch the comment above. The current patch uses "echo", and it's
working.


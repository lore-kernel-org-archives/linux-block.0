Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30A4A8FEF
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440177; cv=fail; b=shX6JYAE+S2yRZU3GnUbdvFeNTtMV0SyqopYPghEbC5n3AuryZ0ExRBCRunEvu75lOw1FN10epqN+er98oXpV0vC2P9EQZR5k1sSxucgHF1kI9EsCi9Yg5OI/WRDi4TozWQJ8TnWriLw6iHFxbm6Xxj4CcSZ0AEJWth84VEiBO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440177; c=relaxed/simple;
	bh=W4mslaMWsCnfwM4Hzrvsqd7c7ICwBYR80RUfQEwx2NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4Y++wyzs97msOzM0q3fCi9aKm+w24oFpiqFXoGBbaAP6KJYU4sIElXKfWjCJtr7FlEq7va6oa6/4DMnuFij0YKIYVS8kR4n4k2qUYEcI5sY20E2sEuyaIBddd8fVty2ZZ7djAKRj8Wl+Fz6s9Yn8g7AK3OinFAkDPsRUGLJBPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KENrfqSn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ip5qjEYJ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KENrfqSn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ip5qjEYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788440175; x=1819976175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W4mslaMWsCnfwM4Hzrvsqd7c7ICwBYR80RUfQEwx2NA=;
  b=KENrfqSnsALehzzgjOYsuREeW12U/RblrY3zAS3RLonGe2lohHR35rCr
   JHuTwvGMorfqWOppkXyTWvydHHOp/T40QBxIZFueghlZ7PVSr/x5DJRq9
   9JASqcAMqn6qL3itEY1p55n4VHvz4CIoHyI+9yu+V/BHRdO5Hux77MecK
   r7xAR5ePxntbtGkI4gU75CPGcWsYa6F1sPnSVEyBpknwKXUNggOXOh6DT
   AXEZkapcIUrdohJkUR0EcbH0zlTN5/21mqf30EZcDIyhioAHKhleEDqmY
   NZm+onUeiOZfbpmHdOZqlJW7DEx3UMdmCG0dKQZbQH3St/i20wuxT8J3Z
   A==;
X-CSE-ConnectionGUID: iX9O8hIdRqeVXha6NDdgag==
X-CSE-MsgGUID: yx73naiZSGKzICYYXu57MQ==
X-IronPort-AV: E=Sophos;i="6.25,260,1779120000"; 
   d="scan'208";a="154662480"
Received: from mail-westus2azon11010027.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2026 20:56:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbS9gqnw1gCPkukvISEgw5U+XhdAjWp3yjQnB9xkVVWoSn2bMkYfAvufmoeLDH0IKtYmQb3V5QMUK0pRwQRFbcNjw/ImfbjYXxFZ0GAntHCNdfQvIWEB89HXfbygd4IsXW1Gehyh06kQfDV7gGhY5pSmcx69quiZSLP0u+J2gGzLHXATv87+X6GJ11kiH4b9pjofYhi4YkToOTml5aIK9qcTiCOuq0cyd+LFJZYKu9GiacR7aZOUJvtbVxzOjZS0q2lLYMviCUYE06Iu3m2/FpihrNh16kxBdtDIIKVFBMLdSgejy4H/9dlELUA0swvfrCtswu9CoA9ZNwL33/vJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdP0Mdb9M52QaNByA/K5wg64BJeQneHbKD6sE1Q3U7Y=;
 b=H0ygTxNgG6RTMCfRlPkFZiuNGE7zpKX6nUXnUcRREVE86t2g01Ws73PJygUcoVAtSf7oNsfXhI71moUVkELw4ereMeJ9SRK16dZXSG6KeKGmI2fdruh9jO06KbNWjP2J4rcB371dObsCSwhS25GVB37FdoIriem4t0qtOzbeKcgfF4ZECACiuCg5eqkOw9VG0No2EDLez5MFzp4FqJsoF6olZ42Sx3iuSWgOiLoQ9ST+QkrQmwqdKe6pIX4Ejgm7/anzoRFs4aiNe+exYCsonFnsfKY9U7eLgLJ2p8kQ5kbh5bNZX/H5DiZKKquypARWHKXZ16eGSEmoFAxfYCyY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdP0Mdb9M52QaNByA/K5wg64BJeQneHbKD6sE1Q3U7Y=;
 b=ip5qjEYJW/9215pBpn7x2yMa5Z5Aak7q8rSgn71GM7so7OneTmedYjfKKWmublHER+LBPwg1GZDr8qkQQEj/NAddhv2xvoAoebcqIPe/h6MYAl7JNMKlMAGSdGpndwjqj6dC6yewe9GzFRL9moAtsRTvPpBhTQkz57dhqKmqH+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6981.namprd04.prod.outlook.com
 (2603:10b6:610:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:56:02 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:56:02 +0000
Date: Thu, 3 Sep 2026 21:55:56 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai@kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH blktests v2] tests/throtl: add a new test 009
Message-ID: <apluNcRpYeO3Oa6w@shinhome>
References: <20260825104053.70390-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825104053.70390-1-cui.tao@linux.dev>
X-ClientProxiedBy: TYCP286CA0054.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 138d6f8f-1084-49e6-61ab-08df09bab57c
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|11063799006|10067099003|5023799004|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jqzd+9Gkgxdm22NPmsZuggi/l8jJuSOuD7/9+fcgdH9yBSoOfp90KxlRuzUkPrNMy4jQAP/D5AGYGLPWnRZxPo+sUR5JYUdeT3eh5q//PY8RLG4HTKdokNr8jujBC1lsCqKpWDk8m2MfPciOyIpudGHTTqr31JmeLywAW+dFebfuHU+HBnPbGdasQzSgKVGJURAR2NJEuv03B2s0PPg4qiH7WuFmUY75OzYfMySyKu5PjLpKAPjE0UiRmY6hKtR8UTwk8x29X8lUibTOtC/5vqmvW2i3yvgtrw7rDTOfzSJz/dp5g/jNhd4HddxRi54xqPLYGtYGllz48do/UJj0K+msTW7oRks43qMvP8RBsGnlBqK0g2KIiIi3qOX7ZKRfmqp8+xe9UsC599vQSizuvFA9yAJAa8geueshDMVZvoCsV0BDXixYd3GE0LuIL8P4ZE9IpxY/wru6kkNkho+VH6W5esHzsCwEwA1sdlORrh56h7jcbr3zxO/dfOPnQ+0Cn58h4BaXjSZq0OhLedp4amszrhdbbMR5wfZjkw+pvldqYv493S0m9UzYU94h1ha3LIvcohXSkXmUG2D0bUmNEvZL6JkRH/JfJH1exfS+msMAOUDSD9o4Myxqy/u1XbYyXHspMQ3JJomwtX7zvQkE65GYVlFC/uP2yrwtnmEc0F0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(11063799006)(10067099003)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IvlRM6RPx6xD+H+hUI843sU8m/newJuqMvQJY9C3FNnWvsNHQ1eyBzOcRDNK?=
 =?us-ascii?Q?qFnlLiVs9tc3eOjOA2QHLWsscbznSbRaW+ejHB9wuCJzfOLytnq9UVZAVbcs?=
 =?us-ascii?Q?dtnUblchaIN5vsDV5wVVoJbqfUMtnl9fJMDjeox1VvKEGztgh5zc097zktJu?=
 =?us-ascii?Q?8+UUA2ZtS6RIWeKNxC0s4XIju7+PtKuLSKAoc9WDzHexZff3HaUgr2HA+ky+?=
 =?us-ascii?Q?lVkM+eRc0gWi0wFp8OEsGEC+RGaftkVqmlV1ynpbeuToCVxEu8AvwnarypTk?=
 =?us-ascii?Q?TmcG1LkWAQXrItim3T0e9NRI1pGkua+3tDI0elJpThRD3HIflHvSail8ncDK?=
 =?us-ascii?Q?KxMHqN9kMZOabhkCh1lZx8kgqN8t7z5rWAWXT1csbirDMfqhIXAsHE/ro7/q?=
 =?us-ascii?Q?9hxkTc2IQTa6BsQUPVUhwfro7KQij6xoC1i/K5cJiWXzO+U7VgliB6k1onLX?=
 =?us-ascii?Q?z9Qt45ktKu0lIQEXzhZHyh3vV7QP+kfSvkGkbi9nqBCQaIdA8fh2HVDeQXfr?=
 =?us-ascii?Q?RucjHKciiOwzrylaCo9TbbexeKNWlCL99GZCMSz2z9DiazPBlXf0pKd917QP?=
 =?us-ascii?Q?YwOnLJSw3T//sfq5mhYAQs4RIHbl2zoLpW8tvCV/RIpDyS5+5hTgsiZ8KH/K?=
 =?us-ascii?Q?S8N7KhCpSlBdqvDAnOuaMbtVwH8A1SVfxhZZG15P8GFDmhOkhWruFWHIxLAe?=
 =?us-ascii?Q?DSruXGwcsi6YlI5AkbFScPIv7e1819cmnBY6eRju5BYHlWK+2h9FzZlY3dhB?=
 =?us-ascii?Q?scwxqEhwsngF2s4hJBXsmWEesitBP4/uo3jUrU2qF0a5/9/p5ET+vUDkfBrc?=
 =?us-ascii?Q?88B6+BnDnY+ZScI0fybY9vGq0OVOAMaxg487LKSJUJxY+mGZMJB/+COLcAmM?=
 =?us-ascii?Q?t4mnKUvaG0Hoyl4n8FGOh4iJrP1T3IqkDc5dpD2wXOMrMQwEJ3HOzbGszlHG?=
 =?us-ascii?Q?ukLMSIPQQzmz9VVaUgM6bltvX2tGSfTu291N3EajEV1oWAqFADSR/Pv0KsWx?=
 =?us-ascii?Q?yXKt7k8jcgkxyb7f3JfESmXshI9O0nkC/+1WdlAYng9+lu4m0tFyq9tYL98q?=
 =?us-ascii?Q?UGcj71If3P47ozyB/TbXJw1raVOWTt71dtEVlW4g1liHjY5gu311j3mjbZq4?=
 =?us-ascii?Q?lj21hC/aT/Jo2v3fPjd5Wy5L1/EGUxzcgC+DTfo4TLZ/1A3k1x291kLM7A4a?=
 =?us-ascii?Q?HVUoGKPN4ekLCjLy5WZCir6F7SUrRIxt2SYWICxblpQkJsNHjDrfDZ/M+haI?=
 =?us-ascii?Q?tx92S0sPt7Wt02MsOpL/a0BheW+naYfPjrcbMAr5zNGQ880liD5Y4g5L+BgO?=
 =?us-ascii?Q?ajv58WOqFu6RriaaueCJb/HNNzXwP0jaSsYJBe0eJOI77rNdy6y5tX7FWv5V?=
 =?us-ascii?Q?oHqqMa++rqLjKhgw60x7dOikGdeE/kUeRpXhYIJl9d/J4hyFePvtb/CitQG4?=
 =?us-ascii?Q?9q79mpE8ox39Ppa9McFUZ83YjzqlkEGi8oUz7iLlGTa2w8N3Rw67oHfwVTcw?=
 =?us-ascii?Q?ET5TTUenLWHXy9lxUpPKhX8Jj30hv/aSp0ip4/itfxmSfCvG95a3aCCh9IW6?=
 =?us-ascii?Q?G+y2Hxj++HDiV/KcbtL3peAHIHf01PW8zjlIuZUs/RQwLlN/W7Pnm4Tmvnym?=
 =?us-ascii?Q?FShD0hlNODRSxn31ZqBzsljcphxMw8gW8ERFLo2ndkb/OaUPOvueIfvcHLoM?=
 =?us-ascii?Q?2Ie5hTMdzdez4SNGEf8tAq6aGdH4YM1plsknXtTA8nbg3a05MNW05HlZQ3MT?=
 =?us-ascii?Q?/DqW6H0VLLIFiE46R9VQ1c9msA5ZwjA=3D?=
X-Exchange-RoutingPolicyChecked:
	BIZ0Q9xgijWj7UxejyMQGjWyTM/qzGyUM4EOrdG88N5aPeoAi6c94VmWjgRPHfY7mmcVUoHbHXvoa8BV86gfwzFjOvwgNlCzIcFNEADEkA9oEDhrABpBTAHkbCluA6uZNtZ/XCnDYpX2ppEIb2y+YI//80pDMITLunpumpBmBBDGwcGH0gfJ7d7PXw6QDwwM7jabEZkqK7a8U/lQ3mlEkC26ZjDfbhRP5DiOIVTQG/Cbhn9jVCht4E8TfFDL4EFCyD11t3qVNs9KtJGcBg1su4r4Ofk5OeRFl50APyrPTS2O2Nf6hsPbpHgySAUOUiIt/SKq6lo3gyPd4VU2XPqxfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CwJnFTtQijOn4tnqUSmXFPNm56ibtjFVU8MrwN8HREr2FQcBIaxRfiAjuw9vtOlvS1jSkrHPvFtlxbqSQYvofr1dirgF/AivDB2PqgJK1M729umkZjx61KgfX4viT5sf0cBbUcxSSpdhoKIUlh+qcnMFMdovoHUSeMigd1Y825tUgYdPdEu8HjDDIHzX66eXpqReewPiAp9bWsBLUlFALozWilYNPoKjbL+bH7a2c7tqOKqfGCMpZIeUXJ8iQGC6fnuqNhEx8GeU8Fl6vtyKIo52vjM6yMkPEHYDzKfkgPceW8PAeOINHz6UyuLKnEEq9fBjqeyYQT1bXU5mgN/vfKktvuLDQ3VQcFWNvNwGmdwQUwfsx1xlwHQy4y/RRQjqg3wEaVEnOGLtTtTtv6a00hvr8aKqpZPB07e6DVmI9fiRm2Gg3qiC9kwRK6NuG41rsD2fHSgjjL21tY5/Sz9UzrE4iJ/UK9do+83vXlj1qhAVAOsTokLvWOLmxApZUF+VriRt68X+IhdSz6DpIxyvcuzjlyG4BkvfazxYaCfp2LCQtMvN/Xed/CuyLH8TdPvaQe+yoFbJOPWjCIhcQAyJAJFrhif7YnmE8KAtXEXE1LCfL5IKZi/xfdbYouLIAZI6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138d6f8f-1084-49e6-61ab-08df09bab57c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:56:02.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrR1bl4ujYajR+Z+U7YSEWjgMNbKK0mRkTr9T3M0gtWwO1ag2boK+aIBsxrqiVZL+dAWY9LUwsXDLgpNMGzDOjZMncZvwSTjortBt91hU8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981

On Aug 25, 2026 / 18:40, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Test the boundary condition of removing a cgroup while it still has IO
> queued in the blk-throttle queue.  The queued bios must be flushed through
> without any blk-cgroup or blk-throttle warning.
> 
> The dmesg check matches any blk-cgroup / blk-throttle warning rather than a
> single call site, so it is not tied to one symbol.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

I applied the patch. Thanks!
